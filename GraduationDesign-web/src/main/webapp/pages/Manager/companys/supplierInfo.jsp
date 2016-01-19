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
	<form action="findSupplier.do" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr style="display: none">
				<th>公司ID</th>
				<td><input  name="id" type="text" readonly="readonly"
					value="${c.id}"/>
				</td>
			</tr>
			<tr>
				<th>公司名称:</th>
				<td>
					<span>${c.companyName}</span>
				</td>
			</tr>
			<tr>
				<th>公司地址:</th>
				<td>
				<span>${c.companyAddress}</span>
				</td>
			</tr>
			<tr>
				<th>公司规模:</th>
				<td>
				<span>${c.companyScale}</span>
				</td>
			</tr>
			<tr>
				<th>注册资本:</th>
				<td>
				<span>${c.registeredCapital}</span>
				</td>
			</tr>
			<tr>
				<th>公司电话:</th>
				<td>
				<span>${c.companyTel}</span>
				</td>
			</tr>
			<tr>
				<th>邮政编码:</th>
				<td>
				<span>${c.zipCode}</span>
				</td>
			</tr>
			<tr>
				<th>公司简介:</th>
				<td>
				<span>${c.companyInfo}</span>
				</td>
			</tr>
			<tr>
				<th>销售人员:</th>
				<td>
				<span>${c.salesMan}</span>
				</td>
			</tr>
			<tr>
				<th>公司网址:</th>
				<td>
				<span>${c.companyWebsite}</span>
				</td>
			</tr>
			<tr>
				<th>公司联系人:</th>
				<td>
				<span>${c.companyContact}</span>
				</td>
			</tr>
			<tr>
				<th>公司类别:</th>
				<td>
				<span>${c.companyTypeName}</span>
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>