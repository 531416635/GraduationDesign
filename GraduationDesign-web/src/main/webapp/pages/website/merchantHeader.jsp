<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 这里就是装饰页面 -->
<head>
<title><decorator:title default="一起采团餐平台" /></title>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector6.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.10.2.min.js"></script>
<decorator:head />
<script type="text/javascript">
	$.ajax({
		type : "POST",
		url : "<%=path%>/merchant/getMenusListForHeader.do",
		dataType : "text",
		data : {

		},
		success : function(data) {
			//提示
			//alert($("#divMenu ul").eq(0).html());
			getMenusData(data);
		}
	});
	var getMenusData = function(data) {
		var menus = eval('(' + data + ')');
		//alert(faqTypedata);
		if (menus != null) {
			$("#divMenu ul").eq(0).children().remove();

			$("#divMenu ul").eq(0).append(eachMenus(menus, 590));
			//alert($("#divMenu").html());
			$('#nav a').hover(function() {
				$(this).siblings('#nav ul').show();
			}, function() {
				$(this).siblings('#nav ul').hide();
			});
			$('#nav ul').hover(function() {
				$(this).show();
			}, function() {
				$(this).hide();
			});
		}

	};

	var eachMenus = function(menus, parentId) {
		var menuStr = "";
		$.each(menus, function(i, item) {
			//alert(item.parentMenu);
			if (item.parentMenu == parentId) {
				menuStr = menuStr + "<li><a href='" + item.menuUrl
						+ "'>"
						+ item.menuName + "</a>";
				var tmp = eachMenus(menus, item.id);
				if (tmp != null && tmp != "") {
					menuStr = menuStr + "<ul>" + tmp + "</ul>";
				}
			}

		});
		return menuStr;
	};
	$.ajax({
		type : "POST",
		url : "<%=path%>/merchant/getNewsListForHeader.do",
		dataType : "text",
		data : {
			"dicType" : 3
		},
		success : function(data) {
			//提示
			getNewsData(data);//divNews
		}
	});
	var getNewsData = function(data) {
		var news = eval('(' + data + ')');
		//alert(faqTypedata);
		if (news != null) {
			$("#divNews ul").eq(0).children().remove();
			$.each(news, function(i, item) {
				var title = item.title;
				$("#divNews ul").eq(0).append(
						"<li><a href='" + item.id
						+ "'>"
								+ title.substr(0, 15) + "</a>");
					
				//alert($("#divMenu").html());
			});
			
		}
      
	};
	$.ajax({
		type : "POST",
		url : "<%=path%>/merchant/getUserForHeader.do",
		dataType : "text",
		data : {
			"dicType" : 3
		},
		success : function(data) {
			//提示
			//alert(data);
			getUserData(data);

		}
	});

	var getUserData = function(data) {
		var user = eval('(' + data + ')');
		//alert(data);
		
		if (user != null) {
		
			if(user.userPhoto!=null &&user.userPhoto!=""){					
				var userPhoto="<a href='toUploadAvatar.do'><img title='点击更换头像' <%-- src='<%=path%>"+user.userPhoto+"' --%>src='<%=path%>/${user.userPhoto}' class='round_photo'></a>";
				//$(this).find("img").eq(0).attr("src",<%=path%>+user.userPhoto);
				$(".user_div_header").html(userPhoto);
			}else{
				var userPhoto="<a href='toUploadAvatar.do'><img id=\"defaultImg\" src=\"<%=path%>	/images/people.png\" title=\"点击上传头像\"	class=\"round_photo\" /></a>";
				$(".user_div_header").html(userPhoto);
			}
			/* <span style="color: #D27474;font-size: 18px;font-weight: bold;">供应商1</span>
						<span>供应部</span><br /> 欢迎登录！<br /> */

			var userName = '<span style="color: #D27474;font-size: 18px;font-weight: bold;">'
					+ user.userName + '</span><br />';
			userName += '<span>';
			if (user.departmentName != null && user.departmentName != '') {
				userName += user.departmentName;
			}
			userName += '</span>';
			if (user.jobName != null && user.jobName != '') {
				userName += user.jobName;
			}
			userName += '<br /><span style="font-size: 14px;">欢迎登录！</span><br />';
			$(".user_div_name").html(userName);

			var companyNamehtml = user.companyName
					+ '<span style=\"color: #FE3637;\">[';

			switch (user.companyStatus) {
			case 3:
				companyNamehtml += '等待系统认证';
				break;
			case 1:
				companyNamehtml += '已认证';
				break;
			default:
				companyNamehtml += '未认证';
				break;
			}
			companyNamehtml += ']</span><br /> ';
			switch (user.companyType) {
			case 1:
				companyNamehtml += "用户级别：VIP用户";
				break;
			case 2:
				companyNamehtml += "用户级别：普通用户";
				break;
			}
			$(".user_div_intro").html(companyNamehtml);
		}

	};

	$(function() {
		$('#nav a').hover(function() {
			$(this).siblings('#nav ul').show();
		}, function() {
			$(this).siblings('#nav ul').hide();
		});
		$('#nav ul').hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
	});

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
ul {
	list-style-type: none
}

#nav {
	width: 100%;
	margin: 0;
	padding: 0;
	z-index: 2;
	position: relative;
}

#nav li {
	float: left;
	position: relative;
	padding: 0;
	line-height: 45px;
	height: 45px;
}

#nav li ul {
	display: none;
	position: absolute;
	top: 35px;
	left: 0px;
}

#nav li a:hover {
	background-color: #8d0100;
	text-decoration: none;
}

#nav li a {
	float: left;
	display: block;
	width: 100px;
	font-size: 14px;
	background-color: #B00000;
	text-align: center;
}

#nav li ul {
	width: 100px;
	margin-top: 8px;
}

#nav li li {
	float: left;
	padding: 0;
	height: 30px;
	line-height: 30px;
	width: 100px;
}

#nav li li a {
	width: 100px;
	font-size: 12px;
}

#wel_div_tou a {
	color: #666;
	text-decoration: none;
}

/* 设置图像圆圈  */
.round_photo {
	width: 90px;
	height: 90px;
	border: 4px solid #ddddde;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	border-radius: 50%;
	behavior: url(<%=path%>/js/PIE.htc);
}

.user_div_con {
	font-size: 14px;
	color: #A8A8A8;
	margin-top: 20px;
	margin-left: 10px;
	margin-right: 5px;
	line-height: 23px;
}

.user_div_header {
	float: left;
}

.user_div_con .user_div_name {
	float: left;
	width: 115px;
	overflow: hidden;
	height: auto;
	padding-left: 5px;
	padding-top: 20px;
	font-size: 11px;
}

.user_div_con .user_div_intro {
	padding-top: 20px;
}

.navdiv  .all {
	color: #fff;
	display: block;
	float: left;
	font-family: "Microsoft Yahei";
	font-size: 15px;
	height: 31px;
	margin-left: 1px;
	text-align: center;
	text-shadow: 2px 2px 5px #444;
}

.purchasemk {
	background-color: #FFFFFF;
	border-radius: 5px;
	float: left;
	height: 29px;
	margin: 8px 5px;
	width: 142px;
	font-family: "Microsoft Yahei";
	font-size: 15px;
}

.purchasemk  .mb {
	text-align: center;
	height: 29px;
	line-height: 29px;
	color: #B00000;
}

.news_div a {
	color: #999;
	text-decoration: none;
}

.news_div a:hover {
	color: #999;
	text-decoration: none;
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
	<div class="top">
		<div id="wel_div_tou" class="wel">
			<ul id="list3" style="width: 620px; margin: 0px auto 0 -30px;">
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
			&nbsp; <span class="wel1">你好！欢迎来到一起采网！</span> <span class="wel2">
				<c:if test="${user ==null }">
					<a href="/GraduationDesign/web/toLogin.do">登录</a>
				</c:if> <c:if test="${user !=null }">
					<a href="/GraduationDesign/web/toLogin.do">${user.userName }</a>
						 |
					<a href="/GraduationDesign/web/cancel.do">退出</a>
				</c:if> | <a rel="sidebar" href="#"
				style="cursor: pointer; 
				background: transparent url('<%=path%>/images/redimg/ico_01.png') no-repeat scroll left center;
				padding-left: 20px;"
				onclick="favorites();">加入收藏 </a>| <a href="#">联系客服</a>
			</span>&nbsp;&nbsp;
		</div>
	</div>
	<div class="header">
		<div class="logo">
			<img id="imgLogo" src="<%=path%>/images/redimg/logo.jpg">
		</div>
		<div class="searchdiv">
			<form action="<%=path%>/web/toSecondIndex.do" method="post">

				<input type="text" name="products" class="searchinput" value="" />
				<input type="hidden" name="cateGoryId" class="searchinput" value="4" />
				<input type="hidden" name="cateGoryLevel" class="searchinput"
					value="1" /> <input type="submit" value="搜索" class="search_btn" />
			</form>
		</div>
	</div>
	<div class="nav">
		<div class="navdiv">
			<div class="sort" style="background-color: #9d0100; width: 240px;">
				<img class="all_img"
					style="float: left; height: 20px; margin: 10px; width: 20px;"
					src="<%=path%>/images/index/splb.png"> <a class="all"
					href="/GraduationDesign/merchant/toPurchaserList.do" style="width: 180px;"><span
					style="color: white;">采供首页</span> </a>
			</div>
			<div id="divMenu" class="sort_rig" style="padding-left: 5px;">
				<ul id="nav">
				</ul>
			</div>
			<div style="float: right; height: 45px; width: 190px;">
				<!--  class="navdiv_rig" -->
				<a href="/GraduationDesign/merchant/InquiryShoppingCar.do"> <img
					style="float: left; margin-top: 8px;"
					src="<%=path%>/images/index/gwc.png"></a>
				<div class="purchasemk">
					<div class="mb">
						<a href="/GraduationDesign/web/toIndex.do"><img style="float: left;"
							src="<%=path%>/images/index/return_03.png"></a>
						<%--  <img style="float: left;" src="<%=path %>/images/index/cggl.png"> --%>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="warp">
		<div class="bjd_left">
			<div class="user_div">
				<div class="user_div_con">
					<div class="user_div_header">
						<%-- <%=path%>/img/1/18.jpg --%>
						<img id="defaultImg" src="<%=path%>/images/people.png"
							title="用户头像" class="round_photo" />
					</div>
					<div class="user_div_name">
						<!-- <span style="color: #D27474;font-size: 18px;font-weight: bold;">供应商</span>
						<span>供应部</span>
						<br /> 欢迎登录！<br />
						工作提醒<span style="color: #BF2F2F;">(5条)</span> -->
					</div>
					<div style="clear: both;"></div>
					<div class="user_div_intro">
						<!-- 武汉xx餐饮有限公司<span style="color: #FE3637;">[未认证]</span><br />
						采购等级：A级 -->
					</div>
				</div>

				<%-- 
				<table id="tbUser"
					style="margin-left:15px;height:230px; width:230px; border:0px solid #d6d6d6; float:left;">
					<tr>
						<td rowspan="3" style="width:50%"></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
				</table>
				--%>
			</div>
			<div class="news_div">
				<h2>新闻公告 &nbsp;</h2>
				<div id="divNews" class="listdiv">
					<ul>
						<c:forEach items="${newList}" var="nl">
							<li><a
								href="<%=path%>/web/newOrNoiceInfo.do?newOrNoticeId=${nl.id}&&type=${nl.newType}">${nl.title}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="news_div">
				<h2>关于我们 &nbsp;</h2>
				<div class="listdiv">
					<ul>
						<li>联系电话：400 991 3966</li>
						<li>工作时间：09:00-20:00</li>
						<li><img src="<%=path%>/images/index/weixin.jpg"
							style="width: 160px; height: 160px" /></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="bjd_right">
			<!-- <div class="position_div">
				<p>当前位置:&nbsp;&nbsp;&nbsp;&nbsp;</p>
			</div> -->
			<decorator:body />
		</div>
	</div>
</body>
</html>