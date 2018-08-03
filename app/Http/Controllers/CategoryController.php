<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Type;

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
	 	$types = Type::all();
	 	return view('category.read',['types' => $types]);
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
