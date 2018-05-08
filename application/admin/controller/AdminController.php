<?php

/**
 *  后台继承类
 * @file   Admin.php  
 * @date   2016-8-23 19:45:21 
 */

namespace app\admin\controller;

use think\Loader;
use app\admin\controller\IndexController;

class AdminController extends CommonController {

    public function index() {
        
        $where = array();
        $group_id = input('group_id')?input('group_id'):4;

        if ($group_id) {
            $where['t2.group_id'] = $group_id;            
        }
        $lists = db('admin')->alias('t1')
                ->where($where)
                ->join(config('database.prefix').'admin_group_access t2', 't1.id=t2.uid')
                ->join(config('database.prefix').'admin_group t3','t2.group_id=t3.id')
                ->field('t1.*,t3.name')
                ->order('t1.id desc')
                ->select();
        $group_N = db('admin_group')->field('id,name')->select();
        $people_count = db('admin')->alias('t1')
                ->where($where)
                ->join(config('database.prefix').'admin_group_access t2', 't1.id=t2.uid')
                ->count();
        $this->assign('people_count',$people_count);
        $this->assign('select_id',$group_id);
        $this->assign('group_N',$group_N);
        $this->assign('lists', $lists);
        $html = $this->fetch('/Admin/index');
        return re_json(0,$html); 
    }

    /*
     * 查看
     */

    public function info() {
        $id = input('id');
        if ($id) {
            //当前用户信息
            $info = model('Admin')->getInfo($id);
            $info['userGroups'] = Loader::model('Admin')->getUserGroups($id);
            $this->assign('info', $info);
        }

        //所有组信息
        $groups = model('AdminGroup')->getGroups();

        $this->assign('groups', $groups);
        $html = $this->fetch('/Admin/info');
        return re_json(0,$html); 
    }

    /*
     * 添加
     */

    public function add() {
        $data = input();
        $data['lastlogintime'] = time();
        $count = db('admin')->where('username', $data['username'])->count();

        if ($count) {
            $info = '该名字已存在!';
            return re_json(1,$info);         }

        if ($data['password'] != $data['rpassword']) {
            $info = '两次密码不一致!';
            return re_json(1,$info); 
        }

        $data['password'] = md5($data['password']);

        $res = model('Admin')->allowField(true)->save($data);

        if ($res) {
            if (isset($data['groups'])) {
                $uid = model('Admin')->id;
                db('admin_group_access')->insert(['uid' => $uid, 'group_id' => $data['groups']]);
            }
            $index = $this->index();
            return $index;
        } else {
            return re_json(1,'操作失败'); 
        }
    }

    /*
     * 修改
     */

    public function edit() {
        $data = input();
        db('admin_group_access')->where(['uid' => $data['id']])->delete();

        if (isset($data['groups'])) {
            db('admin_group_access')->insert(['uid' => $data['id'], 'group_id' => $data['groups']]);
        }


        if (!$data['password']) {
            unset($data['password']);
        } else {
            if ($data['password'] != $data['rpassword']) {
                $info = '两次密码不一致!';
                return re_json(1,$info); 
            }
            $data['password'] = md5($data['password']);
        }

        $res = Loader::model('Admin')->editInfo(2, $data['id'], $data); 
        if ($res) {
            // $lists =  Loader::model('Admin')->getGroupInfo();
            //  $this->assign('lists', $lists);
            //  $html = $this->fetch('/Admin/index');
            // return re_json(0,$html);
            $index = $this->index();
            return $index;
        } else {
           return re_json(1,'操作失败啦'); 
        }
    }

    /*
     * 删除
     */

    public function del() {
        $id = input('id');
        $res = db('admin')->where(['id' => $id])->delete();
        if ($res) {
            db('admin_group_access')->where(['uid' => $id])->delete();
            $index = $this->index();
            return $index;
        } else {
            return re_json(1,'操作失败啦'); 
        }
    }

    /**
     * 修改个人信息
     */
    public function public_edit_info() {
        $data = input();
        if (isset($data['dosubmit'])) {
            if (!$data['password']) {
                unset($data['password']);
            } else {
                if ($data['password'] != $data['rpassword']) {
                    $info = '两次密码不一致!';
                    return re_json(1,$info);
                }
                $data['password'] = md5($data['password']);
            }

            $res = Loader::model('Admin')->editInfo(2, $this->user_id, $data);

            if ($res) {
               $index = new IndexController();
                $html = $index->index_mod();
                return $html;
            } else {
                return re_json(1,'操作失败啦'); 
            }
        } else {
            $info = db('admin')->where('id', $this->user_id)->find();
            $this->assign('info', $info);
            $html= $this->fetch('/Admin/public_edit_info');
            return re_json(0,$html);
        }
    }

}
