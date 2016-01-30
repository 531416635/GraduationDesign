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
<script type="text/javascript">
function check_reset() {
		$.ajax({
			type : "POST",
			url : "reset.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "nullError") {
					$("#msg").text("请输入密码");
				} else if (data == "null2Error") {
					$("#msg").text("请确认密码");
				} else if (data == "pwdError") {
					$("#msg").text("两次输入的密码不一致");
				} else if (data == "success") {
					location.href = "xgcg.do";
				}
			}
		});
	}
</script>
<style type="text/css">
input[type=password] {
	font-size: 16px;
}
</style>
</head>

<body>

	<div class="warp">
		<div class="location">
			<span class="lo1">首页</span> > <span class="lo2">找回密码</span>
		</div>
		<div class="common-bag">
			<div class="common-tit">
				<h1>找回密码</h1>
			</div>

			<div class="formdiv">
				<form action="reset.do" method="post" id="form">
					<p>
						重置密码 : <input type="password" name="czmm" class="search-input" />
					</p>
					<br />
					<p>
						确认密码 : <input type="password" name="qrmm" class="search-input" />
					</p>
					<span style="color: red;" id="msg"></span><br /> <input
						type="button" value="下一步" class="sub2" onclick="check_reset();" />
				</form>

			</div>

		</div>
	</div>





</body>
</html>
