<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/wjmm.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
#btn11 {
	background-color: red;
	height: 30px;
	width: 140px;
	margin-left: 30%;
	font-size: 14px;
	color: white;
}

#btn12 {
	background-color: orange;
	height: 30px;
	width: 140px;
	font-size: 14px;
	color: white;
}

#cx, #cx2 {
	background-color: #0090C0;
	height: 30px;
	width: 60px;
	font-size: 14px;
	color: white;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页 </span>> <span class="lo2">结算管理 ></span> <span
				class="lo2"> 对账单 ></span><span class="lo2"> 对账详情</span>
		</div>
		<p>
			订单支付时间&nbsp;<input type="text" />&nbsp;&nbsp;<input id="cx"
				type="button" value="查询" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 订单号&nbsp;<input
				type="text" />&nbsp;&nbsp;<input id="cx2" type="button" value="查询" />
		</p>

		<div>
			<table width="100%" border="1" cellspacing="0" align="center">
				<thead>
					<tr>
						<th style="display: none">ID</th>
						<th style="display: none">用户ID</th>
						<th>订单号/支付时间</th>
						<th>对方账户</th>
						<th>流水号</th>
						<th>款项到账时间</th>
						<th>财务类型</th>
						<th>收支金额</th>
						<th>我要结算</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><input type="checkbox" /></td>
					</tr>
				</tbody>
			</table>
		</div>


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
							href="/GraduationDesign/web/myInquiry.do?.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
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
								href="/GraduationDesign/web/myInquiry.do?.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
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
							href="/GraduationDesign/web/myInquiry.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<br /> <br /> <input type="button" value="确认提交" id="btn11" />&nbsp;&nbsp;
		<input type="button" value="取消返回" id="btn12" onclick="history.back();" />
	</div>



</body>
</html>
