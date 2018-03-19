

<!-- Navigation -->
<nav class="fh5co-nav" role="navigation">
    <div class="top">
      <div class="container">
        <div class="row">
          <div class="col-xs-12 text-right">
            <p class="num">Call: +01 123 456 7890</p>
            <ul class="fh5co-social">
              <li><a href="#"><i class="icon-twitter"></i></a></li>
              <li><a href="#"><i class="icon-dribbble"></i></a></li>
              <li><a href="#"><i class="icon-github"></i></a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="top-menu">
      <div class="container">
        <div class="row">
          <div class="col-xs-1">
            <div id="fh5co-logo"><a href="index.html">SSRPMP<span>.</span></a></div>
          </div>
          <div class="col-xs-11 text-right menu-1">
            <ul>
              <li class="active"><a href="{{ url('/') }}">主页</a></li>
              <li class="has-dropdown">
                <a href="{{ url('/blog') }}">通知发文</a>
                <ul class="dropdown">
                  <li><a href="#">Web Design</a></li>
                  <li><a href="#">eCommerce</a></li>
                  <li><a href="#">Branding</a></li>
                </ul>
              </li>
              <li><a href="{{ url('/admin') }}">后台管理</a></li>
              <li><a href="{{ url('/contact') }}">联系我们</a></li>
              @if(Route::has('login'))
                @auth
                <li class="btn-cta"><a href="{{ url('/admin/profile') }}"><span>{{ Auth::user()->name }}</span></a></li>
                <li class="btn-cta"><a href="{{ route('logout') }}" onclick="event.preventDefault();document.getElementById('logout-form').submit();"><span>退出登录</span></a></li>
                @else
                <li class="btn-cta"><a href="{{ url('/login') }}"><span>登录</span></a></li>
                <li class="btn-cta"><a href="{{ url('/register') }}"><span>注册</span></a></li>
                @endauth
              @endif
              <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                {{ csrf_field() }}
              </form>
          </div>
        </div>
        
      </div>
    </div>
  </nav>
