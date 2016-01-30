<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
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
		<form action="updateSupplierBalance.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr style="display: none">
					<th>公司ID</th>
					<td><input name="companyId" readonly="readonly"
						value="${cb.companyId}" /></td>
				</tr>
				<tr>
					<th>币种:</th>
					<td><c:choose>
							<c:when test="${cb.currency == '人民币'}">
								<input type="radio" name="currency" value="人民币"
									checked="checked">
						人民币
					</c:when>
							<c:otherwise>
								<input type="radio" name="currency" value="人民币">
						人民币
					</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${cb.currency == '美元'}">
								<input type="radio" name="currency" value="美元" checked="checked">
						美元
					</c:when>
							<c:otherwise>
								<input type="radio" name="currency" value="美元">
						美元
					</c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>账户金额:</th>
					<td><input type="text" name="balance" value="${cb.balance}" />
					</td>
				</tr>
				<tr>
					<th>账户状态:</th>
					<td><c:choose>
							<c:when test="${cb.status==0}">
								<input type="radio" name="status" value="0" checked="checked" />
						初始
					</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="0" />
						初始
					</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${cb.status==1}">
								<input type="radio" name="status" value="1" checked="checked" />
						可用
					</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="1" />
						可用
					</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${cb.status==2}">
								<input type="radio" name="status" value="2" checked="checked" />
						冻结
					</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="2" />
						冻结
					</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${cb.status==3}">
								<input type="radio" name="status" value="3" checked="checked" />
						删除
					</c:when>
							<c:otherwise>
								<input type="radio" name="status" value="3" />
						删除
					</c:otherwise>
						</c:choose></td>
				</tr>

			</table>
			<input type="submit" value="修改" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>