<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
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
		<form action="productTransferAdd.do" method="post">
			<input type="hidden" name="companyProductId"
				value="${companyProductId}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>中转地:</th>
					<td><input type="text" name="transitShipment"
						required="required" /></td>
				</tr>
				<tr>
					<th>联系人:</th>
					<td><input type="text" name="linkMan" required="required" /></td>
				</tr>
				<tr>
					<th>联系电话:</th>
					<td><input type="text" name="linkTel" required="required" /></td>
				</tr>
				<tr>
					<th>到达时间:</th>
					<td><input type="text" name="arrivalTime" required="required" /></td>
				</tr>
				<tr>
					<th>批次:</th>
					<td><input type="text" name="batch" required="required" /></td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>
