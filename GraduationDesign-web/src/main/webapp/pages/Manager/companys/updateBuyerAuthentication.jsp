<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

div {
	position: absolute;
	top: 40%;
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
		<form action="updateBuyerAuthentication.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr style="display: none">
					<th>ID</th>
					<td><input name="id" value="${buyer.id}" /></td>
				</tr>
				<tr>
					<th>认证名称:</th>
					<td><input name="authenticationName"
						value="${buyer.authenticationName}" /></td>
				</tr>
				<tr>
					<th>认证文件:</th>
					<td><input type="text" name="filePath"
						value="${buyer.filePath}" /></td>
				</tr>
				<tr style="display: none">
					<th>企业名称ID</th>
					<td><input type="text" readonly="readonly" name="companyId"
						value="${buyer.companyId}" /></td>
				</tr>
				<%-- <tr>
					<th>状态:</th>
					<td><c:choose>
							<c:when test="${buyer.status==0}">
								<input type="radio" name="status" value="0" checked="checked">
								<span>未认证</span>
							</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="0">
								<span>未认证</span>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${buyer.status==1}">
								<input type="radio" name="status" value="1" checked="checked">
								<span>已认证</span>
							</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="1">
								<span>已认证</span>
							</c:otherwise>
						</c:choose></td>
				</tr> --%>
				<tr>
					<th>上传时间:</th>
					<td><input type="text" name="uploadTime"
						onclick="WdatePicker()" readonly="readonly"
						value="${buyer.uploadTime}" /></td>
				</tr>
				<tr style="display: none">
					<th>上传人:</th>
					<td><input type="text" name="uploadBy"
						value="${buyer.uploadBy}" /></td>
				</tr>
				<tr>
					<th>文件类别:</th>
					<td><input name="fileClass" value="${buyer.fileClass}" /></td>
				</tr>
			</table>
			<input type="submit" value="修改" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>