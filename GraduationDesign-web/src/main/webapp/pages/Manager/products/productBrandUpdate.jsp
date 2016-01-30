<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "";	
%>
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
		<form action="updateProductBrand.do" enctype="multipart/form-data"
			method="post">
			<input type="hidden" name="id" id="userId" value="${productBrand.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>品牌名称:</th>
					<td><input type="text" name="brandName"
						value="${productBrand.brandName}" /></td>
				</tr>
				<tr class="info">
					<th>首页显示:</th>
					<td>是：<input type="radio"
						<c:if test="${productBrand.isHomeShow==1}">checked="checked"</c:if>
						name="isHomeShow" value="1" /> 否：<input type="radio"
						<c:if test="${productBrand.isHomeShow!=1}">checked="checked"</c:if>
						name="isHomeShow" value="0" /></td>
				</tr>
				<tr class="info">
					<th>品牌图片:</th>
					<td id="upload" colspan="3"><img
						src="<%=path%>${productBrand.logoPath}" alt="品牌图片" /> <br>更新品牌图片：<input
						type="file" id="file" name="file"></td>
				</tr>
			</table>
			<input type="submit" value="提交" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>