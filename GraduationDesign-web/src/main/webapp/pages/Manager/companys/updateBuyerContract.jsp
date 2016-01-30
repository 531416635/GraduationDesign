<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="js/datePicker/WdatePicker.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

div {
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
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
<body>
	<div>
		<form action="updateBuyerContract.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr style="display: none">
					<th>合同ID</th>
					<td><input name="id" type="text" value="${c.id}"
						readonly="readonly" /></td>
				</tr>
				<tr style="display: none">
					<th>公司ID</th>
					<td><input name=companyId type="text" value="${companyId}"
						readonly="readonly" /></td>
				</tr>

				<tr>
					<th>合同账期:</th>
					<td><input name="contractTerms" value="${c.contractTerms}" />
					</td>
				</tr>
				<tr>
					<th>合同年限:</th>
					<td><input name="contractTime" onclick="WdatePicker()"
						readonly="readonly" value="${c.contractTime}" /></td>
				</tr>
				<%-- <tr>
				<th>供应品类:</th>
				<td><input name="supplyCategory" 
					value="${c.supplyCategory}" />
				</td>
			</tr> --%>
				<tr>
					<th>合同类型:</th>
					<td><input name="contractType" id="contractType"
						required="required" value="1" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>状态:</th>
					<td><c:choose>
							<c:when test="${c.status==0}">
								<input type="radio" name="status" value="0" checked="checked" />
						签订
					</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="0" />
						签订
					</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${c.status==1}">
								<input type="radio" name="status" value="1" checked="checked" />
						未签订
					</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="1" />
						未签订
					</c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>合同内容:</th>
					<td><input name="contractContent" value="${c.contractContent}" />
					</td>
				</tr>
			</table>
			<input type="submit" value="修改" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>