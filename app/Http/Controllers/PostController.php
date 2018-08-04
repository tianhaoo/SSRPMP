<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Post;

class PostController extends Controller
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
    	return view('post.post', ['posts' => $posts]);
    }

    public function show($slug){
    	$post = Post::findBySlug($slug);
    	return view('post.single', ['post' => $post]);
    }
}
