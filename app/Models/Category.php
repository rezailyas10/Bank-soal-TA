<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Category extends Model
{
    use SoftDeletes;
    use HasFactory;

    protected $fillable = [
        'name','photo','slug'
    ];

    protected $hidden = [

    ];

    public function subCategory(){
        return $this->hasMany(SubCategory::class);
    }


}
