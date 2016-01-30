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
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
bkLib.onDomLoaded(function() {
		new nicEditor({fullPanel : true}).panelInstance
		('content',{hasPanel : true}).removeInstance('content');
	});
</script>
<style type="text/css">
#yangs {
	position: absolute;
	top: 10%;
	margin-top: -50px;
	left: 20%;
	margin-left: -50px;
}
</style>
</head>

<body>
	<div id="yangs">
		<div id="content" cols="100">${companyContracts.contractContent}</div>
	</div>
</body>
</html>