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
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="#" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>供应商商品价格id:</th>
					<td><span>${companyProductPrice.id}</span></td>
				</tr>
				<tr>
					<th>供应商商品id:</th>
					<td><span>${companyProductPrice.companyProductId}</span></td>
				</tr>
				<tr>
					<th>最小数量:</th>
					<td><span>${companyProductPrice.minNum}</span></td>
				</tr>
				<tr>
					<th>最大数量:</th>
					<td><span>${companyProductPrice.maxNum}</span></td>

				</tr>
				<tr>
					<th>价格:</th>
					<td><span>${companyProductPrice.price}</span></td>
				</tr>
				<tr>
					<th>毛利价格:</th>
					<td><span>${companyProductPrice.grossmMarginPriceId}</span></td>
				</tr>
				<tr>
					<th>用户id:</th>
					<td><span>${companyProductPrice.userId}</span></td>

				</tr>
				<tr>
					<th>商品价格编码:</th>
					<td><span>${companyProductPrice.companyProductCode}</span></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>