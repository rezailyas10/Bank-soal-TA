<?php

namespace App\Services;

use App\Models\Major;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class AIEvaluationService1
{
    private $groqApiKey;
    private $groqUrl;

    public function __construct()
    {
        // Set API key dan URL yang benar
        $this->groqApiKey = env('GROQ_API_KEY');
        $this->groqUrl = 'https://api.groq.com/openai/v1/chat/completions';
    }

    /**
     * Evaluasi mendalam per soal dengan lesson yang spesifik.
     *
     * @param  \Illuminate\Support\Collection  $wrongQuestions   Koleksi soal yang salah
     * @param  \Illuminate\Support\Collection  $correctQuestions Koleksi soal yang benar
     * @param  int                             $score            Nilai total (misal 750 dari 1000)
     * @return string                                              Teks respons dari Groq/OpenAI
     */
     public function evaluatePerformance($wrongQuestions, $correctQuestions, int $score, array $subCategoryStats = [])
    {
        // Jika diberikan Collection, convert ke array of objects sesuai buildWrongQuestionsAnalysis
        // Namun kita langsung panggil buildWrongQuestionsAnalysis yang menerima Collection.
        $wrongArr   = $this->buildWrongQuestionsAnalysis($wrongQuestions);
        $correctArr = $this->buildWrongQuestionsAnalysis($correctQuestions);

        // Build prompt dengan array hasil analisis
        $prompt = $this->buildDetailedEvaluationPrompt($wrongArr, $correctArr, $score, $subCategoryStats);

        // Panggil API Groq/OpenAI (sesuaikan implementasi callGroqAPI Anda)
        return $this->callGroqAPI($prompt);
    }


    /**
     * Rekomendasi jurusan murni berdasarkan nilai dan passing score
     */
    public function recommendMajors($score, $majorRankings, $hasSubjectCategories = false)
    {
        // Buat prompt rekomendasi berbasis nilai
        $prompt = $this->buildScoreBasedRecommendationPrompt($score, $majorRankings, $hasSubjectCategories);
        
        // Panggil API Groq
        return $this->callGroqAPI($prompt);
    }

    /**
     
     * Konversi Collection<Question> (atau objek serupa) 
     * menjadi array[] dengan keys yang dibutuhkan.
     *
     * @param  \Illuminate\Support\Collection  $questions
     * @return array[]
     */
     private function buildWrongQuestionsAnalysis($questions)
    {
        $out = [];
        // Jika array diberikan, ubah ke koleksi agar konsisten
        if (is_array($questions)) {
            $questions = collect($questions);
        }
        foreach ($questions as $q) {
            // $q diasumsikan objek dengan properti:
            // - lesson
            // - question_text
            // - explanation
            // - dan relasi subCategory (object) dengan properti name, jika eager-loaded
            $subcatName = null;
            if (isset($q->subCategory) && isset($q->subCategory->name)) {
                $subcatName = $q->subCategory->name;
            }
            // Jika $q->subCategory adalah array atau koleksi, sesuaikan:
            if (!$subcatName && isset($q->sub_category) && is_string($q->sub_category)) {
                $subcatName = $q->sub_category;
            }
            $out[] = [
                'sub_category' => $subcatName ?: 'Umum',
                'lesson'       => $q->lesson       ?? 'Umum',
                'description'  => $this->truncateText(strip_tags($q->question_text ?? ''), 80),
                'explanation'  => $q->explanation  ?? '-',
            ];
        }
        return $out;
    }


    /**
     * Prompt sederhana: fokus ke sub-bab pembahasan, 
     * ambil data dari array $wrong dan $correct.
     *
     * @param  array[]  $wrong   Array hasil buildWrongQuestionsAnalysis untuk soal salah
     * @param  array[]  $correct Array hasil buildWrongQuestionsAnalysis untuk soal benar
     * @param  int      $score
     * @return string  Prompt untuk AI
     */
private function buildDetailedEvaluationPrompt(array $wrongArr, array $correctArr, int $score, array $subCategoryStats = [])
{
    // 1. Kumpulkan statistik per lesson dalam setiap sub_category, dan deskripsi singkat
    $lessonStats = []; // ['subcat'=> ['lesson'=> ['correct'=>int,'wrong'=>int,'descriptions'=>[]]]]
    foreach ($correctArr as $q) {
        $sub = $q['sub_category'] ?? 'Umum';
        $lesson = $q['lesson'] ?? 'Umum';
        if (!isset($lessonStats[$sub][$lesson])) {
            $lessonStats[$sub][$lesson] = ['correct'=>0,'wrong'=>0,'descriptions'=>[]];
        }
        $lessonStats[$sub][$lesson]['correct']++;
        $desc = trim($q['description'] ?? '');
        if ($desc) {
            $lessonStats[$sub][$lesson]['descriptions'][] = $desc;
        }
    }
    foreach ($wrongArr as $q) {
        $sub = $q['sub_category'] ?? 'Umum';
        $lesson = $q['lesson'] ?? 'Umum';
        if (!isset($lessonStats[$sub][$lesson])) {
            $lessonStats[$sub][$lesson] = ['correct'=>0,'wrong'=>0,'descriptions'=>[]];
        }
        $lessonStats[$sub][$lesson]['wrong']++;
        $desc = trim($q['description'] ?? '');
        if ($desc) {
            $lessonStats[$sub][$lesson]['descriptions'][] = $desc;
        }
    }
    // Buat summary deskripsi untuk tiap lesson (ambil maksimal 2 unik)
    foreach ($lessonStats as $sub => $lessons) {
        foreach ($lessons as $lesson => $stat) {
            $unique = array_unique($stat['descriptions']);
            $sample = [];
            foreach ($unique as $d) {
                $sample[] = $d;
                if (count($sample) >= 2) break;
            }
            $lessonStats[$sub][$lesson]['summary'] = $sample ? implode(' ... ', $sample) : '-';
        }
    }

    // 2. Hitung overall average score dari subCategoryStats
    $overallAvgScore = 0.0;
    if (!empty($subCategoryStats)) {
        $sumScore = 0.0;
        foreach ($subCategoryStats as $st) {
            // pastikan key 'average_score' ada
            $sumScore += $st['average_score'];
        }
        $overallAvgScore = $sumScore / count($subCategoryStats);
    }
    // Klasifikasi subkategori berdasarkan average_score
    $subStrengths = [];
    $subWeaknesses = [];
    foreach ($subCategoryStats as $st) {
        $name = $st['name'];
        $avg = $st['average_score'];
        if ($avg >= $overallAvgScore) {
            $subStrengths[] = ['name'=>$name, 'average_score'=>$avg];
        } else {
            $subWeaknesses[] = ['name'=>$name, 'average_score'=>$avg];
        }
    }

    // 3. Format Analisa Per Materi (Lesson)
    $materiSection = "🔍 **Analisa Per Materi (Lesson)**\n\n";
    // Kekuatan per materi
    $materiSection .= "Kekuatan\n";
    $foundStrength = false;
    foreach ($lessonStats as $subcat => $lessons) {
        $lines = [];
        foreach ($lessons as $lesson => $stat) {
            $c = $stat['correct']; $w = $stat['wrong'];
            if (($c + $w) > 0 && $c >= $w) {
                $foundStrength = true;
                $lines[] = "- {$lesson}: {$stat['summary']} ({$c} benar, {$w} salah)";
            }
        }
        if ($lines) {
            $materiSection .= "Mata Pelajaran: {$subcat}\n";
            foreach ($lines as $l) {
                $materiSection .= "{$l}\n";
            }
        }
    }
    if (!$foundStrength) {
        $materiSection .= "- Tidak ada materi dengan jumlah benar ≥ salah.\n";
    }

    // Kelemahan per materi
    $materiSection .= "\nKelemahan\n";
    $foundWeak = false;
    foreach ($lessonStats as $subcat => $lessons) {
        $lines = [];
        foreach ($lessons as $lesson => $stat) {
            $c = $stat['correct']; $w = $stat['wrong'];
            if ($w > $c) {
                $foundWeak = true;
                $lines[] = "- {$lesson}: {$stat['summary']} ({$c} benar, {$w} salah)";
            }
        }
        if ($lines) {
            $materiSection .= "Mata Pelajaran: {$subcat}\n";
            foreach ($lines as $l) {
                $materiSection .= "{$l}\n";
            }
        }
    }
    if (!$foundWeak) {
        $materiSection .= "- Tidak ada materi dengan jumlah salah > benar.\n";
    }

    // 4. Format Analisa Per Mata Pelajaran berdasarkan average_score
    $subcatSection = "\n📊 **Analisa Per Mata Pelajaran**\n\n";
    $subcatSection .= "Kekuatan\n";
    if (!empty($subStrengths)) {
        foreach ($subStrengths as $st) {
            $subcatSection .= sprintf(
                "- %s: Rata-rata nilai %.2f\n",
                $st['name'],
                $st['average_score']
            );
            $subcatSection .= "\n";
        }
    } else {
        $subcatSection .= "- Tidak ada mata pelajaran dengan average_score ≥ rata-rata keseluruhan (%.2f).\n";
        // Sisipkan nilai overall jika diperlukan
        $subcatSection = sprintf($subcatSection, $overallAvgScore);
        $subcatSection .= "\n";
    }
    $subcatSection .= "\nKelemahan\n";
    if (!empty($subWeaknesses)) {
        foreach ($subWeaknesses as $st) {
            $subcatSection .= sprintf(
                "- %s: Rata-rata nilai %.2f\n",
                $st['name'],
                $st['average_score']
            );
            $subcatSection .= "\n";
        }
    } else {
        $subcatSection .= "- Tidak ada mata pelajaran dengan average_score < rata-rata keseluruhan (%.2f).\n";
        $subcatSection = sprintf($subcatSection, $overallAvgScore);
        $subcatSection .= "\n";
    }

    // 5. Gabungkan menjadi prompt
    $prompt = <<<EOD
Kamu adalah tutor yang mengevaluasi kompetensi siswa berdasarkan latihan soal.

📊 Nilai Total: {$score}/1000

{$materiSection}

{$subcatSection}

Tulis ringkas, jelas, dan langsung ke poin minimal 600 kata (≤9500 kata).
EOD;

    return $prompt;
}





    /**
     * Potong teks panjang, tambahkan "..." jika lebih dari $length karakter.
     *
     * @param  string  $text
     * @param  int     $length
     * @return string
     */
    private function truncateText(string $text, int $length = 100): string
    {
        if (strlen($text) <= $length) {
            return $text;
        }
        return substr($text, 0, $length) . '...';
    }


/**
 * Prompt rekomendasi berbasis nilai dengan alternatif meski sudah memenuhi passing score
 */
private function buildScoreBasedRecommendationPrompt($score, $majorRankings, $hasSubjects)
{
    // 1. Buat teks status untuk setiap jurusan pilihan user
    $majorText = '';
    foreach ($majorRankings as $major) {
        $gap = round($major['passing_score'] - $score, 2);
        $line = "• {$major['major_name']} ({$major['university']})\n";
        $line .= "  Passing Score: {$major['passing_score']} | ";

        if ($score >= $major['passing_score']) {
            $safeMargin = round($score - $major['passing_score'], 2);
            if ($safeMargin >= 50) {
                $line .= "✅ Sangat Aman (selisih +{$safeMargin} poin)\n";
            } else {
                $line .= "⚠️ Aman tapi tipis (selisih +{$safeMargin} poin) – peluang ada, tapi perlu hati-hati\n";
            }
        } else {
            $line .= "❌ Kurang {$gap} poin – masih perlu peningkatan\n";
        }

        $majorText .= $line;
    }

    // 2. Cari jurusan dengan passing_score ≤ $score (Pilihan Aman)
    $safeMajors = Major::with('university')
        ->where('passing_score', '<=', $score)
        ->orderByDesc('passing_score')
        ->limit(8)
        ->get();

    // 3. Cari jurusan dengan passing_score > $score (Target Stretch)
    $stretchMajors = Major::with('university')
        ->where('passing_score', '>', $score)
        ->orderBy('passing_score')
        ->limit(8)
        ->get();

    // 4. Format data alternatif – Pilihan Aman
    $safeAlternativeText = '';
    if ($safeMajors->count() > 0) {
        foreach ($safeMajors as $major) {
            $safeAlternativeText .= "• {$major->name} ({$major->university->name}) - PS: {$major->passing_score}\n";
        }
    } else {
        $safeAlternativeText = "Tidak ada jurusan dengan passing score ≤ nilai Anda.\n";
    }

    // 5. Format data alternatif – Target Stretch
    $stretchAlternativeText = '';
    if ($stretchMajors->count() > 0) {
        foreach ($stretchMajors as $major) {
            $stretchAlternativeText .= "• {$major->name} ({$major->university->name}) - PS: {$major->passing_score}\n";
        }
    } else {
        $stretchAlternativeText = "Tidak ada jurusan dengan passing score > nilai Anda.\n";
    }

    // 6. Catatan mata pelajaran
    $subjectNote = $hasSubjects
        ? "💡 Catatan: Karena ini tryout dengan mata pelajaran spesifik, pertimbangkan juga kesesuaian minat jurusan dengan kemampuan pada mapel tersebut."
        : "💡 Catatan: Rekomendasi berdasarkan nilai TPS dan kemampuan umum.";

    // 7. Buat bagian analisis jurusan user (semua pilihan)
    $evaluationText = "🎓 ANALISIS PELUANG BERDASARKAN DATA REAL:\n";
    $evaluationText .= "- Evaluasi gap nilai terhadap semua pilihan jurusan:\n\n";

    foreach ($majorRankings as $major) {
        $gap = round($major['passing_score'] - $score, 2);
        $line = "• {$major['major_name']} ({$major['university']})\n";
        $line .= "  Passing Score: {$major['passing_score']} | ";

        if ($score >= $major['passing_score']) {
            $safeMargin = round($score - $major['passing_score'], 2);
            if ($safeMargin >= 50) {
                $line .= "✅ Sangat Aman (selisih +{$safeMargin} poin)\n";
            } else {
                $line .= "⚠️ Aman tapi tipis (selisih +{$safeMargin} poin) – peluang ada, tapi perlu hati-hati\n";
            }
        } else {
            $line .= "❌ Kurang {$gap} poin – masih perlu peningkatan\n";
        }

        $evaluationText .= $line . "\n";
    }

    // 8. Susun prompt akhir
    $prompt = <<<EOD
Kamu adalah konselor akademik yang REALISTIS dan HANYA menggunakan data jurusan yang tersedia di database.

🎯 Nilai Tryout: {$score}/1000

📋 Status Jurusan Pilihan:
{$majorText}

📚 DATA ALTERNATIF:

🟢 PILIHAN AMAN (Passing Score ≤ {$score}):
{$safeAlternativeText}

🟡 TARGET STRETCH (Passing Score > {$score}):
{$stretchAlternativeText}

{$subjectNote}

ATURAN KETAT:
- WAJIB HANYA menggunakan nama jurusan dan universitas yang tertera dalam “Pilihan Aman” atau “Target Stretch”.
- DILARANG membuat nama jurusan atau universitas baru.
- DILARANG menyebut jurusan dengan passing score di luar kategori yang sudah ditampilkan.
- Jika kedua kategori “Pilihan Aman” dan “Target Stretch” kosong, FOKUS pada analisis pilihan utama dan strategi peningkatan nilai.

{$evaluationText}

💡 ALTERNATIF DARI DATABASE (HANYA jika ada):
- Jika ada data di “Pilihan Aman”, pilih 2–3 jurusan teratas yang paling mendekati nilai Anda.
- Jika ada data di “Target Stretch”, pilih 2–3 jurusan teratas yang paling mendekati nilai Anda.
- Jika kedua kategori kosong, tulis: “Tidak ada alternatif yang sesuai untuk nilai ini.”
- Sertakan passing score yang sesuai dan proyeksi prospek kerja (ringkas).

🚀 STRATEGI PENINGKATAN REALISTIS:
- Target berdasarkan gap nilai sebenarnya dari pilihan jurusan.
- Berikan langkah peningkatan yang realistis (timeline misal +1–2 bulan).
- Prioritaskan mata pelajaran atau materi ujian yang paling berdampak.

PENTING:
- Kalau tidak ada alternatif di salah satu kategori, jangan paksa membuat rekomendasi di kategori tersebut.
- Gunakan HANYA data yang benar-benar tersedia di database.
- Maksimal 5000 kata, bahasa praktis dan jujur.
EOD;

    return $prompt;
}



    /**
     * Panggil Groq API dengan error handling yang baik
     */
    private function callGroqAPI($prompt)
    {
        try {
            // Log untuk debugging
            Log::info('Calling Groq API with prompt length: ' . strlen($prompt));
            
            $response = Http::timeout(30)
                ->withHeaders([
                    'Authorization' => 'Bearer ' . $this->groqApiKey,
                    'Content-Type' => 'application/json',
                ])
                ->post($this->groqUrl, [
                    'model' => 'llama-3.1-8b-instant',
                    'messages' => [
                        [
                            'role' => 'user',
                            'content' => $prompt
                        ]
                    ],
                    'temperature' => 0.7,
                    'max_tokens' => 9999,
                    'top_p' => 0.9
                ]);

            // Log response untuk debugging
            Log::info('Groq API Response Status: ' . $response->status());
            
            if ($response->successful()) {
                $data = $response->json();
                $aiResponse = $data['choices'][0]['message']['content'] ?? 'AI tidak memberikan respons';
                
                // Log sukses
                Log::info('AI Response received successfully');
                
                return $aiResponse;
            } else {
                // Log error response
                Log::error('Groq API Error: ' . $response->body());
                return 'Maaf, AI sedang sibuk. Coba lagi dalam beberapa menit ya! 😊';
            }
            
        } catch (\Exception $e) {
            // Log exception
            Log::error('Groq API Exception: ' . $e->getMessage());
            return 'Ups, ada kendala teknis. Tim kami sedang memperbaikinya! 🔧';
        }
    }
}