<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<style type="text/css">
tr {
	height: 30px;
}
</style>

</head>

<body>
	<div class="inner_div">
		<table>
			<tr>
				<td rowspan="3"><img style="height: 80px; width: 80px"
					src="<%=path%>/img/1/1.jpg" /></td>
				<td><b>商品名称：</b></td>
				<td>金龙鱼</td>
				<td><b>单价：</b></td>
				<td>99</td>
			</tr>
			<tr>
				<td><b>购买数量：</b></td>
				<td>10</td>
				<td><b>金额小计：</b></td>
				<td>990</td>
			</tr>
			<tr>
				<td><b>订单号：</b></td>
				<td>IS20150708000013</td>
				<td><b>配送地址：</b></td>
				<td>光谷食堂</td>
			</tr>
			<tr>
				<td colspan="4">
					<div>
						<p style="float: left;">
							<b>备注信息：</b>
						</p>
						<textarea disabled="disabled"
							style="float: left; width: 600px; height: 150px; line-height: 2; font-size: 12px; resize: none;">
					        这里是备注信息
					    </textarea>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
