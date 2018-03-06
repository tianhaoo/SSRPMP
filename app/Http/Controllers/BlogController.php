<?php

namespace App\Http\Controllers;

use App\Post;
use Illuminate\Http\Request;

class BlogController extends Controller
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

    //
    public function index(){

    	$posts = Post::simplePaginate(4);
    	return view('blog', ['posts' => $posts]);
    }

    public function show($slug){
    	$post = Post::findBySlug($slug);
    	return view('post.show', ['post' => $post]);
    }

}
