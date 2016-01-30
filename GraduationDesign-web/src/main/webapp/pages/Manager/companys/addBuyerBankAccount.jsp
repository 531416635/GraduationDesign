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
		<form action="addBuyerBankAccount.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>公司ID:</th>
					<td><input name="companyId" required="required"/ ></td>
				</tr>
				<tr>
					<th>银行账号:</th>
					<td><input type="text" name="bankAccount" required="required" />
					</td>
				</tr>
				<tr>
					<th>开户行地址:</th>
					<td><input type="text" name="bankAddress" required="required" />
					</td>
				</tr>
				<tr>
					<th>银行名称:</th>
					<td><input type="text" name="bankName" required="required" />
					</td>
				</tr>
				<tr style="display: none">
					<th>状态:</th>
					<td><select name="status" style="width: 173px;">
							<option value="0">初始</option>
							<option value="1">可用</option>
							<option value="2">冻结</option>
							<option value="3">删除</option>
					</select></td>
				</tr>
				<tr style="display: none">
					<th>创建时间:</th>
					<td><input type="text" onclick="WdatePicker()"
						readonly="readonly" name="createTime" required="required" /></td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>