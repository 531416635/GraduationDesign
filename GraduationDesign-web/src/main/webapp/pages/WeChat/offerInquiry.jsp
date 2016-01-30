<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link href="<%=path%>/css/WeChatcss/public.css" rel="stylesheet"
	type="text/css" media="all" />
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
	  $.ajax({  //此ajax加载分页商品
			type : "POST",
			async : false,
			url : "findMoreOfferInquiry.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				currentPage : ++currentPage,		
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
					for ( var i = 0; i < json.priceSheets.length; i++) {
							switch(json.priceSheets[i].Status){
							case 0:content2 = '报价开始';break;
							case 1:content2 = '报价结束';break;
							case 2:content2 = '议价';break;
							case 3:content2 = '议价通过';break;
							case 4:content2 = '议价不通过';break;
							case 5:content2 = '报价失效';break;
							};				 
							content1 +='            	<table>'
							+'         	 <tr>'
							+'            	<td style="width:35px;">商品：</td>'     
							+'                <td>'+json.priceSheets[i].ProductName+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>价格：</td>'
							+'                <td>'+json.priceSheets[i].UnitPrice+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>数量：</td>'
							+'                <td>'+json.priceSheets[i].Quantity+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>总价：</td>'
							+'                <td>'+json.priceSheets[i].UnitPrice*json.priceSheets[i].Quantity+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>日期：</td>'
							+'                <td>'+dateJoin(json.priceSheets[i].CreateDate.time)+'</td>'
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
		<form id="form" action="<%=path%>/weChat/findOfferInquiry.do"
			method="post">
			<P>
				<span>报价单号：</span><input type="text" name="priceSheetId" />
			</P>
			<P>
				<span>商品名称：</span><input type="text" name="productName" />
			</P>
			<P>
				<span>报价日期：</span> <input style="width: 35%" type="text"
					name="createDateStart" onclick="WdatePicker()" readonly="readonly" />-<input
					style="width: 35%" type="text" name="createDateStop"
					onclick="WdatePicker()" readonly="readonly" />
			</P>
			<input style="width: 70px; margin-left: 70%;" type="button"
				onclick="$('#form').submit();" value="查询" />
		</form>
		<hr color="#CCCCCC">
		<c:forEach items="${priceSheets}" var="it">
			<table>
				<tr>
					<td style="width: 35px;">商品：</td>
					<td>${it.ProductName}</td>
				</tr>
				<tr>
					<td>价格：</td>
					<td>${it.UnitPrice}</td>
				</tr>
				<tr>
					<td>数量：</td>
					<td>${it.Quantity}</td>
				</tr>
				<tr>
					<td>总价：</td>
					<td>${it.UnitPrice*it.Quantity}</td>
				</tr>
				<tr>
					<td>日期：</td>
					<td><fmt:formatDate value="${it.CreateDate}" type="both"
							pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td>状态：</td>
					<td><c:choose>
							<c:when test="${it.Status==0}">报价开始</c:when>
							<c:when test="${it.Status==1}">报价结束</c:when>
							<c:when test="${it.Status==2}">议价</c:when>
							<c:when test="${it.Status==3}">议价通过</c:when>
							<c:when test="${it.Status==4}">议价不通过</c:when>
							<c:when test="${it.Status==5}">报价失效</c:when>
						</c:choose></td>
				</tr>
			</table>
		</c:forEach>
		<p id="ps" style="text-align: center">
			<input style="outline: none; background-color: #fff; color: #666"
				type="button" value="点击查看更多↓" onclick="viewMore();">
		</p>
	</div>
</body>
</html>