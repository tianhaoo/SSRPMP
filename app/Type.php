<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Type extends Model
{
    //
    public function projects()
    {
        return $this->hasMany('App\Project', 'type_id', 'id');
    }
}
