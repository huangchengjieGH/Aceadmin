<?php

/**
 *  
 * @file   Index.php  
 * @date   2016-8-23 16:03:10 
 */  

namespace app\admin\controller;

class IndexController extends CommonController{
    /**
     * 后台首页
     * @param nothing
     */
    public function index(){

       	$menu = model('Menu')->getMyMenu($this->user_id, 1);

       	$listorder = parent::getlistorder();

       	if($listorder!=false){
       		$this->assign("tip_shop",$listorder);
       	}

        $menuTree = list_to_tree($menu);

        // var_dump($menuTree);die();

        $data = db("shop")->field("longitude,latitude,shop_name,shop_pic")->select();
        foreach ($data as $key => $value) {
            $data[$key]["longitude"] = $value["longitude"];   
            $data[$key]["latitude"] = $value["latitude"];
            $data[$key]["usernum"] = model("order")->where("shop_id",$value["shop_id"])->count(); 
            $data[$key]["shop_pic"] = config('public.domain_wx').$value['shop_pic'];  
        }
        // var_dump($data[0]["longitude"]);die();
        $this->assign("lists",$data);
        $this->assign('menuTree',$menuTree);
        return $this->fetch('/Index/index');
    }
    /**
     * [index_mod 首页模板]
     * @date   2018-04-01
     * @return [type]
     */
    public function index_mod(){
        $menuTree = list_to_tree($menu);
        $data = db("shop")->field("longitude,latitude,shop_name,shop_pic,shop_id")->select();
        foreach ($data as $key => $value) {
            $data[$key]["longitude"] = $value["longitude"];   
            $data[$key]["latitude"] = $value["latitude"];
            $data[$key]["usernum"] = model("order")->where("shop_id",$value["shop_id"])->count(); 
            $data[$key]["usernum"] = model("order")->where("shop_id",$value["shop_id"])->count(); 
            $data[$key]["shop_pic"] = config('public.domain_wx').$value['shop_pic'];
        }
        // var_dump($data[0]["longitude"]);die();
        $this->assign("lists",$data);
        $html=$this->fetch('/Index/index_mod');
        return re_json(0,$html);
    }
   
    
}