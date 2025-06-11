<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResultLog extends Model
{

    use HasFactory;
    protected $fillable = ['result_id','correct','wrong','score'];

     public function result()
    {
        return $this->belongsTo(Result::class);
    }
}
