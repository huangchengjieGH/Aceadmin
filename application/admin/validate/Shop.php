<?php
namespace app\admin\validate;

use think\Validate;

class Shop extends Validate
{
    protected $rule = [
        'shop_name'  =>  'require|max:25',
        'email' =>  'require|email',
        'shop_phone'=>'require|length:11|/^1[34578]\d{9}$/',
        'shop_HQ' => 'require',
        'authcode' => 'require',
        '#lience' => 'file|image',
        '#id_pic' => 'file|image',
        '#shop_pic' => 'file|image',
        'password'=>'require|confirm',
    ];
    protected $message = [
    	'shop_name.require' => '商家名不能为空',
	    'shop_name.max:25'     => '名称最多不能超过25个字符',
	    'email'        => '邮箱格式错误',
	    'shop_phone' => '请填写正确的手机号',
	    'shop_HQ' => '地址不能为空',
	    'authcode' => '验证码不能为空',
        '#lience.file' =>'请上传营业执照',
        '#lience.image' =>'请上传图片',
        '#id_pic.file'  =>'请上传证件照',
        '#id_pic.image' =>'请上传图片',
        '#shop_pic.file'    =>'请上传门店照',
        '#shop_pic.image'   =>'请上传图片',
        'password'=>'密码不一致'
	];
}
?>