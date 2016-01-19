<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
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
	top: 30%;
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
	<form action="addSupplier.do" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr style="display: none">
				<th>公司ID</th>
				<td><input readonly="readonly" name="id" value="${id}"  required="required"   />
				</td>
			</tr>
			<tr>
				<th>公司名称:</th>
				<td><input type="text" name="companyName" value="${companyName}"  required="required"  />
				</td>
			</tr>
			<tr>
				<th>公司地址:</th>
				<td><input type="text" name="companyAddress" value="${companyAddress}"  required="required"  />
				</td>
			</tr>
			<tr>
				<th>公司规模:</th>
				<td><input type="text" name="companyScale" value="${companyScale}"  required="required"  />
				</td>
			</tr>
			<tr>
				<th>注册资本:</th>
				<td><input name="registeredCapital" type="text"
					required="required"   value="${registeredCapital}" />
				</td>
			</tr>
			<tr>
				<th>公司电话:</th>
				<td><input type="text" name="companyTel" value="${companyTel}"  required="required"  />
				</td>
			</tr>
			<tr>
				<th>邮政编码:</th>
				<td><input type="text" name="zipCode" value="${zipCode}"   required="required"  />
				</td>
			</tr>
			<tr>
				<th>公司简介:</th>
				<td><input name="companyInfo"  required="required"    value="${companyInfo}"/>
				</td>
			</tr>
			<tr>
				<th>销售人员:</th>
				<td><input type="text" name="salesMan" value="${salesMan}"  required="required"  />
				</td>
			</tr>
			<tr>
				<th>公司网址:</th>
				<td><input name="companyWebsite" value="${companyWebsite}"  required="required"  />
				</td>
			</tr>
			<tr>
				<th>公司联系人:</th>
				<td><input type="text" name="companyContact" value="${companyContact}"  required="required"  />
				</td>
			</tr>
			<tr style="display: none">
				<th >公司类别</th>
				<td><input readonly="readonly"   required="required"  
				name="companyType" value="1" />
				</td>
			</tr>
		</table>
		<input type="submit" value="增加"/>
		<input type="reset" value="取消" onclick="history.back()">
	</form>
	</div>
</body>
</html>