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
	String inquiryId = request.getParameter("inquiryId");
	String json = (String) request.getAttribute("json");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript">
	var AddSuppliers=function(){
		var fileIds=''; 
		$("input[name=priceSheetID]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0)
		{
			alert("请选择");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		var tmp=fileIds.split('|');
		var ids=tmp[0];
		var status=tmp[1];
		var companyProductId=tmp[2];
		if(ids==null || ids=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		$.ajax({
		type : "POST",
		url : "AddSuppliers.do",
		dataType : "text",
		data : {
			"companyProductId":companyProductId
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			if(json.result="true")
			{
  				window.location.reload();
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					case "2":
					alert("请进行企业认证！");
				    window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
					break;
				}
			}
		}
		});
	};

	var toBargaining=function(){
		var fileIds=''; 
		$("input[name=priceSheetID]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0)
		{
			alert("请选择");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		var tmp=fileIds.split('|');
		var ids=tmp[0];
		var status=tmp[1];
		//alert(ids);
		//alert(status);
		if(ids==null || ids=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		if(status!='0')
		{
			alert("该订单已经议价，不能重复议价");
		}
		else
		{
			location.href = "toBargaining.do?ids="+ids;
		}		
	};
	function AddOrder() {
	//ajax存入报价单
		var fileIds=''; 
		$("input[name=priceSheetID]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0)
		{
			alert("没有选择可以操作的项");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		var tmp=fileIds.split('|');
		var ids=tmp[0];
		var status=tmp[1];
		if(ids==null || ids=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		$.ajax({
		type : "POST",
		url : "AddOrder.do",
		dataType : "text",
		data : {
			"ids" : ids
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			if(json.result="true")
			{
				//location.href = "deletePriceSheetInfo.do?id="+ids;
				location.href = "splitPriceSheet.do?id="+json.orderId;
			}	
			else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					case "2":
					alert("请进行企业认证！");
				    window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
								break;
							}
						}
					}
				});
	}
</script>
<style type="text/css">
.qrtj {
	background-color: red;
	height: 30px;
	width: 120px;
	margin-left: 20%;
	font-size: 14px;
	color: white;
}

.swmr {
	background-color: red;
	height: 30px;
	width: 120px;
	margin-left: 5%;
	font-size: 14px;
	color: white;
}

#fqyj {
	background-color: orange;
	height: 30px;
	width: 120px;
	margin-left: 5%;
	font-size: 14px;
	color: white;
}

#t { /*background: #D0D0D0;*/
	
}

table {
	border: 1px solid #D0D0D0;
}

tr {
	height: 32px;
}
/* thead {
	border-top: 3px solid #D0D0D0;
}

td {
	float: left;
	height: 50px;
	line-height: 50px
} 

tbody {
	height: 50px;
}  */
</style>
</head>

<body>
	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">询价管理 ></span><span
				class="lo2">我的报价单></span><span
				class="lo3">商品资质</span>
		</div>
		<%-- <c:if test="${!empty priceSheet}"> --%>
		<div>
			<table width="100%" border="0" cellspacing="0" align="center">
				<c:forEach items="${productsCertificate }" var="dis">
					<tr>
						<td><c:if test="${dis.fileClass==100||dis.fileClass==2 }">食品安全资质：</c:if>
						<c:if test="${dis.fileClass==101||dis.fileClass==3 }">生产许可证：</c:if>
						<c:if test="${dis.fileClass==102||dis.fileClass==4 }">QS商城许可证：</c:if>
						<c:if test="${dis.fileClass==103||dis.fileClass==5 }">检测报告：</c:if>
						<c:if test="${dis.fileClass==104||dis.fileClass==6 }">品牌资质授权：</c:if>
						<c:if test="${dis.fileClass==105||dis.fileClass==7 }">厂家代理授权：</c:if>
						
						</td>

						<td><c:if test="${dis.fileClass==100||dis.fileClass==2 }">
								<img id="img" src="<%=path%>${dis.filePath }" alt="Thumbnail 1"
									class="zoom-tiny-image" />
							</c:if>
							<c:if test="${dis.fileClass==101||dis.fileClass==3 }">
								<img id="img" src="<%=path%>${dis.filePath }" alt="Thumbnail 1"
									class="zoom-tiny-image" />
							</c:if>
							<c:if test="${dis.fileClass==102||dis.fileClass==4 }">
								<img id="img" src="<%=path%>${dis.filePath }" alt="Thumbnail 1"
									class="zoom-tiny-image" />
							</c:if>
							<c:if test="${dis.fileClass==103||dis.fileClass==5 }">
								<img id="img" src="<%=path%>${dis.filePath }" alt="Thumbnail 1"
									class="zoom-tiny-image" />
							</c:if>
							<c:if test="${dis.fileClass==104||dis.fileClass==6 }">
								<img id="img" src="<%=path%>${dis.filePath }" alt="Thumbnail 1"
									class="zoom-tiny-image" />
							</c:if>
							<c:if test="${dis.fileClass==105||dis.fileClass==7 }">
								<img id="img" src="<%=path%>${dis.filePath }" alt="Thumbnail 1"
									class="zoom-tiny-image" />
							</c:if>
						</td>
						<br />
				</c:forEach>
			</table>
		</div>



	</div>




</body>
</html>
