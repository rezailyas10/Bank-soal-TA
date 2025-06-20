@extends('layouts.admin')

@section('title')
  Daftar Pengerjaan Tryout
@endsection

@section('content')
<div class="container">
    <h1>Daftar Tryout</h1>

    <!-- Notifikasi sukses -->
    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

   <!-- Tombol untuk membuat bank soal baru -->
   <div class="card-body">
    <a href="{{ route('nilai-tryout.create') }}" class="btn btn-primary mb-3">Buat Bank Soal Baru</a>
   </div>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Nama Bank Soal</th>
                <th>Deskripsi</th>
                <th>Published</th>
                <th>Dibuat Oleh</th>
                <th>Tipe Ujian</th>
                <th>Jumlah Pertanyaan</th>
                <th>Jumlah Peserta</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            @forelse($exams as $exam)
            <tr>
                <td>{{ $exam->title }}</td>
                <td>{!! $exam->description !!}</td>
                <td>{{ $exam->is_published ? 'Ya' : 'Tidak' }}</td>
                <td>{{ $exam->created_by }}</td>
                <td>{{ $exam->exam_type }}</td>
                <td>{{ $exam->questions->count() }}</td>
                <td>{{ $exam->results_count ?? 0 }}</td>
                <td>
                    <a href="{{ route('nilai-tryout.show', $exam->slug) }}" class="btn btn-info btn-sm">Analisa IRT</a>
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="8">Belum ada Tryout.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>
@endsection