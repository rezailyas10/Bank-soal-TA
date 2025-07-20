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
    // 1. Kumpulkan statistik per lesson dalam setiap sub_category
    $lessonStats = [];
    foreach ($correctArr as $q) {
        $sub = $q['sub_category'] ?? 'Umum';
        $lesson = $q['lesson'] ?? 'Umum';
        $lessonStats[$sub][$lesson]['correct'] = ($lessonStats[$sub][$lesson]['correct'] ?? 0) + 1;
        $desc = trim($q['description'] ?? '');
        if ($desc) {
            $lessonStats[$sub][$lesson]['descriptions'][] = $desc;
        }
    }
    foreach ($wrongArr as $q) {
        $sub = $q['sub_category'] ?? 'Umum';
        $lesson = $q['lesson'] ?? 'Umum';
        $lessonStats[$sub][$lesson]['wrong'] = ($lessonStats[$sub][$lesson]['wrong'] ?? 0) + 1;
        $desc = trim($q['description'] ?? '');
        if ($desc) {
            $lessonStats[$sub][$lesson]['descriptions'][] = $desc;
        }
    }
    // Buat summary deskripsi tiap lesson (maks 2)
    foreach ($lessonStats as $sub => $lessons) {
        foreach ($lessons as $lesson => $stat) {
            $unique = array_unique($stat['descriptions'] ?? []);
            $sample = array_slice($unique, 0, 2);
            $lessonStats[$sub][$lesson]['summary'] = $sample ? implode(' ... ', $sample) : '-';
        }
    }

    // 2. Format Analisa Per Materi (Lesson)
    $materiSection = "🔍 **Analisa Per Materi (Lesson)**\n\n";
    $materiSection .= "Kekuatan\n";
    $foundStrength = false;
    foreach ($lessonStats as $subcat => $lessons) {
        $lines = [];
        foreach ($lessons as $lesson => $stat) {
            $c = $stat['correct'] ?? 0;
            $w = $stat['wrong'] ?? 0;
            if ($c + $w > 0 && $c >= $w) {
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

    $materiSection .= "\nKelemahan\n";
    $foundWeak = false;
    foreach ($lessonStats as $subcat => $lessons) {
        $lines = [];
        foreach ($lessons as $lesson => $stat) {
            $c = $stat['correct'] ?? 0;
            $w = $stat['wrong'] ?? 0;
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

    // 3. Format Analisa Per Mata Pelajaran berdasarkan benar vs salah
   // 3. Hitung ulang statistik per subCategory langsung dari lessonStats
$subStats = [];  // ['subcat' => ['correct'=>int,'wrong'=>int]]
foreach ($lessonStats as $subcat => $lessons) {
    $sc = 0; $sw = 0;
    foreach ($lessons as $stat) {
        $sc += $stat['correct'] ?? 0;
        $sw += $stat['wrong']   ?? 0;
    }
    $subStats[$subcat] = ['correct'=>$sc, 'wrong'=>$sw];
}

// 4. Format Analisa Per Mata Pelajaran berdasarkan $subStats
$subcatSection = "\n📊 **Analisa Per Mata Pelajaran (SubCategory)**\n\n";

// Kekuatan: benar ≥ salah
$strengths = [];
// Kelemahan: salah > benar
$weaknesses = [];

foreach ($subStats as $subcat => $stat) {
    if ($stat['correct'] >= $stat['wrong']) {
        $strengths[] = sprintf(
            "%s (%d benar, %d salah%s)",
            $subcat,
            $stat['correct'],
            $stat['wrong'],
            !empty($subCategoryStats[$subcat]['average_score'])
                ? sprintf(", Skor: %.2f", $subCategoryStats[$subcat]['average_score'])
                : ''
        );
    } else {
        $weaknesses[] = sprintf(
            "%s (%d benar, %d salah%s)",
            $subcat,
            $stat['correct'],
            $stat['wrong'],
            !empty($subCategoryStats[$subcat]['average_score'])
                ? sprintf(", Skor: %.2f", $subCategoryStats[$subcat]['average_score'])
                : ''
        );
    }
}

$subcatSection .= "Kekuatan: " . (!empty($strengths) ? implode('; ', $strengths) : '–') . "\n";
$subcatSection .= "Kelemahan: " . (!empty($weaknesses) ? implode('; ', $weaknesses) : '–') . "\n";


    // 4. Gabungkan menjadi prompt
    $prompt = <<<EOD
Kamu adalah tutor yang mengevaluasi kompetensi siswa berdasarkan latihan soal.

📊 Nilai Total: {$score}/1000

{$materiSection}

{$subcatSection}

Tulis ringkas, jelas, dan langsung ke poin minimal 600 kata.
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

// 9. Rekomendasi jurusan di Institut Teknologi Indonesia (ITI)
$itiMajors = [
    ['name' => 'Teknik Elektro', 'score_range' => [400, 1000]],
    ['name' => 'Teknik Mesin', 'score_range' => [400, 1000]],
    ['name' => 'Teknik Sipil', 'score_range' => [580, 1000]],
    ['name' => 'Arsitektur', 'score_range' => [580, 1000]],
    ['name' => 'Teknik Kimia', 'score_range' => [580, 1000]],
    ['name' => 'Teknik Industri', 'score_range' => [500, 1000]],
    ['name' => 'Perencanaan Wilayah Dan Kota', 'score_range' => [580, 1000]],
    ['name' => 'Teknologi Industri Pertanian', 'score_range' => [550, 1000]],
    ['name' => 'Teknik Informatika', 'score_range' => [520, 1000]],
    ['name' => 'Manajemen', 'score_range' => [450, 1000]],
];

$itiRecommendations = [];
foreach ($itiMajors as $major) {
    [$minScore, $maxScore] = $major['score_range'];
    if ($score >= $minScore && $score <= $maxScore) {
        $itiRecommendations[] = "• {$major['name']} (S1 - Institut Teknologi Indonesia)";
    }
}

$itiText = count($itiRecommendations) > 0
    ? implode("\n", $itiRecommendations)
    : "Belum ada jurusan di ITI yang cocok dengan nilai Anda saat ini.";


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

🏫 REKOMENDASI KHUSUS ITI (Institut Teknologi Indonesia):
Berikut jurusan-jurusan di ITI yang secara realistis bisa kamu pertimbangkan sesuai dengan nilai tryout kamu:

{$itiText}
EOD;



    return $prompt;
}



    /**
     * Panggil Groq API dengan error handling yang baik
     */
    private function callGroqAPI($prompt)
    {
        try {
        // Pastikan prompt valid UTF-8
        $prompt = mb_convert_encoding($prompt, 'UTF-8', 'UTF-8');

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
                'max_tokens' => 99999,
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