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
	for (var i=0;i<jsonAddrs.length;i++){
		if(jsonAddrs[i].id==id){
			return jsonAddrs[i].dicName;
		}	
	}
	return "武汉";
}

var isUseServiceLoc = true; //是否默认使用服务端地址
var defaultProvince = '';
var a =0;
for (var i=0;i<jsonAddrs.length;i++){
	if(jsonAddrs[i].dicParent==null||jsonAddrs[i].dicParent==''){
		defaultProvince+='<li><a href="#none" data-value="'+jsonAddrs[i].id+'">'+jsonAddrs[i].dicName+'</a></li>';
	}	
}
var provinceHtml = '<div class="content"><div data-widget="tabs" class="m JD-stock" id="JD-stock">'
								+'<div class="mt">'
								+'    <ul class="tab">'
								+'        <li data-index="0" data-widget="tab-item" class="curr"><a href="#none" class="hover"><em>请选择</em><i></i></a></li>'
								+'        <li data-index="1" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'        <li data-index="2" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'        <li data-index="3" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'    </ul>'
								+'    <div class="stock-line"></div>'
								+'</div>'
								+'<div class="mc" data-area="0" data-widget="tab-content" id="stock_province_item">'
								+'    <ul class="area-list">'
								+defaultProvince
								+'    </ul>'
								+'</div>'
								+'<div class="mc" data-area="1" data-widget="tab-content" id="stock_city_item"></div>'
								+'<div class="mc" data-area="2" data-widget="tab-content" id="stock_area_item"></div>'
								+'<div class="mc" data-area="3" data-widget="tab-content" id="stock_town_item"></div>'
								+'</div></div>';
function getAreaList(provinceId){
	var html = ["<ul class='area-list'>"];
	var longhtml = [];
	var longerhtml = [];
	var listLongh=false;
	for(var k=0;k<jsonAddrs.length;k++){
		if((""+jsonAddrs[k].dicParent)==provinceId){
			listLongh=true;
			break;
		}
	}	
	if (listLongh){
		for (var i=0;i<jsonAddrs.length;i++){
			if(""+jsonAddrs[i].dicParent==provinceId){
				jsonAddrs[i].dicName = jsonAddrs[i].dicName.replace(" ","");
				if(jsonAddrs[i].dicName.length > 12){
					longerhtml.push("<li class='longer-area'><a href='#none' data-value='"+jsonAddrs[i].id+"'>"+jsonAddrs[i].dicName+"</a></li>");
				}
				else if(jsonAddrs[i].dicName.length > 5){
					longhtml.push("<li class='long-area'><a href='#none' data-value='"+jsonAddrs[i].id+"'>"+jsonAddrs[i].dicName+"</a></li>");
				}
				else{
					html.push("<li><a href='#none' data-value='"+jsonAddrs[i].id+"'>"+jsonAddrs[i].dicName+"</a></li>");
				}
				defaultProvince+='<li><a href="#none" data-value="'+jsonAddrs[i].id+'">'+jsonAddrs[i].dicName+'</a></li>';
			}	
		}
	}
	else{
		html.push("<li><a href='#none' data-value='"+currentAreaInfo.currentFid+"'> </a></li>");
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
	if(currentAreaInfo.currentLevel==3){
		currentAreaInfo.currentAreaId = id;
		currentAreaInfo.currentAreaName = name;
		if(!page_load){
			currentAreaInfo.currentTownId = 0;
			currentAreaInfo.currentTownName = "";
		}
	}
	else if(currentAreaInfo.currentLevel==4){
		currentAreaInfo.currentTownId = id;
		currentAreaInfo.currentTownName = name;
	}
	$('#store-selector').removeClass('hover');
	//setCommonCookies(currentAreaInfo.currentProvinceId,currentLocation,currentAreaInfo.currentCityId,currentAreaInfo.currentAreaId,currentAreaInfo.currentTownId,!page_load);
	if(page_load){
		page_load = false;
	}
	//默认地址展现
	var address = currentAreaInfo.currentProvinceName+currentAreaInfo.currentCityName+currentAreaInfo.currentAreaName;
	
	$("#store-selector .text div").html(address).attr("title",address);
	$("#addressShopping").val(""+currentAreaInfo.currentProvinceId+","+currentAreaInfo.currentCityId+","+currentAreaInfo.currentAreaId);
}
function getAreaListcallback(r){
	currentDom.html(getAreaList(r));
	if (currentAreaInfo.currentLevel >= 2){
		currentDom.find("a").click(function(){
			if(page_load){
				page_load = false;
			}
			if(currentDom.attr("id")=="stock_area_item"){
				currentAreaInfo.currentLevel=3;
			}
			else if(currentDom.attr("id")=="stock_town_item"){
				currentAreaInfo.currentLevel=4;
			}
			getStockOpt($(this).attr("data-value"),$(this).html());
		});
		if(page_load){ //初始化加载
			currentAreaInfo.currentLevel = currentAreaInfo.currentLevel==2?3:4;
			if(currentAreaInfo.currentAreaId&&new Number(currentAreaInfo.currentAreaId)>0){
				getStockOpt(currentAreaInfo.currentAreaId,currentDom.find("a[data-value='"+currentAreaInfo.currentAreaId+"']").html());
			}
			else{
				getStockOpt(currentDom.find("a").eq(0).attr("data-value"),currentDom.find("a").eq(0).html());
			}
		}
	}
}
function chooseProvince(provinceId){
	provinceContainer.hide();
	currentAreaInfo.currentLevel = 1;
	currentAreaInfo.currentProvinceId = provinceId;
	currentAreaInfo.currentProvinceName = getNameById(provinceId);
	if(!page_load){
		currentAreaInfo.currentCityId = 0;
		currentAreaInfo.currentCityName = "";
		currentAreaInfo.currentAreaId = 0;
		currentAreaInfo.currentAreaName = "";
		currentAreaInfo.currentTownId = 0;
		currentAreaInfo.currentTownName = "";
	}
	areaTabContainer.eq(0).removeClass("curr").find("em").html('<b>'+currentAreaInfo.currentProvinceName+'</b>');
	areaTabContainer.eq(1).addClass("curr").show().find("em").html('<b>请选择<b>');
	areaTabContainer.eq(2).hide();
	areaTabContainer.eq(3).hide();
	cityContainer.show();
	areaContainer.hide();
	townaContainer.hide();
	if(provinceId){
		cityContainer.html(getAreaList(provinceId));
		cityContainer.find("a").click(function(){
			if(page_load){
				page_load = false;
			}
			$("#store-selector").unbind("mouseout");
			chooseCity($(this).attr("data-value"),$(this).html());
		});
		if(page_load){ //初始化加载
			if(currentAreaInfo.currentCityId&&new Number(currentAreaInfo.currentCityId)>0){
				chooseCity(currentAreaInfo.currentCityId,cityContainer.find("a[data-value='"+currentAreaInfo.currentCityId+"']").html());
			}
			else{
				chooseCity(cityContainer.find("a").eq(0).attr("data-value"),cityContainer.find("a").eq(0).html());
			}
		}
	}
}
function chooseCity(cityId,cityName){
	provinceContainer.hide();
	cityContainer.hide();
	currentAreaInfo.currentLevel = 2;
	currentAreaInfo.currentCityId = cityId;
	currentAreaInfo.currentCityName = cityName;
	if(!page_load){
		currentAreaInfo.currentAreaId = 0;
		currentAreaInfo.currentAreaName = "";
		currentAreaInfo.currentTownId = 0;
		currentAreaInfo.currentTownName = "";
	}
	areaTabContainer.eq(1).removeClass("curr").find("em").html('<b>'+cityName+'<b>');
	areaTabContainer.eq(2).addClass("curr").show().find("em").html('<b>请选择<b>');
	areaTabContainer.eq(3).hide();
	townaContainer.hide();
	areaContainer.show();
	if(cityId){
		areaContainer.html(getAreaList(cityId));
		areaContainer.find("a").click(function(){
			if(page_load){
				page_load = false;
			}
			$("#store-selector").unbind("mouseout");
			chooseArea($(this).attr("data-value"),$(this).html());
			$("#remDiv").replaceWith(s);
		});
		if(page_load){ //初始化加载
			if(currentAreaInfo.currentAreaId&&new Number(currentAreaInfo.currentAreaId)>0){
				chooseArea(currentAreaInfo.currentAreaId,areaContainer.find("a[data-value='"+currentAreaInfo.currentAreaId+"']").html());
			}
			else{
				
				chooseArea(areaContainer.find("a").eq(0).attr("data-value"),areaContainer.find("a").eq(0).html());
			}
		}
	}
	/*currentDom = areaContainer;
	$.getJSONP("http://d.360buy.com/area/get?fid="+cityId+"&callback=getAreaListcallback");*/
}
var s="";
function chooseArea(areaId,areaName){
	//var shoppingCartId=$("#shoppingCartId").val().trim();

	currentAreaInfo.currentLevel = 3;
	currentAreaInfo.currentAreaId = areaId;
	currentAreaInfo.currentAreaName = areaName;
	var address = currentAreaInfo.currentProvinceName+currentAreaInfo.currentCityName+currentAreaInfo.currentAreaName;
	$("#store-selector .text div").html(address).attr("title",address);
	s='<span style="border:1px solid #ABADB3;background-color:#FFFFFF; overflow:hidden;padding:3px;" onclick = "shoppingAddressClick(&quot;'+shoppingCartId+'&quot;)" id="shoppingCart1Id'+shoppingCartId+'">'+address+'<img src="/ssm/images/redimg/btn20121210.png"/></span>';
	
	var r= '{"currentLevel": 1,"currentProvinceId":' +currentAreaInfo.currentProvinceId+',"currentProvinceName":"'+currentAreaInfo.currentProvinceName+'","currentCityId": '+currentAreaInfo.currentCityId+',"currentCityName":"'+currentAreaInfo.currentCityName+'","currentAreaId": '+currentAreaInfo.currentAreaId+',"currentAreaName":"'+currentAreaInfo.currentAreaName+'"}';
	$("#addressShopping"+shoppingCartId).val(""+currentAreaInfo.currentProvinceId+","+currentAreaInfo.currentCityId+","+currentAreaInfo.currentAreaId);
	$("#address"+shoppingCartId).text(r);
	$('#store-selector').removeClass('hover');
	
	//$("#remDiv").replaceWith(s);
	/*provinceContainer.hide();
	cityContainer.hide();
	areaContainer.hide();
	currentAreaInfo.currentLevel = 3;
	currentAreaInfo.currentAreaId = areaId;
	currentAreaInfo.currentAreaName = areaName;
	if(!page_load){
		currentAreaInfo.currentTownId = 0;
		currentAreaInfo.currentTownName = "";
	}
	areaTabContainer.eq(2).removeClass("curr").find("em").html(areaName);
	areaTabContainer.eq(3).addClass("curr").show().find("em").html("请选择");
	townaContainer.show().html("<div class='iloading'>正在加载中，请稍候...</div>");
	currentDom = townaContainer;
	$.getJSONP("http://d.360buy.com/area/get?fid="+areaId+"&callback=getAreaListcallback");*/
}
$("#store-selector .text").after(provinceHtml);
var areaTabContainer=$("#JD-stock .tab li");
var provinceContainer=$("#stock_province_item");
var cityContainer=$("#stock_city_item");
var areaContainer=$("#stock_area_item");
var townaContainer=$("#stock_town_item");
var currentDom = provinceContainer;

//当前地域信息
var currentAreaInfo;
//初始化当前地域信息
function CurrentAreaInfoInit(){
	var address=$("#address"+shoppingCartId).text();
	
	if(address!=null||address!=""){
		currentAreaInfo = eval('(' + address + ')');
	}else{
		currentAreaInfo =  {"currentLevel": 1,"currentProvinceId": 1871,"currentProvinceName":"湖北","currentCityId": 1872,"currentCityName":"武汉市","currentAreaId": 1893,"currentAreaName":"硚口区"};
	}
	
	var ipLoc = getCookie("ipLoc-djd");
	/*ipLoc = ipLoc?ipLoc.split("-"):[1,2,20,0];
	if(ipLoc.length>0&&ipLoc[0]){
		currentAreaInfo.currentProvinceId = ipLoc[0];
		currentAreaInfo.currentProvinceName = getNameById(ipLoc[0]);
	}
	if(ipLoc.length>1&&ipLoc[1]){
		currentAreaInfo.currentCityId = ipLoc[1];
	}
	if(ipLoc.length>2&&ipLoc[2]){
		currentAreaInfo.currentAreaId = ipLoc[2];
	}
	if(ipLoc.length>3&&ipLoc[3]){
		currentAreaInfo.currentTownId = ipLoc[3];
	}*/
}
var page_load = true;
(function(){
	$("#store-selector").unbind("mouseout").bind("mouseout",function(){
		$('#store-selector').removeClass('hover');			
	});
	$("#store-selector").unbind("mouseover").bind("mouseover",function(){
		$('#store-selector').addClass('hover');
		$("#store-selector .content,#JD-stock").show();
	}).find("dl").remove();
	CurrentAreaInfoInit();
	areaTabContainer.eq(0).find("a").click(function(){
		areaTabContainer.removeClass("curr");
		areaTabContainer.eq(0).addClass("curr").show();
		provinceContainer.show();
		cityContainer.hide();
		areaContainer.hide();
		townaContainer.hide();
		areaTabContainer.eq(1).hide();
		areaTabContainer.eq(2).hide();
		areaTabContainer.eq(3).hide();
	});
	areaTabContainer.eq(1).find("a").click(function(){
		areaTabContainer.removeClass("curr");
		areaTabContainer.eq(1).addClass("curr").show();
		provinceContainer.hide();
		cityContainer.show();
		areaContainer.hide();
		townaContainer.hide();
		areaTabContainer.eq(2).hide();
		areaTabContainer.eq(3).hide();
	});
	areaTabContainer.eq(2).find("a").click(function(){
		areaTabContainer.removeClass("curr");
		areaTabContainer.eq(2).addClass("curr").show();
		provinceContainer.hide();
		cityContainer.hide();
		areaContainer.show();
		townaContainer.hide();
		areaTabContainer.eq(3).hide();
	});
	provinceContainer.find("a").click(function() {
		if(page_load){
			page_load = false;
		}
		$("#store-selector").unbind("mouseout");
		chooseProvince($(this).attr("data-value"));
	}).end();
	chooseProvince(currentAreaInfo.currentProvinceId);
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





