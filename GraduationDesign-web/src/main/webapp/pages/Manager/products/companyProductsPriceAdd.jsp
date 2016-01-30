<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >
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
		<form action="companyProductPriceAdd.do" method="post">
			<input type="hidden" name="companyProductId" required="required"
				value="${companyProductId}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th></th>
					<td><input type="hidden" readOnly="readonly"
						" userId" value="${userInfo.id}" /></td>
				</tr>
				<tr>
					<th>最小数量:</th>
					<td><input type="text" required="required" name="minNum" /></td>
				</tr>
				<tr>
					<th>最大数量:</th>
					<td><input type="text" required="required" name="maxNum" /></td>
				</tr>
				<tr>
					<th>商品价格编码:</th>
					<td><input type="text" required="required"
						name="companyProductCode" /></td>
				</tr>
				<tr>
					<th>价格:</th>
					<td><input type="text" required="required" name="price" /></td>
				</tr>
				<tr>
					<th>毛利价格:</th>
					<td><input type="text" required="required" name="grossMargin" /></td>
				</tr>
				<tr>
					<th>到期时间:</th>
					<td><input type="text" required="required" name="endTime" /></td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>
