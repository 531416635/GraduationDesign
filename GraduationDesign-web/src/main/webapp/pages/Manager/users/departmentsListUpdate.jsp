<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:url var="base" value="/">
</c:url>
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
		<form action="departmentUpdate.do" name="userForm" method="post">
			<input type="hidden" name="id" id="userId" value="${db.ID}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>公司名称:</th>
					<td>${db.CompanyName }</td>
				</tr>
				<tr class="info">
					<th>部门名称:</th>
					<td><select name="departmentName" id="departmentName">
							<c:forEach items="${departList }" var="p">
								<option value='${p.departmentName }'
									<c:if test="${p.departmentName==db.DepartmentName }"> selected="selected"</c:if>>
									${p.departmentName }</option>

							</c:forEach>
					</select></td>
				</tr>
				<!--  
		<tr class="info">
			<th>状态:</th>
			<td><input type="text" name="status" value="${db.status}"  style="width:70px;"/></td>
		</tr>
		-->
				<tr class="info">
					<th>创建人:</th>
					<td>${db.UserName }</td>
				</tr>
				<tr class="info">
					<th>状态:</th>
					<td><c:choose>
							<c:when test="${db.Status==0}">
								<input type="radio" name="status" value="0" checked="checked" />未启用
							</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="0" />未启用
							</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${db.Status==1}">
								<input type="radio" name="status" value="1" checked="checked" />已启用
							</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="1" />已启用
						</c:otherwise>
						</c:choose>
				</tr>
			</table>
			<input type="submit" value="提交" />&nbsp;<input type="button"
				value="取消" onclick="location='departments.do'" />
		</form>
	</div>
</body>
</html>