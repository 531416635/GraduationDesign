<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
body {
	text-align: center;
}

h1 {
	margin-top: 15px;
	font-size: 200%;
}

#content {
	font-size: 150%;
}
</style>
</head>

<body>
	<h1>${news.title}</h1>
	<br />
	<div id="content">${news.content}</div>
</body>
</html>
