<?php

namespace App\Services;

use App\Models\Major;
use Illuminate\Support\Facades\Http;

class AIEvaluationService
{
    private $groqApiKey;
    private $groqUrl;

    public function __construct()
    {
        // Set API key dari env
        $this->groqApiKey = env('GROQ_API_KEY');
        $this->groqUrl = 'https://api.groq.com/openai/v1/chat/completions';
    }

    /**
     * Evaluasi mendalam per soal dengan lesson yang spesifik
     */
    public function evaluatePerformance($wrongQuestions, $correctQuestions, $score)
{
    // Bentuk analisis array sederhana
    $wrong = $this->buildWrongQuestionsAnalysis($wrongQuestions);
    $correct = $this->buildWrongQuestionsAnalysis($correctQuestions);

    // Buat prompt
    $prompt = $this->buildDetailedEvaluationPrompt($wrong, $correct, $score);

    return $this->callGroqAPI($prompt);
}



    /**
     * Analisis soal yang salah dengan lesson spesifik
     */
    /**
 * Konversi Collection<Question> jadi array[] dengan keys yg dibutuhkan
 */
private function buildWrongQuestionsAnalysis($questions)
{
    $out = [];
    foreach ($questions as $q) {
        $out[] = [
            'lesson'       => $q->lesson ?? 'Umum',
            'description'  => $this->truncateText(strip_tags($q->question_text), 80),
            'explanation'  => $q->explanation ?? '-'
        ];
    }
    return $out;
}

   /**
 * Prompt evaluasi yang fokus pada perbaikan per soal dengan analisis kekuatan dan kelemahan
 */
/**
 * Prompt sederhana: fokus ke sub-bab pembahasan, ambil data dari array $wrong/$correct
 */
    private function buildDetailedEvaluationPrompt(array $wrong, array $correct, int $score)
    {
        // 1) Kumpulkan lesson yang benar → sebagai kekuatan
        $strengthLessons = [];
        foreach ($correct as $q) {
            // Kalau ada lebih dari satu soal benar di lesson sama, kita pakai deskripsi terakhir
            $strengthLessons[$q['lesson']] = $q['description'];
        }

        // 2) Kumpulkan lesson yang salah → sebagai kelemahan
        $weakLessons = [];
        foreach ($wrong as $q) {
            $weakLessons[$q['lesson']] = $q['description'];
        }

        // 3) Format bagian “KEKUATAN SUBBAB PEMBAHASAN”
        if (count($strengthLessons)) {
            $str = "💪 **KEKUATAN SUBBAB PEMBAHASAN**\n";
            foreach ($strengthLessons as $lesson => $desc) {
                $str .= "- {$lesson}: {$desc}\n";
            }
        } else {
            $str = "💪 **KEKUATAN SUBBAB PEMBAHASAN**\n";
            $str .= "- Tidak ada subbab yang berhasil dikuasai; semua perlu diperbaiki.\n";
        }

        // 4) Format bagian “KELEMAHAN SUBBAB PEMBAHASAN”
        $weakSection = "⚠️ **KELEMAHAN SUBBAB PEMBAHASAN**\n";
        foreach ($weakLessons as $lesson => $desc) {
            $weakSection .= "- {$lesson}: {$desc}\n";
        }
        if (count($weakLessons) === 0) {
            $weakSection .= "- Tidak ada kelemahan; semua soal dikerjakan dengan benar.\n";
        }

        // 5) Strategi belajar berdasarkan kelemahan
        $strategy = "🎯 **STRATEGI PEMBELAJARAN**\n";
        if (count($weakLessons)) {
            foreach ($weakLessons as $lesson => $_) {
                $strategy .= "- Latih soal pada subbab **{$lesson}** setiap hari.\n";
                $strategy .= "- Tinjau ulang penjelasan konsep di subbab **{$lesson}** (video atau ringkasan).\n";
            }
        } else {
            $strategy .= "- Pertahankan konsistensi belajar, karena tidak ada kelemahan teridentifikasi.\n";
        }

        // 6) Gabungkan semua komponen ke dalam satu prompt final
        return <<<EOD
Kamu adalah tutor yang mengevaluasi kompetensi siswa berdasarkan latihan soal.

📊 Nilai: {$score}/100

{$str}

{$weakSection}

{$strategy}

Tulis ringkas, jelas, dan langsung ke poin (1500 kata).
DIBAGIAN KEKUATAN DAN KELEMAHAN TAMBHKAN DESKRIPSI SEDIKIT
GUNAKAN KATA ANDA BUKAN MEREKA
EOD;
    }
//  /**
//      * Prompt rekomendasi kampus
//      */
// public function recommendMajors(int $score, array $subjectStats)
//     {
//         $prompt = $this->buildAcademicRecommendationPrompt($score, $subjectStats);
//         return $this->callGroqAPI($prompt);
//     }

//     /**
//      * Prompt rekomendasi khusus untuk tes kemampuan akademik
//      * Berbeda dengan TPS yang lebih umum
//      */
//   private function buildAcademicRecommendationPrompt(int $score, array $subjectStats)
//     {
//         // Bangun teks performance mata pelajaran
//         $subText = '';
//         foreach ($subjectStats as $subject => $stat) {
//             $subText .= "• {$subject}: {$stat['correct']}/{$stat['total']} benar\n";
//         }

//         return <<<PROMPT
// Kamu adalah konselor akademik untuk Tes Kemampuan Akademik (TKA).  
// Berdasarkan data berikut:

// 🎯 Nilai Total: {$score}/100  
// 📊 Performance per Mata Pelajaran:  
// {$subText}

// Tugasmu:
// 1. **Analisis**: Ringkas kekuatan siswa di mata pelajaran yang paling tinggi akurasinya, dan kelemahan di yang terendah.
// 2. **Rekomendasi Jurusan**: Pilih 2–3 jurusan yang paling cocok dengan profil akademik siswa.  
// 3. **Alasan**: Jelaskan secara singkat kenapa jurusan tersebut sesuai (misal: “Kamu unggul di Matematika, jadi jurusan Statistika cocok karena…”.)  
// 4. **Langkah Selanjutnya**: Beri 1–2 tips belajar untuk memperkuat kelemahan.

// Ketentuan:
// - Hanya gunakan nama jurusan umum (Informatika, Statistika, Teknik Elektro, dst).
// - Jangan sebut passing score atau data lain yang tidak ada.
// - Jawaban dalam 300–400 kata, bahasa ringkas dan mudah dipahami.
// PROMPT;
//     }


  /**
     * Helper untuk memotong teks panjang
     */
    private function truncateText($text, $length = 100)
    {
        return strlen($text) > $length ? substr($text, 0, $length) . '...' : $text;
    }


    /**
     * Panggil Groq API
     */
    private function callGroqAPI($prompt)
    {
        try {
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $this->groqApiKey,
                'Content-Type' => 'application/json',
            ])->post($this->groqUrl, [
                'model' => 'llama-3.1-8b-instant', // Model gratis
                'messages' => [
                    [
                        'role' => 'user',
                        'content' => $prompt
                    ]
                ],
                'temperature' => 0.7,
                'max_tokens' => 9999
            ]);

            if ($response->successful()) {
                $data = $response->json();
                return $data['choices'][0]['message']['content'] ?? 'Gagal mendapat respons AI';
            }
            
            return 'AI sedang tidak tersedia, coba lagi nanti.';
            
        } catch (\Exception $e) {
            return 'Terjadi kesalahan saat menghubungi AI.';
        }
    }
}