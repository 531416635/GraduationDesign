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
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	function reloadcode() {
		var verify = document.getElementById('code');
		verify.setAttribute('src', '/ssm/pages/website/makeCertPic.jsp?it='
				+ Math.random());
	}
	$(document).keydown(function(event) {
		if (event.keyCode == 13) {
			document.getElementById("denglu").click();
			return false;
		}
	});

	function check_login() {
		/* $("#tb").css({"margin-top":"21px"}); */
		$.ajax({
			type : "POST",
			url : "login.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "nullError") {
					$("#msg").text("请输入用户名");
				} else if (data == "nameError") {
					$("#msg").text("用户名不存在");
				} else if (data == "null2Error") {
					$("#msg").text("请输入密码");
				} else if (data == "pwdError") {
					$("#msg").text("密码错误");
				} else if (data == "null3Error") {
					$("#msg").text("请输入验证码");
				} else if (data == "yzmError") {
					$("#msg").text("验证码错误");
				} else if (data == "typeError") {
					$("#msg").text("登录平台错误");
				} else if (data == "success") {
					location.href = "/ssm/web/toIndex.do";
				} else if (data == "companyError") {
					$("#msg").text("未找到公司信息");
				} else if (data == "authenticationError") {
					location.href = "/ssm/merchant/toCompanyAuthentication.do";
				} else if (data == "freeze") {
					$("#msg").text("账户已冻结");
				} else if (data == "delete") {
					$("#msg").text("账户已删除");
				} else if (data == "companyDelete") {
					$("#msg").text("公司信息已删除");
				}
			}
		});

	}
</script>
<style type="text/css">
#img1 {
	float: left;
	margin: 50px 20px;
	width: 40%;
}

#login {
	position: relative;
	float: right;
	z-index: 1;
	margin-top: 178px;
	margin-right: 73px;
	height: 400px;
	width: 350px;
	font-size: 16px;
	/* filter:alpha(opacity=80); -moz-opacity:0.8; -khtml-opacity: 0.8; opacity: 0.8; */
}

#tb {
	margin-top: 21px;
	margin-bottom: auto;
	margin-left: auto;
	margin-right: auto;
}

#img2 {
	margin-left: auto;
	margin-right: auto;
	width: 60%;
	height: 58px;
	border: 1px solid;
	color: #D0D0D0;
	font-size: 20px;
}

#xian {
	margin-top: 0;
	margin-left: auto;
	margin-right: auto;
	color: red;
	width: 80%;
	border: 2px solid;
}

#denglu {
	/* background: url(../images/frontimages/button-red.png) no-repeat; */
	background-color: #B00100;
	border-radius: 5px;
	border: none;
	width: 280px;
	height: 35px;
	margin-top: 10px;
	margin-bottom: 10px;
	font-size: 20px;
	color: white;
}

#name, #pwd {
	width: 290px;
	height: 35px;
	line-height: 35px;
	padding-left: 5px;
	font-size: 16px;
	color: #666;
}

#yzm {
	height: 35px;
	line-height: 35px;
	padding-left: 5px;
	width: 150px;
	font-size: 16px;
	color: #666;
	/* margin-top: 15px; */
}
</style>
</head>

<body>
	<div>
		<div class="warp">
			<div id="img1">
				<img src="../images/banner_login2.jpg" />
			</div>
			<div id="login">
				<form action="login.do" method="post" id="form">
					<table id="tb">
						<tr>
							<td>&nbsp;<span id="msg" style="color: red;"></span></td>
						</tr>
						<tr>
							<td colspan="2"><input id="name"
								style="margin-bottom: 16px;" type="text" name="userCode"
								placeholder="&nbsp;请输入用户名、邮箱或手机号" /></td>
						</tr>
						<tr>
							<td colspan="2"><input id="pwd" style="margin-bottom: 11px;"
								type="password" name="userPsw" placeholder="&nbsp;请输入密码" /></td>
						</tr>
						<tr>
							<td><input id="yzm" type="text" name="yzm"
								placeholder="&nbsp;请输入验证码" /></td>
							<td><img src="/ssm/pages/website/makeCertPic.jsp" id="code"
								onclick="reloadcode()" style="cursor: pointer;" alt="换一张"></td>
						</tr>
						<tr>
							<td colspan="2" style="font-size: 12px;"><input id="denglu"
								type="button" value="登   录" onclick="check_login();" /><br />
								还不是会员？<a href="/ssm/web/toReg.do" style="color: red;">立即注册</a>
								&nbsp;&nbsp;&nbsp;&nbsp;<a href="/ssm/web/toWjmm.do"
								style="color: #606060;">忘记密码</a></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<br />
</body>
</html>
