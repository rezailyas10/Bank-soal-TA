@extends('layouts.app')

@section('title')
  Try Out
@endsection
<style>


    .navbar-brand {
        color: white;
        font-weight: 600;
    }

    .navbar-icons {
        display: flex;
        align-items: center;
    }

    .navbar-icon {
        color: white;
        margin-left: 15px;
        font-size: 1.2rem;
    }

    .detail-header {
        background-color: white;
        padding: 20px;
        border-radius: 0 0 15px 15px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .detail-title {
        font-weight: 600;
        margin-bottom: 5px;
    }

    .detail-subtitle {
        color: #777;
        font-size: 0.9rem;
        margin-bottom: 15px;
    }

    .stats-container {
        display: flex;
        justify-content: space-between;
        margin: 20px 0;
    }

    .stat-item {
        text-align: center;
    }

    .stat-value {
        font-weight: 600;
        font-size: 1.2rem;
        color: var(--primary);
    }

    .stat-label {
        font-size: 0.8rem;
        color: #777;
    }

    .subject-container {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        margin-bottom: 15px;
        overflow: hidden;
    }

    .subject-header {
        padding: 15px;
        border-bottom: 1px solid #f0f0f0;
        font-weight: 600;
    }

    .subject-item {
        padding: 15px;
        border-bottom: 1px solid #f0f0f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .subject-item:last-child {
        border-bottom: none;
    }

    .time-indicator {
        display: flex;
        align-items: center;
        color: #777;
        font-size: 0.9rem;
    }

    .university-selection {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        padding: 20px;
        margin: 20px 0;
    }

    .university-title {
        font-weight: 600;
        margin-bottom: 15px;
        color: var(--primary);
        border-bottom: 2px solid var(--primary);
        padding-bottom: 5px;
        display: inline-block;
    }

    .university-description {
        color: #555;
        font-size: 0.9rem;
        margin-bottom: 15px;
    }

    .custom-select {
        width: 100%;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 10px;
        background-color: #f9f9f9;
    }

    .mascot-container {
        display: flex;
        align-items: center;
        background-color: #e9f0ff;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 20px;
    }

    .mascot-image {
        flex: 0 0 60px;
        height: 60px;
        background-color: #cfd9f0;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
    }

    .mascot-text {
        flex: 1;
        font-size: 0.9rem;
        color: var(--primary);
    }

    .footer-note {
        text-align: center;
        padding: 20px 0;
        color: #777;
        font-size: 0.9rem;
    }

    .register-button {
        display: block;
        width: 100%;
        padding: 12px;
        background-color: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        margin-top: 15px;
        text-align: center;
        text-decoration: none;
    }

    .subject-duration {
        display: flex;
        gap: 10px;
    }

    .duration-box {
        background-color: #f0f0f0;
        border-radius: 5px;
        padding: 4px 8px;
        font-size: 0.8rem;
        display: flex;
        align-items: center;
    }

    .duration-icon {
        margin-right: 5px;
        color: var(--primary);
    }

    @media (max-width: 768px) {
        .stats-container {
            flex-wrap: wrap;
        }

        .stat-item {
            flex: 0 0 50%;
            margin-bottom: 15px;
        }

        .subject-duration {
            flex-direction: column;
            gap: 5px;
        }
    }
</style>

@section('content')
<div class="detail-header" data-aos="fade-down">
    <div class="container">
      <!-- Judul & rentang tanggal -->
      <div class="detail-title">{{ $exam->title }}</div>
      <div class="detail-subtitle">
        {{ $exam->tanggal_dibuka->translatedFormat('j F Y, H:i') }}
        @if($exam->tanggal_ditutup)
          &nbsp;–&nbsp;{{ $exam->tanggal_ditutup->translatedFormat('j F Y, H:i') }}
        @endif
      </div>

      <div class="row stats-container">
        {{-- Status --}}
        <div class="col-6 col-md-3 stat-item">
          <div class="stat-value">
            @if(now()->lt($exam->tanggal_dibuka)) Belum Mulai
            @elseif(now()->between($exam->tanggal_dibuka, $exam->tanggal_ditutup)) Sedang Berlangsung
            @else Selesai
            @endif
          </div>
          <div class="stat-label">Status</div>
        </div>

        {{-- Total Waktu --}}
        <div class="col-6 col-md-3 stat-item">
          <div class="stat-value">
       {{ $questions->pluck('subCategory')->unique('id')->pluck('timer')->sum() }} menit
          </div>
          <div class="stat-label">Total Waktu</div>
        </div>

        {{-- Jumlah Soal --}}
        <div class="col-6 col-md-3 stat-item">
          <div class="stat-value">
            <div class="stat-value">
  {{ $questions->count() }} soal
</div>
          </div>
          <div class="stat-label">Jumlah Soal</div>
        </div>
      </div>
    </div>
  </div>

  <div class="container py-4">
    {{-- mengkelompokan pertanyaan berdasarkan mata pelajaran --}}
    @php
  $questionsGrouped = $questions->groupBy(fn($q) => $q->subCategory->category->name);
        @endphp

  @foreach($questionsGrouped as $categoryName => $groupedQuestions)
  <div class="subject-container">
    <div class="subject-header">{{ $categoryName }}</div>

    @php
      $bySubCategory = $groupedQuestions->groupBy('sub_category_id');
    @endphp

    @foreach($bySubCategory as $subCategoryId => $subQuestions)
      @php
        $subCategory = $subQuestions->first()->subCategory;
      @endphp
      <div class="subject-item">
        <div>{{ $subCategory->name }}</div>
        <div class="subject-duration">
          <div class="duration-box">
            <i class="fas fa-clock duration-icon"></i>
            {{ $subCategory->timer ?? '-' }} menit
          </div>
          <div class="duration-box">
            <i class="fas fa-list duration-icon"></i>
            {{ $subQuestions->count() }} soal
          </div>
        </div>
      </div>
    @endforeach
  </div>
@endforeach

   <!-- University Selection -->
<div class="university-selection">
    <div class="university-title">Target Jurusan</div>
    <div class="university-description">
        Klik untuk menentukan Jurusan Yang Dipilih
    </div>

   @if($userMajors->isNotEmpty())
    @foreach($userMajors as $index => $userMajor)
        <div class="mb-3">
            <h6>Pilihan {{ $index + 1 }}</h6>

            <div class="mb-2">
                <label for="university_{{ $index }}">Universitas</label>
                <input type="text" class="form-control" id="university_{{ $index }}" 
                    value="{{ $userMajor->major->university->name ?? 'Universitas Tidak Diketahui' }}" readonly>
            </div>

            <div>
                <label for="major_{{ $index }}">Program Studi</label>
                <input type="text" class="form-control" id="major_{{ $index }}" 
                    value="{{ $userMajor->major->name ?? 'Jurusan Tidak Diketahui' }}" readonly>
            </div>
        </div>
    @endforeach
      <a href="{{ route('user.majors.index') }}" class="btn btn-primary mt-2">
            Tambah Pilihan Jurusan
        </a>
@else
        
        

    <div class="mascot-container mt-3">
    <div class="alert alert-warning">
        Kamu belum memilih jurusan ini.
    </div>
    <a href="{{ route('user.majors.index') }}" class="btn btn-primary mt-2">
        Pilih Jurusan
    </a>
</div>
    @endif

   
</div>

    
@if (now()->lt($exam->tanggal_dibuka))
    {{-- Jika tryout belum dibuka --}}
    <div class="text-center mb-3 text-red-600 font-semibold">
        Tryout ini belum dibuka.
    </div>
    <a href="{{ route('tryout') }}" class="register-button">
        Kembali ke Halaman Tryout
    </a>

@elseif ($userExamResult)
    {{-- Jika user sudah mengerjakan --}}
    <div class="footer-note" >
        Anda telah mengerjakan tryout ini pada tanggal
        <br />
        <strong>{{ $userExamResult->created_at->format('d M Y H:i') }}</strong>
    </div>
    
    <a href="{{ route('tryout') }}" class="register-button">
        Kembali ke Halaman Tryout
    </a>

@elseif (now()->between($exam->tanggal_dibuka, $exam->tanggal_ditutup))
    {{-- Jika sekarang dalam rentang pengerjaan dan user belum mengerjakan --}}
   @auth
                        @if (Auth::check())
                           <a href="{{ route('tryout-subtest', ['exam' => $exam->slug, 'subtest' => $questions->pluck('subCategory')->filter()->first()?->id]) }}"
                            class="register-button">
                            Kerjakan Sekarang
                            </a>
                        @else
                            <a href="{{ route('login') }}" class="btn btn-warning">
                                Login untuk Mulai
                            </a>
                        @endif
                    @endauth

@else
    {{-- Jika tryout sudah ditutup dan user belum mengerjakan --}}
    <div class="text-center mb-3 text-gray-600 font-semibold">
        Tryout ini telah ditutup.
    </div>
    <a href="{{ route('tryout') }}" class="register-button">
        Kembali ke Halaman Tryout
    </a>
@endif

   
</div>


@endsection

@push('addon-script')
<script
src="https://kit.fontawesome.com/a076d05399.js"
crossorigin="anonymous"
></script>
<script src="/vendor/jquery/jquery.slim.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>

</script>
<script src="/script/navbar-scroll.js"></script>
@endpush