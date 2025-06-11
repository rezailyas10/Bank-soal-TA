@extends('layouts.mitra')

@section('title')
  Detail Bank Soal
@endsection

@section('content')
<div class="container">

     <!-- Notifikasi sukses -->
     @if(session('success'))
     <div class="alert alert-success">
         {{ session('success') }}
     </div>
 @endif
    <h1>Detail Bank Soal: {{ $exam->title }}</h1>
    <div class="card mb-3">
        <div class="card-body">
            <p><strong>Deskripsi:</strong> {{ $exam->description }}</p>
            <p><strong>Mata Pelajaran: {{ $exam->subCategory->name }}</strong> 
            <p><strong>Tipe Ujian:</strong> {{ $exam->exam_type }}</p>
            <p><strong>Published:</strong> {{ $exam->is_published ? 'Ya' : 'Tidak' }}</p>
            <p><strong>Dibuat Oleh:</strong> {{ $exam->created_by }}</p>
        </div>
    </div>

    <hr>

    <h3>Pertanyaan</h3>
    @if($exam->questions->count() > 0)
        <ul class="list-group mb-3">
            @foreach($exam->questions as $question)
                <li class="list-group-item">
                    <strong>{{ $question->question_text }}</strong>
                    <br>
                    <small>Tipe: {{ $question->question_type }}</small>
                    <!-- Tombol untuk update pertanyaan, dialihkan ke QuestionController -->
                    <a href="{{ route('question.edit', $question->id) }}" class="btn btn-sm btn-warning float-right">Update</a>
                    <a href="{{ route('question.show', $question->id) }}" class="btn btn-sm btn-warning float-right">Detail</a>
                    <form action="{{ route('question.destroy', $question->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('Anda yakin ingin menghapus bank soal ini?');">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-danger">Hapus Soal</button>
                    </form>
                </li>
            @endforeach
        </ul>
    @else
        <p>Tidak ada pertanyaan. <a href="{{ route('question.create', ['exam_id' => $exam->id]) }}">Buat pertanyaan baru</a></p>
    @endif

    <a href="{{ route('question.create', ['exam_id' => $exam->id]) }}" class="btn btn-primary">Tambah Pertanyaan</a>
    <a href="{{ route('exam.edit', $exam->id) }}" class="btn btn-secondary">Edit Bank Soal</a>
    <form action="{{ route('exam.destroy', $exam->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('Anda yakin ingin menghapus bank soal ini?');">
        @csrf
        @method('DELETE')
        <button class="btn btn-danger">Hapus Bank Soal</button>
    </form>
</div>
@endsection
