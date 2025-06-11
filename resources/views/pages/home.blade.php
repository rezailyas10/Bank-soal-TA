@extends('layouts.app')

@section('title')
  Home
@endsection

 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
  
.store-carousel {
    background: linear-gradient(135deg, #3369a7 0%, #357abd 100%);
    margin: 0 !important;
  padding-bottom: 0 !important;
}  
.pahamify-banner {
  background: linear-gradient(135deg, #3369a7 0%, #357abd 100%);
  border-radius: 15px;
  padding: 60px 40px;
  color: white;
  position: relative;
  overflow: hidden;
}

.content {
  padding-left: 20px;
  padding-right: 20px;
}

.banner-title {
  font-size: 1.9rem;
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 20px;
}

.banner-description {
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 30px;
  opacity: 0.95;
}

.highlight {
  color: #ffd700;
  font-weight: 600;
}

.soalin-btn {
  padding: 15px 30px;
  border: none;
  border-radius: 50px;
  font-size: 1.1rem;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}


.col-lg-6 img {
  width: 100%;
  height: auto;
  max-width: 400px;
}

.store-trend-categories {
    background-color: #f8f9fa;
    margin-top: 0px;
    margin: 0 !important;
  padding-bottom: 0 !important;
}

.university-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
    height: 100%;
    text-decoration: none;
    color: inherit;
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.university-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    text-decoration: none;
    color: inherit;
}

.university-image-container {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    overflow: hidden;
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
    flex-shrink: 0;
}

.university-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}

.university-name {
    font-size: 0.9rem;
    font-weight: 600;
    color: #2c3e50;
    line-height: 1.3;
    margin: 0;
    word-wrap: break-word;
    hyphens: auto;
    flex-grow: 1;
    display: flex;
    align-items: center;
}

.section-title {
    color: #2c3e50;
    font-weight: 700;
    margin-bottom: 2rem;
    font-size: 1.8rem;
}

/* Responsive grid dengan justify-content-center untuk centering */
.universities-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 1.5rem;
}

.university-item {
    flex: 0 0 auto;
    width: 180px;
    max-width: 100%;
}

 .features-section {
            padding: 80px 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 15px;
            padding: 20px 30px;
            height: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            color: #333;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px auto;
            font-size: 2rem;
            color: white;
        }
        
        .feature-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
            line-height: 1.3;
            height: 3.6rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .feature-desc {
            font-size: 0.95rem;
            line-height: 1.6;
            color: #666;
            margin: 0;
        }

        .feature-icon {
    font-size: 48px; /* atau berapa pun yang kamu mau */
}

/* Media queries untuk responsivitas */
@media (max-width: 576px) {
    .university-item {
        width: 150px;
    }
    
    .university-image-container {
        width: 60px;
        height: 60px;
    }
    
    .university-name {
        font-size: 0.8rem;
    }
    
    .universities-grid {
        gap: 1rem;
    }
    
    .section-title {
        font-size: 1.5rem;
    }
}

        
        
        @media (max-width: 768px) {
            .feature-card {
                margin-bottom: 30px;
            }
        }

@media (min-width: 577px) and (max-width: 768px) {
    .university-item {
        width: 160px;
    }
}

@media (min-width: 769px) and (max-width: 992px) {
    .university-item {
        width: 170px;
    }
}

@media (min-width: 1200px) {
    .university-item {
        width: 200px;
    }
    
    .university-image-container {
        width: 90px;
        height: 90px;
    }
}


/* Responsive Design */
@media (max-width: 768px) {
  .pahamify-banner {
    padding: 40px 20px;
    text-align: center;
  }
  
  .banner-title {
    font-size: 1.8rem;
  }
  
  .banner-description {
    font-size: 1rem;
  }
}

@media (max-width: 768px) {
  .col-lg-6 img {
    max-width: 80%;
    margin: 0 auto;
  }
}

@media (max-width: 576px) {
  .col-lg-6 img {
    margin-top: 30px;
  }
}
</style>
@section('content')
   <!-- Page Content -->
 <div class="page-content page-home">
 <section class="store-carousel">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div class="pahamify-banner">
          <div class="row align-items-center">
            <div class="col-lg-6">
              <div class="content">
                <h2 class="banner-title">
                  Latih dan Ukur Pemahamanmu dengan Bank Soal SoalIN!
                </h2>
                <p class="banner-description">
                  Dapetin <span class="highlight">ratusan</span> bank soal lengkap dan tryout untuk latih pemahamanmu 
                  hadapi <span class="highlight">SNBT</span>. Kamu bisa tau pemahaman materi 
                  mana yang perlu kamu tingkatin dan siap bersaing dengan siswa 
                  di seluruh penjuru Indonesia.
                </p>
                <a href="{{ route('bank-soal') }}" class="btn soalin-btn" style="background-color: #dee2e6;">
                  Kerjain Bank Soal Sekarang
                </a>
              </div>
            </div>
           <div class="col-lg-6 d-flex justify-content-center">
  <img src="/images/img-bank-soal-hero.svg" alt="">
</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<section class="store-trend-categories pt-0 pb-4">
    <div class="container">
        <div class="row mb-3">
            <div class="col-12 text-center" data-aos="fade-up">
                <h2 class="section-title mt-4">Universitas Terfavorit</h2>
            </div>
        </div>
        
        <div class="universities-grid mb-3">
            @foreach($universities as $university)
            <div class="university-item">
                <a href="#" class="university-card">
                    <div class="university-image-container">
                        <img src="{{ asset('storage/' . $university->photo) }}" 
                             alt="{{ $university->name }}" 
                             class="university-img">
                             
                    </div>
                    <p class="university-name">{{ $university->name }}</p>
                </a>
            </div>
            @endforeach
        </div>
    </div>
</section>

  <section class="store-new-products">
    <div class="container">
            <div class="row">
                <div class="col-12 text-center pt-4 pb-2">
                    <h2 class="section-title">Apa aja sih fitur unggulan aplikasi kami?</h2>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            📚
                        </div>
                        <h4 class="feature-title">Bank Soal Lengkap</h4>
                        <p class="feature-desc">Ribuan soal berkualitas dari berbagai mata pelajaran untuk masuk perguruan tinggi</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            ⏱️
                        </div>
                        <h4 class="feature-title">Tryout</h4>
                        <p class="feature-desc">Latihan tryout dengan sistem penilaian yang akurat sesuai standar SNBT</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            🤖
                        </div>
                        <h4 class="feature-title">Evaluasi AI</h4>
                        <p class="feature-desc">Analisis kompetensi mendalam dengan teknologi AI untuk identifikasi kekuatan dan kelemahan</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            🎓
                        </div>
                        <h4 class="feature-title">Rekomendasi Jurusan AI</h4>
                        <p class="feature-desc">Dapatkan rekomendasi jurusan kuliah terbaik dengan teknologi AI berdasarkan hasil tryout dan minat kamu</p>
                    </div>
                </div>
            </div>
        </div>
  </section>

   <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</div>

 {{-- footer --}}
 @include('includes.footer')

@endsection

