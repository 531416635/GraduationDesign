<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			 String num = (String) request.getAttribute("currentPage"); 
%>
<!-- Custom Theme files -->
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<link href="<%=path%>/css/WeChatcss/public.css" rel="stylesheet"
	type="text/css" media="all" />
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<link
	href='http://fonts.useso.com/css?family=Roboto:500,900italic,900,400italic,100,700italic,300,700,500italic,100italic,300italic,400'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.useso.com/css?family=Droid+Serif:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<!--Google Fonts-->
<script type="text/javascript">
   var currentPage =parseInt(<%=num%>);
   function viewMore(){
 
   $.ajax({//加载分页配送单
       type:"POST",
       async:false,
       url :"findMoreDispatchBill.do",
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
					for(var i=0;i<json.dispatchBill.length;i++){
					    switch(json.dispatchBill[i].status){
					      case 0:content2='未配送';break;
					      case 1:content2='已对账';break;
					      case 2:content2='已配送';break;
					      case 3:content2='未验收';break;
					      case 4:content2='已验收';break;
					      case 5:content2='未审核';break;
					      case 6:content2='已审核';break;
					    };
					   
					    content1+='     <table>'
					    +'           <tr>'
						+'          <td style="width:35px;">商品：</td>'
                        +'           <td>  '+json.dispatchBill[i].productName+'</td>'
                        +'          </tr>'
                        +'           <tr>'
            	        +'          <td>价格：</td>'
                        +'           <td> '+json.dispatchBill[i].unitPrice+'</td>'
                        +'           </tr>'
                        +'              <tr>'
            	        +'           <td>数量：</td>'
                        +'           <td>'+json.dispatchBill[i].purchaseQuantity+'</td>'
                        +'            </tr>'
                        +'              <tr>'
            	        +'           <td>总价：</td>'
                        +'          <td>'+json.dispatchBill[i].amount+'</td>'
                        +'             </tr>'
                        +'           <tr>'
            	        +'        <td>日期：</td>'
                        +'         <td>'+dateJoin(json.dispatchBill[i].deliveryTime.time)+'</td>'
                        +'        </tr>'
                        +'         <tr>'
            	        +'          <td>状态：</td>'
                        +'        <td>'
                        +          content2
                        +'         </td>'
                        +'        </tr>'
                        +'         </table>';
					}
			$("#vm").before(content1);
			
	}
	}
	,error:function(e){
	alert(e);	}
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
    window.onload = function() { 
		var newH=window.screen.height-60;
		document.getElementById("div_body").style.height = newH + "px";
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
		<form action="<%=path%>/weChat/myDispatchBill.do" method="post">
			<P>
				<span>配送地址：</span><input type="text" name="shoppingAddressName"
					value="${deliveryInquiryPage.shoppingAddressName}" />
			</P>
			<P>
				<span>配送单号：</span><input type="text" name="dispatchBillId"
					value="${deliveryInquiryPage.dispatchBillId}" />
			</P>
			<P>
				<span>配送人：</span><input style="margin-left: 10px;" type="text"
					name="deliveryUserName"
					value="${deliveryInquiryPage.deliveryUserName}" />
			</P>
			<P>
				状态：<select name="status">
					<option
						<c:if test="${deliveryInquiryPage.status==''}"> selected="true"</c:if>
						value="">全部</option>
					<option
						<c:if test="${deliveryInquiryPage.status==0}"> selected="true"</c:if>
						value="0">未配送</option>
					<option
						<c:if test="${deliveryInquiryPage.status==1}"> selected="true"</c:if>
						value="1">已对账</option>
					<option
						<c:if test="${deliveryInquiryPage.status==2}"> selected="true"</c:if>
						value="2">已配送</option>
					<option
						<c:if test="${deliveryInquiryPage.status==3}"> selected="true"</c:if>
						value="3">未验收</option>
					<option
						<c:if test="${deliveryInquiryPage.status==4}"> selected="true"</c:if>
						value="4">已验收</option>
					<option
						<c:if test="${deliveryInquiryPage.status==5}"> selected="true"</c:if>
						value="5">未审核</option>
					<option
						<c:if test="${deliveryInquiryPage.status==6}"> selected="true"</c:if>
						value="6">已审核</option>
				</select> <input style="width: 70px; margin-left: 20%;" type="submit"
					value="查询" />
			</P>
		</form>
		<hr color="#CCCCCC">
		<c:forEach items="${dispatchBill}" var="d">
			<table>
				<tr>
					<td style="width: 35px;">商品：</td>
					<td>${d.productName}</td>
				</tr>
				<tr>
					<td>价格：</td>
					<td>${d.unitPrice}</td>
				</tr>
				<tr>
					<td>数量：</td>
					<td>${d.purchaseQuantity}</td>
				</tr>
				<tr>
					<td>总价：</td>
					<td>${d.amount}</td>
				</tr>
				<tr>
					<td>日期：</td>
					<td><fmt:formatDate value="${d.deliveryTime}" type="both"
							pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td>状态：</td>
					<td><c:choose>
							<c:when test="${d.status==0}">未配送</c:when>
							<c:when test="${d.status==1}">已对账</c:when>
							<c:when test="${d.status==2}">已配送</c:when>
							<c:when test="${d.status==3}">未验收</c:when>
							<c:when test="${d.status==4}">已验收</c:when>
							<c:when test="${d.status==5}">未审核</c:when>
							<c:when test="${d.status==6}">已审核</c:when>
						</c:choose></td>
				</tr>
			</table>
		</c:forEach>

		<p id="vm" style="text-align: center">
			<input style="outline: none; background-color: #fff; color: #666"
				type="button" value="点击查看更多↓" onclick="viewMore();">
		</p>
	</div>
</body>
</html>