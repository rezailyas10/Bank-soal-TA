@extends('layouts.auth')

@section('title')
    Login
@endsection
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<style>
    img {
        border-top-left-radius: 0;
    border-bottom-left-radius: 0;
    border-top-right-radius: 24px;
    border-bottom-right-radius: 24px;
    }
</style>
@section('content')
    <!-- Page Content -->
    <div class="page-content page-auth">
        <div class="section-store-auth" data-aos="fade-up">
          <div class="container">
            <div class="row align-items-center row-login">
              <div class="col-lg-6 text-center">
                <img
                  src="/images/login.png"
                  alt=""
                  class="w-50 mb-4 mb-lg-none"
                />
              </div>
              <div class="col-lg-5">
                <h2>
                 Belajar Lebih Mudah,  <br />
                  Mulai dari Login
                </h2>
                <form method="POST" action="{{ route('login', ['redirect_to' => url()->current()]) }}" class="mt-3">
                  @csrf
                  <div class="form-group">
                    <label>Email address</label>
                    <input id="email" type="email" class="form-control w-75 @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>

                                @error('email')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                  </div>
                  <div class="form-group">
                    <label>Password</label>
                    <input id="password" type="password" class="form-control w-75 @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">

                                @error('password')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                  </div>
                  <button
                  type="submit"
                    class="btn btn-block w-75 mt-4 text-light"
                    style="background-color: #1A4F80;"
                  >
                    Sign In to My Account
                  </button>
                  <a class="btn btn-signup w-75 mt-2" href="{{ route('register') }}">
                    Sign Up
                  </a>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
<div class="container" style="display: none">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Login') }}</div>

                <div class="card-body">
                    <form method="POST" action="{{ route('login', ['redirect_to' => url()->current()]) }}">
                        @csrf

                        <div class="row mb-3">
                            <label for="email" class="col-md-4 col-form-label text-md-end">{{ __('Email Address') }}</label>

                            <div class="col-md-6">
                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>

                                @error('email')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>


                            <div class="form-group">
                    <label>Password</label>
                    <input id="password" type="password" class="form-control w-75 @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">

                                @error('password')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                  </div>

                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6 offset-md-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>

                                    <label class="form-check-label" for="remember">
                                        {{ __('Remember Me') }}
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-0">
                            <div class="col-md-8 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    {{ __('Login') }}
                                </button>

                                @if (Route::has('password.request'))
                                    <a class="btn btn-link" href="{{ route('password.request') }}">
                                        {{ __('Forgot Your Password?') }}
                                    </a>
                                @endif
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


@endsection
