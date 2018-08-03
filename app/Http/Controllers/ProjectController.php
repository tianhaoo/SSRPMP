<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Project;

class ProjectController extends Controller
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
     * read project detail.
     *
     * @return void
     */    
    public function read()
    {
    	return view('project.read');
    }
	 /**
	 * edit project detail.
	 *
	 * @return void
	 */
	 public function edit()
	 {
	 	return view('project.edit');
	 }
	 /**
	 * show my project.
	 *
	 * @return void
	 */	 
	 public function myproject()
	 {
	 	$projects = Project::all();
	 	return view('project.myproject',['projects' => $projects]);

	 }

	 /**
	 * add a new project.
	 *
	 * @return void
	 */	 
	 public function add()
	 {
	 	return view('project.add');
	 }
	 	 /**
	 * browse project.
	 *
	 * @return void
	 */	 
	 public function browse()
	 { 
	 	$projects = Project::all();
	 	return view('project.browse',['projects' => $projects]);
	 }



}
