@extends('layouts.dashboard')

@section('title')
  Account Setting
@endsection

@section('content')
<div class="section-content section-dashboard-home" data-aos="fade-up">
  <div class="container-fluid">
    <div class="dashboard-heading">
      <h2 class="dashboard-title">My Account</h2>
      <p class="dashboard-subtitle">
        Update your current profile
      </p>
    </div>
    <div class="dashboard-content">
      <div class="row">
        <div class="col-10">
          <form action="{{ route('dashboard-settings-redirect', 'dashboard-settings-account') }}" method="POST" enctype="multipart/form-data" id="locations">
            @csrf
            <div class="card">
              <div class="card-body">
                <!-- Your Name & Email -->
                <div class="row mb-2">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="name">Your Name</label>
                      <input
                        type="text"
                        class="form-control"
                        id="name"
                        name="name"
                        value="{{ $user->name }}"
                      />
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="name">Username</label>
                      <input
                        type="text"
                        class="form-control"
                        id="username"
                        name="username"
                        value="{{ $user->username }}"
                      />
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <label for="email">Your Email</label>
                      <input
                        type="email"
                        class="form-control"
                        id="email"
                        name="email"
                        value="{{ $user->email }}"
                      />
                    </div>
                  </div>
                </div>
                {{-- <!-- Password -->
                <div class="row mb-2">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="password">Your Password</label>
                      <input
                        type="password"
                        class="form-control"
                        id="password"
                        name="password"
                      />
                      <small>Kosongan jika tidak ingin mengganti password</small>
                    </div>
                  </div>
                </div> --}}
                <!-- Combined Address Field -->
                
                <div class="row mb-2">
                  <div class="col-md-12">
                    <div class="form-group">
                      <label for="mobile">Mobile</label>
                      <input
                        type="text"
                        class="form-control"
                        id="mobile"
                        name="phone_number"
                        value="{{ $user->phone_number }}"
                      />
                    </div>
                  </div>
                </div>
                <!-- Submit Button -->
                <div class="row">
                  <div class="col text-right">
                    <button type="submit" class="btn btn-success px-5">
                      Save Now
                    </button>
                  </div>
                </div>
              </div>
            </div>
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
  var locations = new Vue({
    el: "#locations",
    mounted() {
      AOS.init();
      this.getProvince();
      // Inisialisasi nilai-nilai default
      this.provinces_id = '{{ $user->province_id }}';
    },
    data: {
      provinces: null,
      regencies: null,
      districts: null,
      villages: null,
      provinces_id: null,
      regencies_id: null,
      districts_id: null,
      villages_id: null,
    },
    methods: {
      getProvince() {
        var self = this;
        axios.get('{{ route('api-provinces') }}')
          .then((response) => {
            self.provinces = response.data;
            // Set nilai provinces_id jika ada, dan panggil getRegency()
            if (self.provinces_id) {
              self.getRegency();
              this.regencies_id = '{{ $user->regencies_id }}';
            }
          })
          .catch((error) => {
            console.error('Error fetching provinces:', error);
          });
      },
      getRegency() {
        var self = this;
        axios.get('{{ route('api-regencies', '') }}/' + self.provinces_id)
          .then((response) => {
            self.regencies = response.data;
            if (self.regencies_id) {
              self.getDistrict();
              this.districts_id = '{{ $user->district_id }}';
            }
          })
          .catch((error) => {
            console.error('Error fetching regencies:', error);
          });
      },
      getDistrict() {
        var self = this;
        axios.get('{{ route('api-districts', '') }}/' + self.regencies_id)
          .then((response) => {
            self.districts = response.data;
            if (self.districts_id) {
              self.getVillage();
              this.villages_id = '{{ $user->village_id }}';
            }
          })
          .catch((error) => {
            console.error('Error fetching districts:', error);
          });
      },
      getVillage() {
        var self = this;
        axios.get('{{ route('api-villages', '') }}/' + self.districts_id)
          .then((response) => {
            self.villages = response.data;
          })
          .catch((error) => {
            console.error('Error fetching villages:', error);
          });
      }
    },
    watch: {
      provinces_id(val) {
        this.regencies_id = null;
        this.districts_id = null;
        this.villages_id = null;
        if (val) {
          this.getRegency();
        }
      },
      regencies_id(val) {
        this.districts_id = null;
        this.villages_id = null;
        if (val) {
          this.getDistrict();
        }
      },
      districts_id(val) {
        this.villages_id = null;
        if (val) {
          this.getVillage();
        }
      }
    }
  });
</script>
@endpush
