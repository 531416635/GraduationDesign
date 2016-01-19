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
	String json = (String) request.getAttribute("json");
	String json2 = (String) request.getAttribute("json2");
	String show=(String)request.getAttribute("show");
	/* String startTime = (String)request.getAttribute("st");
	String endTime = (String)request.getAttribute("et"); */
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<link href="<%=path%>/css/redcss/core.css" type="text/css"
	rel="stylesheet" />
<script src="<%=path%>/js/redjs/jquery.1.3.2.js" type="text/javascript"
	language="javascript"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript">
$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=json%>);
/* 	  	$("#rows").html(json.rows);
	  	$("#currentPage1").html(json.currentPage); */
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination").pagination(json.rows, { // 创建分页按钮
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
		location.href="statement.do?currentPage1="+(page_index+1)+"&&show=1";
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	
	$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json2 = eval(<%=json2%>);
	  	$("#rows2").html(json2.rows);
	  	$("#currentPage2").html(json2.currentPage);
		var initPagination2 = function() { //此函数为分页动态按钮展现
	 	$("#Pagination2").pagination(json2.rows, { // 创建分页按钮
			current_page: json2.currentPage-1,
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback2,
			items_per_page: json2.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback2(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		var startTime=$("#startTime").val();
		var endTime=$("#endTime").val();
		location.href="statement.do?currentPage2="+(page_index+1)+"&&show=2"+"&&startTime="+startTime+"&&endTime="+endTime;
		}
		flag=true;
		return false;	
	   }
	    initPagination2();
	});

	function checkPastDetial(){
		var startTime=$("#startTime").val();
		var endTime=$("#endTime").val();
// 		alert(startTime+","+endTime);
		
 		if(!(startTime==null || startTime=="" || endTime==null || endTime=="")){
 			if(startTime>endTime){
			alert("结束时间要大于开始时间");
			return;
			}else{
			$("#form1").submit();
			}
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
//------------------------------------------------------结款
function pay(tmpCurrency,tmpAmount,tmpCompanyId,settleType,bankAccount){
var amount = $('#pay').val();
if(amount == null || amount == ""){
alert("请输入金额");
return;
}
location.href="confirmSettlement.do?tmpCompanyId="+tmpCompanyId+"&&tmpCurrency="+encodeURI(encodeURI(tmpCurrency))+"&&tmpAmount="+tmpAmount+"&&settleType="+settleType+"&&bankAccount="+encodeURI(encodeURI(bankAccount));

//---------------------------------确认结算后按钮自灰
$("#jiek").attr('disabled',"true");
$("#jiek").css('background-color','#E3E3E3');
$("#fuk").attr('disabled',"true");
$("#fuk").css('background-color','#E3E3E3');
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


var showTrBankAccount=function(tmp){
if(tmp==1)
{
	$("#trBankAccount").show();
	$("#jiek").show();
	$("#fuk").hide();
}
else
{
	$("#trBankAccount").hide();
	$("#jiek").hide();
	$("#fuk").show();
}
};

function accountWater(){
	location.href="accountWater.do";
}

var bz = $("#currency option:selected").val();
$("#balance").text(bz);

//页面加载进度条
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
</script>
<style type="text/css">
div.meneame span {
	display: inline;
}

.btnq {
	border: none;
	width: 70px;
	height: 20px;
	/* margin-left: 20%; */
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

input ,select{
	height: 23px;
	width: 150px;
}

.input_radio {
	width: 13px;
	height: 13px;
}
#jiek{
	display: none;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">结算管理 ></span><span
				class="lo2">我的结算单</span> 
		</div>

		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab1">我的结算单</a></li>
				<li><a href="#" title="tab2">往期结算单</a></li>
			</ul>
			<div id="content">
				<div id="tab1">
					<table border="1" cellspacing="0" width="100%">
						<tr>
							<th>币种</th>
							<td>
							<select name="currency" id="currency">
									<option value="CNY" selected="selected">人民币</option>
									<option value="USD">美元</option>
							</select></td>
						</tr>
						<tr>
							<th>账户余额</th>
							<td id="balance">
							<%-- <c:if test="$('#balance).text()=='CNY'"> --%>
							<input type="text" value="${companyBalance[0].balance}"
								readonly="readonly" style="text-align: right;" />
							<%-- </c:if>	
							<c:if test="$('#balance).text()=='USD'">
							<input type="text" value="${companyBalance[0].balance*0.1611}"
								readonly="readonly" style="text-align: right;" />
							</c:if>	 --%>
							
							<input type="button" class="action btnq orange" value="帐户流水" onclick="accountWater();"/>
							</td>
						</tr>
						<tr>
							<th>结款金额</th>
							<td><input type="text" name="" id="pay" />
							</td>
						</tr>
						<tr>

							<th>结算类型</th>
							<td><input class="input_radio" name="settleType"
								type="radio" value="0" 
								onclick="showTrBankAccount(0)" /><span>付款</span> <input
								class="input_radio" name="settleType" type="radio" value="1"
								onclick="showTrBankAccount(1)" /><span>结款</span></td>
						</tr>
						<tr id="trBankAccount" style="display:none;">
							<th>银行账号：</th>
							<td>
								<!-- <input type="text" name="bankAccount" id="bankAccount"/> -->
								<select name="bankAccount" style="width:120px" id="bankAccount">
									<option selected="selected"></option>
									<c:forEach items="${companyBankAccount}" var="c">
										<option value="${c.bankAccount}">${c.bankAccount}</option>
									</c:forEach>
							</select>&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=path%>/merchant/toAddBankAccount.do?companyId=${companyId}">新增银行账号</a></td>
						</tr>
						<tr align="center">
							<td colspan="2">
							<input type="button" class="action btnq orange" id="fuk" value="确认结算" onclick="location.href='#'"/>
							<input type="button" class="action btnq orange" id="jiek" 
								value="确认结算" onclick='pay($("#currency option:selected").val(),$("#pay").val(),${companyId},$("input:radio:checked").val(),$("#bankAccount option:selected").val());' />
							</td>
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
							<c:forEach items="${list}" var="c">
								<tr>
									<td align="center">${c.settlementId}</td>
									<td align="center">${c.currency}</td>
									<td align="center">${c.settleAmount}</td>
									<td align="center">${c.settleFee}</td>
									<td align="center">${c.userName}</td>
									<td align="center">${c.settleTime}</td>
									<td align="center"><c:choose>
											<c:when test="${c.status == 0}">未支付</c:when>
											<c:when test="${c.status == 1}">支付成功</c:when>
											<c:when test="${c.status == 2}">支付失败</c:when>
											<c:when test="${c.status == 3}">银行支付成功</c:when>
											<c:when test="${c.status == 4}">银行支付失败</c:when>
											<c:when test="${c.status == 5}">用户取消</c:when>
										</c:choose></td>
									<td align="center">${c.bankAccount}</td>
									<td align="center"><c:choose>
											<c:when test="${c.settleType==0}">付款</c:when>
											<c:when test="${c.settleType==1}">结款</c:when>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 分页 -->
			
			<div id="Pagination" class="meneame" style="clear:left"></div> 	

					<input type="hidden" id="settlement" />

				</div>

				<div id="tab2">
					<h4>往期账单</h4>
							<form action="<%=path%>/merchant/statement.do?show=2" method="post" id="form1">
						日期&nbsp;<input id="startTime" value="${st}" onclick="WdatePicker()"
							readonly="readonly" name="startTime" />&nbsp; 至&nbsp;<input
							id="endTime" value="${et}" onclick="WdatePicker()" readonly="readonly"
							name="endTime" />&nbsp;&nbsp;&nbsp;&nbsp; <input id="checkBtn"
							class="btnq orange" type="button" onclick="checkPastDetial()"
							value="查看" /> <br /> <br />
							</form>
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
							<c:forEach items="${settlementInfo}" var="s">
								<tr>
									<td align="center">${s.settlementId}</td>
									<td align="center">${s.currency}</td>
									<td align="center">${s.settleAmount}</td>
									<td align="center">${s.settleFee}</td>
									<td align="center">${s.userName}</td>
									<td align="center">${s.settleTime}</td>
									<td align="center"><c:choose>
											<c:when test="${s.status == 0}">未支付</c:when>
											<c:when test="${s.status == 1}">支付成功</c:when>
											<c:when test="${s.status == 2}">支付失败</c:when>
											<c:when test="${s.status == 3}">银行支付成功</c:when>
											<c:when test="${s.status == 4}">银行支付失败</c:when>
											<c:when test="${s.status == 5}">用户取消</c:when>
										</c:choose></td>
									<td align="center">${s.bankAccount}</td>
									<td align="center"><c:choose>
											<c:when test="${s.settleType==0}">付款</c:when>
											<c:when test="${s.settleType==1}">结款</c:when>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
						<br />
						<div id="Pagination2" class="meneame" style="clear:left"></div>
				</div>

			</div>
		</div>

	</div>
	<!-- <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script> -->
	<script>
		/* $(document).ready(function() {
			$("#tab1").hide();
			$("#tab2").hide(); // Initially hide all content
			$("#tabs li:first").attr("id", "current"); // Activate first tab
			$("#content div:first").fadeIn(); // Show first tab content

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#tab1").hide();
				$("#tab2").hide(); // Initially hide all content
				$("#tabs li").attr("id", ""); //Reset id's
				$(this).parent().attr("id", "current"); // Activate this
				$('#' + $(this).attr('title')).fadeIn(); // Show content for current tab
			});
			
		})(); */
		$(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			if ("${show}" == "1" || "${show}" == "") {
				$("#tabs li:first").attr("id", "current"); // Activate first tab
				$("#tabs li:last").attr("id", ""); // Activate first tab
				$("#content div:first").fadeIn(); // Show first tab content	
				$("#Pagination").show();
				$("#Pagination2").show();
			} else {
				$("#tabs li:last").attr("id", "current"); // Activate first tab
				$("#tabs li:first").attr("id", ""); // Activate first tab
				$("#tab2").fadeIn(); // Show first tab content
				$("#Pagination").show();
				$("#Pagination2").show();		
			}
			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#tab1").hide();
				$("#tab2").hide();
				$("#tabs li").attr("id", "");
				$(this).parent().attr("id", "current");
				$('#' + $(this).attr('title')).fadeIn();
				var tmp=$(this).attr('title');
				var page="#Pagination" +tmp.replace("tab","");
				$(page).show();
				$("#Pagination").show();
				$("#Pagination2").show();
			});
		});
	</script>
<div class="overlay"></div>

<div id="AjaxLoading" class="showbox">
	<div class="loadingWord"><img src="<%=path%>/images/waiting.gif">加载中，请稍候...</div>
</div>

<div style="height:1200px;">
	
</div>

</body>
</html>
