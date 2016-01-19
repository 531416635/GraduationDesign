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
	<form action="findSupplier.do" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>商品追溯id</th>
				<td>
				<span>${productTransfer.id}</span>
				</td>
			</tr>
			<tr>
				<th>供应商商品id</th>
				<td>
				<span>${productTransfer.companyProductId}</span>
				</td>

			</tr>
			<tr>
				<th>中转地</th>
				<td>
				<span>${productTransfer.transitShipment}</span>
				</td>
			</tr>
			<tr>
				<th>联系人</th>
				<td>
				<span>${productTransfer.linkMan}</span>
				</td>

			</tr>
			<tr>
				<th>联系电话</th>
				<td>
				<span>${productTransfer.linkTel}</span>
				</td>
			</tr>
			<tr>
				<th>到达时间</th>
				<td>
				<span>${productTransfer.arrivalTime}</span>
				</td>
			</tr>
			<tr>
				<th>批次</th>
				<td>
				<span>${productTransfer.batch}</span>
				</td>
				
			</tr>
		</table>
	</form>
	</div>
</body>
</html>