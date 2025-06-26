<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
public function showLoginForm(Request $request)
{
    // Simpan intended jika diinginkan dan belum ada:
    $previous = url()->previous();
    $loginUrl = route('login');
    if ($previous !== $loginUrl && !session()->has('url.intended')) {
        session(['url.intended' => $previous]);
    }
    return view('auth.login');
}


     /**
     * Redirect user after login based on their roles.
     */
    protected function authenticated(Request $request, $user)
{
    switch ($user->roles) {
        case 'ADMIN':
            return redirect()->route('admin-dashboard');

        case 'KONTRIBUTOR':
            return redirect()->route('kontributor-dashboard');

        case 'USER':
            $default = route('home');
            return redirect()->intended($default); // hanya USER yang pakai intended

        default:
            return redirect()->route('home'); // fallback kalau role aneh
    }
}

     public function logout(Request $request)
{
       $wasAuthenticated = auth()->check(); // Cek apakah sebelumnya login

    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();

    // Kalau sebelumnya user login (berada di halaman yang butuh login), arahkan ke home
    if ($wasAuthenticated) {
        return redirect()->route('home');
    }

    // Kalau sebelumnya bukan login (misalnya di halaman publik/guest), arahkan balik ke sebelumnya
    return redirect()->back();
}
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }
}
