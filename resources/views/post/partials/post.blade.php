<div class="post-preview">
  <a href="/ssrpmp/post/{{ $post->slug }}">
    <h2 class="post-title">
      {{ $post->title }}
    </h2>
    <h3 class="post-subtitle">
      {{ $post->excerpt }}
    </h3>
  </a>
  <p class="post-meta">Posted by
    <a href="#">{{ $post->author->name }}</a>
    on {{ $post->created_at->format('F d, Y')}}</p>
</div>

<hr>