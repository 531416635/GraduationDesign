<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div
		style="width: 100%; float: left; margin-top: 5px; height: 800px; border-top: #d7d7d7 solid 2px; overflow: hidden;">
		<ul>
			<c:forEach items="${productsList}" var="pros2" varStatus="status2">
				<li style="float: left; padding-left: 2px;"><a href="#"><img
						src="${pros2.productPic.filePath}" /> </a></li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>