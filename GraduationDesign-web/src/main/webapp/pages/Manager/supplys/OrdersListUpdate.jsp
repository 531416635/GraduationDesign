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
</style>
</head>
<body>
	<form action="updateOrdersList.do" name="userForm" method="post">
		<input type="hidden" name="id" id="id" value="${orders.id}" />
		<table border="0" cellpadding="0" cellspacing="0">
			<tr class="info">
				<th>订单状态:</th>
				<td><input type="radio" name="status" value="0" /><span>申请</span>
					<input type="radio" name="status" value="1" /><span>处理</span> <input
					type="radio" name="status" value="2" /><span>完成</span></td>
			</tr>
			<tr class="info">
				<th>订单编号:</th>
				<td><input type="text" name="orderId" value="${orders.orderId}"
					style="width: 70px;" /></td>
			</tr>
			<tr class="info">
				<th>用户ID:</th>
				<td><input type="text" name="userId" value="${orders.userId}"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" /></td>
			</tr>
		</table>
		<input type="submit" value="提交" />
	</form>
</body>
</html>