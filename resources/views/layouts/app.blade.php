<!DOCTYPE HTML>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>学生科研项目管理平台</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by freehtml5.co" />
	<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	

	

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<link href="https://fonts.googleapis.com/css?family=Work+Sans:300,400,500,700,800" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="{{ URL::asset('css/animate.css') }}">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="{{ URL::asset('css/icomoon.css') }}">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="{{ URL::asset('css/bootstrap.css') }}">

	<!-- Magnific Popup -->
	<link rel="stylesheet" href="{{ URL::asset('css/magnific-popup.css') }}">

	<!-- Owl Carousel  -->
	<link rel="stylesheet" href="{{ URL::asset('css/owl.carousel.min.css') }}">
	<link rel="stylesheet" href="{{ URL::asset('css/owl.theme.default.min.css') }}">

	<!-- Theme style  -->
	<link rel="stylesheet" href="{{ URL::asset('css/style.css') }}">

	<!-- Modernizr JS -->
	<script src="{{ URL::asset('js/modernizr-2.6.2.min.js') }}"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	</head>
	<body>
		
	<div class="fh5co-loader"></div>
	
	<div id="page">
	<!-- nav -->
	@include('partials.nav')
	<!-- end nav -->

	<!-- header -->
	@yield('header')
	<!-- end header -->

	<!-- content -->
	@yield('content')
	
	<!-- end content -->
	
	<!-- footer -->
	@include('partials.footer')

	<!-- end footer -->
	</div>


	<div class="gototop js-top">
    	<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>

	<!-- jQuery -->
	<script src="{{ URL::asset('js/jquery.min.js') }}"></script>
	<!-- jQuery Easing -->
	<script src="{{ URL::asset('js/jquery.easing.1.3.js') }}"></script>
	<!-- Bootstrap -->
	<script src="{{ URL::asset('js/bootstrap.min.js') }}"></script>
	<!-- Waypoints -->
	<script src="{{ URL::asset('js/jquery.waypoints.min.js') }}"></script>
	<!-- Stellar Parallax -->
	<script src="{{ URL::asset('js/jquery.stellar.min.js') }}"></script>
	<!-- Carousel -->
	<script src="{{ URL::asset('js/owl.carousel.min.js') }}"></script>
	<!-- countTo -->
	<script src="{{ URL::asset('js/jquery.countTo.js') }}"></script>
	<!-- Magnific Popup -->
	<script src="{{ URL::asset('js/jquery.magnific-popup.min.js') }}"></script>
	<script src="{{ URL::asset('js/magnific-popup-options.js') }}"></script>
	<!-- Main -->
	<script src="{{ URL::asset('js/main.js') }}"></script>

	</body>
</html>

