<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;

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
    

     /**
     * Redirect user after login based on their roles.
     */
    protected function authenticated(Request $request, $user)
    {
        switch ($user->roles) {
            case 'ADMIN':
                return redirect()->route('admin-dashboard');
            case 'MITRA':
                return redirect()->route('mitra-dashboard');
            case 'USER':
            default:
                return redirect()->route('home');
        }
    }
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }
}
