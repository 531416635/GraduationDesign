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
	String json = (String) request.getAttribute("json");
%>
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="../js/frontjs/lanrenzhijia.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript">
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
		location.href="statement.do?currentPage="+(page_index+1);
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

tr {
	height: 35px;
}

td {
	text-align: center;
	border-left: 1px solid #D0D0D0;
}

th {
	border-left: 1px solid #D0D0D0;
}
</style>
</head>

<body>
	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">账户管理 ></span> <span
				class="lo2"> <c:if test="${companyType==3}">供应合同</c:if> <c:if
					test="${companyType==2}">采购合同</c:if>
			</span>
		</div>


		<div>
			<table width="100%" cellspacing="0" align="center">
				<thead style="border: 1px solid #D0D0D0">
					<tr style="background-color: #f1f1f1;">
						<th style="display: none">合同ID</th>
						<th style="display: none">公司ID</th>
						<th>合同年限</th>
						<th>合同账期</th>
						<th>供应品类</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody style="border: 1px solid #D0D0D0">

					<c:forEach items="${companyContracts}" var="c">
						<tr>
							<td style="display: none">${c.id}</td>
							<td style="display: none">${c.companyId}</td>
							<td>${c.contractTime}</td>
							<td>${c.contractTerms}</td>
							<td>${c.supplyCategory}</td>
							<td><c:choose>
									<c:when test="${c.status==0}">未签订</c:when>
									<c:when test="${c.status==1}">签订</c:when>
								</c:choose></td>
							<td><a class="tablelink"
								href="/ssm/merchant/merchantSupplierContract.do?id=${c.id}">合同详情</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="Pagination" class="meneame" style="clear: left"></div>
		</div>
	</div>
</body>
</html>
