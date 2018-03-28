@extends('layouts.auth')

@section('content')



      <div class="login-box">

        <form class="login-form" method="POST" action="{{ route('login') }}">
            {{ csrf_field() }}

          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>SIGN IN</h3>
          <div class="form-group">
            <label class="control-label">邮箱</label>
            <input id="email" name="email" class="form-control" type="email" placeholder="Your Email" value="{{ old('email') }}" required autofocus>

            @if ($errors->has('email'))
                <span class="help-block">
                    <strong>{{ $errors->first('email') }}</strong>
                </span>
            @endif
          </div>
          <div class="form-group">
            <label class="control-label">密码</label>
            <input id="password" name="password" class="form-control" type="password" placeholder="Password" required>

            @if ($errors->has('password'))
                <span class="help-block">
                    <strong>{{ $errors->first('password') }}</strong>
                </span>
            @endif
          </div>
          <div class="form-group">
            <div class="utility">
              <div class="animated-checkbox">
                <label>
                  <input type="checkbox" name="remember" {{ old('remember') ? 'checked' : '' }}><span class="label-text">Remeber Me</span>
                </label>
              </div>
              <p class="semibold-text mb-2"><a  href="{{ route('password.request') }}" >Forgot Password ?</a></p>
            </div>
          </div>
          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block" type="submit"><i class="fa fa-sign-in fa-lg fa-fw"></i>SIGN IN</button>
          </div>
          <p class="change_link">New to site?
            <a href="{{ route('register') }}" class="to_register"> Create Account </a>
          </p>
        </form>


      </div>

@endsection