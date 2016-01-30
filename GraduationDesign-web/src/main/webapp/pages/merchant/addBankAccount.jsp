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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript">
function check(){
	var reg = /^[0-9]{16,19}$/;
	var bankAccount = $("#bankAccount").val();
	if(bankAccount == null || bankAccount=="" ){
		alert("带*处必须填写");
		return;
	}else if(!reg.test(bankAccount)){
		alert("请填写正确的银行账号！");
		return;
	}else{
		$("#form").submit();
	}
}
	
</script>
<style type="text/css">
.input_text {
	width: 250px;
	height: 23px;
}

tr {
	height: 30px;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">结算管理 ></span><span
				class="lo2">新增银行账号</span>
		</div>
		<form action="<%=path%>/merchant/addBankAccount.do" method="post"
			id="form">
			<table>
				<tr style="display: none">
					<td>ID<input name="id" /></td>
				</tr>
				<tr style="display: none">
					<td colspan="3">companyId<input class="input_text"
						name="companyId" value="${companyId}"></td>
				</tr>
				<tr>
					<td style="width: 5px;"><span style="color: red;">*</span></td>
					<td>银行账号：</td>
					<td><input class="input_text" type="text" name="bankAccount"
						id="bankAccount" /></td>
				</tr>
				<tr>
					<td></td>
					<td>银行地址：</td>
					<td><input class="input_text" type="text" name="bankAddress" /></td>
				</tr>
				<tr>
					<td></td>
					<td>银行名称：</td>
					<td><input class="input_text" type="text" name="bankName" /></td>
				</tr>
				<tr style="display: none">
					<td colspan="3">状态</td>
				</tr>
				<tr style="display: none">
					<td colspan="3">创建时间</td>
				</tr>
			</table>
			<input style="width: 70px; height: 23px; margin-left: 30px;"
				class="orange" type="button" value="提交" onclick="check();" />
		</form>

	</div>


</body>
</html>
