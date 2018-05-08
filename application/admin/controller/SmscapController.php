<?php

/**
 * @file   SmscapController.php  
 * @date   
 */
namespace app\admin\controller;
use think\Controller;
use think\Loader;
use app\admin\controller\SignatureHelper;
	class SmscapController extends Controller {
		public function Smscap(){
			$data = input();
			$phone = $data["phone"];
		    $code = rand(100,1000 ).rand(100,1000);
			$remsg = $this->sendSms($code,$phone);
			$msg = (array)$remsg;
			// print_r($msg);die();
			if($msg["Code"] == "OK"){
				session_start();
				$_SESSION["authcode"] = $code;
				return re_json(0,"");
			}else{
				return re_json(1,"间隔太短，短信发送失败");
			}
		}
		public function Removecap(){
			session_start();
			unset($_SESSION["authcode"]);
			return re_json(0,"");
		}
		public function sendSms($cap,$PhoneNum) {
			$code = $cap?$cap:null;
			$PhoneNum = $PhoneNum?$PhoneNum:null;
			if($code == null || $PhoneNum==null){
				return "warning:is nothing";
			}
		    $params = array ();

		    // *** 需用户填写部分 ***

		    // fixme 必填: 请参阅 https://ak-console.aliyun.com/ 取得您的AK信息
		    $accessKeyId = "";
		    $accessKeySecret = "";

		    // fixme 必填: 短信接收号码
		    $params["PhoneNumbers"] = $PhoneNum;

		    // fixme 必填: 短信签名，应严格按"签名名称"填写，请参考: https://dysms.console.aliyun.com/dysms.htm#/develop/sign
		    $params["SignName"] = "慈龙";

		    // fixme 必填: 短信模板Code，应严格按"模板CODE"填写, 请参考: https://dysms.console.aliyun.com/dysms.htm#/develop/template
		    $params["TemplateCode"] = "SMS_129995048";
		    // fixme 可选: 设置模板参数, 假如模板中存在变量需要替换则为必填项
		    $params['TemplateParam'] = Array (
		        "code" => $code,
		    );

		    // fixme 可选: 设置发送短信流水号
		    // $params['OutId'] = "12345";

		    // fixme 可选: 上行短信扩展码, 扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段
		    // $params['SmsUpExtendCode'] = "1234567";


		    // *** 需用户填写部分结束, 以下代码若无必要无需更改 ***
		    if(!empty($params["TemplateParam"]) && is_array($params["TemplateParam"])) {
		        $params["TemplateParam"] = json_encode($params["TemplateParam"], JSON_UNESCAPED_UNICODE);
		    }

		    // 初始化SignatureHelper实例用于设置参数，签名以及发送请求
		    $helper = new SignatureHelper();

		    // 此处可能会抛出异常，注意catch
		    $content = $helper->request(
		        $accessKeyId,
		        $accessKeySecret,
		        "dysmsapi.aliyuncs.com",
		        array_merge($params, array(
		            "RegionId" => "cn-hangzhou",
		            "Action" => "SendSms",
		            "Version" => "2017-05-25",
		        ))
		        // fixme 选填: 启用https
		        // ,true
		    );

		    return $content;
		}
	}
?>