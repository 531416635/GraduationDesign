<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:url var="base" value="/">
</c:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

.input_txt {
	width: 200px;
	height: 20px;
	line-height: 20px;
}

.info {
	height: 40px;
	line-height: 40px;
}

.info th {
	text-align: right;
	width: 65px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}

div {
	position: absolute;
	top: 10%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="userManagerUpdate.do" name="userForm" method="post">
			<input type="hidden" name="id" id="userId" value="${db.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>用户名:</th>
					<td><input type="text" name="userCode" value="${db.userCode}"
						style="width: 70px;" readonly /></td>
				</tr>
				<tr class="info">
					<th>用户姓名:</th>
					<td><input type="text" name="userName" value="${db.userName}"
						style="width: 70px;" readonly /></td>
				</tr>
				<tr class="info">
					<th>用户密码:</th>
					<td><input type="text" name="userPsw" value="${db.userPsw}"
						readonly /></td>
				</tr>
				<tr class="info">
					<th>用户单位:</th>
					<td><input type="text" name="userUnits"
						value="${db.userUnits}" readonly /></td>
				</tr>
				<tr class="info">
					<th>注册时间:</th>
					<td><input type="text" name="regTime" value="${db.regTime}"
						style="width: 70px;" readonly /></td>
				</tr>
				<tr class="info">
					<th>Email:</th>
					<td><input type="text" name="email" value="${db.email}"
						style="width: 70px;" readonly /></td>
				</tr>
				<tr class="info">
					<th>电话:</th>
					<td><input type="text" name="tel" value="${db.tel}"
						style="width: 70px;" readonly /></td>
				</tr>
				<tr class="info">
					<th>联系地址:</th>
					<td><input type="text" name="address" value="${db.address}"
						style="width: 70px;" readonly /></td>
				</tr>
				<tr class="info">
					<th>邮编:</th>
					<td><input type="text" name="zipCode" value="${db.zipCode}"
						readonly /></td>
				</tr>
				<tr class="info">
					<th>固定电话:</th>
					<td><input type="text" name="fixedLineTel"
						value="${db.fixedLineTel}" readonly /></td>
				</tr>
				<tr class="info">
					<th>传真:</th>
					<td><input type="text" name="fax" value="${db.fax}" readonly /></td>
				</tr>

				<tr class="info">
					<th>状态:</th>
					<td><a style="color: #FF0000">*</a> <c:choose>
							<c:when test="${db.status==0}">
                        			未认证
                        		</c:when>
							<c:when test="${db.status==1}">
                        			已认证
                        		</c:when>
							<c:when test="${db.status==2}">
                        			冻结
                        		</c:when>
							<c:otherwise>
                        			删除
                        		</c:otherwise>
						</c:choose></td>
				</tr>
				<tr class="info">
					<th>角色ID:</th>
					<td><input type="text" name="roleId" value="${db.roleId}"
						readonly /></td>
				</tr>
				<tr class="info">
					<th>邮箱验证:</th>
					<td><a style="color: #FF0000">*</a> <c:choose>
							<c:when test="${db.isEmailVerify==0}">
                        			否
                        		</c:when>
							<c:when test="${db.isEmailVerify==1}">
                        			是
                        		</c:when>
						</c:choose></td>
				</tr>

				<tr class="info">
					<th>电话验证:</th>

					<td><a style="color: #FF0000">*</a> <c:choose>
							<c:when test="${db.isTelVerify==0}">
                        			否
                        		</c:when>
							<c:when test="${db.isTelVerify==1}">
                        			是
                        		</c:when>
						</c:choose></td>
				</tr>
				<tr class="info">
					<th>公司ID:</th>
					<td><input type="text" name="companyId"
						value="${db.companyId}" readonly /></td>
				</tr>
				<tr class="info">
					<th>部门ID:</th>
					<td><input type="text" name="departmentId"
						value="${db.departmentId}" readonly /></td>
				</tr>
				<tr class="info">
					<th>岗位ID:</th>
					<td><input type="text" name="jobsId" value="${db.jobsId}"
						readonly /></td>
				</tr>

			</table>
			<input type="button" value="返回" onclick="history.back()" />
		</form>
	</div>
</body>
</html>