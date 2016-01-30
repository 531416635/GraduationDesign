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
<script type="text/javascript" src="../js/datePicker/WdatePicker.js">
	window.onload = function() {
		var options = document.getElementById("user_status");
		for ( var i = 0; i < options.length; i++) {
			if (options.options[0].value() == options.options[i + 1].value()) {
				options.options[i].remove();
			}
		}

	};
</script>
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
			<%-- <input type="hidden" name="regTime" value="${db.regTime}" /> --%>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>用户名:</th>
					<td><input type="text" name="userCode" value="${db.userCode}"
						style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>用户姓名:</th>
					<td><input type="text" name="userName" value="${db.userName}"
						style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>用户密码:</th>
					<td><input type="text" name="userPsw" value="${db.userPsw}" />
					</td>
				</tr>
				<tr class="info">
					<th>用户类型:</th>
					<td><select name="userType" style="width: 110px;">
							<option value="1"
								<c:if test="${db.userType==1}">
			 selected="selected"
			 </c:if>>管理用户</option>
							<option value="2"
								<c:if test="${db.userType==2}">
			 selected="selected"
			 </c:if>>商户用户</option>
					</select><a style="color: #FF0000">*</a></td>
				</tr>
				<tr class="info">
					<th>用户单位:</th>
					<td><select name='companyId' id="companyId"
						style="width: 180px;">
							<c:forEach items="${companys }" var="c">
								<option value="${c.id}"
									<c:if test="${c.id==db.companyId}"> selected="selected"</c:if>>
									${c.companyName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr class="info">
					<th>Email:</th>
					<td><input type="text" name="email" value="${db.email}"
						style="width: 180px;" /></td>
				</tr>
				<tr class="info">
					<th>电话:</th>
					<td><input type="text" name="tel" value="${db.tel}"
						style="width: 180px;" /></td>
				</tr>
				<tr class="info">
					<th>联系地址:</th>
					<td><input type="text" name="address"
						value="${db.addressName}" style="width: 180px;" size="200px" /></td>
				</tr>
				<tr class="info">
					<th>邮编:</th>
					<td><input type="text" name="zipCode" value="${db.zipCode}" />
					</td>
				</tr>
				<tr class="info">
					<th>固定电话:</th>
					<td><input type="text" name="fixedLineTel"
						value="${db.fixedLineTel}" style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>传真:</th>
					<td><input type="text" name="fax" value="${db.fax}"
						style="width: 70px;" /></td>
				</tr>

				<tr class="info">
					<th>状态:</th>
					<td><select name='status' id="user_status">
							<option value="0"
								<c:if test="${db.status==0}">
                        			selected="selected"
                        		</c:if>>初始</option>
							<option value="1"
								<c:if test="${db.status==1}">
                        			selected="selected"
                        		</c:if>>可用</option>
							<option value="2"
								<c:if test="${db.status==2}">
                        			selected="selected"
                        		</c:if>>冻结</option>
							<option value="3"
								<c:if test="${db.status==3}">
                        			selected="selected"
                        		</c:if>>删除</option>
					</select><a style="color: #FF0000">*</a></td>
				</tr>

				<tr class="info">
					<th>角色名称:</th>
					<td><select name="roleId">
							<option value="${db.roleId}">
								<c:if test="${db.roleId== roles.id}">${roles.roleName}</c:if>
							</option>
							<c:forEach items="${roleListss}" var="ro">
								<c:if test="${ro.id ne db.roleId}">
									<option value="${ro.id }">${ro.roleName}</option>
								</c:if>
							</c:forEach>
					</select><a style="color: #FF0000">*</a></td>
				</tr>
				<%-- <tr class="info">
					<th>公司ID:</th>
					<td><select name="companyId">
							<option value="${db.companyId}" selected>${db.companyId}</option>
							<c:forEach items="${companysU}" var="companyu">
								<option value="${companyu}">${companyu}</option>
							</c:forEach>
					</select><a style="color:#FF0000">*</a></td>
				</tr>
				<tr class="info">
					<th>部门ID:</th>
					<td><select name="departmentId">
							<option value="${db.departmentId}" selected>${db.departmentId}</option>
							<c:forEach items="${departmentsU}" var="departmentu">
								<option value="${departmentu}">${departmentu}</option>
							</c:forEach>
					</select><a style="color:#FF0000">*</a></td>
				</tr>
				<tr class="info">
					<th>岗位ID:</th>
					<td><select name="jobsId">
							<option value="${db.jobsId}" selected>${db.jobsId}</option>
							<c:forEach items="${jobsU}" var="jobu">
								<option value="${jobu}">${jobu}</option>
							</c:forEach>
					</select><a style="color:#FF0000">*</a></td>
				</tr> --%>
			</table>
			<input type="submit" value="提交" />&nbsp;<input type="button"
				value="取消" onclick="location='userManager.do'" />
		</form>
	</div>
</body>
</html>