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
</style>
</head>
<body>

	<form action="/ssm/main/addMenusList.do" name="menuForm" method="post">
		<!--  <input  type="hidden"  name="id"  id="id"    />  -->
		<table border="0" cellpadding="0" cellspacing="0">

			<tr class="info">
				<th>菜单名称:</th>
				<td><input type="text"  name="menuName"  required="required"  />
				</td>
			</tr>

			<tr class="info">
				<th>菜单简码:</th>
				<td><input type="text"  name="menuCode"   required="required" />
				</td>
			</tr>
			<tr class="info">
				<th>菜单路径:</th>
				<td><input type="text" name="menuUrl"   required="required"   />
				</td>
			</tr>


			<tr class="info">
				<th>父菜单:</th>
				<td><select name="parentMenu"  >
						<option value=" ">&nbsp;</option>
						<c:forEach items="${menusLists}" var="menu">
							<option value="${menu.id}"> ${menu.patformName}： ${menu.menuName}</option>
						</c:forEach>
				</select>
				</td>
			</tr>

			<tr class="info" style="display: none">
				<th>状态:</th>
				<td><input type="text"  
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="status" />
				</td>
			</tr>
			
			<tr class="info">
				<th>菜单类别:</th>
				<td><input type="radio" name="menuType" value="1" /><span>菜单</span>
					<input type="radio" name="menuType" value="2" /><span>页面</span> <input
					type="radio" name="menuType" value="3" /><span>按钮</span>
				</td>
			</tr>

			<tr class="info">
				<th>所属平台:</th>
				<td><input type="radio" name="patform" value="1" /><span>系统管理</span>
				<input type="radio" name="patform" value="2"/><span>商户管理</span>
				<%--
					<input type="radio" name="patform" value="3" /><span>供应管理</span> 
					<input
					type="radio" name="patform" value="2" /><span>采购管理</span>
					 --%>
				</td>
			</tr>
			<tr>
				<td colspan="2">${msg}</td>
			</tr>
		</table>
		<input type="submit" value="提交" /><input type="reset" value="返回"
			onclick="history.back()" />
	</form>
</body>
</html>