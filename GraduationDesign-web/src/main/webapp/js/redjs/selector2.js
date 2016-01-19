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
function getNameById2(id){
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
var provinceHtml2 = '<div class="content2"><div data-widget="tabs" class="m JD-stock2" id="JD-stock2">'
								+'<div class="mt2">'
								+'    <ul class="tab2">'
								+'        <li data-index="0" data-widget="tab-item" class="curr"><a href="#none" class="hover"><em>请选择</em><i></i></a></li>'
								+'        <li data-index="1" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'        <li data-index="2" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'        <li data-index="3" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
								+'    </ul>'
								+'    <div class="stock-line2"></div>'
								+'</div>'
								+'<div class="mc2" data-area="0" data-widget="tab-content" id="stock_province_item2">'
								+'    <ul class="area-list2">'
								+defaultProvince
								+'    </ul>'
								+'</div>'
								+'<div class="mc2" data-area="1" data-widget="tab-content" id="stock_city_item2"></div>'
								+'<div class="mc2" data-area="2" data-widget="tab-content" id="stock_area_item2"></div>'
								+'<div class="mc2" data-area="3" data-widget="tab-content" id="stock_town_item2"></div>'
								+'</div></div>';
function getAreaList2(provinceId){
	var html = ["<ul class='area-list2'>"];
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
					longerhtml.push("<li class='longer-area2'><a href='#none' data-value='"+jsonAddrs[i].id+"'>"+jsonAddrs[i].dicName+"</a></li>");
				}
				else if(jsonAddrs[i].dicName.length > 5){
					longhtml.push("<li class='long-area2'><a href='#none' data-value='"+jsonAddrs[i].id+"'>"+jsonAddrs[i].dicName+"</a></li>");
				}
				else{
					html.push("<li><a href='#none' data-value='"+jsonAddrs[i].id+"'>"+jsonAddrs[i].dicName+"</a></li>");
				}
				defaultProvince+='<li><a href="#none" data-value="'+jsonAddrs[i].id+'">'+jsonAddrs[i].dicName+'</a></li>';
			}	
		}
	}
	else{
		html.push("<li><a href='#none' data-value='"+currentAreaInfo2.currentFid+"'> </a></li>");
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
	if(currentAreaInfo2.currentLevel==3){
		currentAreaInfo2.currentAreaId = id;
		currentAreaInfo2.currentAreaName = name;
		if(!page_load2){
			currentAreaInfo2.currentTownId = 0;
			currentAreaInfo2.currentTownName = "";
		}
	}
	else if(currentAreaInfo2.currentLevel==4){
		currentAreaInfo2.currentTownId = id;
		currentAreaInfo2.currentTownName = name;
	}
	$('#store-selector2').removeClass('hover');
	//setCommonCookies(currentAreaInfo2.currentProvinceId,currentLocation,currentAreaInfo2.currentCityId,currentAreaInfo2.currentAreaId,currentAreaInfo2.currentTownId,!page_load2);
	if(page_load2){
		page_load2 = false;
	}
	//默认地址展现
	var address = currentAreaInfo2.currentProvinceName+currentAreaInfo2.currentCityName+currentAreaInfo2.currentAreaName;
	$("#store-selector2 .text2 div").html(address).attr("title",address);
	$("#addressjoin2").val(""+currentAreaInfo2.currentProvinceId+","+currentAreaInfo2.currentCityId+","+currentAreaInfo2.currentAreaId);
}
function getAreaList2callback(r){
	currentDom.html(getAreaList2(r));
	if (currentAreaInfo2.currentLevel >= 2){
		currentDom.find("a").click(function(){
			if(page_load2){
				page_load2 = false;
			}
			if(currentDom.attr("id")=="stock_area_item2"){
				currentAreaInfo2.currentLevel=3;
			}
			else if(currentDom.attr("id")=="stock_town_item2"){
				currentAreaInfo2.currentLevel=4;
			}
			getStockOpt($(this).attr("data-value"),$(this).html());
		});
		if(page_load2){ //初始化加载
			currentAreaInfo2.currentLevel = currentAreaInfo2.currentLevel==2?3:4;
			if(currentAreaInfo2.currentAreaId&&new Number(currentAreaInfo2.currentAreaId)>0){
				getStockOpt(currentAreaInfo2.currentAreaId,currentDom.find("a[data-value='"+currentAreaInfo2.currentAreaId+"']").html());
			}
			else{
				getStockOpt(currentDom.find("a").eq(0).attr("data-value"),currentDom.find("a").eq(0).html());
			}
		}
	}
}
function chooseProvince2(provinceId){
	provinceContainer2.hide();
	currentAreaInfo2.currentLevel = 1;
	currentAreaInfo2.currentProvinceId = provinceId;
	currentAreaInfo2.currentProvinceName = getNameById2(provinceId);
	if(!page_load2){
		currentAreaInfo2.currentCityId = 0;
		currentAreaInfo2.currentCityName = "";
		currentAreaInfo2.currentAreaId = 0;
		currentAreaInfo2.currentAreaName = "";
		currentAreaInfo2.currentTownId = 0;
		currentAreaInfo2.currentTownName = "";
	}
	areaTabContainer2.eq(0).removeClass("curr2").find("em").html('<b>'+currentAreaInfo2.currentProvinceName+'</b>');
	areaTabContainer2.eq(1).addClass("curr2").show().find("em").html('<b>请选择<b>');
	areaTabContainer2.eq(2).hide();
	areaTabContainer2.eq(3).hide();
	cityContainer2.show();
	areaContainer2.hide();
	townaContainer2.hide();
	if(provinceId){
		cityContainer2.html(getAreaList2(provinceId));
		cityContainer2.find("a").click(function(){
			if(page_load2){
				page_load2 = false;
			}
			$("#store-selector2").unbind("mouseout");
			chooseCity2($(this).attr("data-value"),$(this).html());
		});
		if(page_load2){ //初始化加载
			if(currentAreaInfo2.currentCityId&&new Number(currentAreaInfo2.currentCityId)>0){
				chooseCity2(currentAreaInfo2.currentCityId,cityContainer2.find("a[data-value='"+currentAreaInfo2.currentCityId+"']").html());
			}
			else{
				chooseCity2(cityContainer2.find("a").eq(0).attr("data-value"),cityContainer2.find("a").eq(0).html());
			}
		}
	}
}
function chooseCity2(cityId,cityName){
	provinceContainer2.hide();
	cityContainer2.hide();
	currentAreaInfo2.currentLevel = 2;
	currentAreaInfo2.currentCityId = cityId;
	currentAreaInfo2.currentCityName = cityName;
	if(!page_load2){
		currentAreaInfo2.currentAreaId = 0;
		currentAreaInfo2.currentAreaName = "";
		currentAreaInfo2.currentTownId = 0;
		currentAreaInfo2.currentTownName = "";
	}
	areaTabContainer2.eq(1).removeClass("curr2").find("em").html('<b>'+cityName+'<b>');
	areaTabContainer2.eq(2).addClass("curr2").show().find("em").html('<b>请选择<b>');
	areaTabContainer2.eq(3).hide();
	townaContainer2.hide();
	areaContainer2.show();
	if(cityId){
		areaContainer2.html(getAreaList2(cityId));
		areaContainer2.find("a").click(function(){
			if(page_load2){
				page_load2 = false;
			}
			$("#store-selector2").unbind("mouseout");
			chooseArea2($(this).attr("data-value"),$(this).html());
		});
		if(page_load2){ //初始化加载
			if(currentAreaInfo2.currentAreaId&&new Number(currentAreaInfo2.currentAreaId)>0){
				chooseArea2(currentAreaInfo2.currentAreaId,areaContainer2.find("a[data-value='"+currentAreaInfo2.currentAreaId+"']").html());
			}
			else{
				chooseArea2(areaContainer2.find("a").eq(0).attr("data-value"),areaContainer2.find("a").eq(0).html());
			}
		}
	}
	/*currentDom = areaContainer2;
	$.getJSONP("http://d.360buy.com/area/get?fid="+cityId+"&callback=getAreaList2callback");*/
}
function chooseArea2(areaId,areaName){
	currentAreaInfo2.currentLevel = 3;
	currentAreaInfo2.currentAreaId = areaId;
	currentAreaInfo2.currentAreaName = areaName;
	var address = currentAreaInfo2.currentProvinceName+currentAreaInfo2.currentCityName+currentAreaInfo2.currentAreaName;
	$("#store-selector2 .text2 div").html(address).attr("title",address);
	$("#addressjoin2").val(""+currentAreaInfo2.currentProvinceId+","+currentAreaInfo2.currentCityId+","+currentAreaInfo2.currentAreaId);
	$('#store-selector2').removeClass('hover');
	/*provinceContainer2.hide();
	cityContainer2.hide();
	areaContainer2.hide();
	currentAreaInfo2.currentLevel = 3;
	currentAreaInfo2.currentAreaId = areaId;
	currentAreaInfo2.currentAreaName = areaName;
	if(!page_load2){
		currentAreaInfo2.currentTownId = 0;
		currentAreaInfo2.currentTownName = "";
	}
	areaTabContainer2.eq(2).removeClass("curr").find("em").html(areaName);
	areaTabContainer2.eq(3).addClass("curr").show().find("em").html("请选择");
	townaContainer2.show().html("<div class='iloading'>正在加载中，请稍候...</div>");
	currentDom = townaContainer2;
	$.getJSONP("http://d.360buy.com/area/get?fid="+areaId+"&callback=getAreaList2callback");*/
}
$("#store-selector2 .text2").after(provinceHtml2);
var areaTabContainer2=$("#JD-stock2 .tab2 li");
var provinceContainer2=$("#stock_province_item2");
var cityContainer2=$("#stock_city_item2");
var areaContainer2=$("#stock_area_item2");
var townaContainer2=$("#stock_town_item2");
var currentDom = provinceContainer2;
//当前地域信息
var currentAreaInfo2;
//初始化当前地域信息
function currentAreaInfo2Init(){
	currentAreaInfo2 =  {"currentLevel": 1,"currentProvinceId": 1871,"currentProvinceName":"湖北","currentCityId": 1872,"currentCityName":"武汉市","currentAreaId": 1893,"currentAreaName":"硚口区"};
	var ipLoc = getCookie("ipLoc-djd");
	/*ipLoc = ipLoc?ipLoc.split("-"):[1,2,20,0];
	if(ipLoc.length>0&&ipLoc[0]){
		currentAreaInfo2.currentProvinceId = ipLoc[0];
		currentAreaInfo2.currentProvinceName = getNameById2(ipLoc[0]);
	}
	if(ipLoc.length>1&&ipLoc[1]){
		currentAreaInfo2.currentCityId = ipLoc[1];
	}
	if(ipLoc.length>2&&ipLoc[2]){
		currentAreaInfo2.currentAreaId = ipLoc[2];
	}
	if(ipLoc.length>3&&ipLoc[3]){
		currentAreaInfo2.currentTownId = ipLoc[3];
	}*/
}
var page_load2 = true;
(function(){
	$("#store-selector2").unbind("mouseout").bind("mouseout",function(){
		$('#store-selector2').removeClass('hover');			
	});
	$("#store-selector2").unbind("mouseover").bind("mouseover",function(){
		$('#store-selector2').addClass('hover');
		$("#store-selector2 .content2,#JD-stock2").show();
	}).find("dl").remove();
	currentAreaInfo2Init();
	areaTabContainer2.eq(0).find("a").click(function(){
		areaTabContainer2.removeClass("curr2");
		areaTabContainer2.eq(0).addClass("curr2").show();
		provinceContainer2.show();
		cityContainer2.hide();
		areaContainer2.hide();
		townaContainer2.hide();
		areaTabContainer2.eq(1).hide();
		areaTabContainer2.eq(2).hide();
		areaTabContainer2.eq(3).hide();
	});
	areaTabContainer2.eq(1).find("a").click(function(){
		areaTabContainer2.removeClass("curr2");
		areaTabContainer2.eq(1).addClass("curr2").show();
		provinceContainer2.hide();
		cityContainer2.show();
		areaContainer2.hide();
		townaContainer2.hide();
		areaTabContainer2.eq(2).hide();
		areaTabContainer2.eq(3).hide();
	});
	areaTabContainer2.eq(2).find("a").click(function(){
		areaTabContainer2.removeClass("curr2");
		areaTabContainer2.eq(2).addClass("curr2").show();
		provinceContainer2.hide();
		cityContainer2.hide();
		areaContainer2.show();
		townaContainer2.hide();
		areaTabContainer2.eq(3).hide();
	});
	provinceContainer2.find("a").click(function() {
		if(page_load2){
			page_load2 = false;
		}
		$("#store-selector2").unbind("mouseout");
		chooseProvince2($(this).attr("data-value"));
	}).end();
	chooseProvince2(currentAreaInfo2.currentProvinceId);
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





