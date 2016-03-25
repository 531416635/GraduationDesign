
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />

<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
	
	function DepartmentUpdate(id) {
	
			var txt=$("#depart"+id).val();
			if(txt=null||txt==""){
			$("#TRdepart"+id).show();
				}else{
		$.ajax({
			type : "POST",
			url : "companyDepartmentUpdate.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
			departId:id,
			departName:$("#depart"+id).val()
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					window.location.href="buildSonAccount.do";
						//window.location.Reload();
				}
			}
		});}
	}
	function DepartmentDelete(id) {
		$.ajax({
			type : "POST",
			url : "companyDepartmentDelete.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {departId:id},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					window.location.href="buildSonAccount.do";
				}
			}
		});
	}
	//------------------------------------------------------------------------//
	function JobUpdate(id) {
		var departId=$("#hidDepartId").val();
		var txt=$("#txtJob"+id).val();
		if(txt=null||txt==""){
	$("#Jobdepart"+id).show();
	}else{
	
		$.ajax({
			type : "POST",
			url : "companyJobUpdate.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
			jobId:id,
			departId:departId,
			jobName:$("#txtJob"+id).val()
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
				getJobs(departId);
				}
			}
		});}
		
	}
		function JobAdd() {
		var departId=$("#hidDepartId").val();
		var txt=$("#txtJobName").val();
		if(txt=null||txt==""){
	$("#spanTxt1").show();
	}else{
		$.ajax({
			type : "POST",
			url : "companyJobAdd.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
			departId:departId,
			jobName:$("#txtJobName").val()
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
				getJobs(departId);
				}
			}
		});}
	}
	function JobDelete(id) {
		var departId=$("#hidDepartId").val();
		$.ajax({
			type : "POST",
			url : "companyJobDelete.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {	jobId:id},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					getJobs(departId);
				}
			}
		});
	}
	//----------------------------------------------------------------------------------------//
	var appendJobs= function(data)
	{
		$("#sJobs option").remove();
		$("#sJobs").append("<option value=''>请选择岗位</option>");
		$.each(data, function(i, item) {
			//alert(item.id);
			$("#sJobs").append("<option value='"+item.id+"'>"+item.jobName+"</option>");
		});		
	};
	var getJobs=function(id){
	
		$("#hidDepartId").val(id);
		var depart=$("#depart"+id).val()+"-->>";
		$("#tdDepart").html(depart);
		$.ajax({
			type : "POST",
			url : "selectJobs.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {departId:id},
			success : function(data) {
				$("#tdJobs").html("");
				var jobs='<table width="90%" border="0" cellspacing="0"><tbody>';
				$.each(data, function(i, item) {
						jobs+='<tr>';
						jobs+='<td><input type=\"text\" id=\"txtJob'+item.id+'\" value=\"'+item.jobName+'\"/>';
						jobs+='</td>';
						jobs+='<td><a href=\"#\" onclick=\"JobUpdate('+item.id+')\" class=\"tablelink\">修改</a>';
						jobs+=' <a href="#"	onclick="JobDelete('+item.id+')"	class="tablelink">删除</a>';
						jobs+=' </td>';
						jobs+=' </tr>';
						jobs+='<tr id=\"Jobdepart'+item.id+'\" style=\"display:none;color:red;\">';
						jobs+='<td colspan=\"2\">请输入岗位名称</td></tr>';			
				});	
					jobs+=' </table>';	
					//alert(jobs);			
					$("#tdJobs").html(jobs);	
					
					//alert($("#tdJobs").html());
			}	});
			
			
	};
	
	var selectJobs= function()
	{
			var id=$("#sDepart").val();
			//alert(id);
			$.ajax({
			type : "POST",
			url : "selectJobs.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {departId:id},
			success : function(data) {
			//alert(data);
				//提示
					appendJobs(data);
			}
		});
	};
	
	//-----------------------------------------------------------------------------------------//
	var AddAccount=function(){
		var userCode=$("#txtUserCode").val();
	
		var userName=$("#txtUserName").val();
			
		var userPsw=$("#txtUserPsw").val();
			
		var depart=$("#sDepart").val();
		
		var jobs=$("#sJobs").val();
		
		var roleId=null; 
		var obj=document.getElementsByName("chkRole");
		for (var i=0;i<obj.length;i++){ //遍历Radio
          if(obj[i].checked){
           roleId=obj[i].value;
         }
        } 
        	
        
        
        if(userCode==null||userCode==""){
        $("#userCodeSpan").show();
        }else{
       
         $("#userCodeSpan").hide();
        }
               if(userName==null||userName==""){
        $("#userNameSpan").show();
        }else{
         $("#userNameSpan").hide();
        }
       if(userPsw==null||userPsw==""){
        $("#userPswSpan").show();
        }else{
         $("#userPswSpan").hide();
        }
       if(depart==null||depart=="请选择部门"){
        $("#departSpan").show();
        }else{
         $("#departSpan").hide();
        }
     if(jobs==null||jobs=="请选择岗位"||jobs==""){
        $("#jobsSpan").show();
        }else{
         $("#jobsSpan").hide();
        }
         if(roleId==null||roleId==""){
        $("#chkRoleSpan").show();
        } else{
         $("#chkRoleSpan").hide();
        }
        
     
     $.ajax({
     type : "POST",
		url : "checkUser.do",
		dataType:"String",
		data : {
		userCode:userCode,
		},
		success : function(data) {
		var json = eval('(' + data + ')');
		
		if(json.result==null||json.result=="null")
		{		
		if(userCode!=""&&userName!=""&&userPsw!=""&&depart!="请选择部门"||jobs!="请选择岗位"||jobs!=""&&roleId!=null){
		
		$.ajax({
		type : "POST",
		url : "companyAddMerchantUser.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {
		userCode:userCode,
		userName:userName,
		userPsw:userPsw,
		depart:depart,
		jobs:jobs,
		roleId:roleId
		},
		success : function(data) {
				
				switch(data)
				{
					case 1:
						alert("添加成功");
						window.location.href="buildSonAccount.do";
					break;
					case 3:
						alert("您的登录信息已失效，请重新登录");
						window.location.href="toLogin.do";
					break;
				}
		}	
		});}
		}else{
		 $("#userCodeSpanCheck").show();
		
		}
		}
     
     })
       		
		
	};

	
	//------------------------------------------------------------------------------------------//
	var updateRoleStatus =function(id,status){
		$.ajax({
		type : "POST",
		url : "companyEditRole.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {
		roleid:id,
		roleStatus:status
		},
		success : function(data) {
				
				switch(data)
				{
					case 1:
						alert("修改成功");
						window.location.href="buildSonAccount.do";
					break;
					case 3:
						alert("您的登录信息已失效，请重新登录");
						window.location.href="toLogin.do";
					break;
				}
		}	
		});
	};
	
	var AddRole=function(){
	var roleName=$("#txtRoleName").val();
		if(roleName==null||roleName==""){
		$("#roleNameSpan").show();
		}else{
		
		$.ajax({
		type : "POST",
		url : "companyAddRole.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {roleName:roleName},
		success : function(data) {
				if(data==1)
				{
						alert("添加成功");
						window.location.href="buildSonAccount.do";
				}
		}	
		});
		}
		
	};
	
	var clickChkRight=function(parenttid,tid,chk){
		$("#t"+tid).find("input[type='checkbox']").each(function(){ 
		 	$(this).attr("checked",$(chk).attr("checked"));
		 });
		 var ischeck=$("#t"+parenttid).find("input[type='checkbox']:checked").length;
		 //alert(ischeck);
		 //alert($("#t"+parenttid).parent().parent().find("input[type='checkbox']").eq(0).attr("checked"));
		 if(ischeck==0)
		 {
		 	$("#t"+parenttid).parent().parent().find("input[type='checkbox']").eq(0).attr("checked",false);
		 }
		 if(ischeck>0)
		 {
		 	$("#t"+parenttid).parent().parent().find("input[type='checkbox']").eq(0).attr("checked",true);
		 }
	};
	
	var showMenu=function(data,parentMenu,rightId){
		var tmp='';
		var right=rightId.split(',');
		$.each(data, function(i, item) {
			if(item.parentMenu==parentMenu)
			{
				tmp+='<tr style="border:solid 1px #E0E0E0;">';
				tmp+='<td><input type="checkbox" name="chkMenuId" onclick="clickChkRight('+parentMenu+','+item.id+',this)"';
				if(rightId!=null&&rightId!='')
				{
					$.each(right, function(i, r) {
						if(item.id==r)
						{
							tmp+='checked="checked"';
						}
					});
				}
				tmp+='value=\"'+item.id+'\"/>'+item.menuName;
				tmp+='</td><td>';
				tmp+=showMenu(data,item.id,rightId);
				tmp+='</td></tr>';				
			}			
		});
		if(tmp!='')
		{
			return '<table style="width:100%;border:solid 1px #b7d5df;" cellspacing="0" id="t'+parentMenu+'">'+tmp+'</table>';
		}			
		return tmp;
	}; 
	
	var editRoleRight=function(){
		var roleId=$("#hidRoleId").val();
		//var rightId=$("#chkMenuId").val();
		 var rightId="";
		 $("#tdRoleRight input[name='chkMenuId']:checked").each(function(){ 
		 	rightId += $(this).val()+",";
		 });
		 //alert(rightId);
		rightId=rightId.substring(0,rightId.length-1);
		$.ajax({
		type : "POST",
		url : "companyEditRoleRight.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {
		roleId:roleId,
		rightId:rightId
		},
		success : function(data) {
				if(data==1)
				{
						alert("添加成功");
						//$("#tRoleRight").toggle();
						window.location.href="buildSonAccount.do"; 
				}
		}	
		});
	};
	var getRoleRight=function(id,rightId){
		//alert(rightId);
		$("#tRoleRight").toggle(); 
		$("#hidRoleId").val(id);
		$.ajax({
		type : "POST",
		url : "getRoleRight.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {
		roleId:id
		},
		success : function(data) {
			//alert(data);
			if(data==3)
			{
				alert("您的登录信息已失效，请重新登录");
				window.location.href="toLogin.do";
			}
			else
			{
				/* $("#tRoleRight").css('display','online'); 
				$("#tRoleRight").show(); */
				var td=showMenu(eval(data),0,rightId);
				//alert(td);
				$("#tdRoleRight").html(td);
			}				
		  }	
		});
	};
	$(function(){
	/* //部门名字输入校验
	$("input[name='departmentName']").blur(function(){
	
	var txt=$(this).val();
	if(txt=null||txt==""){
	$("#spanTxt").show();
	}
	
	}); */
	//部门名字新增校验
	$("#dNsubmit").click(function(){
	
	var txt=$("input[name='departmentName']").val();
	if(txt=null||txt==""){
	$("#spanTxt").show();
	}else{
	
	$("form[name='userForm']").submit();
	}
	});
	/* //新增岗位输入检验
	$("#txtJobName").blur(function(){
	
	var txt=$(this).val();
	if(txt=null||txt==""){
	$("#spanTxt1").show();
	}
	
	}); */
	
	
	});
	
	</script>
<style type="text/css">
select {
	width: 150px;
	height: 23px;
}

input[type=text] {
	width: 150px;
	height: 23px;
}

.input_but {
	width: 80px;
	height: 20px;
}

.input_rad {
	width: 13px;
	height: 13px;
	margin-left: 5px;
}

tr {
	height: 32px;
}
</style>

</head>

<body>

	<div class="inner_div">

		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab1">部门填写</a></li>
				<li><a href="#" title="tab2">角色权限</a></li>
				<li><a href="#" title="tab3">基本信息</a></li>
			</ul>
			<div id="content">
				<div id="tab1">

					<h3 style="background-color: #E0E0E0;">部门填写</h3>


					<table width="80%" border="0" cellspacing="0">
						<tr>


							<td width="40%"><form style="margin-left: 0;"
									action="companyDepartmentAdd.do" name="userForm" method="post">

									<input type="text" name="departmentName" />&nbsp;&nbsp; <input
										class="input_but orange" type="button" id="dNsubmit"
										value="增加部门" /> <span id="spanTxt"
										style="color: red; display: none;"><br />请输入正确的部门</span>
								</form></td>

							<td></td>
							<td><input type="hidden" id="hidDepartId" /> <input
								type="text" id="txtJobName" />&nbsp;&nbsp; <input type="button"
								class="input_but orange" value="增加岗位" onclick="JobAdd()" /><span
								id="spanTxt1" style="color: red; display: none;"><br />请输入正确的岗位</span>
							</td>
						</tr>
						<tr>
							<td><table width="90%" border="0" cellspacing="0">
									<tbody>
										<c:forEach items="${departments}" var="department">
											<tr>
												<td><input type="text" id="depart${department.id }"
													value="${department.departmentName}"
													onclick="getJobs(${department.id })" /></td>
												<td><a href="#"
													onclick="DepartmentUpdate(${department.id })"
													class="tablelink">修改</a>&nbsp;&nbsp; <a href="#"
													onclick="DepartmentDelete(${department.id })"
													class="tablelink">删除</a></td>
											</tr>
											<tr id="TRdepart${department.id }"
												style="display: none; color: red;">
												<td colspan="2">请输入部门名称</td>
											</tr>
										</c:forEach>
									</tbody>
								</table></td>
							<td id="tdDepart"></td>
							<td id="tdJobs"></td>
						</tr>
					</table>

					<div class="pagin">
						<div class="message">
							共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
						</div>
						<ul class="paginList">
							<c:choose>
								<c:when test="${page.currentPage==1}">
									<li class="paginItem current"><a href="#"><span
											class="pagepre"></span> </a></li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/GraduationDesign/users/departments.do?currentPage=${page.currentPage-1}"><span
											class="pagepre"></span> </a></li>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="1" end="${page.totalPage}" var="s3">
								<c:choose>
									<c:when test="${s3==page.currentPage}">
										<li class="paginItem current"><a href="#">${s3}</a></li>
									</c:when>
									<c:otherwise>
										<li class="paginItem"><a
											href="/GraduationDesign/users/departments.do?currentPage=${s3}">${s3}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${page.currentPage==page.totalPage or s3<=10}">
									<li class="paginItem current"><a href="#"><span
											class="pagenxt"></span> </a></li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/GraduationDesign/users/departments.do?currentPage=${page.currentPage+1}"><span
											class="pagenxt"></span> </a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>

				</div>

				<div id="tab3">
					<table>
						<tr>
							<td><span style="color: red;">*</span>表示必填项</td>

						</tr>
						<tr>
							<td><span style="color: red;">*</span>子账号名：</td>
							<td><input type="text" id="txtUserCode" /></td>
							<td><span id="userCodeSpan"
								style="display: none; color: red;">请输入子账号名</span> <span
								id="userCodeSpanCheck" style="display: none; color: red;">该子账户已被注册</span>
							</td>
						</tr>
						<tr>
							<td><span style="color: red;">*</span>子账号姓名:</td>
							<td><input type="text" id="txtUserName" /></td>
							<td id="userNameSpan" style="display: none; color: red;"><span>请输入子账号姓名</span>
							</td>
						</tr>
						<tr>
							<td><span style="color: red;">*</span>密码：</td>
							<td><input type="text" id="txtUserPsw" /></td>
							<td id="userPswSpan" style="display: none; color: red;"><span>请输入密码</span>
							</td>
						</tr>
						<tr>
							<td><span style="color: red;">*</span>部门：</td>
							<td><select id="sDepart" onchange="selectJobs()"><option>请选择部门</option>
									<c:forEach items="${departments}" var="depart">
										<option value="${depart.id }">${depart.departmentName
											}</option>
									</c:forEach>
							</select></td>
							<td id="departSpan" style="display: none; color: red;"><span>请输入部门</span>
							</td>
						</tr>
						<tr>
							<td><span style="color: red;">*</span>岗位：</td>
							<td><select id="sJobs">
									<option>请选择岗位</option>
							</select></td>
							<td id="jobsSpan" style="display: none; color: red;"><span>请输入岗位</span>
							</td>
						</tr>
						<tr>
							<td><span style="color: red;">*</span>角色：</td>
							<td><c:forEach items="${roles}" var="role">
									<c:if test="${role.status==1 }">

										<input class="input_rad" id="chkRole" name="chkRole"
											type="radio" value="${role.id}" />${role.roleName}

									</c:if>
								</c:forEach></td>
							<td id="chkRoleSpan" style="display: none; color: red;"><span>请输入角色</span>
							</td>
						</tr>
						<tr>
							<td colspan="2"><input class="input_but orange"
								type="button" id="btnAccount" value="提交" onclick="AddAccount()" />
							</td>
						</tr>
					</table>
				</div>

				<div id="tab2">
					<table style="width: 100%; border: solid 1px #b7d5df;"
						cellspacing="0">
						<tr>
							<td colspan="8" align="right"><span id="roleNameSpan"
								style="display: none; color: red;">请输入角色</span> 角色名称：<input
								type="text" id="txtRoleName" /> <input class="input_but orange"
								type="button" value="新增角色" onclick="AddRole()" /></td>
						</tr>

						<tr style="background-color: #e5e5e5;">
							<!-- <th><input id="checkAll" type="checkbox" value=""
								onclick="checkAll();" />
							</th> -->

							<th style="display: none">ID</th>
							<th>角色名称</th>
							<th>状态</th>
							<th style="width: 250px;">创建时间</th>
							<th>创建人</th>
							<th style="width: 250px;">操作</th>
						</tr>
						<tbody>
							<c:forEach items="${roles}" var="role">
								<tr>
									<%-- <td align="center"><input name="box" type="checkbox"
										value="${role.id}" />
									</td> --%>
									<td style="display: none">${role.id}</td>
									<td align="center">${role.roleName}</td>
									<td align="center"><c:choose>
											<c:when test="${role.status==0}">
                        			未启用
                        		</c:when>
											<c:when test="${role.status==1}">
                        			启用
                        		</c:when>
											<c:when test="${role.status==2}">
                        			删除
                        		</c:when>
										</c:choose></td>
									<td align="center"><fmt:formatDate
											value="${role.createTime}" pattern="yyyy-MM-dd" /></td>
									<td align="center">${role.createByName}</td>
									<td align="center"><c:choose>
											<c:when test="${role.status==0}">
												<a href="#" onclick="updateRoleStatus(${role.id },1)"
													class="tablelink">启用</a>
											</c:when>
											<c:when test="${role.status==1}">
												<a href="#" onclick="updateRoleStatus(${role.id },0)"
													class="tablelink">停用</a>
											</c:when>

										</c:choose>&nbsp;&nbsp; <a href="#"
										onclick="updateRoleStatus(${role.id },2)" class="tablelink">
											删除 </a> &nbsp;&nbsp;<a href="#"
										onclick="getRoleRight('${role.id }','${role.rightID }')"
										class="tablelink">分配权限</a></td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
					<br />
					<table
						style="width: 100%; border: solid 1px #b7d5df; display: none;"
						cellspacing="0" id="tRoleRight">
						<tr>
							<td>角色权限列表</td>
							<td align="right"><input type="hidden" id="hidRoleId" /> <input
								type="button" id="btnRoleRight" onclick="editRoleRight()"
								value="确认修改权限" /></td>
						</tr>
						<tr>
							<td id="tdRoleRight" colspan="2"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			$("#tabs li:first").attr("id", "current"); // Activate first tab
			$("#content div:first").fadeIn(); // Show first tab content

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide(); //Hide all content
				$("#tabs li").attr("id", ""); //Reset id's
				$(this).parent().attr("id", "current"); // Activate this
				$('#' + $(this).attr('title')).fadeIn(); // Show content for current tab
			});
		});
	</script>
</body>
</html>
