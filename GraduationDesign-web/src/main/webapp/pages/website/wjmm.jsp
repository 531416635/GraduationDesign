<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link rel="stylesheet" type="text/css" href="../css/frontcss/public.css" />
<link rel="stylesheet" type="text/css" href="../css/frontcss/wjmm.css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	function reloadcode() {
		var verify = document.getElementById('code');
		verify.setAttribute('src', '/GraduationDesign/pages/website/makeCertPic.jsp?it='
				+ Math.random());
	}
	function check() {
		$.ajax({
			type : "POST",
			url : "/GraduationDesign/web/wjmm.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "nullError") {
					$("#msg").text("请输入用户名");
				} else if (data == "nameError") {
					$("#msg").text("用户名不存在");
				} else if (data == "null2Error") {
					$("#msg").text("请输入验证码");
				} else if (data == "yzmError") {
					$("#msg").text("验证码错误");
				} else if (data == "success") {
					location.href = "toAqrz.do";
				}
			}
		});
	}
</script>
<style type="text/css">
input[type=text] {
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
				<form action="/GraduationDesign/web/wjmm.do" method="post" id="form">
					<p style="font-size: 16px;">
						用户名 : <input type="text" name=userCode " class="search-input" />
					</p>
					<br />
					<p style="font-size: 16px;">
						验证码 : <input type="text" name="yzm" class="search-input1" />&nbsp;&nbsp;
						<img src="/GraduationDesign/pages/website/makeCertPic.jsp" id="code"
							onclick="reloadcode()" style="cursor: pointer;" alt="换一张">
					</p>
					<span style="color: red;" id="msg"></span><br /> <input
						type="button" value="下一步" class="sub1" onclick="check();" />
				</form>

			</div>

		</div>
	</div>





</body>
</html>
