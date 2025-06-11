@extends('layouts.mitra')

@section('title', 'Detail Soal')

@section('content')
<div class="container mt-4">
    <h1>Detail Soal</h1>

    <div class="card">
        <div class="card-body">
            <p><strong>ID:</strong> {{ $question->id }}</p>

            <p><strong>Soal:</strong><br> {!! $question->question_text !!}</p>

            @if ($question->photo)
                <p><strong>Gambar:</strong><br>
                    <img src="{{ asset('storage/' . $question->photo) }}" alt="Photo" class="img-fluid" style="max-width: 300px;">
                </p>
            @endif

            <p><strong>Tipe Soal:</strong> {{ ucfirst($question->question_type) }}</p>
            <p><strong>Penjelasan:</strong><br> {!! $question->explanation !!}</p>
            <p><strong>Materi (Lesson):</strong> {{ $question->lesson }}</p>

            <p><strong>Kategori Soal:</strong> {{ $question->subCategory?->name ?? '-' }}</p>
            <p><strong>Ujian:</strong> <a href="{{ route('exam.show', $question->exam->slug) }}">{{ $question->exam->title }}</a></p>

            <a href="{{ route('question.edit', $question->id) }}" class="btn btn-warning">Edit</a>

            <form action="{{ route('question.destroy', $question->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Yakin ingin menghapus soal ini?')">
                @csrf
                @method('DELETE')
                <button class="btn btn-danger">Hapus</button>
            </form>

            <a href="{{ route('exam.show', $question->exam->slug) }}" class="btn btn-secondary">Kembali ke Ujian</a>
        </div>
    </div>
</div>
@endsection
