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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/wjmm.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
#chakan {
	margin-left: 10%;
	margin-top: 5%;
	font-size: 18px;
	line-height: 25px;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div id="chakan">
			发票编号：${ic.invoiceId}<br /> 发票抬头：${ic.invoiceTitle}<br /> 发票类型：
			<c:choose>
				<c:when test="${ic.invoiceType == 1}">增值税发票</c:when>
				<c:when test="${ic.invoiceType == 2}">普通发票</c:when>
				<c:when test="${ic.invoiceType == 3}">专业发票</c:when>
			</c:choose>
			<br /> 发票状态：
			<c:choose>
				<c:when test="${ic.status==0}">发票已申请</c:when>
				<c:when test="${ic.status==1}">发票已寄出</c:when>
				<c:when test="${ic.status==2}">发票已签收</c:when>
			</c:choose>
			<br /> 发票金额：${ic.amount}<br /> 创建时间：${ic.createTime}<br />
		</div>
	</div>

</body>
</html>
