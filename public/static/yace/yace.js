//返回的是对象
function serializeForm_jq(formId){
  var $input = $(formId+' input');
  var data = {};
  $input.each(function(index,ele){
      var name = $input.eq(index).attr('name');
      var val = $input.eq(index).val();
      if($input.eq(index).attr('type') =='checkbox'){
          if($input.eq(index).is(':checked')){
          if(data[name]==null || data[name] == ''){ 
            data[name] = new Array();
            data[name].push(val);
          }else{
            data[name].push(val);
          }
        }
      }else if($input.eq(index).attr('type') =='radio'){
          if($input.eq(index).is(':checked')){
            data[name] = val;
          }
      }else{
      data[name] = val;
      }
  });
  return data;
}

function re_json(url,data,callback){
      var data = arguments[1]?arguments[1]:{};
      layer.closeAll();
       if(url != '/admin//'){
         $.post(url,data,function(res){
            if(res!=null){
                $res = $.parseJSON(res);
                if($res.status==0){
                    callback($res.html);
                }else if($res.status==1){
                    layer.msg($res.html);
                }else{
                    layer.msg('完善中。。。');
                }
            }
        });
       }else{

       }
}
//多文件上传
function upflie_ajax(url_N,data,filename){
  var formData = new FormData();
  var data = data?data:{};
  var filename = filename?filename:[];
  var url_N = url_N;
  if(filename !=null){
    for(var i = 0;i<filename.length;i++){
      // console.log($(filename[i])[0].files[0]);
      formData.append(filename[i],$(filename[i])[0].files[0]);
    }
  }
  if(data !=null){
    for(var i = 0;i<data.length;i++){
      formData.append(data[i].name,data[i].val);
    }
  } 
  $.ajax({ 
      url : url_N, 
      type : 'POST', 
      data : formData, 
      // 告诉jQuery不要去处理发送的数据
      processData : false, 
      // 告诉jQuery不要去设置Content-Type请求头
      contentType : false,
      beforeSend:function(){
      },
      success : function(res) { 
        if(res!=null){
            $res = $.parseJSON(res);
            if($res.status==0){
                layer.msg($res.html);
                window.location.href='/admin/login/index';
            }else if($res.status>0){
                layer.msg($res.html);
            }else{
                layer.msg('完善中。。。');
            }
          }
      }, 
      error : function(res) { 
        layer.msg('本地文件出错，请尝试刷新后注册！');
      } 
      }); 
}
//验证信息,标签选择器,规则名,是否检验为空
function check_info(input_id,rule_name,f){
  var $input = $(input_id);
  var name = rule_name?rule_name:null;
  var flag = f?f:0;
  var rule = {
    "phone":/^1[34578]\d{9}$/,
    "password":/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/,
    "email":/^[0-9A-Za-z][\.-_0-9A-Za-z]*@[0-9A-Za-z]+(\.[0-9A-Za-z]+)+$/,
    "number":/^-?\d+$/,
  };
  var rule_tip = {
    "phone":"请填写正确的手机号",
    "password":"密码长度为8-16位且必须由字母和数字组成",
    "email":"请填写正确的邮箱",
    "number":'请填入整数'
  }
  var str = $input.val(); 
  if(flag){
      if($input.val() == ""){
          layer.tips('这里不能为空', input_id,{
            tips: [1, '#000'],
            time: 4000
          });
      }
    }
  if(name!=null){
    var reg = rule[name];
       
    if(!reg.test(str)){
      layer.tips(rule_tip[name], input_id,{
            tips: [1, '#000'],
            time: 4000
          });
    }
  }
}

//首页基本菜单功能
function menutab(url,data){
    var data = arguments[1]?arguments[1]:{};
    layer.closeAll();
     if(url != '/admin//'){
       $.post(url,data,function(res){
          if(res!=null){
              $res = $.parseJSON(res);
              if($res.status==0){
                  $('.wrap-fluid .container-fluid').html($res.html);
              }else if($res.status==1){
                  layer.msg($res.html);
              }else{
                  layer.msg('完善中。。。');
              }
          }
      });
     }else{

     }
  }
    function del_rec(url,tra_id){
      var tip_str = arguments[2]?arguments[2]:'真的要删掉吗';
      var btn_str = arguments[3]?arguments[3]:'删除';
       if(url != '/admin//'){
         layer.confirm(tip_str, {
         skin: 'layui-layer-molv',
         anim: 2 ,
          btn: [btn_str,'算了'] //按钮
            }, function(index){
                layer.close(index);
               $.post(url,{id:tra_id},function(res){
                    if(res!=null){
                        $res = $.parseJSON(res);
                        if($res.status==0){
                            $('.wrap-fluid .container-fluid').html($res.html);
                        }
                        else if($res.status==1){
                            layer.msg($res.html);
                        }else{
                            layer.msg('完善中。。。');
                        }
                    }
                });
            }, function(){

            });       
       }
    }
    function add_rec(url,op,s){
        var op = arguments[1]?arguments[1]:0;
        var s = arguments[2]?arguments[2]:'';
        var address = arguments[2]?arguments[3]:'';

        var data = serializeForm_jq('.myfrom');

        if(op == 1){
            data[s] = $('.selector').val();
        }
        // console.log(data);
       if(url != '/admin//'){
         $.post(url,data,function(res){
            if(res!=null){
                $res = $.parseJSON(res);
                if($res.status==0){
                    $('.wrap-fluid .container-fluid').html($res.html);
                }
                else if($res.status==1){
                    layer.msg($res.html);
                }else{
                    layer.msg('完善中。。。');
                }
            }
        });
       }
    }
    function myale(str){
        layer.open({
          title: '提示'
          ,content: str
        });  
    }
    //库存提醒
  function stock_tip(){    
    var stock_str = "";
    var $stock_count = $("div.stock_count");
    var $stock_str = $("ul.stock_str");
    var stock_url_str = '\"/admin/Product/send_stock_look\"';
    var orderaudio = document.getElementById("orderbgMusic");
    var getting_stock = {
        url:"/admin/User/query_isstock",
        type:"get",
        dataType:"json",
        success:function(res){
            $res = $.parseJSON(res);
            if($res.status==0){
              stock_str = "";
                $stock_str.html(stock_str);
                for(var i in $res.html.list){
                  stock_str += "<li onclick=\'menutab("+stock_url_str+")\'><a href='javascript:;'>"+i+". "+$res.html.list[i].shop_name+"<span>   剩"+($res.html.list[i].bucket_allnum-$res.html.list[i].bucket_null)+"桶</span></a></li>";
                }
                stock_str += "<li onclick=\'menutab("+stock_url_str+")\'><div>更多</div></li>";
                var flag_music=$stock_count.html();
                if($res.html.count>flag_music){
                  orderaudio.play();
                }
                $stock_count.html($res.html.count);
                $stock_str.html(stock_str);
                orderaudio.currentTime = 0;
            }else{
                $stock_count.html($res.html);
            }
        }
    }
    $.ajax(getting_stock);
    window.setInterval(function(){$.ajax(getting_stock)},600000);
  }
  //d订单提醒
  function order_tip(){    
    var order_str = "";
    var $order_count = $("div.order_count");
    var $order_str = $("ul.order_str");
    var order_url_str = '\"/admin/Order/index\"';
    var orderaudio = document.getElementById("orderbgMusic");
    var getting_order = {
        url:"/admin/Order/query_order",
        type:"get",
        dataType:"json",
        success:function(res){
            $res = $.parseJSON(res);
            if($res.status==0){ 
              order_str = "";
                $order_str.html(order_str);
                for(var i in $res.html.list){
                  order_str += "<li onclick=\'menutab("+order_url_str+")\'><a href='javascript:;'>"+i+". "+$res.html.list[i].o_address+"</a></li>";
                }
                order_str += "<li onclick=\'menutab("+order_url_str+")\'><div>更多</div></li>";
                var flag_music=$order_count.html();
                if($res.html.count>flag_music){
                  orderaudio.play();
                }
                $order_count.html($res.html.count);
                $order_str.html(order_str);
                orderaudio.currentTime = 0;
            }else{
                $order_count.html($res.html);
            }
        }
    }
    $.ajax(getting_order);
    window.setInterval(function(){$.ajax(getting_order)},600000);
  }
//服务点管理
    function look_shop(tra_id){
        var id = arguments[0]?arguments[0]:'';
        var str ="";
        $.post('/admin/Shoper/info_pic', {"shop_id":id}, function(res){
        if(res!=null){
         $res = $.parseJSON(res);
         // console.log($res.html);
         if($res.status == 0){  
          layer.tab({
              area: ['600px', '300px'],
              tab: [{
                title: '营业执照', 
                content: "<img style='width:auto;height:220px;' src='"+$res.html.lience_pic+"'>"
              }, {
                title: '证件照', 
                content: "<img style='width:auto;height:220px;' src='"+$res.html.id_pic+"'>"
              }, {
                title: '实体店门照', 
                content: "<img style='width:auto;height:220px;' src='"+$res.html.shop_pic+"'>"
              }]
            });
                    }else{
          layer.open({
            type: 1,
            content: "" 
          });  
        }
      }
    });
    }
    //审核通过事件
    function ispass(tra_id){
        var id = arguments[0]?arguments[0]:'';
        var str ="";
        $.post('/admin/Shoper/ispass', {"shopid":id}, function(res){
        if(res!=null){
         $res = $.parseJSON(res);
         if($res.status == 0){  
               $('.wrap-fluid .container-fluid').html($res.html);
            }
            else{
                layer.msg($res.html);
            }
          }
        });
    }
    //审核通过事件(通用)
    function ispass_user(url,tra_id){
        var url = arguments[0]?arguments[0]:0;
        var id = arguments[1]?arguments[1]:0;
        var str ="";
        $.post(url, {"info":id}, function(res){
        if(res!=null){
         $res = $.parseJSON(res);
         if($res.status == 0){  
               menutab(url);
            }
            else{
                layer.msg($res.html);
            }
          }
        });
    }
    //派送桶装水事件
    function send_sbw(tra_id,shop_id){
      var id = arguments[0]?arguments[0]:'';
      var shop_id = arguments[1]?arguments[1]:'';
      $.post("/admin/Shoper/shoperinfo",{"shop_id":shop_id},function(res){
        if(res!=null){
         var $res = $.parseJSON(res);
         // console.log($res);
         var str_select = '<div style="width:400px;padding:5px 2px;"><span>配送员选择：</span><select class="select_a" id="select_shoperinfo">';
         for(var i=0;i<$res.html.length;i++){
            str_select += '<option value ="'+$res.html[i].sid+'">'+$res.html[i].realname+'</option>';
         }
         str_select += '</select></div>';
         if($res.status == 0){  
               layer.open({
                type: 1,
                skin: 'layui-layer-molv',
                offset: 'auto',//具体配置参考：offset参数项
                content: str_select,
                btn: '派送',
                btnAlign: 'c' ,//按钮居中,
                shade: 0,
                yes: function(){
                  var num = $("#select_shoperinfo").val();
                  if(id!=null){
                    $.post("/admin/Order/send_sbw",{"orderid":id,'shoper_id':num},function(ress){
                      if(ress!=null){
                       var $ress = $.parseJSON(res);
                       if($res.status == 0){  
                             $('.wrap-fluid .container-fluid').html($ress.html);
                             layer.closeAll();
                             menutab('/admin/Order/index');
                          }
                          else{
                              layer.msg($ress.html);
                          }
                        }
                    });
                  }
                }
              });
            }
            else{
                layer.msg($res.html);
            }
          }
      });   
    }
    //添加库存
    function add_stock(tra_id){
      var id = arguments[0]?arguments[0]:'';
      layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">数量<input type="text" class="stock_num"/></div>',
        btn: '派送',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".stock_num").val();
          $.post("/admin/Product/add_stock",{"shopid":id,"num":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
      });
    }
    function add_crowd(){
      layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">人群名字:<input type="text" class="crowd_name"/><br>描述:<input type="text" class="crowd_desc"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var crowd_name = $(".crowd_name").val();
          var crowd_desc = $(".crowd_desc").val();
          $.post("/admin/Freinfo/crowd_add",{"crowd_desc":crowd_desc,"crowd_name":crowd_name},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   layer.msg($res.html);
                   layer.closeAll();
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
      });
    }
    //商家确认收货 
    function enter_send(tra_id){
      var id = arguments[0]?arguments[0]:'';
      layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">到货数量<input type="text" class="enter_num"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".enter_num").val();
          $.post("/admin/Product/enter_send",{"shopid":id,"num":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
      });
    }
    //厂家确认还桶数量
     function enter_back(tra_id){
      var id = arguments[0]?arguments[0]:'';
      layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">到货数量<input type="text" class="enter_back"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".enter_back").val();
          $.post("/admin/Product/enter_back",{"shopid":id,"num":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
      });
    }
    //商家给回的空桶数量
     function call_backnum(tra_id){
      var id = arguments[0]?arguments[0]:'';
      layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">还桶数量<input type="text" class="call_backnum"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".call_backnum").val();
          $.post("/admin/Product/call_backnum",{"shopid":id,"num":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
      });
    }
//弹出协议
function alert_txt(){
      var str = '';
      //替换就行了
      //
      str ="";
      layer.open({
        type: 1 ,
        title:"协议",
        area:['60%','100%'],
        shade: 0.8,
        content:str,
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          $('#check_box').attr('checked', true);
          layer.closeAll();
        }
      });
    }

function setlnglat(lng,lat){

}
function address_set(val){
}
function address_get(){
}
function send_smsvip(){
      var phone = $("#mobile").val();
      var reg = /^1[34578]\d{9}$/;
      if(!reg.test(phone)){
        layer.tips(rule_tip[name], input_id,{
              tips: [1, '#000'],
              time: 4000
            });
    }else{
      if(phone != null || phone != ""){
              $.post("/admin/Userinfo/send_sms",{"phone":phone},function(res){
                  if(res!=null){
                    var $res = $.parseJSON(res);
                    if($res.status == 0){
                      layer.msg("发送成功");
                    }else{
                      layer.msg($res.html);
                    }
                  }else{
                    layer.msg($res.html)
                  }
              });
            }else{
              layer.msg("error");
            }
          }     
    }

//根据地区号返回地址
    //@param string
    //return string:null
function getAddressOfNum(num){
        var num_t = num?num:null;
        if(num!=null){
            var pro_num = num.slice(0,2);
            var city_num = num.slice(2,4);
            var dis_num = num.slice(4,6);
            var address = "";
            var pro = ChineseDistricts['86'][pro_num+"0000"];
            if(city_num!="00"){
              var city = ChineseDistricts[pro_num+"0000"][pro_num+city_num+"00"];
              if(dis_num!="00"){
                var dis  = ChineseDistricts[pro_num+city_num+"00"][num];
                address = pro+city+dis;
                return address; 
              }else{
                address = pro+city;
                return address;  
              }
            }else{
              address = pro;
              return address;              
            }
        }else{
          return null;
        }
}
//省市县联动事件
function select_change_city(str){

      var $select_str = str; 

      var checkIndex=$($select_str).get(0).selectedIndex;

      var code = $($select_str+">option").eq(checkIndex).attr("data-code");

      var address = getAddressOfNum(code);

      var data = {"code":code,"address":address};

      return data;

}
//修改服务费
function edit_service($tra_id){

  var id = arguments[0]?arguments[0]:'';

  layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">服务费：<input type="text" class="enter_num"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".enter_num").val();
          $.post("/admin/Shoper/edit_service",{"shop_id":id,"num":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                   menutab('/admin/Shoper/index')
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
    });

}
//修改库存
function edit_stock($tra_id){

  var id = arguments[0]?arguments[0]:'';

  layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">添加库存：<input type="text" class="enter_num"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".enter_num").val();
          $.post("/admin/Product/edit_stock",{"shop_id":id,"num":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                   menutab('/admin/Product/query_stock')
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
    });

}

function edit_alret(urlstr,$tra_id,name){
  var urlstr = arguments[0]?arguments[0]:'';
  var id = arguments[1]?arguments[1]:'';
  var name = arguments[2]?arguments[2]:'';
  layer.open({
        type: 1,
        skin: 'layui-layer-molv',
        offset: 'auto',//具体配置参考：offset参数项
        content: '<div style="padding: 20px 80px;">'+name+'<input type="text" class="enter_num"/></div>',
        btn: '确认',
        btnAlign: 'c' ,//按钮居中,
        shade: 0,
        yes: function(){
          var num = $(".enter_num").val();
          $.post(urlstr,{"info1":id,"info2":num},function(res){
            if(res!=null){
             $res = $.parseJSON(res);
             if($res.status == 0){  
                   $('.wrap-fluid .container-fluid').html($res.html);
                   layer.closeAll();
                   // menutab('/admin/Index/index')
                }
                else{
                    layer.msg($res.html);
                }
              }
          });
        }
    });

}
    