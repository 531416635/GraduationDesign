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
	<div id=div1>
		<form action="dictionaryUpdate.do" method="post">
			<input type="hidden" name="id" value="${dictionary.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>名称:</th>
					<td align="left"><input type="text" name="dicName"
						value="${dictionary.dicName}" /></td>
				</tr>
				<tr>
					<th>编号:</th>
					<td align="left"><input type="text" name="dicCode"
						value="${dictionary.dicCode}" /></td>
				</tr>
				<tr>
					<th>别名:</th>
					<td align="left"><input type="text" name="dicValue"
						value="${dictionary.dicValue}" /></td>
				</tr>
				<tr>
					<th>父名:</th>
					<td align="left"><c:if test="${dictionary.dicParent!=null }">
							<select name="dicParent" required="required">
								<c:forEach items="${dictionarys}" var="dic">

									<option value="${dic.id}"
										<c:if test='${dic.id==dictionary.dicParent}'>selected = "selected"</c:if>>${dic.dicName}</option>

								</c:forEach>

							</select>
						</c:if> <c:if test="${dictionary.dicParent==null }">顶级地域无父名</c:if> <%-- <input type="text" name="dicParent" value="${dictionary.dicParent}"/></td> --%>
				</tr>
				<tr>
					<th>字典类别:</th>
					<td align="left"><select name="dicType" required="required">
							<c:forEach items="${dictionaryTypes}" var="dic2">
								<option value="${dic2.id}"
									<c:if test='${dic2.id==dictionary.dicType}'>selected = 'selected'</c:if>>${dic2.typeName}</option>
							</c:forEach>
					</select> <%-- <input type="text" name="dicType"
						value="${dictionary.dicType}" /> --%></td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>
