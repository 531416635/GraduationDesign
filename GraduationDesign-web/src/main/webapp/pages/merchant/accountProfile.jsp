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
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
	function shanchu(userId){
	 var r = window.confirm("确定删除此信息吗？");
	 if(r){
             location.href="deleteSonAccount.do?userId="+userId;
          }
	}
	function xiugai(userId){
             location.href="toUpdateSonAccount.do?userId="+userId;
	}
	
	 window.onload = function color(){//窗口加载时调用  
                var table = document.getElementById("person");//根据table的 id 属性值获得对象  
                var rows = table.getElementsByTagName("tr");//获取table类型的tr元素的列表  
               /*  for(var i = 0; i < rows.length; i++){  
                    if(i % 2 == 0){  
                        rows[i].style.backgroundColor = "#E0E0E0";//偶数行时背景色为#EAF2D3  
                    }  
                    else{  
                        rows[i].style.backgroundColor = "#F0F0F0";//单数行时背景色为white  
                    }  
                }  */ 
            }  
             function chushi(id){
            	 var r = window.confirm("确定初始化该账号密码？");
	 		if(r){
	 			alert("初始密码成功，初始密码为123");
             	location.href="initSonAccount.do?id="+id;
         	 }
            }
</script>
<style type="text/css">
button {
	background-color: red;
}

thead {
	background-color: #e5e5e5;
}

td {
	text-align: center;
}

tr {
	height: 30px;
	border: 0.5px solid #999;
}

.but1 {
	width: 50px;
	height: 20px;
}

.but2 {
	width: 100px;
	height: 20px;
}
</style>

</head>

<body>
	<div class="inner_div" style="color: #999; line-height: 25px;">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">账户管理 ></span><span
				class="lo2"> 子账户管理</span>
		</div>
		<div>
			<h3>账号概况</h3>
			<b>总 数：</b>&nbsp;${maxAccount}<br /> <b>可使用：</b>&nbsp;${status0+status1}<br />
			<b>可创建：</b>&nbsp;${maxAccount-status0-status1}<br /> <b>冻结：</b>&nbsp;${status2}<br />
			<div id="d4" style="color: red;">子账户定义：每个采购人员可以最多创建50个子账户，并授予子账户对应权限，该子账户不等同于一般会员账号的定义</div>
		</div>
		<br /> <br />
		<h3>设置步骤</h3>

		1.添加员工信息 2.设置角色权限 3.所有员工权限管理 &nbsp;&nbsp;<a
			style="text-decoration: none;" href="buildSonAccount.do"> <input
			class="orange but2" type="button" value="新建员工" />
		</a> <br />
		<c:if test="${(maxAccount-userStatus0-userStatus1-userStatus2)>0 }"></c:if>
		<br />
		<hr style="color: red; border: 1px solid;" />
		<br />

		<div>


			<table width="100%" id="person">
				<thead>
					<tr>
						<th>子账户名</th>
						<th>部门</th>
						<th>岗位</th>
						<th>角色</th>
						<th style="width: 200px;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sonAccountInfo}" var="s">

						<tr>
							<td style="display: none"><input name="userId"
								value="${s.ID}" /></td>
							<td>${s.UserCode}</td>
							<td>${s.DepartmentName}</td>
							<td>${s.JobName}</td>
							<td>${s.RoleName}</td>
							<td><input class="orange but1" type="button" value="修改"
								onclick="xiugai(${s.ID})" /> <input class="orange but1"
								type="button" value="删除" onclick="shanchu(${s.ID});" /> <input
								class="orange but2" type="button" value="初始化密码"
								onclick="chushi(${s.ID})" /></td>
						</tr>
					</c:forEach>
				</tbody>
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
								href="/ssm/merchant/toSonAccountManagement.do?currentPage=${page.currentPage-1}"><span
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
									href="/ssm/merchant/toSonAccountManagement.do?currentPage=${s3}">${s3}</a></li>
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
								href="/ssm/merchant/toSonAccountManagement.do?currentPage=${page.currentPage+1}"><span
									class="pagenxt"></span> </a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
