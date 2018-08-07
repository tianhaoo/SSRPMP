<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    // 项目的所有成员
    public function members()
    {
        return $this->belongsToMany('App\User', 'user_projects', 'project_id', 'user_id');
    }

    // 项目的主持人
    public function host()
    {
        return $this->hasMany('App\User', 'user_id', 'id');
    }

    // 项目的资金申请
    public function funds()
    {
        return $this->belongsTo('App\Project', 'project_id', 'id');
    }

}
