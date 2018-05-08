<?php

/**
 *  
 * @file   LogController.php  
 * @date   2016-10-9 18:23:24 
 */

namespace app\admin\controller;
use think\Loader;

class LogController extends CommonController {
	private static $page_size = 15;
    public function index() {
        $where = array();
        $page = $_POST['num']?$_POST['num']:0; 
        $amount = $_SESSION['pagecount'] = db('admin_log')->count();
        $page_count =  (int)($amount / self::$page_size) + 1;
        if($_SESSION['pagecount']<(($page+1)*self::$page_size)){
            $this->assign('N_flag',0);
        }else{
           $this->assign('N_flag',1);  
        }
        $lists = db("admin_log")->where($where)->order('id desc')->limit($page*self::$page_size,self::$page_size)->select();
	
        $this->assign("page_count",$page_count);  
        $this->assign('lists', $lists);
        $this->assign('page', $page);  
        $html =  $this->fetch('/Log/index');
        return re_json(0,$html);
    }
}
