@extends('layouts.app')

@section('title', 'Try Out')

@push('addon-style')
<style>
    /* —————— CSS Anda tetap sama —————— */
    .navbar-brand { color: white; font-weight: 600; }
    .navbar-icons { display: flex; align-items: center; }
    .navbar-icon { color: white; margin-left: 15px; font-size: 1.2rem; }
    .search-bar { background-color: #f0f0f0; border-radius: 50px; padding: 8px 15px; margin: 15px 0; }
    .search-bar input { border: none; background: transparent; width: 100%; }
    .search-bar input:focus { outline: none; }
    .task-card { border-radius: 12px; margin-bottom: 10px; padding: 15px; color: white; position: relative; }
    .task-card.yellow { background-color: var(--orange); }
    .task-card.green  { background-color: var(--green); }
    .task-card.purple { background-color: var(--purple); }
    .task-card-title { font-weight: 600; margin-bottom: 5px; }
    .task-card-button { background-color: rgba(255,255,255,0.3); border: none; border-radius: 50px; color: white; padding: 3px 12px; font-size: 0.8rem; }
    .section-title { font-weight: 600; font-size: 1.1rem; margin: 20px 0 15px 0; }
    .list-item { background-color: white; border-radius: 8px; padding: 12px; margin-bottom: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); position: relative; cursor: pointer; }
    .list-item-title { font-weight: 600; margin-bottom: 0; }
    .list-item-subtitle { color: #777; font-size: 0.8rem; }
    .toggle-icon { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: var(--primary); }
    .list-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; }
    @media (max-width: 768px) { .list-grid { grid-template-columns: 1fr; } }

    /* —————— New Styles for Try Out Cards —————— */
    .tryout-section {
        margin-top: 30px;
    }
    
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .section-header h3 {
        font-weight: 600;
        font-size: 1.2rem;
        margin: 0;
        color: #333;
    }
    
    .view-all-link {
        color: #10B981;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 500;
    }
    
    .view-all-link:hover {
        color: #059669;
        text-decoration: none;
    }
    
    .tryout-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
        margin-bottom: 20px;
    }
    
    @media (max-width: 768px) {
        .tryout-grid {
            grid-template-columns: 1fr;
        }
    }
    
    .tryout-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        border: 1px solid #f0f0f0;
        transition: all 0.3s ease;
        position: relative;
        text-decoration: none;
        color: inherit;
    }
    
    .tryout-card:hover {
        box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        transform: translateY(-2px);
        text-decoration: none;
        color: inherit;
    }
    
    .tryout-card-header {
        display: flex;
        align-items: flex-start;
        margin-bottom: 15px;
    }
    
    .tryout-number {
        background: #10B981;
        color: white;
        width: 60px;
        height: 60px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        font-weight: 700;
        margin-right: 15px;
        flex-shrink: 0;
    }
    
    .tryout-info {
        flex: 1;
        min-width: 0;
    }
    
    .tryout-badge {
        background: #10B981;
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
        margin-bottom: 8px;
        display: inline-block;
    }
    
    .tryout-title {
        font-size: 1rem;
        font-weight: 600;
        color: #1f2937;
        margin: 0 0 8px 0;
        line-height: 1.3;
    }
    
    .tryout-meta {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 15px;
    }
    
    .tryout-meta-item {
        display: flex;
        align-items: center;
        font-size: 0.85rem;
        color: #6b7280;
    }
    
    .tryout-meta-item i {
        margin-right: 6px;
        color: #9ca3af;
    }
    
    .tryout-arrow {
        position: absolute;
        top: 20px;
        right: 20px;
        color: #10B981;
        font-size: 1.2rem;
    }
    
    .tryout-status {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .status-upcoming {
        background: #fef3c7;
        color: #d97706;
    }
    
    .status-ongoing {
        background: #dcfce7;
        color: #16a34a;
    }
    
    .status-completed {
        background: #e5e7eb;
        color: #6b7280;
    }
    
    .status-available {
        background: #dbeafe;
        color: #2563eb;
    }
</style>
@endpush

@section('content')

  <div class="container py-3">
    <!-- Search Bar -->
    <div class="search-bar d-flex align-items-center" >
      <i class="fas fa-search me-2"></i>
      <input type="text" placeholder="Cari Bank Soal" />
    </div>

    <!-- —————— Try Out Tersedia Section —————— -->
    <div class="tryout-section">
      <div class="section-header">
        <h3>Try Out Tersedia</h3>
        <a href="#" class="view-all-link">
          Lihat Semua Try Out <i class="fas fa-chevron-right"></i>
        </a>
      </div>

      <!-- —————— Upcoming Try Out —————— -->
      @if($upcoming->isNotEmpty())
        <div class="tryout-grid" data-aos="fade-up">
          @foreach($upcoming as $index => $exam)
            <a href="{{ route('tryout-detail', $exam->slug) }}" class="tryout-card">
              <div class="tryout-card-header">
                <div class="tryout-number">{{ str_pad($index + 1, 2, '0', STR_PAD_LEFT) }}</div>
                <div class="tryout-info">
                  <span class="tryout-badge">SNBT</span>
                  <div class="tryout-status status-upcoming">Segera Dimulai</div>
                </div>
              </div>
              <h4 class="tryout-title">{{ $exam->title }}</h4>
              <div class="tryout-meta">
                <div class="tryout-meta-item">
                  <i class="fas fa-star"></i>
                  Bisa Dibeli
                </div>
                <div class="tryout-meta-item">
                  <i class="fas fa-users"></i>
                  {{ number_format(rand(100000, 200000)) }} Peserta
                </div>
              </div>
              <div class="tryout-arrow">
                <i class="fas fa-chevron-right"></i>
              </div>
            </a>
          @endforeach
        </div>
      @endif

      <!-- —————— Ongoing Try Out —————— -->
      @if($ongoing->isNotEmpty())
        <div class="tryout-grid" data-aos="fade-up" data-aos-delay="100">
          @foreach($ongoing as $index => $exam)
            <a href="{{ route('tryout-detail', $exam->slug) }}" class="tryout-card">
              <div class="tryout-card-header">
                <div class="tryout-number">{{ str_pad($index + 1, 2, '0', STR_PAD_LEFT) }}</div>
                <div class="tryout-info">
                  <span class="tryout-badge">SNBT</span>
                  <div class="tryout-status status-ongoing">Berlangsung</div>
                </div>
              </div>
              <h4 class="tryout-title">{{ $exam->title }}</h4>
              <div class="tryout-meta">
                <div class="tryout-meta-item">
                  <i class="fas fa-star"></i>
                  Bisa Dibeli
                </div>
                <div class="tryout-meta-item">
                  <i class="fas fa-users"></i>
                  {{ number_format(rand(100000, 200000)) }} Peserta
                </div>
              </div>
              <div class="tryout-arrow">
                <i class="fas fa-chevron-right"></i>
              </div>
            </a>
          @endforeach
        </div>
      @endif

      <!-- —————— Past Try Out —————— -->
      @if($past->isNotEmpty())
        <div class="tryout-grid" data-aos="fade-up" data-aos-delay="200">
          @foreach($past as $index => $exam)
            @php
              $hasResult = !empty($userResults[$exam->id]);
              $linkUrl = $hasResult 
                ? route('tryout-result', ['exam' => $exam->id, 'id' => $userResults[$exam->id]->id])
                : route('tryout-detail', $exam->slug);
            @endphp
            
            <a href="{{ $linkUrl }}" class="tryout-card">
              <div class="tryout-card-header">
                <div class="tryout-number">{{ str_pad($index + 1, 2, '0', STR_PAD_LEFT) }}</div>
                <div class="tryout-info">
                  <span class="tryout-badge">SNBT</span>
                  <div class="tryout-status {{ $hasResult ? 'status-completed' : 'status-available' }}">
                    {{ $hasResult ? 'Selesai' : 'Tersedia' }}
                  </div>
                </div>
              </div>
              <h4 class="tryout-title">{{ $exam->title }}</h4>
              <div class="tryout-meta">
                <div class="tryout-meta-item">
                  <i class="fas fa-star"></i>
                  {{ $hasResult ? 'Sudah Dikerjakan' : 'Tidak Mengerjakan' }}
                </div>
                <div class="tryout-meta-item">
                  <i class="fas fa-users"></i>
                  {{ number_format(rand(100000, 200000)) }} Peserta
                </div>
              </div>
              <div class="tryout-arrow">
                <i class="fas fa-chevron-right"></i>
              </div>
            </a>
          @endforeach
        </div>
      @endif
    </div>

  </div>
@endsection

@push('addon-script')
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="/vendor/jquery/jquery.slim.min.js"></script>
  <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
  <script>
    AOS.init({ duration: 800, once: true });
  </script>
  <script src="/script/navbar-scroll.js"></script>
@endpush