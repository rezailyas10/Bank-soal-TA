@extends('layouts.auth')

@section('content')

  <!-- Page Content -->
  <div class="page-content page-auth mt-5" id="register">
    <div class="section-store-auth" data-aos="fade-up">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-4">
            <h2>
              Daftar Sekarang & <br />
              Mulai Persiapan SNBT-mu!
            </h2>
            <form method="POST" class="mt-3" action="{{ route('register') }}">
              @csrf

              <div class="form-group">
                <label>Full Name</label>
                <input id="name" v-model="name" type="text" class="form-control @error('name') is-invalid @enderror" name="name" value="{{ old('name') }}" required autocomplete="name" autofocus>
                @error('name')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
              </div>
              <div class="form-group">
                <label>Username</label>
                <input id="username" v-model="username" type="text" class="form-control @error('username') is-invalid @enderror" name="username" value="{{ old('username') }}" required autocomplete="username" autofocus>
                @error('username')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
              </div>
              <div class="form-group">
                <label>Email</label>
                <input id="email" type="email" v-model="email" @change="checkEmail" class="form-control @error('email') is-invalid @enderror" :class="{'is-invalid': email_unavailable}" name="email" value="{{ old('email') }}" required autocomplete="email">
                @error('email')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
              </div>
              <div class="form-group">
                <label>Password</label>
                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="new-password">
                @error('password')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
              </div>
              <div class="form-group">
                <label>Confirm Password</label>
                <input id="password-confirm" type="password" class="form-control @error('password_confirmation') is-invalid @enderror" name="password_confirmation" required autocomplete="new-password">
                @error('password_confirmation')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
              </div>
              
              <button type="submit" :disabled="email_unavailable" class="btn btn-block mt-4 text-light" style="background-color: #1A4F80;">
                Sign Up Now
              </button>
              <a href="{{ route('login', ['redirect_to' => url()->current()]) }}" class="btn btn-signup btn-block mt-2">
                Back to Sign In
              </a>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

@endsection

@push('addon-script')
<script src="/vendor/vue/vue.js"></script>
<script src="https://unpkg.com/vue-toasted"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
  Vue.use(Toasted);

  var register = new Vue({
    el: "#register",
    mounted() {
      AOS.init();
    },
    data() {
      return {
        name: "",
        username: "",
        email: "",
        password: "",
        email_unavailable: false,
      }
    },
    methods: {
      checkEmail() {
        var self = this;
        axios.get('{{ route('api-register-check') }}', {
          params: {
            email: this.email
          }
        })
        .then(function (response) {
          if (response.data == 'Unavailable') {
            self.$toasted.show(
              "Email bisa didaftar",
              {
                position: "top-center",
                className: "rounded",
                duration: 1000,
              }
            );
            self.email_unavailable = false;
          } else {
            self.$toasted.error(
              "Maaf, tampaknya email sudah terdaftar pada sistem kami.",
              {
                position: "top-center",
                className: "rounded",
                duration: 1000,
              }
            );
            self.email_unavailable = true;
          }
        })
        .catch(function (error) {
          console.log(error);
        });
      }
    }
  });
</script>
@endpush
