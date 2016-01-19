!function ($) {
	$.extend({
		_jsonp : {
			scripts : {},
			counter : 1,
			charset : "gb2312",
			head : document.getElementsByTagName("head")[0],
			name : function (callback) {
				var name = "_jsonp_" + (new Date).getTime() + "_" + this.counter;
				this.counter++;
				var cb = function (json) {
					eval("delete " + name),
					callback(json),
					$._jsonp.head.removeChild($._jsonp.scripts[name]),
					delete $._jsonp.scripts[name]
				};
				return eval(name + " = cb"),
				name
			},
			load : function (a, b) {
				var c = document.createElement("script");
				c.type = "text/javascript",
				c.charset = this.charset,
				c.src = a,
				this.head.appendChild(c),
				this.scripts[b] = c
			}
		},
		getJSONP : function (a, b) {
			var c = $._jsonp.name(b),
			a = a.replace(/{callback};/, c);
			return $._jsonp.load(a, c),
			this
		}
	})
}
(jQuery);
var currentLocation = "武汉";
var currentProvinceId = 1871;	
//根据省份ID获取名称
function getNameById(id){
	for (var i=0;i<jsonAddrs3.length;i++){
		if(jsonAddrs3[i].id==id){
			return jsonAddrs3[i].dicName;
		}	
	}
	return "武汉";
}

var isUseServiceLoc = true; //是否默认使用服务端地址
var defaultProvince = '';
var a =0;
for (var i=0;i<jsonAddrs3.length;i++){
	if(jsonAddrs3[i].dicParent==null||jsonAddrs3[i].dicParent==''){
		defaultProvince+='<li><a href="#none" data-value="'+jsonAddrs3[i].id+'">'+jsonAddrs3[i].dicName+'</a></li>';
	}	
}
var provinceHtml3 = '<div class="content3"><div data-widget="tabs" class="m JD-stock3" id="JD-stock3">'
								+'<div class="mt3">'
								+'    <ul class="tab3">'
								+'        <li data-index="0" data-widget="tab-item" class="curr"><a href="#none" class="hover"><em>请选择</em><i></i></a></li>'
								+'        <li data-index="1" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'        <li data-index="2" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'        <li data-index="3" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'    </ul>'
								+'    <div class="stock-line3"></div>'
								+'</div>'
								+'<div class="mc3" data-area="0" data-widget="tab-content" id="stock_province_item3">'
								+'    <ul class="area-list3">'
								+defaultProvince
								+'    </ul>'
								+'</div>'
								+'<div class="mc3" data-area="1" data-widget="tab-content" id="stock_city_item3"></div>'
								+'<div class="mc3" data-area="2" data-widget="tab-content" id="stock_area_item3"></div>'
								+'<div class="mc3" data-area="3" data-widget="tab-content" id="stock_town_item3"></div>'
								+'</div></div>';
function getAreaList(provinceId){
	var html = ["<ul class='area-list3'>"];
	var longhtml = [];
	var longerhtml = [];
	var listLongh=false;
	for(var k=0;k<jsonAddrs3.length;k++){
		if((""+jsonAddrs3[k].dicParent)==provinceId){
			listLongh=true;
			break;
		}
	}	
	if (listLongh){
		for (var i=0;i<jsonAddrs3.length;i++){
			if(""+jsonAddrs3[i].dicParent==provinceId){
				jsonAddrs3[i].dicName = jsonAddrs3[i].dicName.replace(" ","");
				if(jsonAddrs3[i].dicName.length > 12){
					longerhtml.push("<li class='longer-area3'><a href='#none' data-value='"+jsonAddrs3[i].id+"'>"+jsonAddrs3[i].dicName+"</a></li>");
				}
				else if(jsonAddrs3[i].dicName.length > 5){
					longhtml.push("<li class='long-area3'><a href='#none' data-value='"+jsonAddrs3[i].id+"'>"+jsonAddrs3[i].dicName+"</a></li>");
				}
				else{
					html.push("<li><a href='#none' data-value='"+jsonAddrs3[i].id+"'>"+jsonAddrs3[i].dicName+"</a></li>");
				}
				defaultProvince+='<li><a href="#none" data-value="'+jsonAddrs3[i].id+'">'+jsonAddrs3[i].dicName+'</a></li>';
			}	
		}
	}
	else{
		html.push("<li><a href='#none' data-value='"+currentAreaInfo3.currentFid+"'> </a></li>");
	}
	html.push(longhtml.join(""));
	html.push(longerhtml.join(""));
	html.push("</ul>");
	return html.join("");
}
function cleanKuohao(str){
	if(str&&str.indexOf("(")>0){
		str = str.substring(0,str.indexOf("("));
	}
	if(str&&str.indexOf("（")>0){
		str = str.substring(0,str.indexOf("（"));
	}
	return str;
}

function getStockOpt(id,name){
	if(currentAreaInfo3.currentLevel==3){
		currentAreaInfo3.currentAreaId = id;
		currentAreaInfo3.currentAreaName = name;
		if(!page_load3){
			currentAreaInfo3.currentTownId = 0;
			currentAreaInfo3.currentTownName = "";
		}
	}
	else if(currentAreaInfo3.currentLevel==4){
		currentAreaInfo3.currentTownId = id;
		currentAreaInfo3.currentTownName = name;
	}
	$('#store-selector3').removeClass('hover');
	//setCommonCookies(currentAreaInfo3.currentProvinceId,currentLocation,currentAreaInfo3.currentCityId,currentAreaInfo3.currentAreaId,currentAreaInfo3.currentTownId,!page_load3);
	if(page_load3){
		page_load3 = false;
	}
	//默认地址展现
	var address = currentAreaInfo3.currentProvinceName+currentAreaInfo3.currentCityName+currentAreaInfo3.currentAreaName;
	$("#store-selector3 .text3 div").html(address).attr("title",address);
	$("#addressjoin3").val(""+currentAreaInfo3.currentProvinceId+","+currentAreaInfo3.currentCityId+","+currentAreaInfo3.currentAreaId);
}
function getAreaListcallback(r){
	currentDom.html(getAreaList(r));
	if (currentAreaInfo3.currentLevel >= 2){
		currentDom.find("a").click(function(){
			if(page_load3){
				page_load3 = false;
			}
			if(currentDom.attr("id")=="stock_area_item3"){
				currentAreaInfo3.currentLevel=3;
			}
			else if(currentDom.attr("id")=="stock_town_item3"){
				currentAreaInfo3.currentLevel=4;
			}
			getStockOpt($(this).attr("data-value"),$(this).html());
		});
		if(page_load3){ //初始化加载
			currentAreaInfo3.currentLevel = currentAreaInfo3.currentLevel==2?3:4;
			if(currentAreaInfo3.currentAreaId&&new Number(currentAreaInfo3.currentAreaId)>0){
				getStockOpt(currentAreaInfo3.currentAreaId,currentDom.find("a[data-value='"+currentAreaInfo3.currentAreaId+"']").html());
			}
			else{
				getStockOpt(currentDom.find("a").eq(0).attr("data-value"),currentDom.find("a").eq(0).html());
			}
		}
	}
}
function chooseProvince3(provinceId){
	provinceContainer3.hide();
	currentAreaInfo3.currentLevel = 1;
	currentAreaInfo3.currentProvinceId = provinceId;
	currentAreaInfo3.currentProvinceName = getNameById(provinceId);
	if(!page_load3){
		currentAreaInfo3.currentCityId = 0;
		currentAreaInfo3.currentCityName = "";
		currentAreaInfo3.currentAreaId = 0;
		currentAreaInfo3.currentAreaName = "";
		currentAreaInfo3.currentTownId = 0;
		currentAreaInfo3.currentTownName = "";
	}
	areaTabContainer3.eq(0).removeClass("curr").find("em").html('<b>'+currentAreaInfo3.currentProvinceName+'</b>');
	areaTabContainer3.eq(1).addClass("curr").show().find("em").html('<b>请选择<b>');
	areaTabContainer3.eq(2).hide();
	areaTabContainer3.eq(3).hide();
	cityContainer3.show();
	areaContainer3.hide();
	townaContainer3.hide();
	if(provinceId){
		cityContainer3.html(getAreaList(provinceId));
		cityContainer3.find("a").click(function(){
			if(page_load3){
				page_load3 = false;
			}
			$("#store-selector3").unbind("mouseout");
			chooseCity3($(this).attr("data-value"),$(this).html());
		});
		if(page_load3){ //初始化加载
			if(currentAreaInfo3.currentCityId&&new Number(currentAreaInfo3.currentCityId)>0){
				chooseCity3(currentAreaInfo3.currentCityId,cityContainer3.find("a[data-value='"+currentAreaInfo3.currentCityId+"']").html());
			}
			else{
				chooseCity3(cityContainer3.find("a").eq(0).attr("data-value"),cityContainer3.find("a").eq(0).html());
			}
		}
	}
}
function chooseCity3(cityId,cityName){
	provinceContainer3.hide();
	cityContainer3.hide();
	currentAreaInfo3.currentLevel = 2;
	currentAreaInfo3.currentCityId = cityId;
	currentAreaInfo3.currentCityName = cityName;
	if(!page_load3){
		currentAreaInfo3.currentAreaId = 0;
		currentAreaInfo3.currentAreaName = "";
		currentAreaInfo3.currentTownId = 0;
		currentAreaInfo3.currentTownName = "";
	}
	areaTabContainer3.eq(1).removeClass("curr").find("em").html('<b>'+cityName+'<b>');
	areaTabContainer3.eq(2).addClass("curr").show().find("em").html('<b>请选择<b>');
	areaTabContainer3.eq(3).hide();
	townaContainer3.hide();
	areaContainer3.show();
	if(cityId){
		areaContainer3.html(getAreaList(cityId));
		areaContainer3.find("a").click(function(){
			if(page_load3){
				page_load3 = false;
			}
			$("#store-selector3").unbind("mouseout");
			chooseArea3($(this).attr("data-value"),$(this).html());
		});
		if(page_load3){ //currentAreaInfo3
			if(currentAreaInfo3.currentAreaId&&new Number(currentAreaInfo3.currentAreaId)>0){
				chooseArea3(currentAreaInfo3.currentAreaId,areaContainer3.find("a[data-value='"+currentAreaInfo3.currentAreaId+"']").html());
			}
			else{
				chooseArea3(areaContainer3.find("a").eq(0).attr("data-value"),areaContainer3.find("a").eq(0).html());
			}
		}
	}
	/*currentDom = areaContainer3;
	$.getJSONP("http://d.360buy.com/area/get?fid="+cityId+"&callback=getAreaListcallback");*/
}
function chooseArea3(areaId,areaName){
	currentAreaInfo3.currentLevel = 3;
	currentAreaInfo3.currentAreaId = areaId;
	currentAreaInfo3.currentAreaName = areaName;
	var address = currentAreaInfo3.currentProvinceName+currentAreaInfo3.currentCityName+currentAreaInfo3.currentAreaName;
	/************************************/
	//header首页选中省市区存入session中
	$("#provinceName").val(currentAreaInfo3.currentProvinceName);
	$("#provinceId").val(currentAreaInfo3.currentProvinceId);
	$("#cityName").val(currentAreaInfo3.currentCityName);
	$("#cityId").val(currentAreaInfo3.currentCityId);
	$("#areaName").val(currentAreaInfo3.currentAreaName);
	$("#areaId").val(currentAreaInfo3.currentAreaId);
	addressAjax();
	/************************************/
	$("#store-selector3 .text3 div").html(address).attr("title",address);
	$("#addressjoin3").val(""+currentAreaInfo3.currentProvinceId+","+currentAreaInfo3.currentCityId+","+currentAreaInfo3.currentAreaId);
	$('#store-selector3').removeClass('hover');
	/*provinceContainer3.hide();
	cityContainer3.hide();
	areaContainer3.hide();
	currentAreaInfo3.currentLevel = 3;
	currentAreaInfo3.currentAreaId = areaId;
	currentAreaInfo3.currentAreaName = areaName;
	if(!page_load3){
		currentAreaInfo3.currentTownId = 0;
		currentAreaInfo3.currentTownName = "";
	}
	areaTabContainer3.eq(2).removeClass("curr").find("em").html(areaName);
	areaTabContainer3.eq(3).addClass("curr").show().find("em").html("请选择");
	townaContainer3.show().html("<div class='iloading'>正在加载中，请稍候...</div>");
	currentDom = townaContainer3;
	$.getJSONP("http://d.360buy.com/area/get?fid="+areaId+"&callback=getAreaListcallback");*/
}
$("#store-selector3 .text3").after(provinceHtml3);
var areaTabContainer3=$("#JD-stock3 .tab3 li");
var provinceContainer3=$("#stock_province_item3");
var cityContainer3=$("#stock_city_item3");
var areaContainer3=$("#stock_area_item3");
var townaContainer3=$("#stock_town_item3");
var currentDom = provinceContainer3;
//当前地域信息
var currentAreaInfo3;
//初始化当前地域信息
function currentAreaInfo3Init(){
	
	var provinceName=$("#provinceName").val().trim();
	var provinceId=$("#provinceId").val();
	var cityName=$("#cityName").val();
	var cityId=$("#cityId").val();
	var areaId=$("#areaId").val();
	var areaName=$("#areaName").val();
	if(provinceId!=null&&provinceId!=""){
		
		currentAreaInfo3 =  {"currentLevel": 1,"currentProvinceId": provinceId,"currentProvinceName":provinceName,"currentCityId": cityId,"currentCityName":cityName,"currentAreaId": areaId,"currentAreaName":areaName};
	}else{
		currentAreaInfo3 =  {"currentLevel": 1,"currentProvinceId": 1871,"currentProvinceName":"湖北","currentCityId": 1872,"currentCityName":"武汉市","currentAreaId": 1893,"currentAreaName":"硚口区"};
	}
	
	var ipLoc = getCookie("ipLoc-djd");
	/*ipLoc = ipLoc?ipLoc.split("-"):[1,2,20,0];
	if(ipLoc.length>0&&ipLoc[0]){
		currentAreaInfo3.currentProvinceId = ipLoc[0];
		currentAreaInfo3.currentProvinceName = getNameById(ipLoc[0]);
	}
	if(ipLoc.length>1&&ipLoc[1]){
		currentAreaInfo3.currentCityId = ipLoc[1];
	}
	if(ipLoc.length>2&&ipLoc[2]){
		currentAreaInfo3.currentAreaId = ipLoc[2];
	}
	if(ipLoc.length>3&&ipLoc[3]){
		currentAreaInfo3.currentTownId = ipLoc[3];
	}*/
}
var page_load3 = true;
(function(){
	$("#store-selector3").unbind("mouseout").bind("mouseout",function(){
		$('#store-selector3').removeClass('hover');			
	});
	$("#store-selector3").unbind("mouseover").bind("mouseover",function(){
		$('#store-selector3').addClass('hover');
		$("#store-selector3 .content3,#JD-stock3").show();
	}).find("dl").remove();
	currentAreaInfo3Init();
	areaTabContainer3.eq(0).find("a").click(function(){
		areaTabContainer3.removeClass("curr");
		areaTabContainer3.eq(0).addClass("curr").show();
		provinceContainer3.show();
		cityContainer3.hide();
		areaContainer3.hide();
		townaContainer3.hide();
		areaTabContainer3.eq(1).hide();
		areaTabContainer3.eq(2).hide();
		areaTabContainer3.eq(3).hide();
	});
	areaTabContainer3.eq(1).find("a").click(function(){
		areaTabContainer3.removeClass("curr");
		areaTabContainer3.eq(1).addClass("curr").show();
		provinceContainer3.hide();
		cityContainer3.show();
		areaContainer3.hide();
		townaContainer3.hide();
		areaTabContainer3.eq(2).hide();
		areaTabContainer3.eq(3).hide();
	});
	areaTabContainer3.eq(2).find("a").click(function(){
		areaTabContainer3.removeClass("curr");
		areaTabContainer3.eq(2).addClass("curr").show();
		provinceContainer3.hide();
		cityContainer3.hide();
		areaContainer3.show();
		townaContainer3.hide();
		areaTabContainer3.eq(3).hide();
	});
	provinceContainer3.find("a").click(function() {
		if(page_load3){
			page_load3 = false;
		}
		$("#store-selector3").unbind("mouseout");
		chooseProvince3($(this).attr("data-value"));
	}).end();
	chooseProvince3(currentAreaInfo3.currentProvinceId);
})();

function getCookie(name) {
	var start = document.cookie.indexOf(name + "=");
	var len = start + name.length + 1;
	if ((!start) && (name != document.cookie.substring(0, name.length))) {
		return null;
	}
	if (start == -1) return null;
	var end = document.cookie.indexOf(';', len);
	if (end == -1) end = document.cookie.length;
	return unescape(document.cookie.substring(len, end));
};





