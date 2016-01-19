<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

div {
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="shoppingAddressAdd.do" method="post">
		<input type="hidden" name="status" value="1">
			<table border="0" cellpadding="0" cellspacing="0">
		<tr >
			<th>配送地址:</th>
			<td><input type="text" name="shoppingAddress"/></td>
		</tr>
		<tr >
			<th>地址简称:</th>
			<td><input type="text" name="adderssName"/></td>
		</tr>
		<tr >
			<th>公司名称:</th>
			<td><input type="text" name="companyId"/></td>
		</tr>
		<tr >
			<th>用户名称:</th>
			<td><input type="text" name="userId"/></td>
		</tr>
			</table>
			<input type="submit" value="增加" />
			<input type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>
