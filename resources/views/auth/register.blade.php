@extends('layouts.auth')

@section('content')

      <!--register form-->
        <div class="col-md-4">
          <div class="tile">
            <h3 class="tile-title">Register</h3>
            <div class="tile-body">
              <form id="register-form" class="form-horizontal" method="POST" action="{{ route('register') }}">
                {{ csrf_field() }}

                <div class="form-group row">
                  <label class="control-label col-md-4">姓名</label>
                  <div class="col-md-8">
                    <input class="form-control" id="name" type="text" class="form-control" name="name" value="{{ old('name') }}" placeholder="Enter your name" required autofocus>

                    @if ($errors->has('name'))
                        <span class="help-block">
                            <strong>{{ $errors->first('name') }}</strong>
                        </span>
                    @endif
                  </div>
                </div>

                <div class="form-group row">
                  <label class="control-label col-md-4">学号/工号</label>
                  <div class="col-md-8">
                    <input class="form-control" id="stu_id" type="text" class="form-control" name="stu_id" value="{{ old('stu_id') }}" placeholder="Enter your numbers" required>

                    @if ($errors->has('stu_id'))
                        <span class="help-block">
                            <strong>{{ $errors->first('stu_id') }}</strong>
                        </span>
                    @endif
                  </div>
                </div>




                <div class="form-group row">
                  <label class="control-label col-md-4">邮箱</label>
                  <div class="col-md-8">
                    <input class="form-control" id="email" type="email" class="form-control" name="email" value="{{ old('email') }}" placeholder="Enter email address" required>

                    @if ($errors->has('email'))
                        <span class="help-block">
                            <strong>{{ $errors->first('email') }}</strong>
                        </span>
                    @endif
                  </div>
                </div>
                <div class="form-group row">
                  <label class="control-label col-md-4">密码</label>
                  <div class="col-md-8">
                    <input class="form-control" id="password" type="password" class="form-control" name="password" placeholder="Password" required>

                    @if ($errors->has('password'))
                        <span class="help-block">
                            <strong>{{ $errors->first('password') }}</strong>
                        </span>
                    @endif
                  </div>
                </div>
                <div class="form-group row">
                  <label class="control-label col-md-4">确认密码</label>
                  <div class="col-md-8">
                    <input class="form-control" id="password-confirm" type="password" class="form-control" name="password_confirmation" placeholder="Confirm Password" required>
                  </div>
                </div>


<!-- 
                <div class="form-group row">
                  <div class="col-md-8 col-md-offset-3">
                    <div class="form-check">
                      <label class="form-check-label">
                        <input class="form-check-input" type="checkbox">I accept the terms and conditions
                      </label>
                    </div>
                  </div>
                </div> -->


              </form>
            </div>
            <div class="tile-footer">
              <div class="row">
                <div class="col-md-8 col-md-offset-3">
                    <button class="btn btn-primary" type="button" onclick="event.preventDefault();document.getElementById('register-form').submit();">
                        <i class="fa fa-fw fa-lg fa-check-circle"></i>Register
                    </button>
                    &nbsp;&nbsp;&nbsp;
                    <a class="btn btn-secondary" href="{{ url('/') }}"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                </div>
              </div>
            </div>
          </div>
        </div>
@endsection



