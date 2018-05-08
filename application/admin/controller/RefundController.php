<?php

/**
 * @Author: yehith
 * @Date:   2018-05-02 15:24:11
 * @Last Modified by:   yehith
 * @Last Modified time: 2018-05-03 09:04:20
 */
namespace app\admin\controller;

use app\admin\controller\CommonController;
// 
// use think\Controller;

use app\admin\controller\WinXinRefund;

use app\admin\model\RefundOrder;

use app\admin\model\User;

use app\admin\model\Userinfo;

use app\admin\model\Shop;

class RefundController extends CommonController
{
	private static $page_size = 17;
	
	//同意退押金此处为后台处理
    public function refundFre()
    {
        $data = input();

        $id = $data['info'];

        //.........
        $RefundOrder = db('RefundOrder')->where(['id'=>$id])->find();

        // var_dump($RefundOrder['order_id']);die();

        if($RefundOrder){

            if($RefundOrder['status'] != 1){

                return re_json(901,'退款状态错误');

            }

            $totalFee   =  floatval($RefundOrder['price']*100);

            $refundFee  =  floatval($RefundOrder['price']*100);

            $outTradeNo =  $RefundOrder['order_id'];

            $Refund = new WinXinRefund($totalFee,$refundFee,$outTradeNo);

            $return = $Refund->refund();

            // var_dump($return);die();

            //return $return;
            //
            if($return['return_code'] && $return['return_code']){

                //更新数据
                if($RefundOrder->type == 1){

                    $Userinfo = new Userinfo();

                    $Userinfo ->save(['user_fre'=>0],['user_id' =>$RefundOrder->user_id]);

                }else if($RefundOrder->type == 2){

                    $Userinfo = new Userinfo();

                    $Userinfo ->save(['business_fre'=>0],['user_id' =>$RefundOrder->user_id]);

                }else{

                    $Shop = new Shop();

                    $Shop ->save(['is_pay'=>0],['user_id' =>$RefundOrder->user_id]);
                }

                //更新退款订单
                $RefundOrder = new RefundOrder();

                $RefundOrder ->save(['status'=>2],['order_id'=>$outTradeNo]);

                return re_json(900,'退款完成');

            }else{
                return re_json(902,'微信退款失败');
            }
        }else{
            return re_json(903,'平台退款失败');
        }

    }

    public function refund_index(){

    	$page = $_POST['num']?$_POST['num']:0; 

        $amount = $_SESSION['pagecount'] = model('RefundOrder')->count();

        $page_count =  (int)($amount/self::$page_size) + 1;

        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }

    	$lists = model('RefundOrder')
    					->alias('ro')
    					->join('sbw_userinfo ui','ro.user_id = ui.user_id','left')
    					->join('sbw_user u','ro.user_id = u.user_id','left')
    					->order('id desc')
						->limit($page*self::$page_size,self::$page_size)
						 ->field('ro.*,ui.user_phone,u.user_name')
    					->select();

    	$num['page_size'] = self::$page_size;

    	$this->assign("page_count",$page_count);

        $this->assign('lists', $lists);

        $this->assign('num',$num);

        $this->assign('page', $page);

    	$html = $this->fetch('Order/refund');

    	return re_json(0,$html);
    }
}
?>