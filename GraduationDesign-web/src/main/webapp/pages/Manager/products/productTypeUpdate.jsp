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
	top: 20%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="updateProductType.do" name="userForm" method="post">
			<input type="hidden" name="id" id="userId" value="${productType.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>类别名称:</th>
					<td><input type="text" name="typeName"
						value="${productType.typeName}" /></td>
				</tr>
				<tr class="info">
					<th>父类别:</th>
					<td><select name="parentType">
							<option value=""></option>
							<c:forEach items="${productTypes}" var="pr">
								<option value="${pr.id}"
									<c:if test="${productType.parentTypee.id==pr.id}"> selected</c:if>>${pr.typeName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr class="info">
					<th>类别简称:</th>
					<td><input type="text" name="typeCode"
						value="${productType.typeCode}" /></td>
				</tr>
			</table>
			<input type="submit" value="提交" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>