<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>Gentelella Alela! | </title>

    <!--这里定义css-->
    @section('css')
    @show 


  </head>
  <body class="nav-md">
    <div class="container body">
      <div class="main_container">

        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            @include('partials.sidebar')
          </div>
        </div>

        @include('partials.topnav')

        <!-- page content -->
        <div class="right_col" role="main">
          @yield('content')
        </div>

        @include('partials.footer')
      </div>
    </div>

    <!--这里定义javascript -->
    @section('javascript')
    @show
  </body>
</html>
