<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:url var="base" value="/">
</c:url>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
 
</script>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js">
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
	width: 65px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}
</style>
</head>
<body onload='s3()'>
	<form action="/ssm/main/addInquiryList.do" name="userForm"
		method="post">
		<input type="hidden" name="id" id="id" value="" />
		<table border="0" cellpadding="0" cellspacing="0">
			<%-- 	<tr class="info" style="display: none">
				<th>用户ID:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="userId" value="${userId}"/>
				</td>
			</tr> --%>
			<tr class="info">
				<th>币种:</th>
				<td><input type="radio" name="currency" value="人民币"
					checked="checked" /><span>人民币</span> <input type="radio"
					name="currency" value="美元" /><span>美元</span></td>
			</tr>
			<tr class="info">
				<th>交易方式:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="deliveryType" />
				</td>
			</tr>
			<tr class="info">
				<th>产品型号:</th>
				<td><input type="text" name="productModel" required="required" />
				</td>
			</tr>
			<tr class="info">
				<th>产品ID:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="productID"
					required="required" /></td>
			</tr>
			<tr class="info">
				<th>产品数量:</th>
				<td><input type="text" required="required"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="productQuantity" />
				</td>
			</tr>
			<tr class="info">
				<th>数量单位:</th>
				<td><input type="text" name="productUnit" required="required" />
				</td>
			</tr>
			<tr class="info">
				<th>参考单价:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="refPrice"
					required="required" /></td>
			</tr>
			<tr class="info">
				<th>期望单价:</th>
				<td><input type="text"
					onkeyup="value=value.replace(/[^(\d)]/g,'')" name="expectPrice"
					required="required" /></td>
			</tr>
			<tr class="info">
				<th>期望交期:</th>
				<td><input type="text" name="expectTime" required="required"
					onclick="WdatePicker()" readonly="readonly" style="width: 70px;" />
				</td>
			</tr>


		</table>
		<input type="submit" value="提交" />
	</form>
</body>
</html>