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
    return view('welcome');
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


});
