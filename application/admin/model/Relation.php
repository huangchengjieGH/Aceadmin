<?php
/**
 *
 * @file   order.php
 * @date   2018-03-04 00:51:09
 * @author yehith
 */
namespace app\admin\model;

use think\Model;

class Relation extends Model {

    public static function countProxy(){
        $count = self::where(['ifproxy'=>1])
            ->count();
        return $count;

    }

}
?>