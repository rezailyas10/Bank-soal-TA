<?php

namespace App\Http\Controllers\Admin;

use App\Models\Exam;
use App\Models\User;
use App\Models\SubCategory;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\TryoutSubtest;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use App\Http\Requests\Admin\ExamRequest;
use Yajra\DataTables\Facades\DataTables;
use App\Http\Requests\Admin\ProductRequest;

class TryoutController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $subcategories = SubCategory::all();
         $user = Auth::user();
        // Tentukan view berdasarkan role
    if ($user->roles === 'ADMIN') {
         $exams = Exam::where('exam_type','tryout')->where('created_by', Auth::user()->name)->latest()->paginate(24);
        $view = 'pages.admin.tryout.index';
    } elseif ($user->roles === 'MITRA') {
        $exams = Exam::where('exam_type','tryout')->latest()->paginate(24);
        $view = 'pages.mitra.tryout.index';
    }
        
        return view($view,[
            'sub_categories' => $subcategories,
            'exams' => $exams,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
   public function create()
    {
        $users = User::all();
        $subcategories = SubCategory::all();
        return view('pages.mitra.tryout.create', [
            'users'          => $users,
            'sub_categories' => $subcategories,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    // public function store(ExamRequest $request)
    // {
      
    //     $data = $request->all();
    //     $data['slug'] = Str::slug($request->title);
    //     $data['created_by'] = auth()->user()->name;

    //     if ($data['exam_type'] === 'tryout') {
    //         $data['tanggal_dibuka']  = $request->tanggal_dibuka;
    //         $data['tanggal_ditutup'] = $request->tanggal_ditutup;
    //     }

    //     $exam = Exam::create($data);
    //     if ($data['exam_type'] === 'tryout') {
    //         foreach ($request->subcategory_id as $i => $subcat) {
    //             TryoutSubtest::create([
    //                 'exam_id'         => $exam->id,
    //                 'subcategory_id' => $subcat,
    //                 'timer'           => $request->timer[$i],
    //             ]);
    //         }
    //     }

    //     return redirect()->route('exam.index')->with('success', 'Bank soal berhasil dibuat!');

    // }

    public function store(ExamRequest $request)
    {
      
        $data = $request->all();
        $data['slug'] = Str::slug($request->title);
        $data['created_by'] = auth()->user()->name;
        $data['sub_category_id'] = null;
        $data['exam_type'] = 'tryout';
         $data['tanggal_dibuka']  = $request->tanggal_dibuka;
         $data['tanggal_ditutup'] = $request->tanggal_ditutup;
    

        Exam::create($data);

        return redirect()->route('tryout.index')->with('success', 'Bank soal berhasil dibuat!');

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $user = Auth::user();
        if ($user->roles === 'ADMIN') {
        $exam = Exam::with([
        'questions' => function($query) {
            $query->orderBy('created_at', 'desc');
        },
        'questions.subCategory',
        'questions.user',
        'subCategory'
    ])->where('slug', $id)->firstOrFail();
        $view = 'pages.admin.tryout.show';
    } elseif ($user->roles === 'MITRA') {
    $exam = Exam::with([
        'questions' => function($query) {
            $query->where('user_id', auth()->id())
                  ->orderBy('created_at', 'desc');
        },
        'questions.subCategory',
        'questions.user',
        'subCategory'
    ])->where('slug', $id)->firstOrFail();
    
    $view = 'pages.mitra.tryout.show';
}
        return view($view, compact('exam'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $exam = Exam::findOrFail($id);
        $users = User::all();
        $subcategories = SubCategory::all();

        return view('pages.mitra.tryout.edit', [
            'exam'           => $exam,
            'users'          => $users,
            'sub_categories' => $subcategories,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ExamRequest $request, $id)
{
    $exam = Exam::findOrFail($id);
    $data = $request->all();
    $data['slug'] = Str::slug($request->title);
     $data['exam_type'] = 'tryout';
    $data['sub_category_id'] = null;
    $data['tanggal_dibuka']  = $request->tanggal_dibuka;
    $data['tanggal_ditutup'] = $request->tanggal_ditutup;


    $exam->update($data);

    return redirect()
        ->back()
        ->with('success', 'Tryout berhasil diperbarui!');
}

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $exam = Exam::findOrFail($id);
        $exam->delete();
        return redirect()->route('tryout.index')->with('success', 'Tryout berhasil dihapus!');
    }
}
