<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>

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
						window.location.href="invoice.do";
					} else {
						return;
						}
                }
            };
           xhr.open("post","allDeleteInvoice.do",true);
           xhr.setRequestHeader('content-type',
                'application/x-www-form-urlencoded');
           var countId = getId();
           if(countId==""){
             return;
           }
           xhr.send("Uid="+countId);
  }
  
function checkAll(){
  var ischecked=document.getElementById("checkAll").checked;
  if(ischecked){
    checkallbox();
  }else{
    invoicecheckallbox();
  }
}
function checkallbox(){
   var boxarray = document.getElementsByName("box");
   for(var i = 0; i < boxarray.length; i++) { 
     boxarray[i].checked = true;
   }
}
function invoicecheckallbox() { 
  var boxarray = document.getElementsByName("box"); 
  for(var i = 0; i < boxarray.length; i++) { 
    boxarray[i].checked = false;
  }
}


</script>


</head>


<body>



	<div class="rightinfo">

		<div class="tools">
			<ul class="toolbar">
				<li class="click"><span><img
						src="<%=path%>/images/t01.png" /></span>添加</li>
				<li class="click2"><span><img
						src="<%=path%>/images/t03.png" /></span> <a href="javascript:;"
					onclick="getText();">删除</a></li>
			</ul>
		</div>

		<table class="tablelist">
			<thead>
				<tr>
					<th><input id="checkAll" type="checkbox" onclick="checkAll();" /></th>
					<th>ID<i class="sort"><img src="<%=path%>/images/px.gif" /></i></th>
					<th>发票ID</th>
					<th>发票类型</th>
					<th>发票抬头</th>
					<th>发票金额</th>
					<th>开具时间</th>
					<th>公司名称</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${invoices }" var="invoice">
					<tr>
						<td><input type="checkbox" name="box" value="${invoice.id}" /></td>
						<td>${invoice.id}</td>
						<td>${invoice.invoiceId}</td>
						<td>${invoice.invoiceType}</td>
						<td>${invoice.invoiceTitle}</td>
						<td>${invoice.amount}</td>
						<td>${invoice.createTime}</td>
						<td>${invoice.companyName}</td>
						<td><a href="toInvoiceUpdate.do?id=${invoice.id }"
							class="tablelink">修改</a> <a
							href="invoiceDelete.do?id=${invoice.id }" class="tablelink">
								删除 </a></td>
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
								class="pagepre"></span></a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/GraduationDesign/supplys/invoice.do?currentPage=${page.currentPage-1}"><span
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
								href="/GraduationDesign/supplys/invoice.do?currentPage=${s3}">${s3}</a></li>
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
							href="/GraduationDesign/supplys/invoice.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span></a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>


		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="../images/ticon.png" /></span>
				<div class="tipright">
					<p>是否确认对信息的修改 ？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>

			<div class="tipbtn">
				<input name="" type="button" class="sure" value="确定"
					onclick="location='toInvoiceAdd.do'" />&nbsp; <input name=""
					type="button" class="cancel" value="取消" />
			</div>

		</div>
	</div>

	<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
