<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    //
    public static function findBySlug($slug)
    {
    	return static::where('slug',$slug)->first();
    }

    public function author(){
    	return $this->belongsTo(User::class, 'author_id');
    }
}
