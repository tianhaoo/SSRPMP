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

// 首页
Route::get('/', function () {
    return view('index');
});
Route::get('/home', function () {
	return redirect('/');
})->name('home');

// 通知发文
Route::get('/blog', 'BlogController@index');
Route::get('/post/{slug}', 'BlogController@show');

// 用户登录
Auth::routes();

// 后台管理
Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();

    // 重载登录路由
    Route::get('/login', ['uses' => 'Auth\LoginController@showLoginForm', 'as' => 'voyager.login']);
    Route::post('/login', ['uses' => 'Auth\LoginController@login', 'as' => 'voyager.postlogin']);
    Route::post('/logout', ['uses' => 'Auth\LoginController@logout', 'as' => 'voyager.logout']);

});
