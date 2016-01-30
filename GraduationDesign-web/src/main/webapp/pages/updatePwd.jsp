<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.wit.comm.Common"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<link href="CSS/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function checkLogin(){
		$.ajax({
             type: "POST",
             url: "updatePwd.do",
             dataType:"text",
             data: $("#pwd_change").serialize(),
             success: function(data){
                		if(data=="nullError") {
                			alert("请输入原始密码！");
                		}else if(data=="pwdError") {
                			alert("原始密码不正确！");
                		}else if(data=="null2Error") {
                			alert("请输入新密码！");
                		}else if(data=="null3Error") {
                			alert("请确认密码！");
                		}else if(data=="confirmError") {
                			alert("两次输入的密码不一致！");
                		}else if(data=="success"){
                			alert("恭喜您修改密码成功！");
                		}
                      }
                });
	}
</script>
<style type="text/css">
div {
	position: absolute;
	top: 30%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<table border="1" align="center">
			<tr>
				<td><h1 align="center">修改密码</h1></td>
			</tr>
			<tr>
				<td><form action="updatePwd.do" method="post" id="pwd_change">
						<table border="0" align="center">
							<tr>
								<td><input type="hidden" name="id" value="${userInfo.id}" />
								</td>
							</tr>
							<tr>
								<td><input type="hidden" name="userPwd"
									value="${userInfo.userPsw}" /></td>
							</tr>
							<tr>
								<td>请输入原密码：<input type="password" id="opwd" name="oldPwd" />
								</td>

							</tr>
							<tr>
								<td>请输入新密码：<input type="password" name="newPwd" />
								</td>
							</tr>
							<tr>
								<td>请确认新密码：<input type="password" name="newPwdConfirm" />
								</td>
							</tr>
							<tr>
								<td align="center"><input type="button" value="确认修改"
									onclick="checkLogin()" /> <input type="reset" value="重置"
									name="reset" /></td>
							</tr>
						</table>
					</form></td>
			</tr>
		</table>
	</div>
</body>
</html>