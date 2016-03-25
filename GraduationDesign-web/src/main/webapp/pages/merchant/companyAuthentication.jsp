<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/wjmm.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
	function check() {
		location.href = "/GraduationDesign/merchant/merchantAccountManager.do";
	}
</script>
</head>

<body>

	<div class="inner_div">
		<div
			style="width: 500px; height: 300px; margin: 50px auto; border: 2px solid #d6d6d6; border-radius: 5px; text-align: center; padding: 30px;">
			<p id="pp">
				<img width="80px" height="80px"
					src="<%=path%>/images/redimg/jinggao.png" />
			</p>
			<p>企业未进行认证</p>
			<p>请进入企业认证页面进行认证和相关资料填写</p>

			<div>
				<input type="button" class="orange" name="czmm" id="cg"
					value="进行企业认证" onclick="check();" /><br /> <br />
			</div>
		</div>

	</div>





</body>
</html>
