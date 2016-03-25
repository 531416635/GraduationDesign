<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
		 window.onload = function color(){//窗口加载时调用  
                var table = document.getElementById("person");//根据table的 id 属性值获得对象  
                var rows = table.getElementsByTagName("tr");//获取table类型的tr元素的列表  
                for(var i = 0; i < rows.length; i++){  
                    if(i % 2 == 0){  
                        rows[i].style.backgroundColor = "#E0E0E0";//偶数行时背景色为#EAF2D3  
                    }  
                    else{  
                        rows[i].style.backgroundColor = "#F0F0F0";//单数行时背景色为white  
                    }  
                }  
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
td {
	text-align: center;
}
</style>
</head>
<body>
	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">账户管理 ></span><span
				class="lo2"> 子账户密码初始化</span>
		</div>

		<div>
			<table width="100%" id="person" style="">
				<thead>
					<tr>
						<!-- <th><input name="ids" id="checkAll" type="checkbox"
						onclick="checkAll();" />全选</th> -->
						<th>子账户名</th>
						<th>部门</th>
						<th>岗位</th>
						<th>角色</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users}" var="s">

						<tr>
							<td style="display: none"><input name="userId"
								value="${s.ID}" /></td>
							<%-- <td><input type="checkbox" name="box" value="${c.id}" /></td> --%>
							<td>${s.UserCode}</td>
							<td>${s.DepartmentName}</td>
							<td>${s.JobName}</td>
							<td>${s.RoleName}</td>
							<td><input type="button" value="初始化密码"
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
								href="/GraduationDesign/merchant/initSonAccount.do?currentPage=${page.currentPage-1}"><span
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
									href="/GraduationDesign/merchant/initSonAccount.do?currentPage=${s3}">${s3}</a></li>
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
								href="/GraduationDesign/merchant/initSonAccount.do?currentPage=${page.currentPage+1}"><span
									class="pagenxt"></span> </a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>

</body>
</html>
