	// 百度地图API功能
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(113.229428,23.403597);
	var lng,lat;
	var cityName;
	map.centerAndZoom(point,17);
	var scaleCtrl = new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT,offset: new BMap.Size(10,40)});
	map.addControl(scaleCtrl);
	var geoc = new BMap.Geocoder();
	function myFun(result){
		cityName = result.name;
		// map.setCenter(cityName);
	}
	map.enableScrollWheelZoom(true);
	var myCity = new BMap.LocalCity();
	myCity.get(myFun);
	var navigationControl = new BMap.NavigationControl({
	    // 靠左上角位置
	    anchor: BMAP_ANCHOR_TOP_LEFT,
	    // LARGE类型
	    type: BMAP_NAVIGATION_CONTROL_LARGE,
	    // 启用显示定位
	    enableGeolocation: true
	  });
	  map.addControl(navigationControl);

	// map.centerAndZoom(cityName,12);  
	         
	//单击获取点击的经纬度
	// map.addEventListener("click",function(e){
	// 	lng = e.point.lng;
	// 	lat= e.point.lat;
	// 	var pt = e.point;
	// 	$.post("/admin/Register/get_m",{"lng":lng,"lat":lat},function(res){
 //            if(res!=null){
 //             $res = $.parseJSON(res);
 //             if($res.status == 0){  
 //                   map.clearOverlays();
 //                   $data = $res.html
	// 				if($data!=null){
	// 					for(var k = 0;k<$data.length;k++){
	// 						var point = new BMap.Point($data[k]["longitude"],$data[k]["latitude"]);
	// 						console.log($data[k]["shop_pic"]);
	// 			  			var label = new BMap.Label("<img style='width: 5em;' src='"+$data[k]["shop_pic"]+"'>"+$data[k]["shop_name"]+" "+"距离"+$data[k]["distance"]+"m",{offset:new BMap.Size(20,-10)});
	// 			  			var oval = new BMap.Polygon(add_oval(point,0.001,0.00095), {strokeColor:"blue", strokeWeight:0.5, strokeOpacity:0.4});
	// 						addMarker(point,label,oval);			
	// 					}			
	// 				}
	// 				var p = new BMap.Point(lng, lat);

	// 			  	var oval = new BMap.Polygon(add_oval(p,0.001,0.00095), {strokeColor:"blue", strokeWeight:0.5, strokeOpacity:0.4});
	// 				var marker = new BMap.Marker(p);		
	// 				map.addOverlay(oval);
	// 				map.addOverlay(marker);
	// 				marker.setAnimation(BMAP_ANIMATION_BOUNCE);
	// 				//地址解析
	// 				geoc.getLocation(pt, function(rs){
	// 					var addComp = rs.addressComponents;
	// 					parent.address_set(addComp.province + addComp.city + addComp.district+addComp.street + addComp.streetNumber);
	// 				});
	// 				//设置经纬度
	// 				parent.setlnglat(lng,lat);
 //                }
 //                else if($res.status == 1){
 //                    layer.open({
	// 		          title: '提示'
	// 		          ,content:$res.html
	// 		        });
 //                }
 //              }
 //          });  
	// });
	//获取各商家经纬度
	function set_piont(){
		var $data = parent.get_lists();
		if($data!=null){
			for(var i = 1;i<$data.length;i++){
				var point = new BMap.Point($data[i]["longitude"],$data[i]["latitude"]);
				var bmap_str = "<img style='width: 5em;' src='"+$data[i]["shop_pic"]+"'>"+$data[i]["shop_name"];
				if(typeof($data[i]["usernum"])!="undefined"){
					bmap_str+=" "+$data[i]["usernum"]+"人次下单";
				}
	  			var label = new BMap.Label(bmap_str,{offset:new BMap.Size(20,-10)});
	  			var oval = new BMap.Polygon(add_oval(point,0.001,0.00095), {strokeColor:"blue", strokeWeight:0.5, strokeOpacity:0.4});
				addMarker(point,label,oval);			
			}			
		}
	}
	//
	set_piont();
	//添加多个点
	function addMarker(point,label,oval){
	  var marker = new BMap.Marker(point);
		marker.setLabel(label);
		map.addOverlay(oval);
	  	map.addOverlay(marker);
	}
	function address_point(val){
		myGeo.getPoint(val, function(point){
			if (point) {
				map.centerAndZoom(point, 16);
				map.addOverlay(new BMap.Marker(point));
			}else{
				alert("您选择地址没有解析到结果!");
			}
		}, "中国");
	}
	function add_oval(centre,x,y)
	{
		var assemble=new Array();
		var angle;
		var dot;
		var tangent=x/y;
		for(i=0;i<36;i++)
		{
			angle = (2* Math.PI / 36) * i;
			dot = new BMap.Point(centre.lng+Math.sin(angle)*y*tangent, centre.lat+Math.cos(angle)*y);
			assemble.push(dot);
		}
		return assemble;
	}
	
	//关于状态码
	//BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
	//BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
	//BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
	//BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
	//BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
	//BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
	//BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
	//BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
	//BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)
