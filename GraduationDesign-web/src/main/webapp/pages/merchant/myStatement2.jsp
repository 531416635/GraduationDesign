<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	function checkPastDetial(){
		var startTime=$("#startTime").val();
		var endTime=$("#endTime").val();
// 		alert(startTime+","+endTime);
 		if(!(startTime==null || startTime=="" || endTime==null || endTime=="")){
			//重发请求
			window.location.href="<%=path%>/merchant/statement2.do";
		}else{
			alert("请输入日期的区间");
		}
	}

	function apply(){
	var amount = $('#pay').val();
	var invoiceTitle = $('#head').val();
	var bankAccount = $('#bankAccount').val();
	if(amount == null || amount == ""){
	alert("请输入金额");
	return;
	}
	if(invoiceTitle == null || invoiceTitle == ""){
		alert("请填写发票抬头");
		return;
	} 
	$.ajax({
		type:"post",
		url:"<%=path%>/merchant/applyInvoice.do",
		dataType:"text",
		data:{
			"amount":amount,
			"invoiceTitle":invoiceTitle,
			"bankAccount":bankAccount
		},
		success:function(data){
		var json = eval('('+data+')');
			if(json.result="true"){ 
			<%-- location.href="<%=path%>/merchant/confirmSettlement.do?settlement="+settlement; --%>
			var settlement = json.settlement;
			$('#settlement').val(settlement);
			alert("申请发送成功");
		 } 
		 }
	});
	
}
//------------------------------------------------------本次付款
function pay(){
var settlement = $('#settlement').val();
var amount = $('#pay').val();
var bankAccount = $('#bankAccount').val();
if(amount == null || amount == ""){
alert("请输入本次付款金额");
return;
}
	$.ajax({
		type:"post",
		url:"<%=path%>/merchant/confirmSettlement.do",
		dataType:"text",
				data:{
					"amount":amount,
					"settlement":settlement,
					"bankAccount":bankAccount
				},
				success:function(data){
				var json = eval('('+data+')');
				if(json.result="true"){ 
				location.href="";
					}	
				}
				});
}
//------------------------------------------------------本次取款
function pay2(){
var settlement = $('#settlement').val();
var amount2 = $('#pay2').val();
var bankAccount = $('#bankAccount').val();
if(amount2 == null || amount2 == ""){
alert("请输入本次取款金额");
return;
}
	$.ajax({
		type:"post",
		url:"<%=path%>/merchant/confirmSettlement.do",
		dataType:"text",
				data:{
					"amount":-amount,
					"settlement":settlement,
					"bankAccount":bankAccount
				},
				success:function(data){
				var json = eval('('+data+')');
				if(json.result="true"){ 
				location.href="";
					}	
				}
				});
}
//--------------------------------------------------发票抬头存入数据库
function title(){
	var invoiceTitle = $('#head').val();
	if(invoiceTitle == null || invoiceTitle == ""){
		alert("请填写发票抬头");
		return;
	} 
	$.ajax({
		type:"post",
		url:"<%=path%>/merchant/insertInvoiceTitle.do",
		dataType:"text",
		data:{
			"invoiceTitle":invoiceTitle
		},
		success:function(data){
		var json = eval('('+data+')');
			if(json.result="true"){ 
			location.href="location.reload();";
		 } 
		 }
	});
}

//--------------------------------------------------银行账号存入数据库
function newAccount(){
	var bankAccount = $('#bankAccount').val();
	if(bankAccount == "" || bankAccount == null){
		alert("请填写银行账号");
		return;
	}
	$.ajax({
		type:"post",
		url:"<%=path%>/merchant/newAccount.do",
		dataType:"text",
		data:{
			"bankAccount":bankAccount
		},
		success:function(data){
		var json = eval('('+data+')');
			if(json.result="true"){ 
			location.href="location.reload();";
		 } 
		 }
	});
}
</script>
<style type="text/css">
.btnq {
	border: none;
	width: 70px;
	height: 20px;
	margin-left: 20%;
	font-size: 12px;
	color: white;
}

.btnf {
	border: none;
	width: 70px;
	height: 20px;
	margin-left: 50px;;
	font-size: 12px;
	color: white;
}

th {
	background-color: #F0F0F0;
	border: 0.5px solid #999;
}

td {
	border: 0.5px solid #999;
}

tr {
	height: 32px;
}

input {
	height: 23px;
	width: 150px;
}

.input_radio {
	width: 13px;
	height: 13px;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">结算管理 ></span><span
				class="lo2">我的结算单</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab1">往期结算单</a></li>
				<li><a href="#" title="tab2">我的结算单</a></li>
			</ul>
			<div id="content">

				<div id="tab1">
					<h4>往期账单</h4>
					<!-- 					<form action="<%=path%>/merchant/statement.do"> -->
					日期&nbsp;<input id="startTime" value="" onclick="WdatePicker()"
						readonly="readonly" name="startTime" />&nbsp; 至&nbsp;<input
						id="endTime" value="" onclick="WdatePicker()" readonly="readonly"
						name="endTime" />&nbsp;&nbsp;&nbsp;&nbsp; <input
						class="btnq orange" id="checkBtn" type="button"
						onclick="checkPastDetial()" value="查看" /> <br /> <br />
					<table border="1" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>付款时间</th>
								<th>结算金额</th>
								<th>结款人</th>
								<th>发票号</th>
								<th>银行账户</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${st}" var="c">
								<tr>
									<td align="center">${c.SettleTime}</td>
									<td align="center">${c.SettleAmount}</td>
									<td align="center">${c.SettleBy }</td>
									<td align="right">${c.InvoiceID}</td>
									<td align="right">${c.BankAccount}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<br />
					<!-- 					</form> -->
				</div>


				<div id="tab2">
					<table border="1" cellspacing="0" width="100%">
						<tr>
							<th>账户余额</th>
							<td><input type="text" value="${companyBalance[0].balance}"
								readonly="readonly" style="text-align: right;" /></td>
						</tr>
						<tr>
							<th>结款金额</th>
							<td><input type="text" name="" id="pay" /></td>
						</tr>
						<tr>
							<%-- <th>发票抬头</th>	
									<td>
									<!-- <input type="text" name="" id="head"/> -->
									<select name="invoice">
									<option selected="selected"></option>
									<c:forEach items="${invoice}" var="t" >
									<option value="${t.invoiceTitle}">${t.invoiceTitle}</option>
									</c:forEach>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="">申请发票</a> --%>

							<!-- <input type="button" value="新增" onclick="title();"/> </td>-->

							<!-- <input type="button" value="新增" onclick="newAccount();"/></td>-->

							<th>结算类型</th>
							<td><input class="input_radio" name="settleType"
								type="radio" value="0" /><span>付款</span> <input
								class="input_radio" name="settleType" type="radio" value="1" /><span>结款</span>
							</td>
						</tr>
						<tr>
							<th>银行账号</th>
							<td>
								<!-- <input type="text" name="bankAccount" id="bankAccount"/> -->
								<select name="bankAccount" style="width: 152px; height: 25px;">
									<option selected="selected"></option>
									<c:forEach items="${companyBankAccount}" var="c">
										<option value="${c.bankAccount}">${c.bankAccount}</option>
									</c:forEach>
							</select>&nbsp;&nbsp;&nbsp;&nbsp; <a href="">新增银行账号</a>
							</td>
						</tr>
						<tr align="center">
							<td colspan="2"><input type="button" class="btnq orange"
								value="确认结算" onclick="pay();" /></td>
						</tr>
					</table>
					<br />


					<table border="1" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>结算编号</th>
								<th>结算币种</th>
								<th>结算金额</th>
								<th>结算手续费</th>
								<th>结算人</th>
								<th>结算时间</th>
								<th>结算状态</th>
								<th>银行账号</th>
								<th>结算类型</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>

					<!-- <input type="button" class="btnq" value="申请发票" onclick="apply();"/>&nbsp;&nbsp;&nbsp;&nbsp; -->

					<input type="hidden" id="settlement" />


					<%-- <table border="1" cellspacing="0" width="100%">
					<tr>
					<th>本次取款</th>
					<th>发票抬头</th>
					<th>银行账号</th>
					<th>备注</th>
					</tr>
					<tr>
					<td><input type="text" name="" id="pay2" value=""/></td>
					<td>
						<select name="invoice">
						<option selected="selected"></option>
							<c:forEach items="${invoice}" var="t" >
							<option value="${t.invoiceTitle}">${t.invoiceTitle}</option>
							</c:forEach>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="">申请发票</a>
					</td>
					<td>
						<select name="bankAccount">
						<option selected="selected"></option>
							<c:forEach items="${companyBankAccount}" var="c">
							<option value="${c.bankAccount}">${c.bankAccount}</option>
							</c:forEach>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="">新增银行账号</a>
					</td>
					<td><br></td>
					</tr>
					</table><br/>
					<!-- <input type="button" class="btnq" value="申请发票" onclick="apply();"/>&nbsp;&nbsp;&nbsp;&nbsp; -->
					<input type="button" class="btnq" value="确认结算" onclick="pay2();"/><br/><br/>
					 --%>
				</div>
			</div>
		</div>

	</div>
	<script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			$("#tabs li:first").attr("id", "current"); // Activate first tab
			$("#content div:first").fadeIn(); // Show first tab content

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide(); //Hide all content
				$("#tabs li").attr("id", ""); //Reset id's
				$(this).parent().attr("id", "current"); // Activate this
				$('#' + $(this).attr('title')).fadeIn(); // Show content for current tab
			});
			
		})();
	</script>
</body>
</html>
