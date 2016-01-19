<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css"/>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	 function update() {
          $.ajax({
                	type: "POST",
             url: "userManagerUpdate1.do",
             dataType:"text", 
             data: $('#form').serialize(),
             success: function(data,textStatus){
             	//提示
                		if(data=="true") {
                			alert("更新成功！");
                		} else {
                			alert("更新失败！");
                		}
                		location.href="toCompanyUserList.do";
                      }
                });
	  }	
</script>
<style type="text/css">
body{width:100%;height:100%;background-color: #FFFFFF;text-align: center;}
.input_txt{width:200px;height:20px;line-height:20px;}
.info{height:40px;line-height:40px;}
.info th{text-align: right;width:65px;color: #4f4f4f;padding-right:5px;font-size: 13px;}
.info td{text-align:left;}
#div1 {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
<div id="div1">
<form id="form" action="userManagerUpdate1.do" name="userForm" method="post">
	<input type="hidden" name="id" id="id" value="${db.id}"/>
	<input type="hidden" name="roleId" id="roleId" value="${userInfo.roleId}"/>
	<input type="hidden" name="userType" id="userType" value="${userInfo.userType}"/>
	<input type="hidden" name="companyId" id="companyId" value="${userInfo.companyId}"/>
	<input type="hidden" name="regTime" id="regTime" value="${db.regTime}"/>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr class="info">
			<th>用户名:</th>
			<td><input type="text" name="userCode"  value="${db.userCode}" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>用户姓名:</th>
			<td><input type="text" name="userName"  value="${db.userName}" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>用户密码:</th>
			<td><input type="text" name="userPsw"  value="${db.userPsw}" /></td>
		</tr>
		<tr class="info">
			<th>用户单位:</th>
			<td><input type="text" name="userUnits" value="${db.userUnits}" style="width:180px;"/></td>
		</tr>
		<tr class="info">
			<th>Email:</th>
			<td><input type="text" name="email"  value="${db.email}" style="width:180px;" /></td>
		</tr>
		<tr class="info">
			<th>电话:</th>
			<td><input type="text" name="tel"  value="${db.tel}" style="width:180px;"/></td>
		</tr>
		<tr class="info">
			<th>联系地址:</th>
			<td><input type="text" name="address" value="${db.address}" style="width:180px;" size="200px"/></td>
		</tr>
		<tr class="info">
			<th>邮编:</th>
			<td><input type="text" name="zipCode" value="${db.zipCode}"/></td>
		</tr>
		<tr class="info">
			<th>固定电话:</th>
			<td><input type="text" name="fixedLineTel" value="${db.fixedLineTel}" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>传真:</th>
			<td><input type="text" name="fax" value="${db.fax}" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>状态:</th>
			<td>
				<select name='status' id="user_status">
				    <option value="${db.status}">
				      <c:choose>
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
                        	</c:choose>
				    </option>
					<option value="0">未认证</option>
					<option value="1">已认证</option>
					<option value="2">冻结</option>
					<option value="3">删除</option>
			    </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<%-- <tr class="info">
			<th>角色名称:</th>
			<td>
			  <select name="roleId" >
			  <option value="${db.roleId}">
			    <c:if test="${db.roleId== roles.id}">${roles.roleName}</c:if>
			  </option>
		       <c:forEach items="${roleListss}" var="ro">
			      <c:if test="${ro.id ne db.roleId}">
			         <option value="${ro.id }">${ro.roleName}</option>
			      </c:if>
			   </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<tr class="info">
			<th>部门ID:</th>
			<td>
			  <select name="departmentId" >
			  <option value="${db.departmentId}" selected>${db.departmentId}</option>
			    <c:forEach items="${departmentsU}" var="departmentu">
			       <option value="${departmentu}">${departmentu}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<tr class="info">
			<th>岗位ID:</th>
			<td>
			  <select name="jobsId" >
			   <option value="${db.jobsId}" selected>${db.jobsId}</option>
			    <c:forEach items="${jobsU}" var="jobu">
			       <option value="${jobu}">${jobu}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr> --%>
		
	</table>
               
	<input type="button" value="提交" onclick="update();"/>
	<input type="reset" value="取消" onclick="history.back()"/>
	</form>
	</div>
</body>
</html>