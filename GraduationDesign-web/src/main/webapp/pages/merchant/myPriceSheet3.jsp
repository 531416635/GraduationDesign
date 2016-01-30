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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function AddDispatchBill() {
		var flag = false;
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
		var boxNums = 0;var t=0;
		$.each(checkboxChecked, function(i, box) {
			
			if($(box).next().next().val().trim()!=""){
			
			boxNums += parseInt($(box).next().next().val().trim());
			}
					
			if(t==i){
			if($(box).next().next().next().val().trim()!=""){
			t++;
			}$("#msg2").hide();
			}else{
			$("#msg2").show();
			}
			
		});
		var allnum = $("#mytable tr:first th:eq(1)");

		if (boxNums == 0) {
			$("#msg").show();
			$("#msg3").hide();
			return;
		}  else if (boxNums != parseInt(allnum.text())) {
			$("#msg3").show();
			$("#msg").hide();
			return;
		} else if (flag) {
			$("#msg2").show();
			$("#msg").hide();
			$("#msg3").hide();
			return;
		} else {
			$("#msg").hide();
			$("#msg3").hide();
			$.ajax({
				type : "POST",
				url : "AddDispatchBill.do",
				dataType : "text",
				data : {
					"orderid" : orderid,
					"DispatchBill" : fileIds,
					"priceSheetId" : priceSheetId,
				},
				success : function(data) {
					//提示	
					var json = eval('(' + data + ')');
					if (json.result = "true") {
						//location.href = "deletePriceSheetInfo.do?id="+priceSheetId;
						location.href = "myDispatchBill.do";
					} else {
						switch (json.result) {
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
						url : "addShoppingAddress.do",
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
							window.location.reload();
								var json = eval('(' + data + ')');
								var selects = $("#pSign select:first").clone();
								$("#pSign")
										.append(
												'<input type="checkbox" name="chkAddId" value="'+json.id+'" />  ['
														+ json.adderssName
														+ ']  '
														+ json.address
														+ '<br/>数量：<input type="text" class="Num" id="txtNum'+json.id+'" />  配送时间：<input type="text" id="deliveryTime'
														+ json.id
														+ '" onclick="WdatePicker({dateFmt:'
														+ "'yyyy-MM-dd HH:mm:ss'"
														+ '})" readonly="readonly" style="width:120px;"/>验收人:')
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
		$("#msg").hide();
		$("#msg2").hide();
		$("#msg3").hide();
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
	}
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

.input_text {
	width: 150px;
	height: 22px;
}
</style>
</head>

<body>
	<div class="inner_div">
		<p style="padding-left: 0px;">我的订单：${order.orderId }</p>
		<div>
			<table width="100%" style="color: gray" border="1px" cellspacing="0">
				<thead>
					<tr id="bj">
						<th>产品名称</th>
						<th>货品数量</th>
						<th>报价日期</th>
						<th>期望交期</th>
						<th>有效期至</th>
						<th>备注</th>
					</tr>
				</thead>
				<tbody id="mytable">
					<tr>
						<th>${order.productName }</th>
						<th>${order.quantity }</th>
						<th>${order.orderTime }</th>
						<th>${order.deliveryDate }</th>
						<th>${order.validUntil }</th>
						<th></th>
					</tr>
				</tbody>
			</table>
		</div>
		<br />

		<div id="t2">
			<p style="margin: 0px; background-color: #e5e5e5; font-size: 14px">配送地点</p>
			<span id="msg" style="color: red;">*请填写数量*</span><span id="msg3"
				style="color: red;">*您填写的数量与货品数量不符 *</span><span id="msg2"
				style="color: red;">*请填写日期*</span>
			<p id="pSign">
				<c:forEach items="${shopAdds}" var="sa">
					<input type="checkbox" name="chkAddId" value="${sa.id }" />  [${sa.adderssName}]  ${sa.address}<br />
					&nbsp;&nbsp;&nbsp;&nbsp;数量：<input class="Num input_text"
						type="text" id="txtNum${sa.id}" />&nbsp;&nbsp;配送时间：<input
						class="input_text" type="text" id="deliveryTime${sa.id}"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						onchange="changeExpectTime('${sa.id}')" readonly="readonly"
						style="width: 120px;" />&nbsp;&nbsp;验收人：
					<select class="input_text" id="usersNum${sa.id}"
						name="usersNum${sa.id}">
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
					value="${addressIds}" /> 地址简称：<input id="shortAddress"
					class="input_text" type="text" /> &nbsp;地址详细：<input
					id="detailAddress" class="input_text" type="text" />
				<button class="orange" id="input_buttn" onclick="addAddress();">增加</button>
			</p>
		</div>
		<input class="action orange" type="button" value="确认提交"
			id="input_buttn" onclick="AddDispatchBill()" /> <input
			class="orange" type="button" value="取消返回" id="input_buttn"
			onclick="history.back()" />
	</div>

	<br />
	<div class="overlay"></div>

	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord">
			<img src="<%=path%>/images/waiting.gif">加载中，请稍候...
		</div>
	</div>

	<div style="height: 1200px;"></div>

</body>
</html>