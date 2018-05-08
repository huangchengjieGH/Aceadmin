<?php	
/**
 *  后台继承类
 * @file   Admin.php  
 * @date   2016-8-23 19:45:21 
 */
namespace app\admin\controller;

use think\Loader;

class ShoperinfoController extends CommonController {
	/**
	 * @Author  yehith
	 * @date    2018-04-01
	 * @version 版本号v1.0
	 * @return  json[status,数组]
	 * @return  [type]
	 */
	public function index(){
		if(session('user_id') == 1){
			$lists = db('Shoperinfo')->select();
	        $this->assign('lists', $lists);
			$html =  $this->fetch('/Shoperinfo/index');
	        return re_json(0,$html);
		}else{

		$data_s = db('admin')
				->alias('a')
				->join('sbw_shop w','a.mobile = w.shop_phone')
				->where('a.id',session('user_id'))
				->select();
		$data['shop_id']=$data_s[0]['shop_id'];

		$lists = db('Shoperinfo')->where("shop_id",$data['shop_id'])->select();
        $this->assign('lists', $lists);
		$html =  $this->fetch('/Shoperinfo/index');
        return re_json(0,$html);
		}
	}
	/**
	 * 跳转
	 */
	public function add(){
		$html =  $this->fetch('/Shoperinfo/info');
        return re_json(0,$html);
	}
	/**
	 * [add_info description]
	 * 添加操作
	 */
	public function add_info(){
		$data = input();
		$listorder 	= model('admin_group_access')
					->alias('a')
					->join('sbw_admin_group w','a.group_id = w.id')
					->where('a.uid',session('user_id'))
					->field('listorder')
					->find();
		if($listorder['listorder'] == 2){
			$data_s = db('admin')
					->alias('a')
					->join('sbw_shop w','a.mobile = w.shop_phone')
					->where('a.id',session('user_id'))
					->select();
			$data['shop_id']=$data_s[0]['shop_id'];

			//查询骑手称呼是否存在同名
	        $count = db('Shoperinfo')->where('name', $data['name'])->count();

	        $res = model('shoperinfo')->allowField(true)->save($data);

	        if ($res) {
	            $lists =  db('Shoperinfo')->where("shop_id",$data['shop_id'])->select();;
	            $this->assign('lists', $lists);
				$html =  $this->fetch('/Shoperinfo/index');
	            return re_json(0,$html);
	        } else {
	            return re_json(1,'操作失败'); 
	        }
		}else{

			return re_json(1,'你不是水店');
		}
        
	}
}
?>