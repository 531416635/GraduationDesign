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
	<form action="addPriceSheetList.do" name="userForm" method="post">
		<input type="hidden" name="id" id="id" value="" />
		<table border="0" cellpadding="0" cellspacing="0">
			<tr class="info" style="display: none">
				<th>用户ID:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="userId" /></td>
			</tr>

			<tr class="info">
				<th>供应商名称:</th>
				<td><input type="text" name="companyId" /></td>
			</tr>

			<tr class="info">
				<th>产品名称:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')"
					name="companyProductId" /></td>
			</tr>



			<tr class="info">
				<th>数量:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="quantity" /></td>
			</tr>

			<tr class="info">
				<th>数量单位:</th>
				<td><input type="text" name="productUnit" /></td>
			</tr>
			<tr class="info">
				<th>单价:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="unitPrice" /></td>
			</tr>
			<tr class="info">
				<th>交货期:</th>
				<td><input type="text" name="deliveryDate"
					onclick="WdatePicker()" readonly="readonly" style="width: 70px;" />
				</td>
			</tr>

			<tr class="info">
				<th>有效期至:</th>
				<td><input type="text" name="validUntil"
					onclick="WdatePicker()" readonly="readonly" style="width: 70px;" />
				</td>
			</tr>
		</table>
		<input type="submit" value="提交" />
	</form>
</body>
</html>