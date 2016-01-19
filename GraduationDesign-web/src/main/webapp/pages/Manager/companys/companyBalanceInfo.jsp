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
		<form action="findBalanceById.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr style="display: none">
					<th>ID</th>
					<td><span>${c.id}</span></td>
				</tr>
				<tr style="display: none">
					<th>公司ID:</th>
					<td><span>${c.companyId}</span></td>
				</tr>

				<tr>
					<th>币&nbsp;&nbsp;&nbsp;&nbsp;种:</th>
					<td><span>${c.currency}</span></td>
				</tr>
				<tr>
					<th>账户金额:</th>
					<td><span><a href="/ssm/CompanyBalanceLog.do?id=${c.companyId}">${c.balance}</a></span></td>
				</tr>
				<tr>
					<th>账户状态:</th>
					<td><c:choose>
							<c:when test="${c.status==0}">
                        			初始
                        		</c:when>
							<c:when test="${c.status==1}">
                        			可用
                        		</c:when>
							<c:when test="${c.status==2}">
                        			冻结
                        		</c:when>
							<c:otherwise>
                        			删除
                        		</c:otherwise>
						</c:choose></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>