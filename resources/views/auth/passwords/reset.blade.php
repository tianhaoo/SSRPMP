
@extends('layouts.auth')

@section('content')

      <!--register form-->
        <div class="col-md-4">
          <div class="tile">
            <h3 class="tile-title">Reset Password</h3>
            <div class="tile-body">
              <form id="reset-form" class="form-horizontal" method="POST" action="{{ route('password.request') }}">
                {{ csrf_field() }}

                <input type="hidden" name="token" value="{{ $token }}">
                <div class="form-group row">
                  <label class="control-label col-md-4">Email</label>
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
                  <label class="control-label col-md-4">Password</label>
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
                  <label class="control-label col-md-4">Confirm Password</label>
                  <div class="col-md-8">
                    <input class="form-control" id="password-confirm" type="password" class="form-control" name="password_confirmation" placeholder="Confirm Password" required>

                    @if ($errors->has('password_confirmation'))
                        <span class="help-block">
                            <strong>{{ $errors->first('password_confirmation') }}</strong>
                        </span>
                    @endif                   
                  </div>
                </div>

              </form>
            </div>
            <div class="tile-footer">
              <div class="row">
                <div class="col-md-8 col-md-offset-3">
                    <button class="btn btn-primary" type="submit" onclick="document.getElementById('reset-form').submit();">
                        <i class="fa fa-fw fa-lg fa-check-circle"></i>Reset
                    </button>
                    &nbsp;&nbsp;&nbsp;
                    <a class="btn btn-secondary" href="{{ url('/') }}"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                </div>
              </div>
            </div>
          </div>
        </div>
@endsection
























