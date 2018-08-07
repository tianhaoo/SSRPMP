<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Fund extends Model
{
    //
    public function applyUser()
    {
        return $this->belongsTo('App\User', 'user_id', 'id');
    }

    public function approveUser()
    {
        return $this->belongsTo('App\User', 'approve_id', 'id');
    }

    public function project()
    {
        return $this->belongsTo('App\Project', 'project_id', 'id');
    }
}
