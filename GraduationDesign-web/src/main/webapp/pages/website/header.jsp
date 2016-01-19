<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="com.wit.model.Users"%>
<%@taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	/* Users user=(Users)request.getSession().getAttribute("user"); */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 这里就是装饰页面 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><decorator:title default="一起采团餐平台" /></title>
<link href="<%=path%>/css/redcss/public.css" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/css/redcss/list.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" href="<%=path%>/css/redcss/style.css"
	type="text/css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector3.css" />

<link rel="stylesheet" href="<%=path%>/css/redcss/detail.css"
	type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/lanrenzhijia.js"></script>
<%-- <script type="text/javascript" src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script> --%>
<script type="text/javascript" src="<%=path%>/js/redjs/nav.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/5icool.org.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.min.js"></script>
<%-- <script type="text/javascript" src="<%=path%>/js/redjs/jquery.min.1.js"></script>--%>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.min.2.js"></script>
<decorator:head />
<script type="text/javascript">
	
	$.ajax({
		type : "POST",
		url : "getDictionarysForHeader.do",
		dataType : "text",
		data : {
			"dicType" : 3
		},
		success : function(data) {
			//提示
			getDicData(data);
		}
	});

	$.ajax({
		type : "POST",
		url : "getFAQTypeForFooter.do",
		dataType : "text",
		data : {
			"faqTypeTop" : 5
		},
		success : function(data) {
			//提示
			getFaqTypeData(data);
		}
	});
	var getFaqTypeData = function(faqTypedata) {
		var faqType = eval('(' + faqTypedata + ')');
		//alert(faqTypedata);
		$.each(faqType, function(i, item) {
			//问题标题
			getFaqType(item.id, i);
			$("#divFAQ").find("ul").eq(i).find("li").eq(0).text(item.typeName);
		});
	};

	var getFaqType = function(faqType, typeIndex) {
		$.ajax({
			type : "POST",
			url : "getFAQForFooter.do",
			dataType : "text",
			data : {
				"faqType" : faqType
			},
			success : function(data) {
				//提示问题内容			
				getFaqData(data, typeIndex);
			}
		});
	};
	var getFaqData = function(data, typeIndex) {
		var faq = eval('(' + data + ')');
		$.each(faq, function(i, item) {
			//alert(item.title);
			//alert(item.id);
			//alert($("#divFAQ").find("ul").eq(typeIndex).find("li").eq(i+1).text());
			$("#divFAQ").find("ul").eq(typeIndex).find("li").eq(i + 1).text(
					item.title).click(function() {
				location.href = "<%=path%>/web/commonProblem.do?id="+item.id;
					}).css("cursor","pointer");
		});
	};
	
	var getDicData = function(data) {
		var dic = eval('(' + data + ')');
		$.each(dic, function(i, item) {
			switch (item.dicCode) {
			case "Logo":
				//alert(item.dicName);
				$("#imgLogo").attr("src", "<%=path%>" + item.dicValue);//填充内容;//
				break;
			case "Copyright":
				//alert(item.dicName);
				$("#divCopyright").html(item.dicValue);
				break;
			case "Banner":
				//alert(item.dicName);
				break;
			}
		});
	};

	$(function() {
		//点击后判断ul是否隐藏
		$(".purchase p").click(function() {
			var ul = $(".listUl");
			if (ul.css("display") == "none") {
				ul.slideDown(200);
			} else {
				ul.slideUp(200);
			}
		});
		//选中某个内容后赋值给p标签，并隐藏ul列表
		$(".purchase li").click(function() {
			var txt = $(this).text();
			$(".purchase p").html(txt);
			$(".listUl").hide();
		});
	});

	$(function() {
		$(".left_nav dd").hover(function() {
			$(".nav_right", this).show();
		});
		$(".left_nav dd").mouseleave(function() {
			$(".nav_right", this).hide();
		});
	});
	/* $(function() {
		$(".gr_d").hover(function() {
			x = $(".gr_d").index(this);
			$(".gr_d").eq(x).animate({
				left : -10
			}, 500);
		}, function() {
			$(".gr_d").eq(x).animate({
				left : 0
			}, 500);
		});
	});
	$(function() {
		$(".grid_2").hover(function() {
			x = $(".grid_2").index(this);
			$(".grid_2").eq(x).animate({
				left : -8
			}, 500);
		}, function() {
			$(".grid_2").eq(x).animate({
				left : 0
			}, 500);
		});
	}); */

	$(function() {
		$('.tab ul.menu li').click(function() {
			//获得当前被点击的元素索引值
			var Index = $(this).index();
			//给菜单添加选择样式
			$(this).addClass('active').siblings().removeClass('active');
			//显示对应的div
			$('.tab').children('div').eq(Index).show().siblings('div').hide();

		});
	});
	function searchProduct() {
		location.href="<%=path%>	/web/toSecondIndex.do?products="
			+ $('#products').val() + "&&cateGoryLevel=1&&cateGoryId=4";
	}

	//加入收藏

	function favorites() {
		var title = document.title;
		var url = window.location;
		var ua = navigator.userAgent.toLowerCase();
		if (ua.indexOf("360se") > -1) {
			alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
		} else if (ua.indexOf("msie 8") > -1) {
			window.external.AddToFavoritesBar(url, title); //IE8 
		} else if (document.all) {
			try {
				window.external.addFavorite(url, title);
			} catch (e) {
				alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
			}
		} else if (window.sidebar) {
			window.sidebar.addPanel(title, url, "");
		} else {
			alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
		}
	}
	
	/**********/
	var jsonAddrs3="";
	//header头部页面显示省
	$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddDictionary.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
			productId:"45"
			},
			success : function(data) {
					var json = eval(data);
					jsonAddrs3=json;
				
 			 $.getScript("<%=path%>/js/redjs/selector3.js");
		
				
			},
			
		});
	//header首页选中省市区存入session中
	function  addressAjax(){
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/addProvince.do",
			data : {
			provinceName:$("#provinceName").val(),
			provinceId:$("#provinceId").val(),
			cityName:$("#cityName").val(),
			cityId:$("#cityId").val(),
			areaName:$("#areaName").val(),
			areaId:$("#areaId").val(),
			},
			success : function(data) {
					var json =eval('(' + data + ')');
				if(json==true){
				 location.reload() ;
				}
	}	
	});};
		/**********/
</script>
<style type="text/css">
#ProvinceInfo {
	width: 300px;
	height: 250px;
	position: relative;
	left: 0px;
	top: 24px;
	background-color: #fff;
	z-index: 5;
	display: none;
}
</style>
</head>
<body>
	<input type="hidden" id="provinceName"
		value="${sessionScope.provinceName }" />
	<input type="hidden" id="provinceId"
		value="${sessionScope.provinceId }" />
	<input type="hidden" id="cityName" value="${sessionScope.cityName }" />
	<input type="hidden" id="cityId" value="${sessionScope.cityId }" />
	<input type="hidden" id="areaName" value="${sessionScope.areaName }" />
	<input type="hidden" id="areaId" value="${sessionScope.areaId }" />
	<div class="head_box">
		<div class="head">
			<div style="float: left;">
				<ul id="list3" style="width: 620px; margin: 0px auto 0 auto;">
					<li id="summary-stock3">
						<div class="dt">配送至：</div>
						<div class="dd">
							<div id="store-selector3">
								<div class="text3">
									<div></div>
									<b></b> <input type="hidden" id="addressjoin3" value="" />
								</div>
								<div onclick="$('#store-selector3').removeClass('hover')"
									class="close"></div>
							</div>
							<div id="store-prompt3">
								<strong></strong>
							</div>
						</div>
					</li>
				</ul>
				<%-- <span id="AddDictionary" onmouseover="dictionaryOver()"
					onmouseout="dictionaryOut()">配送至：<c:if
						test="${province==null }">湖北</c:if>
					<c:if test="${province!=null }">${province.dicName}</c:if>
				</span> --%>
				<span class="welcome">您好, 欢迎来到一起采商城！</span>

			</div>

			<div style="float: right;">
				<c:if test="${user ==null }">
					<a href="toLogin.do">登录</a>
					<span> |</span>
					<a href="toReg.do">注册</a>
				</c:if>
				<c:if test="${user !=null }">
					<%-- <a href="javascript:void(0)">${user.userName }</a> --%>
					<a href="toLogin.do">${user.userName }</a>
					<span> |</span>
					<a href="/ssm/web/cancel.do">退出</a>
				</c:if>
				<span> |</span><a class="collect" rel="sidebar" href="#"
					style="cursor: pointer" onclick="favorites();">收藏我们</a><span>|
				</span> <span>客服电话400 991 3966</span>
			</div>

			<div id="ProvinceInfo"></div>
		</div>
	</div>
	<!--搜索-->
	<div class="search_box">
		<div class="logo">
			<a href="#"><img id="imgLogo"
				src="<%=path%>/images/redimg/logo.jpg"> </a>
		</div>
		<dl class="se_1">
			<dt>
				<input id="products" placeholder="请输入关键词">
				<button onclick="searchProduct();">搜索</button>
			</dt>
			<dd>
				热门搜索: <a
					href="<%=path%>/web/toSecondIndex.do?products=米&&cateGoryLevel=1&&cateGoryId=4">米</a>
				<a
					href="<%=path%>/web/toSecondIndex.do?products=面&&cateGoryLevel=1&&cateGoryId=4">面</a>
				<a
					href="<%=path%>/web/toSecondIndex.do?products=鸡蛋&&cateGoryLevel=1&&cateGoryId=4"">鸡蛋</a>
			</dd>
		</dl>
	</div>
	<!--导航-->
	<%-- <div class="nav_box">
		<div class="nav_in">
			<div class="all_t">
				<a class="all" href="#">商品分类</a>
			</div>
			<a class="nav" href="<%=path%>/web/toIndex.do">首页</a> <a class="nav"
				href="#">食材团购</a> <a class="nav" href="#">现货特价</a> <a class="nav"
				href="#">价格指数</a> <a class="nav" href="#">论坛社区</a>
			<div class="cart">
				<div class="purchase">
					<p>
						<a href="#">我的采供后台</a>
					</p>
					<ul class="listUl">
						<li><a href="/ssm/merchant/myInquiry.do">询单历史</a></li>
						<li><a href="/ssm/merchant/xiadan.do">下订单</a></li>
						<li><a href="/ssm/merchant/myOrder.do">我的订单</a></li>
						<li><a href="/ssm/merchant/myDispatchBill.do">发货单</a></li>
						<li><a href="">我的发票</a></li>
					</ul>
				</div>
				<span> <a href="#">购买指引</a> </span>
			</div>
		</div>
	</div> --%>
	<!--导航-->
	<div class="nav_box">
		<div class="nav_in">
			<div class="all_t">
				<img class="all_img" src="<%=path%>/images/index/splb.png"><a
					class="all" href="#" style="width: 130px;">所有商品分类</a>
			</div>
			<a class="nav" href="<%=path%>/web/toIndex.do">首页</a> <a class="nav"
				href="<%=path%>/web/toGroupon.do">食材团购</a> <a class="nav"
				href="<%=path%>/web/toSpotPriceIndex.do">现货特价</a> <a class="nav"
				href="#">价格指数</a> <a class="nav" href="#">论坛社区</a>
			<!-- <div class="cart">
     
      <div class="purchase">  
      <p>我的采供后台</p>
      <ul class="listUl">
        <li><a href="<%=path%>/merchant/myInquiry.do">我的询价</a></li>
		<li><a href="<%=path%>/merchant/myPriceSheet.do">我的报价</a></li>
		<li><a href="<%=path%>/merchant/myOrder.do">我的订单</a></li>
		<li><a href="<%=path%>/merchant/myDispatchBill.do">配送单</a></li>
		<li><a href=""></a></li>
      </ul>
      
      </div>
      <span>
      <a href="#">购买指引</a>
      </span>
    </div> -->
			<div class="purchase">
				<a href="/ssm/merchant/InquiryShoppingCar.do"> <img
					src="<%=path%>/images/index/gwc.png" style="float: left;"></a>
				<div>
					<a href="/ssm/merchant/toPurchaserList.do"><img
						src="<%=path%>/images/index/cggl.png" style="float: right;"></a>
				</div>
			</div>
		</div>
	</div>

	<decorator:body />

	<div class="foot">
		<div class="stern_box">
			<div class="di_div">
				<ul class="di_bat">
					<li><img src="<%=path%>/images/index/authentic.png"> <!-- <h4>一起采商城</h4> -->
						<p style="margin-top: 10px;">品质保证</p></li>
					<li><img src="<%=path%>/images/index/transport.png"> <!-- <h4>一起采商城</h4> -->
						<p style="margin-top: 10px;">配送保证</p></li>
					<li><img src="<%=path%>/images/index/delivery.png"> <!-- <h4>一起采商城</h4> -->
						<p style="margin-top: 10px;">服务保证</p></li>
					<li><img src="<%=path%>/images/index/photo.png"> <!-- <h4>一起采商城</h4> -->
						<p style="margin-top: 10px;">样品保证</p></li>
					<li><img src="<%=path%>/images/index/guide.png"> <!-- <h4>一起采商城</h4> -->
						<p style="margin-top: 10px;">安全结算</p></li>
				</ul>
			</div>
			<div id="divFAQ" class="stern_in">
				<ul class="each" style="margin-left: 70px;">
					<li class="ea_1"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
				</ul>
				<ul class="each">
					<li class="ea_1"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
				</ul>
				<ul class="each">
					<li class="ea_1"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
				</ul>
				<ul class="each">
					<li class="ea_1"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
				</ul>
				<ul class="each">
					<li class="ea_1"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
					<li class="ea_2"></li>
				</ul>
			</div>

		</div>
		<!--红色底部条条 <div class="co_box2">
		    <p style="font-size: 14px;color:#F9F9F9;">© 2009-2014 珍蔡食料商城版权所有，并保留所有权利       武汉市江夏区光谷大道金融港B6栋公采大厦      E-mail : 12345678qq.com</p>
		</div> -->
		<div class="co_box">
			<img src="<%=path%>/images/redimg/co_01.png">
			<p id="divCopyright">© 2009-2015 一起采商城版权所有，并保留所有权利</p>
		</div>
	</div>

</body>
</html>