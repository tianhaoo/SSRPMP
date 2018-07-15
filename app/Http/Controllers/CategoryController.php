<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CategoryController extends Controller
{
		    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

	 /**
	 * show a new project.
	 *
	 * @return void
	 */	 
	 public function read()
	 {
	 	return view('category.read');
	 }
	 	 /**
	 * add a new project.
	 *
	 * @return void
	 */	 
	 public function add()
	 {
	 	return view('category.add');
	 }
}
