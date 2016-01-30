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
	left: 30%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>商品ID:</th>
					<td><span>${product.id}</span></td>

				</tr>
				<tr>
					<th>商品名称:</th>
					<td><span>${product.productName}</span></td>

				</tr>
				<tr>
					<th>商品类别:</th>
					<td>
						<%-- 	<span>${product.productTypee.typeName}</span> --%> <c:forEach
							items="${product.productTypes}" var="m" varStatus="s">
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
					<th>商品品牌:</th>
					<td><span>${product.commodityBrand}</span></td>

				</tr>
				<tr>
					<th>商品单价:</th>
					<td><span>${product.unitPrice}</span></td>

				</tr>
				<tr>
					<th>商品简介:</th>
					<td><span>${product.productInfo}</span></td>

				</tr>
				<tr>
					<th>商品产地:</th>
					<td><span>${product.producingArea}</span></td>

				</tr>
				<tr>
					<th>商品品类:</th>
					<td><span>${product.productCategorys.cateGoryName}</span></td>

				</tr>
				<tr>
					<th>商品名：</th>
					<td><span>${product.productName}</span></td>

				</tr>
				<tr>
					<th>供应商如下：</th>
				</tr>
				<tr>
					<th>供应商公司名：</th>
					<c:forEach items="${product.companys}" var="c">
						<td><span><a
								href="/ssm/grossMarginPrice/toCompanyProductPrice.do?productId=${product.id}&&companyId=${c.id}">${c.companyName}</a></span>
						</td>

					</c:forEach>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>