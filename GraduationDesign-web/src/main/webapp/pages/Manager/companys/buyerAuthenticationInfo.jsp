<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">
$(".tablelist tbody tr:odd").addClass("odd");
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
                    window.location.href="buyerAuthenticationInfo.do?companyId="+${companyId};
                }
            };
           xhr.open("post","deleteAuthenticationInfo.do",true);
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
function checkDelete(id,companyId){
	 var r = window.confirm("确定删除此认证信息？");
	 if(r){
             location.href="deleteBuyerAuthentication.do?id="+id+"&&companyId="+companyId;
          }
}
function checkDeletes(){
	var r = window.confirm("确定删除所选认证信息吗？");
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
				<li class="click"><span><img src="images/t01.png" /> </span><a
					href="/GraduationDesign/toAddBuyerAuthentication.do?companyId=${companyId}">添加</a></li>
				<li><a class="tablelink" href="#" onclick="checkDeletes();"><span><img
							src="images/t03.png" /> </span>删除</a></li>
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th><input name="" id="checkAll" type="checkbox"
						onclick="checkAll();" />全选</th>
					<th>认证ID</th>
					<th>认证名称</th>
					<th>认证文件</th>
					<th style="display: none">企业名称ID</th>
					<!-- <th>状态</th> -->
					<th>上传时间</th>
					<th style="display: none">上传人</th>
					<th>文件类别</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${au}" var="au">
					<tr>
						<td><input name="box" type="checkbox" onclick="checkBox();"
							value="${au.id}" /></td>
						<td>${au.id}</td>
						<td>${au.authenticationName}</td>
						<td><img src="<%=path%>${au.filePath}" alt="" width="200px;"
							height="80px;" /></td>
						<td style="display: none">${au.companyId}</td>
						<%-- <td>
                        	<c:choose>
                        		<c:when test="${au.status==0}">
                        			未认证
                        		</c:when>
                        		<c:when test="${au.status==1}">
                        			已认证
                        		</c:when>
                        	</c:choose>
                        </td> --%>
						<td>${au.uploadTime}</td>
						<td style="display: none">${au.uploadBy}</td>
						<td>${au.fileClass}</td>
						<td><a class="tablelink"
							href="/GraduationDesign/toUpdateBuyerAuthentication.do?id=${au.id}">修改</a> <a
							class="tablelink" href="#"
							onclick="checkDelete(${au.id},${companyId});">删除</a> <%-- <input
							type="button" value="删除"
							onclick="location.href='deleteBuyerAuthentication.do?id=${au.id}&&companyId=${companyId}';" /> --%>
						</td>
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
							href="/GraduationDesign/buyerAuthenticationInfo.do?currentPage=${page.currentPage-1}&&companyId=${companyId}"><span
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
								href="/GraduationDesign/buyerAuthenticationInfo.do?currentPage=${s3}&&companyId=${companyId}">${s3}</a></li>
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
							href="/GraduationDesign/buyerAuthenticationInfo.do?currentPage=${page.currentPage+1}&&companyId=${companyId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>


		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="../images/ticon.png" /> </span>
				<div class="tipright">
					<p>是否确认对信息的修改 ？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>

			<div class="tipbtn">
				<input name="" type="button" class="sure" value="确定" />&nbsp; <input
					name="" type="button" class="cancel" value="取消" />
			</div>

		</div>
	</div>


</body>

</html>
