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
Route::get('/', function () {
    return view('kx');
})->name('kx');

Route::get('/home', function () {
    return redirect('/ssrpmp');
});

Route::get('/ssrpmp', 'IndexController@index')->name('index');

// post route
Route::get('/ssrpmp/post/{slug}','PostController@show')->name('showpost');
Route::get('/ssrpmp/post', 'PostController@index')->name('post');

Route::group(['prefix' => 'ssrpmp'], function () {
    Auth::routes();
});

// Route::get('/home', 'HomeController@index')->name('home');


Route::group(['prefix' => 'ssrpmp/admin'], function () {
    Voyager::routes();

    Route::get('/login', ['uses' => 'Auth\LoginController@showLoginForm', 'as' => 'voyager.login']);
	Route::post('/login', ['uses' => 'Auth\LoginController@login', 'as' => 'voyager.postlogin']);
	Route::post('/logout', ['uses' => 'Auth\LoginController@logout', 'as' => 'voyager.logout']);
});
