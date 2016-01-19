<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:url var="base" value="/"> </c:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css"/>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body{width:100%;height:100%;background-color: #FFFFFF;text-align: center;}
.input_txt{width:200px;height:20px;line-height:20px;}
.info{height:40px;line-height:40px;}
.info th{text-align: right;width:65px;color: #4f4f4f;padding-right:5px;font-size: 13px;}
.info td{text-align:left;}
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
	<form action="rightUpdate.do" name="userForm" method="post" >
		<input type="hidden" name="id" id="userId" value="${db.id}"/>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr class="info">
			<th>权限名称:</th>
			<td><input type="text" name="rightName" value="${db.rightName}"  style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>权限代码:</th>
			<td><input type="text" name="rightCode"  value="${db.rightCode}" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>菜单ID:</th>
			<td>
			   <select name="menuId" style="width:70px;">
			    <option value="${db.menuId}">${db.menuId}</option>
			    <c:forEach items="${menusIdsU}" var="menuIdu">
			       <option value="${menuIdu}" >${menuIdu}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
	</table>
	<input type="submit" value="提交" />&nbsp;<input type="button" value="取消"  onclick="location='rights.do'"/>
	</form>
	</div>
</body>
</html>