<?php

namespace App\Http\Controllers\Voyager;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataDeleted;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Events\BreadImagesDeleted;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Controllers\Traits\BreadRelationshipParser;
use TCG\Voyager\Http\Controllers\Controller;
use PHPUnit\Framework\Constraint\IsTrue;
use App\Fund;

class FundController extends Controller
{
    use BreadRelationshipParser;
    //***************************************
    //               ____
    //              |  _ \
    //              | |_) |
    //              |  _ <
    //              | |_) |
    //              |____/
    //
    //      Browse our Data Type (B)READ
    //
    //****************************************

    public function index(Request $request)
    {
        // GET THE SLUG, ex. 'posts', 'pages', etc.
        $slug = $this->getSlug($request);

        // GET THE DataType based on the slug
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('browse', app($dataType->model_name));

        $getter = $dataType->server_side ? 'paginate' : 'get';

        $search = (object) ['value' => $request->get('s'), 'key' => $request->get('key'), 'filter' => $request->get('filter')];
        $searchable = $dataType->server_side ? array_keys(SchemaManager::describeTable(app($dataType->model_name)->getTable())->toArray()) : '';
        $orderBy = $request->get('order_by');
        $sortOrder = $request->get('sort_order', null);

        // Next Get or Paginate the actual content from the MODEL that corresponds to the slug DataType
        if (strlen($dataType->model_name) != 0) {
            $relationships = $this->getRelationships($dataType);

            $model = app($dataType->model_name);
            $query = $model::select('*')->with($relationships);

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'browse');

            if ($search->value && $search->key && $search->filter) {
                $search_filter = ($search->filter == 'equals') ? '=' : 'LIKE';
                $search_value = ($search->filter == 'equals') ? $search->value : '%'.$search->value.'%';
                $query->where($search->key, $search_filter, $search_value);
            }

            if ($orderBy && in_array($orderBy, $dataType->fields())) {
                $querySortOrder = (!empty($sortOrder)) ? $sortOrder : 'DESC';
                $dataTypeContent = call_user_func([
                    $query->orderBy($orderBy, $querySortOrder),
                    $getter,
                ]);
            } elseif ($model->timestamps) {
                $dataTypeContent = call_user_func([$query->latest($model::CREATED_AT), $getter]);
            } else {
                $dataTypeContent = call_user_func([$query->orderBy($model->getKeyName(), 'DESC'), $getter]);
            }

            // Replace relationships' keys for labels and create READ links if a slug is provided.
            $dataTypeContent = $this->resolveRelations($dataTypeContent, $dataType);
        } else {
            // If Model doesn't exist, get data from table name
            $dataTypeContent = call_user_func([DB::table($dataType->name), $getter]);
            $model = false;
        }

        // Check if BREAD is Translatable
        if (($isModelTranslatable = is_bread_translatable($model))) {
            $dataTypeContent->load('translations');
        }

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        $view = 'voyager::bread.browse';

        if (view()->exists("voyager::$slug.browse")) {
            $view = "voyager::$slug.browse";
        }

        // 拥有browse_media权限的用户可以查看所有的项目
        // 没有browse_media权限的用户只能查看自己参与的项目
        // 找出当前用户参与的项目，并替换
        $canSeeOthersFunds = Voyager::can('browse_media');
        if(!$canSeeOthersFunds)
        {
            $apply_funds = $request->user()->apply_funds;
            $dataTypeContent = $apply_funds;
        }
        // 如果拥有相应的权限的话，就不进行任何操作

        return Voyager::view($view, compact(
            'dataType',
            'dataTypeContent',
            'isModelTranslatable',
            'search',
            'orderBy',
            'sortOrder',
            'searchable',
            'isServerSide'
        ));
        
    }

    //***************************************
    //                _____
    //               |  __ \
    //               | |__) |
    //               |  _  /
    //               | | \ \
    //               |_|  \_\
    //
    //  Read an item of our Data Type B(R)EAD
    //
    //****************************************

    public function show(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $relationships = $this->getRelationships($dataType);
        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);
            $dataTypeContent = call_user_func([$model->with($relationships), 'findOrFail'], $id);
        } else {
            // If Model doest exist, get data from table name
            $dataTypeContent = DB::table($dataType->name)->where('id', $id)->first();
        }

        // Replace relationships' keys for labels and create READ links if a slug is provided.
        $dataTypeContent = $this->resolveRelations($dataTypeContent, $dataType, true);

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'read');

        // Check permission
        $this->authorize('read', $dataTypeContent);

        // 没有权限的人不是自己参与的项目不能看
        $canSeeOthersFunds = Voyager::can('browse_media');
        if(! $canSeeOthersFunds)
        {
            // 先找出能看的项目
            $apply_funds = $request->user()->apply_funds;
            $cannotSee = true;
            // 请求的不在能看的里面，那就不让看
            foreach($apply_funds as $fund)
            {
                if($fund->id == $id)
                    $cannotSee = false;
            }
            if($cannotSee)
                abort(404);
        }

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::bread.read';

        if (view()->exists("voyager::$slug.read")) {
            $view = "voyager::$slug.read";
        }
        
        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
        
    }

    //***************************************
    //                ______
    //               |  ____|
    //               | |__
    //               |  __|
    //               | |____
    //               |______|
    //
    //  Edit an item of our Data Type BR(E)AD
    //
    //****************************************

    public function edit(Request $request, $id)
    {
        // 没有权限的人不是自己参与的项目不能编辑
        $canEditOthersFunds = Voyager::can('browse_media');
        if(! $canEditOthersFunds)
        {
            // 先找出能编辑的项目
            $apply_funds = $request->user()->apply_funds;
            $cannotEdit = true;
            // 请求的不在能编辑的里面，那就不让编辑
            foreach($apply_funds as $fund)
            {
                if($fund->id == $id)
                    $cannotEdit = false;
            }
            if($cannotEdit)
                abort(404);
        }

        //有权限的话，进入正常操作流程
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $relationships = $this->getRelationships($dataType);

        $dataTypeContent = (strlen($dataType->model_name) != 0)
            ? app($dataType->model_name)->with($relationships)->findOrFail($id)
            : DB::table($dataType->name)->where('id', $id)->first(); // If Model doest exist, get data from table name

        foreach ($dataType->editRows as $key => $row) {
            $details = json_decode($row->details);
            $dataType->editRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('edit', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        // 处理申请流程中编辑表单的一些变化
        // 超级管理员不参与判断（有browse database权限的人）
        if(! Voyager::can('browse_database')){
            $editFund = Fund::find($id);
            $isTeacher = Voyager::can('browse_media');
            if($editFund->status == "申请中"){
                // 即将开始审批阶段
                // 当前状态是申请中，学生可以编辑申请理由，申请金额，申请项目，老师则可以读取申请理由，申请金额和申请项目，并编辑审批理由和审批金额
                if(! $isTeacher){
                    $newEditRows = array();
                    foreach($dataType->EditRows as $row){
                        if ($row->field == "apply_reason" || $row->field == "apply_money" || $row->field == "fund_belongsto_project_relationship")
                            array_push($newEditRows, $row);
                    }
                    $dataType->editRows = collect($newEditRows);
                } elseif($isTeacher) {
                    $newEditRows = array();
                    $readonly = array(
                        "textarea" => array("apply_reason",),
                        "input" => array("apply_money"), 
                    );
                    $disabled = array(
                        "project_id",
                    );
                    foreach($dataType->EditRows as $row){
                        if ($row->field == "apply_reason" 
                        || $row->field == "apply_money" 
                        || $row->field == "fund_belongsto_project_relationship"
                        || $row->field == "approve_reason"
                        || $row->field == "approve_money"
                        )
                            array_push($newEditRows, $row);
                    }
                    $dataType->editRows = collect($newEditRows);               
                } else{
                    return redirect()
                    ->back()
                    ->with([
                        'message' => "获取当前用户信息失败，请稍后再试，或联系管理员",
                        "alert-type" => 'error',
                    ]);
                }

            } elseif($editFund->status == "审批中"){
                // 即将开始结报阶段
                // 当前状态是审批中，老师可以编辑审批理由和审批金额，学生可以查看申请理由，申请金额，申请项目，审批理由和审批金额，并编辑报销单编号和结报金额
                if($isTeacher){
                    $newEditRows = array();
                    $readonly = array(
                        "textarea" => array("apply_reason",),
                        "input" => array("apply_money"), 
                    );
                    $disabled = array(
                        "project_id",
                    );
                    foreach($dataType->EditRows as $row){
                        if ($row->field == "apply_reason" 
                        || $row->field == "apply_money" 
                        || $row->field == "fund_belongsto_project_relationship"
                        || $row->field == "approve_reason"
                        || $row->field == "approve_money"
                        )
                            array_push($newEditRows, $row);
                    }
                    $dataType->editRows = collect($newEditRows);
                } elseif(! $isTeacher){
                    $newEditRows = array();
                    $readonly = array(
                        "textarea" => array("apply_reason", "approve_reason"),
                        "input" => array("apply_money", "approve_money"), 
                    );
                    $disabled = array(
                        "project_id",
                    );
                    foreach($dataType->EditRows as $row){
                        if ($row->field == "apply_reason" 
                        || $row->field == "apply_money" 
                        || $row->field == "fund_belongsto_project_relationship"
                        || $row->field == "approve_reason"
                        || $row->field == "approve_money"
                        || $row->field == "reimburse_no"
                        || $row->field == "reimburse_money"
                        )
                            array_push($newEditRows, $row);
                    }
                    $dataType->editRows = collect($newEditRows);
                } else {
                    return redirect()
                    ->back()
                    ->with([
                        'message' => "获取当前用户信息失败，请稍后再试，或联系管理员",
                        "alert-type" => 'error',
                    ]);
                }
            } elseif($editFund->status == "结报中"){
                if(!$isTeacher){
                    $newEditRows = array();
                    $readonly = array(
                        "textarea" => array("apply_reason", "approve_reason"),
                        "input" => array("apply_money", "approve_money"), 
                    );
                    $disabled = array(
                        "project_id",
                    );
                    foreach($dataType->EditRows as $row){
                        if ($row->field == "apply_reason" 
                        || $row->field == "apply_money" 
                        || $row->field == "fund_belongsto_project_relationship"
                        || $row->field == "approve_reason"
                        || $row->field == "approve_money"
                        || $row->field == "reimburse_no"
                        || $row->field == "reimburse_money"
                        )
                            array_push($newEditRows, $row);
                    }
                    $dataType->editRows = collect($newEditRows);
                } elseif($isTeacher){
                    $newEditRows = array();
                    $readonly = array(
                        "textarea" => array("apply_reason", "approve_reason", ),
                        "input" => array("reimburse_no"), 
                    );
                    $disabled = array(
                        "project_id",
                    );
                    foreach($dataType->EditRows as $row){
                        if ($row->field == "apply_reason" 
                        || $row->field == "apply_money" 
                        || $row->field == "fund_belongsto_project_relationship"
                        || $row->field == "approve_reason"
                        || $row->field == "approve_money"
                        || $row->field == "reimburse_no"
                        || $row->field == "reimburse_money"
                        )
                            array_push($newEditRows, $row);
                    }
                    $dataType->editRows = collect($newEditRows);
                } else {
                    return redirect()
                    ->back()
                    ->with([
                        'message' => "获取当前用户信息失败，请稍后再试，或联系管理员",
                        "alert-type" => 'error',
                    ]);
                }
            } elseif($editFund->status == "结束"){
                $readonly = array(
                    "textarea" => array("apply_reason", "approve_reason", ),
                    "input" => array("reimburse_no", "apply_money", "approve_money", "reimburse_money", ), 
                );
                $disabled = array(
                    "project_id",
                    "user_id",
                    "approve_id",
                );
            } else {
                return redirect()
                ->back()
                ->with([
                    'message' => "获取当前经费申请信息失败，请稍后再试，或联系管理员",
                    "alert-type" => 'error',
                ]);
            }
        }


        if(!isset($readonly)) $readonly = array();
        if(!isset($disabled)) $disabled = array();
        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'readonly', 'disabled'));
    }

    // POST BR(E)AD
    public function update(Request $request, $id)
    {
        // 没有权限的人不是自己参与的项目不能编辑
        $canUpdateOthersFunds = Voyager::can('browse_media');
        if(! $canUpdateOthersFunds)
        {
            // 先找出能编辑的项目
            $apply_funds = $request->user()->apply_funds;
            $cannotUpdate = true;
            // 请求的不在能编辑的里面，那就不让编辑
            foreach($apply_funds as $fund)
            {
                if($fund->id == $id)
                    $cannotUpdate = false;
            }
            if($cannotUpdate)
                abort(404);
        }

        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Compatibility with Model binding.
        $id = $id instanceof Model ? $id->{$id->getKeyName()} : $id;

        $data = call_user_func([$dataType->model_name, 'findOrFail'], $id);

        
        // Check permission
        $this->authorize('edit', $data);

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->editRows, $dataType->name, $id);


        if ($val->fails()) {
            return response()->json(['errors' => $val->messages()]);
        }

        if (!$request->ajax()) {

            // 超级管理员不参与判断（有browse database权限的人）
            if(! Voyager::can('browse_database')){
                // 不同的人不同的阶段有不同的权限
                $updateFund = Fund::find($id);
                $isTeacher = Voyager::can('browse_media');
                if($updateFund->status == "申请中"){
                    if($isTeacher){
                        // 确保只能编辑能编辑的字段
                        $newEditRows = array();
                        foreach($dataType->EditRows as $row){
                            if ($row->field == "approve_reason"
                            || $row->field == "approve_money"
                            )
                                array_push($newEditRows, $row);
                        }
                        $dataType->editRows = collect($newEditRows);

                        // 给相应的字段赋值
                        $updateFund->approve_time = date("Y-m-d H:i:s");
                        $updateFund->status = "审批中";
                        $updateFund->approve_id = $request->user()->id;
                        if(!$updateFund->save()){
                            return redirect()
                            ->back()
                            ->with([
                                'message' => "创建流水号和写入申请状态失败，请稍后再试，或联系管理员",
                                "alert-type" => 'error',
                            ]);
                        }
                    } elseif(! $isTeacher){
                        $newEditRows = array();
                        foreach($dataType->EditRows as $row){
                            if ($row->field == "apply_reason" || $row->field == "apply_money" || $row->field == "fund_belongsto_project_relationship")
                                array_push($newEditRows, $row);
                        }
                        $dataType->editRows = collect($newEditRows);
                    } else {
                        return redirect()
                        ->back()
                        ->with([
                            'message' => "获取当前用户信息失败，请稍后再试，或联系管理员",
                            "alert-type" => 'error',
                        ]);
                    }
                } elseif($updateFund->status == "审批中"){
                    if($isTeacher){
                        $newEditRows = array();
                        foreach($dataType->EditRows as $row){
                            if ($row->field == "approve_reason"
                            || $row->field == "approve_money"
                            )
                                array_push($newEditRows, $row);
                        }
                        $dataType->editRows = collect($newEditRows);
                    } elseif(! $isTeacher){
                        $newEditRows = array();
                        foreach($dataType->EditRows as $row){
                            if ($row->field == "reimburse_no"
                            || $row->field == "reimburse_money"
                            )
                                array_push($newEditRows, $row);
                        }
                        $dataType->editRows = collect($newEditRows);
                        // 给相应的字段赋值
                        $updateFund->reimburse_time = date("Y-m-d H:i:s");
                        $updateFund->status = "结报中";
                        if(!$updateFund->save()){
                            return redirect()
                            ->back()
                            ->with([
                                'message' => "创建流水号和写入申请状态失败，请稍后再试，或联系管理员",
                                "alert-type" => 'error',
                            ]);
                        }

                    } else {
                        return redirect()
                        ->back()
                        ->with([
                            'message' => "获取当前用户信息失败，请稍后再试，或联系管理员",
                            "alert-type" => 'error',
                        ]);
                    }

                } elseif($updateFund->status == "结报中"){
                    if(!$isTeacher){
                        $newEditRows = array();
                        foreach($dataType->EditRows as $row){
                            if ($row->field == "reimburse_no"
                            || $row->field == "reimburse_money"
                            )
                                array_push($newEditRows, $row);
                        }
                        $dataType->editRows = collect($newEditRows);
                    } elseif($isTeacher){
                        $newEditRows = array();
                        foreach($dataType->EditRows as $row){
                            if ($row->field == "apply_money" 
                            || $row->field == "fund_belongsto_project_relationship"
                            || $row->field == "approve_money"
                            || $row->field == "reimburse_money"
                            )
                                array_push($newEditRows, $row);
                        }
                        $dataType->editRows = collect($newEditRows);

                        // 给相应的字段赋值
                        $updateFund->end_time = date("Y-m-d H:i:s");
                        $updateFund->status = "结束";
                        if(!$updateFund->save()){
                            return redirect()
                            ->back()
                            ->with([
                                'message' => "创建流水号和写入申请状态失败，请稍后再试，或联系管理员",
                                "alert-type" => 'error',
                            ]);
                        }
                    } else {
                        return redirect()
                        ->back()
                        ->with([
                            'message' => "获取当前用户信息失败，请稍后再试，或联系管理员",
                            "alert-type" => 'error',
                        ]);
                    }

                } elseif($updateFund->status == "结束"){
                    $newEditRows = array();
                    $dataType->editRows = collect($newEditRows);
                } else {
                    return redirect()
                    ->back()
                    ->with([
                        'message' => "更新当前经费申请信息失败，请稍后再试，或联系管理员",
                        "alert-type" => 'error',
                    ]);
                }

            }

            $this->insertUpdateData($request, $slug, $dataType->editRows, $data);
            
            event(new BreadDataUpdated($dataType, $data));

            return redirect()
                ->route("voyager.{$dataType->slug}.index")
                ->with([
                    'message'    => __('voyager::generic.successfully_updated')." {$dataType->display_name_singular}",
                    'alert-type' => 'success',
                ]);
        }
    }

    //***************************************
    //
    //                   /\
    //                  /  \
    //                 / /\ \
    //                / ____ \
    //               /_/    \_\
    //
    //
    // Add a new item of our Data Type BRE(A)D
    //
    //****************************************

    public function create(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        $dataTypeContent = (strlen($dataType->model_name) != 0)
                            ? new $dataType->model_name()
                            : false;

        foreach ($dataType->addRows as $key => $row) {
            $details = json_decode($row->details);
            $dataType->addRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'add');

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        // 创建新的经费管理的时候，只能添加申请理由，申请经费和对应的项目
        // 超级管理员不参与判断（有browse database权限的人）
        if(! Voyager::can('browse_database')){
            $newAddRows = array();
            foreach($dataType->addRows as $row){
                if ($row->field == "apply_reason" || $row->field == "apply_money" || $row->field == "fund_belongsto_project_relationship")
                    array_push($newAddRows, $row);
            }
            $dataType->addRows = collect($newAddRows); 
        }


        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    /**
     * POST BRE(A)D - Store data.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->addRows);

        if ($val->fails()) {
            return response()->json(['errors' => $val->messages()]);
        }

        if (!$request->has('_validate')) {

            // 创建的时候只能创建申请理由，申请金额和项目名称
            $newAddRows = array();
            foreach($dataType->addRows as $row){
                if ($row->field == "apply_reason" || $row->field == "apply_money" || $row->field == "project_id")
                    array_push($newAddRows, $row);
            }
            $dataType->addRows = collect($newAddRows); 

            $data = $this->insertUpdateData($request, $slug, $dataType->addRows, new $dataType->model_name());
            

            event(new BreadDataAdded($dataType, $data));
            

            // 根据创建时间自动生成流水号，并在创建的时候将状态设置为申请
            $fund = Fund::find($data->id);
            $fund->fno = str_replace("-","",date("Y-m-dH-i-s")) . rand(5,25);
            $fund->status = "申请中";
            $fund->user_id = $request->user()->id;
            if(!$fund->save()){
                return redirect()
                ->back()
                ->with([
                    'message' => "创建流水号和写入申请状态失败，请稍后再试，或联系管理员",
                    "alert-type" => 'error',
                ]);
            };


            // 
            if ($request->ajax()) {
                return response()->json(['success' => true, 'data' => $data]);  
            }


            return redirect()
                ->route("voyager.{$dataType->slug}.index")
                ->with([
                        'message'    => __('voyager::generic.successfully_added_new')." {$dataType->display_name_singular}",
                        'alert-type' => 'success',
                    ]);
        }
    }

    //***************************************
    //                _____
    //               |  __ \
    //               | |  | |
    //               | |  | |
    //               | |__| |
    //               |_____/
    //
    //         Delete an item BREA(D)
    //
    //****************************************

    public function destroy(Request $request, $id)
    {
        // 没有权限的人不是自己参与的项目不能删除
        $canDeleteOthersFunds = Voyager::can('browse_media');
        if(! $canDeleteOthersFunds)
        {
            // 先找出能删除的项目
            $apply_funds = $request->user()->apply_funds;
            $cannotDelete = true;
            // 请求的不在能删除的里面，那就不让删除
            foreach($apply_funds as $fund)
            {
                if($fund->id == $id)
                    $cannotDelete = false;
            }
            if($cannotDelete)
                abort(404);
        }

        // 有权限删除项目的人继续正常流程
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('delete', app($dataType->model_name));

        // Init array of IDs
        $ids = [];
        if (empty($id)) {
            // Bulk delete, get IDs from POST
            $ids = explode(',', $request->ids);
        } else {
            // Single item delete, get ID from URL
            $ids[] = $id;
        }
        foreach ($ids as $id) {
            $data = call_user_func([$dataType->model_name, 'findOrFail'], $id);
            $this->cleanup($dataType, $data);
        }

        $displayName = count($ids) > 1 ? $dataType->display_name_plural : $dataType->display_name_singular;

        $res = $data->destroy($ids);
        $data = $res
            ? [
                'message'    => __('voyager::generic.successfully_deleted')." {$displayName}",
                'alert-type' => 'success',
            ]
            : [
                'message'    => __('voyager::generic.error_deleting')." {$displayName}",
                'alert-type' => 'error',
            ];

        if ($res) {
            event(new BreadDataDeleted($dataType, $data));
        }

        return redirect()->route("voyager.{$dataType->slug}.index")->with($data);
    }

    /**
     * Remove translations, images and files related to a BREAD item.
     *
     * @param \Illuminate\Database\Eloquent\Model $dataType
     * @param \Illuminate\Database\Eloquent\Model $data
     *
     * @return void
     */
    protected function cleanup($dataType, $data)
    {
        // Delete Translations, if present
        if (is_bread_translatable($data)) {
            $data->deleteAttributeTranslations($data->getTranslatableAttributes());
        }

        // Delete Images
        $this->deleteBreadImages($data, $dataType->deleteRows->where('type', 'image'));

        // Delete Files
        foreach ($dataType->deleteRows->where('type', 'file') as $row) {
            foreach (json_decode($data->{$row->field}) as $file) {
                $this->deleteFileIfExists($file->download_link);
            }
        }
    }

    /**
     * Delete all images related to a BREAD item.
     *
     * @param \Illuminate\Database\Eloquent\Model $data
     * @param \Illuminate\Database\Eloquent\Model $rows
     *
     * @return void
     */
    public function deleteBreadImages($data, $rows)
    {
        foreach ($rows as $row) {
            if ($data->{$row->field} != config('voyager.user.default_avatar')) {
                $this->deleteFileIfExists($data->{$row->field});
            }

            $options = json_decode($row->details);

            if (isset($options->thumbnails)) {
                foreach ($options->thumbnails as $thumbnail) {
                    $ext = explode('.', $data->{$row->field});
                    $extension = '.'.$ext[count($ext) - 1];

                    $path = str_replace($extension, '', $data->{$row->field});

                    $thumb_name = $thumbnail->name;

                    $this->deleteFileIfExists($path.'-'.$thumb_name.$extension);
                }
            }
        }

        if ($rows->count() > 0) {
            event(new BreadImagesDeleted($data, $rows));
        }
    }

    /**
     * Order BREAD items.
     *
     * @param string $table
     *
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function order(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('edit', app($dataType->model_name));

        if (!isset($dataType->order_column) || !isset($dataType->order_display_column)) {
            return redirect()
            ->route("voyager.{$dataType->slug}.index")
            ->with([
                'message'    => __('voyager::bread.ordering_not_set'),
                'alert-type' => 'error',
            ]);
        }

        $model = app($dataType->model_name);
        $results = $model->orderBy($dataType->order_column)->get();

        $display_column = $dataType->order_display_column;

        $view = 'voyager::bread.order';

        if (view()->exists("voyager::$slug.order")) {
            $view = "voyager::$slug.order";
        }

        return Voyager::view($view, compact(
            'dataType',
            'display_column',
            'results'
        ));
    }

    public function update_order(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('edit', app($dataType->model_name));

        $model = app($dataType->model_name);

        $order = json_decode($request->input('order'));
        $column = $dataType->order_column;
        foreach ($order as $key => $item) {
            $i = $model->findOrFail($item->id);
            $i->$column = ($key + 1);
            $i->save();
        }
    }
}
