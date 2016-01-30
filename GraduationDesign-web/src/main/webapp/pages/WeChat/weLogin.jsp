<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";	
%>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<!-- Custom Theme files -->
<link href="<%=path%>/css/WeChatcss/style.css" rel="stylesheet"
	type="text/css" media="all" />
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<link
	href='http://fonts.useso.com/css?family=Roboto:500,900italic,900,400italic,100,700italic,300,700,500italic,100italic,300italic,400'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.useso.com/css?family=Droid+Serif:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<!--Google Fonts-->

<style type="text/css">
p {
	font-size: 85%;
}

span {
	width: 15%;
}

img {
	width: 20px;
	height: 20px;
	padding: 5px;
}
</style>

<script type="text/javascript">
    window.onload = function() { 
		var newH=window.screen.height-60;
		document.getElementById("div_body").style.height = newH + "px";
	};
function check_login() {
		$.ajax({
			type : "POST",
			url : "login.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "nullError") {
					$("#msg").text("请输入用户名");
				} else if (data == "nameError") {
					$("#msg").text("用户名不存在");
				} else if (data == "null2Error") {
					$("#msg").text("请输入密码");
				} else if (data == "pwdError") {
					$("#msg").text("密码错误");
				} else if(data=="typeError"){
				   $("#msg").text("登录平台错误");
				}else if (data == "success"){
					location.href = "/ssm/web/toIndex.do";
				}else if(data == "companyError"){
					$("#msg").text("未找到公司信息");
				}else if(data == "authenticationError"){
					location.href = "/ssm/merchant/toCompanyAuthentication.do";
				}else if(data == "freeze"){
					$("#msg").text("账户已冻结");
				}else if(data == "delete"){
					$("#msg").text("账户已删除");
				}else if(data == "companyDelete"){
					$("#msg").text("公司信息已删除");
				}
			}
		});
	}
</script>
</head>
<body>
	<div id="div_body" class="login-top">
		<div style="height: 320px; padding-top: 20px;">
			<form action="/ssm/weChat/login.do" method="post" id="form">
				<div>
					<span id="msg" style="color: red;"></span>
				</div>
				<div class="div_input">
					<span><img src="<%=path %>/images/WeChat/denlv.png" /></span> <input
						id="name" type="text" name="userCode" placeholder="&nbsp;用户名:">
				</div>
				<div class="div_input">
					<span><img src="<%=path %>/images/WeChat/mima.png" /></span> <input
						id="pwd" type="password" name="userPsw" placeholder="&nbsp;密码:">
				</div>
				<input style="width: 100%; height: 40px; font-size: 180%"
					type="button" value="登 录" onclick="check_login();">
			</form>
			<div class="forgot">
				<p>
					没有一起采账号<a href="/ssm/web/toReg.do">点击这里进行注册</a><a
						style="float: right" id="pw" href="/ssm/web/toWjmm.do">忘记密码</a>
				</p>
			</div>
		</div>
	</div>
</body>
</html>