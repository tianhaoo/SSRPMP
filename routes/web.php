<?php
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Auth::routes();

Route::get('/', 'WelcomeController@index')->name('index');
Route::get('/home', 'HomeController@home')->name('home');


// post route
Route::get('/post/{slug}','PostController@show')->name('showpost');
Route::get('/post', 'PostController@index')->name('post');


//category route
Route::prefix('category')->group(function(){
	Route::get('show','CategoryController@read')->name('showcategory');
	Route::get('add','CategoryController@add')->name('addcategory');
});


//project route

Route::prefix('project')->group(function(){
	Route::get('my','ProjectController@myproject')->name('myproject');
	Route::get('detail','ProjectController@read')->name('projectdetail');
	Route::get('edit','ProjectController@edit')->name('projectedit');
	Route::get('add','ProjectController@add')->name('projectadd');
	Route::get('delete','ProjectController@delete')->name('projectdelete');
	Route::get('browse','ProjectController@browse')->name('projectbrowse');
});


//funds route
Route::prefix('funds')->group(function(){
	Route::get('browse','FundsController@browse')->name('showfundsapplication');
	Route::get('approved','FundsController@approved')->name('approved');
	Route::get('approving','FundsController@approving')->name('approving');
	Route::get('detail','FundsController@detail')->name('fundsdetail');
	Route::get('edit','FundsController@edit')->name('fundsedit');
	Route::get('delete','FundsController@delete')->name('fundsdelete');
});



// [your site path]/Http/routes.php

Route::group(['prefix' => 'admin'], function () {
	Voyager::routes();
	// 重载登录路由
	Route::get('/login', ['uses' => 'Auth\LoginController@showLoginForm', 'as' => 'voyager.login']);
	Route::post('/login', ['uses' => 'Auth\LoginController@login', 'as' => 'voyager.postlogin']);
	Route::post('/logout', ['uses' => 'Auth\LoginController@logout', 'as' => 'voyager.logout']);
});
