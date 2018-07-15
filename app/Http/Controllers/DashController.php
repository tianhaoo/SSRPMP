<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DashController extends Controller
{
    //
    public function index()
    {
    	$total = \App\User::all()->count();

    	return view('dashboard',['total'=> $total]);
    }
}
