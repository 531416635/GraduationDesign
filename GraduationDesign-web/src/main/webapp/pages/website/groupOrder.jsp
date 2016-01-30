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
	String id = request.getParameter("id");
	String priceSheetId = request.getParameter("priceSheetId");
%>
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />

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
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function AddGrouponPay() {
		var flag = false;
		var InvoiceTitle="";
		var invoiceType="";
		var allAmount="";
		if($("#checkInvoice").attr("checked")==true){
		InvoiceTitle=$("#InvoiceTitle").val();//发票抬头
		invoiceType=$("input[name='invoiceType']:checked").val();//发票类型
		allAmount=$("#allAmount").val();//总金额
		
		}
		
		//ajax存入报价单
		//var data = $("#")
		var orderid ="<%=id%>";
		var priceSheetId ="<%=priceSheetId%>";
		var fileIds = "";
		$("input[name=chkAddId]").each(
				function() {
					if ($(this).attr("checked") == true
							|| $(this).attr("checked") == "checked") {
						var id = $(this).val();
						var deliveryTime = $("#deliveryTime" + id).val()
								.replace(/:/g, "@");
						fileIds += "{id:" + id + ",num:"
								+ $("#txtNum" + id).val() + ",checkUser:"
								+ $("#usersNum" + id).val() + ",deliveryTime:"
								+ deliveryTime + "},";
						if ($("#deliveryTime" + id).val() == "") {
							flag = true;
							return;
						}
					}
				});
		if (fileIds.length == 0) {
			alert("请选择");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		fileIds = "[" + fileIds + "]";
		var checkboxChecked = $("#pSign :checkbox:checked");
		var t=0;		
		
		//var allnum = $("#mytable tr:first th:eq(1)");
	 if (flag) {
			$("#msg2").show();
			$("#msg").hide();
			$("#msg3").hide();
			return;
		} else {
			$("#msg").hide();
			$("#msg3").hide();
			jindutiao();
			$.ajax({
						type : "POST",
						url : "AddGrouponPay.do",
						dataType : "text",
						data : {
							"orderid" : orderid,
							"DispatchBill" : fileIds,
							"priceSheetId" : priceSheetId,
							"InvoiceTitle":InvoiceTitle,
							"invoiceType":invoiceType,
							"allAmount":allAmount
							
						},
						success : function(data) {
							//提示	
							var json = eval('(' + data + ')');
							if (json.result = "true") {
							$(".action").css("display","none");		
							$("#input_buttn1").css("display","inline");
								//location.href = "deletePriceSheetInfo.do?id="+priceSheetId;
								//location.href = "myDispatchBill.do";
								alert("成功！")
							} else {
								switch (json.result) {
								case "1":
									alert("请先登录！");
									window.location.href = "<%=path%>/web/toLogin.do";			
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
	}
	//添加新默认收货地址
	function addAddress() {
		var address = $("#addressIds").val();
		var detailAddress = $("#detailAddress").val();
		var shortAddress = $("#shortAddress").val();
		if (detailAddress == "" || shortAddress == "") {
			alert("详细地址与简称必填");
		} else {
			$
					.ajax({
						type : "POST",
						url : "/ssm/merchant/addShoppingAddress.do",
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						dataType : "text",
						data : {
							address : address,
							detailAddress : detailAddress,
							shortAddress : shortAddress
						},
						success : function(data) {
							if (data == "false") {
								alert("程序出错了！");
							} else if (data == "null") {
								alert("新增地址已存在，请重新填写！");
							} else {
								var json = eval('(' + data + ')');
								var selects = $("#pSign select:first").clone();
								var numAmount=$("#numAmount").val();
								$("#pSign")
										.append(
												'<input type="radio" id="radio'+json.id+'" name="chkAddId" onchange="checkBoxBlur('+json.id+')" value="'+json.id+'" />  ['
														+ json.adderssName
														+ ']  '
														+ json.address
														+ '<br/><input type="hidden" class="Num" id="txtNum'+json.id+'" value="'+numAmount+'"  /> &nbsp;&nbsp;&nbsp;&nbsp; 配送时间：<input type="text" id="deliveryTime'
														+ json.id
														+ '" onclick="WdatePicker({dateFmt:'
														+ "'yyyy-MM-dd HH:mm:ss'"
														+ '})" readonly="readonly" onchange="changeExpectTime('+json.id+')"  style="width:120px;"/>&nbsp;&nbsp;验收人:')
										.append(selects).append('<br />');
								$("#txtNum" + json.id).next().attr({
									id : "usersNum" + json.id,
									name : "usersNum" + json.id
								});
							}
						}
					});
		}
	}
	$(function() {
		$("#msg2").hide();
	});

	function changeExpectTime(Id) {

		var deliveryTime = $("#deliveryTime" + Id).val().trim()
				.substring(0, 10);

		var date = new Date();
		var seperator1 = "-";
		var seperator2 = ":";
		var month = date.getMonth() + 1;
		var strDate = date.getDate();
		if (month >= 1 && month <= 9) {
			month = "0" + month;
		}
		if (strDate >= 0 && strDate <= 9) {
			strDate = "0" + strDate;
		}
		var currentdate = date.getFullYear() + seperator1 + month + seperator1
				+ strDate  ;
	

			var date1 = new Date(Date.parse(currentdate));
			var date2 = new Date(Date.parse(deliveryTime));
	
			if (date1.getTime() > date2.getTime()) {
				alert("配送日期不得小与当前系统日期");
				$("#deliveryTime" + Id).val("");
			}
			if(date2!=""){
			$("#msg2").hide();
			}
	}

	function addInvoiceTitle() {
		var InvoiceTitletxt = $("#addInvoiceTitle").val().trim();
		var s="";
		if (InvoiceTitletxt!="") {
		s="<option value='"+InvoiceTitletxt+"' selected='selected'> "+InvoiceTitletxt+"</option>";
		$("#InvoiceTitle").append(s);
		$("#addInvoiceTitle").val("");
		} else {
			alert("请输入合适的发票抬头");
			$("#addInvoiceTitle").val("");
		}
	}
	
	function checkBoxBlur(id){
		if($("input[name='chkAddId']:checked").length ==1){
			var numAmount=$("#numAmount").text().trim();	
			var num1=$("#unitPrice").text();
			var newNum=(Number(numAmount)*Number(num1)).toFixed(2);
			$("#totalAmount").val(newNum);
			var allAmount=(Number($("#dispatchAmount").val().trim())+Number(newNum)).toFixed(2);
			$("#allAmount").val(allAmount);
 			}
  		};
	
//----------------------------------页面加载进度条
function jindutiao(){
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
};	
//是否提供发票
function checkInvoice(){
if($("input[name='checkInvoice']:checked").length ==1){
$("#invoiceDiv").show();
}else{
$("#invoiceDiv").hide();
}
}
</script>
<style type="text/css">
#tt {
	margin-left: auto;
	margin-right: auto;
	height: 80px;
	border: 1px solid;
	color: gray;
}

#bj {
	background-color: #d5d5d5;
}

#t2 {
	border: 1px solid;
	color: gray;
	margin-bottom: 15px;
}

#input_buttn {
	height: 23px;
	width: 80px;
	margin-left: 30px;
	font-size: 12px;
	color: white;
}

p {
	line-height: 30px;
	padding-left: 15px;
}

input[type="text"], select {
	width: 150px;
	height: 22px;
}
</style>
</head>

<body>
	<div class="inner_div">
		<hr style="color: red; border: 1px solid; margin-top: 20px;" />
		<p style="padding-left: 0px;">团购订单</p>
		<div>
			<table width="100%" style="color: gray" border="0px" cellspacing="0">

				<tr>
					<th rowspan="3"><img style="width: 88px; height: 88px;"
						src="<%=path %>${fliePath }" /></th>
					<th colspan="6" style="float: left;">${order.productName }</th>

				</tr>


				<tr>
					<th>订单号：</th>
					<th>${order.orderId }</th>
					<th>配送单号：</th>
					<th></th>
					<th>购买数量:</th>
					<th><span id="numAmount">${order.quantity }</span>${order.productUnit }</th>
				</tr>
				<tr>
					<th>单价:</th>
					<th id="unitPrice">${order.unitPrice }</th>
					<th>总额:</th>
					<th>${order.totolAmount }</th>
					<th>配送地址:</th>
					<th>${Address}</th>
				</tr>

			</table>
		</div>
		<hr style="color: red; border: 1px solid; margin-top: 20px;" />
		<br />

		<div id="t2">
			<p style="margin: 0px; background-color: #e5e5e5; font-size: 14px">配送地点</p>
			<span id="msg2" style="color: red; display: none;">*请填写日期*</span>
			<p id="pSign">
				<c:forEach items="${shopAdds}" var="sa">
					<input type="radio" id="radio${sa.id }" name="chkAddId"
						value="${sa.id }" onchange="checkBoxBlur(${sa.id})" />  [${sa.adderssName}]  ${sa.address}<br />
					&nbsp;&nbsp;&nbsp;&nbsp;<input class="Num" type="hidden"
						id="txtNum${sa.id}" value="${order.quantity }" />&nbsp;&nbsp;配送时间：<input
						type="text" id="deliveryTime${sa.id}"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						onchange="changeExpectTime('${sa.id}')" readonly="readonly"
						style="width: 120px;" />&nbsp;&nbsp;验收人:
					<select id="usersNum${sa.id}" name="usersNum${sa.id}">
						<c:forEach items="${users}" var="u">
							<c:if test="${u.status=='1'}">
								<option value="${u.id}">${u.userName}(${u.userCode})</option>
							</c:if>
						</c:forEach>
					</select>
					<br />
				</c:forEach>
			</p>
			<br />
			<p>
				&nbsp;增加默认配送地点&nbsp;<input type="hidden" id="addressIds"
					value="${addressIds}" /> 地址简称：<input id="shortAddress" type="text" />
				&nbsp;地址详细：<input id="detailAddress" type="text" />
				<button class="orange" id="input_buttn" onclick="addAddress();">增加</button>
			</p>
		</div>

		<div style="border: 1px solid gray; background-color: #f1f1f1;">
			收货信息：<br />
			<textArea type="text" name=""
				style="resize: none; width: 500px; border: 0px; border-bottom: 1px solid gray;"></textArea>
			<br /> <br /> 其他信息：<input type="checkbox" id="checkInvoice"
				onchange="checkInvoice()" name="checkInvoice" value="1"> 发票
			<br />
			<div id="invoiceDiv" style="display: none;">
				发票类型: <input type="radio" name="invoiceType" checked="checked"
					value="1" /><span>增值税发票</span> <input type="radio"
					name="invoiceType" value="2" /><span>普通发票</span> <input
					type="radio" name="invoiceType" value="3" /><span>专业发票</span> <br />发票抬头：<select
					name="InvoiceTitle" id="InvoiceTitle">
					<c:forEach items="${invoice}" var="t">
						<c:if test="${t.invoiceTitle != null && t.invoiceTitle != ''}">
							<option value="${t.invoiceTitle}">${t.invoiceTitle}</option>
						</c:if>
					</c:forEach>
				</select> <br />增加默认发票抬头<input type="text" id="addInvoiceTitle"> <input
					type="button" id="addInvoice" value="增加"
					onclick="addInvoiceTitle()" />
			</div>
		</div>
		<div style="border: 1px solid gray; background-color: #f1f1f1;">
			商品金额：<input type="text" value="0.00" id="totalAmount"
				style="border: 0px;" readonly="readonly" name="totalAmount " /><br />
			运费：<input type="text" id="dispatchAmount" value="0.00"
				onchange="checkBoxBlur(0)"
				onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
				onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" /><br />
			待支付：<input type="text" value="0.00" id="allAmount"
				style="border: 0px;" readonly="readonly" name="totalAmount " /><br />
		</div>
		<input class="orange action" type="button" value="进行支付"
			id="input_buttn" onclick="AddGrouponPay()" /><input type="button"
			value="进行支付" id="input_buttn1"
			style="background-color: #404040; display: none;" /> <input
			class="orange" type="button" value="取消返回" id="input_buttn"
			onclick="history.back()" />
	</div>

	<br />


	<div class="overlay"></div>

	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord">
			<img src="<%=path%>/images/waiting.gif" />加载中，请稍候...
		</div>
	</div>

	<div style="height: 1200px;"></div>


</body>
</html>