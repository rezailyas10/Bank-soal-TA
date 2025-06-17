<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\ExamRequest;
use App\Models\Exam;
use App\Models\SubCategory;
use App\Models\TryoutSubtest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use App\Http\Requests\Admin\ProductRequest;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Support\Str;

class ExamController extends Controller
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
         $exams = Exam::where('exam_type','latihan soal')->latest()->paginate(24);
        $view = 'pages.admin.exam.index';
    } elseif ($user->roles === 'MITRA') {
        $exams = Exam::where('exam_type','latihan soal')->where('created_by', Auth::user()->name)->latest()->paginate(24);
        $view = 'pages.mitra.exam.index';
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
         $user = Auth::user();
        $subcategories = SubCategory::all();
         if ($user->roles === 'ADMIN') {
        $view = 'pages.admin.exam.create';
        } elseif ($user->roles === 'MITRA') {
            $view = 'pages.mitra.exam.create';
        }
        return view($view, [
            'users'          => $users,
            'sub_categories' => $subcategories,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ExamRequest $request)
    {
      
        $data = $request->all();
        $data['slug'] = Str::slug($request->title);
        $data['created_by'] = auth()->user()->name;
        $data['exam_type'] = 'latihan soal';
        $data['tanggal_dibuka']  = $request->tanggal_dibuka;
        $data['tanggal_ditutup'] = $request->tanggal_ditutup;
        

        Exam::create($data);

        return redirect()->route('exam.index')->with('success', 'Bank soal berhasil dibuat!');

    }

    // public function store(ExamRequest $request)
    // {
      
    //     $data = $request->all();
    //     $data['slug'] = Str::slug($request->title);
    //     $data['created_by'] = auth()->user()->name;
    //     $data['sub_category_id'] = null;
    //     $data['tanggal_dibuka']  = null;
    //     $data['tanggal_ditutup'] = null;
    //     $data['exam_type'] = 'latihan soal';
        

    //     $exam = Exam::create($data);
    //         foreach ($request->subcategory_id as $i => $subcat) {
    //             TryoutSubtest::create([
    //                 'exam_id'         => $exam->id,
    //                 'subcategory_id' => $subcat,
    //                 'timer'           => 0,
    //             ]);
    //         }

    //     return redirect()->route('exam.index')->with('success', 'Bank soal berhasil dibuat!');

    // }

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
        $view = 'pages.admin.exam.show';
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
    
    $view = 'pages.mitra.exam.show';
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
        $user = Auth::user();
 if ($user->roles === 'ADMIN') {
        $view = 'pages.admin.exam.edit';
        } elseif ($user->roles === 'MITRA') {
            $view = 'pages.mitra.exam.edit';
        }

       return view($view, [
        'exam' => $exam,
        'users' => $users,
        'subcategories' => $subcategories,
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
     $data['tanggal_dibuka']  = null;
    $data['tanggal_ditutup'] = null;
    $data['exam_type'] = 'latihan soal';

    $exam->update($data);

    return redirect()
        ->back()
        ->with('success', 'Bank soal berhasil diperbarui!');
}

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $exam = Exam::findOrFail($id);
        $exam->delete();
        return redirect()->route('exam.index')->with('success', 'Bank soal berhasil dihapus!');
    }
}
