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
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />

<script type="text/javascript">
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
	function checkAll() {
		var ischecked = document.getElementById("checkAll").checked;
		if (ischecked) {
			checkallbox();
		} else {
			discheckallbox();
		}
	}
	function checkallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = true;
		}
	}
	function discheckallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
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
	function getXhr() {
		var xhr = null;
		if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		} else {
			xhr = new ActiveXObject('Microsoft . XMLHTTP');
		}
		return xhr;
	}
	function getText() {
		var xhr = getXhr();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				if (window.confirm("确定要删除吗?")) {
					window.location.href = "Orders.do";
				} else {
					return;
				}
			}
		};
		xhr.open("post", "allDeleteOrders.do", true);
		xhr.setRequestHeader('content-type',
				'application/x-www-form-urlencoded');
		var countId = getId();
		xhr.send("Uid=" + countId);
	}$(function(){
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
			prev_text: "<<上一页",
			next_text: "下一页>>"
		}); 
	 };  
	function pageselectCallback(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		location.href="Orders.do?currentPage="+(page_index+1);
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
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">系统后台</a></li>
			<li><a href="#">订单管理</a></li>

		</ul>
	</div>




	<div class="tools">
		<ul class="toolbar">
			<li><a class="tablelink" href="/GraduationDesign/main/toOrdersAdd.do?"><span><img
						src="../images/t01.png" /> </span>添加</a></li>
			<li class="click2"><span><img
					src="<%=path%>/images/t03.png" /> </span> <a href="javascript:;"
				onclick="getText();">删除</a></li>

		</ul>



	</div>


	<table class="tablelist">
		<thead>
			<tr>
				<th><input id="checkAll" type="checkbox" name="" value=""
					onclick="checkAll();" /></th>
				<th style="display: none">ID<i class="sort"><img
						src="<%=path%>/images/px.gif" /> </i></th>
				<th>订单时间</th>
				<th>订单状态</th>
				<th>订单编号</th>
				<th>供应商名称</th>
				<th>产品名称</th>
				<th>数量</th>
				<th>数量单位</th>
				<th>单价</th>
				<th>交货期</th>
				<th>有效期至</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dispatch}" var="dis">
				<tr>
					<td><input name="box" type="checkbox" value="${dis.id}" /></td>
					<td style="display: none">${dis.id}</td>
					<td>${dis.orderTime}</td>

					<td>${dis.orderId}</td>
					<td>${dis.companyProductId}</td>
					<td></td>
					<td>${dis.quantity}</td>
					<td>${dis.productUnit}</td>
					<td>${dis.unitPrice}</td>
					<td>${dis.deliveryDate}</td>
					<td>${dis.validUntil}</td>
					<td><c:choose>
							<c:when test="${dis.status == 0}">申请</c:when>
							<c:when test="${dis.status == 1}">处理</c:when>
							<c:when test="${dis.status == 2}">完成 </c:when>
						</c:choose></td>

					<td><a href="deleteOrders.do?id=${dis.id }" class="tablelink">
							删除 </a> <a href="toOrdersListUpdate.do?id=${dis.id}"
						class="tablelink">修改</a></td>
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
		<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
		<div id="Pagination" class="meneame" style="clear: left"></div>
	</div>
	<!-- 分页 -->
	<%-- <div class="pagin">
		<div class="message">
			共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
		</div>
		<ul class="paginList">
			<c:choose>
				<c:when test="${page.currentPage==1}">
					<li class="paginItem current"><a href="#"><span
							class="pagepre"></span> </a>
				</c:when>
				<c:otherwise>
					<li class="paginItem"><a
						href="/GraduationDesign/main/Orders.do?currentPage=${page.currentPage-1}"><span
							class="pagepre"></span> </a>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="1" end="${page.totalPage}" var="s3">
				<c:choose>
					<c:when test="${s3==page.currentPage}">
						<li class="paginItem current"><a href="#">${s3}</a>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/GraduationDesign/main/Orders.do?currentPage=${s3}">${s3}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${page.currentPage==page.totalPage or s3<=10}">
					<li class="paginItem current"><a href="#"><span
							class="pagenxt"></span> </a>
				</c:when>
				<c:otherwise>
					<li class="paginItem"><a
						href="/GraduationDesign/main/Orders.do?currentPage=${page.currentPage+1}"><span
							class="pagenxt"></span> </a>
				</c:otherwise>
			</c:choose>
		</ul>
	</div> --%>



	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
