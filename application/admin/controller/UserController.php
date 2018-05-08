<?php
/**
 *  后台继承类
 * @file
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;
use think\Controller;
use think\Loader;

class UserController extends Controller{
	private $app_id = '';
    private $app_secret = '';
	/*
	*微信登陆
	 */
	public function wxLogin() {
	  $data = input();
      $appid=$this->app_id;
      $appsecret=$this->app_secret;
      	$code =$data['code'];
      	$url = "https://api.weixin.qq.com/sns/jscode2session?appid=".$appid."&secret=".$appsecret."&js_code=".$code."&grant_type=authorization_code";
	    // $token_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$appid."&secret=".$appsecret."&code=".$code."&grant_type=authorization_code";
	    $curl = curl_init();
	    curl_setopt($curl,CURLOPT_URL, $url);
	    curl_setopt($curl,CURLOPT_SSL_VERIFYPEER, FALSE);
	    curl_setopt($curl,CURLOPT_SSL_VERIFYHOST, FALSE);
	    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	    $output = curl_exec($curl);
	    curl_close($curl);
	    // $data_u['user_wxid'] = $output['openid'];
	    // $data_u["User_name"] = $data["name"];
	    $data_wx = json_decode($output,true);
	    $count = model("User")->where("user_wxid",$data_wx["openid"])->count();
	    if($count){
	    // 	$sha1 = sha1($data["rawData"].$data_wx["session_key"]);
	    // 	if($sha1 == $data["signature"]){
	    $data_updata["User_status"] = 1;
	    $res_up = model("User")->where("user_wxid",$data_wx["openid"])->setField($data_updata);
	    return re_json(1,"登陆成功");
	    	// }else{
	    	// 	return re_json(2,"登陆失败");
	    	// }

	    }else{
	    	$data_u["user_wxid"] = $data_wx["openid"];
	    	$data_user = json_decode($data['userinfo'],true);
	    	$data_u["user_name"] = $data_user['nickName'];
	    	$data_u["u_gender"] = $data_user['gender'];
	    	$data_u["updatatime"] = $data_u['registertime'] = time();
	    	if($this->user_add($data_u)){
		    	return re_json(1,"欢迎您的到来");
	    	}else{
	    		return re_json(2,"服务器异常");
	    	}
	    }
	    
        return re_json(0,$arrayName = array('islogin' => 1, ));
    }
    /*
    *首次用户注册
     */
    public function user_add($datatran){
    	$data = $datatran?$datatran:null;
    	if($data!=null){
    		model('User')->startTrans();
	    	$res = model("User")->allowField(true)->save($data);
	    	if($res){
	    		$data_uf["user_id"] = model('userinfo')->getLastInsID(); 
	    		$data_uf["updatatime"] = $data["updatatime"];
	    		model('userinfo')->startTrans();
	    		$res_uf = model('userinfo')->allowField(true)->save($data_uf);
	    		if($res_uf){
	    			model("User")->commit();
	    			model("userinfo")->commit();
	    			return 1;
	    		}else{
	    			model("userinfo")->rollback();
					model("User")->rollback();
	    		}
	    	}else{
	    		model("User")->rollback();
	    		return 0;
	    	}
    	}else{
    		return 0;
    	}
    }
    public function product_info(){
    	$lists = db("product")->limit(10)->select();
    	foreach($lists as $k => $v){
			$lists[$k]["pics"] = string_ex($v["product_pic"]);
    		unset($lists[$k]["product_pic"]);   	
    	}
    	$lists[0]["pic"] = $lists[0]["pics"][0];

    	return re_json(1,$lists);
    }
    //获取各商家的库存情况
	public function query_isstock(){
		$count = model("shop_admin_access")->count();
		if($count > 0){
			$where["ispass"] = 1;
			$where["bucket_null"] =  array('egt',450); 
			$count = model("shop_admin_access")->where($where)->count();
			$lists["list"] = model("shop_admin_access")
					 ->alias("saa")
					 ->join("sbw_shop s","saa.shopid = s.shop_id")
					 ->where($where)
					 ->field("saa.bucket_null,saa.bucket_allnum,s.shop_name,s.shop_HQ")
					 ->select();
			$lists["count"] = $count;
			return re_json(0,$lists);
		}
		return re_json(1,$count);
	}
	//测试用的方法
	public function text(){

			// var_dump("1111");die();

		    // $post_data['filename'] = $file;

		    $postUrl = "http://tp5admin.com/api/v1/refund/refundFre?id=95";

		    $timeout = 30;

		    // $ch = curl_init();

		    // curl_setopt($ch,CURLOPT_URL, $postUrl);

		    $ch = curl_init('http://404.php.net/');

			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);

			if(curl_exec($ch) === false)
			{
			    echo 'Curl error: ' . curl_error($ch);
			}
			else
			{
			    echo '操作完成没有任何错误';
			}

			// 关闭句柄
			curl_close($ch);

		    // curl_close($curl);

		    // print_r($output);

	}

	
}
?>