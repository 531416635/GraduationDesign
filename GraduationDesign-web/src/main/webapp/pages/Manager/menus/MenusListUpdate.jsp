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
	<form action="updateMenusList.do" name="userForm" method="post">
		<input type="hidden" name="id" id="id" value="${menus.id}" />
		<table border="0" cellpadding="0" cellspacing="0">


			<tr class="info">
				<th>菜单名称:</th>
				<td><input type="text" name="menuName"
					value="${menus.menuName}" /></td>
			</tr>

			<tr class="info">
				<th>菜单简码:</th>
				<td><input type="text" name="menuCode"
					value="${menus.menuCode}" /></td>
			</tr>
			<tr class="info">
				<th>菜单路径:</th>
				<td><input type="text" name="menuUrl" value="${menus.menuUrl}" />
				</td>
			</tr>

			<tr class="info">
				<th>父菜单:</th>
				<td><select name="parentMenu">
						<option value=" ">&nbsp;</option>
						<c:forEach items="${menusLists}" var="menu">
							<c:choose>
								<c:when test="${menu.id==menus.parentMenu}">
									<option value="${menu.id}" selected="selected"> ${menu.patformName}：${menu.menuName}</option>
								</c:when>
								<c:otherwise>
									<option value="${menu.id}"> ${menu.patformName}：${menu.menuName}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
				</select><a style="color:#FF0000">*</a></td>
			</tr>
			<tr class="info">
				<th>状态:</th>
				<td><c:choose>
						<c:when test="${menus.status==0}">
							<input type="radio" name="status" value="0" checked="checked" />
							<span>不启用</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="status" value="0" />
							<span>不启用</span>
						</c:otherwise>
					</c:choose> <c:choose>
						<c:when test="${menus.status==1}">
							<input type="radio" name="status" value="1" checked="checked" />
							<span>启用</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="status" value="1" />
							<span>启用</span>
						</c:otherwise>
					</c:choose></td>
			</tr>

			<%-- 	<tr class="info" style="display: none">
				<th>创建时间:</th>
				<td><input type="text" name="createTime"
					value="${menus.createTime}" onclick="WdatePicker()"
					readonly="readonly" style="width:70px;" />
				</td>
			</tr>

			<tr class="info">
				<th>创建人:</th>
				<td><input type="text" value="${menus.createBy}"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="createBy" />
				</td>
			</tr> --%>

			<tr class="info">
				<th>菜单类别:</th>
				<td><c:choose>
						<c:when test="${menus.menuType==1}">
							<input type="radio" name="menuType" value="1" checked="checked" />
							<span>菜单</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="menuType" value="1" />
							<span>菜单</span>
						</c:otherwise>
					</c:choose> <c:choose>
						<c:when test="${menus.menuType==2}">
							<input type="radio" name="menuType" value="2" checked="checked" />
							<span>页面</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="menuType" value="2" />
							<span>页面</span>
						</c:otherwise>
					</c:choose> <c:choose>
						<c:when test="${menus.menuType==3}">
							<input type="radio" name="menuType" value="3" checked="checked" />
							<span>按钮</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="menuType" value="3" />
							<span>按钮</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>

			<tr class="info">
				<th>所属平台:</th>
				<td><c:choose>
						<c:when test="${menus.patform==1}">
							<input type="radio" name="patform" value="1"  checked="checked" />
							<span>管理平台</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="patform" value="1" />
							<span>管理平台</span>
						</c:otherwise>
					</c:choose>
					 <c:choose>
						<c:when test="${menus.patform==2}">
							<input type="radio" name="patform" value="2"  checked="checked" />
							<span>商户管理平台</span>
						</c:when>
						<c:otherwise>
							<input type="radio" name="patform" value="2" />
							<span>商户管理平台</span>
						</c:otherwise>
					</c:choose> 
					<%-- 
					<c:choose>
						<c:when test="${menus.patform==3}">
							<input type="radio" name="patform" value="3"  checked="checked" />
							<span>采购商平台</span>
						</c:when>
						<c:otherwise>
								<input type="radio" name="patform" value="3" />
							<span>采购商平台</span>
						</c:otherwise>
					</c:choose>
					--%>
					
					</td>
			</tr>

		</table>
		<input type="submit" value="提交" /><input type="reset" value="返回"
			onclick="history.back()" />
	</form>
</body>
</html>