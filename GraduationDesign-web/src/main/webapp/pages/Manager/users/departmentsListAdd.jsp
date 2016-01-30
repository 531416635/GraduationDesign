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
		<form action="departmentAdd.do" name="userForm" method="post">
			<input type="hidden" name="userId" id="userId" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>公司名称:</th>
					<td><select name="companyId">
							<c:forEach items="${CompanyName}" var="C">
								<c:if test="${C.CompanyName!=null}">
									<option value="${C.CompanyID}">${C.CompanyName}</option>
								</c:if>
							</c:forEach>
					</select><a style="color: #FF0000">*</a></td>
				</tr>
				<tr class="info">
					<th>部门名称:</th>
					<td><input type="text" name="departmentName"
						style="width: 90px;" /></td>
				</tr>
				<!--  
		<tr class="info">
			<th>状态:</th>
			<td><input type="text" name="status"   style="width:70px;"/></td>
		</tr>
		-->
			</table>
			<input type="submit" value="提交" />&nbsp;<input type="button"
				value="取消" onclick="location='departments.do'" />
		</form>
	</div>
</body>
</html>