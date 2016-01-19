<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">

</script>


</head>


<body>

	<div class="rightinfo" style="border: 2px solid;color:#000;position:relative;">

		<div>
			<table>
				<tr>
					<td>公司名称:${companys.companyName}</td>
				</tr>
				<tr>
					<td>公司电话:${companys.companyTel}</td>
				</tr>
				<tr>
					<td>公司网址:${companys.companyWebsite}</td>
				</tr>
				<tr>
					<td>公司联系人:${companys.companyContact}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 1px solid;height:40%;color:#000;position:absolute;top:30%; right:10%;">
			账户金额:
			<input style="color: red;text-align:right;font-size: 18px;" type="text" name="balance" value="${companyBalance.balance}"/>
		</div><br />

	</div><br/>
		
	
	<p align="center">对账单明细</p>
	<div style="border: 2px solid;color:#000;">
		<table class="tablelist">
			<thead>
				<tr>
					<th style="display: none">ID</th>
					<th style="display: none">公司ID</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>金额</th>
					<th>已结算金额</th>
					<th>币种</th>
					<th>折扣</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${cbs}" var="c">
					<tr>
						<td style="display: none">${c.id}</td>
						<td style="display: none">${c.companyId}</td>
						<td>${c.startTime}</td>
						<td>${c.endTime}</td>
						<td align="right">${c.amount}</td>
						<td align="right">${c.settledAmount}</td>
						<td>${c.currency}</td>
						<td>${c.discount}</td>
						<td>
						<c:choose>
							<c:when test="${c.status==0}">
							未对账
							</c:when>
							<c:when test="${c.status==1}">
							已对账
							</c:when>
						</c:choose>
						</td>
						<td><a href="duizhang.do?id=${c.id}&&companyId=${companyId}">对账</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
