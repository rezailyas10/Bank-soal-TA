@extends('layouts.app')

@section('title', $blog->title)

@section('content')
<div class="container" style="margin-top: 100px">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-light rounded-pill px-4 py-2 mb-0">
            <li class="breadcrumb-item">
                <a href="{{ route('home') }}" class="text-decoration-none">
                    <i class="fas fa-home me-1"></i>Home
                </a>
            </li>
            <li class="breadcrumb-item">
                <a href="{{ route('blog') }}" class="text-decoration-none">Blog</a>
            </li>
            <li class="breadcrumb-item active fw-semibold" aria-current="page">
                {{ Str::limit($blog->title, 30) }}
            </li>
        </ol>
    </nav>

    <div class="row g-5">
        <!-- Main Content -->
        <div class="col-lg-8">
            <!-- Article Header -->
            <header class="article-header mb-5">
                <div class="mb-3">
                    <span class="badge badge-category {{ $blog->category == 'panduan' ? 'bg-success' : 'bg-primary' }} mb-3">
                        {{ $blog->category == 'panduan' ? '📚 Panduan' : '📰 Artikel' }}
                    </span>
                </div>
                
                <h1 class="article-title display-5 fw-bold mb-4 lh-base">{{ $blog->title }}</h1>
                
                <div class="article-meta d-flex flex-wrap align-items-center mb-4">
                    <div class="author-info d-flex align-items-center me-4 mb-2">
                        <div class="author-avatar me-3">
                            <div class="rounded-circle bg-primary d-flex align-items-center justify-content-center" 
                                 style="width: 48px; height: 48px;">
                                <span class="text-white fw-bold">
                                    {{ substr($blog->author, 0, 1) }}
                                </span>
                            </div>
                        </div>
                        <div>
                            <div class="fw-semibold text-dark">{{ $blog->author }}</div>
                            <small class="text-muted">Author</small>
                        </div>
                    </div>
                    
                    <div class="meta-items d-flex flex-wrap">
                        <div class="meta-item me-4 mb-2">
                            <i class="fas fa-calendar text-primary me-2"></i>
                            <span class="text-muted">{{ $blog->formatted_date }}</span>
                        </div>
                        <div class="meta-item me-4 mb-2">
                            <i class="fas fa-clock text-primary me-2"></i>
                            <span class="text-muted">{!! ceil(str_word_count(strip_tags($blog->content)) / 200) !!} min read</span>
                        </div>
                        <div class="meta-item mb-2">
                            <i class="fas fa-eye text-primary me-2"></i>
                            <span class="text-muted">{{ rand(100, 1000) }} views</span>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Featured Image -->
            <div class="featured-image mb-5">
                <div class="position-relative rounded-4 overflow-hidden shadow-lg">
                    <img src="{{ asset('storage/' . $blog->cover) }}" alt="{{ $blog->title }}" 
                         class="img-fluid w-100" 
                         alt="{{ $blog->title }}"
                         style="height: 400px; object-fit: cover;">
                    <div class="image-overlay position-absolute bottom-0 start-0 end-0 p-4">
                        <div class="bg-dark bg-opacity-50 rounded-3 p-3 text-white">
                            <small>
                                <i class="fas fa-camera me-2"></i>
                                Cover Image - {{ $blog->title }}
                            </small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Article Content -->
            <article class="article-content">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-5">
                        <div class="content-body">
                            {!!$blog->content !!}
                        </div>
                    </div>
                </div>
            </article>

            <!-- Article Footer -->
            <footer class="article-footer mt-5">
                <!-- Tags -->
                <div class="article-tags mb-4">
                    <h6 class="fw-semibold mb-3">Tags:</h6>
                    <div class="d-flex flex-wrap gap-2">
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill">
                            {{ $blog->category_label }}
                        </span>
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill">
                            Tutorial
                        </span>
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill">
                            Tips
                        </span>
                    </div>
                </div>

                <!-- Share Buttons -->
                <div class="share-section">
                    <div class="card border-0 bg-light rounded-4">
                        <div class="card-body p-4">
                            <h6 class="fw-semibold mb-3">
                                <i class="fas fa-share-alt me-2 text-primary"></i>
                                Bagikan Artikel Ini
                            </h6>
                            <div class="d-flex flex-wrap gap-2">
                                <a href="https://www.facebook.com/sharer/sharer.php?u={{ urlencode(request()->fullUrl()) }}" 
                                   target="_blank" class="btn btn-facebook btn-sm rounded-pill px-4">
                                    <i class="fab fa-facebook-f me-2"></i>Facebook
                                </a>
                                <a href="https://twitter.com/intent/tweet?url={{ urlencode(request()->fullUrl()) }}&text={{ urlencode($blog->title) }}" 
                                   target="_blank" class="btn btn-twitter btn-sm rounded-pill px-4">
                                    <i class="fab fa-twitter me-2"></i>Twitter
                                </a>
                                <a href="https://www.linkedin.com/sharing/share-offsite/?url={{ urlencode(request()->fullUrl()) }}" 
                                   target="_blank" class="btn btn-linkedin btn-sm rounded-pill px-4">
                                    <i class="fab fa-linkedin me-2"></i>LinkedIn
                                </a>
                                <a href="https://wa.me/?text={{ urlencode($blog->title . ' - ' . request()->fullUrl()) }}" 
                                   target="_blank" class="btn btn-whatsapp btn-sm rounded-pill px-4">
                                    <i class="fab fa-whatsapp me-2"></i>WhatsApp
                                </a>
                                <button onclick="copyToClipboard('{{ request()->fullUrl() }}')" 
                                        class="btn btn-outline-secondary btn-sm rounded-pill px-4">
                                    <i class="fas fa-link me-2"></i>Copy Link
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

            <!-- Navigation -->
            <div class="article-navigation mt-5">
                <div class="d-flex justify-content-between align-items-center">
                    <a href="{{ route('blog') }}" class="btn btn-outline-primary rounded-pill px-4">
                        <i class="fas fa-arrow-left me-2"></i>Kembali ke Blog
                    </a>
                    
                    <div class="scroll-top">
                        <button onclick="scrollToTop()" class="btn btn-light rounded-circle" style="width: 48px; height: 48px;">
                            <i class="fas fa-arrow-up"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Related Articles -->
            @if($relatedBlogs->count() > 0)
                <div class="sidebar-widget mb-5">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white border-0 p-4">
                            <h5 class="card-title mb-0 fw-bold">
                                <i class="fas fa-newspaper text-primary me-2"></i>
                                Artikel Terkait
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            @foreach($relatedBlogs as $related)
                                <article class="related-article mb-4 {{ !$loop->last ? 'border-bottom pb-4' : '' }}">
                                    <div class="row g-3">
                                        <div class="col-4">
                                            <div class="related-image rounded-3 overflow-hidden">
                                                <img src="{{ $related->cover_url }}" 
                                                     alt="{{ $related->title }}"
                                                     class="img-fluid w-100" 
                                                     style="height: 80px; object-fit: cover;">
                                            </div>
                                        </div>
                                        <div class="col-8">
                                            <h6 class="mb-2 lh-base">
                                                <a href="{{ route('blog-show', $related->slug) }}" 
                                                   class="text-decoration-none text-dark related-title">
                                                    {{ Str::limit($related->title, 60) }}
                                                </a>
                                            </h6>
                                            <div class="related-meta">
                                                <small class="text-muted d-block">
                                                    <i class="fas fa-calendar me-1"></i>
                                                    {{ $related->formatted_date }}
                                                </small>
                                                <small class="text-muted">
                                                    <i class="fas fa-user me-1"></i>
                                                    {{ $related->author }}
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            @endforeach
                        </div>
                    </div>
                </div>
            @endif

            <!-- Categories -->
            <div class="sidebar-widget mb-5">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 p-4">
                        <h5 class="card-title mb-0 fw-bold">
                            <i class="fas fa-folder text-primary me-2"></i>
                            Kategori
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-grid gap-3">
                            <a href="{{ route('blog', ['category' => 'panduan']) }}" 
                               class="category-link d-flex justify-content-between align-items-center p-3 text-decoration-none border rounded-3 bg-light">
                                <div class="d-flex align-items-center">
                                    <div class="category-icon me-3">
                                        <i class="fas fa-book text-success"></i>
                                    </div>
                                    <div>
                                        <div class="fw-semibold text-dark">Panduan</div>
                                        <small class="text-muted">Tutorial lengkap</small>
                                    </div>
                                </div>
                                <i class="fas fa-arrow-right text-muted"></i>
                            </a>
                            <a href="{{ route('blog', ['category' => 'artikel']) }}" 
                               class="category-link d-flex justify-content-between align-items-center p-3 text-decoration-none border rounded-3 bg-light">
                                <div class="d-flex align-items-center">
                                    <div class="category-icon me-3">
                                        <i class="fas fa-newspaper text-primary"></i>
                                    </div>
                                    <div>
                                        <div class="fw-semibold text-dark">Artikel</div>
                                        <small class="text-muted">Berita & tips</small>
                                    </div>
                                </div>
                                <i class="fas fa-arrow-right text-muted"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Newsletter -->
            <div class="sidebar-widget">
                <div class="card border-0 shadow-sm rounded-4" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                    <div class="card-body p-4 text-white text-center">
                        <i class="fas fa-envelope fa-2x mb-3 opacity-75"></i>
                        <h5 class="fw-bold mb-3">Subscribe Newsletter</h5>
                        <p class="mb-4 opacity-90">Dapatkan artikel terbaru langsung ke email Anda</p>
                        <div class="input-group mb-3">
                            <input type="email" class="form-control border-0" placeholder="Email Anda...">
                            <button class="btn btn-light text-primary fw-semibold px-4" type="button">
                                Subscribe
                            </button>
                        </div>
                        <small class="opacity-75">Gratis dan tanpa spam</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('styles')
<style>
    .article-title {
        color: #2c3e50;
        line-height: 1.3;
    }
    
    .badge-category {
        font-size: 0.875rem;
        padding: 0.6rem 1rem;
        border-radius: 25px;
        letter-spacing: 0.5px;
    }
    
    .author-avatar {
        transition: transform 0.3s ease;
    }
    
    .author-avatar:hover {
        transform: scale(1.05);
    }
    
    .featured-image {
        transition: transform 0.3s ease;
    }
    
    .featured-image:hover {
        transform: translateY(-5px);
    }
    
    .image-overlay {
        background: linear-gradient(transparent, rgba(0,0,0,0.7));
    }
    
    .content-body {
        font-size: 1.125rem;
        line-height: 1.8;
        color: #2c3e50;
    }
    
    .content-body p {
        margin-bottom: 1.5rem;
    }
    
    .related-title {
        transition: color 0.3s ease;
        font-size: 0.9rem;
        line-height: 1.4;
    }
    
    .related-title:hover {
        color: #0d6efd !important;
    }
    
    .related-image {
        transition: transform 0.3s ease;
    }
    
    .related-article:hover .related-image {
        transform: scale(1.05);
    }
    
    .category-link {
        transition: all 0.3s ease;
    }
    
    .category-link:hover {
        background: #e9ecef !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    
    .btn-facebook {
        background: #1877f2;
        border-color: #1877f2;
        color: white;
    }
    
    .btn-facebook:hover {
        background: #166fe5;
        border-color: #166fe5;
    }
    
    .btn-twitter {
        background: #1da1f2;
        border-color: #1da1f2;
        color: white;
    }
    
    .btn-twitter:hover {
        background: #0d8bd9;
        border-color: #0d8bd9;
        color: white;
    }
    
    .btn-linkedin {
        background: #0077b5;
        border-color: #0077b5;
        color: white;
    }
    
    .btn-linkedin:hover {
        background: #005885;
        border-color: #005885;
        color: white;
    }
    
    .btn-whatsapp {
        background: #25d366;
        border-color: #25d366;
        color: white;
    }
    
    .btn-whatsapp:hover {
        background: #1ab851;
        border-color: #1ab851;
        color: white;
    }
    
    .card {
        transition: all 0.3s ease;
    }
    
    .sidebar-widget .card:hover {
        transform: translateY(-5px);
    }
    
    .scroll-top button {
        transition: all 0.3s ease;
    }
    
    .scroll-top button:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    .breadcrumb-item + .breadcrumb-item::before {
        content: "→";
        color: #6c757d;
    }
    
    .meta-item {
        font-size: 0.9rem;
    }
    
    @media (max-width: 768px) {
        .article-title {
            font-size: 2rem;
        }
        
        .featured-image img {
            height: 250px !important;
        }
        
        .content-body {
            font-size: 1rem;
        }
        
        .author-info {
            flex-direction: column;
            text-align: center;
            margin-bottom: 1rem !important;
        }
        
        .meta-items {
            justify-content: center;
        }
    }
</style>
@endpush

@push('scripts')
<script>
    function copyToClipboard(text) {
        navigator.clipboard.writeText(text).then(function() {
            // Create toast notification
            showToast('Link berhasil disalin!', 'success');
        }).catch(function(err) {
            console.error('Could not copy text: ', err);
            showToast('Gagal menyalin link', 'error');
        });
    }
    
    function showToast(message, type) {
        const toast = document.createElement('div');
        toast.className = `toast-notification ${type}`;
        toast.innerHTML = `
            <div class="toast-content">
                <i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
                <span>${message}</span>
            </div>
        `;
        
        // Add styles
        toast.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            padding: 12px 20px;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            transform: translateX(100%);
            transition: transform 0.3s ease;
            ${type === 'success' ? 'background: #28a745;' : 'background: #dc3545;'}
        `;
        
        document.body.appendChild(toast);
        
        // Animate in
        setTimeout(() => {
            toast.style.transform = 'translateX(0)';
        }, 100);
        
        // Animate out and remove
        setTimeout(() => {
            toast.style.transform = 'translateX(100%)';
            setTimeout(() => {
                document.body.removeChild(toast);
            }, 300);
        }, 3000);
    }
    
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
    
    // Show/hide scroll to top button
    window.addEventListener('scroll', function() {
        const scrollButton = document.querySelector('.scroll-top button');
        if (window.pageYOffset > 300) {
            scrollButton.style.opacity = '1';
            scrollButton.style.visibility = 'visible';
        } else {
            scrollButton.style.opacity = '0';
            scrollButton.style.visibility = 'hidden';
        }
    });
    
    // Reading progress indicator
    window.addEventListener('scroll', function() {
        const article = document.querySelector('.article-content');
        if (article) {
            const articleTop = article.offsetTop;
            const articleHeight = article.offsetHeight;
            const windowHeight = window.innerHeight;
            const scrollTop = window.pageYOffset;
            
            const progress = Math.max(0, Math.min(100, 
                ((scrollTop - articleTop + windowHeight) / articleHeight) * 100
            ));
            
            // You can add a progress bar here if needed
        }
    });
</script>
@endpush