<!-- Navigation -->

<style>
  /* Dropdown on hover */
.navbar-nav .dropdown:hover > .dropdown-menu {
    display: block;
    margin-top: 0; /* biar ga kelempar jauh */


}
/* ISOLASI LOGO - Tidak mempengaruhi elemen lain */
.navbar-brand {
    display: flex;
    margin: 10px 0;
    align-items: center;
    height: 50px; /* Tinggi tetap untuk brand container */
    overflow: hidden; /* Sembunyikan bagian logo yang overflow */
}
.navbar-logo {
    /* Logo bisa diubah ukuran sesuka hati tanpa ganggu layout */
    height: 150px; /* Ubah sesuai kebutuhan */
    width: auto;
    max-height: none; /* Hilangkan batasan */
    max-width: none; /* Hilangkan batasan */
    
    /* Posisioning untuk isolasi */
    object-fit: contain;
    flex-shrink: 0; /* Logo tidak mengecil saat container sempit */
}


</style>
<nav
class="navbar navbar-expand-lg navbar-light navbar-store fixed-top navbar-fixed-top"
data-aos="fade-down"
>
<div class="container">
  <a class="navbar-brand" href="{{ route('home') }}">
   <img src="/images/logo snbt.svg" alt="Logo SNBT" class="navbar-logo" />
  </a>
  <button
    class="navbar-toggler"
    type="button"
    data-toggle="collapse"
    data-target="#navbarResponsive"
    aria-controls="navbarResponsive"
    aria-expanded="false"
    aria-label="Toggle navigation"
  >
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarResponsive">
    <ul class="navbar-nav ml-auto">
      <li class="nav-item active">
        <a class="nav-link" href="{{ route('home') }}">Beranda </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="{{ route('bank-soal') }}">Bank Soal</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="{{ route('tryout') }}">Try Out</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="{{ route('categories') }}">Blog</a>
      </li>
      {{-- <ul class="navbar-nav d-none d-lg-flex">
        <li class="nav-item dropdown">
          <a
            class="nav-link"
            href="#"
            id="navbarDropdown"
            role="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
           Panduan
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="{{ route('dashboard') }}">SNBT</a>
            <a class="dropdown-item" href="{{ route('dashboard-settings-account') }}"
              >UM UGM</a
            >
            <div class="dropdown-divider"></div>
            
          </div>
        </li>
       
      </ul> --}}
  
      <!-- Mobile Menu -->
      <ul class="navbar-nav d-block d-lg-none">
        <li class="nav-item">
          <a class="nav-link" href="#">
            {{-- Hi, {{ Auth::user()->name }} --}}
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link d-inline-block" href="">>
            Cart
          </a>
        </li>
      </ul>
     @guest
    <li class="nav-item">
      <a
  class="btn nav-link px-4 text-white"
  href="{{ route('login') }}"
  style="background-color: #1A4F80;">
  Log In
</a>
      
    </li>
     @endguest
    </ul>

    @auth
      <!-- Desktop Menu -->
     <ul class="navbar-nav d-none d-lg-flex">
      <li class="nav-item dropdown">
  <a
    class="nav-link dropdown-toggle"
    href="#"
    id="navbarDropdown"
    role="button"
    aria-haspopup="true"
  >
    <img
      src="/images/icon-user.png"
      alt=""
      class="rounded-circle mr-2 profile-picture"
    />
    Hi, {{ Auth::user()->username }}
  </a>
  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
    <a class="dropdown-item" href="{{ route('dashboard') }}">Dashboard</a>
    <a class="dropdown-item" href="{{ route('dashboard-settings-account') }}">Settings</a>
    <div class="dropdown-divider"></div>
    <a class="dropdown-item" href="{{ route('logout') }}"
       onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
       Logout
    </a>
  </div>
</li>
    </ul>

    <!-- Mobile Menu -->
    <ul class="navbar-nav d-block d-lg-none">
      <li class="nav-item">
        <a class="nav-link" href="#">
          Hi, {{ Auth::user()->name }}
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-inline-block" href="">>
          Cart
        </a>
      </li>
    </ul>
    @endauth
  </div>
</div>
</nav>

<!-- Logout Form -->
<form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
  @csrf
</form>
