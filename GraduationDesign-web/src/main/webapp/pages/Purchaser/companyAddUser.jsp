<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	 function save() {
          $.ajax({
                	type: "POST",
             url: "companyAddUser.do",
             dataType:"text", 
             data: $('#form').serialize(),
             success: function(data,textStatus){
             	//提示
                		if(data=="true") {
                			alert("添加成功！");
                		} else {
                			alert("添加失败！");
                		}
                		location.href="toCompanyUserList.do";
                      }
                });
	  }	
</script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

#div1 {
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div id=div1>
		<form id="form" action="companyAddUser.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>用户姓名:</th>
					<td><input type="text" name="userName" /></td>
				</tr>
				<tr>
					<th>用户名:</th>
					<td><input required="required" type="text" name="userCode" /></td>
				</tr>
				<tr>
					<th>用户密码:</th>
					<td><input required="required" type="text" name="userPsw" /></td>
				</tr>
				<tr>
					<th>Email:</th>
					<td><input required="required" type="text" name="email" /></td>
				</tr>
				<tr>
					<th>电话:</th>
					<td><input required="required" type="text" name="tel" /></td>
				</tr>
				<tr>
					<th>联系地址:</th>
					<td><input required="required" type="text" name="address" /></td>
				</tr>
			</table>
			<input type="button" value="提交" onclick="save();" /> <input
				type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>
