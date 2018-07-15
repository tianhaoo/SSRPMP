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

Route::get('/', 'DashController@index')->name('dash');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

//category route
Route::get('/category-show','CategoryController@read')->name('showcategory');

Route::get('/category-add','CategoryController@add')->name('addcategory');

//project route
Route::get('/my-project','ProjectController@myproject')->name('myproject');

Route::get('/project-detail','ProjectController@read')->name('projectdetail');

Route::get('/project-edit','ProjectController@edit')->name('projectedit');

Route::get('/project-add','ProjectController@add')->name('projectadd');

Route::get('/project-delete','ProjectController@delete')->name('projectdelete');

Route::get('/project-browse','ProjectController@browse')->name('projectbrowse');


// [your site path]/Http/routes.php

Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});
