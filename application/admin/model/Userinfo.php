<?php
/**
 *  
 * @file    
 * @date   2018-03-04 00:51:09 
 * @author yehith 
 */
namespace app\admin\model;

use think\Model;

class Userinfo extends Model {
    
//隐藏详细信息id
    protected $hidden =['uid'];
    //定义时间戳字段
    protected $autoWriteTimestamp = true;
    protected $updateTime = 'updatatime';
    //过滤不存在的键值
    protected $field = true;

    // 一对多
    public function address(){
        return $this->hasMany("Address",'user_id','user_id');
    }

    // 获取所有的地址信息
    public function getAllAddress($user_id){
        $addresses = $this->address()
            ->where('user_id','=',$user_id)
            ->select();
        return $addresses;
    }

    public static function getByUserID($user_id){
        $user_info = self::where('user_id','=',$user_id)
            ->find();
        return $user_info;
    }
}
?>