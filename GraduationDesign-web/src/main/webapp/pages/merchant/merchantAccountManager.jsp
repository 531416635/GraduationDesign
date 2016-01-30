<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String jsonAddrs = (String) request.getAttribute("jsonAddrs");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/redcss/address.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector2.css" />
<link href="<%=path%>/css/redcss/style.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/artDialog/dialog-plus-min.js"></script>
<link href="<%=path%>/js/artDialog/ui-dialog.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript">
var jsonAddrs =<%=jsonAddrs%>
	function check() {
	var s1 = $("#ddp").val();
	var s12 = $("#dds").val();
	var detail0 = $("#detail0").val();
	var detail1 = $("#detail1").val();
	var addressjoin = $("#addressjoin").val();
	var regZipCode=/^[1-9]\d{5}(?!\d)$/;
	var addressjoin2 = $("#addressjoin2").val();
	var regFixedTel=/\d{3}-\d{8}|\d{4}-\d{7}/;
	var regZip=/^[1-9]\d{5}(?!\d)$/;
	var regFax=/^\d{3}-\d{8}$/;
	var regEmail=/^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/;
	var regMobile=/^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
	var fixedlineTel = $("#fixedlineTel").val();
	if(s1==null||s1==""){
		var address=$("#addressjoin").val()+","+$("#detail0").val();
		if(addressjoin == null || addressjoin == "" || detail0 == null || detail0 == ""){
			$("#msgAddress").text("*号处必须填写");
	        return;
		}
	}else{
	if(s12 == null || s12 == ""){
			var address = $("#province").val()+$("#city").val()+$("#district").val()+$("#detail0").val();
		}else{
			var address=$("#dds").val();
		}
	}
	$("#ddp").val(address);	
	var s2 = $("#ddp2").val();
	var s22 = $("#dds2").val();
	if(s2==null||s2==""){
		var companyAddress =$("#addressjoin2").val() +","+$("#detail1").val();
		if(addressjoin2 == null || addressjoin2 == "" || detail1 == null || detail1 == ""){
			$("#msgCompanyAddress").text("*号处必须填写");
	        return;
		}
	}else{
		if(s22 == null || s22 == ""){
			var companyAddress = $("#province2").val()+$("#city2").val()+$("#district2").val()+$("#detail1").val();
		}else{
			var companyAddress=$("#dds2").val();
		}
	}	
		$("#companyAddress").val(companyAddress);
		
		
	//公司地址
	var district2 = $("#district2").val();
	
	
	var male = $("#gender").val();
	if(male == null || male == ""){
   		var gender = $("input:radio[name=gender]:checked").val();
   		if(gender==null || gender == ""){
     		 $("#msgGender").text("*号处必须填写");
       	return;
   		} 
   	}
   	
   	var userName = $("#userName").val();
	if(userName == null || userName ==""){
		$("#msgUserName").text("*号处必须填写");
        return;
	}
   
    var companyName=$("#companyName").val();
	if(companyName == null || companyName ==""){
		$("#msgCompanyName").text("*号处必须填写");
        return;
	}
	
	var companyTel = $("#companyTel").val();
    if(companyTel == null || companyTel ==""){
		$("#msgCompanyTel").text("*号处必须填写");
        return;
	}else{
		if(!regFixedTel.test(companyTel)){
			//格式不正确，提示错误信息
			$("#msgCompanyTel").text("公司电话格式***-********或****-*******！");
			return;
		}
	}
	
	var zipCode = $("#zipCode").val();
	if(zipCode != null && zipCode !=""){
		if(!regZipCode.test(zipCode)){
			//邮编格式不正确，提示错误信息
			$("#msgZipCode").text("邮编为6位数字！");
			return;
		}
	}
	
	var companyZip = $("#companyZip").val();
	if(companyZip == null || companyZip ==""){
		$("#msgCompanyZip").text("*号处必须填写");
        return;
	}else{
		if(!regZip.test(companyZip)){
			//邮编格式不正确，提示错误信息
			$("#msgCompanyZip").text("公司邮编为6位数字！");
			return;
		}
	}
	var email = $("#email").val();
	if(email != null && email!= ""){
		if(!regEmail.test(email)){
		//用户名格式不正确，提示错误信息
		$("#msgEmail").text("联系邮箱格式包含@！");
		return;
		}
	}
	
	var mobile = $("#tel").val();
	if(mobile!=null && mobile!=""){
		if(!regMobile.test(mobile)){
		//用户名格式不正确，提示错误信息
		$("#msgTel").text("手机号码为11位，要求以13、14、15、17、18开头！");
		return;
		}
	}
	
	var fixedlineTel = $("#fixedLineTel").val();
	if(fixedlineTel !=null && fixedlineTel !=""){
		if(!regFixedTel.test(fixedlineTel)){
		//格式不正确，提示错误信息
		$("#msgFixedlineTel").text("固话格式***-********或****-*******！");
		return;
		}
	}
	
	var fax=$("#fax").val();
	if(fax != null && fax != ""){
		if (!regFax.test(fax)) {
		$("#msgFax").text("传真格式***-********！");
		return;
		}
	}
	
	
	var companyFax=$("#companyFax").val();
	if(companyFax != null && companyFax != ""){
		if (!regFax.test(companyFax)) {
		$("#msgCompanyFax").text("传真格式***-********！");
		return;
		}
	}
    $("#form1").submit();
}

//--------------------------------------校验子账户信息	
function saveSonAccount(){
	var s1 = $("#ddp").val();
	var s2 = $("#dds").val();
	var id = $("#id").val();
    var detail0 = $("#detail0").val();
    var addressjoin = $("#addressjoin").val();
	var regZipCode=/^[1-9]\d{5}(?!\d)$/;
	var regFax=/^\d{3}-\d{8}$/;
	var regFixedTel=/\d{3}-\d{8}|\d{4}-\d{7}/;
	var regEmail=/^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/;
	var regMobile=/^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;

	var zipCode =$("#zipCode").val();
	if(zipCode != null && zipCode !=""){
		if(!regZipCode.test(zipCode)){
			//邮编格式不正确，提示错误信息
			$("#msgZipCode").text("邮编为6位数字！");
			return;
		}
	}
	
	var male = $("#gender").val();
    if(male == null || male == ""){
    	var gender = $("input:radio[name=gender]:checked").val();
    	if(gender==null || gender == ""){
      	 $("#msgGender").text("*号处必须填写");
        return;
    	} 
    }
    
    var email = $("#email").val();
	if(email != null && email!= ""){
		if(!regEmail.test(email)){
		//用户名格式不正确，提示错误信息
		$("#msgEmail").text("联系邮箱格式包含@！");
		return;
		}
	}
		
	var mobile = $("#tel").val();
	if(mobile!=null && mobile!=""){
		if(!regMobile.test(mobile)){
		//用户名格式不正确，提示错误信息
		$("#msgTel").text("手机号码为11位，要求以13、14、15、17、18开头！");
		return;
		}
	}
    
   	var fixedlineTel = $("#fixedLineTel").val();
	if(fixedlineTel !=null && fixedlineTel !=""){
		if(!regFixedTel.test(fixedlineTel)){
		//格式不正确，提示错误信息
		$("#msgFixedLineTel").text("固话格式***-********或****-*******！");
		return;
		}
	}
		
	var fax=$("#fax").val();
	if(fax != null && fax != ""){
		if (!regFax.test(fax)) {
		$("#msgFax").text("传真格式***-********！");
		return;
		}
	}
	
	if(s1==null||s1==""){
		var address=$("#addressjoin").val()+","+$("#detail0").val();
		if(addressjoin == null || addressjoin == "" || detail0 == null || detail0 == ""){
			$("#msgAddress").text("*号处必须填写");
	        return;
		}
	}else{
		if(s2 == null || s2 == ""){
			var address = $("#province").val()+$("#city").val()+$("#district").val()+$("#detail0").val();
		}else{
			var address=$("#dds").val();
		}
	}
		$("#ddp").val(address);	
		
	var userName = $("#userName").val();	
	if(userName == null || userName == ""){
		$("#msgUserName").text("*号处必须填写");
	}else{
		$("#form1").submit();
	}
}

//------------------------------------------------------------------------------------
/* //div隐显切换
$(function(){
$(".continue").click(function(){
    //找到所有的inner_div里面的div
    var div = $(".inner_div div");
    //循环div，找到处于显示状态的div将其隐藏，并将其下一个div显示
    for(var i=0;i<div.length;i++){
        if(div[i].style.display === 'block'){
            div[i].style.display = 'none';
            div[i+1].style.display = 'block';
            break;
        }
    }
});
});
$(function(){
$(".back").click(function(){
     //找到所有的inner_div里面的div
    var div = $(".inner_div div");
    //循环div，找到处于显示状态的div将其隐藏，并将其上一个div显示
    for(var i=0;i<div.length;i++){
        if(div[i].style.display == 'block'){
            div[i].style.display = 'none';
            div[i-1].style.display = 'block';
            break;
        }
    }
});
}); */
//-------下一步
function next(){
var s1 = $("#ddp").val();
	var s2 = $("#dds").val();
	var id = $("#id").val();
    var detail0 = $("#detail0").val();
    var addressjoin = $("#addressjoin").val();
	var regZipCode=/^[1-9]\d{5}(?!\d)$/;
	var regFax=/^\d{3}-\d{8}$/;
	var regFixedTel=/\d{3}-\d{8}|\d{4}-\d{7}/;
	var regEmail=/^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/;
	var regMobile=/^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
	
	var userName = $("#userName").val();	
	if(userName == null || userName == ""){
		$("#msgUserName").text("*号处必须填写");
		return;
	}

	var zipCode = $("#zipCode").val();
	if(zipCode != null && zipCode !=""){
		if(!regZipCode.test(zipCode)){
			//邮编格式不正确，提示错误信息
			$("#msgZipCode").text("邮编为6位数字！");
			return;
		};
	}
	
	var male = $("#gender").val();
    if(male == null || male == ""){
    	var gender = $("input:radio[name=gender]:checked").val();
    	if(gender==null || gender == ""){
      	 $("#msgGender").text("*号处必须填写");
        return;
    	} 
    }
    
    var email = $("#email").val();
	if(email != null && email!= ""){
		if(!regEmail.test(email)){
		//用户名格式不正确，提示错误信息
		$("#msgEmail").text("联系邮箱格式包含@！");
		return;
		}
	}
		
	var mobile = $("#tel").val();
	if(mobile!=null && mobile!=""){
		if(!regMobile.test(mobile)){
		//用户名格式不正确，提示错误信息
		$("#msgTel").text("手机号码为11位，要求以13、14、15、17、18开头！");
		return;
		}
	}
    
   	var fixedlineTel = $("#fixedLineTel").val();
	if(fixedlineTel !=null && fixedlineTel !=""){
		if(!regFixedTel.test(fixedlineTel)){
		//格式不正确，提示错误信息
		$("#msgFixedLineTel").text("固话格式***-********或****-*******！");
		return;
		}
	}
		
	var fax=$("#fax").val();
	if(fax != null && fax != ""){
		if (!regFax.test(fax)) {
		$("#msgFax").text("传真格式***-********！");
		return;
		}
	}
	
	if(s1==null||s1==""){
		var address=$("#addressjoin").val()+","+$("#detail0").val();
		if(addressjoin == null || addressjoin == "" || detail0 == null || detail0 == ""){
			$("#msgAddress").text("*号处必须填写");
	        return;
		}
	}
	$("#tab1").hide();
	$("#tab2").show();
}
//--------上一步
function back(){
	$("#tab2").hide();
	$("#tab1").show();
}

	function checkSs(id) {
		$.ajax({
			type : "POST",
			url : "provinceUrbanLinkage.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				id : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("获取失败！");
				} else {
					var json = eval(data);
					$("#city").children().remove();
					listCitys(json);
				}
			}
		});
	}
	function checkss(id) {
		$.ajax({
			type : "POST",
			url : "provinceUrbanLinkage.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				"id" : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					var json = eval(data);
					listDistrict(json);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}

	//二级显示
	function listCitys(json) {
		var option1 = $("<option value='1'></option>");
		option1.html("请选择城市");
		$("#city").append(option1);
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#city").append(option2);
		}
	};

	//三级显示
	function listDistrict(json) {
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#district").append(option2);
		}
	};

	function checkSs2(id) {
		$.ajax({
			type : "POST",
			url : "provinceUrbanLinkage.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				id : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("获取失败！");
				} else {
					var json = eval(data);
					$("#city2").children().remove();
					listCitys2(json);
				}
			}
		});
	}
	function checkss2(id) {
		$.ajax({
			type : "POST",
			url : "provinceUrbanLinkage.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				"id" : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					var json = eval(data);
					listDistrict2(json);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}

	//二级显示
	function listCitys2(json) {
		var option1 = $("<option value='1'></option>");
		option1.html("请选择城市");
		$("#city2").append(option1);
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#city2").append(option2);
		}
	};

	//三级显示
	function listDistrict2(json) {
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#district2").append(option2);
		}
	};


</script>
<style type="text/css">
div.meneame span {
	display: inline;
}

input, select {
	width: 140px;
	height: 20px;
}

.input_but {
	width: 70px;
	height: 20px;
}

.input_radio {
	width: 13px;
	height: 13px;
}

tr {
	height: 35px;
}

td {
	padding-right: 10px;
}
</style>
</head>

<body>


	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">账户管理 ></span><span
				class="lo2">账户信息</span>
		</div>
		<br />
		<div class="detail_list">
			<%-- <ul id="tabs">
				<li>基本信息</li>
				<c:if test="${user.parentID==0 || user.parentID==null}">
				<li>公司信息</li>
				<!-- <li><a href="#" title="tab3">资料认证</a></li> -->
				</c:if>
			</ul> --%>
			<div id="content">

				<form action="completeMerchantAccountInfo.do"
					enctype="multipart/form-data" method="post" id="form1">

					<div id="tab1">
						<h3>基本信息</h3>
						<p align="right">
							<span style="color: red;">*</span>表示必填项
						</p>
						<span id="msg" style="color: red;"></span>
						<table>
							<tr>
								<td style="width: 5px;"><input type="hidden" id="id"
									name="id" value="${user.id}" /> <input type="hidden"
									name="companyId" value="${user.companyId}" /> <input
									type="hidden" name="userType" value="${user.userType}" /> <span
									style="color: red;">*</span></td>
								<td>姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><c:choose>
										<c:when test="${user.userName!=null}">
											<input type="hidden" id="userName" name="userName"
												value="${user.userName}" />
						${user.userName}
						</c:when>
										<c:otherwise>
											<input id="userName" name="userName" value="${user.userName}" />
										</c:otherwise>
									</c:choose> <span id="msgUserName" style="color: red;"></span></td>
							</tr>
							<tr>
								<td><span style="color: red;">*</span></td>
								<td>性别： <input type="hidden" value="${user.gender}"
									id="gender" />
								</td>
								<td><c:if test="${user.gender != null}">
										<c:if test="${user.gender == 1}">
											<span><input type="hidden" name="gender" value="1" />先生</span>
										</c:if>
										<c:if test="${user.gender == 2}">
											<span><input type="hidden" name="gender" value="2" />女士</span>
										</c:if>
									</c:if> <c:if test="${user.gender == null}">
										<input class="input_radio" type="radio" name="gender"
											value="1" checked="checked" />
										<span>先生</span>
										<input class="input_radio" type="radio" name="gender"
											value="2" />
										<span>女士</span>
									</c:if> <span id="msgGender" style="color: red;"></span></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>公司职务：</td>
								<td><c:if
										test="${user.companyPlant!=null && user.companyPlant!='' }">
										<input type="hidden" id="companyPlant" name="companyPlant"
											value="${user.companyPlant}" />${user.companyPlant}
							</c:if> <c:if
										test="${user.companyPlant ==null || user.companyPlant =='' }">
										<input type="text" id="companyPlant" name="companyPlant"
											value="${user.companyPlant}" />
									</c:if> <span id="msgCompanyPlant" style="color: red;"></span></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>联系邮箱：</td>
								<td><c:choose>
										<c:when test="${user.email != null && user.email != ''}">
											<input type="hidden" name="email" value="${user.email}" />${user.email}
						</c:when>
										<c:otherwise>
											<input id="email" type="text" name="email"
												value="${user.email}" />
										</c:otherwise>
									</c:choose> <span id="msgEmail" style="color: red;"></span></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>联系手机</td>
								<td><c:choose>
										<c:when test="${user.tel != null && user.tel != ''}">
											<input type="hidden" name="tel" value="${user.tel}" />${user.tel}
						</c:when>
										<c:otherwise>
											<input type="text" id="tel" name="tel" value="${user.tel}" />
										</c:otherwise>
									</c:choose> <span id="msgTel" style="color: red;"></span></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>固定电话：</td>
								<td><c:choose>
										<c:when
											test="${user.fixedLineTel != null && user.fixedLineTel != ''}">
											<input type="hidden" name="fixedLineTel" id="fixedLineTel"
												value="${user.fixedLineTel}" />${user.fixedLineTel}
						</c:when>
										<c:otherwise>
											<input type="text" id="fixedLineTel" name="fixedLineTel"
												value="${user.fixedLineTel}" />
										</c:otherwise>
									</c:choose> <span id="msgFixedLineTel" style="color: red;"></span></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>传真：</td>
								<td><c:choose>
										<c:when test="${user.fax != null && user.fax != ''}">
											<input type="hidden" name="fax" value="${user.fax}" />${user.fax}
						</c:when>
										<c:otherwise>
											<input type="text" id="fax" name="fax" value="${user.fax}" />
										</c:otherwise>
									</c:choose> <span id="msgFax" style="color: red;"></span></td>
							</tr>
							<tr>
								<td><span style="color: red;">*</span></td>
								<td>联系地址：</td>
								<td><c:if
										test="${user.address == null || user.address == ''}">
										<%-- <select id="province"
							name="province" onblur="checkSs(this.value)">
							<option value="1">请选择省份</option>
							<c:forEach items="${dictionarys}" var="d">
								<option value="${d.id}">${d.dicName}</option>
							</c:forEach>
						</select> 
						<select id="city" name="city"
							onblur="if(this.value!=1){checkss(this.value);}">
							<option value="1">请选择城市</option>
						</select> 
						<select id="district" name="district"
							onblur="if(this.value!=1){checkss(this.value);}">
							<option value="1">请选择地区</option>
						</select>
						<input id="detail0" type="text" name="detail0" value="详细地址"
							onfocus="if(this.value=='详细地址') {this.value='';}"
							onblur="if(this.value=='') {this.value='详细地址';}"
							/>  --%>
										<div class="dd">
											<div id="store-selector">
												<div class="text">
													<div></div>
													<b></b><input type="hidden" id="addressjoin" value="" />
												</div>
												<div onclick="$('#store-selector').removeClass('hover')"
													class="close"></div>
											</div>
											<div id="store-prompt">
												<strong></strong>
											</div>
										</div>

										<input style="width: 500px; height: 50px;" type="text"
											id="detail0" name="detail0" placeholder="详细地址" />
									</c:if> <input type="hidden" id="ddp" name="address"
									value="${user.address}" /> <c:if
										test="${user.address != null && user.address != ''}">
										<input type="hidden" id="province" value="${provice.dicName}" />${provice.dicName}
							<input type="hidden" id="city" value="${city.dicName}" />${city.dicName}
							<input type="hidden" id="district" value="${district.dicName}" />${district.dicName}
							<input type="hidden" id="detail0" value="${detail0}" />${detail0}
							<input type="hidden" id="dds" value="${address}" />${address}
						</c:if> <span id="msgAddress" style="color: red;"></span></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>邮编：</td>
								<td><c:choose>
										<c:when test="${user.zipCode != null && user.zipCode != ''}">
											<input type="hidden" name="zipCode" value="${user.zipCode}" />${user.zipCode}
						</c:when>
										<c:otherwise>
											<input type="text" id="zipCode" name="zipCode"
												value="${user.zipCode}" />
										</c:otherwise>
									</c:choose> <span id="msgZipCode" style="color: red;"></span></td>
							</tr>
						</table>
						<c:if test="${user.parentID!=null && user.parentID != ''}">
							<input class="input_but orange" type="button" value="保存"
								onclick="saveSonAccount();" />
							<span id="msg2" style="color: red"></span>
						</c:if>
						<c:if test="${user.parentID==null || user.parentID == ''}">
							<input class=" continue input_but orange" type="button"
								value="下一步" onclick="next();" />
						</c:if>
					</div>
					<input type="hidden" name="companyStatus"
						value="${user.companyStatus}" /> <input type="hidden"
						name="parentID" value="${user.parentID}" />
					<c:if test="${user.parentID==0 || user.parentID==null}">
						<div id="tab2">
							<h3>公司信息</h3>
							<p align="right">
								<span style="color: red;">*</span>表示必填项
							</p>
							<input type="hidden" name="companyId" value="${companys.id}" />
							<input type="hidden" name="status" value="${companys.status}" />
							<table>
								<tr>
									<td style="width: 5px;"><span style="color: red;">*</span></td>
									<td><b style="font-weight: bold;"> 公司名称：</b></td>
									<td colspan="3"><c:choose>

											<c:when
												test="${companys.companyName != null && companys.companyName != ''}">
												<input type="hidden" name="companyName" id="companyName"
													value="${companys.companyName}" />${companys.companyName}
					</c:when>
											<c:otherwise>
												<input type="text" name="companyName" id="companyName"
													value="${companys.companyName}" />
											</c:otherwise>
										</c:choose> <span id="msgCompanyName" style="color: red;"></span></td>
								</tr>
								<tr>
									<td><span style="color: red;">*</span></td>
									<td><b style="font-weight: bold;">公司地址：</b> <%-- <input type="hidden" name="companyAddress" id="companyAddress" value="${companys.companyAddress}"/> --%>
									</td>
									<td colspan="3"><c:if
											test="${companys.companyAddress == null || companys.companyAddress == ''}">
											<%-- <select id="province2"
						 onblur="checkSs2(this.value)">
						<option value="1">请选择省份</option>
						<c:forEach items="${dictionarys}" var="d">
							<option value="${d.id}">${d.dicName}</option>
						</c:forEach>
					</select> <select id="city2" name="city2"
						onblur="if(this.value!=1){checkss2(this.value);}">
						<option value="1">请选择城市</option>
					</select> <select id="district2" name="district2"
						onblur="if(this.value!=1){checkss2(this.value);}">
						<option value="1">请选择地区</option>
					</select>
					<input id="detail1" type="text" name="detail1" value="详细地址"
							onfocus="if(this.value=='详细地址') {this.value='';}"
							onblur="if(this.value=='') {this.value='详细地址';}"
							/>  --%>
											<div class="dd2">
												<div id="store-selector2">
													<div class="text2">
														<div></div>
														<b></b><input type="hidden" id="addressjoin2" value="" />
													</div>
													<div onclick="$('#store-selector2').removeClass('hover')"
														class="close2"></div>
												</div>
												<div id="store-prompt2">
													<strong></strong>
												</div>
											</div>

											<input style="width: 500px; height: 50px;" id="detail1"
												type="text" name="detail1" placeholder="详细地址" />
										</c:if> <input type="hidden" id="ddp2" name="companyAddress"
										value="${companys.companyAddress}" /> <c:if
											test="${companys.companyAddress != null && companys.companyAddress != ''}">
											<input type="hidden" id="province2"
												value="${provice2.dicName}" />${provice2.dicName}
						<input type="hidden" id="city2" value="${city2.dicName}" />${city2.dicName}
						<input type="hidden" id="district2" value="${district2.dicName}" />${district2.dicName}
						<input type="hidden" id="detail1" value="${detail1}" />${detail1}
						<input type="hidden" id="dds2" value="${companyAddress}" />${companyAddress}
					</c:if> <span id="msgCompanyAddress" style="color: red;"></span></td>
								</tr>
								<tr>
									<td><span style="color: red;">*</span></td>
									<td><b style="font-weight: bold;">公司电话：</b></td>
									<td colspan="3"><c:choose>
											<c:when
												test="${companys.companyTel != null && companys.companyTel != ''}">
												<input type="hidden" name="companyTel" id="companyTel"
													value="${companys.companyTel}" />${companys.companyTel}
					</c:when>
											<c:otherwise>
												<input type="text" name="companyTel" id="companyTel"
													value="${companys.companyTel}" />
											</c:otherwise>
										</c:choose> <span id="msgCompanyTel" style="color: red;"></span></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><b style="font-weight: bold;">公司传真：</b></td>
									<td colspan="3"><c:if
											test="${companys.companyFax == null || companys.companyFax == '' }">
											<input type="text" id="companyFax" name="companyFax"
												value="${companys.companyFax}" />
										</c:if> <c:if
											test="${companys.companyFax != null && companys.companyFax != '' }">
											<input type="hidden" name="companyFax"
												value="${companys.companyFax}" />${companys.companyFax}
							</c:if> <span id="msgCompanyFax" style="color: red;"></span></td>
								</tr>
								<tr>
									<td><span style="color: red;">*</span></td>
									<td><b style="font-weight: bold;">公司邮编：</b></td>
									<td colspan="3"><c:choose>
											<c:when
												test="${companys.companyZipCode != null && companys.companyZipCode != ''}">
												<input type="hidden" id="companyZip" name="companyZip"
													value="${companys.companyZipCode}" />${companys.companyZipCode}
					</c:when>
											<c:otherwise>
												<input type="text" name="companyZipCode" id="companyZip"
													value="${companys.companyZipCode}" />
											</c:otherwise>
										</c:choose> <span id="msgCompanyZip" style="color: red;"></span></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><b style="font-weight: bold;">公司网址：</b></td>
									<td colspan="3"><c:if
											test="${companys.companyWebsite == null || companys.companyWebsite == ''}">
											<input type="text" id="" name="companyWebsite"
												value="${companys.companyWebsite}" />
										</c:if> <c:if
											test="${companys.companyWebsite != null && companys.companyWebsite != ''}">
											<input type="hidden" name="companyWebsite"
												value="${companys.companyWebsite}" />${companys.companyWebsite}
						</c:if> <span id="msgCompanyWebsite" style="color: red;"></span></td>
								</tr>
								<tr style="background-color: #e5e5e5; height: 25px;">
									<td colspan="4"><b style="font-weight: bold;">公司规模</b></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><b style="font-weight: bold;">员工数量：</b></td>
									<td><c:if
											test="${companys.companyScale == null || companys.companyScale == ''}">
											<select name="companyScale">
												<option value="" selected="selected">请选择员工数</option>
												<option value="1">10人以下</option>
												<option value="2">10-50(人)</option>
												<option value="3">50-100(人)</option>
												<option value="4">100人以上</option>
											</select>&nbsp; 
								</c:if> <c:if
											test="${companys.companyScale != null && companys.companyScale != ''}">
											<c:choose>
												<c:when test="${companys.companyScale == 0}">请选择员工数</c:when>
												<c:when test="${companys.companyScale == 1}">10人以下</c:when>
												<c:when test="${companys.companyScale == 2}">10-50(人)</c:when>
												<c:when test="${companys.companyScale == 3}">50-100(人)</c:when>
												<c:when test="${companys.companyScale == 4}">100人以上</c:when>
											</c:choose>
								&nbsp; 
								</c:if></td>
									<td><b style="font-weight: bold;">注册资本：</b></td>
									<td><c:if
											test="${companys.registeredCapital == null || companys.registeredCapital == ''}">
											<select name="registeredCapital">
												<option value="" selected="selected">请选择注册资本</option>
												<option value="1">50万以下(元)</option>
												<option value="2">50-100万(元)</option>
												<option value="3">100-500万(元)</option>
												<option value="4">500万以上(元)</option>
											</select>&nbsp;
								</c:if> <c:if
											test="${companys.registeredCapital != null && companys.registeredCapital != ''}">
											<c:choose>
												<c:when test="${companys.registeredCapital == 0}">请选择注册资本</c:when>
												<c:when test="${companys.registeredCapital == 1}">50万以下(元)</c:when>
												<c:when test="${companys.registeredCapital == 2}">50-100万(元)</c:when>
												<c:when test="${companys.registeredCapital == 3}">100-500万(元)</c:when>
												<c:when test="${companys.registeredCapital == 4}">500万以上(元)</c:when>
											</c:choose>
								&nbsp;
								</c:if></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><b style="font-weight: bold;">配送车辆：</b></td>
									<td><c:if
											test="${companys.distributionCar == null || companys.distributionCar == ''}">
											<select name="distributionCar">
												<option value="" selected="selected">请选择配送车辆</option>
												<option value="1">5辆以下</option>
												<option value="2">5-10辆</option>
												<option value="3">10-20辆</option>
												<option value="4">20辆以上</option>
											</select>&nbsp;
								</c:if> <c:if
											test="${companys.distributionCar != null && companys.distributionCar != ''}">
											<c:choose>
												<c:when test="${companys.distributionCar == 0}">请选择配送车辆</c:when>
												<c:when test="${companys.distributionCar == 1}">5辆以下</c:when>
												<c:when test="${companys.distributionCar == 2}">5-10辆</c:when>
												<c:when test="${companys.distributionCar == 3}">10-20辆</c:when>
												<c:when test="${companys.distributionCar == 4}">20辆以上</c:when>
											</c:choose>
								&nbsp;
								</c:if></td>
									<td><b style="font-weight: bold;">食堂数量：</b></td>
									<td><c:if
											test="${companys.diningRoomNumber == null || companys.diningRoomNumber == ''}">
											<select name="diningRoomNumber">
												<option value="" selected="selected">请选择食堂数量</option>
												<option value="1">10家以下</option>
												<option value="2">10-20家</option>
												<option value="3">20-50家</option>
												<option value="4">50家以上</option>
											</select>
										</c:if> <c:if
											test="${companys.diningRoomNumber != null && companys.diningRoomNumber != ''}">
											<c:choose>
												<c:when test="${companys.diningRoomNumber == 0}">请选择食堂数量</c:when>
												<c:when test="${companys.diningRoomNumber == 1}">10家以下</c:when>
												<c:when test="${companys.diningRoomNumber == 2}">10-20家</c:when>
												<c:when test="${companys.diningRoomNumber == 3}">20-50家</c:when>
												<c:when test="${companys.diningRoomNumber == 4}">50家以上</c:when>
											</c:choose>

										</c:if></td>
								</tr>

							</table>
							<br /> <input type="button" value="上一步"
								class="back input_but orange" onclick="back();" />&nbsp;&nbsp;
							<input type="button" value="保存" class="input_but orange"
								onclick="check();" />
						</div>
					</c:if>
			</div>
			</form>
		</div>
	</div>
	</div>

	<script>
	$(document).ready(function() {
			$("#tab1").hide();
			$("#tab2").hide();
			$("#content div:first").fadeIn();
			$("#Pagination").show(); // Show first tab content
			$("#store-selector").show();
			$("#store-selector2").show();
			$(".dd").show();
			$(".dd2").show();
			$("#store-prompt").show();
			$("#store-prompt2").show();
			
			/* $('#tabs a').click(function(e) {
				e.preventDefault();
				$("#tab1").hide();
				$("#tab2").hide();
				var ids1 = '#' + $(this).attr('title');
				$(ids1).fadeIn();
				$("#Pagination").show();
				$("#store-selector").show();
				$("#store-selector2").show();
				$(".dd").show();
				$(".dd2").show();
				$("#store-prompt").show();
				$("#store-prompt2").show();
			}); */
		});
	</script>
	<script type="text/javascript" src="<%=path%>/js/redjs/selector.js"></script>
	<script type="text/javascript" src="<%=path%>/js/redjs/selector2.js"></script>
</body>
</html>
