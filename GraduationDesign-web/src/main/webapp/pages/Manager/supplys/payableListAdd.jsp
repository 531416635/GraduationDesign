<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:url var="base" value="/"> </c:url>
<!DOCTYPE>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css"/>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body{width:100%;height:100%;background-color: #FFFFFF;text-align: center;}
.input_txt{width:200px;height:20px;line-height:20px;}
.info{height:40px;line-height:40px;}
.info th{text-align: right;width:65px;color: #4f4f4f;padding-right:5px;font-size: 13px;}
.info td{text-align:left;}
div {
	position: absolute;
	top: 10%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
<div>
	<form action="payableAdd.do" name="userForm" method="post" >
		<input type="hidden" name="userId" id="userId" value=""/>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr class="info">
			<th>结算编号:</th>
			<td><input type="text" name="settlementId"  required="required"   style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>结算币种:</th>
			<td>
			  <select name="currency">
			    <option value="人民币">人民币</option>
			    <option value="美元">美元</option>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<tr class="info">
			<th>结算金额:</th>
			<td><input type="text"  required="required"   name="settleAmount" style="width:70px;"/></td>
		</tr>
		<tr class="info">
			<th>手续费:</th>
			<td><input type="text"   required="required"  name="settleFee" /></td>
		</tr>
		<tr class="info">
			<th>结算人:</th>
			<td><input type="text"   required="required"  name="settleBy"/></td>
		</tr>
		<tr class="info">
			<th>结算时间:</th>
			<td><input type="text" name="settleTime"  required="required"  onclick="WdatePicker()" style="width:70px;" readonly/></td>
		</tr>
		<tr class="info">
			<th>结算状态:</th>
			<td><input type="text"  required="required"   name="status" /></td>
		</tr>
		<tr class="info">
			<th>银行ID:</th>
			<td>
			  <select name="bankAccountId">
			    <c:forEach items="${bankAccounts}" var="bank">
			       <option value="${bank}">${bank}</option>
			    </c:forEach>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
		<tr class="info">
			<th>结算类型:</th>
			<td><input type="text" name="settleType" value="1"/></td>
		</tr>
		<tr class="info">
			<th>开具发票:</th>
			<td>
			  <select  name="isInvoice">
			    <option value="0">否</option>
			    <option value="1">是</option>
			  </select><a style="color:#FF0000">*</a>
			</td>
		</tr>
	</table>
	<input type="submit" value="提交" />&nbsp;<input type="button" value="取消"  onclick="location='payable.do'"/>
	</form>
	</div>
</body>
</html>