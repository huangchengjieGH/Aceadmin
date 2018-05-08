<?php
/**
 *  后台继承类
 * @file
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;

use think\Loader;
use app\admin\controller\SmscapController;

class UserinfoController extends CommonController{
	 //一页有多少条数据
    private static $page_size = 17;
	public function index(){
		$other = array();
		//计算页数
		$page = $_POST['num']?$_POST['num']:0; 
        $amount = $_SESSION['pagecount'] = model('user')->count();
        $page_count =  (int)($amount/self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
		$lists = db('user')
				->alias('a')
				->join('sbw_userinfo w','a.user_id = w.user_id','left')
				->field('a.user_name,a.u_gender,a.registertime,u_isvip,a.user_id,a.user_role,w.user_phone,w.user_address,w.user_address_detail,w.user_floor,w.user_iselevator,w.user_fre,w.business_fre,w.updatatime,w.is_business,w.latitude,w.longitude')
				->order('registertime desc')
				->limit($page*self::$page_size,self::$page_size)
				->select();
		$other["count"] = db('user')->count();
		
		// $other["all_fre"] = db('userinfo')->sum("user_fre");
		// $other["all_umoney"] = db('userinfo')->sum("u_money");
		//计算总押金情况
		// foreach ($lists as $key => $value) {
		// 	$other["page_fre"] += $value["user_fre"];
		// }
		$this->assign('other',$other);
		$this->assign("page_count",$page_count);  
        $this->assign('lists', $lists);
        $this->assign('page', $page);
		$html =  $this->fetch('/User/index');
		return re_json(0,$html);
	}
	public function add_info(){
		session_start();
		$adminid = session('user_id');
		$where = array();
		if($adminid==1){

		}else{
			$where['admin_id']=$adminid;
		}
		// $lists = model('cap')->where($where)->order('id desc')->select();
		// $this->assign("lists",$lists);
		$html = $this->fetch('/User/iscollected');
		return re_json(0,$html);
	}
	public function ispass(){
		$data = input();
		model("user")->startTrans();
        $res = model("user")->where(['user_id'=>$data['info']])->update(['u_isvip'=>1]);
        if($res){
        	model('user')->commit();
        	$html = $this->index();
        	return $html;
        }
	}
	/**
	 * [send_sms 短信发送]
	 * @date   2018-04-27
	 * @return [type]     [description]
	 */
	public function send_sms(){
		$data = input();
		$Smscap = new SmscapController();
		$phone = $data["phone"];
		$ishave = db("cap")->where(['phone'=>$phone])->find();
		if($ishave==null){
			$code = rand(100,1000 ).rand(100,1000);
			$data["cap"] = $code;
			$res = model('cap')->allowField(true)->save($data);
			if($res){
				$remsg = $Smscap->sendSms($code,$phone);
				$msg = (array)$remsg;
				// print_r($msg);die();
				if($msg["Code"] == "OK"){
					
					return re_json(0,"");
				}else{
					return re_json(1,"间隔太短，短信发送失败");
				}
			}else{
				return re_json(1,"录入数据出错");
			}
		}
		else{
			return re_json(1,"已经发送过了");
		}	
	}
}