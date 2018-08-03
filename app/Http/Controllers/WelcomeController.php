<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Post;

class WelcomeController extends Controller
{
    public function index()
    {
    	$posts = Post::simplePaginate(2);
        return view('welcome',['posts' => $posts]);
    }

    public function show($slug)
    {
    	$post = Post::findBySlug($slug);
    	return view('post.slug',['post' => $post]);
    }
}
