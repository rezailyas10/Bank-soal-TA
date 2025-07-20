<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PasswordReset extends Model
{
    use HasFactory;
    public $timestamps = false; // karena tidak ada created_at/updated_at Laravel
    protected $table = 'password_resets';
    protected $fillable = ['email', 'token', 'created_at'];
}
