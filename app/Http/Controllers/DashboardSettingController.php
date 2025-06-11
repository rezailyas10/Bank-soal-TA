<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\District;
use App\Models\Province;
use App\Models\Regency;
use App\Models\Village;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DashboardSettingController extends Controller
{
    public function store()
    {
        $user = Auth::user();
        $categories = Category::all();
        $province = Province::all();
        $regency = Regency::all();
        $district = District::all();
        $village = Village::all();
        return view('pages.dashboard.dashboard-settings', [
            'user' => $user,
            'categories' => $categories,
            'province' => $province,
            'regency' => $regency,
            'district' => $district,
            'village' => $village,
        ]);
    }

    public function account()
{
    $user = Auth::user();
    
    // Tentukan view berdasarkan role
    if ($user->roles === 'ADMIN') {
        $view = 'pages.admin.dashboard-account';
    } elseif ($user->roles === 'MITRA') {
        $view = 'pages.mitra.dashboard-account';
    } elseif(($user->roles === 'USER')) {
        $view = 'pages.dashboard.dashboard-account';
    }

    return view($view, [
        'user' => $user
    ]);
}

    public function update(Request $request, $redirect)
{
    try {
        $data = $request->all();

        $item = Auth::user();
        $item->update($data);

        return redirect()->route($redirect)->with('success', 'Data berhasil diperbarui!');
    } catch (\Exception $e) {
        return redirect()->back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage());
    }
}
}
