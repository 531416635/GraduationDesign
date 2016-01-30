<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:url var="base" value="/">
</c:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

.input_txt {
	width: 200px;
	height: 20px;
	line-height: 20px;
}

.info {
	height: 40px;
	line-height: 40px;
}

.info th {
	text-align: right;
	width: 65px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}

div {
	position: absolute;
	top: 10%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}

#regist {
	height: 30px;
	width: 70px;
	background-color: orange;
}

span {
	text-align: right;
	width: 65px;
	color: #4f4f4f;
	padding-right: 1px;
	font-size: 10px;
}
</style>
</head>
<body>
	<div>
		<form action="" name="userForm" method="post">
			<input type="hidden" name="userId" id="userId" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th><a style="color: #FF0000">*</a>会员身份</th>
					<td><input type="radio" name="user" value="0" /><span>采购商</span>
						<input type="radio" name="user" value="1" /><span>供应商</span></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>电子邮箱</th>
					<td><input type="text" name="roleCode" style="width: 165px;" /></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>登录名</th>
					<td><input type="text" name="status" style="width: 165px;" /></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>密码</th>
					<td><input type="text" name="createTime" style="width: 168px;" /></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>确认密码</th>
					<td><input type="text" name="createBy" /></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>公司名称</th>
					<td><input type="text" name="createBy" /></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>联系人</th>
					<td><input type="text" name="createBy" style="width: 60px;" />
						<input type="radio" name="who" value="0" checked /><span>先生</span>
						<input type="radio" name="who" value="1" /><span>女士</span></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>联系电话</th>
					<td><input type="text" name="createBy" style="width: 168px;" /></td>
				</tr>
				<tr class="info">
					<th><a style="color: #FF0000">*</a>验证码</th>
					<td><input type="text" name="createBy" style="width: 100px;" />
					</td>
				</tr>
				<tr class="info">
					<th></th>
					<td><input type="radio" name="" /> <span>我已阅读并接受<a
							href="javacript:;">&lt;&lt;团掌网用户协议&gt;&gt;</a>及<a
							href="javacript:;">&lt;&lt;隐私策略&gt;&gt;</a></span></td>
				</tr>
			</table>
			<input id="regist" type="submit" value="注册" />
		</form>
	</div>
</body>
</html>