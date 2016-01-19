<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script language="javascript" type="text/javascript">
	function changeExpectTime(Id) {
		var time=$("#Validity").val().trim();
		var deliveryTime = $("#ValidityTime_" + Id).val().trim().substring(0, 10);

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
				 $("#ValidityTime_" + Id).val(time);
				 alert("配送日期不得小与当前系统日期");
			} 
			
			if(deliveryTime==""){
			 $("#ValidityTime_" + Id).val(time);
				 alert("请输入合适时间");
			}
	}
	
	function groupSubmit(id) {
		var GrouponPrice = $("#GrouponPrice").val().trim();
		var ValidityTime = $("#ValidityTime_" + id).val().trim();
		if (GrouponPrice != "" && ValidityTime != "") {
			$("#form").submit();
		}
		if (GrouponPrice == "" && ValidityTime == "") {
			alert("请输入团购价和有效期限");
		} else if (GrouponPrice == "") {
			alert("请输入团购价");
		} else if (ValidityTime == "") {
			alert("请输入有效期限");
		}
	}
</script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

.input_txt {
	width: 200px;
	height: 20px;
	line-height: 20px;
}

.info {
	height: 40px;
	line-height: 40px;
}

.info th {
	text-align: right;
	width: 100px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}

#div1 {
	position: absolute;
	top: 10%;
	/* margin-top: -50px; */
	left: 10%;
	margin: 0 auto;
	/* margin-left: -50px; */
}
</style>

</head>
<body>
	<div id="div1" style="margin:0 auto;">
		<form id="form" action="updateGroupon.do"
			enctype="multipart/form-data" method="post">

			<c:forEach items="${groupon }" var="g">

				<input type="hidden" name="id" value="${g.id }" />
				<input type="hidden" name="productId" value="${g.ProductID }" />
				<input type="hidden" name="Validity" id="Validity" value="${g.ValidityTime }" />
				<input type="hidden" name="SoldOut" value="${g.SoldOut }" />

				<table border="0" cellpadding="0" cellspacing="0">

					<tr class="info">
						<th>商品名称:</th>
						<td width="200px">${g.ProductName }</td>
						<th>商品原价:</th>
						<td>${g.UnitPrice }</td>

					</tr>
					<tr class="info">
						<th>团购价：</th>
						<td><input type="text" name="GrouponPrice" id="GrouponPrice"
						onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
				onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"	value="${g.GrouponPrice }" />
						</td>
						<th>成交数：</th>
						<td><c:if test="${g.SoldOut==null }">0</c:if> <c:if
								test="${g.SoldOut!=null }">${g.SoldOut }</c:if>&nbsp;${g.ProductUnit
							}</td>
					</tr>


					<tr class="info">
						<th>有效期限：</th>
						<td><input onclick="WdatePicker()" name="ValidityTime"
							onchange="changeExpectTime('${g.id}')"
							id="ValidityTime_${g.id}" value="${g.ValidityTime }" />
						</td>
						<th>团购状态：</th>
						<td><input type="checkbox" name="Status"
							<c:if test='${g.Status==2}'> checked="checked"</c:if> value="2" />
						</td>

					</tr>
					<tr class="info">
						<th>折扣：</th>
						<td><input type="text" name="Discount" value="${g.Discount }" />
						</td>
						<th>节省：</th>
						<td><input type="text" name="Spare" value="${g.Spare }" />
					</tr>				
					<tr>
						<th>图片展示：</th>
						<td><c:if test="${g.IsDefault==1}"><img src="<%=path %>${g.filePath}" /></c:if>
						</td>
					</tr>
					<tr class="info">
						<th>购买须知:</th>
						<td colspan="3"><textarea cols="100" id="content"
								style="width:90%; height:auto;min-height:300px;" name="Remark">${g.Remark}</textarea>
						</td>
					</tr>
				</table>

				<input type="button" value="提交" onclick="groupSubmit('${g.id}')" />
				<input type="reset" value="取消" onclick="history.back()">
			</c:forEach>
		</form>
	</div>
</body>
</html>