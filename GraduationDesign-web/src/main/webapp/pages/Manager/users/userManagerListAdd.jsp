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
<!DOCTYPE >
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

<script type="text/javascript">
    var a=/^1[3,5]{1}[0-9]{1}[0-9]{8}$ /;
    var t1=document.getElementById("mobilephone").value;
    if(!a.test(t1))
    {
        alert("请输入正确的手机号码");
        return false;
    }

</script>
</head>
<body>
	<div>
		<form action="userManagerAdd.do" name="userForm" method="post">
			<input type="hidden" name="userId" id="userId" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>用户名:</th>
					<td><input type="text" name="userCode" required="required"
						style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>用户姓名:</th>
					<td><input type="text" name="userName" required="required"
						style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>用户密码:</th>
					<td><input type="text" name="userPsw" required="required"
						style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>用户类型:</th>
					<td><select name="userType">
							<option value="1">管理后台用户</option>
							<option value="2">商户用户</option>
					</select><a style="color: #FF0000">*</a></td>
				</tr>
				<tr class="info">
					<th>用户单位:</th>
					<td><input type="text" required="required" name="userUnits" /></td>
				</tr>
				<tr class="info">
					<th>Email:</th>
					<td><input type="text" required="required" name="email"
						style="width: 100px;" /></td>
				</tr>
				<tr class="info">
					<th>手机号:</th>
					<td><input type="text" name="tel" required="required"
						id="mobilephone" style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>联系地址:</th>
					<td><input type="text" name="address" required="required"
						style="width: 180px;" size="200px" /></td>
				</tr>
				<tr class="info">
					<th>邮编:</th>
					<td><input type="text" required="required" name="zipCode" /></td>
				</tr>
				<tr class="info">
					<th>固定电话:</th>
					<td><input type="text" required="required" name="fixedLineTel" /></td>
				</tr>
				<tr class="info">
					<th>传真:</th>
					<td><input type="text" name="fax" required="required"
						style="width: 70px;" /></td>
				</tr>
				<!--  
		<tr class="info">
			<th>状态:</th>
			<td>
				<select name='status'>
					<option value="0">未认证</option>
					<option value="1">已认证</option>
					<option value="2">冻结</option>
					<option value="3">删除</option>
			    </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		-->
				<tr class="info">
					<th>角色名称:</th>
					<td><select name="roleId">
							<c:forEach items="${roles}" var="role">
								<option value="${role.id}">${role.roleName}
									<%-- <c:choose>
				      <c:when test="${role.id==1}">
				                      管理员
				      </c:when>
				      <c:when test="${role.id==2}">
				                      采购商
				      </c:when>
				      <c:when test="${role.id==3}">
				                      供应商
				      </c:when>
				      <c:when test="${role.id==4}">
				                      超级管理员
				      </c:when>
				    </c:choose> --%>
								</option>
							</c:forEach>
					</select><a style="color: #FF0000">*</a></td>
				</tr>

				<!--
		<tr class="info">
			<th>公司ID:</th>
			<td>
			   <select name="companyId" >
			    <c:forEach items="${companys}" var="company">
			       <option value="${company}">${company}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<tr class="info">
			<th>部门ID:</th>
			<td>
			  <select name="departmentId" >
			    <c:forEach items="${departments}" var="department">
			       <option value="${department}">${department}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<tr class="info">
			<th>岗位ID:</th>
			<td>
			  <select name="jobsId" >
			    <c:forEach items="${jobs}" var="job">
			       <option value="${job}">${job}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		-->
			</table>
			<input type="submit" value="提交" />&nbsp;<input type="button"
				value="取消" onclick="location='userManager.do'" />
		</form>
	</div>
</body>
</html>