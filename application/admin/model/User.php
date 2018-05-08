<?php
/**
 *  
 * @file   Shoper.php  
 * @date   2018-03-04 00:51:09 
 * @author yehith 
 */
namespace app\admin\model;

use think\Model;

class User extends Model {
    //定义时间戳字段名
    protected $autoWriteTimestamp = true;
    protected $createTime = 'registertime';
    protected $updateTime = 'updatatime';

    //用户是否存在
    //存在返回user_id，不存在返回0
    public static function getByOpenID($openid)
    {
        $user = User::where('user_wxid', '=', $openid)
            ->find();
        return $user;
    }

    //用户信息
    public function getUserInfo()
    {
        return $this->hasOne('Userinfo');
    }

    //用户订单
    public function orders()
    {
        return $this->hasMany('Order');
    }

	 public static function getByUserID($user_id)
    {
        $user = User::where('user_id', '=', $user_id)
            ->find();
        return $user;
    }

}
?>