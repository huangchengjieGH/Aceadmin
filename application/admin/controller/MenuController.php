<?php

/**
 *  
 * @file   Menu.php  
 * @date   2016-8-30 11:46:22 
 */

namespace app\admin\controller;

use think\Loader;

class MenuController extends CommonController {

    public function index() {
        $res = db('menu')->order('listorder asc')->select();
	
        $lists = nodeTree($res);
        $this->assign('lists', $lists);
        $html = $this->fetch('/Menu/index');
        return re_json(0,$html);
    }

    /*
     * 查看
     */
    public function look() {
        $res = db('menu')->order('listorder asc')->select();
    
        $lists = nodeTree($res);
        $this->assign('lists', $lists);
        $html = $this->fetch('/Menu/Look');
        return re_json(0,$html);
    }
    public function info() {


        $id = input('id');
        if ($id) {
            //当前用户信息
            $info = db('menu')->find($id);
            $this->assign('info', $info);
        }

        //下拉菜单
        $this->assign('selectMenu', Loader::model('Menu')->selectMenu());
        $html = $this->fetch('/Menu/info');
        return re_json(0,$html);
    }

    /*
     * 添加
     */

    public function add() {
        $data = input();
        if ($data['parentid'] == null) {
            $data['parentid'] = 0;
        }
        $res = model('menu')->allowField(true)->save($data);
        if ($res) {
            $res = db('menu')->order('listorder asc')->select();
    
            $lists = nodeTree($res);
            $this->assign('lists', $lists);
            $html = $this->fetch('/Menu/index');
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
        if ($data['parentid'] == null) {
            $data['parentid'] = 0;
        }

        $res = model('menu')->allowField(true)->save($data, ['id' => $data['id']]);
        if ($res) {
            $res = db('menu')->order('listorder asc')->select();
    
            $lists = nodeTree($res);
            $this->assign('lists', $lists);
            $html = $this->fetch('/Menu/index');
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
        $res = db('menu')->where(['id' => $id])->delete();
        if ($res) {
            $res = db('menu')->order('listorder asc')->select();
    
            $lists = nodeTree($res);
            $this->assign('lists', $lists);
             $html = $this->fetch('/Menu/index');
            return re_json(0,$html);
        } else {
            return re_json(1,'操作失败啦');
        }
    }

    /**
     * 排序
     */
    public function setListorder() {

        // print_r($_POST);die();
        if ($_POST['listorder']) {
            $listorder = $_POST['listorder'];
            foreach ($listorder as $k => $v) {
                $data = array();
                $data['listorder'] = $v;
                $data['updatetime'] = time();
                $res = db('menu')->where(['id' => $k])->update($data);
            }
            if ($res) {
                $res = db('menu')->order('listorder asc')->select();
    
                $lists = nodeTree($res);
                $this->assign('lists', $lists);
               return re_json(0,'刷新中');
            } else {
                return re_json(1,'操作失败啦');
            }
        }
    }

}
