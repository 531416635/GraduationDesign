<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

	function addBuyerContract(){
		var status = $("input[name='status']:checked").val();
		var contractTerms=$("#contractTerms").val();
		var contractTime=$("#contractTime").val();
		var contractExpirationTime=$("#contractExpirationTime").val();
		var contractType="${contractType}";
		var contractContent=$("#contractContent").val();
		var companyId=$("#companyId").val();
// 		alert(companyId+" "+status+" "+contractTerms +" "+ contractTime+" "+contractExpirationTime +" "+contractType +" "+contractContent);
		window.location.href="<%=path%>/addSupplierContract.do?status="+status+"&companyId="+companyId+"&contractType="+contractType+"&contractTerms="+encodeURI(encodeURI(contractTerms))+"&contractContent="+encodeURI(encodeURI(contractContent))+"&contractTime="+contractTime+"&contractExpirationTime="+contractExpirationTime;
	}
</script>
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
<!-- 	<form action="addBuyerContract.do?contractType=${contractType}" method="post"> -->
		<table border="0" cellpadding="0" cellspacing="0">
			<tr style="display: none">
<!-- 				<th>合同ID</th> -->
				<td><input  name="id" type="hidden"  required="required"
					value="${id}"/>
				</td>
			</tr>
			<tr >
<!-- 				<th>公司ID</th> -->
				<td><input id="companyId" name="companyId" type="hidden"  required="required"
					value="${companyId}"/>
				</td>
			</tr>
			
			<tr>
				<th>合同账期:</th>
				<td><input name="contractTerms" id="contractTerms" value="${c.contractTerms}"  required="required"/>
				</td>
			</tr>
			<tr>
				<th>合同时间:</th>
				<td><input name="contractTime" id="contractTime"  required="required"
				onclick="WdatePicker()" 
				readonly="readonly" value="${contractTime}" />
				</td>
			</tr>
			<tr>
				<th>合同期限:</th>
				<td><input name="contractExpirationTime" id="contractExpirationTime"  required="required"
				onclick="WdatePicker()" 
				readonly="readonly" value="${contractExpirationTime}" />
				</td>
			</tr>
			<%-- <tr style="display: none"> 
				<th>供应品类:</th>
				<td><input name="supplyCategory" id="supplyCategory" required="required"
					value="${supplyCategory}" />
				</td>
			</tr> --%>
			<tr> 
				<th>合同类型:</th>
				<td>
						<input name="contractType" id="contractType" required="required"
						value="供应商" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>状态:</th>
				<td>
					<input type="radio" id="status" name="status" value="0"  required="required"><span>签订</span>
					<input type="radio" id="status" name="status" value="1"   required="required"><span>未签订</span>
				</td>
			</tr>
			<tr>
				<th>合同内容:</th>
				<td><textarea rows="15" cols="30" id="contractContent" name="contractContent" value="${contractContent}"  required="required"></textarea>
				</td>
			</tr>
		</table>
		<input type="button" onclick="addBuyerContract()" value="增加"/>
		<input type="reset" value="取消" onclick="history.back()">
<!-- 	</form> -->
	</div>
</body>
</html>
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
	<form action="addSupplierContract.do?contractType=${contractType }" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr style="display: none">
				<th>公司ID</th>
				<td><input  name=companyId type="text"  required="required"
					value="${companyId}"/>
				</td>
			</tr>
			
			<tr>
				<th>合同账期:</th>
				<td><input name="contractTerms"  value="${contractTerms}"  required="required"/>
				</td>
			</tr>
			<tr>
				<th>合同时间:</th>
				<td><input name="contractTime"  required="required"
				onclick="WdatePicker()" 
				readonly="readonly" value="${contractTime}" />
				</td>
			</tr>
			<tr>
				<th>合同期限:</th>
				<td><input name="contractExpirationTime"  required="required"
				onclick="WdatePicker()" 
				readonly="readonly" value="${contractExpirationTime}" />
				</td>
			</tr>
			<tr>
				<th>状态:</th>
				<td>
					<input type="radio" name="status" value="0"><span>签订</span>
					<input type="radio" name="status" value="1"><span>未签订</span>
				</td>
			</tr>
			<%-- <tr style="display: none">
				<th>供应品类:</th>
				<td><input name="supplyCategory"  required="required"
					value="${supplyCategory}" />
				</td>
			</tr> --%>
			<tr> 
				<th>合同类型:</th>
				<td>
						<input name="contractType" id="contractType" required="required"
						value="采购商" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>合同内容:</th>
				<td><input name="contractContent" value="${contractContent}"  required="required"/>
				</td>
			</tr>
		</table>
		<input type="submit" value="增加"/>
		<input type="reset" value="取消" onclick="history.back()">
	</form>
	</div>
</body>
</html>