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
		<form action="" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>商品ID：</th>
					<td><input name="id" type="text" readonly="readonly"
						value="${product.id}" /></td>
				</tr>
				<tr>
					<th>商品名称：</th>
					<td><input name=productName type="text" readonly="readonly"
						value="${product. productName}" /></td>
				</tr>
				<tr>
					<th>商品类别：</th>
					<td>
						<%-- <input name="productType" readonly="readonly" value="${product.productTypee.typeName}" /> --%>
						<c:forEach items="${product.productTypes}" var="m" varStatus="s">
							<c:choose>
								<c:when test="${s.last}">
                            				${m.typeName}
                            			</c:when>
								<c:otherwise>
                            				${m.typeName}、
                            			</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>商品品牌：</th>
					<td><input name="commodityBrand" readonly="readonly"
						value="${product.commodityBrand}" /></td>
				</tr>
				<tr>
					<th>商品单价：</th>
					<td><input name="unitPrice" readonly="readonly"
						value="${product.unitPrice}" /></td>
				</tr>
				<tr>
					<th>商品简介：</th>
					<td><input name="productInfo" readonly="readonly"
						value="${product.productInfo}" /></td>
				</tr>
				<tr>
					<th>商品产地：</th>
					<td><input name="producingArea" readonly="readonly"
						value="${product.producingArea}" /></td>
				</tr>
				<tr>
					<th>商品品类：</th>
					<td><input name="productCategory" readonly="readonly"
						value="${product.productCategorys.cateGoryName}" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>