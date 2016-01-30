<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			 String num = (String) request.getAttribute("currentPage"); 
%>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/artDialog/dialog-plus-min.js"></script>
<link href="<%=path%>/js/artDialog/ui-dialog.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/WeChatcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/WeChatcss/style.css" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords"
	content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="text/javascript">
	var currentPage =parseInt(<%=num%>);
	function viewMore(){
 	/* var startTime=(page.inquiryTimeStart==null)?"":dateJoin(page.inquiryTimeStart.time);
	var stopTime=(page.inquiryTimeStop==null)?"":dateJoin(page.inquiryTimeStop.time);  */
	  $.ajax({  //此ajax加载分页商品
			type : "POST",
			async : false,
			url : "findMoreMyInquiry.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				currentPage : ++currentPage,
				/*  inquiryTimeStop : stopTime,
				inquiryTimeStart : startTime,
				productName : page.productName,
				inquiryId : page.inquiryId  */
			},
			success : function(data) {
				
				if (data == "false") { //提示
				var d = dialog({
   				title: '友情提示',
   			 	content: '加载失败，请稍后重试！'
				});
				d.show();
				} else {
					var json = eval(data);
					var content1 = '';
					var content2 = '';
					for ( var i = 0; i < json.inquirySheets.length; i++) {
							switch(json.inquirySheets[i].status){
							case 0:content2 = '未询价';
							break;
							case 1:content2 = '已询价';
							};					 
							content1 +='            	<table>'
							+'         	<tr>'
							+'            	<td style="width:35px;">商品：</td>'     
							+'                <td>'+json.inquirySheets[i].productName+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>价格：</td>'
							+'                <td>'+json.inquirySheets[i].refPrice+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>数量：</td>'
							+'                <td>'+json.inquirySheets[i].productQuantity+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>总价：</td>'
							+'                <td>'+json.inquirySheets[i].refPrice*json.inquirySheets[i].productQuantity+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>日期：</td>'
							+'                <td>'+dateJoin(json.inquirySheets[i].orderTime.time)+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>状态：</td>'
							+'                <td>'
							+					content2
							+'                </td>'
							+'            </tr>'
							+'         </table>';
					}
					$("#ps").before(content1);
				}
			}
		}); 	
	};
	function dateJoin(time){
     var date=new Date(time); 
		var times="";     
		times+=date.getFullYear()+"-";     
		times+=(date.getMonth()+1)+"-";     
		times+=date.getDate()+" "; 
		/* times+= date.getHours()+":";
		times+= date.getMinutes()+":";
		times+= ((date.getSeconds()>=10)?date.getSeconds():"0"+date.getSeconds());  */
		return times;
     }
</script>
<style type="text/css">
p {
	font-size: 90%;
	margin: 9px 0;
}

table {
	border-bottom: 1px dashed #999;
	margin: 10px 0;
	width: 100%;
}
</style>
</head>
<body>
	<div class="top">
		<form id="form" action="<%=path%>/weChat/findMyInquiry.do"
			method="post">
			<P>
				<span>询价单号：</span><input type="text" name="inquiryId" id="inquiryId" />
			</P>
			<P>
				<span>商品名称：</span><input type="text" name="productName"
					id="productName" />
			</P>
			<P>
				<span>询价日期：</span><input style="width: 35%" type="text"
					name="inquiryTimeStart" id="inquiryTimeStart"
					onclick="WdatePicker()" readonly="readonly" />-<input
					style="width: 35%" type="text" name="inquiryTimeStop"
					id="inquiryTimeStop" onclick="WdatePicker()" readonly="readonly" />
			</P>
			<input style="width: 70px; margin-left: 70%;" type="button"
				onclick="$('form').submit();" value="查询" />
		</form>
		<hr color="#CCCCCC">
		<c:forEach items="${inquirySheets}" var="it">
			<table>
				<tr>
					<td style="width: 35px;">商品：</td>
					<td>${it.productName}</td>
				</tr>
				<tr>
					<td>价格：</td>
					<td>${it.refPrice}</td>
				</tr>
				<tr>
					<td>数量：</td>
					<td>${it.productQuantity}</td>
				</tr>
				<tr>
					<td>总价：</td>
					<td>${it.refPrice*it.productQuantity}</td>
				</tr>
				<tr>
					<td>日期：</td>
					<td><fmt:formatDate value="${it.orderTime}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td>状态：</td>
					<td><c:if test="${it.status==0}">未询价</c:if> <c:if
							test="${it.status==1}">已询价</c:if></td>
				</tr>
			</table>
		</c:forEach>
		<p id="ps" style="text-align: center">
			<input style="outline: none; background-color: #fff; color: #666"
				type="button" value="点击查看更多↓" onclick="viewMore()">
		</p>
		<!-- 分页 -->
		<!-- <div class="pagin" id="pagin">
			<div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div>
			<div id="Pagination" class="meneame" style="clear:left"></div> 	
			</div> -->
	</div>
</body>
</html>