@php
    switch (auth()->user()->roles) {
        case 'ADMIN':
            $layout = 'layouts.admin';
            break;
        case 'KONTRIBUTOR':
            $layout = 'layouts.kontributor';
            break;
        case 'USER':
            $layout = 'layouts.dashboard';
            break;
        default:
            $layout = 'layouts.dasboard'; // fallback layout kalau role tidak dikenali
            break;
    }
@endphp

@extends($layout)



@section('title')
  Change Password
@endsection

@section('content')
<div class="section-content section-dashboard-home" data-aos="fade-up">
  <div class="container-fluid">
    <div class="dashboard-heading">
      <h2 class="dashboard-title">Change Password</h2>
      <p class="dashboard-subtitle">Change your password</p>
    </div>
    <div class="dashboard-content">
      <div class="row">
        <div class="col-8 mx-auto">
          <form action="{{ route('dashboard-settings-redirect', 'dashboard-settings-store') }}" method="POST">
            @csrf
            <div class="card">
              <div class="card-body">
                <!-- Old Password -->
                <div class="form-group position-relative">
                  <label for="oldPassword">Old Password</label>
                  <input type="password" class="form-control" id="oldPassword" name="old_password" placeholder="Enter your old password" required />
                  <span toggle="#oldPassword" class="fa fa-fw fa-eye toggle-password"></span>
                  <small id="oldPasswordFeedback" class="form-text text-muted"></small>
                </div>

                <!-- New Password -->
                <div class="form-group position-relative">
                  <label for="newPassword">New Password</label>
                  <input type="password" class="form-control" id="newPassword" name="new_password" placeholder="Enter your new password" required />
                  <span toggle="#newPassword" class="fa fa-fw fa-eye toggle-password"></span>
                  <small id="newPasswordFeedback" class="form-text text-muted">
                    Your password must be at least 8 characters long, contain letters and numbers.
                  </small>
                </div>

                <!-- Confirm New Password -->
                <div class="form-group position-relative">
                  <label for="confirmPassword">Confirm New Password</label>
                  <input type="password" class="form-control" id="confirmPassword" name="confirm_password" placeholder="Confirm your new password" required />
                  <span toggle="#confirmPassword" class="fa fa-fw fa-eye toggle-password"></span>
                  <small id="confirmPasswordFeedback" class="form-text text-muted"></small>
                </div>

                <!-- Submit Button -->
                <div class="row">
                  <div class="col text-right">
                    <button type="submit" class="btn btn-success px-5">Save Now</button>
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
<script>
  document.querySelectorAll('.toggle-password').forEach(element => {
    element.addEventListener('click', function () {
      this.classList.toggle('fa-eye');
      this.classList.toggle('fa-eye-slash');
      let input = document.querySelector(this.getAttribute('toggle'));
      input.type = input.type === 'password' ? 'text' : 'password';
    });
  });

  // Validasi Password
  document.getElementById('newPassword').addEventListener('input', function () {
    let feedback = document.getElementById('newPasswordFeedback');
    let password = this.value;
    let regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    
    if (password.length === 0) {
      feedback.innerText = "Your password must be at least 8 characters long, contain letters and numbers.";
      feedback.style.color = "gray";
    } else if (!regex.test(password)) {
      feedback.innerText = "Password must contain at least 8 characters with letters and numbers.";
      feedback.style.color = "red";
    } else {
      feedback.innerText = "Strong password!";
      feedback.style.color = "green";
    }
  });

  document.getElementById('confirmPassword').addEventListener('input', function () {
    let feedback = document.getElementById('confirmPasswordFeedback');
    let newPassword = document.getElementById('newPassword').value;
    let confirmPassword = this.value;

    if (confirmPassword.length === 0) {
      feedback.innerText = "";
    } else if (newPassword !== confirmPassword) {
      feedback.innerText = "Passwords do not match!";
      feedback.style.color = "red";
    } else {
      feedback.innerText = "Passwords match!";
      feedback.style.color = "green";
    }
  });

  document.getElementById('oldPassword').addEventListener('input', function () {
    let feedback = document.getElementById('oldPasswordFeedback');
    
    if (this.value.length === 0) {
      feedback.innerText = "";
    } else {
      feedback.innerText = "Checking old password...";
      feedback.style.color = "gray";
    }
  });
</script>
@endpush
