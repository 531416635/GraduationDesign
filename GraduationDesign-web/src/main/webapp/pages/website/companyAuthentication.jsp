<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link rel="stylesheet" type="text/css" href="../css/frontcss/public.css" />
<link rel="stylesheet" type="text/css" href="../css/frontcss/wjmm.css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<style type="text/css">
#cg {
	background: url(../images/frontimages/button-red.png) no-repeat;
	border: none;
	width: 300px;
	height: 40px;
	margin-top: 20px;
	margin-bottom: 15px;
	font-size: 20px;
	color: white;
	margin-top: 3%;
	margin-left: 20%;
	margin-right: auto;
	margin-bottom: auto;
}

#pp {
	margin-top: 10%;
	margin-left: 33%;
	margin-right: auto;
	margin-bottom: 3%;
}
</style>
<script type="text/javascript">
	function check() {
		location.href = "/ssm/merchant/merchantAccountManager.do";
	}
</script>
</head>

<body>

	<div class="warp">
		<p id="pp">企业未进行认证请进入企业认证页面进行认证和相关资料填写</p>

		<div class="formdiv">
				<input type="button" name="czmm" id="cg" value="进行企业认证"
					onclick="check();" /><br />
				<br />
		</div>

	</div>





</body>
</html>
