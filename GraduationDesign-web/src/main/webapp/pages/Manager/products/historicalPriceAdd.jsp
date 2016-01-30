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

#div1 {
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div id="div1">
		<form action="addHistoricalPrice.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>商品名称:</th>
					<td><input type="text" name="productName" required="required" /></td>
				</tr>

				<tr>
					<th>商品品牌:</th>
					<td><input type="text" name="commodityBrand"
						required="required" /></td>
				</tr>
				<tr>
					<th>商品单价:</th>
					<td><input type="text" name="unitPrice" required="required" /></td>
				</tr>
				<tr>
					<th>商品简介:</th>
					<td><input type="text" name="productInfo" required="required" /></td>
				</tr>
				<tr>
					<th>商品产地:</th>
					<td><input type="text" name="producingArea"
						required="required" /></td>
				</tr>
				<tr>
					<th>商品品类:</th>
					<td><select name="productCategory">
							<c:forEach items="${productCategorys}" var="p">
								<option value="${p.id}">${p.cateGoryName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>商品类别:</th>
					<td></td>
				</tr>
			</table>
			<div class="">
				<ul>
					<c:forEach items="${productTypes}" var="m">
						<li style="display: inline"><input type="checkbox"
							name="productTypeIds" value="${m.id}" />${m.typeName}</li>
					</c:forEach>
				</ul>
			</div>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>
