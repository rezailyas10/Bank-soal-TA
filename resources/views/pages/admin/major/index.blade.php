@extends('layouts.admin')

@section('title')
  Program Studi
@endsection

@section('content')
<div class="container">
    <h1>Daftar program studi</h1>

    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <!-- Filter dan Search -->
    <form method="GET" action="{{ route('major.index') }}" class="mb-3">
        <div class="row g-2 align-items-end">
            <div class="col-md-4">
                <label for="university_id">Filter Universitas</label>
                <select name="university_id" id="university_id" class="form-control">
                    <option value="">-- Semua Universitas --</option>
                    @foreach($sub_universities as $university)
                        <option value="{{ $university->id }}" {{ request('university_id') == $university->id ? 'selected' : '' }}>
                            {{ $university->name }}
                        </option>
                    @endforeach
                </select>
            </div>

            <div class="col-md-4">
                <label for="search">Cari Program Studi</label>
                <input type="text" name="search" id="search" class="form-control" value="{{ request('search') }}">
            </div>

            <div class="col-md-4">
                <button type="submit" class="btn btn-primary">Terapkan</button>
                <a href="{{ route('major.index') }}" class="btn btn-secondary">Reset</a>
            </div>
        </div>
    </form>

    <a href="{{ route('major.create') }}" class="btn btn-primary mb-3">Buat Program Studi Baru</a>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Nama program studi</th>
                <th>Jenjang</th>
                <th>Skor UTBK Rata-Rata</th>
                <th>Daya Tampung</th>
                <th>Peminat</th>
                <th>Universitas</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            @forelse($majors as $major)
                <tr>
                    <td>{{ $major->name }}</td>
                    <td>{{ $major->level }}</td>
                    <td>{{ $major->passing_score }}</td>
                    <td>{{ $major->quota }}</td>
                    <td>{{ $major->peminat }}</td>
                    <td>{{ $major->university->name }}</td>
                    <td>
                        <a href="{{ route('major.show', $major->id) }}" class="btn btn-info btn-sm">Detail</a>
                        <a href="{{ route('major.edit', $major->id) }}" class="btn btn-warning btn-sm">Update</a>
                        <form action="{{ route('major.destroy', $major->id) }}" method="POST" style="display: inline-block;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Apakah anda yakin ingin menghapus?')">Delete</button>
                        </form>
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="6">Belum ada program studi.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <!-- Pagination -->
   <div class="d-flex justify-content-start">
   {{ $majors->links() }}
</div>
</div>
@endsection
