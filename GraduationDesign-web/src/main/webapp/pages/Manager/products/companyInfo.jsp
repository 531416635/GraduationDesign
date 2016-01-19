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
	text-align: right;
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
	left:40%;
	margin-left: -50px;
}
</style>
</head>
<body>
<div>
	<form action="" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>公司ID</th>
				<td><input  name="id" type="text" readonly="readonly"
					value="${company.id}"/>
				</td>
			</tr>
			<tr>
				<th>公司名称</th>
				<td><input  name=companyName type="text" readonly="readonly"
					value="${company.companyName}"/>
				</td>
			</tr>
			<tr>
				<th>公司地址</th>
				<td><input name="companyAddress" readonly="readonly" value="${company.companyAddress}" />
				</td>
			</tr>
			<tr>
				<th>公司规模</th>
				<td><input name="companyScale" readonly="readonly" value="${company.companyScale}" />
				</td>
			</tr>
			<tr>
				<th>注册资本</th>
				<td><input name="registeredCapital" readonly="readonly"
					value="${company.registeredCapital}" />
				</td>
			</tr>
			<tr>
				<th>公司电话</th>
				<td><input name="companyTel" readonly="readonly" value="${company.companyTel}" />
				</td>
			</tr>
			<tr>
				<th>邮政编码</th>
				<td><input name="companyZipCode" readonly="readonly" value="${company.companyZipCode}" />
				</td>
			</tr>
			<tr>
				<th>公司简介</th>
				<td><input name="companyInfo" readonly="readonly" value="${company.companyInfo}"/>
				</td>
			</tr>
			<tr>
				<th>销售人员</th>
				<td><input name="salesan" readonly="readonly" value="${company.salesMan}" />
				</td>
			</tr>
			<tr>
				<th>公司网址</th>
				<td><input name="companyWebsite" readonly="readonly" value="${company.companyWebsite}" />
				</td>
			</tr>
			<tr>
				<th>公司联系人</th>
				<td><input name="companyContact" readonly="readonly" value="${company.companyContact}" />
				</td>
			</tr>
			<tr>
				<th>公司类别</th>
				<td><input name="companyType" readonly="readonly" value="${company.companyType}" />
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>