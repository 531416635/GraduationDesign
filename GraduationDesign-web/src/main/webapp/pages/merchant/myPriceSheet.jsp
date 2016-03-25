<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	String inquiryId = request.getParameter("inquiryId");
	String json = (String) request.getAttribute("json");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<script type="text/javascript">
	var AddSuppliers=function(){
		var fileIds=''; 
		$("input[name=priceSheetID]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0)
		{
			alert("请选择");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		var tmp=fileIds.split('|');
		var ids=tmp[0];
		var status=tmp[1];
		var companyProductId=tmp[2];
		if(ids==null || ids=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		$.ajax({
		type : "POST",
		url : "AddSuppliers.do",
		dataType : "text",
		data : {
			"companyProductId":companyProductId
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			if(json.result="true")
			{
  				window.location.reload();
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					case "2":
					alert("请进行企业认证！");
				    window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
					break;
				}
			}
		}
		});
	};

	var toBargaining=function(){
		var fileIds=''; 
		$("input[name=priceSheetID]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0)
		{
			alert("请选择");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		var tmp=fileIds.split('|');
		var ids=tmp[0];
		var status=tmp[1];
		//alert(ids);
		//alert(status);
		if(ids==null || ids=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		if(status!='0')
		{
			alert("该订单已经议价，不能重复议价");
		}
		else
		{
			//------------------点击发起议价后按钮自灰
		    $("#bargin").attr('disabled',"true");
		    $("#bargin").css('background-color','#E3E3E3');	
			location.href = "toBargaining.do?ids="+ids;
		}
		
	};
	function AddOrder() {
	//ajax存入报价单
		var fileIds=''; 
		$("input[name=priceSheetID]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0)
		{
			alert("没有选择可以操作的项");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		var tmp=fileIds.split('|');
		var ids=tmp[0];
		var status=tmp[1];
		if(ids==null || ids=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		//---------------------------------点击确认提交后按钮自灰
		$("#confirm").attr('disabled',"true");
		$("#confirm").css('background-color','#E3E3E3');
		$.ajax({
		type : "POST",
		url : "AddOrder.do",
		dataType : "text",
		data : {
			"ids" : ids
		},
		success : function(data) {
		
			//提示	
			var json =eval('('+data+')');
			
			if(json.result="true")
			{
			//alert(json.orderId);
				//location.href = "deletePriceSheetInfo.do?id="+ids;
				location.href = "splitPriceSheet.do?id="+json.orderId;
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					case "2":
					alert("请进行企业认证！");
				    window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
								break;
							}
						}
					}
				});
	}
	$(function() {
		var flag = false; //标识生成分页时是否生成查询默认页商品
		var json = eval(
<%=json%>
	);
		$("#rows").html(json.rows);
		$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
			$("#Pagination").pagination(json.rows, { // 创建分页按钮
				current_page : json.currentPage - 1,
				num_edge_entries : 3, //边缘页数
				num_display_entries : 3, //主体页数
				callback : pageselectCallback,
				items_per_page : json.pageNum, //每页显示1项
				prev_text : "上一页",
				next_text : "下一页"
			});
		};
		function pageselectCallback(page_index, jq) { //此函数为分页动态按钮展现的回调函数，即分页展现商品
			var priceSheetId = $("#priceSheetId").val();
			var productName = $("#productName").val();
			var companyName = $("#companyName").val();
			var createDateStart = $("#createDateStart").val();
			var createDateStop = $("#createDateStop").val();
			var status = $("#status").val();
			var s = "";
			if (priceSheetId.length > 0) {
				s += "&&priceSheetId=" + priceSheetId;
			}
			if (productName.length > 0) {
				s += "&&productName=" + productName;
			}
			if (companyName.length > 0) {
				s += "&&companyName=" + companyName;
			}
			if (createDateStart.length > 0) {
				s += "&&createDateStart=" + createDateStart;
			}
			if (createDateStop.length > 0) {
				s += "&&createDateStop=" + createDateStop;
			}
			if (status.length > 0) {
				s += "&&status=" + status;
			}
			if (flag) {
				location.href = "myPriceSheet.do?currentPage="
						+ (page_index + 1) + s;
			}
			flag = true;
			return false;
		}
		initPagination();
	});

	function addProductSample(companyName, productName, supplierId,
			CompanyProductID, index) {

		if (confirm("申请信息如下：\n" + "供应商名称：" + companyName + "\n产品名称："
				+ productName)) {

			$.ajax({
				type : "POST",
				url : "checkProductSample.do",
				dataType : "text",
				data : {
					"supplierId" : supplierId,
					"CompanyProductID" : CompanyProductID,

				},
				success : function(data) {
					//提示	
					var json = eval('(' + data + ')');

					if (json.result > 0) {
						$("#productSample" + index).submit();
						$("#button1" + index).hide();
						$("#button2" + index).show();

					}
					if (json.result == "0" || json.result == "-1") {
						alert("三个月以内您已申请过！");
						$("#button1" + index).hide();
						$("#button2" + index).show();
					}
					if (json.result == "true") {
						$("#productSample" + index).submit();
						$("#button1" + index).hide();
						$("#button2" + index).show();
					}
					if (json.result == "false") {
						alert("参数出错");
					}
				},
				error : function(e) {
					alert("订单出错！");
				}

			});

		} else {
			alert("取消成功");
		}
	}
	//----------------------------------页面加载进度条
	$(document).ready(function() {
		var h = $(document).height();
		$(".overlay").css({
			"height" : h
		});
		$(".action").click(function() {
			$(".overlay").css({
				'display' : 'block',
				'opacity' : '0.8'
			});
			$(".showbox").stop(true).animate({
				'margin-top' : '300px',
				'opacity' : '1'
			}, 200);
			setTimeout(function() {
				$(".showbox").stop(true).animate({
					'margin-top' : '250px',
					'opacity' : '0'
				}, 400);
				$(".overlay").css({
					'display' : 'none',
					'opacity' : '0'
				});
			}, 800);
		});
	});
	//搜索条件的时间比较
	function changeExpectTime(id) {

		var time1 = $("#time1").val();
		var time2 = $("#time2").val();
		var date1 = new Date(Date.parse(time1));
		var date2 = new Date(Date.parse(time2));
		if (date1.getTime() > date2.getTime()) {

			alert("询价开始时间不得小于结束时间。");
			$("#time" + id).val("");
		}

	}
</script>
<style type="text/css">
.qrtj {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
}

.swmr {
	background-color: red;
	height: 30px;
	width: 120px;
	margin-left: 5%;
	font-size: 14px;
	color: white;
}

#fqyj {
	height: 25px;
	width: 100px;
	margin-left: 20px;
	font-size: 14px;
	color: white;
	background-color: #FB4949;
}

#t { /*background: #D0D0D0;*/
	
}

table {
	border: 1px solid #D0D0D0;
}

tr {
	height: 32px;
}
/* thead {
	border-top: 3px solid #D0D0D0;
}

td {
	float: left;
	height: 50px;
	line-height: 50px
} 

tbody {
	height: 50px;
}  */
table {
	font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, "宋体";
	border: 1px solid #f1f1f1;
	width: 100%;
	margin-top: 20px;
}

tr {
	width: 100%;
}

td {
	padding-left: 8px;
}

.span_name {
	color: #000;
	font-size: 12px;
}

.span_value {
	color: #4d4d4d;
	font-size: 12px;
}

.span_red {
	color: #FF5C4D;
	font-size: 12px;
}

.input_text {
	width: 115px;
	height: 20px;
}
/*------------商品状态---------------------------------*/
.span_zt {
	float: right;
	width: 80px;
	height: 24px;
	color: #fff;
	border-radius: 2px;
	font-size: 14px;
	line-height: 24px;
	text-align: center;
	margin: 4px 10px 0 0;
}
/*--------已完成-------------------*/
.zt_ywc {
	background-color: #89C24D;
}
/*--------未完成--------------------*/
.zt_wwc {
	background-color: #FF5C4D;
}
/*--------待处理--------------------*/
.zt_dcl {
	background-color: #FEBF18;
}
</style>
</head>

<body>
	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">询价管理 ></span><span
				class="lo2">我的报价单</span> <br /> <br />
		</div>
		<input type="hidden" id="priceSheetId" value="${priceSheetId}">
		<input type="hidden" id="productName" value="${productName}">
		<input type="hidden" id="companyName" value="${companyName}">
		<input type="hidden" id="createDateStart" value="${createDateStart}">
		<input type="hidden" id="createDateStop" value="${createDateStop}">
		<input type="hidden" id="status" value="${status}">
		<div
			style="border: 1px solid #D6D6D6; margin: 10px 0; padding: 10px 5px;">
			<form action="myPriceSheet.do" method="post">
				<b style="font-size: 16px;">报价单查询 </b> &nbsp;&nbsp;&nbsp; 订单号：<input
					type="text" style="height: 20px;" name="priceSheetId"
					value="${priceSheetId}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				询价日期：<input type="text" id="time1" name="createDateStart"
					onchange="changeExpectTime(1)" style="height: 20px;"
					value="${createDateStart}" readonly="readonly"
					onclick="WdatePicker()" />-<input type="text"
					name="createDateStop" style="height: 20px;"
					onchange="changeExpectTime(2)" value="${createDateStop}" id="time2"
					readonly="readonly" onclick="WdatePicker()" /> <br> <span
					style="margin-left: 118px;">供应商：</span><input type="text"
					name="companyName" style="height: 20px;" value="${companyName}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

				商&nbsp;&nbsp;&nbsp;&nbsp;品：<input type="text" name="productName"
					style="height: 20px;" value="${productName}">
				&nbsp;&nbsp;状态：<select name="status" type="text" id="status"
					style="height: 20px; width: 80px;">
					<option value="10"
						<c:if test="${status==10 }">selected="selected"</c:if>>全部</option>
					<option value="0"
						<c:if test="${status==0 }">selected="selected"</c:if>>报价开始</option>
					<option value="1"
						<c:if test="${status==1 }">selected="selected"</c:if>>报价结束</option>
					<option value="2"
						<c:if test="${status==2 }">selected="selected"</c:if>>议价中</option>
					<option value="3"
						<c:if test="${status==3 }">selected="selected"</c:if>>议价通过</option>
					<option value="4"
						<c:if test="${status==4 }">selected="selected"</c:if>>议价不通过</option>
					<option value="5"
						<c:if test="${status==5 }">selected="selected"</c:if>>报价失效</option>
				</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="orange"
					value="查询">
			</form>
			<c:if test="${empty priceSheet}">
				<script type="text/javascript">
			alert("查询结果为空,请重新输入！");
			</script>
			</c:if>
		</div>
		<c:if test="${!empty priceSheet}">



			<div>
				<table width="100%" border="0" cellspacing="0" align="center">

					<c:forEach items="${priceSheet}" var="c" varStatus="status">
						<tbody>
							<tr style="background-color: #FAFAFA;">

								<td colspan="7" style="height: 35px; line-height: 35px;"><p
										style="margin: 0; font-size: 14px; color: #2a2a2a;">
										<span style="float: left;">报价单编号：${c.PriceSheetID}</span>
										<c:choose>
											<c:when test="${c.Status==0}">
												<span class="span_zt zt_dcl" style="padding: 2px 5px;">报价开始</span>
											</c:when>
											<c:when test="${c.Status==1}">
												<span class="span_zt zt_ywc" style="padding: 2px 5px;">报价结束</span>
											</c:when>
											<c:when test="${c.Status==2}">
												<span class="span_zt zt_dcl" style="padding: 2px 5px;">议价中</span>
											</c:when>
											<c:when test="${c.Status==3}">
												<span class="span_zt zt_ywc" style="padding: 2px 5px;">议价通过</span>
											</c:when>
											<c:when test="${c.Status==4}">
												<span class="span_zt zt_wwc" style="padding: 2px 5px;">议价不通过</span>
											</c:when>
											<c:when test="${c.Status==5}">
												<span class="span_zt zt_wwc" style="padding: 2px 5px;">报价失效</span>
											</c:when>
										</c:choose>
									</p></td>


							</tr>
							<tr>
								<td colspan="7">&nbsp;</td>
							</tr>
							<tr>
								<td rowspan="3"><c:if test="${ c.Status==0 || c.Status==3}">
										<input type="radio" id="priceSheetID" name="priceSheetID"
											value="${c.ID}|${c.Status}|${c.CompanyProductID}" />
									</c:if></td>
								<td rowspan="3" style="width: 90px;"><c:if
										test="${c.productPic!=null && c.productPic!=''}">
										<div
											style="width: 79px; height: 64px; padding: 1px; border: 1px solid #d9d9d9;">
											<img style="width: 79px; height: 64px;"
												src="<%=path%>${c.productPic}">
										</div>
									</c:if></td>


								<td style="width: 241px;"><span class="span_name">报价产品：</span>
									<span class="span_value">${c.ProductName}</span></td>
								<td style="width: 101px;"><span class="span_name">规格：</span><span
									class="span_value">${c.ProductModel}</span></td>
								<td style="width: 101px;"><span class="span_name">单价：</span><span
									class="span_red">${c.UnitPrice}</span><span class="span_value">元</span>
								</td>
								<td style="width: 156px;"><span class="span_name">数量：</span><span
									class="span_value">${c.Quantity}</span></td>

								<td><span class="span_name">总额：</span><span
									class="span_red">${c.UnitPrice*c.Quantity}</span><span
									class="span_value">元</span></td>
							</tr>
							<tr>
								<td style="width: 241px;"><span class="span_name">供应商：</span><span
									class="span_value">${c.CompanyName}</span>
								<td colspan="2" style="width: 230px;"><span
									class="span_name">供应商电话：</span><span class="span_value">${c.CompanyTel}</span>
								</td>

								<%-- <td>${c.DeliveryDate}</td> --%>
								<td colspan="2"><a class="span_red"
									href="/GraduationDesign/merchant/productsCertificate.do?id=${c.ProductID}&&companyID=${c.CompanyID}">查看商品资质</a>
								</td>
							</tr>
							<tr>
								<td style="width: 241px;"><span class="span_name">报价日期：</span><span
									class="span_value"> <fmt:formatDate
											value="${c.CreateDate}" type="both" pattern="yyyy-MM-dd" />
								</span></td>

								<td colspan="2" style="width: 230px;"><span
									class="span_name">有效期至：</span><span class="span_value">
										<fmt:formatDate value="${c.ValidUntil}" type="both"
											pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" />
								</span></td>
								<td><span class="span_name">期望交期：</span><span
									class="span_value"> <jsp:useBean id="date"
											class="java.util.Date" /> <fmt:formatDate
											value="${c.DeliveryDate }" type="date" dateStyle="long"
											pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" />
								</span></td>
								<td><c:if test="${c.IsSample==1 }">
										<form id="productSample${status.index }"
											action="addProductSample.do" method="post">
											<input type="hidden" name="ids" value="${ids }" /> <input
												type="hidden" name="supplierId" value="${supplierId }" /> <input
												type="hidden" name="companyProductId"
												value="${c.CompanyProductID }" /> <input type="hidden"
												name="requestUnit" value="${c.ProductUnit }" /> <input
												type="hidden" name="requestNum" value="1" /> <input
												class="orange" type="button" value="申请小样"
												id="button1${status.index }"
												style="margin-right: 20%; width: 65px; height: 20px;"
												onclick="addProductSample('${c.CompanyName }','${c.ProductName}','${supplierId }','${c.CompanyProductID }','${status.index }')" />
											<input type="button" class="orange" value="已申请"
												id="button2${status.index }"
												style="display: none; float: right; margin-right: 20%; width: 65px; height: 20px;" />
											<!-- <script type="text/javascript">
											$(document).ready(
															function() {
																checkProductSample(
																		'${supplierId }',
																		'${c.CompanyProductID }','${status.index }');
															});
										</script> -->
										</form>
									</c:if></td>

							</tr>
							<tr>
								<td colspan="10" style="height: 20px;"></td>
							</tr>
						</tbody>

					</c:forEach>
				</table>
			</div>

			<!-- 分页 -->
			<div class="pagin">
				<!-- <div class="message">
					共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage"
						class="blue"></i>页
				</div> -->
				<div id="Pagination" class="meneame" style="clear: left"></div>

			</div>
			<%-- <div class="pagin">
				<div class="message">
					共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
				</div>
				<ul class="paginList">
					<c:choose>
						<c:when test="${page.currentPage==1}">
							<li class="paginItem current"><a href="#"><span
									class="pagepre"></span> </a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/GraduationDesign/merchant/myPriceSheet.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
									class="pagepre"></span> </a>
							</li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="1" end="${page.totalPage}" var="s3">
						<c:choose>
							<c:when test="${s3==page.currentPage}">
								<li class="paginItem current"><a href="#">${s3}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/GraduationDesign/merchant/myPriceSheet.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${page.currentPage==page.totalPage or s3<=10}">
							<li class="paginItem current"><a href="#"><span
									class="pagenxt"></span> </a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/GraduationDesign/merchant/myPriceSheet.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
									class="pagenxt"></span> </a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>

			</div> --%>
			<!-- <hr style="color: red;border: 1px solid;margin-top: 50px;" /> -->
			<br>
			<div class="demo" style="width: 100%; text-align: center;">
				<input type="button" value="确认提交" id="confirm"
					class="action qrtj orange" onclick="AddOrder()" /> <input
					type="button" id="bargin" value="发起议价" class="action qrtj orange"
					onclick="toBargaining()" /> <input type="hidden"
					value="点发起议价后会自动跳到议价单2进行议价，然后可以提交，">
			</div>
		</c:if>
	</div>

	<div class="overlay"></div>

	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord">
			<img src="<%=path%>/images/waiting.gif">加载中，请稍候...
		</div>
	</div>

	<div style="height: 1200px;"></div>



</body>
</html>
