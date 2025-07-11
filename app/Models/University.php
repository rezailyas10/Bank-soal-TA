<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class University extends Model
{
    use HasFactory;

    protected $fillable = [
        'name','photo','slug'
    ];

    protected $hidden = [

    ];

    public function majors(){
        return $this->hasMany(Major::class);
    }


}
