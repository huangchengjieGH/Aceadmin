<?php

/**
 *  后台继承类
 * @file   Admin.php  
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;

use think\Controller;
use think\Loader;

class RegisterController extends controller {
    /*
     * 添加
     */
    public function add(){
        session_start();
        $data = input();
        $where = array();
        $validate = Loader::validate('Shop');
        if(!$validate->check($data)){
            $info = $validate->getError();
            return re_json(1,$info);
        }
        if(!isset($_SESSION["authcode"])){
            return re_json(1,"验证码已过期");
        }
        if($data["authcode"] != $_SESSION["authcode"]){
            $info = "验证码不正确";
            return re_json(1,$info);
        }else{
            $data_a['registertime']=$data['registertime']=$data['updatetime'] = time();
            $data['lience_pic'] = upload_img("shoper",$_FILES["#lience"]);
            $p_flag = 0;
            //图片转存
            if($data['lience_pic']!=null){
                $data['id_pic'] = upload_img("shoper",$_FILES["#id_pic"]);
                if($data['id_pic'] != null){
                    $data['shop_pic'] = upload_img("shoper",$_FILES["#shop_pic"]);
                    if($data['shop_pic'] != null){
                        $p_flag = 1;
                    }else{
                         unlink($data['shop_pic']);
                         unlink($data['id_pic']);
                         unlink($data['lience_pic']);
                    }
                }else{
                    unlink($data['id_pic']);
                    unlink($data['lience_pic']);
                }
            }else{
                unlink($data['lience_pic']);
            }
            if($p_flag){
                //写入数据库,shoper的事务开始
                model('shop')->startTrans();
                $where['shop_phone']=$data_a['username'] = $data_a['mobile'] = $data['shop_phone'];
                $where['shop_HQ'] = $data['shop_HQ'];
                $where['shop_name'] = $dat['shop_name'];
                $count = model('shop')->whereOr($where)->count();
                if($count){
                    $info = "注册失败！电话、地址或商家名字重复了";
                    return re_json(0,$info);
                }else{
                    $data["longitude"] = $data["longitude"]*1000000;
                    $data["latitude"] = $data["latitude"]*1000000;
                    $s_re = model('shop')->allowField(true)->save($data);
                    if($s_re){
                        $data_saa['shopid'] = model('shop')->getLastInsID();
                        $data_a['password'] = md5($data["password"]);
                        $data_a['email'] = $data['email'];
                        model('admin')->startTrans();
                        $a_re = model('admin')->allowField(true)->save($data_a);
                        if($a_re){
                            $data_aga['uid'] = $data_saa['admin_id'] = model('admin')->getLastInsID();
                            $data_aga['group_id'] = 4;
                            model('admin_group_access')->startTrans();
                            $aga_re = model('admin_group_access')->allowField(true)->save($data_aga);
                            if($aga_re){
                                model('shop_admin_access')->startTrans();
                                $saa_re = model('shop_admin_access')->allowField(true)->save($data_saa);
                                if($saa_re){
                                    //事物提交
                                    model('shop_admin_access')->commit();
                                    model('admin_group_access')->commit();
                                    model('admin')->commit();
                                    model('shop')->commit();
                                }else{
                                    //事务回滚
                                    model('admin')->rollback();
                                    model('shop')->rollback();
                                    model('admin_group_access')->rollback();
                                    model('shop_admin_access')->rollback();
                                    $p_flag = 0;
                               }
                            }else{
                                model('admin')->rollback();
                                model('shop')->rollback();
                                model('admin_group_access')->rollback();
                                $p_flag = 0;
                            }
                        }else{
                            model('admin')->rollback();
                            model('shoper')->rollback();
                            $p_flag = 0;
                        }
                    }
                }
            }
             if($p_flag){               
                    $info = $_FILES["#id_pic"];
                    return re_json(0,"注册成功，等待审核通过吧！");
                }else{
                    $info = "注册失败，休息一会再注册";
                    return re_json(1,$info);
                }
    }
}
public function Bmap(){
    return $this->fetch('/Login/Bmap');
}

public function register_cap(){
    captcha();
}
public function get_m(){
    $data = input();
    $longitude1 = $data["lng"];
    $latitude1 = $data["lat"];

    $longitude2 = 0;
    $latitude2 = 0;

    // 终点坐标
    $shop = db("shop")->field("longitude,latitude,shop_name,shop_pic")->select();
    foreach ($shop as $key => $value) {
        $longitude2 = $shop[$key]["longitude"] = $value["longitude"]/1000000;   
        $latitude2 = $shop[$key]["latitude"] = $value["latitude"]/1000000;
        $shop[$key]["distance"] = getDistance($longitude1, $latitude1, $longitude2, $latitude2, 1);
        if($shop[$key]["distance"]<150){
            return re_json(1,"距离".$shop[$key]["shop_name"]."过近  距离".$shop[$key]["distance"]."m");
        }  
    }
    return re_json(0,$shop);
   
}
}
?>