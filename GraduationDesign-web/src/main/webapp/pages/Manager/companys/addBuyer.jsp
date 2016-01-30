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
<script type="text/javascript">

</script>
</head>
<body>
	<div>
		<form action="addBuyer.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr style="display: none">
					<th>公司ID</th>
					<td><input readonly="readonly" name="id" value="${id}" /></td>
				</tr>
				<tr>
					<th>公司名称:</th>
					<td><input type="text" name="companyName"
						value="${companyName}" /></td>
				</tr>
				<tr>
					<th>公司地址:</th>
					<td><input type="text" name="companyAddress"
						value="${companyAddress}" /></td>
				</tr>
				<tr>
					<th>公司规模:</th>
					<td><select name="companyScale">
							<option value="0">请选择员工数</option>
							<option value="1">10人以下</option>
							<option value="2">10-50(人)</option>
							<option value="3">50-100(人)</option>
							<option value="4">100人以上</option>
					</select></td>
				</tr>
				<tr>
					<th>注册资本:</th>
					<td><select name="registeredCapital">
							<option value="0">请选择注册资本</option>
							<option value="1">50万以下(元)</option>
							<option value="2">50-100万(元)</option>
							<option value="3">100-500万(元)</option>
							<option value="4">500万以上(元)</option>
					</select></td>
				</tr>
				<tr>
					<th>公司电话:</th>
					<td><input type="text" name="companyTel" value="${companyTel}" />
					</td>
				</tr>
				<tr>
					<th>邮政编码:</th>
					<td><input type="text" name="companyZipCode"
						value="${companyZipCode}" /></td>
				</tr>
				<tr>
					<th>公司简介:</th>
					<td><input name="companyInfo" value="${companyInfo}" /></td>
				</tr>
				<tr style="display: none">
					<th>销售人员:</th>
					<td><input type="text" name="salesMan" value="${salesMan}" />
					</td>
				</tr>
				<tr>
					<th>公司网址:</th>
					<td><input name="companyWebsite" value="${companyWebsite}" />
					</td>
				</tr>
				<tr>
					<th>公司联系人:</th>
					<td><input type="text" name="companyContact"
						value="${companyContact}" /></td>
				</tr>
				<tr>
					<th>公司类别:</th>
					<td><input type="radio" name="companyType" value="1" /><span>商户用户</span>
						<input type="radio" name="companyType" value="2" /><span>采购商</span>
						<input type="radio" name="companyType" value="3" /><span>供应商</span>
					</td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back();">
		</form>
	</div>
</body>
</html>