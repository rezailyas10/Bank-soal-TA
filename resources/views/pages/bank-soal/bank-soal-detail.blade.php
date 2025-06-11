@extends('layouts.app')

@section('title')
  Bank Soal Detail
@endsection

<style>
    .brand-text {
        color: white;
        font-weight: bold;
        font-size: 1.5rem;
        text-decoration: none;
    }

    .brand-text:hover {
        color: white;
        text-decoration: none;
    }

    .container {
        max-width: 1000px;
        margin: 0 auto;
        padding: 0 15px;
    }

    .sub-category-header {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 30px;
        text-align: center;
    }

    .sub-category-header h3 {
        margin: 0 0 15px 0;
        color: #333;
        font-size: 1.8rem;
    }

    .exam-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 15px;
        margin-bottom: 20px;
    }

    .exam-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 20px;
        transition: transform 0.2s ease;
        cursor: pointer;
        border: 1px solid #f1f5f9;
    }

    .exam-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }

    .exam-number {
        flex-shrink: 0;
        text-align: center;
    }

    .exam-badge {
        background: #22c55e;
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 0.7rem;
        font-weight: 600;
        text-transform: uppercase;
        margin-bottom: 5px;
        display: inline-block;
    }

    .exam-number-display {
        font-size: 2.5rem;
        font-weight: 800;
        color: #1f2937;
        line-height: 1;
    }

    .exam-content {
        flex: 1;
        min-width: 0;
    }

    .exam-status {
        color: #6b7280;
        font-size: 0.85rem;
        margin-bottom: 4px;
    }

    .exam-title {
        color: #1f2937;
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 8px;
        line-height: 1.3;
    }

    .exam-meta {
        display: flex;
        align-items: center;
        gap: 15px;
        color: #6b7280;
        font-size: 0.8rem;
    }

    .exam-meta-item {
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .exam-actions {
        flex-shrink: 0;
        display: flex;
        flex-direction: column;
        gap: 8px;
        align-items: flex-end;
    }

    .btn {
        padding: 8px 16px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.85rem;
        border: none;
        cursor: pointer;
        white-space: nowrap;
    }

    .btn-primary {
        background: #3b82f6;
        color: white;
    }

    .btn-primary:hover {
        background: #2563eb;
        color: white;
        text-decoration: none;
    }

    .btn-secondary {
        background: #6b7280;
        color: white;
    }

    .btn-secondary:hover {
        background: #4b5563;
        color: white;
        text-decoration: none;
    }

    .btn-warning {
        background: #f59e0b;
        color: white;
    }

    .btn-warning:hover {
        background: #d97706;
        color: white;
        text-decoration: none;
    }

    .score-badge {
        background: #dbeafe;
        color: #1e40af;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 600;
    }

    .empty-message {
        text-align: center;
        padding: 50px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        color: #666;
        font-size: 1.1rem;
    }

    .alert {
        padding: 15px;
        border-radius: 6px;
        margin-bottom: 20px;
    }

    .alert-success {
        background: #dcfce7;
        color: #166534;
        border: 1px solid #bbf7d0;
    }

    @media (max-width: 768px) {
        .exam-grid {
            grid-template-columns: 1fr;
        }
        
        .exam-card {
            flex-direction: column;
            text-align: center;
            gap: 15px;
        }
        
        .exam-actions {
            align-items: center;
            flex-direction: row;
            justify-content: center;
        }
    }
</style>

<!-- Notifikasi sukses -->
@if(session('success'))
<div class="alert alert-success">
    {{ session('success') }}
</div>
@endif

@section('content')
   <!-- Navbar -->
   <nav class="navbar">
       <div class="container">
           <a href="{{ route('dashboard') }}" class="brand-text">Bank Soal</a>
       </div>
   </nav>

   <!-- Sub Kategori Header -->
   <div class="container mt-4">
       <div class="sub-category-header">
           <h3>{{ $subCategories->name }}</h3>
           @if($subCategories->photo)
              <img src="{{ asset('storage/' . $subCategories->photo) }}" alt="{{ $subCategories->name }}" style="max-width: 150px; border-radius: 6px;">
           @endif
       </div>

       <!-- Daftar Exam/Latihan Soal -->
       @forelse($exams as $index => $exam)
           <div class="exam-grid">
               <div class="exam-card">
                   <div class="exam-number">
                       <div class="exam-badge">{{ $exam->exam_type }}</div>
                       <div class="exam-number-display">{{ str_pad($index + 1, 2, '0', STR_PAD_LEFT) }}</div>
                   </div>
                   
                   <div class="exam-content">
                       @if(! empty($userResults[$exam->id]))
                           <div class="exam-status">Sudah Dikerjakan</div>
                       @else
                           <div class="exam-status">Belum Dikerjakan</div>
                       @endif
                       
                       <div class="exam-title">{{ $exam->title }}</div>
                       
                       <div class="exam-meta">
                           @if(! empty($userResults[$exam->id]))
                               <div class="exam-meta-item">
                                   <span>⭐</span>
                                   <span>Nilai: {{ $userResults[$exam->id]->score }}</span>
                               </div>
                           @else
                               <div class="exam-meta-item">
                                   <span>⭐</span>
                                   <span>Belum Dikerjakan</span>
                               </div>
                           @endif
                           
                           <div class="exam-meta-item">
                               <span>👥</span>
                               <span>{{ $examParticipants[$exam->id] ?? 0 }} Peserta</span>
                           </div>
                       </div>
                   </div>

                   <div class="exam-actions">
                       @if(! empty($userResults[$exam->id]))
                           {{-- Sudah pernah mengerjakan --}}
                           <div class="score-badge">Score: {{ $userResults[$exam->id]->score }}</div>
                           <a href="{{ route('bank-soal-result', ['exam' => $exam->id, 'id' => $userResults[$exam->id]->id]) }}" class="btn btn-secondary">
                               Lihat Detail
                           </a>
                       @else
                           {{-- Belum mengerjakan --}}
                           @auth
                               @if (Auth::check())
                                   <a href="{{ route('exam', $exam->slug) }}" class="btn btn-primary">
                                       Mulai Latihan
                                   </a>
                               @else
                                   <a href="{{ route('login') }}" class="btn btn-warning">
                                       Login Dulu
                                   </a>
                               @endif
                           @endauth
                       @endif
                   </div>
               </div>
           </div>
       @empty
           <div class="empty-message">
               Belum ada latihan soal untuk sub kategori ini.
           </div>
       @endforelse
   </div>
@endsection

@push('addon-script')
<script>
 
</script>
@endpush