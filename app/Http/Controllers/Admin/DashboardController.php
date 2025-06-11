<?php

namespace App\Http\Controllers\Admin;

use App\Models\User;
use App\Models\Transaction;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
          $user = Auth::user();

        if ($user->roles !== 'ADMIN') {
            return redirect()->back();
        }
     
        return view('pages.admin.dashboard');
    }
    public function mitra()
    {
          $user = Auth::user();

        if ($user->roles !== 'MITRA') {
            return redirect()->back();
        }
     
        return view('pages.mitra.dashboard');
    }
}
