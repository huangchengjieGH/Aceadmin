<?php

/**
 *  
 * @file   GroupController.php  
 * @date   2016-9-1 15:11:41 
 */

namespace app\admin\controller;

class GroupController extends CommonController {
    /**
     * [index description]
     * @date   2018-04-01
     * @return [type]
     */
    public function index() {
        $res = db('admin_group')->select();
        $this->assign('lists', $res);
        $html = $this->fetch('/Group/index');
        return re_json(0,$html);
    }
    /**
     * [info description]
     * @date   2018-04-01
     * @return [type]
     */
    public function info() {
        $id = input('id');
        if ($id) {
            //当前用户信息
            $info = db('admin_group')->find($id);
            $this->assign('info', $info);
        }

        $html = $this->fetch('/Group/info');
        return re_json(0,$html);
    }

    /**
     * [add description]
     * @date 2018-04-01
     */
    public function add() {
        $data = input();
        $res = model('Admin_group')->allowField(true)->save($data);
        if ($res) {
            $res = db('admin_group')->select();
            $this->assign('lists', $res);
            $html = $this->fetch('/Group/index');
            return re_json(0,$html);
        } else {
            return re_json(1,'操作失败啦'); 
        }
    }

    /*
     * 修改
     */

    public function edit() {
        $data = input();
        $data['updatetime'] = time();
        $res = model('Admin_group')->allowField(true)->save($data, ['id' => $data['id']]);
        if ($res) {
            $res = db('admin_group')->select();
            $this->assign('lists', $res);
            $html = $this->fetch('/Group/index');
            return re_json(0,$html);
        } else {
            return re_json(1,'操作失败啦'); 
        }
    }

    /*
     * 删除
     */

    public function del() {
        $id = input('id');
        $res = db('admin_group')->where(['id' => $id])->delete();
        if ($res) {
            db('admin_group_access')->where(['group_id'=>$id])->delete();
            $html = $this->fetch('/Group/index');
            return re_json(0,$html);
        } else {
            return re_json(1,'操作失败啦'); 
        }
    }

    /**
     * 权限
     */
    public function rule() {

        //echo APP_PATH;exit;
        if (input('id')) {
            $gid = input('id');
            $rules = db('admin_group')->where('id',$gid)->value('rules');
            $this->assign('rules',$rules);
            
            $menu = db('menu')->order('listorder asc')->select();
            $this->assign('menu', list_to_tree($menu));
            $html =  $this->fetch('/Group/rule');
            return re_json(0,$html);
        }
    }

    public function editRule() {
        $post = input();
        if ($post['id']) {
            $where = ['id' => $post['id']];

            $rules = implode(',', $post['rules']);
            $data = array();
            $data['updatetime'] = time();
            $data['rules'] = $rules;
            $res = model('admin_group')->save($data, $where);

            if ($res) {
                $res = db('admin_group')->select();
                $this->assign('lists', $res);
                $html = $this->fetch('/Group/index');
                return re_json(0,$html);
            } else {
                return re_json(1,'操作失败啦'); 
            }
        }
    }

}
