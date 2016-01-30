<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE  >
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
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="addCompanyProducts.do" name="userForm" method="post">
			<input type="hidden" name="userId" id="userId" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>公司名称:</th>
					<td><input type="text" name="companyId" required="required" /></td>
				</tr>
				<tr class="info">
					<th>商品名称:</th>
					<td><input type="text" required="required" name="productId"/ ></td>
				</tr>
				<tr class="info">
					<th>状态:</th>
					<td><select name="status">
							<option value="0">可用</option>
							<option value="1">冻结</option>
							<option value="2">删除</option>
					</select></td>
				</tr>
			</table>
			<input type="submit" value="提交" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>