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
			String page2 = (String)request.getAttribute("orderPage2");
%>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<link href="<%=path%>/css/redcss/core.css" type="text/css" rel="stylesheet"/>
<script src="<%=path%>/js/redjs/jquery.1.3.2.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/css/frontcss/public.css" />
  <script type="text/javascript">
       //自动生成系统当前时间用于默认赋值
      $(document).ready(function() {
     var myDate = new Date();
     var month=myDate.getMonth();
     var yr=myDate.getFullYear();
     var date=myDate.getDate();
     /* var stopTime=yr+"-"+(month-2)+"-"+date;
     if($("#orderTimeStop").val()==null||$("#orderTimeStop").val()==""){ 
     	$("#orderTimeStop").val(stopTime);
     } */
    var orderTimeStop1=$("#orderTimeStop").val();
   var stopTime1=yr+"-"+(month-2)+"-"+date;
    var stopTime2 = new Date(stopTime1.replace(/-/g,"\/"));
    var stopTime = stopTime2.getTime();
    var orderTimeStop2 = new Date(orderTimeStop1.replace(/-/g,"\/"));
    var orderTimeStop = orderTimeStop2.getTime();
   
  if (orderTimeStop> stopTime||$("#orderTimeStop").val()==null||$("#orderTimeStop").val()=="") {
    	  $("#orderTimeStart").val("");
    	$("#orderTimeStop").val(stopTime1);
    };
     }); 
     
     //分页
     $(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=page2%>);
	  	$("#rows2").html(json.rows);
	  	$("#currentPage2").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination2").pagination(json.rows, { // 创建分页按钮
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
		var a="myOldOrder.do?currentPage2="+(page_index+1);
		
		location.href=a;
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	
	/*****检查订单的起止时间*************/
function checkTime(){
     var myDate = new Date();
     var month=myDate.getMonth();
     var yr=myDate.getFullYear();
     var date=myDate.getDate();
   var stopTime1=yr+"-"+(month-2)+"-"+date;
     var orderTimeStart1=$("#orderTimeStart").val();
     var orderTimeStop1=$("#orderTimeStop").val();
    
    var stopTime2 = new Date(stopTime1.replace(/-/g,"\/"));
    var stopTime = stopTime2.getTime();
    
     var orderTimeStart2 = new Date(orderTimeStart1.replace(/-/g,"\/"));
    var orderTimeStart = orderTimeStart2.getTime();
   
    var orderTimeStop2 = new Date(orderTimeStop1.replace(/-/g,"\/"));
    var orderTimeStop = orderTimeStop2.getTime();
   
   
    if (orderTimeStart > stopTime) {
        
        $("#orderTimeStart").val("");
    	alert("请选择三个月以后的日期");
        
    }else if (orderTimeStop> stopTime) {
    	$("#orderTimeStop").val(stopTime1);
    	alert("请选择三个月以后的日期");
        
    }else{
     if (orderTimeStart > orderTimeStop) {
         $("#orderTimeStart").val("");
    	$("#orderTimeStop").val(stopTime1);
    	 alert("开始时间不应大于结束时间");
    };
    };
     
}
  </script>
  <style type="text/css">
.input_text{
   width: 150px;
   height: 20px;
} 

select{
   width: 100px;
   height: 20px;
}
 #button_ss{
   width: 70px;
   height: 20px;
} 
 #table_2 td,th{
  text-align: center;
  border: 0.5px solid #999;
}
#table_1 td{
    height:30px;
	padding-right: 10px;
}
</style>
    
  </head>
  
  <body>
   <div class="inner_div">
      <div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
           <span class="lo1">首页</span> > <span class="lo2">订单管理 ></span><span class="lo2">我的订单</span>
		</div>
		
		<div class="detail_list">
		<ul id="tabs">
				<li><a href="<%=path%>/merchant/myOrder.do" title="tab1">近三个月订单 </a></li>
				<li><a href="<%=path%>/merchant/myOldOrder.do" title="tab2">三个月前订单</a></li>
			</ul>
			<div id="content">
					<div id="tab">
   <form  action="<%=path%>/merchant/myOldOrder.do" method="post">
		<table id="table_1">
		<tr>
		<td>订单号：</td>
		<td><input  class="input_text" type="text" name="orderId"  id="orderId" <c:if test="${page1.orderId!=''}">value="${page1.orderId}"</c:if>/></td>
		<td>货品名称：</td>
		<td><input  class="input_text" type="text" name="productName" id="productName" <c:if test="${page1.productName!=''}">value="${page1.productName}"</c:if> /></td>
		</tr>
		<tr>
		<td>成交时间</td>
		<td colspan="3">
		<input   class="input_text" onchange="checkTime()" onclick="WdatePicker()" readonly="readonly" name="orderTimeStart"  id="orderTimeStart" value="${page1.orderTimeStart }"/>-
		<input   class="input_text" onchange="checkTime()" onclick="WdatePicker()" readonly="readonly" name="orderTimeStop"  id="orderTimeStop"  value="${page1.orderTimeStop }" />
		</td>
		 </tr>
		<tr>				
		<td>订单类型：</td>
		<td colspan="3"><select name="orderType">
		<option <c:if test="${page1.orderType==''}"> selected="true" </c:if> value="">全部</option>
		<option <c:if test="${page1.orderType==1}"> selected="true" </c:if> value="1">询价订单</option>
		<option <c:if test="${page1.orderType==2}"> selected="true" </c:if> value="2">团购订单</option>
		<option <c:if test="${page1.orderType==3}"> selected="true" </c:if>  value="3">特价订单</option>
		</select></td>
		</tr>
		</table>
	 <p>
		<input id="button_ss" class="orange" type="submit" value="搜索"/>	</p>			
		   </form>
					<table  id="table_2" border="1px solid #D0D0D0" cellspacing="0" width="100%">
						<thead>
							<tr style="background-color: #f1f1f1;">
								<th>货品</th>
								<th>单价</th>
								<th>数量</th>
								<th>总金额</th>
								<th>订单状态</th>
								<th>交易操作</th>
								<th>订单日期</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${order2}" var="b">
								<tr>
									<td>${b.productName}</td>
									<td>${b.unitPrice}</td>
									<td>${b.quantity}</td>
									<td align="right">${b.totolAmount}</td>
									<td><c:choose>
											<c:when test="${b.status==0}">未完结</c:when>
											<c:when test="${b.status==1}">已完结</c:when>
											<c:when test="${b.status==2}">已拆分</c:when>
											<c:when test="${b.status==3}">已关闭</c:when>
											
										</c:choose></td>
									<td><a href="#">查看评价</a><br>&nbsp;<a href="<%=path%>/merchant/acceptanceDetails.do?id=${b.id}">验收情况</a>&nbsp;<br><!-- <ahref="#">申请售后</a><br> --></td>
									<td>${b.orderTime}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<%--分页部分 --%>
			<div id="page">
			<div id="pagin2" class="pagin">
			<!-- <div class="message">
				共<i id="rows2" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage2" class="blue"></i>页
			</div> -->
			<div id="Pagination2" class="meneame" style="clear:left"></div> 	
			</div>
			 </div>
		
		</div>
   </div> 
  </body>
</html>
