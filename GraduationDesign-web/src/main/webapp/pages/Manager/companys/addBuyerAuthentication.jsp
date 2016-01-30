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
	<div>
		<form action="addBuyerAuthentication.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>认证名称:</th>
					<td><input name="authenticationName" required="required" "${authenticationName}" />
					</td>
				</tr>
				<tr>
					<th>认证文件:</th>
					<td><input type="text" name="filePath" required="required"
						value="${filePath}" /></td>
				</tr>
				<tr style="display: none">
					<th>企业名称ID</th>
					<td><input type="text" name="companyId" required="required"
						value="${companyId}" /></td>
				</tr>
				<tr style="display: none">
					<th>企业类型:</th>
					<td><input type="text" readonly="readonly" required="required"
						name="companyType" value="2" /></td>
				</tr>
				<tr style="display: none">
					<th>状态</th>
					<td><select name='status' style="width: 173px;">
							<option value="0">初始</option>
							<option value="1">可用</option>
							<option value="2">冻结</option>
							<option value="3">结算</option>
					</select></td>
				</tr>
				<tr style="display: none">
					<th>上传时间:</th>
					<td><input type="text" name="uploadTime" required="required"
						onclick="WdatePicker()" readonly="readonly" value="${uploadTime}" />
					</td>
				</tr>
				<tr style="display: none">
					<th>上传人:</th>
					<td><input type="text" name="uploadBy" value="${companyId}"
						required="required" /></td>
				</tr>
				<tr style="display: none">
					<th>文件类别:</th>
					<td><input name="fileClass" value="${fileClass}"
						checked="checked" /></td>
				</tr>

			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>