<?php

/**
 * @Author: yehith
 * @Date:   2018-05-02 15:28:37
 * @Last Modified by:   yehith
 * @Last Modified time: 2018-05-02 15:32:40
 */
namespace app\admin\model;

use think\Model;

class RefundOrder extends Model {
    protected $createTime = 'o_builddate';
    // 根据 全局用户ID 和押金类型 查询是否交了押金,

    // 返回相应的订单数据

    public static function getByUserID($user_id,$type){

        $desopit = self::where('user_id',$user_id)
            ->where('type',$type)
            ->find();
//            ->where('status',0)
        return $desopit;

    }

}
?>