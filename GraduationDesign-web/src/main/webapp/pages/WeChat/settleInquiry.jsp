<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="<%=path%>/css/WeChatcss/public.css" rel="stylesheet"
	type="text/css" media="all" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
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
			url : "findMoreSettlement.do",
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
					for ( var i = 0; i < json.settlements.length; i++) {
							switch(json.settlements[i].status){
							case 0:content2 = '未支付';break;
							case 1:content2 = '支付成功';break;
							case 2:content2 = '支付失败';break;
							case 3:content2 = '银行支付成功';break;
							case 4:content2 = '银行支付失败';break;
							case 5:content2 = '用户取消';break;
							};	
										 
							content1 +='            	<table>'
							+'         	 <tr>'
							+'            	<td style="width:35px;">结算编号：</td>'     
							+'                <td>'+json.settlements[i].settlementId+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>结算金额：</td>'
							+'                <td>'+json.settlements[i].settleAmount+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>结算时间：</td>'
							+'                <td>'+dateJoin(json.settlements[i].settleTime.time)+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            <td>结算人：</td>'
							+'                <td>'+json.settlements[i].userName+'</td>'
							+'            </tr>'							
							+'            <tr>'
							+'            	<td>结算状态：</td>'
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
		<form id="form" action="<%=path%>/weChat/findSettlement.do"
			method="post">
			<P>
				<span>结单号：</span><input type="text" name="settlementId" />
			</P>
			<P>
				<span>账期：</span> <input style="width: 35%" type="text"
					name="settleTimeStart" onclick="WdatePicker()" readonly="readonly" />-<input
					style="width: 35%" type="text" name="settleTimeStop"
					onclick="WdatePicker()" readonly="readonly" />
			</P>
			<input style="width: 70px; margin-left: 70%;" type="button"
				onclick="$('#form').submit();" value="查询" />
		</form>
		<hr color="#CCCCCC">
		<c:forEach items="${settlements}" var="it" varStatus="status1">
			<table>
				<tr>
					<td style="width: 60px;">结算编号：</td>
					<td>${it.settlementId}</td>
				</tr>
				<tr>
					<td>结算金额：</td>
					<td>${it.settleAmount}</td>
				</tr>
				<tr>
					<td>结算时间：</td>
					<td>${it.settleTime}</td>
				</tr>
				<tr>
					<td>结算人：</td>
					<td>${it.userName}</td>
				</tr>
				<tr>
					<td>结算状态：</td>
					<td><c:choose>
							<c:when test="${it.status == 0}">未支付</c:when>
							<c:when test="${it.status == 1}">支付成功</c:when>
							<c:when test="${it.status == 2}">支付失败</c:when>
							<c:when test="${it.status == 3}">银行支付成功</c:when>
							<c:when test="${it.status == 4}">银行支付失败</c:when>
							<c:when test="${it.status == 5}">用户取消</c:when>
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