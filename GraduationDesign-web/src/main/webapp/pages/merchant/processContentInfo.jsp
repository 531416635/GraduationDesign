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
	//String roleName = request.getParameter("userRole");
	String json = (String)request.getAttribute("json");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<style type="text/css">
#img2 {
	margin-left: auto;
	margin-right: auto;
	width: 60%;
	height: 58px;
	border: 1px solid;
	color: #D0D0D0;
	font-size: 20px;
}

#t {
	background: #D0D0D0;
}

tbody {
	border: 1px solid #D0D0D0;
}

tr {
	height: 30px;
}
</style>

<script>

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
		location.href="processContentInfo.do?currentPage="+(page_index+1);
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
</script>
</head>

<body>

	<div class="inner_div">

		<hr style="color: red; border: 1px solid;" />
		<br />
		<div></div>
		<c:if test="${!empty workflowLogsAndNodes}">
			<table width="100%" cellspacing="1" align="center">
				<c:forEach items="${workflowLogsAndNodes}" var="w">
					<tr>
						<td><b>处理人：</b>&nbsp;${w.UserName}<br></td>
						<td><b>处理环节：</b>${w.NodeName}<br></td>
						<td><b>处理结果：</b> <c:choose>
								<c:when test="${w.ProcessResult==1}">同意</c:when>
								<c:when test="${w.ProcessResult!=1}">退回</c:when>
							</c:choose> <br></td>
						<td><b>处理时间：</b>${w.ProcessDate}<br></td>
					</tr>
					<tr>
						<td><b>处理信息：</b></td>
						<td colspan="3"><textarea disabled="disabled"
								style="float: left; width: 95%; height: 50px; line-height: 2; font-size: 12px; resize: none;">${w.ProcessContent}</textarea>
						</td>
					</tr>
					<tr style="border-bottom: 3px solid #D0D0D0;">
						<td colspan="4">&nbsp;</td>
					</tr>
				</c:forEach>
			</table>
			<!-- 分页 -->
			<div class="pagin">
				<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
				<div id="Pagination" class="meneame" style="clear: left"></div>
			</div>
		</c:if>
	</div>
	</div>




</body>
</html>
