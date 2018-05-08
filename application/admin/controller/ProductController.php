<?php
/**
 *  后台继承类
 * @file
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;

use think\Loader;

class ProductController extends CommonController{
	/**
	 * [index 首页]
	 * @date   2018-04-07
	 * @return [type]     [description]
	 */
	public function index(){
		session_start();
		if(isset($_SESSION["pics"])){
			unset($_SESSION['pics']);
		}
		$lists = db('product')
				->select();
		$count = db('product')->count();
		$this->assign('people_count',$count);
		$this->assign('lists',$lists);
		$html =  $this->fetch('/Product/index');
		return re_json(0,$html);
	}
	/**
	 * [info 添加跳转]
	 * @date   2018-04-07
	 * @return [type]     [description]
	 */
	public function info(){
		$lists = model("shop")->field("shop_id,shop_name")->select();
		$this->assign("shoplist",$lists);
		$html =  $this->fetch('/Product/info');
		return re_json(0,$html);
	}
	/**
	 * [add 添加产品]
	 * @date 2018-04-07
	 */
	public function add(){
		
		$data = input();

		$re_upload = $this->upload_proImg();

        if($re_upload){

        $data["product_pic"] = $re_upload;

        model("product")->startTrans();

        $res = model("product")->allowField(true)->save($data);

        if($res){

        	$p_id = model("product")->getLastInsID();

        	model("shop_product_access")->startTrans();
        	
        	$data_pa['product_id'] = $p_id;

        	$data_pa['shop_id'] = $data['shop_id'];

        	$data_pa['stock'] = $data['stock']?$data['stock']:0;

        	$res = model("shop_product_access")->allowField(true)->save($data_pa);

        	if($res){

        		model("product")->commit();

        		model('shop_product_access')->commit();

        		return re_json(0,"上传成功");

        	}else{

        		model('shop_product_access')->rollback();

        		model("product")->rollback();

	        	$arr = string_ex($re_upload);

	        	foreach ($arr as $key => $vlaue) {

	        	      unlink(config('public.domain_wx').$vlaue); 

	        	 }   

	        	return re_json(1,"上传失败,请重新尝试");

        	}
        }else{

        	model("product")->rollback();

        	$arr = string_ex($re_upload);

        	foreach ($arr as $key => $vlaue) {

        	      unlink(config('public.domain_wx').$vlaue); 

        	 }      

        	return re_json(1,"上传失败,请重新尝试");

        }	

        }else{

        	return re_json(1,"上传失败，请重新尝试");

        }
	}
	/*
	*查询库存
	 */
	public function query_stock(){
		session_start();
		// die('li');
		$where = [];

		$data["uid"] = session("user_id")?session("user_id"):null;

		//判断是否为合法用户
		
		$shop = [];

		if($data["uid"]!=null){

			//是否为超级管理员
			if($data["uid"] != 1){

				$where["uid"] = session("user_id");

				$group = model("admin_group_access")

				         ->alias("aga")

				         ->join("sbw_admin_group ag","aga.group_id=ag.id")

				         ->where($where)

				         ->find();

				//一移除查询条件
				//
				unset($where["uid"]);

				//组权限为2的才能操作
				if($group["listorder"]==2){

					$where["admin_id"] = session("user_id");

					$shop = db("shop_admin_access")->where($where)->field("shopid")->find();


					// var_dump($shop);die();

					$shop["spa.shop_id"] = $shop['shopid'];

					unset($shop['shopid']);

				}elseif($group["listorder"]==6){

					// die('li');

				}else{

					return re_json(1,"身份有问题！");

				}
			}


		}

		$lists = model("shop_product_access")

						->alias("spa")

						->join("sbw_shop s","spa.shop_id = s.shop_id")

						->join("sbw_product p","spa.product_id = p.id",'left')

						->where($shop)

						->field("spa.shop_id,spa.stock,s.shop_name,s.shop_HQ,s.shop_address_detail,p.product_N")

						->select();

		$this->assign("lists",$lists);

		$this->assign("where",session("user_id"));

		$html = $this->fetch("/Product/stock");

		return re_json(0,$html);


	}
	/**
	 * [add_stock 添加库存]
	 * @date 2018-04-27
	 */
	public function edit_stock(){

		$data = input();

		$num = $data["num"];

		if($num < 501 && $num > 99){

			$where["shop_id"] = $data["shop_id"];

			$oldnum = db('shop_product_access')->where($where)->field('stock')->find();

			$num += $oldnum['stock'];

			$res = model('shop_product_access')->where($where)->update(['stock'=>$num]);

	        if($res){  

	            $json = $this->index();

	            return $json;

	        }else{

	            return re_json(1,"数据没有更新");

	        }
		}else{

			return re_json(1,"数量异常！");


		}

	}
	/**
	 * [del_product 删除产品]
	 * @param [string] $[id] [产品id]
	 * @return [type]
	 */
	public function del_product_r(){
		$id = input('id');
		$del_data = db('product')->where(['id'=>$id])->field('product_pic')->find();
		$arr = string_ex($del_data['product_pic']);
		foreach ($arr as $key => $vlaue) {
	       // unlink($vlaue); 	
	    } 
        $res = db('product')->where(['id' => $id])->delete();
        if ($res) {
            return $this->index();
        } else {
            return re_json(1,'操作失败啦');
        }
	}
	/**
	 * [del_product 下架]
	 * @date   2018-04-03
	 * @return [type]     [description]
	 */
	public function del_product(){
		$id = input('id');
		$del_data = db('product')->where(['id'=>$id])->field('del_flag')->find();
		$flag = $del_data['del_flag']?0:1;
		// print_r($flag);die();
        $res = db('product')->where(['id' => $id])->update(["del_flag"=>$flag]);
        if ($res) {
            return $this->index();
        } else {
            return re_json(1,'操作失败啦');
        }
	}
	/**
	 * [productinfo 修改商品属性]
	 * @date   2018-04-05
	 * @return [type]     [description]
	 */
	public function productinfo(){
		$data = input();
		$info = db('product')->where(["id"=>$data['id']])->find();
		if($info['product_pic']!=''){			
			$arr = string_ex($info['product_pic']);
			foreach ($arr as $key => $value) {
		       $info['pics'][$key] = config('public.domain_wx').$value;
		       $info['pic_del'][$key] = $value;	
		    }
		} 
		$shoplists = model("shop")->field("shop_id,shop_name")->select();
		
		$this->assign("shoplist",$shoplists);
	    // print_r($info);die();
	    $this->assign('info',$info);
	    $html = $this->fetch('/Product/info');
	    return re_json(0,$html);
	}
	/**
	 * [upload_proImg 上传产品图]
	 * @date   2018-04-05
	 * @return [type]     [description]
	 */
	public function upload_proImg(){
		$file=$_FILES['image_data'];//获取上传文件的信息，数组形式
		$filename ="";
		if(is_array($file)){
			foreach($file['tmp_name'] as $k=>$v)  
	        {  
	        	$file_t["tmp_name"] = $v;
	        	$file_t["type"] = $file["type"][$k];
	        	$file_t["name"] = $file["name"][$k];  
	        	if($filename == ""){
	        		$filename=upload_img("product",$file_t);
	        	}else{
	        		$filename= $filename.",".upload_img("product",$file_t);
	        	}
	        }
	    }
        if($filename !=null){
        	return $filename;
        }else{
        	return false;
        }
	}
	/**
	 * [edit_product 修改产品的属性]
	 * @date   2018-04-07
	 * @return [type]     [description]
	 */
	public function edit_product(){
		session_start();
		$data = input();
		$id = $data['id'];
        // print_r($data);die();
		unset($data['id']);
		$del_data = db('product')->where(['id'=>$id])->field('product_pic')->find();
		$filename = $del_data['product_pic'];
		if(isset($_SESSION['pics'])){
			$filename ='';
			$resoure_pic = string_ex($del_data['product_pic']);
			$arr = $_SESSION['pics'];
			foreach ($arr as $key => $value) {
				if($resoure_pic[$key] != $val){
					if($filename==""){
						$filename .= $val;
					}else{
						$filename .=','.$val;
					}
				}
				// var_dump(config("public.uploadfile").$value);die();
				// unlink($value);
			}
			unset($_SESSION['pics']);
		}
		$re_upload = $this->upload_proImg();	
		if($re_upload){	
        	$data["product_pic"] =$filename?$filename.','.$re_upload:$re_upload;
			model('product')->startTrans();
			$res = model('product')->where(['id'=>$id])->update($data);
			if($res){
				model('product')->commit();
				$redata = $this->index();
				return $redata;
			}else{
				return re_json(1,"修改失败");
			}
		}else{
			return re_json(1,'删除文件失败');
		}
	}
	/**
	 * [pre_del_Img 删除预处理]
	 * @date   2018-04-07
	 * @return [type]     [description]
	 */
	public function pre_del_Img(){
		$data = input();
		session_start();
		if(!isset($_SESSION["pics"])){
			$_SESSION["pics"] = array();
		}
		array_push($_SESSION["pics"],$data['pic']);
		return $_SESSION["pics"];
	}
}