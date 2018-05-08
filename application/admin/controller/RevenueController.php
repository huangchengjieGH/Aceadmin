<?php

/**
 * @Author: yehith
 * @Date:   2018-04-28 11:59:07
 * @Last Modified by:   yehith
 * @Last Modified time: 2018-05-02 09:51:58
 */

namespace app\admin\controller;

class RevenueController extends CommonController{
	private static $page_size = 12;
    private static $area_code = 440114;


	public function index(){
        session_start();
        $where = array();
        $num = array();
        //默认显示的状态
        $order_status = 2;

        $data = input();

        if(isset($data["start"])){
            if($data["start"]!=null){
                $_SESSION["start_time"]=$start_time = strtotime($data["start"]);
                $_SESSION["stop_time"]=$stop_time  = strtotime($data["stop"]);
            }
        }else{
            if(!isset($_SESSION["start_time"])){
                //获取今天的时间点（00:00:00）
		        $_SESSION['start_time'] = $start_time = strtotime(date('Y-m-d'));

		        $_SESSION['stop_time'] = $stop_time = strtotime(date('Y-m-d'))+86399;
            }else{
            	$start_time = $_SESSION['start_time']; 

		        $stop_time = $_SESSION['stop_time']; 
                // return re_json(1,"无法查询！");
            }
        }

        if($_SESSION["stop_time"]!= null){

            $where['o_builddate'] = array(['egt',$start_time],['elt',$stop_time]);         

        	$where_l['o_builddate'] = array(['egt',$start_time],['elt',$stop_time]);       	
        }

        $where['order_status'] = array(['egt',$order_status]);
        $where_l['order_status'] = array(['egt',$order_status]);

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

        //订单数,
        $amount = $_SESSION['pagecount'] = model('order')->where($where)->count();

        //总共几页
        $page_count =  (int)($amount/self::$page_size) + 1;

        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }

        //获取订单数
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

        $this->assign("page_count",$page_count);  
        $this->assign('lists', $lists);
        $this->assign('num',$num);
        $this->assign('page', $page);
        $html = $this->fetch('/Order/index_revenue');
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
    /**
     * [clear_time 清除时间]
     * @date   2018-04-28
     * @return [type]     [description]
     */
    public function clean_time(){

    	session_start();

    	if(isset($_SESSION["start_time"])){
            unset($_SESSION["start_time"]);
            unset($_SESSION["stop_time"]);
        }

        return $this->index();

    }

    /**
     * [settime 设置时间]
     * @date   2018-05-02
     * @return [type]     [description]
     */
    public function settime(){


    }
}
?>