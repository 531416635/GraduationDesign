<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	String json = (String) request.getAttribute("json");
%>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript">
$('.tablelist tbody tr:odd').addClass('odd');
//----------------------------------发票寄出
	function fapiao(tmpId,tmpStatementId){
		location.href="purchaserInvoiceSend.do?tmpId="+tmpId+"&&tmpStatementId="+tmpStatementId;
	}
//---------------------------------------发票签收	
	function qianshou(tmpStatementId){
		location.href="invoiceSign.do?tmpStatementId="+tmpStatementId;
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
		location.href="invoiceList.do?currentPage="+(page_index+1);
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
				<li class="">
					<a href="/ssm/supplys/toInvoiceAdd.do">&nbsp;申请发票</a>
				</li>
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th style="display: none">ID</th>
					<th style="display: none">发票ID</th>
					<th>发票抬头</th>
					<th>发票金额</th>
					<th>发票类型</th>
					<th>发票状态</th>
					<th>开具时间</th>
					<th>公司ID</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${invoice}" var="c">
					<tr>
						<td style="display: none">${c.ID}</td>
						<td style="display: none">${c.InvoiceID}</td>
						
						<td>${c.InvoiceTitle}</td>
						<td>${c.Amount}</td>
						<td>
						<c:choose>
							<c:when test="${c.InvoiceType==1}">增值税发票</c:when>
							<c:when test="${c.InvoiceType==2}">普通发票</c:when>
							<c:when test="${c.InvoiceType==3}">专业发票</c:when>
						</c:choose>
						</td>
						<td>
						<c:choose>
							<c:when test="${c.Status==0}">发票申请</c:when>
							<c:when test="${c.Status==1}">发票已寄出</c:when>
							<c:when test="${c.Status==2}">发票已签收</c:when>
						</c:choose>
						</td>
						<td>${c.CreateTime}</td>
						<td>${c.CompanyID}</td>
						<input type="hidden" name="StatementID" value="${c.StatementID}"/>
						<td>
						<c:if test="${c.CompanyType==2}">
						<c:if test="${c.Status == 0}">
						<input type="button" value="寄出" onclick="fapiao(${c.ID},${c.StatementID})"/>
						</c:if>
						</c:if>
						<c:if test="${c.CompanyType==3}">
						<c:if test="${c.Status == 1}">
						<input type="button" value="签收" onclick="qianshou(${c.StatementID})"/>
						</c:if>
						</c:if>
						</td>
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
		
		<%-- <div class="pagin">
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
							href="/ssm/supplys/invoiceList.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
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
								href="/ssm/supplys/invoiceList.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
							</li>
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
							href="/ssm/supplys/invoiceList.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div> --%>




	</div>

</body>

</html>



