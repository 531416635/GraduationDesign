<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<!-- Custom Theme files -->
<link href="css/public.css" rel="stylesheet" type="text/css" media="all" />
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<link
	href='http://fonts.useso.com/css?family=Roboto:500,900italic,900,400italic,100,700italic,300,700,500italic,100italic,300italic,400'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.useso.com/css?family=Droid+Serif:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<!--Google Fonts-->
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>

<script type="text/javascript">
	var currentPage =parseInt(<%=num%>);
	window.onload = function() {
		var newH = window.screen.height - 60;
		document.getElementById("div_body").style.height = newH + "px";
	};
	function checkTime() {
		if ($("#startOrderTime").val() != "" && $("#endOrderTime").val() != "") {

			if ($("#startOrderTime").val() > $("#endOrderTime").val()) {
				alert("开始时间不应大于结束时间！")
			} else {
			$("#form1").submit();
			}
		} else {
		$("#form1").submit();
		}

	};

	function viewMore(){
	  $.ajax({  //此ajax加载分页商品
			type : "POST",
			async : false,
			url : "orderMore.do",
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
					
					for ( var i = 0; i < json.orders.length; i++) {
							content1 += '<table>' + '<tr>'
								+ '<td style="width:60px;">商品：</td><td>'
								+ json.orders[i].productName
								+ '</td></tr><tr>'
								+ '	<td>价格：</td>'
								+ '	<td>'
								+ json.orders[i].UnitPrice
								+ '</td></tr><tr>'
								+ '	<td>数量：</td>'
								+ '	<td>'
								+ json.orders[i].Quantity
								+ '</td></tr><tr>'
								+ '	<td>总价：</td>'
								+ '	<td>'
								+ json.orders[i].TotolAmount
								+ '</td></tr><tr>'
								+ '	<td>日期：</td>'
								+ '	<td>'
								+ dateJoin(json.orders[i].OrderTime.time)
								+ '</td></tr><tr>'
								+ '	<td>状态：</td>'
								+ '	<td>'
								+ json.orders[i].Status + '</td></tr></table>';
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

div.meneame span {
	display: inline;
}
</style>
</head>
<body>
	<div class="top">
		<form style="width:85%; margin:0 auto;" action="orderInquiry.do"
			id="form1" method="post">
			<P>
				<span>订单单号：</span><input type="text" name="orderId">
			</P>
			<P>
				<span>商品名称：</span><input id="productName" type="text"
					name="productName" placeholder="&nbsp;请输入商品名称" />
			</P>
			<P>
				<span>供应商：</span><input id="companyName" type="text"
					name="companyName" placeholder="&nbsp;请输入供应商名称" />
			</P>
			<P>
				<span>订单日期：</span><input onclick="WdatePicker()"
				id="startOrderTime"	name="startOrderTime" />-<input onclick="WdatePicker()"
				id="endOrderTime"	name="endOrderTime" />
			</P>
			<input style="width:70px; margin-left:70%;" type="button"
				onclick="checkTime()" value="查询" />
		</form>
		<hr color="#CCCCCC">

		<c:forEach items="${orders }" var="p">
			<table>
				<tr>
					<td style="width:60px;">商品：</td>
					<td>${p.productName }</td>
				</tr>
				<tr>
					<td>价格：</td>
					<td>${p.UnitPrice }</td>
				</tr>
				<tr>
					<td>数量：</td>
					<td>${p.Quantity }</td>
				</tr>
				<tr>
					<td>总价：</td>
					<td>${p.TotolAmount }</td>
				</tr>
				<tr>
					<td>日期：</td>
					<td>${p.OrderTime }</td>
				</tr>
				<tr>
					<td>状态：</td>
					<td>${p.Status }</td>
				</tr>
			</table>
		</c:forEach>
		<p id="ps" style="text-align:center">
			<input style="outline:none; background-color:#fff; color:#666"
				type="button" value="点击查看更多↓" onclick="viewMore()">
		</p>
	</div>
</body>
</html>