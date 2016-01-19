<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css"/>
<script type="text/javascript" src="js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

#div1 {
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div id = div1>
		<form action="dictionaryAdd.do" method="post">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr >
			<th>名称:</th>
			<td><input type="text" name="dicName"  required="required"   /></td>
		</tr>
		<tr >
			<th>编号:</th>
			<td><input type="text" name="dicCode"   required="required" /></td> 
		</tr>
		<tr>
			<th>别名:</th>
			<td><input type="text" name="dicValue"   required="required" /></td>
		</tr>
		<tr>
			<th>父名:</th>
			<td>
			<select name="dicParent" required="required">
			<c:forEach items="${dictionarys}" var ="dic" >
				<option value="${dic.id}">${dic.dicName}</option>
			</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<th>字典类别:</th>
			<td>
			<select name="dicType" required="required">
			<c:forEach items="${dictionaryTypes}" var ="dic2">
			<option value="${dic2.id}">${dic2.typeName}</option>
			</c:forEach>
			</select>
			</td>
		</tr>
			</table>
			<input type="submit" value="增加" />
			<input type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>
