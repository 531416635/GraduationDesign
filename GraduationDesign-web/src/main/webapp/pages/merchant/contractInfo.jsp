<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
		new nicEditor({fullPanel : true}).panelInstance
		('content',{hasPanel : true}).removeInstance('content');
	});
</script>
<style type="text/css">
#yangshi{
	margin-top: 5px;
	width: 820px;
	height: 770px;
	overflow:scroll;
	border:1px solid;
}
td{
	font-size: 14px;
	line-height: 30px;
	padding-right: 10px;
}
tr{
	height: 30px;
}
table{
	margin: 10px 10px;
}
</style>
</head>

<body>
	<div class="inner_div">
	<table>
	   <tr>
	   		<td><b>合同时间：</b></td>
	   		<td>${companyContracts.contractTime}</td>
	   		<td><b>合同年限：</b></td>
	   		<td>${companyContracts.contractExpirationTime}</td>
	   		<td><b>合同账期：</b></td>
	   		<td>${companyContracts.contractTerms}</td>
	   </tr>
	   <tr>
	   		<td><b>合同类型：</b></td>
	   		<td>
	   			<c:choose>
				<c:when test="${companyContracts.contractType==0}">
				采购合同
				</c:when>
				<c:when test="${companyContracts.contractType==1}">
				供应合同
				</c:when>
				</c:choose>
	   		</td>
	   		<td><b>供应品类：</b></td>
	   		<td colspan="3">${companyContracts.supplyCategory}</td>
	   </tr>
	</table>
		<div id="yangshi">
		<div id="content" cols="100" style="font-size: 16px; line-height: 35px;" >${companyContracts.contractContent}</div>
		</div>
	</div>
</body>
</html>