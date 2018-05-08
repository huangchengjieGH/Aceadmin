<?php
/**
 *  
 * @file   Shoper.php  
 * @date   2018-03-04 00:51:09 
 * @author yehith 
 */
namespace app\admin\model;

use think\Model;

class Shop extends Model {
    
    //隐藏详细信息id
   //protected $hidden =['shop_id'];
    //定义时间戳字段
    protected $autoWriteTimestamp = true;
    protected $updateTime = 'updatetime';
    protected $createTime = 'registertime';
    // 根据用户ID获取商家信息

    public static function getByUserID($user_id){

        $shoper = self::where('user_id','=',$user_id)

            ->find();

        return $shoper;

    }
    public function products(){
        return $this->hasMany('Product','shop_id','shop_id');
    }

    // 根据用户ID获取商家信息
    public static function getCheckShop(){

        $shop = self::with('products')->where('is_check','=',1)

            ->select();

        return $shop;

    }

// 根据shop_id获取商家信息
	public static function getByShopID($shop_id){

        $shoper = self::where('shop_id','=',$shop_id)

            ->find();

        return $shoper;

    }
    public function getShopPicAttr($value){

        $finalUrl = $value;

        $finalUrl = config('setting.domain').$value;

        return $finalUrl;

    }
    public function getLiencePicAttr($value){

        $finalUrl = $value;

        $finalUrl = config('setting.domain').$value;

        return $finalUrl;

    }
}
?>