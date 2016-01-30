<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/wjmm.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/redcss/jindutiao.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">

	//获取选中box的ID
	function getId() {
		var ids = '';
		$('input[name="box"]:checked').each(function() {			
			ids += $(this).val() + ",";
		});
		//判断账单是否对过账，已对账的才能结算
		ids = ids.substring(0, ids.length - 1);
		//alert(ids);
		return ids;
	}
	/* 
	 function checkAll(){
	 var ischecked=document.getElementById("checkAll").checked;
	 if(ischecked){
	 checkallbox();
	 }else{
	 discheckallbox();
	 }
	 }
	 function checkallbox(){
	 var boxarray = document.getElementsByName("box");
	 for(var i = 0; i < boxarray.length; i++) { 
	 boxarray[i].checked = true;
	 }
	 }
	 function discheckallbox() { 
	 var boxarray = document.getElementsByName("box"); 
	 for(var i = 0; i < boxarray.length; i++) { 
	 boxarray[i].checked = false;
	 }
	 }
	 function checkBox(){
	
	 var checkObjs1 = $(":checkbox[name='box']:checked");
	 var checkObjs2 = $(":checkbox[name='box']");
	 if(checkObjs1.length==checkObjs2.length) {
	 document.getElementById("checkAll").checked=true;
	 }else{
	 document.getElementById("checkAll").checked=false;
	 }
	 } */

	function querenduizhang() {
		var fileIds = getId();
		if (fileIds==null ||
			fileIds.length == 0) {
			alert("请选择要操作的条目");
			return;
		}
		var st = $("#st"+fileIds).val();
		var ss = $("#ss"+fileIds).val();
		if(st == 2){
			if(ss == 2){
				alert("尚未申请发票");
			}else{
				alert("发票尚未寄出");
			}
		}
		/* fileIds = fileIds.substring(0, fileIds.length - 1); */
		$.ajax({
			type : "POST",
			url : "/ssm/merchant/reconciliation.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			dataType : "text",
			data : {
				ids : fileIds
			},
			success : function(data) {
			//----------------------点击确认对账后该按钮自灰
			$("#conf").attr('disabled',"true");
			$("#conf").css('background-color','#E3E3E3');
				var json = eval('(' + data + ')');
				if (json.result == "true") {
					//$("#cb").html(json.companyBalance);
					location.href = "financeInfo.do";			
				}
			}
		});
	}

	function pay() {
		var fileIds = getId();
		$.ajax({
			type : "POST",
			url : "iWantPay.do",
			data : {
				"ids" : fileIds
			},
			success : function(data) {
				var json = eval('(' + data + ')');
				if (json.result == "true") {
					//$("#cb").html(json.companyBalance);
					/* if(json.status == 0){
						alert("请先对账");
					}else{ */
					location.href = "statement.do?fileIds=" + fileIds;
					/* } */
				}
			}
		});
	}
	
/* 	//---------------------弹出窗口
	function openwin(statementId,settleAmount) {
	window.open ("toApplyForInvoice.do?statementId="+statementId+"&&settleAmount="+settleAmount,"width=500","height=300","top=0")
	} */
	//--------------------------------------发票签收
	function sign(tmpStatementId){
		location.href="buyerInvoiceSign.do?tmpStatementId="+tmpStatementId;
	}
	//----------------------------------------发票寄出
	function send(tmpStatementId){
		location.href="invoiceSendOut.do?tmpStatementId="+tmpStatementId;
	}
	
	function queren(tmpInvoiceType,tmpInvoiceTitle,tmpAmount,tmpCompanyId,tmpStatementId){
	var invoiceType = $("input[name=invoiceType]:checked").val();
	var title = $("#titleValue option:selected").val();
	var title2 = $("#titleValue2").val();
	if(invoiceType == null){
		alert("请选择发票类型");
		return;
	}
	if((title == null || title == "") && (title2 == null || title2 == "")){
		alert("发票抬头不能为空");
		return;
	}
	location.href="applyForInvoice.do?tmpInvoiceType="+tmpInvoiceType +"&&tmpInvoiceTitle="+encodeURI(encodeURI(tmpInvoiceTitle))+"&&tmpAmount="+tmpAmount+"&&tmpCompanyId="+tmpCompanyId+"&&tmpStatementId="+tmpStatementId;
	}
	
	function apply(){
		var fileIds = getId();
		if (fileIds==null ||
			fileIds.length == 0) {
			alert("请选择要操作的条目");
			return;
		}
		var st = $("#st"+fileIds).val();
		var at = $("#at"+fileIds).val();
		$("#statementId").text(fileIds);
		$("#amount").text(-at);
		if(st == 5){
			alert("已申请过发票");
			return;
		}
		$("#shenqing").toggle();
		
		//------------------------点击申请发票后该按钮自灰
		$("#apply").attr('disabled',"true");
	    $("#apply").css('background-color','#E3E3E3');
	}
	
	//------------查看发票
	function show(statementId,status){
		location.href="seeInvoice.do?statementId="+statementId;
	}
//页面加载进度条
$(document).ready(function(){
	var h = $(document).height();
	$(".overlay").css({"height": h });	
	$(".action").click(function(){	
		$(".overlay").css({'display':'block','opacity':'0.8'});		
		$(".showbox").stop(true).animate({'margin-top':'300px','opacity':'1'},200);		
		setTimeout(function(){			
			$(".showbox").stop(true).animate({'margin-top':'300px','opacity':'0'},400);			
			$(".overlay").css({'display':'none','opacity':'0'});			
		},800);		
	});	
});	
//--------------添加发票抬头
function addTitle(companyId,title){
	alert("添加成功，请重新申请发票");
	location.href = "addTitle.do?companyId="+companyId+"&&title="+encodeURI(encodeURI(title));
}
</script>

<style type="text/css">
tr {
	height: 35px;
}

td {
	/* text-align:center; */
	border-left: 1px solid #D0D0D0;
}

th {
	border-left: 1px solid #D0D0D0;
}

#shenqing {
	display: none;
	margin-left: 20%;
	margin-top: 50px;
}

#chakan {
	display: none;
}

.ck {
	font-size: 14px;
	color: white;
	height: 30px;
	margin-left: 15%;
	margin-top: 10px;
}

#shenqing table tr td {
	font-size: 16px;
	border: 0;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">结算管理 ></span><span
				class="lo2">对账单</span>
		</div>
		<div>
			<%-- 本次对账金额:${companyBalance}&nbsp;&nbsp;&nbsp;&nbsp; --%>
			<!-- <input style="color: red;text-align:right;font-size: 18px;" type="text" name="settleAmount" id="pay" value=""/>
			&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="我要付款" onclick="pay();"/>
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><input type="button" value="我要提现"/></a> -->
			<input type="hidden" name="settlement" value="" id="settlement" />
		</div>
		<br />
		<h1 align="center">
			<b>对&nbsp;&nbsp;账&nbsp;&nbsp;单</b>
		</h1>
		<div>
			<table width="100%" cellspacing="0" align="center">
				<thead style="border: 1px solid #D0D0D0">
					<tr style="background-color: #f1f1f1;">
						<th style="display: none">ID</th>
						<th style="display: none">公司ID</th>
						<th>请选择</th>
						<th>账单时间</th>
						<th>币种</th>
						<th>账单金额</th>
						<th>折扣</th>
						<th>结算金额</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody style="border: 1px solid #D0D0D0">

					<c:forEach items="${cbs}" var="c">
						<tr>
							<td style="display: none">${c.id}</td>
							<td style="display: none">${c.companyId}</td>
							<td align="center"><c:if
									test="${c.status==5 ||c.status == 2}">
									<input type="radio" name="box" value="${c.id}" />
								</c:if></td>
							<td align="center"><fmt:formatDate value="${c.startTime}"
									pattern="yyyy-MM-dd" /></td>
							<td align="center"><input id="ct${c.id}" type="hidden"
								value="${c.currency}" /> ${c.currency}</td>
							<td align="right">${c.amount}</td>
							<td align="right">${c.discount}</td>
							<td align="right"><input id="at${c.id}" type="hidden"
								value="${c.settledAmount}" />${c.settledAmount}</td>
							<td name="status" align="center"><input type="hidden"
								id="st${c.id}" value="${c.status}" /> <input type="hidden"
								id="ss${c.id}" value="${c.stateType}" /> <c:choose>
									<c:when test="${c.status==0}">未对账</c:when>
									<c:when test="${c.status==1}">已对账</c:when>
									<c:when test="${c.status==2}">系统对账</c:when>
									<c:when test="${c.status==3}">发票已申请</c:when>
									<c:when test="${c.status==4}">发票已寄出</c:when>
									<c:when test="${c.status==5}">发票已签收</c:when>
								</c:choose></td>

							<td align="center"><a style="color: #666;"
								href="/ssm/merchant/financialSettlement.do?id=${c.id}">对账详情</a>
								<c:if test="${c.stateType==2}">
									<%--<c:if test="${c.status==2}">
									<a href="#" onclick="openwin(${c.id},${c.settledAmount})">申请发票</a>
									</c:if> --%>
									<c:if test="${c.status==4}">
										<a href="#" onclick="sign(${c.id});">发票签收</a>
									</c:if>
								</c:if> <c:if test="${c.stateType==1}">
									<c:if test="${c.status==3}">
										<a href="#" onclick="send(${c.id})">发票寄出</a>
									</c:if>
								</c:if> <c:if
									test="${c.status == 1 || c.status==3 || c.status==4 || c.status==5}">
									<a href="#" onclick="show(${c.id},${c.status})">查看发票</a>
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br />


		<hr style="color: red; border: 1px solid; margin-top: 50px;" />

		<input class="action orange"
			style="width: 120px; height: 30px; margin: 10px 40px;" id="conf"
			type="button" value="确认对账" onclick="querenduizhang();" />
		<c:if test="${cbs[0].stateType != 1}">
			<input class="action orange"
				style="width: 120px; height: 30px; margin: 10px 40px;" type="button"
				value="申请发票" onclick="apply();" id="apply" />
		</c:if>

		<div id="shenqing">
			<table>
				<tr>
					<td>发票类型：</td>
					<td><input type="radio" name="invoiceType" value="1"
						checked="checked" /><span>增值税发票</span> <input type="radio"
						name="invoiceType" value="2" /><span>普通发票</span> <input
						type="radio" name="invoiceType" value="3" /><span>专业发票</span></td>
				</tr>
				<tr>
					<td>发票抬头：</td>
					<td><select name="InvoiceTitle" id="titleValue"
						style="height: 25px; width: 130px;">
							<c:forEach items="${invoice}" var="t">
								<c:if test="${t.invoiceTitle != null && t.invoiceTitle != ''}">
									<option value="${t.invoiceTitle}">${t.invoiceTitle}</option>
								</c:if>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>增加发票抬头：</td>
					<td><input style="height: 23px;" type="text" id="title" />&nbsp;<input
						class="orange" type="button" value="增加"
						onclick='addTitle(${companyId},$("#title").val());' /></td>
				</tr>
				<tr>
					<td>发票金额：</td>
					<td><span name="amount" id="amount"></span></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="确认"
						class="action orange ck"
						onclick='queren($("input[name=invoiceType]:checked").val(),$("#titleValue option:selected").val(),$("#amount").text(),${companyId},$("#statementId").text());' /></td>
				</tr>
			</table>
			<div style="display: none">
				<span>公司ID：</span> <span name="companyId">${companyId}</span>
			</div>
			<div style="display: none">
				<span>对账单号：</span> <span name="statementId" id="statementId"></span>
			</div>

		</div>

		<div class="overlay"></div>

		<div id="AjaxLoading" class="showbox"
			style="opacity: 0; margin-top: 300px;">
			<div class="loadingWord">
				<img src="<%=path%>/images/waiting.gif">加载中，请稍候...
			</div>
		</div>

		<div style="height: 1200px;"></div>
	</div>
</body>
</html>
