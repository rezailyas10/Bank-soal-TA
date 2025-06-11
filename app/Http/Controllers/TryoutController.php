<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Exam;
use App\Models\Major;
use App\Models\Result;
use App\Models\Product;
use App\Models\Category;
use App\Models\Question;
use App\Models\UserMajor;
use App\Models\University;
use App\Models\SubCategory;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\ResultDetails;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class TryoutController extends Controller
{
     /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $currentTime = Carbon::now();

        $upcoming = Exam::where('exam_type', 'tryout')
            ->where('tanggal_dibuka', '>', $currentTime)
            ->where('is_published',true)
            ->orderBy('tanggal_dibuka')
            ->get();

        $ongoing = Exam::where('exam_type', 'tryout')
            ->where('tanggal_dibuka', '<=', $currentTime)
            ->where('is_published',true)
            ->where('tanggal_ditutup', '>=', $currentTime)
            ->orderBy('tanggal_dibuka')
            ->get();

        $past = Exam::where('exam_type', 'tryout')
        ->where('is_published',true)
            ->where('tanggal_ditutup', '<', $currentTime)
            ->orderBy('tanggal_dibuka', 'desc')
            ->get();

     $allExams = $upcoming->merge($ongoing)->merge($past);

    $userResults = [];

    foreach ($allExams as $exam) {
        $userResults[$exam->id] = Result::where('user_id', Auth::id())
            ->where('exam_id', $exam->id)
            ->latest()
            ->first();
    }

      // Statistik per subcategory
           // Statistik per subcategory, hanya untuk exam_type = 'latihan'
            // $subCategoryStats = Result::join('exams', 'results.exam_id', '=', 'exams.id')
            //     ->join('sub_categories', 'exams.sub_category_id', '=', 'sub_categories.id')
            //     ->where('results.user_id', Auth::id())
            //     ->where('exams.exam_type', 'latihan soal')             // filter di sini
            //     ->selectRaw('
            //         sub_categories.id,
            //         sub_categories.name,
            //         COUNT(results.id) as total_attempts,
            //         AVG(results.score) as avg_score,
            //         MAX(results.score) as best_score
            //     ')
            //     ->groupBy('sub_categories.id', 'sub_categories.name')
            //     ->orderByDesc('total_attempts')
            //     ->get();

            // // Riwayat pengerjaan, hanya latihan
            // $results = Result::with(['exam.subCategory'])
            //     ->join('exams', 'results.exam_id', '=', 'exams.id')
            //     ->where('results.user_id', Auth::id())
            //     ->where('exams.exam_type', 'latihan soal')             // filter di sini
            //     ->orderByDesc('results.created_at')
            //     ->select('results.*')                              // select kolom results.*
            //     ->limit(10)
            //     ->get();

            // // Hitung detail untuk setiap result
            // foreach ($results as $result) {
            //     $details = ResultDetails::where('result_id', $result->id)->get();
            //     $result->total_questions = $details->count();
            //     $result->correct_answers = $details->where('correct', true)->count();
            //     $result->wrong_answers = $details->where('correct', false)->count();
            // }
        

        return view('pages.tryout.tryout', [
            'upcoming' => $upcoming,
            'ongoing'  => $ongoing,
            'past'     => $past,
            'userResults' => $userResults
        ]);
    }
    public function test()
    {
       $subCategories = SubCategory::all();
        return view('pages.tryout.tryout1', compact('subCategories'));
    }

   public function show($slug)
{
    if (!auth()->check()) {
        return redirect()->route('login');
    }
    $exam = Exam::where('slug', $slug)->firstOrFail();

    $questions = Question::with('subCategory.category')
    ->where('exam_id', $exam->id)
    ->get();

    $userExamResult = auth()->user()->results()
    ->where('exam_id', $exam->id)
    ->latest()
    ->first();

$universities = University::all();
$majors = Major::all();
      $userMajors = UserMajor::with('major')
        ->where('user_id', auth()->id())
        ->get();

    return view('pages.tryout.tryoutDetail', compact('exam','userExamResult','userMajors','universities','majors','questions'));
}

 public function result($examId, $resultId)
        {
            $user = Auth::user();

    if ($user->roles !== 'USER') {
        return redirect()->back();
    }
        $exam = Exam::with('questions','results')->findOrFail($examId);
        $result = Result::with('user','exam')->findOrFail($resultId);
    
        $resultDetails = ResultDetails::with('question.subCategory')
            ->where('result_id', $resultId)
            ->get();
    
        $correctCount = $resultDetails->filter(fn($d) => $d->correct == 1)->count();
        $inCorrectCount = $resultDetails->filter(fn($d) => $d->correct == 0 && !is_null($d->correct))->count();
        $nullCount = $resultDetails->filter(fn($d) => is_null($d->correct))->count();
        $totalQuestions = $resultDetails->count();

        // Total valid = benar + salah (tanpa null)
        $totalValid = $correctCount + $inCorrectCount;

        // Hitung akurasi
        $accuracy = $totalValid > 0 ? ($correctCount / $totalValid) * 100 : 0;

    // Ambil semua hasil ujian exam ini, urut descending score
$allScores = Result::where('exam_id', $examId)
    ->orderByDesc('score')
    ->pluck('score', 'id'); // collection [result_id => score]

$totalParticipants = $allScores->count();

// Cari ranking user ini untuk tryout secara keseluruhan
$ranking = $allScores->keys()->search($result->id);
if ($ranking === false) {
    $ranking = null;
} else {
    $ranking += 1; // dari index 0 ke ranking mulai 1
}

// Hitung persentase Top X%
$topPercentage = $totalParticipants > 0 ? (1 - ($ranking - 1) / $totalParticipants) * 100 : 0;

// Ambil jurusan user
$userId = $result->user_id;
$userMajors = UserMajor::with('major.university')
    ->where('user_id', $userId)
    ->get();

// Query untuk ranking per universitas dan per major
$universityRankings = [];
$majorRankings = [];

foreach ($userMajors as $userMajor) {
    // Ranking berdasarkan universitas
    $universityRank = DB::table('results')
        ->join('user_majors', 'results.user_id', '=', 'user_majors.user_id')
        ->join('majors', 'user_majors.major_id', '=', 'majors.id')
        ->where('results.exam_id', $examId)
        ->where('majors.university_id', $userMajor->major->university_id)
        ->where('results.score', '>', $result->score)
        ->count() + 1;

    $totalUniversityParticipants = DB::table('results')
        ->join('user_majors', 'results.user_id', '=', 'user_majors.user_id')
        ->join('majors', 'user_majors.major_id', '=', 'majors.id')
        ->where('results.exam_id', $examId)
        ->where('majors.university_id', $userMajor->major->university_id)
        ->count();

    // Ranking berdasarkan major/jurusan
    $majorRank = DB::table('results')
        ->join('user_majors', 'results.user_id', '=', 'user_majors.user_id')
        ->where('results.exam_id', $examId)
        ->where('user_majors.major_id', $userMajor->major_id)
        ->where('results.score', '>', $result->score)
        ->count() + 1;

    $totalMajorParticipants = DB::table('results')
        ->join('user_majors', 'results.user_id', '=', 'user_majors.user_id')
        ->where('results.exam_id', $examId)
        ->where('user_majors.major_id', $userMajor->major_id)
        ->count();

    // Simpan ranking universitas (hindari duplikasi)
    $universityKey = $userMajor->major->university_id;
    if (!isset($universityRankings[$universityKey])) {
        $universityRankings[$universityKey] = [
            'university_name' => $userMajor->major->university->name ?? '-',
            'rank' => $universityRank,
            'total' => $totalUniversityParticipants,
        ];
    }

    // Simpan ranking major
    $majorRankings[] = [
        'major_name' => $userMajor->major->name ?? '-',
        'university' => $userMajor->major->university->name ?? '',
        'rank' => $majorRank,
        'total' => $totalMajorParticipants,
        'quota' => $userMajor->major->quota ?? 0,
        'is_accepted' => $majorRank <= ($userMajor->major->quota ?? 0) && ($userMajor->major->quota ?? 0) > 0,
    ];
}

// Convert university rankings to indexed array
$universityRankings = array_values($universityRankings);
    // Rekap berdasarkan subkategori
 $perSubcategory = DB::table('result_details')
    ->join('questions', 'result_details.question_id', '=', 'questions.id')
    ->join('sub_categories', 'questions.sub_category_id', '=', 'sub_categories.id')
    ->select([
        'questions.sub_category_id AS id',
        'sub_categories.name AS name',
        DB::raw('SUM(CASE WHEN result_details.correct = 1 THEN 1 ELSE 0 END) AS correct'),
        DB::raw('COUNT(*) AS total'),
        DB::raw('(SUM(CASE WHEN result_details.correct = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100) AS percentage'),
        DB::raw('AVG(result_details.score) AS average_score'),
        DB::raw('MIN(result_details.question_id) AS firstQId'),
    ])
    ->where('result_details.result_id', $resultId)
    ->groupBy('questions.sub_category_id', 'sub_categories.name')
    ->get();
    
        return view('pages.tryout.results', [
            'exam'   => $exam,
            'result' => $result,
            'resultDetails' => $resultDetails,
            'correctCount' => $correctCount,
            'totalQuestions' => $totalQuestions,
            'inCorrectCount' => $inCorrectCount,
            'nullCount' => $nullCount,
            'totalValid' => $totalValid,
            'accuracy' => $accuracy,
            'ranking' => $ranking,
            'totalParticipants' => $totalParticipants,
            'topPercentage' => round($topPercentage, 2),
            'majorRankings' => $majorRankings,
            'perSubcategory' => $perSubcategory,
        ]);
    }

 public function review($examId, $subCategoryId, $questionId)
    {
        $exam = Exam::with('questions')->findOrFail($examId);
        $question = Question::with(['multipleChoice', 'multipleOption', 'essay'])->where('sub_category_id', $subCategoryId)->findOrFail($questionId);
    
        // ambil jawaban user dari result_detail
        $userResultDetail = ResultDetails::with('result')
            ->whereHas('result', fn($query) => $query->where('exam_id', $examId)->where('user_id', auth()->id()))
            ->where('question_id', $questionId)
            ->latest()
            ->first();
    
        $result = $userResultDetail?->result; // ambil relasi result dari result_detail

        $userAnswersProcessed = [];

        if (
            $question->question_type === 'pilihan_majemuk' &&
            $userResultDetail &&
            $userResultDetail->answer &&
            $question->multipleOption
        ) {
            $userAnswers = json_decode($userResultDetail->answer, true);
            $options = $question->multipleOption;
        
            $statements = [];
            $correctMap = [];
        
            for ($i = 1; $i <= 5; $i++) {
                $statement = $options->{"multiple$i"} ?? null;
                $correct = $options->{"yes/no$i"} ?? 'no';
        
                if (!empty($statement)) {
                    $statements[] = $statement;
                    $correctMap[$statement] = $correct;
                }
            }
        
            foreach ($userAnswers as $statement => $userValue) {
                $correctValue = $correctMap[$statement] ?? 'no';
        
                $userAnswersProcessed[] = [
                    'statement' => $statement,
                    'user_answer' => ucfirst($userValue),
                    'is_correct' => strtolower($userValue) === strtolower($correctValue),
                ];
            }
        }

        // Hitung total peserta yang ikut exam ini
            $totalParticipants = Result::where('exam_id', $examId)->count();

            // Hitung berapa peserta yang sempat menjawab soal ini
            $totalAnswers = ResultDetails::whereHas('result', function($q) use ($examId) {
                    $q->where('exam_id', $examId);
                })
                ->where('question_id', $questionId)
                ->count();

            // Hitung yang menjawab benar
            $correctAnswers = ResultDetails::whereHas('result', function ($q) use ($examId) {
                    $q->where('exam_id', $examId);
                })
                ->where('question_id', $questionId)
                ->where('correct', true)
                ->count();

            // P‐value: proporsi peserta yang benar
            $difficultyLevel = $totalParticipants > 0
                ? round($correctAnswers / $totalParticipants, 2)
                : 0;

            // Kategori Kesulitan
            if ($difficultyLevel <= 0.30) {
                $difficultyCategory = 'Sukar';
            } elseif ($difficultyLevel <= 0.70) {
                $difficultyCategory = 'Sedang';
            } else {
                $difficultyCategory = 'Mudah';
            }

    $resultDetails = ResultDetails::whereHas('result', function ($q) use ($examId) {
    $q->where('exam_id', $examId)->where('user_id', auth()->id());
})->get();

    
return view('pages.tryout.result-details', compact('exam', 'question', 'userResultDetail', 'result', 'userAnswersProcessed',   'difficultyLevel',
        'difficultyCategory','resultDetails'));

    }

}