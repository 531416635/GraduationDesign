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
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
	function changeJob() {
		var id = $("select[name='departmentId']").val();
		$.ajax({
			dataType : "text",
			async : false,
			type : "POST",
			url : "toUpdateJobs.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				"departmentId" : id
			},
			success : function(data) {
				var divPic = "";
				var json = eval('(' + data + ')');
				if (data != "false") {
					for ( var i = 0; i < json.length; i++) {
						divPic += "<option value='"+json[i].id+"'>"
								+ json[i].jobName + "</option>";
					}
				} 
				$("select[name='jobsId']").html(divPic);
			},

		});

	}
</script>

<style type="text/css">
#tijiao {
	width: 80px;
	height: 23px;
	margin-left: 15%;
	font-size: 14px;
	color: white;
}

#quxiao {
	width: 80px;
	height: 23px;
	margin: auto;
	font-size: 14px;
	color: white;
}

.input_text {
	width: 140px;
	height: 23px;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab1">子账户修改</a></li>
			</ul>
			<div id="content">
				<form action="sonAccountUpdate.do" name="userForm" method="post">
					<div id="tab1">
						<input type="hidden" name="id" id="userId" value="${db.id}" /> <input
							type="hidden" name="regTime" value="${db.regTime}" />
						<table border="0" cellpadding="0" cellspacing="0">
							<tr class="info">
								<th>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</th>
								<td><input class="input_text" type="text" name="userCode"
									value="${db.userCode}" /></td>


								<th>用户姓名：</th>
								<td><input class="input_text" type="text" name="userName"
									value="${db.userName}" /></td>
							</tr>
							<tr class="info">
								<th>角色名称：</th>
								<td><select class="input_text" style="width: 80px;"
									name="roleId">
										<option value="${db.roleId}">
											<c:if test="${db.roleId== roles.id}">${roles.roleName}</c:if>
										</option>
										<c:forEach items="${roleListss}" var="ro">
											<c:if test="${ro.id ne db.roleId}">
												<option value="${ro.id }">${ro.roleName}</option>
											</c:if>
										</c:forEach>
								</select><a style="color: #FF0000">*</a></td>

								<th>状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</th>
								<td><select class="input_text" style="width: 80px;"
									name='status' id="user_status">
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
							<%-- <tr class="info">
					<th>用户密码:</th>
					<td><input type="text" name="userPsw" value="${db.userPsw}" />
					</td>
				</tr> --%>
							<tr class="info" style="display: none">
								<th>用户类型：</th>
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

								<th>电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</th>
								<td><input class="input_text" type="text" name="tel"
									value="${db.tel}" /></td>

								<th>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</th>
								<td><input class="input_text" type="text" name="email"
									value="${db.email}" style="width: 180px;" /></td>
							</tr>

							<tr class="info">

								<th>固定电话：</th>
								<td><input class="input_text" type="text"
									name="fixedLineTel" value="${db.fixedLineTel}" /></td>

								<%-- <th>联系地址:</th>
					<td><input type="text" name="address" value="${db.address}"
						style="width:180px;" size="200px" /></td> --%>
								<%-- <tr class="info">
					<th>邮编:</th>
					<td><input type="text" name="zipCode" value="${db.zipCode}" />
					</td>
				</tr> --%>

							</tr>
							<%-- <tr class="info">
					<th>传真:</th>
					<td><input type="text" name="fax" value="${db.fax}"
						style="width:70px;" /></td>
				</tr> --%>

							<tr class="info">

							</tr>

							<tr class="info">

							</tr>
							<tr class="info" style="display: none">
								<th>公司ID：${companysU}</th>
								<td><select class="input_text" style="width: 80px;"
									name="companyId">
										<option value="${db.companyId}" selected>${db.companyId}</option>
										<c:forEach items="${companysU}" var="companyu">
											<option value="${companyu}">${companyu}</option>
										</c:forEach>
								</select><a style="color: #FF0000">*</a></td>
							</tr>
							<tr class="info">
								<th>部门：</th>
								<td><select class="input_text" style="width: 80px;"
									name="departmentId" onchange="changeJob()">

										<c:forEach items="${departmentsU}" var="departmentu">
											<option value="${departmentu.id}"
												<c:if test="${departmentu.id==db.departmentId}">selected</c:if>>${departmentu.departmentName}</option>
										</c:forEach>
								</select><a style="color: #FF0000">*</a></td>
							</tr>
							<tr class="info">
								<th>岗位：</th>
								<td><select class="input_text" style="width: 80px;"
									name="jobsId">

										<c:forEach items="${jobsU}" var="jobu">
											<option value="${jobu.id}"
												<c:if test="${jobu.id==db.jobsId}">selected</c:if>>${jobu.jobName}</option>
										</c:forEach>
								</select><a style="color: #FF0000">*</a></td>
							</tr>
						</table>
						<input class="orange" type="submit" value="提交" id="tijiao" />&nbsp;
						<input class="orange" type="reset" value="取消"
							onclick="history.back()" id="quxiao" />
					</div>
				</form>
			</div>
		</div>

	</div>





</body>
</html>
