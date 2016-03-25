<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="<%=path%>/css/main.css" />
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
	function tijiao(tmpInvoiceType,tmpInvoiceTitle,tmpAmount,tmpCompanyId,tmpStatementId){
		if(tmpInvoiceType == null || tmpInvoiceType == ""){
			alert("请选择发票类型");
			return;
		}
		if(tmpInvoiceTitle==null || tmpInvoiceTitle == ""){
			alert("发票抬头不能为空");
			return;
		}
		location.href="invoiceAdd.do?tmpInvoiceType="+tmpInvoiceType+"&&tmpInvoiceTitle="+encodeURI(encodeURI(tmpInvoiceTitle))+"&&tmpAmount="+tmpAmount+"&&tmpCompanyId="+tmpCompanyId+"&&tmpStatementId="+tmpStatementId;
	}
	
	function addInvoiceTitle(companyId,title){
		alert("添加成功，请重新申请发票");
		location.href="/GraduationDesign/supplys/sysAddTitle.do?companyId="+companyId+"&&title="+encodeURI(encodeURI(title));
	}
</script>
<!-- <style type="text/css">
div {
	position: absolute;
	top: 10%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style> -->

</head>
<body>
	<div>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr class="info">
				<th>发票类型:</th>
				<td><input type="radio" name="invoiceType" value="1"
					checked="checked" /><span>增值税发票</span> <input type="radio"
					name="invoiceType" value="2" /><span>普通发票</span> <input
					type="radio" name="invoiceType" value="3" /><span>专业发票</span></td>
			</tr>
			<tr class="info">
				<th>发票抬头:</th>
				<td><select name="InvoiceTitle" id="titleValue">
						<c:forEach items="${invoice}" var="t">
							<c:if test="${t.invoiceTitle != null && t.invoiceTitle != ''}">
								<option value="${t.invoiceTitle}">${t.invoiceTitle}</option>
							</c:if>
						</c:forEach>
				</select></td>
			</tr>
			<tr class="info">
				<th>增加默认发票抬头:</th>
				<td><input type="text" id="title" /><input type="button"
					value="增加"
					onclick="addInvoiceTitle(${tmpCompanyId},$('#title').val());" /></td>
			</tr>
			<tr class="info">
				<th>发票金额:</th>
				<td>${tmpSettledAmount}</td>
			</tr>
			<tr class="info" style="display: none">
				<th>公司ID:</th>
				<td>${tmpCompanyId}</td>
			</tr>
			<tr class="info" style="display: none">
				<th>对账单号:</th>
				<td>${tmpStatementId}</td>
			</tr>

		</table>
		<input type="button" value="提交"
			onclick='tijiao($("input[name=invoiceType]:checked").val(),$("#titleValue option:selected").val(),${tmpSettledAmount},${tmpCompanyId},${tmpStatementId})' />&nbsp;
		<input type="reset" value="取消" onclick="history.back()" />
	</div>
</body>
</html>