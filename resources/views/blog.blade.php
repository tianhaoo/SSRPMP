@extends('layouts.blog')

@section('blogheader')
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
        <div class="site-heading">
          <h1>通知发文</h1>
          <span class="subheading">notifications</span>
        </div>
      </div>
    </div>
  </div>
@stop

@section('blogcontent')

<div class="row">
  <div class="col-lg-8 col-md-10 mx-auto">
    @foreach($posts as $post)
        @include('partials.post', ['post' => $post])
    @endforeach

    
    {{ $posts->Links() }}

  </div>
</div>

@stop