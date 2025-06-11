<?php

namespace App\Http\Controllers;

use Exception;
use Midtrans\Snap;

use App\Models\cart;
use Midtrans\Config;
use Midtrans\Notification;

use App\Models\Transaction;

use Illuminate\Http\Request;
use App\Models\TransactionDetail;
use Illuminate\Support\Facades\Auth;

class CheckoutController extends Controller
{
    public function process(Request $request){
        //save user data
        $user = Auth::user();
        $user->update($request->except('total_price'));

        //process checkout
        $code = 'STORE-' . mt_rand(0000000,9999999);
        $carts = Cart::with(['product','user'])
                        ->where('users_id', Auth::user()->id)
                        ->get();

        //transaction create
        $transaction = Transaction::create([
            'users_id' => Auth::user()->id,
            'inscurance_price' => 0,
            'shipping_price' => 0,
            'total_price' => $request->total_price,
            'transaction_status' => 'PENDING',
            'code' => $code,
        ]);
        foreach ($carts as $cart) {
            $trx = 'TRX-' . mt_rand(0000000,9999999);
            TransactionDetail::create([
                'transactions_id' => $transaction->id,
                'products_id' => $cart->product->id,
                'price' => $cart->product->price,
                'total_price' => $request->total_price,
                'shipping_status' => 'PENDING',
                'resi' => '',
                'code' => $trx,
            ]);
        }
        //hapus cart setelah checkout
        Cart::where('users_id',Auth::user()->id)->delete();

        //konfigurasi midtrans

        // Set your Merchant Server Key
            Config::$serverKey = config('services.midtrans.server_key');
            Config::$isProduction = config('services.midtrans.isProduction');
            Config::$isSanitized = config('services.midtrans.isSanitized');
            Config::$is3ds = config('services.midtrans.is3ds');

        // buat array untuk dikirim ke midtrans
        $midtrans = [
            'transaction_details' => [
                'order_id' => $code,
                'gross_amount' => (int) $request->total_price
            ],

            'customer_details' => [
                'first_name' => Auth::user()->name,
                'email' => Auth::user()->email,
            ],
            'enabled_payments' => [
                    "credit_card", "cimb_clicks",
                "bca_klikbca", "bca_klikpay", "bri_epay", "echannel", "permata_va",
                "bca_va", "bni_va", "bri_va","cimb_va", "other_va", "gopay", "indomaret",
                "danamon_online", "akulaku", "shopeepay", "kredivo", "uob_ezpay","other_qris"
            ],

            'vtweb' => []
            ];

            try {
                // Get Snap Payment Page URL
                $paymentUrl = Snap::createTransaction($midtrans)->redirect_url;

                return redirect($paymentUrl);
                
              }
              catch (Exception $e) {
                echo $e->getMessage();
              }
    }
 
    public function callback(Request $request){
        $request->validate([]);

        // set konfigurasi  midtrans
        Config::$serverKey = config('services.midtrans.serverKey');
        Config::$isProduction = config('services.midtrans.isProduction');
        Config::$isSanitized = config('services.midtrans.isSanitized');
        Config::$is3ds = config('services.midtrans.is3ds');


        //instance midtrans notifictaion
        $notif = new Notification();

        //asign variabel
        $status = $notif->transaction_status;
        $type = $notif->payment_type;
        $fraud = $notif->fraud_status;
        $order_id = $notif->order_id;

        //cari transaksi berdasarkan order id
        $transaction = Transaction::findOrFail($order_id);

        //handle notification status
        if ($status == 'capture') {
            if ($type == 'credit_card') {
                if ($fraud == 'challenge') {
                    $transaction->status = 'PENDING';
                    } else {
                        $transaction->status = 'SUCCESS';
                        }
                }
                } elseif ($type == 'settlement') {
                    $transaction->status = 'SUCCESS';
                }
                elseif ($status == 'pending') {
                    $transaction->status = 'PENDING';
                    }
                elseif ($status == 'deny') {
                        $transaction->status = 'FAILED';
                        }
                elseif ($status == 'expire') {
                            $transaction->status = 'FAILED';
                 }
                 elseif ($status == 'cancel') {
                    $transaction->status = 'FAILED';
                    }

            //save transaction
            $transaction->save();
                        
    }
}
