<?php

namespace App\Http\Controllers\Admin;

use App\Models\Exam;
use App\Models\User;
use App\Models\Essay;
use App\Models\Question;
use App\Models\SubCategory;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\MultipleChoice;
use App\Models\MultipleOption;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Yajra\DataTables\Facades\DataTables;

class questionController extends Controller
{
   
    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $exam_id = $request->get('exam_id');
        $subcategories = SubCategory::all();
        return view('pages.mitra.question.create', [
            'exam_id'       => $exam_id,
            'sub_categories'=> $subcategories,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request, Exam $exam)
    {
        $data = $request->all();
        $exam = Exam::findOrFail($request->exam_id);
        $data['exam_id'] = $exam->id;
        $data['user_id']    = Auth::id();              // user yg login
        $data['status']     = 'Ditinjau';              // default
        $data['difficulty'] = $request->difficulty;
        // Proses upload foto
    if ($request->hasFile('photo')) {
        $file = $request->file('photo');
        $filename = time() . '_' . $file->getClientOriginalName();
        $data['photo'] = $file->storeAs("assets/question/{$exam->id}", $filename, 'public');
    }

    // Simpan pertanyaan
    $question = Question::create($data);

    // Simpan ke tabel terkait sesuai tipe soal
   // Simpan pilihan ganda
   if ($request->question_type == 'pilihan_ganda') {
    $option1 = strip_tags($request->option1, '<img>');
    $option2 = strip_tags($request->option2, '<img>');
    $option3 = strip_tags($request->option3, '<img>');
    $option4 = strip_tags($request->option4, '<img>');
    $option5 = strip_tags($request->option5, '<img>');

    $correctAnswerKey = $request->correct_answer;
    $correctAnswer = null;

    // Tentukan jawaban yang benar berdasarkan key
    switch ($correctAnswerKey) {
        case 'option1':
            $correctAnswer = $option1;
            break;
        case 'option2':
            $correctAnswer = $option2;
            break;
        case 'option3':
            $correctAnswer = $option3;
            break;
        case 'option4':
            $correctAnswer = $option4;
            break;
        case 'option5':
            $correctAnswer = $option5;
            break;
        default:
            $correctAnswer = null;
            break;
    }

    // Simpan ke tabel MultipleChoice
    MultipleChoice::create([
        'question_id'    => $question->id,
        'option1'        => $option1,
        'option2'        => $option2,
        'option3'        => $option3,
        'option4'        => $option4,
        'option5'        => $option5,
        'correct_answer' => $correctAnswer,
    ]);
} elseif ($request->question_type == 'pilihan_majemuk') {
    MultipleOption::create([
        'question_id' => $question->id,
        'multiple1'     => $request->multiple1,
        'yes/no1'     => $request->input('yes/no1'),
        'multiple2'     => $request->multiple2,
        'yes/no2'     => $request->input('yes/no2'),
        'multiple3'     => $request->multiple3,
        'yes/no3'     => $request->input('yes/no3'),
        'multiple4'     => $request->multiple4,
        'yes/no4'     => $request->input('yes/no4'),
        'multiple5'     => $request->multiple5,
        'yes/no5'     => $request->input('yes/no5'),
    ]);
} elseif ($request->question_type == 'isian') {
    // --- Soal Isian (Essay) ---
    Essay::create([
        'question_id' => $question->id,
        'text'        => $request->text,
    ]);
}

   $exam = $question->exam; // Dapatkan data exam dari relasi question

if ($exam->exam_type === 'latihan soal') {
    return redirect()->route('exam.show', $exam->slug)->with('success', 'Pertanyaan berhasil dibuat!');
} elseif ($exam->exam_type === 'tryout') {
    return redirect()->route('tryout.show', $exam->slug)->with('success', 'Pertanyaan berhasil dibuat!');
} else {
    // Default fallback jika tipe tidak dikenal
    return redirect()->route('mitra-dashboard')->with('warning', 'Tipe ujian tidak dikenal, diarahkan ke dashboard.');
}
    }


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $question = Question::with(['multipleChoice', 'multipleOption', 'essay'])->findOrFail($id);
        $exam = Exam::all();
        $users = User::all();
        $subcategories = SubCategory::all();

        return view('pages.mitra.question.show', [
            'question' => $question,
            'exam'           => $exam,
            'users'          => $users,
            'sub_categories' => $subcategories,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $question = Question::with(['multipleChoice', 'multipleOption', 'essay'])->findOrFail($id);
        $exam = Exam::all();
        $users = User::all();
        $subcategories = SubCategory::all();
          $user = Auth::user();
          $exam = Exam::find($question->exam_id);

         if ($user->roles === 'ADMIN') {
        $view = 'pages.mitra.question.updateTryout';
    } elseif ($user->roles === 'MITRA') {
        $view = 'pages.mitra.question.update';
    }

        return view($view, [
            'question' => $question,
            'exam'           => $exam,
            'users'          => $users,
            'sub_categories' => $subcategories,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Exam $exam, Question $question)
{
      $user = Auth::user();
      if ($user->roles === 'ADMIN') {
        // Validasi input status
        $request->validate([
            'status' => 'required|in:Ditinjau,Diterima,Ditolak',
        ]);
        // Update status saja
        $question->status = $request->status;
        $question->save();

        return redirect()->back()->with('success', 'Status pertanyaan berhasil diperbarui.');
    }
    elseif ($user->roles === 'MITRA') {
        $data = $request->all();
    $exam = Exam::findOrFail($request->exam_id);
    $data['exam_id'] = $exam->id;
    $data['user_id']    = Auth::id();              // user yg login
    $data['status']     = $request->status;             // default
    $data['difficulty'] = $request->difficulty;

    // Jika ada file foto baru, update foto
    if ($request->hasFile('photo')) {
        $file = $request->file('photo');
        $filename = time() . '_' . $file->getClientOriginalName();

        // Hapus foto lama jika ada
        if ($question->photo && Storage::disk('public')->exists($question->photo)) {
            Storage::disk('public')->delete($question->photo);
        }

        // Simpan foto baru ke folder berdasarkan exam_id
        $data['photo'] = $file->storeAs("assets/question/{$exam->id}", $filename, 'public');
    } elseif($request->filled('remove_photo')) {
        // Jika checkbox hapus foto dicentang, hapus foto lama dan set kolom photo menjadi null
        if ($question->photo && Storage::disk('public')->exists($question->photo)) {
            Storage::disk('public')->delete($question->photo);
        }
        $data['photo'] = null;
    } else {
        $data['photo'] = $question->photo;
    }

    // Update data pertanyaan
    $question->update($data);

   // Hapus data soal lain jika tipe soal berubah
if ($request->question_type != 'pilihan_ganda') {
    MultipleChoice::where('question_id', $question->id)->delete();
}

if ($request->question_type != 'pilihan_majemuk') {
    MultipleOption::where('question_id', $question->id)->delete();
}

if ($request->question_type != 'isian') {
    Essay::where('question_id', $question->id)->delete();
}

if ($request->question_type == 'pilihan_ganda') {
    // ini buat opsi jawabannya gk ada tag html nya kecuali untuk data gambar
    $option1 = strip_tags($request->option1, '<img>');
    $option2 = strip_tags($request->option2, '<img>');
    $option3 = strip_tags($request->option3, '<img>');
    $option4 = strip_tags($request->option4, '<img>');
    $option5 = strip_tags($request->option5, '<img>');

    $correctAnswerKey = $request->correct_answer;
    $correctAnswer = null;

    switch ($correctAnswerKey) {
        case 'option1':
            $correctAnswer = $option1;
            break;
        case 'option2':
            $correctAnswer = $option2;
            break;
        case 'option3':
            $correctAnswer = $option3;
            break;
        case 'option4':
            $correctAnswer = $option4;
            break;
        case 'option5':
            $correctAnswer = $option5;
            break;
    }

    $multipleChoice = MultipleChoice::where('question_id', $question->id)->first();

    if ($multipleChoice) {
        $multipleChoice->update([
            'option1' => $option1,
            'option2' => $option2,
            'option3' => $option3,
            'option4' => $option4,
            'option5' => $option5,
            'correct_answer' => $correctAnswer,
        ]);
    } else {
        MultipleChoice::create([
            'question_id' => $question->id,
            'option1' => $option1,
            'option2' => $option2,
            'option3' => $option3,
            'option4' => $option4,
            'option5' => $option5,
            'correct_answer' => $correctAnswer,
        ]);
    }

} elseif ($request->question_type == 'pilihan_majemuk') {
    $multipleOption = MultipleOption::where('question_id', $question->id)->first();

    $dataOption = [
        'question_id' => $question->id,
        'multiple1' => $request->multiple1,
        'yes/no1' => $request->input('yes/no1'),
        'multiple2' => $request->multiple2,
        'yes/no2' => $request->input('yes/no2'),
        'multiple3' => $request->multiple3,
        'yes/no3' => $request->input('yes/no3'),
        'multiple4' => $request->multiple4,
        'yes/no4' => $request->input('yes/no4'),
        'multiple5' => $request->multiple5,
        'yes/no5' => $request->input('yes/no5'),
    ];

    if ($multipleOption) {
        $multipleOption->update($dataOption);
    } else {
        MultipleOption::create($dataOption);
    }

} elseif ($request->question_type == 'isian') {
    $essay = Essay::where('question_id', $question->id)->first();

    if ($essay) {
        $essay->update([
            'text' => $request->text,
        ]);
    } else {
        Essay::create([
            'question_id' => $question->id,
            'text' => $request->text,
        ]);
    }
}
    

        return redirect()->back()->with('success', 'Pertanyaan berhasil dirubah!');
    }
   
}

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $question = Question::findOrFail($id);
       // Hapus foto dari storage
    if ($question->photo && Storage::disk('public')->exists($question->photo)) {
        Storage::disk('public')->delete($question->photo);
    }

    // Hapus data terkait di tabel multiple_choices, multiple_options, dan essays
    MultipleChoice::where('question_id', $question->id)->delete();
    MultipleOption::where('question_id', $question->id)->delete();
    Essay::where('question_id', $question->id)->delete();

    // Hapus pertanyaan
    $question->delete();

    return redirect()->back()->with('success', 'Pertanyaan berhasil dihapus!');
    }
    
}
