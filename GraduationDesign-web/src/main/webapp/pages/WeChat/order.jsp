<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- Custom Theme files -->
<link href="<%=path %>/css/WeChatcss/style.css" rel="stylesheet" type="text/css" media="all" />
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
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<!--Google Fonts-->
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>

<script type="text/javascript">
	window.onload = function() {
		var newH = window.screen.height - 60;
		document.getElementById("div_body").style.height = newH + "px";
	};

	function checkTime() {
		if ($("#startOrderTime").val() != "" && $("#endOrderTime").val() != "") {

			if ($("#startOrderTime").val() > $("#endOrderTime").val()) {
				alert("开始时间不应大于结束时间！")
			} else {
				$("#form1").submit();
			}
		}else{
		$("#form1").submit();		
		}
		
	};
</script>
<style type="text/css">
span {
	width: 22%;
}
</style>
</head>
<body>
	<div class="login">
		<div class="login-top">
			<form style="width:85%; margin:0 auto;" action="/ssm/weChat/order.do"
				method="post" id="form1">
				<div class="order_input">
					<span>日期：</span>
					<!-- <input type="text"> -->
					<input onclick="WdatePicker()" id="startOrderTime"
						name="startOrderTime" />
				</div>
				<div class="order_input">
					<span>到：</span>
					<!-- <input type="text"> -->
					<input onclick="WdatePicker()" id="endOrderTime"
						name="endOrderTime" />
				</div>
				<div class="order_input">
					<span>订单号：</span> <input type="text" name="orderId">
				</div>
				<div class="order_input">
					<span>用户名字：</span> <input type="text" name="userName"
						placeholder="&nbsp;请输入用户名字">
				</div>
				<div style="margin-bottom:28px;" class="order_input">
					<span>商品名称：</span><input id="productName" type="text"
						name="productName" placeholder="&nbsp;请输入商品名称" />

				</div>
				<input style="width:45%; height:30px; float:left;" type="button"
					onclick="checkTime()" value="立即查询"> <input
					style="width:45%; height:30px; float:right;" type="submit"
					value="人工服务">
			</form>
			<div style="clear:both;margin:0px;padding:0px;line-height:0px;"></div>
		</div>
	</div>
</body>
</html>