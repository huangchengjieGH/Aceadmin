<?php

/**
 *  登陆页
 * @file   Login.php  
 * @date   2016-8-23 19:52:46 
 */

namespace app\admin\controller;

use think\Controller;
use think\Loader;

class LoginController extends Controller {

    /**
     * 登入
     */
    public function index() {
        // dump(request()->ip());exit;

        // dump(request()->ip());exit;

        if ($_POST['dosubmit']) {
            $username = input('post.username');
            $password = input('post.password');

            if (!$username) {
                $this->error('用户名不能为空');
            }
            if (!$password) {
                $this->error('密码不能为空');
            }

            $info = db('admin')->field('id,username,password')->where('username', $username)->find();

            if (!$info) {
                $this->error('用户不存在');
            }

            if (md5($password) != $info['password']) {
                $this->error('密码不正确');
            } else {
                session('user_name', $info['username']);
                session('user_id', $info['id']);
                $info_g = db("admin_group_access")->field("group_id")->where("uid",$info["id"])->find();
                session('group_id',$info_g["group_id"]);
                if (input('post.islogin')) {
                    cookie('user_name', encry_code($info['username']));
                    cookie('user_id', encry_code($info['id']));
                    cookie('group_id', encry_code($info_g['group_id']));
                }

                //记录登录信息
                Loader::model('Admin')->editInfo(1, $info['id']);
                $this->redirect('/admin/Index/index',302);
            }
        } else {
            if (session('user_name')) {
                $this->success('您已登入', 'Index/index');
            }

            if (cookie('user_name')) {
                $username = encry_code(cookie('user_name'),'DECODE');
                $info = db('admin')->field('id,username,password')->where('username', $username)->find();
                $info_g = db("admin_group_access")->field("group_id")->where("uid",$info["id"])->find();
                if ($info) {
                    //记录
                    session('user_name', $info['username']);
                    session('user_id', $info['id']);
                    cookie('group_id', encry_code($info_g['group_id']));
                    Loader::model('Admin')->editInfo(1, $info['id']);
                    return $this->fetch('/Index/index');
                }
            }

            $this->view->engine->layout(false);
            return $this->fetch('/Login/login');
        }
    }

    /**
     * 登出
     */
    public function logout() {
        session('user_name', null);
        session('user_id', null);
        cookie('user_name', null);
        cookie('user_id', null);
        $this->redirect('/admin/Login/index',302);
    }

    public function register() {
        $data = db("shop")->field("longitude,latitude,shop_name,shop_pic")->select();
        foreach ($data as $key => $value) {
            $data[$key]["longitude"] = $value["longitude"]/1000000;   
            $data[$key]["latitude"] = $value["latitude"]/1000000; 
        }
        // var_dump($data[0]["longitude"]);die();
        $this->assign("lists",$data);
        return $this->fetch('/Login/register');
    }
}
