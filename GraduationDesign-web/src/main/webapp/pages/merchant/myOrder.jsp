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
			String page1 = (String)request.getAttribute("orderPage1");
			
			/* String page2 = (String)request.getAttribute("orderPage2"); */
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
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<script type="text/javascript">

	/* 	$(document).ready(function() {
			//示例1，默认弹出层
			new PopupLayer({trigger:".ele1",popupBlk:"#blk1",closeBtn:"#close1",offsets:{x:-850,y:250} 
			});
			}); */
			
		/* 	function dispatchBillsOfOrder(id){
			 $.ajax({
			dataType : "text",
			async : true,
			type : "POST",
			url : "dispatchBillsOfOrder.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				orderId : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					tablelist(data);
				}
			},
		}); 
     }  */
     //弹出层配送单列表
    /*  function tablelist(data){
     var json = eval('('+data+')');
     var josn2 = json.dispatchBill;
     var content1="";
     var content2="";	
     var content3 ="";
     var status ="";
     if(json.userRole=="Supplier"||json.userRole=="DeliveryUser"){
     content1="<th>配送人</th><th>配送时间</th>";
     }else if(json.userRole=="Checker"){
      content1="<th>验收人</th><th>验收时间</th>";
     }else if(json.userRole=="Accepter"||json.userRole=="PurchaseFinancial"){
     content1="<th>对账人</th><th>对账时间</th>";
     }else if(json.userRole=="PurchaseUser"||json.userRole=="PurchaseCompany"||json.userRole=="PurchaseDepart"){
     content1="<th>仓储</th><th>配送人</th><th>配送时间</th><th>验收人</th><th>验收时间</th><th>对账人</th><th>对账时间</th>";
     }
     $("#theadlist").html('<tr><th>发货单号</th><th>订单ID</th><th>商品名称</th><th>购买数量</th><th>实收数量</th><th>数量单位</th><th>单价</th><th>金额小计</th><th>配送地址</th>'+content1+
						'<th>状态</th></tr>');
		for ( var i = 0; i < josn2.length; i++) {
		if(json.userRole=="Supplier"||json.userRole=="DeliveryUser"){
      content2="<td>"+ josn2[i].deliveryUserName+"</td><td>"+dateJoin(josn2[i].deliveryTime.time)+"</td>";
     }else if(json.userRole=="Checker"){
      content2="<td>"+ josn2[i].checkUserName+"</td><td>"+dateJoin(josn2[i].checkTime.time)+"</td>";
     }else if(json.userRole=="Accepter"||json.userRole=="PurchaseFinancial"){
     content2="<td>"+ josn2[i].accepterUserName+"</td><td>"+dateJoin(josn2[i].acceptTime.time)+"</td>";
     }else if(json.userRole=="PurchaseUser"||json.userRole=="PurchaseCompany"||json.userRole=="PurchaseDepart"){
     content2="<td>"+ josn2[i].storageName+"</td><td>"+josn2[i].accepterUserName+"</td><td>"+dateJoin(josn2[i].acceptTime.time)+"</td><td>"+josn2[i].deliveryUserName+"</td><td>"+dateJoin(josn2[i].deliveryTime.time)+"</td><td>"+josn2[i].checkUserName+"</td><td>"+dateJoin(josn2[i].checkTime.time)+"</td>";
     }
		 switch(josn2[i].status){
		 case 0:status="<td>未配送</td>";
		 case 1:status="<td>已对账</td>";
		 case 2:status="<td>未配送</td>";
		 case 3:status="<td>未验收</td>";
		 case 4:status="<td>已验收</td>";
		 case 5:status="<td>未审核</td>";
		 case 6:status="<td>已审核</td>";		 
		 }
			content3+='<tr><td>'+josn2[i].dispatchBillId+'</td><td>'+josn2[i].orderCode+'</td><td>'+josn2[i].productName+'</td><td>'+josn2[i].purchaseQuantity+'</td><td>'+josn2[i].packagesNumber+'</td><td>'+josn2[i].productUnit+'</td><td>'+josn2[i].unitPrice+'</td><td>'+josn2[i].amount+'</td><td>'+josn2[i].shoppingAddressName+'</td>'+content2+status+'</tr>';	
		}
		$("#tbodylist").html(content3);
     }
     function dateJoin(time){
     var date=new Date(time); 
		var times="";     
		times+=date.getFullYear()+"-";     
		times+=(date.getMonth()+1)+"-";     
		times+=date.getDate()+" "; 
		times+= date.getHours()+":";
		times+= date.getMinutes()+":";
		times+= date.getSeconds(); 
		return times;
     } */
 /*     function ele1checked(id){
     $("#ele1").val(id);
     } */
     
     //自动生成系统当前时间用于默认赋值
      $(document).ready(function() {
     var myDate = new Date();
     var month=myDate.getMonth();
     var yr=myDate.getFullYear();
     var date=myDate.getDate();
     var startTime=yr+"-"+(month-2)+"-"+date;
     if($("#orderTimeStart").val()==null||$("#orderTimeStart").val()==""){
     $("#orderTimeStart").val(startTime);
     }  
         var stopTime=yr+"-"+(month+1)+"-"+date;
     if($("#orderTimeStop").val()==null||$("#orderTimeStop").val()==""){ 
     $("#orderTimeStop").val(stopTime);
     }
     }); 
     
     //分页部分
     $(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=page1%>);
	  	$("#rows1").html(json.rows);
	  	$("#currentPage1").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination1").pagination(json.rows, { // 创建分页按钮
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
		var a="myOrder.do?currentPage1="+(page_index+1);
	
		location.href=a;
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
<%-- 	$(function(){
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
		location.href="myOrder.do?currentPage2="+(page_index+1)+"&&show=2";
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	}); --%>
	
//----------------------------------页面加载进度条
$(document).ready(function(){
	var h = $(document).height();
	$(".overlay").css({"height": h });	
	$(".action").click(function(){
		$(".overlay").css({'display':'block','opacity':'0.8'});
		$(".showbox").stop(true).animate({'margin-top':'300px','opacity':'1'},200);
		setTimeout(function(){
			$(".showbox").stop(true).animate({'margin-top':'250px','opacity':'0'},400);
			$(".overlay").css({'display':'none','opacity':'0'});
		},800);
	});
});	

/*****检查订单的起止时间*************/
function checkTime(){
     var myDate = new Date();
     var month=myDate.getMonth();
     var yr=myDate.getFullYear();
     var date=myDate.getDate();
     var startTime1=yr+"-"+(month-2)+"-"+date;
     var stopTime1=yr+"-"+(month+1)+"-"+date;
     var orderTimeStart1=$("#orderTimeStart").val();
     var orderTimeStop1=$("#orderTimeStop").val();
     
     var startTime2 = new Date(startTime1.replace(/-/g,"\/"));
    var startTime = startTime2.getTime();
    
    var stopTime2 = new Date(stopTime1.replace(/-/g,"\/"));
    var stopTime = stopTime2.getTime();
    
     var orderTimeStart2 = new Date(orderTimeStart1.replace(/-/g,"\/"));
    var orderTimeStart = orderTimeStart2.getTime();
   
    var orderTimeStop2 = new Date(orderTimeStop1.replace(/-/g,"\/"));
    var orderTimeStop = orderTimeStop2.getTime();
   
   
    if (orderTimeStart <startTime || orderTimeStart > stopTime) {
        
        $("#orderTimeStart").val(startTime1);
    	alert("请选择三个月以内的日期");
        
    }else if (orderTimeStop> stopTime||orderTimeStop<startTime) {
    	$("#orderTimeStop").val(stopTime1);
    	alert("请选择三个月以内的日期");
        
    }else{
     if (orderTimeStart > orderTimeStop) {
         $("#orderTimeStart").val(startTime1);
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
<script src="<%=path%>/js/redjs/popup_layer.js" type="text/javascript" language="javascript"></script>

</head>

<body>
	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span><span class="lo2">我的订单</span>
		</div>
<!-- 		<a href="javascript:exportExcel();" class="myBtn"><em>导出</em></a> -->
		<!-- <p>
			日期&nbsp;<input onclick="WdatePicker()" readonly="readonly" />&nbsp;至
			&nbsp;<input onclick="WdatePicker()" readonly="readonly" />
		</p> -->

		<div class="detail_list">
<!-- 			<a href="#">订单存档</a> -->
			<ul id="tabs">
				<li><a href="<%=path %>/merchant/myOrder.do" title="tab1">近三个月订单 </a></li>
				<li><a href="<%=path%>/merchant/myOldOrder.do" title="tab2">三个月前订单</a></li>
			</ul>
			<div id="content">
				<div id="tab1">
					<input type="hidden" id="ele1" value="">
     <form name="orders" action="/ssm/merchant/myOrder.do" method="post">
     <table id="table_1">
     	<tr>
     		<td>订单号：</td>
     		<td><input class="input_text" type="text" name="orderId" id="orderId" <c:if test="${page.orderId!=''}">value="${page.orderId}"</c:if> /></td>
     		<td>货品名称：</td>
     		<td><input class="input_text" type="text" name="productName"   id="productName"  <c:if test="${page.productName!=''}">value="${page.productName}"</c:if> /></td>
     	</tr>
     	<tr>
     		<td>成交时间：</td>
     		<td colspan="3">
     			<input class="input_text" onchange="checkTime()" onclick="WdatePicker()" readonly="readonly" name="orderTimeStart"  id="orderTimeStart" value="${page.orderTimeStart }" />-
     			<input class="input_text" onchange="checkTime()" onclick="WdatePicker()" readonly="readonly"  name="orderTimeStop"  id="orderTimeStop"  value="${page.orderTimeStop}" />
     		</td>
     	</tr>
     	<tr>
     		<td>订单状态：</td>
     		<td colspan="3">
     			<input  style="width:20px;height:10px" type="radio" name= "orderStatus" value=""  <c:if test="${page.orderStatus==''||page.orderStatus==null}"> checked="checked"</c:if>/><span>全部</span>
				<input  style="width:20px;height:10px" type="radio" name= "orderStatus" value="0"   <c:if test="${page.orderStatus==0}"> checked="checked"</c:if>/><span>未完结</span>
				<input  style="width:20px;height:10px" type="radio" name= "orderStatus" value="1"   <c:if test="${page.orderStatus==1}"> checked="checked"</c:if>/><span>已完结</span>
				<input  style="width:20px;height:10px" type="radio" name= "orderStatus" value="2"  <c:if test="${page.orderStatus==2}"> checked="checked"</c:if>/><span>已拆分</span>
				<input  style="width:20px;height:10px" type="radio" name= "orderStatus" value="3"   <c:if test="${page.orderStatus==3}"> checked="checked"</c:if>/><span>已关闭</span>
     		</td>
     	</tr>
     	<tr>				
		<td>订单类型：</td>
		<td colspan="3"><select name="orderType">
		<option <c:if test="${page.orderType!=1&&page.orderType!=2&&page.orderType!=3}"> selected="true" </c:if> value="">全部</option>
		<option <c:if test="${page.orderType==1}"> selected="true" </c:if> value="1">询价订单</option>
		<option <c:if test="${page.orderType==2}"> selected="true" </c:if> value="2">团购订单</option>
		<option <c:if test="${page.orderType==3}"> selected="true" </c:if>  value="3">特价订单</option>
		</select></td>
		</tr>
     </table>
					<br>
					<input id="button_ss" class="action orange" type="submit" value="搜索"/></p>
    </form>
					<table  id="table_2" border="1px solid #D0D0D0" cellspacing="0" width="100%">
						<thead>
							<tr style="background-color: #f1f1f1;">
								<th>订单编号</th>
								<th>货品</th>
								<th style="width: 60px">单价</th>
								<th style="width: 60px">数量</th>
								<th>总金额</th>
								<th>订单状态</th>
								<th style="width: 100px">交易操作</th>
								<th>订单日期</th>
								<th>订单类型</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${order1}" var="d">
							<tr><%-- 用于初始化7个计数变量的初值 --%>
                                              <c:set var="n1" value="0"></c:set>
					                          <c:set var="n2" value="0"></c:set>
					                          <c:set var="n3" value="0"></c:set>
					                          <c:set var="n4" value="0"></c:set> 
					                          <c:set var="n5" value="0"></c:set>
					                          <c:set var="n6" value="0"></c:set> 
					                          <c:set var="n7" value="0"></c:set>
									<td>${d.orderId}</td>
									<td>${d.productName}</td>
									<td>${d.unitPrice}</td>
									<td>${d.quantity}</td>
									<td align="right">${d.totolAmount}</td>
									<td><c:choose>
											<c:when test="${d.status==0}">未完结</c:when>
											<c:when test="${d.status==1}">已完结</c:when>
											<c:when test="${d.status==2}">
											<%--下面的代码用于在“订单状态”字段中统计并显示处于各个状态的被拆分订单的个数 --%>                           
											<c:forEach items="${d.orderStatus}" var="c" >
										<c:if test="${c==0}"><c:set var="n1" value="${n1+1}"></c:set></c:if>
										<c:if test="${c==1}"><c:set var="n2" value="${n2+1}"></c:set></c:if>
										<c:if test="${c==2}"><c:set var="n3" value="${n3+1}"></c:set></c:if>
										<c:if test="${c==3}"><c:set var="n4" value="${n4+1}"></c:set></c:if>
										<c:if test="${c==4}"><c:set var="n5" value="${n5+1}"></c:set></c:if>
										<c:if test="${c==5}"><c:set var="n6"  value="${n6+1}"></c:set></c:if>
										<c:if test="${c==6}"><c:set var="n7"  value="${n7+1}"></c:set></c:if>									
											</c:forEach>
											<c:if test="${n1>0}">有${n1}个订单未配送<br></c:if> 
											<c:if test="${n2>0}">有${n2}个订单已对账<br></c:if>
											<c:if test="${n3>0}">有${n3}个订单已配送<br></c:if>
											<c:if test="${n4>0}">有${n4}个订单未验收<br></c:if>
											<c:if test="${n5>0}">有${n5}个订单已验收<br></c:if>
											<c:if test="${n6>0}">有${n6}个订单未审核<br></c:if>
											<c:if test="${n7>0}">有${n7}个订单已审核<br></c:if>
											</c:when>	
											<c:when test="${d.status==3 }">已关闭</c:when>	
											<%-- 			<c:when test="${d.status==3}">待评价</c:when>
											<c:when test="${d.status==4}">交易成功</c:when> --%>
										</c:choose></td>
									<td>
									<a href="#">查看评价</a>&nbsp;<br />
									<a href="<%=path%>/merchant/acceptanceDetails.do?id=${d.id}">验收情况</a>&nbsp;<br />
									<!-- <a href="#">申请售后</a>&nbsp;<br /> -->
								   <c:choose>
										<c:when test="${d.status==0}"><c:if test="${d.orderType==1}"><a href="splitPriceSheet.do?id=${d.id}">订单拆分</a></c:if>
										<c:if test="${d.orderType==2}"><a href="<%=path%>/web/toGrouponPay.do?id=${d.id}">等待付款</a></c:if></c:when>
									<%-- 	<c:when test="${d.status==2}"><a class="ele1" href="javascript:ele1checked(${d.id});">拆分详情</a></c:when>		 --%>
									</c:choose>
									</td>
									<td>${d.orderTime}</td>
									<td><c:if test="${d.orderType==1}">询价订单</c:if>
									<c:if test="${d.orderType==2}">团购订单</c:if>
									<c:if test="${d.orderType==3}">现货订单</c:if></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
		<!-- 弹出层 -->
	<!-- 	<div id="blk1" class="blk" style="display:none; width:1100px;height:auto;" >
            <div class="head"><div class="head-right"></div></div>
            <div class="main">
                <h2>订单拆分配送单列表</h2>
                <a href="javascript:void(0)" id="close1" class="closeBtn">关闭</a>
                <table id="tablelist" width="100%" border="1" cellspacing="0" align="center">
				<thead id="theadlist">	
				</thead>
				<tbody id="tbodylist">
				</tbody>
			</table><br>
            </div>
            <div class="foot"><div class="foot-right"></div></div>
        </div> -->
		
		

			</div>
			<div id="page">
			<!-- 分页 1-->
			<div id="pagin1" class="pagin">
			<!-- <div class="message">
				共<i id="rows1" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage1" class="blue"></i>页
			</div> -->
			<div id="Pagination1" class="meneame" style="clear:left"></div> 	
			</div>
			<!-- 分页 2-->
			<!-- <div id="pagin2" class="pagin">
			<div class="message">
				共<i id="rows2" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage2" class="blue"></i>页
			</div>
			<div id="Pagination2" class="meneame" style="clear:left"></div> 	
			</div> -->
			<!-- 
			<div id="Pagination1" class="meneame" style="clear:left"></div> 

			<div id="Pagination2" class="meneame" style="clear:left"></div> -->
				<%-- <div id="page1" class="pagin">
					<div class="message">
						共有<i class="blue">${orderPage1.rows}</i>条记录，当前显示第&nbsp;<i
							class="blue">${orderPage1.currentPage}&nbsp;</i>页
					</div>
					<ul class="paginList">
						<c:choose>
							<c:when test="${orderPage1.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myOrder.do?currentPage1=${page1.currentPage-1}&&show=1"><span
										class="pagepre"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${orderPage1.totalPage}" var="s3">
							<c:choose>
								<c:when test="${s3==orderPage1.currentPage}">
									<li class="paginItem current"><a href="#">${s3}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/ssm/merchant/myOrder.do?currentPage1=${s3}&&show=1">${s3}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${orderPage1.currentPage==orderPage1.totalPage or s3<=10}">
								<li class="paginItem current"><a href="#"><span
										class="pagenxt"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myOrder.do?currentPage1=${orderPage1.currentPage+1}&&show=1"><span
										class="pagenxt"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div> --%>
				<%-- <div id="page2" class="pagin">
					<div class="message">
						共有<i class="blue">${orderPage2.rows}</i>条记录，当前显示第&nbsp;<i
							class="blue">${orderPage2.currentPage}&nbsp;</i>页
					</div>
					<ul class="paginList">
						<c:choose>
							<c:when test="${orderPage2.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myOrder.do?currentPage2=${orderPage2.currentPage-1}&&show=2"><span
										class="pagepre"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${orderPage2.totalPage}" var="s3">
							<c:choose>
								<c:when test="${s3==orderPage2.currentPage}">
									<li class="paginItem current"><a href="#">${s3}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/ssm/merchant/myOrder.do?currentPage2=${s3}&&show=2">${s3}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${orderPage2.currentPage==orderPage2.totalPage or s3<=10}">
								<li class="paginItem current"><a href="#"><span
										class="pagenxt"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myOrder.do?currentPage2=${orderPage2.currentPage+1}&&show=2"><span
										class="pagenxt"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div> --%>
			</div>
		</div>
	</div>

	<!-- <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script> -->
	<script>
/* 		$(document).ready(function() {
 			$("#content div").hide(); // Initially hide all content	
			if ("${show}" == "1" || "${show}" == "") {
				$("#tabs li:first").attr("id", "current"); // Activate first tab
				$("#tabs li:last").attr("id", ""); // Activate first tab
				$("#content div:first").fadeIn(); // Show first tab content	
				$("#pagin1").show();	
				$("#pagin2").hide();		
			} else {
				$("#tabs li:last").attr("id", "current"); // Activate first tab
				$("#tabs li:first").attr("id", ""); // Activate first tab
				$("#content div:last").fadeIn(); // Show first tab content
				$("#pagin1").hide();	
				$("#pagin2").show();		
			}	 
				
			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide();
				$("#tabs li").attr("id", "");
				$(this).parent().attr("id", "current");
				$('#' + $(this).attr('title')).fadeIn();
				$("#pagin1").hide();	
				$("#pagin2").hide();	
				var tmp=$(this).attr('title');
				var page="#pagin" +tmp.replace("tab","");
				$(page).show();				
			});
		}); */
	</script>
<div class="overlay"></div>

<div id="AjaxLoading" class="showbox">
	<div class="loadingWord"><img src="<%=path%>/images/waiting.gif">加载中，请稍候...</div>
</div>

<div style="height:1200px;">
	
</div>
</body>
</html>
