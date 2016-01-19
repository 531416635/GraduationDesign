<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
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
		<form action="insertSupplierBalance.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>公司ID:</th>
					<td><input type="text" name="companyId" value="${companyId}"   />
					</td>
				</tr>
				<tr>
					<th>币种:</th>
					<td><select name='currency' style="width:173px;">
							<option value="人民币">人民币</option>
							<option value="美元">美元</option>
					</select>
					</td>
				</tr>
				<tr>
					<th>账户金额:</th>
					<td><input type="text" name="balance" value="${balance}"  required="required" />
					</td>
				</tr>
				<tr style="display: none">
					<th>账户状态:</th>
					<td>
					<select name='status' style="width:173px;" >
							<option value="0">初始</option>
							<option value="1">可用</option>
							<option value="2">冻结</option>
							<option value="3">结算</option>
					</select>
					</td>
				</tr>

			</table>
			<input type="submit" value="增加" />
			<input type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>