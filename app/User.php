<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends \TCG\Voyager\Models\User
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    // 作为成员参与的项目，也有可能是主持人
    public function member_projects()
    {
        return $this->belongsToMany('App\Project', 'user_projects', 'user_id', 'project_id');
    }

    // 作为主持人的项目
    public function host_projects()
    {
        return $this->hasMany('App\Project', 'user_id', 'id');
    }

    // 申请的资金
    public function apply_funds()
    {
        return $this->hasMany('App\Fund', 'user_id', 'id');
    }

    // 审批的资金
    public function approve_funds()
    {
        return $this->hasMany('App\Fund', 'approve_id', 'id');
    }

}
