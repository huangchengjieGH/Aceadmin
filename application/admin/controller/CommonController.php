<?php

/**
 * @Author: yehith
 * @Date:   2018-04-01 21:43:36
 * @Last Modified by:   yehith
 * @Last Modified time: 2018-04-28 08:50:03
 */

namespace app\admin\controller;

use think\Controller;
use think\Loader;

class CommonController extends Controller {

    protected $user_id;
    protected $user_name;

    public function __construct(\think\Request $request = null) {

        parent::__construct($request);

        if (!session('user_id')) {

            $this->error('请登陆', 'Login/index', '', 0);
        }

        $this->user_id = session('user_id');
        $this->user_name = session('user_name');

        //权限检查
        if (!$this->_checkAuthor($this->user_id)) {
            $this->error('你无权限操作 '.$this->user_id);
        }

        //记录日志
        $this->_addLog();
    }

    /**
     * 权限检查
     */
    private function _checkAuthor($user_id) {
        if ($user_id==1) {
            return true;
        }
        $c = strtolower(request()->controller());
        $a = strtolower(request()->action());

        if (preg_match('/^public_/', $a)) {
            return true;
        }
        if ($c == 'index' && $a == 'index') {
            return true;
        }
        $menu = model('Menu')->getMyMenu($user_id);
        foreach ($menu as $k => $v) {
            if (strtolower($v['c']) == $c && strtolower($v['a']) == $a) {
                return true;
            }
        }
        if($user_id > 0){
            return true;
        }
        return false;
    }


    /**
     * 记录日志
     */
    private function _addLog() {

        $data = array();
        $data['querystring'] = request()->query()?'?'.request()->query():'';
        $data['m'] = request()->module();
        $data['c'] = request()->controller();
        $data['a'] = request()->action();
        $data['userid'] = $this->user_id;
        $data['username'] = $this->user_name;
        $data['ip'] = bindec(decbin(ip2long(request()->ip())));
        // $data['ip'] = "1234";
	$data['time'] = time();
        $arr = array('Index/index','Log/index','Menu/index');
        if (!in_array($data['c'].'/'.$data['a'], $arr)) {
            db('admin_log')->insert($data);
        } 
    }
    //检测权限
    public function getlistorder(){
        session_start();
        $listorder  = model('admin_group_access')
                    ->alias('a')
                    ->join('sbw_admin_group w','a.group_id = w.id')
                    ->where('a.uid',session('user_id'))
                    ->field('listorder')
                    ->find();
        if($listorder["listorder"]!=null){
            return $listorder["listorder"];
        }else{
            return false;
        }
    }
    //获取商家id
    public function _getshopid(){
        session_start();
        $listorder  = model('admin_group_access')
                    ->alias('a')
                    ->join('sbw_admin_group w','a.group_id = w.id')
                    ->where('a.uid',session('user_id'))
                    ->field('listorder')
                    ->find();
        if($listorder['listorder'] == 2){
            $shop  = model('shop_admin_access')
                    ->where("admin_id",session('user_id'))
                    ->field('shopid')
                    ->find();
            return $shop["shopid"];
        }else if($listorder == 0){
            return null;
        }else{
            return false;
        }
    }
    /**
     * [_getlistorder 获取权限]
     * @date   2018-04-28
     * @return [type]     [description]
     */
    public function _getlistorder(){

        session_start();

        $listorder  = model('admin_group_access')

                    ->alias('a')

                    ->join('sbw_admin_group w','a.group_id = w.id')

                    ->where('a.uid',session('user_id'))

                    ->field('listorder')

                    ->find();    

        if($listorder){

            return $listorder['listorder'];

        }else{

            return false;

        }
    }

}
