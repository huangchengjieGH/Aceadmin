<?php

/**
 * @Author: yehith
 * @Date:   2018-04-01 21:43:36
 * @Last Modified by:   yehith
 * @Last Modified time: 2018-04-01 21:44:30
 */

namespace app\admin\controller;
use think\Db;
use app\admin\model\Relation;
class DistributionController extends CommonController {

    private static $page_size = 12;
    private static $area_code = 440114;


    public function index(){
        session_start();
        $where = array();
        $num = array();
        //默认显示的状态
        $order_status = 2;
        $ifproxy = 1;
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
        $where_h['ifproxy'] = array(['egt',$ifproxy]);
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


//        $sql = "select count(*) from sbw_relation where ifproxy =1";
//        $amount = Db::query($sql);
//        echo $amount;
        //订单数,
//        $amount = $_SESSION['pagecount'] = model('order')->where($where_h)->count();
        $amount  = $_SESSION['pagecount'] = Relation::countProxy();

//        echo $amount;
        //总共几页
        $page_count =  (int)($amount/self::$page_size) + 1;

        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
            $this->assign('N_flag',1);
        }

        //获取订单数
        $lists = $this->distribution($page);

        $num['page_size'] = self::$page_size;

        //订单的总额
//        $num["price"] = db("order")
//            ->where($where)
//            ->sum("price");

        //销售的桶量
//        $num['bucket_num'] = db("order")
//            ->where($where)
//            ->sum("num");
//        echo $page_count;
//        echo $page;
//        echo $lists;
        $this->assign("page_count",$page_count);
        $this->assign('lists', $lists);
//        $this->assign('num',$num);
        $this->assign('page', $page);
        $html = $this->fetch('/Distribution/distribution');
        return re_json(0,$html);

    }
    public function distribution($tra_page){
        $page = $tra_page?$tra_page:0;
//        $page = '1';
//        $page_size = '2';
//        $page_size2 = '6';
//
//        $page*self::$page_size,self::$page_size;

        $pageStart = $page*self::$page_size;
        $pageEnd = self::$page_size;
//
//        echo $page;
//        echo $pageStart;
//        echo $pageEnd;
        $sql = "select h.user_id,h.user_name,
    case 
    when h.user_role =1 then '普通用户'
    when h.user_role =2 then '配送员'
    when h.user_role =3 then '水店'
    when h.user_role =4 then '企业用户' 
    end user_role,
h.totalincome,h.incoming,k.incomed from (
select a.user_id,a.user_name,a.user_role,a.totalincome,b.incoming from (
select p.user_id,p.user_name,p.user_role,IFNULL(sum(k.income),0) totalincome from sbw_income k right join 
(select n.user_id, n.user_name,n.user_role from sbw_relation m left join sbw_user n on m.customerId = n.user_id
where m.ifproxy = 1) p on k.enjoyId = p.user_id
group by p.user_id
) a left join (
select p.user_id,p.user_name,p.user_role,IFNULL(sum(k.income),0) incoming from (
select enjoyId,sum(income) as income from sbw_income  
where status = 1
group by enjoyId ) k right join 
(select n.user_id, n.user_name,n.user_role from sbw_relation m left join sbw_user n on m.customerId = n.user_id
where m.ifproxy = 1) p
on k.enjoyId = p.user_id
group by p.user_id,p.user_name,p.user_role
) b on a.user_id = b.user_id
) h left join (
select p.user_id,p.user_name,p.user_role,IFNULL(sum(k.income),0) incomed from (
select enjoyId,sum(income) as income from sbw_income  
where status = 0
group by enjoyId ) k right join 
(select n.user_id, n.user_name,n.user_role from sbw_relation m left join sbw_user n on m.customerId = n.user_id
where m.ifproxy = 1) p
on k.enjoyId = p.user_id
group by p.user_id,p.user_name,p.user_role
) k on h.user_id = k.user_id
order by h.totalincome desc
limit ?,?";

        $totalIncome = Db::query($sql,[$pageStart,$pageEnd]);
//        echo json($totalIncome);
        foreach($totalIncome as $k=>$v){
            $t = $v->user_role;
            if($t == 1){
                $v['user_role'] = '普通用户';
            }elseif ($t == 2){
                $v['user_role'] = '配送员';
            }elseif ($t == 3){
                $v['user_role'] = '水店';
            }elseif ($t == 4){
                $v['user_role'] = '企业用户';
            }

        }
        return $totalIncome;
//        return json($totalIncome);
    }

}