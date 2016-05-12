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
	String roleName = request.getParameter("userRole");
	String json = (String) request.getAttribute("json");
	Integer userId = (Integer) request.getAttribute("userId");
%>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript">
	//封装供应商指定配送人('Supplier')和财务指定对账人('PurchaseFinancial')的json数据
	function jsonData(roleName,processResult,status){
		var jsonDatas="";
		$("input[name='dbID']:checked").each(function() {
				var ids = $(this).val();
				var dispatchBillId = $("#hdID_" + ids).val();
				var processContent=$("#processContent").val();
				jsonDatas += "{dispatchBillId:" +"'"+ dispatchBillId +"'"+",processContent:"+"'"+processContent+"'"+",processResult:"+processResult+",roleName:"+"'"+roleName+"'"+",status:"+status+"},";
		});
		jsonDatas = jsonDatas.substring(0, jsonDatas.length - 1);
		jsonDatas = '[' + jsonDatas + ']';
		return jsonDatas;
	}
	//封装财务('Accepter')的json数据
	function jsonDataAccepter(roleName,processResult,status){
		var jsonDatas="";
		$("input[name='dbID']:checked").each(function() {
				var ids = $(this).val();
				var dispatchBillId = $("#hdID_" + ids).val();
				var processContent=$("#processContent").val();
				jsonDatas += "{dispatchBillId:" +"'"+ dispatchBillId +"'"+",processContent:"+"'"+processContent+"'"+",processResult:"+processResult+",roleName:"+"'"+roleName+"'"+",status:"+status+"},";
		});
		jsonDatas = jsonDatas.substring(0, jsonDatas.length - 1);
		jsonDatas = '[' + jsonDatas + ']';
		return jsonDatas;
	}
	//验收人('Checker')的json数据
	function jsonDataChecker(roleName,processResult,status){
		var jsonDatas="";
		$("input[name='dbID']:checked").each(function() {
				var ids = $(this).val();
				var dispatchBillId = $("#hdID_" + ids).val();
				var processContent=$("#processContent").val();
				jsonDatas += "{dispatchBillId:" +"'"+ dispatchBillId +"'"+",processContent:"+"'"+processContent+"'"+",processResult:"+processResult+",roleName:"+"'"+roleName+"'"+",status:"+status+"},";
		});
		jsonDatas = jsonDatas.substring(0, jsonDatas.length - 1);
		jsonDatas = '[' + jsonDatas + ']';
		return jsonDatas;
	}
	
	//封装配送人'DeliveryUser'的json数据
	function jsonDataDeliveryUser(roleName,processResult,status){
		var jsonDatas="";
		$("input[name='dbID']:checked").each(function() {
				var ids = $(this).val();
				var dispatchBillId = $("#hdID_" + ids).val();
				var processContent=$("#processContent").val();
				jsonDatas += "{dispatchBillId:" +"'"+ dispatchBillId +"'"+",processContent:"+"'"+processContent+"'"+",processResult:"+processResult+",roleName:"+"'"+roleName+"'"+",status:"+status+"},";
		});
		jsonDatas = jsonDatas.substring(0, jsonDatas.length - 1);
		jsonDatas = '[' + jsonDatas + ']';
		return jsonDatas;
	}
	

	//添加审计流程日志信息
	var insertWorkFlowLogs=function(jsonDatas){
		$.ajax({
			type : "POST",
			url : "addWorkFlowLogs.do",
			dataType : "text",
			data : {
				"jsonDatas" : jsonDatas
			},
			success : function(data) {
				//提示	
				var json =eval('(' + data + ')');
				var roleName ="${userRole}";
				if(json.result="true")
				{				
					switch (roleName) {
						case 'Supplier':
						location.href = "myDispatchBillToSupplier.do";		
						break;
						case 'PurchaseFinancial':
						location.href = "myDispatchBillToFinancial.do";		
						break;
						case 'Accepter':
						location.href = "myDispatchBillToAccepter.do";		
						break;
						case 'DeliveryUser':
						location.href = "myDispatchBillToDeliveryUser.do";		
						break;
						case 'Checker':
						location.href = "myDispatchBillToChecker.do";		
						break;
					}								
				}else{
					switch(json.result)
					{
						case "1":
						alert("请先登录！");
				    	window.location.href= "<%=path%>/web/toLogin.do";			
						break;
						default:
						switch (roleName) {
							case 'Supplier':
							location.href = "myDispatchBillToSupplier.do";		
							break;
							case 'PurchaseFinancial':
							location.href = "myDispatchBillToFinancial.do";		
							break;
						}	
						break;
					}
				}
			}
		});
	}

	var editDispatchBillUser = function(processResult,user,ids,status) {
		$.ajax({
		type : "POST",
		url : "editDispatchBillUser.do",
		dataType : "text",
		data : {
			"user" : user,
			"ids":ids,
			"status":status
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			var roleName ="${userRole}";
			if(json.result="true")
			{	
				var jsonDatas=null;				
				switch (roleName) {
					case 'Supplier':
					jsonDatas=jsonData(roleName,processResult,status);
					insertWorkFlowLogs(jsonDatas);
					//location.href = "myDispatchBillToSupplier.do";		
					break;
					case 'PurchaseFinancial':
					jsonDatas=jsonData(roleName,processResult,status);
					insertWorkFlowLogs(jsonDatas);
					//location.href = "myDispatchBillToFinancial.do";		
					break;
				}								
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					default:
					switch (roleName) {
						case 'Supplier':
						location.href = "myDispatchBillToSupplier.do";		
						break;
						case 'PurchaseFinancial':
						location.href = "myDispatchBillToFinancial.do";		
						break;
					}	
					break;
				}
			}
		}
	 });
	}
	var editPackagesNumber=function(roleName,processResult,PackagesNum,status)
	{
		$.ajax({
		type : "POST",
		url : "EditPackagesNumber.do",
		dataType : "text",
		data : {
			"PackagesNum" : PackagesNum
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			if(json.result="true")
			{
					var jsonDatas=jsonDataDeliveryUser(roleName,processResult,status);
					insertWorkFlowLogs(jsonDatas);
					//location.href = "myDispatchBillToDeliveryUser.do";				
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					default:
						location.href = "myDispatchBillToDeliveryUser.do";			
					break;
				}
			}
		}
	});
	};
	var EditDispatchBillStatus=function(processResult,fileIds,status)
	{
		$.ajax({
		type : "POST",
		url : "EditDispatchBillStatus.do",
		dataType : "text",
		data : {
			"status":status,
			"fileIds":fileIds
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			var roleName ="${userRole}";
			if(json.result="true")
			{
				var jsonDatas=null;
				switch (roleName) {
					case 'Accepter':
					jsonDatas=jsonDataAccepter(roleName,processResult,status);
					insertWorkFlowLogs(jsonDatas);
					//location.href = "myDispatchBillToAccepter.do";	
					break;
					case 'Checker':
					jsonDatas=jsonDataChecker(roleName,processResult,status);
					insertWorkFlowLogs(jsonDatas);
					//location.href = "myDispatchBillToChecker.do";	
					break;
					case 'DeliveryUser':
					jsonDatas=jsonDataDeliveryUser(roleName,processResult,status);
					insertWorkFlowLogs(jsonDatas);
					//location.href = "myDispatchBillToDeliveryUser.do";
					break;
				}			
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";
						break;
					default:
						switch (roleName) {
						case 'Accepter':
							location.href = "myDispatchBillToAccepter.do";
							break;
						case 'Checker':
							location.href = "myDispatchBillToChecker.do";
							break;
						case 'DeliveryUser':
							location.href = "myDispatchBillToDeliveryUser.do";
							break;
						}
						break;
					}
				}
			}
		});
	};
	function reject() {
		//返回：处理结果为 0
		var processResult = 0;
		var roleName = "${userRole}";
		var fileIds = getId();
		//alert("reject:"+roleName);
		switch (roleName) {
		/* 	case 'Supplier'://供应商设置配送人
			
				EditDispatchBillStatus(fileIds, 0);
				break; */
		/* 	case 'PurchaseFinancial'://财务经理指定财务对账人
			
				EditDispatchBillStatus(fileIds, 0);
				break; */
		case 'DeliveryUser'://2
			EditDispatchBillStatus(processResult, fileIds, 0);
			break;
		case 'Accepter'://5

			EditDispatchBillStatus(processResult, fileIds, 4);
			break;
		case 'Checker'://3
			EditDispatchBillStatus(processResult, fileIds, 2);
			break;
		}
	}
	var submit = function() {
		//提交：处理结果为 1
		var processResult = 1;
		var roleName = "${userRole}";
		var fileIds = "";
		//alert("submit:"+roleName);
		switch (roleName) {
		case 'Supplier'://供应商设置配送人
			var user = $("#sUser").val();
			fileIds = getId();
			editDispatchBillUser(processResult, user, fileIds, 2);
			$("#btnSub").attr('disabled', "true");
			$("#btnSub").css('background-color', '#E3E3E3');
			break;
		case 'PurchaseFinancial'://财务经理指定财务对账人
			var user = $("#sUser").val();
			fileIds = getId();
			editDispatchBillUser(processResult, user, fileIds, 5);
			$("#btnSub").attr('disabled', "true");
			$("#btnSub").css('background-color', '#E3E3E3');
			break;
		case 'DeliveryUser'://配送填写实收数据
			var tmpmsg = "";
			$("input[name='dbID']:checked").each(function() {

				var ids = $(this).val();
				var num = $("#txtPackagesNumber" + ids).val();
				var dispatchBillId = $("#hdID_" + ids).val();
				fileIds += "{id:" + ids + ",num:" + num + "},";
				var checknum = new RegExp("^[0-9]+(.[0-9]{2})?$");
				;
				if (num == null || num == 0 || checknum.test(num) == false) {
					tmpmsg += "[" + dispatchBillId + ":请填写实收数据]";
				}
			});
			if (tmpmsg != "") {
				alert(tmpmsg);
			} else {
				fileIds = fileIds.substring(0, fileIds.length - 1);
				fileIds = '[' + fileIds + ']';
				//alert(fileIds);
				editPackagesNumber(roleName, processResult, fileIds, 3);
				$("#btnSub").attr('disabled', "true");
				$("#btnSub").css('background-color', '#E3E3E3');
			}
			break;
		case 'Accepter'://财务审核人员
			fileIds = getId();
			EditDispatchBillStatus(processResult, fileIds, 6);
			$("#btnSub").attr('disabled', "true");
			$("#btnSub").css('background-color', '#E3E3E3');
			break;
		case 'Checker'://验收人员验收
			fileIds = getId();
			EditDispatchBillStatus(processResult, fileIds, 4);
			$("#btnSub").attr('disabled', "true");
			$("#btnSub").css('background-color', '#E3E3E3');
			break;
		}
	};
	//用于获取商品的商品id
	function getId() {
		var fileIds = "";
		var dispatchBillIds = "";
		$("input[name='dbID']:checked").each(function() {
			var ids = $(this).val();
			fileIds += ids + ",";
		});
		fileIds = fileIds.substring(0, fileIds.length - 1);
		if (fileIds.length <= 0) {
			alert("请选择要处理的单据");
			return;
		}
		return fileIds;
	}

	function checkAll() {
		var ischecked = document.getElementById("checkAll").checked;
		if (ischecked) {
			checkallbox();
		} else {
			discheckallbox();
		}
	}
	function checkallbox() {
		var boxarray = document.getElementsByName("dbID");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = true;
		}
	}
	function discheckallbox() {
		var boxarray = document.getElementsByName("dbID");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = false;
		}
	}
	function checkBox() {
		var checkObjs1 = $(":checkbox[name='dbID']:checked");
		var checkObjs2 = $(":checkbox[name='dbID']");
		if (checkObjs1.length == checkObjs2.length) {
			document.getElementById("checkAll").checked = true;
		} else {
			document.getElementById("checkAll").checked = false;
		}
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
			var orderCode = $("#orderCode1").val();
			var productName = $("#productName1").val();
			var supplierName = $("#supplierName1").val();
			var status = $("#status1").val();
			
			var s = "";
			if (orderCode.length > 0) {
				s += "&&orderCode=" + orderCode;
			}
			if (productName.length > 0) {
				s += "&&productName=" + productName;
			}
			if (supplierName.length > 0) {
				s += "&&supplierName=" + supplierName;
			}
			if (status.length > 0) {
				s += "&&status=" + status;
			}
			if (flag) {
				var controllers = "";
				switch (
<%=roleName%>
	) {
				case "PurchaseUser":
					controllers = "myDispatchBill.do";
				case "PurchaseCompany":
					controllers = "myDispatchBillToCompany.do";
				case "PurchaseFinancial":
					controllers = "myDispatchBillToFinancial.do";
				case "PurchaseDepart":
					controllers = "myDispatchBillToDepart.do";
				case "Supplier":
					controllers = "myDispatchBillToSupplier.do";
				case "Checker":
					controllers = "myDispatchBillToChecker.do";
				case "DeliveryUser":
					controllers = "myDispatchBillToDeliveryUser.do";
				case "Accepter":
					controllers = "myDispatchBillToAccepter.do";
				}
				location.href = controllers + "?currentPage="
						+ (page_index + 1) + "&&userId=" +
<%=userId%>
	+ s;
			}
			flag = true;
			return false;
		}
		initPagination();
	});
	//页面加载进度条
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
</script>
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
	background: #fafafa;
}

tbody {
	border: 1px solid #fafafa;
}

tr {
	height: 30px;
}

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
			<c:choose>
				<c:when test="${userRole=='PurchaseUser'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">我的验收单</span>
				</c:when>
				<c:when test="${userRole=='Checker'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">配送单验收</span>
				</c:when>
				<c:when test="${userRole=='Accepter'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">配送单审核</span>
				</c:when>
				<c:when test="${userRole=='PurchaseFinancial'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">对账指派</span>
				</c:when>
				<c:when test="${userRole=='PurchaseDepart'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">部门验收单</span>
				</c:when>
				<c:when test="${userRole=='PurchaseCompany'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">公司验收单</span>
				</c:when>
				<c:when test="${userRole=='Supplier'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">订单配送处理</span>
				</c:when>
				<c:when test="${userRole=='DeliveryUser'}">
					<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span>
					<span class="lo2">订单实收处理</span>
				</c:when>
			</c:choose>
			<br /> <br />
		</div>
		<div>
			<!-- 验收单查询 （开始）-->
			<c:if
				test="${userRole=='PurchaseUser'||userRole=='PurchaseCompany'||userRole=='PurchaseDepart'}">
				<div
					style="border: 1px solid #D6D6D6; margin: 5px 0; height: 80px; line-height: 40px;">
					<input type="hidden" id="orderCode1" value="${orderCode }" /> <input
						type="hidden" id="productName1" value="${productName }" /> <input
						type="hidden" id="supplierName1" value="${supplierName }" /> <input
						type="hidden" id="status1" value="${status }" />
					<c:if test="${userRole=='PurchaseUser'}">
						<form action="myDispatchBill.do" method="post">
					</c:if>

					<c:if test="${userRole=='PurchaseCompany'}">
						<form action="myDispatchBillToCompany.do" method="post">
					</c:if>
					<c:if test="${userRole=='PurchaseDepart'}">
						<form action="myDispatchBillToDepart.do" method="post">
					</c:if>
					<span style="margin-left: 15px; font-size: 18px;">验收单查询</span>&nbsp;&nbsp;&nbsp;&nbsp;
					订单号：<input name="orderCode" style="height: 20px; width: 160px;"
						type="text" id="orderCode" value="${orderCode }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商品：<input
						name="productName" type="text" style="height: 20px; width: 160px;"
						id="productName" value="${productName }" /><br /> <span
						style="margin-left: 133px;">供应商：</span><input name="supplierName"
						type="text" id="supplierName" value="${supplierName }"
						style="height: 20px; width: 160px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：<select
						name="status" type="text" id="status"
						style="height: 20px; width: 65px;">
						<option value="10"
							<c:if test="${status==10 }">selected="selected"</c:if>>全部</option>
						<option value="0"
							<c:if test="${status==0 }">selected="selected"</c:if>>未配送</option>
						<option value="1"
							<c:if test="${status==1 }">selected="selected"</c:if>>已对账</option>
						<option value="2"
							<c:if test="${status==2 }">selected="selected"</c:if>>已配送</option>
						<option value="3"
							<c:if test="${status==3 }">selected="selected"</c:if>>未验收</option>
						<option value="4"
							<c:if test="${status==4 }">selected="selected"</c:if>>已验收</option>
						<option value="5"
							<c:if test="${status==5 }">selected="selected"</c:if>>未审核</option>
						<option value="6"
							<c:if test="${status==6 }">selected="selected"</c:if>>已审核</option>
					</select><span style="margin-left: 100px;"><input name="submitButton"
						class="orange" type="submit" id="submitButton" value="查询" /></span>
					</form>
				</div>

			</c:if>
			<!-- 验收单查询 （结束）-->
			<c:if test="${empty dispatchBill}">
				<script type="text/javascript">
			alert("查询结果为空,请重新输入！");
			</script>
			</c:if>
		</div>
		<c:if test="${!empty dispatchBill}">


			<table width="100%" cellspacing="1" align="center">
				<tr>
					<td><c:if
							test="${userRole=='DeliveryUser' || userRole=='Checker'|| userRole=='Accepter'||
							userRole=='Supplier'||userRole=='PurchaseFinancial'}">
							<input type="checkbox" id="checkAll" onclick="checkAll();" />全选
						</c:if></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tbody>
					<c:forEach items="${dispatchBill}" var="c">
						<tr style="background-color: #FAFAFA;">
							<td colspan="5" style="height: 35px; line-height: 35px;"><p
									style="margin: 0; font-size: 14px; color: #2a2a2a;">
									<span style="float: left;">订单号:${c.orderCode} </span><span
										style="float: left; margin-left: 50px;">配送单号:${c.dispatchBillId}</span>
								</p></td>
							<td style="text-align: center;"><c:choose>
									<c:when test="${c.status==0}">
										<span class="span_zt zt_dcl" style="padding: 2px 5px;">未配送</span>
									</c:when>
									<c:when test="${c.status==1}">
										<span class="span_zt zt_ywc" style="padding: 2px 5px;">已对账</span>
									</c:when>
									<c:when test="${c.status==2}">
										<span class="span_zt zt_ywc" style="padding: 2px 5px;">已配送</span>
									</c:when>
									<c:when test="${c.status==3}">
										<span class="span_zt zt_wwc" style="padding: 2px 5px;">未验收</span>
									</c:when>
									<c:when test="${c.status==4}">
										<span class="span_zt zt_ywc" style="padding: 2px 5px;">已验收</span>
									</c:when>
									<c:when test="${c.status==5}">
										<span class="span_zt zt_wwc" style="padding: 2px 5px;">未审核</span>
									</c:when>
									<c:when test="${c.status==6}">
										<span class="span_zt zt_ywc" style="padding: 2px 5px;">已审核</span>
									</c:when>
								</c:choose></td>
						</tr>
						<tr>
							<td colspan="">&nbsp;</td>
						</tr>
						<tr>
							<td rowspan="4" style="width: 150px;">&nbsp;&nbsp;<c:if
									test="${userRole=='DeliveryUser' || userRole=='Checker'|| 
								userRole=='Accepter'||userRole=='Supplier'||userRole=='PurchaseFinancial'}">
									<input type="checkbox" name="dbID" id="dbID" value="${c.id }"
										onclick="checkBox()" />
									<input type="hidden" name="hdID" id="hdID_${c.id }"
										value="${c.dispatchBillId }" />
									<input type="hidden" name="accepterId" id="accepterId_${c.id }"
										value="${c.accepter }" />
									<input type="hidden" name="checkerId" id="checkerId_${c.id }"
										value="${c.checkUser}" />
									<input type="hidden" name="deliveryUserId"
										id="deliveryUserId_${c.id }" value="${c.deliveryUser}" />
										&nbsp;&nbsp;
								</c:if> <c:if test="${c.productPic!=null && c.productPic!=''}">
									<div
										style="display: inline-block; width: 106px; height: 95px; padding: 1px; border: 1px solid #d9d9d9;">
										<img style="width: 106px; height: 95px;"
											src="<%=path%>${c.productPic}" />
									</div>
								</c:if></td>
							<td colspan="2"><span class="span_name">商品名称：</span><span
								class="span_value">${c.productName}</span></td>
							<td colspan="2"><span class="span_name">供应商：</span><span
								class="span_value">${c.supplierName}</span></td>
						</tr>
						<tr>
							<td style="width: 170px;"><span class="span_name">规格：</span><span
								class="span_value">${c.productModel }</span></td>
							<td style="width: 160px;"><span class="span_name">单价：</span><span
								class="span_red">${c.unitPrice}</span><span class="span_value">元</span>
							</td>
							<td style="width: 180px;"><c:if
									test="${userRole=='Supplier'||
						userRole=='DeliveryUser'||
						userRole=='PurchaseUser'|| 
						userRole=='PurchaseCompany'||
						userRole=='PurchaseDepart'}">
									<span class="span_name">配送人：</span>
									<span class="span_value">${c.deliveryUserName}</span>
								</c:if></td>
							<td colspan="2"><c:if
									test="${userRole=='Supplier'||
						userRole=='DeliveryUser'||
						userRole=='PurchaseUser'|| 
						userRole=='PurchaseCompany'||
						userRole=='PurchaseDepart'}">
									<span class="span_name">配送时间：</span>
									<span class="span_value"> <jsp:useBean id="date"
											class="java.util.Date" /> <fmt:formatDate
											value="${c.deliveryTime}" type="date" dateStyle="long"
											pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" />
									</span>
								</c:if></td>


						</tr>
						<tr>
							<td><span class="span_name">购买数量：</span><span
								class="span_value">${c.purchaseQuantity}${c.productUnit}</span>
							</td>
							<td><span class="span_name">实收数量：</span><span
								class="span_value"> <c:if
										test="${userRole!='DeliveryUser'}">
							${c.packagesNumber}${c.productUnit}
						</c:if> <c:if test="${userRole=='DeliveryUser'}">
										<input type="text" style="width: 35%"
											id="txtPackagesNumber${c.id}" value="${c.packagesNumber}" />${c.productUnit}
						</c:if>
							</span></td>
							<td><c:if
									test="${userRole=='Checker'||
										userRole=='PurchaseUser'|| 
										userRole=='PurchaseCompany'||
										userRole=='PurchaseDepart'}">
									<span class="span_name">验收人：</span>
									<span class="span_value">${c.checkUserName}</span>
								</c:if></td>
							<td colspan="2"><c:if
									test="${userRole=='Checker'||
										userRole=='PurchaseUser'|| 
										userRole=='PurchaseCompany'||
										userRole=='PurchaseDepart'}">
									<span class="span_name">验收时间：</span>
									<span class="span_value"> <fmt:formatDate
											value="${c.checkTime}" type="date" dateStyle="long"
											pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" />
									</span>
								</c:if></td>

						</tr>
						<tr>
							<td><span class="span_name">总额：</span><input
								id="textAmount${c.id}" value="${c.amount}" type="hidden" /><span
								class="span_red">${c.amount}</span></td>
							<td><a
								href="<%=path%>/merchant/processContentInfo.do?dispatchBillId=${c.dispatchBillId}"
								style="color: red;">查看审核信息</a></td>
							<td><c:if
									test="${userRole=='Accepter'||
							userRole=='PurchaseFinancial'||
							userRole=='PurchaseUser'|| 
							userRole=='PurchaseCompany'||
							userRole=='PurchaseDepart'}">
									<%-- 仓储:${c.storageName} --%>
									<span class="span_name">对账人：</span>
									<span class="span_value">${c.accepterUserName}</span>
								</c:if></td>
							<td colspan="2"><c:if
									test="${userRole=='Accepter'||
							userRole=='PurchaseFinancial'||
							userRole=='PurchaseUser'|| 
							userRole=='PurchaseCompany'||
							userRole=='PurchaseDepart'}">
									<%-- 仓储:${c.storageName} --%>
									<span class="span_name">对账时间：</span>
									<span class="span_value"> <fmt:formatDate
											value="${c.acceptTime}" type="date" dateStyle="long"
											pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" />
									</span>
								</c:if></td>


						</tr>
						<tr>
							<td colspan="6"><span class="span_name">配送地址：</span><span
								class="span_value">${c.shoppingAddressName}</span></td>
						</tr>
						<tr style="border-bottom: 3px solid #fafafa;">
							<td colspan="6">&nbsp;</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagin" style="float: none;">
				<!-- 分页 -->
				<div class="pagin">
					<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
					<div id="Pagination" class="meneame" style="clear: left"></div>
				</div>
				<%-- <div class="message">
					共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
				</div>
				<div style="width: 880px; height: 32px;">
					<ul class="paginList">
						<c:choose>
							<c:when test="${page.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><strong><a
										href='/GraduationDesign/merchant/<c:choose>
								<c:when test="${userRole=='PurchaseUser'}">
								myDispatchBill.do
								</c:when>
								<c:when test="${userRole=='PurchaseCompany'}">
								myDispatchBillToCompany.do
								</c:when>
								<c:when test="${userRole=='PurchaseFinancial'}">
								myDispatchBillToFinancial.do
								</c:when>
								<c:when test="${userRole=='PurchaseDepart'}">
								PurchaseDepart.do
								</c:when>
								<c:when test="${userRole=='Supplier'}">
								myDispatchBillToSupplier.do
								</c:when>
								<c:when test="${userRole=='Checker'}">
								myDispatchBillToChecker.do
								</c:when>
								<c:when test="${userRole=='DeliveryUser'}">
								myDispatchBillToDeliveryUser.do
								</c:when>
								<c:when test="${userRole=='Accepter'}">
								myDispatchBillToAccepter.do
								</c:when>
								</c:choose>?currentPage=${page.currentPage-1}&amp;&amp;userId=${userId}'><span
											class="pagepre"></span> </a>
								</strong><br>
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
										href="/GraduationDesign/merchant/<c:choose>
								<c:when test="${userRole=='PurchaseUser'}">
								myDispatchBill.do
								</c:when>
								<c:when test="${userRole=='PurchaseCompany'}">
								myDispatchBillToCompany.do
								</c:when>
								<c:when test="${userRole=='PurchaseFinancial'}">
								myDispatchBillToFinancial.do
								</c:when>
								<c:when test="${userRole=='PurchaseDepart'}">
								PurchaseDepart.do
								</c:when>
								<c:when test="${userRole=='Supplier'}">
								myDispatchBillToSupplier.do
								</c:when>
								<c:when test="${userRole=='Checker'}">
								myDispatchBillToChecker.do
								</c:when>
								<c:when test="${userRole=='DeliveryUser'}">
								myDispatchBillToDeliveryUser.do
								</c:when>
								<c:when test="${userRole=='Accepter'}">
								myDispatchBillToAccepter.do
								</c:when>
								</c:choose>?currentPage=${s3}&&userId=${userId}">${s3}</a>
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
									href="/GraduationDesign/merchant/<c:choose>
								<c:when test="${userRole=='PurchaseUser'}">
								myDispatchBill.do
								</c:when>
								<c:when test="${userRole=='PurchaseCompany'}">
								myDispatchBillToCompany.do
								</c:when>
								<c:when test="${userRole=='PurchaseFinancial'}">
								myDispatchBillToFinancial.do
								</c:when>
								<c:when test="${userRole=='PurchaseDepart'}">
								PurchaseDepart.do
								</c:when>
								<c:when test="${userRole=='Supplier'}">
								myDispatchBillToSupplier.do
								</c:when>
								<c:when test="${userRole=='Checker'}">
								myDispatchBillToChecker.do
								</c:when>
								<c:when test="${userRole=='DeliveryUser'}">
								myDispatchBillToDeliveryUser.do
								</c:when>
								<c:when test="${userRole=='Accepter'}">
								myDispatchBillToAccepter.do
								</c:when>
								</c:choose>?currentPage=${page.currentPage+1}&&userId=${userId}"><span
										class="pagenxt"></span> </a> <br></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>	 --%>
				<div style="width: 300px; margin-left: 120px; margin-top: 20px;">

					<c:if test="${userRole=='Supplier'||userRole=='PurchaseFinancial'}">
						<b style="float: left;">指派操作人：</b>&nbsp;&nbsp;
						 <select id="sUser" style="width: 200px; height: 20px;">
							<c:forEach items="${users}" var="user">
								<c:if test="${user.status=='1'}">
									<option value="${user.id }">${user.userName}(${user.userCode})</option>
								</c:if>
							</c:forEach>
						</select>
					</c:if>
					<br /> <br />
					<c:if
						test="${userRole=='DeliveryUser' || userRole=='Checker'|| userRole=='Accepter'||userRole=='Supplier'||userRole=='PurchaseFinancial'}">

						<b style="float: left;">备注信息：</b>
						<br />
						<br />
						<textarea
							style="float: left; width: 600px; height: 150px; line-height: 2; resize: none;"
							id="processContent"></textarea>
						<br />
						<input style="width: 70px; height: 20px; margin: 10px 20px;"
							type="button" class="action orange" id="btnSub"
							onclick="submit()" value="提交" />
						<c:if
							test="${userRole=='Checker' ||userRole=='DeliveryUser'|| userRole=='Accepter'}">
							<input style="width: 70px; height: 20px;" type="button"
								class="orange" id="btnReturn" onclick="reject()" value="退回" />
						</c:if>
					</c:if>
				</div>
			</div>
		</c:if>
	</div>
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
