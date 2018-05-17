<?php

/**
 *  后台继承类
 * @file   Admin.php  
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;

use think\Loader;

class ShoperController extends CommonController {

    private static $page_size = 12;

	public function index(){
        $demo=model("shop"); 
        $page = $_POST['num']?$_POST['num']:0; 
        $amount = $_SESSION['pagecount'] = model('shop')->where($where)->count();
        $page_count =  (int)($amount / self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
        //获取数据       
        $lists=$demo
        		->alias('a')
                ->join('sbw_shop_admin_access w','a.shop_id = w.shopid','left')
                ->join('sbw_admin ad','w.admin_id = ad.id','left')
        		->field('a.*,w.ispass,w.bucket_null,w.bucket_allnum,ad.realname as username,w.shop_fre')
                ->limit($page*self::$page_size,self::$page_size)
                ->select();
        $this->assign("page_count",$page_count);  
        $this->assign('lists', $lists);
        $this->assign('page', $page);
        $html =  $this->fetch('/Shoper/index');
        return re_json(0,$html);
    }
    public function info_pic(){
        $data = input();
        $lists = db("shop")->where($data)->field("shop_pic,id_pic,lience_pic,shop_id")->find();


        $lists["shop_pic"] = config('public.domain_wx').$lists["shop_pic"];
        $lists["lience_pic"] = config('public.domain_wx').$lists["lience_pic"];
        $lists["id_pic"] = config('public.domain_wx').$lists["id_pic"];


        // var_dump($lists);die();
        return re_json(0,$lists);        
    }
    /**
     * [ispass 水店审核通过]
     * @date   2018-04-26
     * @return [type]     [description]
     */
    public function ispass(){
        $data = input();
        $shop["shop_id"] = $data["shopid"];
        $is_res = db("shop")->where($shop)->field("is_check,shop_phone")->find();
        $is_has = db("shop_admin_access")->where($data)->find();
         $ispass = 0;
            if($is_res["is_check"]){
                $ispass = 0;
            }else{
                $ispass = 1;
            }
        if($is_has){
            $res = model("shop")->where($shop)->update(["is_check"=>$ispass]);
            if($res){
                $index = $this->index();
                return $index;
            }else{
                return re_json(1,"提交失败");
            }
        }else{
            $res = model("shop")->where($shop)->update(["is_check"=>$ispass]);
            $data_a['password'] = md5("123456");
            $data_a['username'] = $data_a["mobile"] = $is_res["shop_phone"]; 
            model('admin')->startTrans();
            $a_re = model('admin')->allowField(true)->save($data_a);
            $flge = 0;
            if($a_re&&$res){
                $data_aga['uid'] = $data_saa['admin_id'] = model('admin')->getLastInsID();
                $data_aga['group_id'] = 4;
                model('admin_group_access')->startTrans();
                $aga_re = model('admin_group_access')->allowField(true)->save($data_aga);
                if($aga_re){
                    $data_saa["shopid"] = $data["shopid"];
                    $data_saa["ispass"] = 1;
                    model("shop_admin_access")->startTrans();
                    $saa_re = model("shop_admin_access")->allowField(true)->save($data_saa);
                    if($saa_re){
                        $flge =1;
                    }
                }
                
            }
            if($flge){
                //事物提交
                model('shop_admin_access')->commit();
                model('admin_group_access')->commit();
                model('admin')->commit();
                $index = $this->index();
                return $index;
            }else{
                 //事务回滚
                model('admin')->rollback();
                model('admin_group_access')->rollback();
                model('shop_admin_access')->rollback();
                return re_json(1,"提交失败");
            }
        }
    }
    /**
     * [eavl_info 評論信息]
     * @date   2018-04-26
     * @return [type]     [description]
     */
    public function eavl_info(){


        $where = array();

        //身份检测
        $shop["shopid"] = parent::_getshopid();
        if($shop["shopid"]!=false){
            if($shop["shopid"]!=null){
                $where['shop_id'] = $shop["shopid"];
                $where_l['se.shop_id'] = $shop["shopid"];
            }
        }else{
            if(session('user_id')!=1){

                $listorder = parent::_getlistorder();

                if($listorder){

                    if($listorder != 6){

                        return re_json(1,"身份有问题！");

                    }

                }else{

                    return re_json(1,"身份有问题！");

                }
                
            }
        }
        $where["parent_id"] = 0;
        $page = $_POST['num']?$_POST['num']:0; 
        $amount = $_SESSION['pagecount'] = model('shop_eval')->where($where)->count();
        $page_count =  (int)($amount / self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
        $where_l["parent_id"] = 0;
        $lists = db("shop_eval")
                    ->alias("se")
                    ->join("sbw_shop s","s.shop_id = se.shop_id")
                    ->join("sbw_user u","u.user_id = se.user_id",'left')
                    ->where($where_l)
                    ->order('se.time desc')
                    ->field("se.*,s.shop_name,s.shop_phone")
                    ->limit($page*self::$page_size,self::$page_size)
                    ->select();
        foreach ($lists as $key => $value) {
            $lists[$key]["pllt"] = db("shop_eval")
                                    ->alias("se")
                                    ->join("sbw_shop s","s.shop_id = se.shop_id","left")
                                    ->where(["parent_id"=>$value["id"]])
                                    ->field("se.*,s.shop_name,s.shop_phone")
                                    ->order("id desc")
                                    ->limit(2)
                                    ->select();
        }
        // print_r($lists);die(); 
        $this->assign("page_count",$page_count);  
        $this->assign('lists', $lists);
        $this->assign('page', $page);        
        $html = $this->fetch("/Shoper/eavl_info");
        return re_json(0,$html);
    }
    public function clear_own(){
        $data = input();
        $id = $data["id"];
        model("shop_admin_access")->startTrans();
        $res = model("shop_admin_access")->where(['shopid'=>$id])->update(['own_num'=>0]);
        if($res){
            model("shop_admin_access")->commit();
            return $this->index();
        }else{
            model("shop_admin_access")->rollback();
            return re_json(1,"无权操作");
        }
    }
    /**
     * [hf_save 回复操作 ]
     * @date   2018-04-11
     * @return [type]     [description]
     */
    public function hf_save(){
        $data = input();
        $data['time'] = time();
        $data['shop_id'] = parent::_getshopid();
        // print_r($data);die();
        if($data["shopid"]!=false){
            if($data["shopid"]==null){
                 return re_json(1,"身份有问题！");
            }
        }else{
            if(session('user_id')!=1){
                $listorder = parent::_getlistorder();

                if($listorder){

                    if($listorder != 6){                        
                        return re_json(1,"身份有问题！");
                    }

                }else{
                    return re_json(1,"身份有问题！");
                }
                
            }
        }
        model("shop_eval")->startTrans();
        $res = model("shop_eval")->save($data);
        if($res){
            $id = model("shop_eval")->getLastInsID();
            model("shop_eval")->commit();
            $info = db("shop_eval")
                    ->alias("se")
                    ->join("sbw_shop s","s.shop_id = se.shop_id","left")
                    ->where(["id"=>$id])
                    ->field("se.eavl,s.shop_name,s.shop_phone")
                    ->find();
            $info["shop_name"] = $info["shop_name"]?$info["name"]:"管理员";
            return re_json(0,$info);
        }else{
            model("shop_eval")->rollback();
            return re_json(1,"回复失败");
        }
    }
    /**
     * [eavl_add 模拟评论添加]
     * @date   2018-04-08
     * @return [type]     [description]
     */
    public function eavl_add(){
        $p[1] = "五星好评";
        $p[2] = "不错，好评";
        $p[3] = "服务有点差";
        $data["eavl"] = $p[rand(1,3)];
        $data["star"] = rand(1,5);
        $data["time"] = time();
        $data["shop_id"] = rand(1,4); 
        $data["user_id"] = rand(10,12);
        model("shop_eval")->allowField(true)->save($data);
     }
     public function  ShopUserinfo(){
        $user_id = "10";
        $where['u_id'] = $user_id;
        $lists = db('user_shop_access')
                    ->alias('sa')
                    ->join('sbw_shop s','sa.shop_id = s.shop_id')
                    ->join('sbw_user u','u.user_id = sa.u_id')
                    ->where($where)
                    ->field('sa.*,s.shop_name,s.shop_phone,u.user_name')
                    ->select();
                    // print_r($lists);die();
        $this->assign('lists',$lists);
        $html = $this->fetch('/Shoper/shopuser');
        return re_json(0,$html);
     }
     /**
      * [Shoperinfo 选择骑手]
      * @date 2018-04-27
      */
     public function Shoperinfo(){
        $data = input();
        $lists = db("shoperinfo")->where($data)->field('realname,sid')->select();
        // var_dump($data);die();
        if($lists != null){      
            return re_json(0,$lists);
        }else{
            return re_json(1,"没有骑手！");
        }
     }

     /**
      * [edit_service 修改服务费]
      * @date   2018-04-27
      * @return [type]     [description]
      */
     public function edit_service(){

        $data = input();

        $where["shop_id"] = $data['shop_id'];

        $num = floatval($data['num']);

        $res = model('shop')->where($where)->update(['service_fee'=>$num]);

        if($res){  

            $json = $this->index();

            return $json;

        }else{

            return re_json(1,"数据没有更新");

        }
     }

     /**
      * [fee_index 浏览费用]
      * @date   2018-04-27
      * @return [type]     [description]
      */
     public function fre_index(){

        $list = db('set_money')->field('id,user_fre,shop_fre,company_fre,floor_fre,floor_sub')->select();

        // var_dump($list);die();

        $this->assign('lists',$list);

        $html = $this->fetch('/Shoper/fre_index');

        return re_json(0,$html);

     }

     public function get_fee(){

        $data = input();

        $info = db('set_money')->where($data)->find();

        $this->assign('info',$info);

        $html = $this->fetch('/Shoper/set_fee');

        return re_json(0,$html);

     }

     /**
      * [set_fee 设置费用]
      * @date 2018-04-27
      */
     public function set_fee(){

        $data = input();

        $data['user_fre'] = floatval($data['user_fre']);

        $data['company_fre'] = floatval($data['company_fre']);

        $data['shop_fre'] = floatval($data['shop_fre']);

        $data['floor_fre'] = floatval($data['floor_fre']);

        $where['id'] = $data['id'];

        unset($data['id']); 

        model('set_money')->startTrans();

        $res = model('set_money')->where($where)->update($data);

        if($res){

            model('set_money')->commit();

            return $this->fre_index();

        }else{

            model('set_money')->rollback();

            return re_json(1,'数据没有更新！');

        }

     }
     /**
      * [edit_deliveryarea 配送范围]
      * @date   2018-04-27
      * @return [type]     [description]
      */
     public function edit_deliveryarea(){

        $data = input();

        if($data['info2']<10 && $data['info2']>0){

            $info['deliveryArea'] = floatval($data['info2']);

            $where['shop_id'] = $data['info1'];

            model('shop')->startTrans();

            $res = model('shop')->where($where)->update($info);

            if($res){

                model('shop')->commit();

                return $this->index();

            }else{

                model('shop')->rollback();

                return re_json(1,'数据没有更新！');

            }

        }else{

            return re_json(1,'数量异常！');

        }

     }

}
?>