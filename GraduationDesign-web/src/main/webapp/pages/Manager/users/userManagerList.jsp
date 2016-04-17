<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String json = (String) request.getAttribute("json");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />

<script type="text/javascript">
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});
function checkAll(){
  var ischecked=document.getElementById("checkAll").checked;
  if(ischecked){
    checkallbox();
  }else{
    discheckallbox();
  }
}
function checkallbox(){
   var boxarray = document.getElementsByName("box");
   for(var i = 0; i < boxarray.length; i++) { 
     boxarray[i].checked = true;
   }
}
function discheckallbox() { 
  var boxarray = document.getElementsByName("box"); 
  for(var i = 0; i < boxarray.length; i++) { 
    boxarray[i].checked = false;
  }
}

function getId() {
			var fileIds = "";
			$("input[name=box]").each(function() {
				 if ($(this).attr("checked") == true) {
             		 fileIds += $(this).val() + "@";
                  }     
			});
			if (fileIds == "") {
				alert("请选择需要删除的项!");
			} 
			fileIds = fileIds.substring(0, fileIds.length - 1);
			return fileIds;
		}
function  getXhr(){
        var xhr = null;
        if(window . XMLHttpRequest){
            xhr  = new XMLHttpRequest();
        }else{
            xhr = new ActiveXObject('Microsoft . XMLHTTP');
        }
        return xhr;
}
 function getText(){
            var xhr = getXhr();
            xhr.onreadystatechange=function(){
                if(xhr.readyState==4 && xhr.status==200){
                       if (window.confirm("确认吗?")) {
						window.location.href="userManager.do";
						} else {
						return;
						}
                    
                }
            };
           xhr.open("post","allDeleteUm.do",true);
           xhr.setRequestHeader('content-type',
                'application/x-www-form-urlencoded');
           var countId = getId();
            if(countId==""){
             return;
           }
           xhr.send("Uid="+countId);
  }
  
  
	window.onload = function() {
		var tab = document.getElementsByTagName('table')[0];

		var trs = tab.rows;
		for (var i = 0, len = trs.length; i < len; i++) {
			for (var j = 9; j <= 20; j++) {
				if (j != 14) {
					var cell = trs[i].cells[j];
					cell.style.display = 'none';
				}
			}
		}
	};

	function hid() {
		var tab = document.getElementsByTagName('table')[0];
		var trs = tab.rows;

	};
	$(function() {
		var flag = false; //标识生成分页时是否生成查询默认页商品
		var json = eval(
<%=json%>);
	  	$("#rows").html(json.rows);
	  	$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination").pagination(json.rows, { // 创建分页按钮
			current_page: json.currentPage-1,
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		location.href="userManager.do?currentPage="+(page_index+1);
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
</script>
<style type="text/css">
div.meneame span {
	display: inline;
}
</style>

</head>


<body>


	<div class="rightinfo">

		<div class="tools">
			<ul class="toolbar">
				<li class="click"><span><img
						src="<%=path%>/images/t01.png" /> </span>添加</li>
				<li class="click2"><span><img
						src="<%=path%>/images/t03.png" /> </span> <a href="javascript:;"
					onclick="getText();">删除</a></li>
			</ul>

		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th><input id="checkAll" type="checkbox" value=""
						onclick="checkAll();" /></th>
					<th>ID<i class="sort"><img src="<%=path%>/images/px.gif" />
					</i>
					</th>
					<th>角色名</th>
					<th>用户名</th>
					<th>用户姓名</th>
					<th>用户类型</th>
					<th>用户单位</th>
					<th>注册时间</th>
					<th>Email</th>
					<th>电话</th>
					<th>联系地址</th>
					<th>邮编</th>
					<th>固定电话</th>
					<th>传真</th>
					<th>状态</th>
					<th>角色ID22</th>
					<th>邮箱验证</th>
					<th>电话验证</th>
					<th>公司ID</th>
					<th>部门ID</th>
					<th>岗位ID</th>
					<th style="width: 15%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userManagers}" var="userManager">
					<tr>
						<td><input name="box" type="checkbox"
							value="${userManager.id}" /></td>
						<td>${userManager.id}</td>
						<td>${userManager.roleName}</td>
						<td>${userManager.userCode}</td>
						<td>${userManager.userName}</td>
						<td><c:choose>
								<c:when test="${userManager.userType==1}">
                     			管理用户
                     		</c:when>
								<c:when test="${userManager.userType==2}">
                     			商户用户
                     		</c:when>
							</c:choose></td>
						<td>${userManager.userUnits}</td>
						<td>${userManager.regTime}</td>
						<td>${userManager.email}</td>
						<td>${userManager.tel}</td>
						<td>${userManager.address}</td>
						<td>${userManager.zipCode}</td>
						<td>${userManager.fixedLineTel}</td>
						<td>${userManager.fax}</td>
						<td><c:choose>
								<c:when test="${userManager.status==0}">
                     			未认证
                     		</c:when>
								<c:when test="${userManager.status==1}">
                     			已认证
                     		</c:when>
								<c:when test="${userManager.status==2}">
                     			已冻结
                     		</c:when>
								<c:otherwise>
                     			已删除
                     		</c:otherwise>
							</c:choose></td>
						<td>${userManager.roleId}</td>
						<td>${userManager.isEmailVerify}</td>
						<td>${userManager.isTelVerify}</td>
						<td>${userManager.companyId}</td>
						<td>${userManager.departmentId}</td>
						<td>${userManager.jobsId}</td>
						<td><a href="toUserManagerAll.do?id=${userManager.id }"
							class="tablelink">详细信息</a> <a
							href="toUserManagerUpdate.do?id=${userManager.id }"
							class="tablelink">修改</a> <a
							href="userManagerDelete.do?id=${userManager.id }"
							class="tablelink"> 删除 </a> <a
							href="userManagerFreeze.do?id=${userManager.id }"
							class="tablelink">冻结</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 分页 -->
		<div class="message">
			共<i style="color: blue;">${page.rows}</i>条记录，当前显示第&nbsp;<i
				style="color: blue;">${page.currentPage}&nbsp;</i>页
		</div>
		<div class="pagin">
			<!-- 	<div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
			<div id="Pagination" class="meneame" style="clear: left"></div>
		</div>

		<%-- <div class="pagin">
			<div class="message">
				共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<c:choose>
					<c:when test="${page.currentPage==1}">
						<li class="paginItem current"><a href="#"><span
								class="pagepre"></span>
						</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/GraduationDesign/users/userManager.do?currentPage=${page.currentPage-1}"><span
								class="pagepre"></span>
						</a>
						</li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/GraduationDesign/users/userManager.do?currentPage=${s3}">${s3}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span>
						</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/GraduationDesign/users/userManagers.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span>
						</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div> --%>



		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="../images/ticon.png" /> </span>
				<div class="tipright">
					<p>是否确认添加用户？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>

			<div class="tipbtn">
				<input name="" type="button" class="sure" value="确定"
					onclick="location='toUserManagerAdd.do'" />&nbsp; <input name=""
					type="button" class="cancel" value="取消" />
			</div>

		</div>




	</div>

	<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
