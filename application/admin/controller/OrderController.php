<?php

/**
 *  后台继承类
 * @file   Order .php  
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;

use think\Controller;
use think\Loader;

class OrderController extends CommonController {

    //一页有多少条数据
    private static $page_size = 12;
    private static $area_code = 440114;


	public function index(){
        session_start();
        $where = array();
        $num = array();
        //默认显示的状态
        $order_status = 2;
        $data = input();

        //判断是否有订单状态
        if(!isset($data["op"])){

            if(isset($data["order_status"])){
               $_SESSION["order_status"]= $order_status = $data["order_status"];
            }elseif(isset($_SESSION["order_status"])){
                $order_status = $_SESSION["order_status"];
            }
            if($data["order_status"]!=10){
                $where_l["o.order_status"] = $order_status;
                $where["order_status"] = $order_status;
            }
        }

        //判断是否有时间，有就清理
        if(isset($_SESSION["start_time"])){
            unset($_SESSION["start_time"]);
            unset($_SESSION["stop_time"]);
        }

        //查找管理员的权限
        $shop["shopid"] = parent::_getshopid();
        if($shop["shopid"]!=false){
            if($shop["shopid"]!=null){
                $where['shop_id'] = $shop["shopid"];
                $where_l["o.shop_id"] = $shop["shopid"];
                $this->assign('isdisplay',1);
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

        //计算页数
        $page = $_POST['num']?$_POST['num']:0; 
        $amount = $_SESSION['pagecount'] = model('order')->where($where)->count();
        $page_count =  (int)($amount/self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
       
       //获取订单信息
        $lists = $this->getOrder($where_l,$page);

       $num['page_size'] = self::$page_size;

        //订单的总额
        $num["price"] = db("order")
                        ->where($where)
                        ->sum("price");

        //销售的桶量
        $num['bucket_num'] = db("order")
                    ->where($where)
                    ->sum("num");

        $this->assign("o_status",$this->get_status($order_status));
        $this->assign("page_count",$page_count);  
        $this->assign('lists', $lists);
        $this->assign('num',$num);
        $this->assign('page', $page);
        $html = $this->fetch('/Order/index');
        return re_json(0,$html);
        
    }
    /**
     * [getOrder 获取订单信息]
     * @date   2018-04-28
     * @param  [type]     $param [过滤条件]
     * @param  [type]     $page  [第几页]
     * @return [type]            [array 数组]
     */
    public function getOrder($param,$tra_page){

        $where = $param?$param:[];

        $page = $tra_page?$tra_page:0;

        $lists = db("order")

                    ->alias('o')

                    ->join('sbw_userinfo ui','o.user_id = ui.user_id','left')

                    ->join('sbw_user u','o.user_id = u.user_id','left')

                    ->join('sbw_shop s','o.shop_id = s.shop_id','left')

                    ->join('sbw_shoperinfo si','o.shoper_id = si.sid',"left")

                    ->join('sbw_product p','o.product_id = p.id',"left")

                    ->where($where)

                    ->order('shop_id desc')

                    ->limit($page*self::$page_size,self::$page_size)

                    ->field('o.*,ui.user_phone,u.user_name,ui.user_floor,s.shop_phone,s.shop_HQ,s.shop_name,si.mobile,si.name,p.product_N')

                    ->select();

          return $lists;

    }
    /*
    *搜索
     */
    public function search_order(){
        $data = input();
        // $data['shop_name'] = "2";
        $where['shop_name'] = array('like', "%{$data['shop_name']}%", 'or');


        $shop_id = db("shop")->where($where)->field("shop_id")->select();
         // print_r($shop_id);die();
        $where_str='';
        if($shop_id!=''){
            foreach ($shop_id as $key => $value) {
                if($where_str == ""){
                    $where_str .= $value["shop_id"];
                }else{
                    $where_str .= ','.$value["shop_id"];
                }
            }
            $where_id["shop_id"] = array('in',$where_str);
            $where_o["o.shop_id"] = array('in',$where_str);
        }else{
            $where_id["shop_id"] = 0;
            $where_o["o.shop_id"] = 0;
        }
        
        $page = $_POST['num']?$_POST['num']:0;       
        $amount = $_SESSION['pagecount'] = model('order')->where($where_id)->count();
        print_r($amount);die();
        $page_count =  (int)($amount / self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
        $lists = db("order")
                    ->alias('o')
                    ->join('sbw_userinfo ui','o.user_id = ui.user_id')
                    ->join('sbw_user u','o.user_id = u.user_id')
                    ->join('sbw_shop s','o.shop_id = s.shop_id')
                    ->join('sbw_shoperinfo si','o.shop_id = si.sid',"left")
                    ->join('sbw_product p','o.product_id = p.id',"right")
                    ->where($where_o)
                    ->order('shop_id desc')
                    ->limit($page*self::$page_size,self::$page_size)                    
                    ->field('o.*,ui.user_phone,u.user_name,s.shop_phone,s.shop_HQ,s.shop_name,si.mobile,si.name,p.product_N')
                    ->select();
        $fre = db('freset')->where(['fre_type'=>3,'area'=>self::$area_code])->field('fre')->find();
        foreach($lists as $vo){
            $num["income"] += $vo["price"]*$vo["num"];
            if($vo["iselevator"]){
                $num["pay"] += $fre['fre']*$vo["floor"];
            }
        }
        $num['fre'] = $fre['fre'];
        $num['page_size'] = self::$page_size;

        $all_price = db("order")
                        ->where($where)
                        ->sum("pro_price*num");
        $all_lists = db("order")
                    ->where($where)
                    ->select();
        foreach($all_lists as $val){
            if($val["iselevator"]){
                $num["all_pay"] += $val['cost']*$val["floor"]*$val['num'];
            }
        }
        $this->assign("all_num",$all_price);
        $this->assign("flag_t",1);
        $this->assign("num",$num);
        $this->assign('lists', $lists);
        $this->assign("page_count",$page_count);
        $this->assign('page', $page);
        $html = $this->fetch('/Order/index');
        return re_json(0,$html);
    }
    /*
     * 订单生成
     */
    public function orderadd(){
    	$data = input();
        $time = time();
        $data['updatetime'] = $time;
        $data['order_num'] = $time.rand(100,1000);
        $data['order_id'] = $data['Order_num'];
        $data['num'] = rand(1,15);
        $data['o_address'] = '广州花都区111号';
        $data['product_id'] = 9;
        $data['o_builddate'] = $time;
        $data['shop_id'] = 1;
        $data['user_id'] = 10;
        $data['uid'] = 1;
        $data['shoper_id'] = 0;
        $data['Order_status'] = 1;
        $where["shopid"] =$data["shop_id"];
        model('order')->startTrans();
        $result = model('order')->allowField(true)->save($data);
        if($result){
            model('shop_admin_access')->startTrans();
            $is_res = db("shop_admin_access")->where($where)->field("bucket_null,bucket_allnum")->find();
            $num = $is_res["bucket_null"] + $data["num"];
            if($num<$is_res["bucket_allnum"]){
                $res = model("shop_admin_access")->where($where)->update(["bucket_null"=>$num]);
                if($res){
                    model("order")->commit();
                    model("shop_admin_access")->commit();
                    return re_json(0,$data);
                }
                else{
                    model("shop_admin_access")->rollback();
                    model('order')->rollback();
                }
            }else{
                return re_json(1,"商家库存不足！");
            }
        }else{
            model('order')->rollback();
        }
    }
    /*
    *按时间去查询数据
     */
    public function orderOftime (){
        $data = input();
        $where = array();
        session_start();
        if(isset($data["start"])){
            if($data["start"]!=null){
                $_SESSION["start_time"]=$start_time = strtotime($data["start"]);
                $_SESSION["stop_time"]=$stop_time  = strtotime($data["stop"]);
            }
        }else{
            if(isset($_SESSION["start_time"])){
                $start_time = $_SESSION["start_time"];
                $stop_time = $_SESSION["stop_time"];
            }else{
                return re_json(1,"无法查询！");
            }
        }
        $where['o_builddate'] = array(['egt',$start_time],['elt',$stop_time]);

        $shop["shopid"] = $this->_getshopid();
        if($shop["shopid"]!=false){
            if($shop["shopid"]!=null){
                $where['shop_id'] = $shop["shopid"];
                $this->assign('isdisplay',1);
            }
        }else{
             if(session('user_id')!=1){
                return re_json(1,"有问题！");
            }
        }
        $page = $_POST['num']?$_POST['num']:0;       
        $amount = $_SESSION['pagecount'] = model('order')->where($where)->count();
        $page_count =  (int)($amount / self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
        $lists = db("Order")
                    ->alias('o')
                    ->join('sbw_userinfo ui','o.user_id = ui.user_id')
                    ->join('sbw_user u','o.user_id = u.user_id')
                    ->join('sbw_shop s','o.shop_id = s.shop_id')
                    ->join('sbw_shoperinfo si','o.shop_id = si.sid',"left")
                    ->join('sbw_product p','o.product_id = p.id')
                    ->where($where)
                    ->order('id desc')
                    ->limit($page*self::$page_size,self::$page_size)                    
                    ->field('o.*,ui.user_phone,u.user_name,s.shop_phone,s.shop_HQ,s.shop_name,si.mobile,si.name,p.product_N')
                    ->select();
        $fre = db('freset')->where(['fre_type'=>3,'area'=>self::$area_code])->field('fre')->find();
        foreach($lists as $vo){
            $num["income"] += $vo["price"]*$vo["num"];
            if($vo["iselevator"]){
                $num["pay"] += $fre['fre']*$vo["floor"];
            }
        }
        $num['fre'] = $fre['fre'];
        $num['page_size'] = self::$page_size;
        $all_price = db("order")
                        ->where($where)
                        ->sum("pro_price*num");
        $all_lists = db("order")
                    ->where($where)
                    ->select();
        foreach($all_lists as $val){
            if($val["iselevator"]){
                $num["all_pay"] += $fre['fre']*$val["floor"]*$val['num'];
            }
        }
        $this->assign("o_status",$this->get_status(10));
        $this->assign("flag_t",1);
        $this->assign("num",$num);
        $this->assign('lists', $lists);
        $this->assign("page_count",$page_count);
        $this->assign('page', $page);
        $html = $this->fetch('/Order/index');
        return re_json(0,$html);
    }
    //轮询是否有新订单
    public function query_order(){
        session_start();
        $shop["shopid"] = $this->_getshopid();
        if($shop["shopid"]!=false){
            if($shop["shopid"]!=null){
                $where['shop_id'] = $shop["shopid"];
            }
        }else{
             if(session('user_id')!=1){
                return re_json(1,"身份有问题！");
            }
        }
        $where["Order_status"] = 2;
        $lists["list"] = db("Order")->where($where)
                            ->order('o_builddate desc')
                            ->limit(0,6)
                             ->field('o_address')
                            ->select();
        $lists["count"] = model('order')->where($where)->count();
        return re_json(0,$lists);
    }
    /**
     * [send_sbw description]
     * @date   2018-04-10
     * @return [type]     [description]
     */
    public function send_sbw(){
        $data = input();
        $updatetime = time();
        model("order")->startTrans();
        $res = model("order")->where(['id'=>$data['orderid']])->update(['order_status'=>3,'updatetime'=>$updatetime,'shoper_id'=>$data['shoper_id']]);
        if($res){
            model("order")->commit();
            return $this->index();
        }else{
            model("order")->rollback();
            return re_json(1,"状态出错了");
        }
    }
    public function get_status($tra_id){
        $status["status"] = array('1' ,'2','3','4','5','6','-1','-3',10);
        $status["names"] = array("未支付","未派送","待收货","待评价",'交易完成','订单关闭','发起退单',"交易关闭","全部");
        $status["statu"] = $tra_id;
        return $status;
    }

}
?>