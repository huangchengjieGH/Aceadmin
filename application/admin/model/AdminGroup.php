<?php

/**
 *  
 * @file   AdminGroup.php  
 * @date   2016-8-30 18:22:31  
 */

namespace app\admin\model;

class AdminGroup extends \think\Model {

    public function getGroups() {

        $res = db('admin_group')->field('id,name')->select();
        $data = array();
        foreach ($res as $k => $v) {
            $data[$v['id']] = $v['name'];
        }
        return $data;
    }

    public function getGroupName($group_id) {
        return db('admin_group')->where(['id' => $group_id])->value('name');
    }

}
