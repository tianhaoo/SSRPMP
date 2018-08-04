@extends('layouts.post')

@section('title', ' - ' . '{{ $post->title }}')



@section('blogheader')
 <!-- Page Header -->
    <header class="masthead" style="background-image: url('/storage/{{ $post->image }}')">
      <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <div class="post-heading">
              <h1>{{ $post->title }}</h1>
              <h2 class="subheading">{{ $post->sub_title }}</h2>
              <span class="meta">Posted by <a href="#">{{ $post->author->name }}</a> on {{ $post->created_at->format('F d, Y')}}</span>
            </div>
          </div>
        </div>
      </div>
    </header>
@stop

@section('blogcontent')


    <!-- Post Content -->
    <article>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
           {!! $post->body !!}
          </div>
        </div>
      </div>
    </article>




@stop





  </body>

</html>
