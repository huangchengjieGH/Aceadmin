<?php

// 应用公共文件
function p($str) {
    echo '<pre>';
    print_r($str);
}

function nodeTree($arr, $id = 0, $level = 0) {
    static $array = array();
    foreach ($arr as $v) {
        if ($v['parentid'] == $id) {
            $v['level'] = $level;
            $array[] = $v;
            nodeTree($arr, $v['id'], $level + 1);
        }
    }
    return $array;
}

/**
 * 数组转树
 * @param type $list
 * @param type $root
 * @param type $pk
 * @param type $pid
 * @param type $child
 * @return type
 */
function list_to_tree($list, $root = 0, $pk = 'id', $pid = 'parentid', $child = '_child') {
    // 创建Tree
    $tree = array();
    if (is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] = &$list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId = 0;
            if (isset($data[$pid])) {
                $parentId = $data[$pid];
            }
            if ((string) $root == $parentId) {
                $tree[] = &$list[$key];
            } else {
                if (isset($refer[$parentId])) {
                    $parent = &$refer[$parentId];
                    $parent[$child][] = &$list[$key];
                }
            }
        }
    }
    return $tree;
}
/**
 * 菜单数组
 * @param type $list
 */
function list_to_menu($list) {
    // 创建父数组
    $tree = array();
    if (is_array($list)) {
        foreach ($list as $key => $val) {
            $i = $val['parentid'];
            if($i == 0){
                $tree['parent'][]=$val;
            }else{
               $tree['child']["$i"][]=$val; 
            }
        }
    }
    return $tree;
}

/**
 * 下拉选择框
 */
function select($array = array(), $id = 0, $str = '', $default_option = '') {
    $string = '<select ' . $str . '>';
    $default_selected = (empty($id) && $default_option) ? 'selected' : '';
    if ($default_option)
        $string .= "<option value='' $default_selected>$default_option</option>";
    if (!is_array($array) || count($array) == 0)
        return false;
    $ids = array();
    if (isset($id))
        $ids = explode(',', $id);
    foreach ($array as $key => $value) {
        $selected = in_array($key, $ids) ? 'selected' : '';
        $string .= '<option value="' . $key . '" ' . $selected . '>' . $value . '</option>';
    }
    $string .= '</select>';
    return $string;
}

/**
 * 复选框
 * 
 * @param $array 选项 二维数组
 * @param $id 默认选中值，多个用 '逗号'分割
 * @param $str 属性
 * @param $defaultvalue 是否增加默认值 默认值为 -99
 * @param $width 宽度
 */
function checkbox($array = array(), $id = '', $str = '', $defaultvalue = '', $width = 0, $field = '') {
    $string = '';
    $id = trim($id);
    if ($id != '')
        $id = strpos($id, ',') ? explode(',', $id) : array($id);
    if ($defaultvalue)
        $string .= '<input type="hidden" ' . $str . ' value="-99">';
    $i = 1;
    foreach ($array as $key => $value) {
        $key = trim($key);
        $checked = ($id && in_array($key, $id)) ? 'checked' : '';
        if ($width)
            $string .= '<label class="ib" style="width:' . $width . 'px">';
        $string .= '<input type="radio" ' . $str . ' id="' . $field . '_' . $i . '" ' . $checked . ' value="' . $key . '"> ' . $value;
        if ($width)
            $string .= '</label>';
        $i++;
    }
    return $string;
}

/**
 * 单选框
 * 
 * @param $array 选项 二维数组
 * @param $id 默认选中值
 * @param $str 属性
 */
function radio($array = array(), $id = 0, $str = '', $width = 0, $field = '') {
    $string = '';
    foreach ($array as $key => $value) {
        $checked = trim($id) == trim($key) ? 'checked' : '';
        if ($width)
            $string .= '<label class="ib" style="width:' . $width . 'px">';
        $string .= '<input type="radio" ' . $str . ' id="' . $field . '_' . $key . '" ' . $checked . ' value="' . $key . '"> ' . $value;
        if ($width)
            $string .= '</label>';
    }
    return $string;
}
/**
 * 返回的json
 * 
 * @param $status 状态值 0为成功，1为失败，其他自己想
 * @param $html 字符串，可以是信息，也可以是html
 */
function re_json($status,$html) {
    $res['status'] = $status;
    $res['html'] = $html;
    return json_encode($res);
}

/**
 * 字符串加密、解密函数
 *
 *
 * @param	string	$txt		字符串
 * @param	string	$operation	ENCODE为加密，DECODE为解密，可选参数，默认为ENCODE，
 * @param	string	$key		密钥：数字、字母、下划线
 * @param	string	$expiry		过期时间
 * @return	string
 */
function encry_code($string, $operation = 'ENCODE', $key = '', $expiry = 0) {
    $ckey_length = 4;
    $key = md5($key != '' ? $key : config('encry_key'));
    $keya = md5(substr($key, 0, 16));
    $keyb = md5(substr($key, 16, 16));
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) : substr(md5(microtime()), -$ckey_length)) : '';

    $cryptkey = $keya . md5($keya . $keyc);
    $key_length = strlen($cryptkey);

    $string = $operation == 'DECODE' ? base64_decode(strtr(substr($string, $ckey_length), '-_', '+/')) : sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
    $string_length = strlen($string);

    $result = '';
    $box = range(0, 255);

    $rndkey = array();
    for ($i = 0; $i <= 255; $i++) {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }

    for ($j = $i = 0; $i < 256; $i++) {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }

    for ($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
    }

    if ($operation == 'DECODE') {
        if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {
            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        return $keyc . rtrim(strtr(base64_encode($result), '+/', '-_'), '=');
    }
}

/**
 * 传入日期格式或时间戳格式时间，返回与当前时间的差距，如1分钟前，2小时前，5月前，3年前等
 * @param string or int $date 分两种日期格式"2013-12-11 14:16:12"或时间戳格式"1386743303"
 * @param int $type
 * @return string
 */
function formatTime($date = 0, $type = 1) { //$type = 1为时间戳格式，$type = 2为date时间格式
    date_default_timezone_set('PRC'); //设置成中国的时区
    switch ($type) {
        case 1:
            //$date时间戳格式
            $second = time() - $date;
            $minute = floor($second / 60) ? floor($second / 60) : 1; //得到分钟数
            if ($minute >= 60 && $minute < (60 * 24)) { //分钟大于等于60分钟且小于一天的分钟数，即按小时显示
                $hour = floor($minute / 60); //得到小时数
            } elseif ($minute >= (60 * 24) && $minute < (60 * 24 * 30)) { //如果分钟数大于等于一天的分钟数，且小于一月的分钟数，则按天显示
                $day = floor($minute / ( 60 * 24)); //得到天数
            } elseif ($minute >= (60 * 24 * 30) && $minute < (60 * 24 * 365)) { //如果分钟数大于等于一月且小于一年的分钟数，则按月显示
                $month = floor($minute / (60 * 24 * 30)); //得到月数
            } elseif ($minute >= (60 * 24 * 365)) { //如果分钟数大于等于一年的分钟数，则按年显示
                $year = floor($minute / (60 * 24 * 365)); //得到年数
            }
            break;
        case 2:
            //$date为字符串格式 2013-06-06 19:16:12
            $date = strtotime($date);
            $second = time() - $date;
            $minute = floor($second / 60) ? floor($second / 60) : 1; //得到分钟数
            if ($minute >= 60 && $minute < (60 * 24)) { //分钟大于等于60分钟且小于一天的分钟数，即按小时显示
                $hour = floor($minute / 60); //得到小时数
            } elseif ($minute >= (60 * 24) && $minute < (60 * 24 * 30)) { //如果分钟数大于等于一天的分钟数，且小于一月的分钟数，则按天显示
                $day = floor($minute / ( 60 * 24)); //得到天数
            } elseif ($minute >= (60 * 24 * 30) && $minute < (60 * 24 * 365)) { //如果分钟数大于等于一月且小于一年的分钟数，则按月显示
                $month = floor($minute / (60 * 24 * 30)); //得到月数
            } elseif ($minute >= (60 * 24 * 365)) { //如果分钟数大于等于一年的分钟数，则按年显示
                $year = floor($minute / (60 * 24 * 365)); //得到年数
            }
            break;
        default:
            break;
    }
    if (isset($year)) {
        return $year . '年前更新';
    } elseif (isset($month)) {
        return $month . '月前更新';
    } elseif (isset($day)) {
        return $day . '天前更新';
    } elseif (isset($hour)) {
        return $hour . '小时前更新';
    } elseif (isset($minute)) {
        return $minute . '分钟前更新';
    }
}
/**
 * PHP发送Json对象数据
 *
 * @param $url 请求url
 * @return array
 */
function http_post_json($url)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    $response = curl_exec($ch);
    curl_close($ch);
 
    return $response;
}
/*
*验证码生成
 */
function captcha() {
    session_start();
    $captcha=''; //验证码
    $image=imagecreatetruecolor(100,30);
    $bgcolor=imagecolorallocate($image,0xFF,0xFF,0xFF); //白色背景
     
    imagefill($image,0,0,$bgcolor); //用白色背景填充图片
     
    //产生验证码的内容
    for($i=0;$i<4;$i++) {
        $fontsize=5; //字体大小
        $fontcolor=imagecolorallocate($image,0x00,0x00,0x00); //字体颜色-黑色
        $data='vw234fg89tus5xnhbkmjpqra7cde6y'; //内容字典
        $fontcontent=substr($data,rand(0,strlen($data)-1),1); //产生验证码内容
        $captcha.=$fontcontent;
         
        $x=($i*100/4)+rand(5,8); //坐标
        $y=8; //坐标
         
        imagestring($image,$fontsize,$x,$y,$fontcontent,$fontcolor); //输出验证码的内容
    }
     
    $_SESSION["authcode"]=$captcha;
     
    //增加干扰点
    for($i=0;$i<200;$i++) {
        $pointcolor=imagecolorallocate($image,rand(0,255),rand(0,255),rand(0,255));
        imagesetpixel($image,rand(0,200),rand(0,60),$pointcolor);
    }
     
    //增加干扰线
    for($i=0;$i<3;$i++) {
        $linecolor=imagecolorallocate($image,rand(0,255),rand(0,255),rand(0,255));
        imageline($image,rand(0,100),rand(0,30),rand(0,100),rand(0,30),$linecolor);
 
    }
     
    header('Content-Type:image/png'); //发送原生HTTP头
    // echo $captcha;
    imagepng($image); //以png格式显示图片
    imagedestroy($image); //销毁图像
}
/*
*通过经纬度计算位置距离
 */
function getAround($longitude,$latitude){
        $PI = 3.14159265;
        //纬度
        $latitude = $latitude;
        //经度
        $longitude = $longitude;
        
        $degree = (24901*1609)/360.0;
        //半径（单位米）
        $raidusMile = 500;

        $dpmLat = 1/$degree;
        $radiusLat = $dpmLat*$raidusMile;

        $local['minLat'] = ($latitude - $radiusLat)*1000000;
        $local['maxLat'] = ($latitude + $radiusLat)*1000000;

        $mpdLng = $degree*cos($latitude * ($PI/180));

        $dpmLng = 1 / $mpdLng;
        $radiusLng = $dpmLng*$raidusMile;

        $local['minLng'] = ($longitude - $radiusLng)*1000000;
        $local['maxLng'] = ($longitude + $radiusLng)*1000000;
        
        return $local;
    }
/*
*上传文件
 */
function upload_img($filesname,$filetran){
    $file = $filetran?$filetran:null;
    $pre_file = config('public.uploadfile');
    // var_dump($pre_file);die();
    $path=$pre_file."/public/uploads/".$filesname."/".date("Y-m-d",time())."/";
    $path2 = "/uploads"."/".$filesname."/".date("Y-m-d",time())."/";
    if(!file_exists($pre_file."/public/uploads/")){
        mkdir($pre_file."/public/uploads/", 0777);  
        chmod($pre_file."/public/uploads/", 0777);
    }
    if(!file_exists($pre_file."/public/uploads/".$filesname."/")){
        mkdir($pre_file."/public/uploads/".$filesname."/", 0777);  
        chmod($pre_file."/public/uploads/".$filesname."/", 0777);
    }
    if(!file_exists($path))   
    {   
    //检查是否有该文件夹，如果没有就创建，并给予最高权限
        mkdir($path, 0777);  
        chmod($path, 0777); 
    }//END IF 
    //允许上传的文件格式   
    $tp = array("image/jpeg","image/jpg","image/png");   
    //检查上传文件是否在允许上传的类型   
      
    if(!in_array($file["type"],$tp))   
    {   
        return null;  
    }//END IF   
      
    if($file["name"])   
    {   
        $file1=$file["name"];
        $str = strrev($file1);
        $arr = explode(".",$str);
        $str_2 = strrev($arr[0]);
        $str_3 = time().rand(100,1000);
        $file2 = $path.$str_3.".".$str_2; 
        $file3 = $path2.$str_3.".".$str_2;   
        $flag=1;   
    }//END IF   
      
    if($flag){ 
        $result=move_uploaded_file($file["tmp_name"],$file2);
    }  
      
    //特别注意这里传递给move_uploaded_file的第一个参数为上传到服务器上的临时文件   
    if($result)   
    {   
    //echo "上传成功!".$file2;   
        return $file3;  
    } 
}
/*
*字符窜分解
 */
function string_ex($str){
    $arr = explode(",",$str);
    return $arr;
}
/**
 * 计算两点地理坐标之间的距离
 * @param  Decimal $longitude1 起点经度
 * @param  Decimal $latitude1  起点纬度
 * @param  Decimal $longitude2 终点经度 
 * @param  Decimal $latitude2  终点纬度
 * @param  Int     $unit       单位 1:米 2:公里
 * @param  Int     $decimal    精度 保留小数位数
 * @return Decimal
 */
function getDistance($longitude1, $latitude1, $longitude2, $latitude2, $unit=2, $decimal=2){

    $EARTH_RADIUS = 6370.996; // 地球半径系数
    $PI = 3.1415926;

    $radLat1 = $latitude1 * $PI / 180.0;
    $radLat2 = $latitude2 * $PI / 180.0;

    $radLng1 = $longitude1 * $PI / 180.0;
    $radLng2 = $longitude2 * $PI /180.0;

    $a = $radLat1 - $radLat2;
    $b = $radLng1 - $radLng2;

    $distance = 2 * asin(sqrt(pow(sin($a/2),2) + cos($radLat1) * cos($radLat2) * pow(sin($b/2),2)));
    $distance = $distance * $EARTH_RADIUS * 1000;

    if($unit==2){
        $distance = $distance / 1000;
    }

    return round($distance, $decimal);

}

function  get_status_name($tra_id){

        $status["status"] = array('1' ,'2','3','4','5','6','-1','-3');

        $names = array("未支付","未派送","待收货","待评价",'交易完成','订单关闭','发起退单',"交易关闭");

        $name = '异常状态';

        foreach ($status['status'] as $key => $value) {

            if($tra_id == $value){

                $name = $names[$key];

            }

        }
        
        return $name;
    }

