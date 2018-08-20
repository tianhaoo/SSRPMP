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

Route::get('/x/', 'IndexController@index')->name('index');

// post route
Route::get('/x/post/{slug}','PostController@show')->name('showpost');
Route::get('/x/post', 'PostController@index')->name('post');

Route::group(['prefix' => 'x'], function () {
    Auth::routes();
});

// Route::get('/home', 'HomeController@index')->name('home');


Route::group(['prefix' => 'x/admin'], function () {
    Voyager::routes();

    Route::get('/login', ['uses' => 'Auth\LoginController@showLoginForm', 'as' => 'voyager.login']);
	Route::post('/login', ['uses' => 'Auth\LoginController@login', 'as' => 'voyager.postlogin']);
	Route::post('/logout', ['uses' => 'Auth\LoginController@logout', 'as' => 'voyager.logout']);
});
