<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	top: 10%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="supplyUpdate.do" name="userForm" method="post">
			<input type="hidden" name="id" value="${db.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>发货单号:</th>
					<td><input type="text" name="dispatchBillId"
						value="${db.dispatchBillId}" style="width:70px;" />
					</td>
				</tr>
				<tr class="info">
					<th>订单ID:</th>
					<td><input type="text" name="orderId"
						value="${db.orderId}" style="width:70px;" /><a
						style="color:#FF0000">*</a></td>
				</tr>
				<tr class="info">
					<th>产品型号:</th>
					<td><input type="text" name="companyProductId"
						value="${db.companyProductId}" style="width:70px;" />
					</td>
				</tr>
				<tr class="info">
					<th>数量:</th>
					<td><input type="text" name="quantity"
						value="${db.purchaseQuantity}" />
					</td>
				</tr>
				<tr class="info">
					<th>数量单位:</th>
					<td><select name="productUnit">
							<option value="${db.productUnit}">${db.productUnit}</option>
							<option value="千克">千克</option>
							<option value="克">克</option>
							<option value="斤">斤</option>
							<option value="公斤">公斤</option>
							<option value="吨">吨</option>
					</select></td>
				</tr>
				<tr class="info">
					<th>单价:</th>
					<td><input type="text" name="unitPrice"
						value="${db.unitPrice}" />
					</td>
				</tr>
				<tr class="info">
					<th>金额小计:</th>
					<td><input type="text" name="amount" value="${db.amount}" />
					</td>
				</tr>
				<tr class="info">
					<th>仓储ID:</th>
					<td><select name="storageId">
							<option value="${db.storageId}">${db.storageId}</option>
							<c:forEach items="${storageIdsU}" var="sto">
								<option value="${sto}">${sto}</option>
							</c:forEach>
					</select><a style="color:#FF0000">*</a></td>
				</tr>

			</table>
			<input type="submit" value="提交" />&nbsp;<input type="button"
				value="取消" onclick="location='supply.do'" />
		</form>
	</div>
</body>
</html>