<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
</style>
</head>
<body>
	<form action="addNew.do" name="userForm" method="post">
		<input type="hidden" name="userId" id="userId" value=""/>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr class="info">
			<th>标题:</th>
			<td><input type="text" name="title"/></td>
		</tr>
		<tr class="info">
			<th>内容:</th>
			<td><textarea  class="width300 height70" name="Content"></textarea></td>
		</tr>
		<tr class="info">
			<th>发布时间:</th>
			<td><input type="text" name="releaseTime" onclick="WdatePicker()" readonly="readonly" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>发布时效:</th>
			<td><input type="text" name="releaseAging" onclick="WdatePicker()" readonly="readonly" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>发布人:</th>
			<td><input type="text" name="publishers" /></td>
		</tr>
		<tr class="info">
			<th>状态:</th>
			<td><input type="text" name="status"/></td>
		</tr>
		<tr class="info">
			<th>新闻类别:</th>
			<td><input type="text" name="newType" value="${newType}"/></td>
		</tr>
	</table>
	<input type="submit" value="提交" />
	</form>
</body>
</html>