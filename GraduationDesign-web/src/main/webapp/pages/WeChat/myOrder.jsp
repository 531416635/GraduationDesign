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
<link href="<%=path %>/css/WeChatcss/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<style type="text/css">
#p1 {
	font-size: 120%;
}


#order1,#order2 {
	border-bottom: 1px dashed #999;
	padding: 10px 0;
}
</style>
<script type="text/javascript">
var currentPage =parseInt(<%=num%>);
	window.onload = function() {
		var newH = window.screen.height - 60;
		document.getElementById("div_body").style.height = newH + "px";
	};
	
	function viewMore(){
	  $.ajax({  //此ajax加载分页商品
			type : "POST",
			async : false,
			url : "orderInquiryMore.do",
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
							var sta=json.orders[i].Status;
							var order=json.orders[i];
							var x='';
							var y='';
							switch (sta) {

						case 0:
							x='未完结';
							break;
						case 1:
							x='已完结';
							break;
						case 2:
							x='已拆分';
							break;
						case 3:
							x='订单取消';
							break;
						}
							
							if('ValidUntilkey' in order){
							y=dateJoin(json.orders[i].ValidUntil.time);
							
							}
								content1 += '<div id="order"'+i+'><p>编号：'
										+ json.orders[i].OrderID
										+ '</p>'
										+ '<p>商品：'
										+ json.orders[i].productName
										+ '</p>'
										+ '<p>时间：'
										+ dateJoin(json.orders[i].OrderTime.time)
										+ '</p>'
										+ '<p>数量：'
										+ json.orders[i].Quantity
										+ '</p>'
										+ '<p>名称：'
										+ json.orders[i].UserName
										+ '</p>'
										+ '<p>供应商：'
										+ json.orders[i].CompanyName
										+ '</p>'
										+ '<p>单价：'
										+ json.orders[i].UnitPrice
										+ '</p>'
										+ '<p>总额：'
										+ json.orders[i].TotolAmount
										+ '</p>'
										+ '<p>截止：'
										+ y /* dateJoin(json.orders[i].OrderTime.time) */
								+ '</p>'
								+ '<p>状态：'+x
								+ '</p></div>'

					}
					$("#ps").before(content1);
				}
			},
			error : function(e) {
				alert("失败！");
			}
		});
	};

	function dateJoin(time) {
		var times = "";

		if (time != "") {
			var date = new Date(time);
			times += date.getFullYear() + "-";
			times += (date.getMonth() + 1) + "-";
			times += date.getDate() + " ";
		}
		return times;
	}
</script>
</head>
<body>
	<div class="login">
			<div class="login-top">
			<p id="p1">我的订单</p>
			<hr color="#999999" />
			<c:forEach items="${orders }" var="p" varStatus="status">

				<div id="order${status.index }">
					<p>编号：${p.OrderID }</p>
					<p>商品：${p.productName }</p>
					<p>时间：${p.OrderTime }</p>
					<p>数量：${p.Quantity }</p>
					<p>名称：${p.UserName }</p>
					<p>供应商：${p.CompanyName }</p>
					<p>单价：${p.UnitPrice }</p>
					<p>总额：${p.TotolAmount }</p>
					<p>截止：${p.ValidUntil }</p>
					<p>
						状态：
						<c:if test="${p.Status==0 }">未完结</c:if>
						<c:if test="${p.Status==1 }">已完结</c:if>
						<c:if test="${p.Status==2 }">已拆分</c:if>
						<c:if test="${p.Status==3 }">订单取消</c:if>
					</p>
					<!-- <p>
						配送：<a href="#">查看配送详情</a>
					</p> -->
				</div>
			</c:forEach>
			<p id="ps" style="text-align:center">
				<input style="outline:none; background-color:#fff; color:#666"
					type="button" value="点击查看更多↓" onclick="viewMore()">
			</p>
			<form action="orderInquiry.do" method="post">
				<input type="hidden" name="status" value="" /> <input type="submit"
					value="全部订单" />
			</form>
			<form action="orderInquiry.do" method="post">
				<input type="hidden" name="status" value="1" /> <input type="submit"
					value="已完结订单" />
			</form>
			<form action="orderInquiry.do" method="post">
				<input type="hidden" name="status" value="0" /> <input type="submit"
					value="未处理订单" />
			</form>
			<div style="clear:both;margin:0px;padding:0px;line-height:0px;"></div>

		</div>
	</div>
</body>
</html>