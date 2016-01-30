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
</style>
</head>
<body>
	<div>
		<form action="invoiceUpdate.do" name="userForm" method="post">
			<input type="hidden" name="id" id="userId" value="${db.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>发票ID:</th>
					<td><input type="text" name="invoiceId"
						value="${db.invoiceId}" style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>发票类型:</th>
					<td><input type="text" name="invoiceType"
						value="${db.invoiceType}" /></td>
				</tr>
				<tr class="info">
					<th>发票抬头:</th>
					<td><input type="text" name="invoiceTitle"
						value="${db.invoiceTitle}" style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>发票金额:</th>
					<td><input type="text" name="amount" value="${db.amount}" /></td>
				</tr>
				<tr class="info">
					<th>开具时间:</th>
					<td><input type="text" name="createTime"
						onclick="WdatePicker()" style="width: 70px;" readonly></td>
				</tr>
				<tr class="info">
					<th>公司ID:</th>
					<td><input type="text" name="companyId"
						value="${db.companyId}" /></td>
				</tr>
			</table>
			<input type="submit" value="提交" />&nbsp;<input type="button"
				value="取消" onclick="location='invoice.do'" />
		</form>
	</div>
</body>
</html>