<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String json = (String) request.getAttribute("json");
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>一起采</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />

<script type="text/javascript">
$('.tablelist tbody tr:odd').addClass('odd');
	function click(it) {
		alert(it);
	}
	$(document).ready(function() {
		$(".click").click(function() {
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

		$(".sure").click(function() {
			$(".tip").fadeOut(100);
		});

		$(".cancel").click(function() {
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

 function getText(){
       /**     var xhr = getXhr();
            xhr.onreadystatechange=function(){
                if(xhr.readyState==4 && xhr.status==200){
                    window.location.href="findBuyer.do";
                }
            };
           xhr.open("post","allDelete.do",true);
           xhr.setRequestHeader('content-type',
                'application/x-www-form-urlencoded');
           var countId = getId();
           xhr.send("Uid="+countId);*/
$.ajax({
  url: "/ssm/FAQ/allDeleteIds.do",
  data: {
Uid:countId
  },
  success: function( data ) {
              window.location.href="FAQList.do";
  }
});
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
	  var r = window.confirm("确定删除此信息？");
	 if(r){
             location.href="<%=path%>/FAQ/FAQDelete.do?id="+id;
          } 
}
function checkDeletes(){
	var r = window.confirm("确定删除所选信息吗？");
	 if(r){
            getText();
          }

}
$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=json%>);
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
		location.href="<%=path%>/FAQ/FAQList.do?currentPage="+(page_index+1);
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
		<form action="FAQAdd.do" method="post">
			<div class="tools">
				<ul class="toolbar">
					<li class=""><span><img src="images/t01.png" /></span> <a
						href="/ssm/FAQ/toFAQAdd.do">添加</a></li>
					<li><a class="tablelink" href="#" onclick="checkDeletes();"><span><img
								src="images/t03.png" /> </span>删除</a></li>
				</ul>
			</div>


			<table class="tablelist">
				<thead>
					<tr>
						<th><input name="" id="checkAll" type="checkbox"
							onclick="checkAll();" />全选</th>
						<th style="display: none">ID</th>
						<th>问题名称</th>
						<th>问题类型</th>
						<th>显示序列</th>
						<th>创建时间</th>
						<th>创建者</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${FAQ}" var="c">
						<tr>
							<td><input type="checkbox" name="box" value="${c.id}" /></td>
							<td style="display: none">${c.id}</td>
							<td><a href="/ssm/FAQ/FAQInfo.do?id=${c.id}">${c.title}</a></td>
							<td><c:forEach items="${questionType }" var="q">

									<c:if test="${q.id ==c.questionType }">${q.typeName }</c:if>
								</c:forEach></td>
							<td>${c.showIndex}</td>
							<td><jsp:useBean id="date" class="java.util.Date" /> <fmt:formatDate
									value="${c.createTime }" type="date" dateStyle="long"
									pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" /></td>

							<td>${c.createByName}</td>
							<td><a class="tablelink"
								href="/ssm/FAQ/toFAQUpdate.do?id=${c.id}">修改</a> <a
								class="tablelink" href="javascript:void(0)"
								onclick="checkDelete(${c.id});">删除</a> <%-- <input type="button" value="删除"
							onclick="location.href='deleteBuyer.do?id=${c.id}';" /> --%></td>
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
				<div id="Pagination" class="meneame" style="clear: left"></div>
			</div>

			<%-- <div class="pagin">
			<div class="message">
				共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<c:choose>
					<c:when test="${page.currentPage==1}">
						<li class="paginItem current"><a href="javascript:void(0)"><span
								class="pagepre"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/FAQ/FAQList.do?currentPage=${page.currentPage-1}"><span
								class="pagepre"></span> </a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="javascript:void(0)">${s3}</a></li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/FAQ/FAQList.do?currentPage=${s3}">${s3}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="javascript:void(0)"><span
								class="pagenxt"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/FAQ/FAQList.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span> </a></li>
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
						<p>是否确认对信息的修改 ？</p>
						<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
					</div>
				</div>

				<div class="tipbtn">
					<input name="" type="button" class="sure" value="确定" />&nbsp; <input
						name="" type="button" class="cancel" value="取消" />
				</div>

			</div>
		</form>




	</div>


</body>

</html>
