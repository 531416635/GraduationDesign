
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<title>一起采</title>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<style type="text/css">
.input_text {
	width: 150px;
	height: 20px;
}

tr {
	height: 30px;
}

table {
	margin-bottom: 20px;
}
</style>
</head>

<body>
	<div
		style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
		<span class="lo1">首页</span> > <span class="lo2"> 商品管理 ></span><span
			class="lo2"> 商品上货</span><span class="lo2"> 商品编辑</span>
	</div>
	<form action="/ssm/merchant/updateCompanyProductsInfo.do" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>商品编码：</th>
				<td><input class="input_text" type="text"
					name="companyProductCode"
					value="${companyproducts.companyProductCode}" /></td>
			</tr>
			<input type="hidden" name="id" value="${companyproducts.id}" />
			<tr>
				<th>生产日期：</th>
				<td><input class="input_text" type="text" name="productDate"
					value="<fmt:formatDate value="${companyproducts.productDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker()" readonly="readonly" /></td>
			</tr>

			<%-- <th>生产日期：</th>
<td><input  type="text"  name="productDate"  value="${companyproducts.productDate}" /></td>
</tr> --%>

			<tr>
				<th>备注：</th>
				<td><textarea name="productRemark" cols="35"
						style="width: 300px; height: 100px;"> ${companyproducts.productRemark}</textarea></td>
			</tr>
		</table>
		<input style="width: 70px; height: 23px; margin-left: 30px;"
			class="orange" type="submit" value="提交" /> <input
			style="width: 70px; height: 23px; margin-left: 30px;" class="orange"
			type="reset" value="取消" onclick="history.back()">
	</form>

</body>
</html>
