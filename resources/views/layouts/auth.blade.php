<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="{{ URL::asset('css/main.css') }}">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>{{ config('app.name', 'Laravel') }}</title>
  </head>
  <body>

    <section class="material-half-bg">
      <div class="cover"></div>
    </section>

    <section class="login-content" >
      <div class="logo">
        <h1>学生科研项目管理平台</h1>
      </div>
      @yield('content')

     





    </section>
  </body>
  <!-- Essential javascripts for application to work-->
  <script src="{{ URL::asset('js/jquery-3.2.1.min.js') }}"></script>
  <script src="{{ URL::asset('js/popper.min.js') }}"></script>
  <script src="{{ URL::asset('js/bootstrap.min.js') }}"></script>
  <script src="{{ URL::asset('js/main.js') }}"></script>
  <!-- The javascript plugin to display page loading on top-->
  <script src="{{ URL::asset('js/plugins/pace.min.js') }}"></script>
</html>


