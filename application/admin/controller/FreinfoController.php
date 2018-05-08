<?php
/**
 * @Author: yehith
 * @Date:   2018-04-01 21:43:36
 * @Last Modified by:   yehith
 * @Last Modified time: 2018-04-03 17:58:35
 */
namespace app\admin\controller;
use think\Controller;
use think\Loader;
class FreinfoController extends CommonController{
	/**
	 * 
	 * @date   2018-04-01
	 * @return [type]
	 */
	 public function fretype_index(){
        $lists = db("fretype")
                    ->alias("ft")
                    ->join("sbw_freset fs","ft.id = fs.fre_type")
                    ->field("ft.fre_name,fre_dec,fs.fre,fs.updatetime,fs.area,fs.id")
                    ->select();
        $this->assign("lists",$lists);
        $html = $this->fetch("/Freinfo/fretype_index");
        return re_json(0,$html);
    }
    /**
     * [add_fretype description]
     * @date 2018-04-01
     */
   public function add_fretype(){
    $data = input();
   	$data["updatetime"] = time(); 
   	// print_r($data);die();
    model("fretype")->startTrans();
    model("freset")->startTrans();
    $res = model("fretype")->allowField(true)->save($data);
	    if($res){
	    	$data["fre_type"] = model("fretype")->getLastInsID();
	    	$res = model("freset")->allowField(true)->save($data);
	    	if($res){
		        model("fretype")->commit();
				model("freset")->commit();
		        $redata = $this->fretype_index();
		        return  $redata;
	    	}else{
	    		model("fretype")->rollback();
	    		model("freset")->rollback();
	    		return re_json(1,"设置失败");
	    	}
	    }else{
	    	model("fretype")->rollback();
	    	return re_json(1,"设置失败");
	    }
	}
	/**
	 * [add_index 跳转添加页]
	 * @date 2018-04-02
	 */
	public function add_index(){
		$crowd = db('crowd')->select();
		$this->assign('crowd',$crowd);
		$html = $this->fetch("/Freinfo/fre_info");
		return re_json(0,$html);
	}
	/**
	 * [fre_info description]
	 * @date   2018-04-03
	 * @return [type]     [description]
	 */
	public function fre_info(){
		$data["fs.id"] = input("id");
		$info = db("freset")
                    ->alias("fs")
                    ->join("sbw_fretype ft","fs.fre_type = ft.id")
                    ->field("fs.*,ft.fre_name,ft.fre_dec,ft.crowd")
                    ->where($data)
                    ->find();
        // print_r($info);die();
        $this->assign("info",$info);
        $crowd = db('crowd')->select();
		$this->assign('crowd',$crowd);
        $html = $this->fetch("/Freinfo/fre_info");
        return re_json(0,$html);
 	}
 	/**
 	 * [edit_fre 修改]
 	 * @date   2018-04-02
 	 * @return [type]     [description]
 	 */
 	public function edit_fre(){
 		$data = input();
 		$id = $data['fre_type'];
 		$fretype_data['fre_name'] = $data["fre_name"];
 		$fretype_data['fre_dec'] = $data["fre_dec"];
 		$fretype_data['crowd'] = $data["crowd"];
 		unset($data["fre_name"]);
 		unset($data["fre_dec"]);
 		unset($data["address"]);
 		unset($data["crowd"]);
 		// print_r($data);die();
		model("fretype")->startTrans();
		$where['id'] = $data["fre_type"];
        $flag = model("fretype")->where($where)->update($fretype_data);
		$where['id'] = $data["id"];
		unset($data['id']);
		// print_r($where);die();
		model("freset")->startTrans();
 		$res = model("freset")->where($where)->update($data);
 		if($res&&$flag){
 			model("freset")->commit();
 			model("fretype")->commit();
 			return $this->fretype_index();
 		}else if($res){
 			model("freset")->commit();
 			return $this->fretype_index();
 		}else if($flag){
 			model("fretype")->commit();
 			return $this->fretype_index();
 		}else{
 			model("fretype")->rollback();
 			model("freset")->rollback();
 			return re_json(1,"内容没更改或数据录入有误");
 		}
 	}
 	/**
 	 * [crowd_index 人群设置]
 	 * @date   2018-04-03
 	 * @return [type]     [description]
 	 */
 	public function crowd_index(){
 		$html = $this->fetch("/Freinfo/crowd_index");
 		return re_json(0,$html);
 	}
 	/**
 	 * [crowd_add 人群设定]
 	 * @date   2018-04-03
 	 * @return [type]     [description]
 	 */
 	public function crowd_add(){
 		$data = input();
 		model("crowd")->startTrans();
    	$res = model("crowd")->allowField(true)->save($data);
    	if($res){
    		model("crowd")->commit();
    		return $this->crowd_index();
    	}else{
    		model("crowd")->rollback();
    		return re_json(1,'添加失败');
    	}
 	}
}
?>