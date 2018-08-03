<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class FundsController extends Controller
{
    //
    public function browse()
    {
    	return view('funds.browse');
    }

    public function approved()
    {
    	return view('funds.approved');
    }

    public function approving()
    {
    	return view('funds.approving');
    }

    public function detail()
    {
    	return view('funds.detail');
    }

    public function edit()
    {
    	return view('funds.edit');
    }
}
