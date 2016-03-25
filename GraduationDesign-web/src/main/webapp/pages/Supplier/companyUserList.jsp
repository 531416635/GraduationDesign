<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>

<script type="text/javascript">
function click (it){
alert(it);
}
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
function getId() {
			var fileIds = "";
			$("input[name=box]").each(function() {
				 if ($(this).attr("checked") == true) {
             		 fileIds += $(this).val() + ",";
                  }     
			});
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
                    window.location.href="toCompanyUserLists.do";
                }
            };
           xhr.open("post","deleteCompanyUsers2.do",true);
           xhr.setRequestHeader('content-type',
                'application/x-www-form-urlencoded');
           var countId = getId();
           xhr.send("Uid="+countId);
  }
  
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

function checkBox(){
            			
            		var checkObjs1 = $(":checkbox[name='box']:checked");
            		var checkObjs2 = $(":checkbox[name='box']");
            		  	if(checkObjs1.length==checkObjs2.length) {
                			document.getElementById("checkAll").checked=true;
                }else{
                			document.getElementById("checkAll").checked=false;
    }
}
function checkDelete(id){
	 var r = window.confirm("确定删除此商品信息吗？");
	 if(r){
             location.href="/GraduationDesign/users/deleteCompanyUsers.do?id="+id;
          }
}
function checkDeletes(){
	var r = window.confirm("确定删除所选商品信息吗？");
	 if(r){
            getText();
          }

}
</script>


</head>


<body>

	<div class="rightinfo">

		<div class="tools">

			<ul class="toolbar">
				<li><a class="tablelink" href="/GraduationDesign/users/toCompanyAddUsers.do"><span><img
							src="../images/t01.png" /></span>添加</a></li>
				<li><a class="tablelink" href="#" onclick="checkDeletes();"><span><img
							src="../images/t03.png" /></span>删除</a></li>
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th width="60"><input name="" id="checkAll" type="checkbox"
						onclick="checkAll();" />全选</th>
					<th>ID</th>
					<th>用户名</th>
					<th>用户姓名</th>
					<th>注册时间</th>
					<th>Email</th>
					<th>电话</th>
					<th>联系地址</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${userManagers}" var="userManager">
					<c:if
						test="${userManager.status==0 or userManager.status==1 or userManager.status==2}">
						<tr>
							<td><input type="checkbox" name="box" onclick="checkBox();"
								value="${userManager.id}" /></td>
							<td>${userManager.id}</td>
							<td>${userManager.userCode}</td>
							<td>${userManager.userName}</td>
							<td>${userManager.regTime}</td>
							<td>${userManager.email}</td>
							<td>${userManager.tel}</td>
							<td>${userManager.address}</td>
							<td><c:choose>
									<c:when test="${userManager.status==0}">
                     			未认证
                     		</c:when>
									<c:when test="${userManager.status==1}">
                     			已认证
                     		</c:when>
									<c:when test="${userManager.status==2}">
                     			冻结
                     		</c:when>
									<c:otherwise>
                     			删除
                     		</c:otherwise>
								</c:choose></td>
							<td><a href="toUserManagerAll2.do?id=${userManager.id }"
								class="tablelink">详细信息</a> <a
								href="toUserManagerUpdate2.do?id=${userManager.id }"
								class="tablelink">修改</a> <a
								href="javascript:checkDelete(${userManager.id});"
								class="tablelink"> 删除 </a></td>
						</tr>
					</c:if>
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
								class="pagepre"></span></a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/GraduationDesign/products/productsList.do?currentPage=${page.currentPage-1}"><span
								class="pagepre"></span></a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a></li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/GraduationDesign/products/productsList.do?currentPage=${s3}">${s3}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span></a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/GraduationDesign/products/productsList.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span></a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>




	</div>

	<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
