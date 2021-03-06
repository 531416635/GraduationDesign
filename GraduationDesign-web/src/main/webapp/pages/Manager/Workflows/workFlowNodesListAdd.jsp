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
<!DOCTYPE >
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
	<form action="addWorkFlowNodesList.do" name="userForm" method="post">
		<input type="hidden" name="id" id="id" value="" />
		<table border="0" cellpadding="0" cellspacing="0">
			<tr class="info">
				<th>节点名称:</th>
				<td><input required="required" type="text" name="nodeName" />
				</td>
			</tr>
			<tr class="info">
				<th>节点简称:</th>
				<td><input required="required" type="text" name="nodeCode" />
				</td>
			</tr>
			<tr class="info">
				<th>节点角色:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="nodeRole" /></td>
			</tr>

			<tr class="info">
				<th>节点类型:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="nodeType" /></td>
			</tr>
			<tr class="info">
				<th>批复:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="processResult" /></td>
			</tr>
			<tr class="info">
				<th>批复内容:</th>
				<td><input type="text" required="required"
					name="processContent" /></td>
			</tr>

			<tr class="info">
				<th>上一个节点:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="prevNode" /></td>
			</tr>
			<tr class="info">
				<th>下一个节点:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="nextNode" /></td>
			</tr>
			<tr class="info">
				<th>流程类型ID:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="workflowTypeId" /></td>
			</tr>

		</table>
		<input type="submit" value="提交" />
	</form>
</body>
</html>