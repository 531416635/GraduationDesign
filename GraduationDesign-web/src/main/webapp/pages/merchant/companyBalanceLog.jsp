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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<link href="<%=path%>/css/redcss/core.css" type="text/css"
	rel="stylesheet" />
<script src="<%=path%>/js/redjs/jquery.1.3.2.js" type="text/javascript"
	language="javascript"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
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
		location.href="accountWater.do?currentPage="+(page_index+1);
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

.btnq {
	border: none;
	width: 70px;
	height: 20px;
	margin-left: 20%;
	font-size: 12px;
	color: white;
}

.btnf {
	border: none;
	width: 70px;
	height: 20px;
	margin-left: 50px;;
	font-size: 12px;
	color: white;
}

th {
	background-color: #F0F0F0;
	border: 0.5px solid #999;
}

td {
	border: 0.5px solid #999;
}

tr {
	height: 32px;
}

input {
	height: 23px;
	width: 150px;
}

.input_radio {
	width: 13px;
	height: 13px;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">结算管理 ></span><span
				class="lo2">资金账户流水</span>
		</div>

					<table border="1" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>币种</th>
								<th>账户金额</th>
								<th>账户变更</th>
								<th>变更时间</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${companyBalanceLog}" var="c">
								<tr>
									<td align="center">${c.currency}</td>
									<td align="right">${c.balance}</td>
									<td align="right">${c.balanceChange}</td>
									<td align="center">${c.changeDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 分页 -->
			<div class="pagin">
			<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
			<div id="Pagination" class="meneame" style="clear:left"></div> 	
			</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>
