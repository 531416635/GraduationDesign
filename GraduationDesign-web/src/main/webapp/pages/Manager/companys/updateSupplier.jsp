<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	top: 30%;
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
		<form action="updateSupplier.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr style="display: none">
					<th>ID</th>
					<td><input name="id" readonly="readonly" value="${cp.id}" />
					</td>
				</tr>
				<tr>
					<th>公司名称:</th>
					<td><input type="text" name="companyName"
						value="${cp.companyName}" /></td>
				</tr>
				<tr>
					<th>公司地址:</th>
					<td><input type="text" name="companyAddress"
						value="${cp.companyAddress}" /></td>
				</tr>
				<tr>
					<th>公司规模:</th>
					<td><input type="text" name="companyScale"
						value="${cp.companyScale}" /></td>
				</tr>
				<tr>
					<th>注册资本:</th>
					<td><input name="registeredCapital" type="text"
						value="${cp.registeredCapital}" /></td>
				</tr>
				<tr>
					<th>公司电话:</th>
					<td><input type="text" name="companyTel"
						value="${cp.companyTel}" /></td>
				</tr>
				<tr>
					<th>邮政编码:</th>
					<td><input type="text" name="zipCode" value="${cp.zipCode}" />
					</td>
				</tr>
				<tr>
					<th>公司简介:</th>
					<td><input type="text" name="companyInfo"
						value="${cp.companyInfo}" /></td>
				</tr>
				<tr>
					<th>销售人员:</th>
					<td><input type="text" name="salesMan" value="${cp.salesMan}" />
					</td>
				</tr>
				<tr>
					<th>公司网址:</th>
					<td><input type="text" name="companyWebsite"
						value="${cp.companyWebsite}" /></td>
				</tr>
				<tr>
					<th>状态:</th>
					<td><c:choose>
							<c:when test="${cp.status==0}">
								<input type="radio" name="status" value="0" checked="checked">
					未认证
				</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="0">
					未认证
				</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${cp.status==1}">
								<input type="radio" name="status" value="1" checked="checked">
					已认证
				</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="1">
					已认证
				</c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>公司联系人:</th>
					<td><input type="text" name="companyContact"
						value="${cp.companyContact}" /></td>
				</tr>
			</table>
			<input type="submit" value="修改" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>