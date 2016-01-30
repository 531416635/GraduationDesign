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
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
<script type="text/javascript">
//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor().panelInstance('contractContent');
	});
<%-- 	function addBuyerContract(){
		var status = $("input[name='status']:checked").val();
		var contractTerms=$("#contractTerms").val();
		var contractTime=$("#contractTime").val();
		var contractExpirationTime=$("#contractExpirationTime").val();
		var contractType="${contractType}";
		var contractContent=$("#contractContent").val();
		var companyId=$("#companyId").val();
// 		alert(companyId+" "+status+" "+contractTerms +" "+ contractTime+" "+contractExpirationTime +" "+contractType +" "+contractContent);
		window.location.href="<%=path%>/addBuyerContract.do?status="+status+"&companyId="+companyId+"&contractType="+contractType+"&contractTerms="+encodeURI(encodeURI(contractTerms))+"&contractContent="+encodeURI(encodeURI(contractContent))+"&contractTime="+contractTime+"&contractExpirationTime="+contractExpirationTime;
	} --%>
	
var showSupplyCategory=function(tmp){
		if(tmp == 0){
		$("#supplyCategory").hide();
		}else{
		$("#supplyCategory").show();
		}
	};
</script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

#supplyCategory {
	display: none;
}
</style>
</head>
<body>
	<div>
		<form action="addBuyerContract.do" enctype="multipart/form-data"
			method="post">
			<table>
				<tr style="display: none">
					<th>合同ID</th>
					<td><input name="id" type="hidden" value="${id}" /></td>
				</tr>
				<tr style="display: none">
					<th>公司ID</th>
					<td><input id="companyId" name="companyId" type="hidden"
						value="${companyId}" /></td>
				</tr>

				<tr>
					<th>合同账期:</th>
					<td><input name="contractTerms" id="contractTerms" /></td>
				</tr>
				<tr>
					<th>合同时间:</th>
					<td><input name="contractTime" id="contractTime"
						onclick="WdatePicker()" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>合同期限:</th>
					<td><input name="contractExpirationTime"
						id="contractExpirationTime" onclick="WdatePicker()"
						readonly="readonly" /></td>
				</tr>
				<tr>
					<th>合同类型:</th>
					<td><input type="radio" name="contractType" value="0"
						onclick="showSupplyCategory(0)" /><span>采购商</span> <input
						type="radio" name="contractType" value="1"
						onclick="showSupplyCategory(1)" /><span>供应商</span></td>
				</tr>
				<tr id="supplyCategory">
					<th>供应品类:</th>
					<td><select name="supplyCategory">
							<option value="米面粮油">米面粮油</option>
							<option value="冷鲜禽蛋">冷鲜禽蛋</option>
							<option value="南干北货">南干北货</option>
							<option value="豆类豆制">豆类豆制</option>
							<option value="用具耗材">用具耗材</option>
							<option value="调味调料">调味调料</option>
					</select></td>
				</tr>
				<tr>
					<th>合同内容:</th>
					<td colspan="3"><textarea cols="100" id="contractContent"
							style="width: 90%; height: 300px;" name="contractContent"></textarea>
					</td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="history.back()">
		</form>
	</div>
</body>
</html>