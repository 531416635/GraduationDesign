
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"	
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String productlist = (String)request.getAttribute("productLists");
	String jsonPages = (String)request.getAttribute("jsonPages");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>一起采</title>
	<link rel="stylesheet" type="text/css"
		href="<%=path%>/css/frontcss/houtai.css" />
	<link rel="stylesheet" type="text/css"
		href="<%=path%>/css/frontcss/detail.css" />
	<script type="text/javascript"
		src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
	<script type="text/javascript"
		src="<%=path%>/js/redjs/jquery.pagination.js"></script>
	<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
	<script type="text/javascript"
		src="<%=path%>/js/artDialog/dialog-plus-min.js"></script>
	<link href="<%=path%>/js/artDialog/ui-dialog.css" rel="stylesheet"
		type="text/css" />
	<script type="text/javascript">
	   $(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品;
	  	var json = eval(<%=jsonPages%>);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination").pagination(json.rows, { //创建分页按钮
			current_page: json.currentPage-1,
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		location.href="/ssm/merchant/toProductEdit4.do?currentPage="+(page_index+1);
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	}); 
	
	function showProductSafetyPic(id,productId){
	var productLists =<%=productlist%>;
	var titles = '商品名称：';
	var contents1 = '<div id="productId'+productId+'"><table style="width: 100%"><thead><tr><th width="120">资质名称</th><th width="100">审核状态</th></tr></thead><tbody>';
	var contents2='<select name="fileUpload" id="fileUpload">';
	var fileStyle = '';
	var fileStatus = '';
	var conditions = '2,3,4,5,6,7';
	
	for(var i=0;i<productLists.length;i++){
	if(productLists[i].productId==productId){
	titles+=productLists[i].productName;
	for(var j=0;j<productLists[i].companyProductPics.length;j++){
	switch(productLists[i].companyProductPics[j].fileClass){
	case 2:fileStyle='食品安全资质'; break;
	case 3: fileStyle='生产许可证'; break;
	case 4: fileStyle='QS商城许可证'; break;
	case 5: fileStyle='检测报告'; break;
	case 6: fileStyle='品牌资质授权'; break;
	case 7: fileStyle='厂家代理授权'; break;
	}
	switch(productLists[i].companyProductPics[j].status){
	case 0: fileStatus = '待审批';conditions=conditions.replace(productLists[i].companyProductPics[j].fileClass+((productLists[i].companyProductPics[j].fileClass==7)?"":","),""); break;
	case 1: fileStatus = '审批通过';conditions=conditions.replace(productLists[i].companyProductPics[j].fileClass+((productLists[i].companyProductPics[j].fileClass==7)?"":","),""); break;
	case 2: fileStatus = '审批无效'; break;
	}
	contents1+='<tr><td>'+fileStyle+'</td><td>'+fileStatus+'</td></tr>';
	};
	};
	}
	var conditionList =conditions.split(',');
	for(var i=0;i<conditionList.length;i++){
	switch(conditionList[i]){
	case '2': contents2+='<option value="2">食品安全资质</option>'; break;
	case '3': contents2+='<option value="3">生产许可证</option>'; break;
	case '4': contents2+='<option value="4">QS商城许可证</option>'; break;
	case '5': contents2+='<option value="5">检测报告</option>'; break;
	case '6': contents2+='<option value="6">品牌资质授权</option>'; break;
	case '7': contents2+='<option value="7">厂家代理授权</option>'; break;
	}
	}
	if(conditions==""){
	contents2='';
	}else{
	contents2+='</select><input type="file" id="imgFile" name="file"/><input type="button" value="上传" onclick="fileUpload('+id+','+productId+');" id="upLoadBtn"/>';
	}
	contents1+='</tbody></table><div id="condition'+productId+'">'+contents2+'</div></div>';
   var d = dialog({
   				 title: titles,
   			 	content: contents1
				});
	d.show();
	 
	}
	function fileUpload(id,productId){
		var fileStyle='';
		var fileStyle=$("#fileUpload option:selected").val();
		if($("#imgFile").val()!=null&&$("#imgFile").val()!=""){
		$.ajaxFileUpload({
 			dataType : "text",
			type : "POST",
			url : "uploadSafetyfile.do",
			secureuri : false,  
            fileElementId:'imgFile',// 上传控件的id  
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				fileClass : fileStyle,
				companyProductId : id
			},
			success : function(data) {
			if(data=="false"){
			var d = dialog({
   				 title: '友情提示',
   			 	content: '提交失败请稍后重试！'
				});
			d.show();
			}else{
			var safetyFile = eval('(' + data.replace("<pre>","").replace("</pre>","") + ')');
			switch(safetyFile.fileClass){
				case 2:	fileStyle='食品安全资质'; break;
				case 3: fileStyle='生产许可证'; break;
				case 4: fileStyle='QS商城许可证'; break;
				case 5: fileStyle='检测报告'; break;
				case 6: fileStyle='品牌资质授权'; break;
				case 7: fileStyle='厂家代理授权'; break;
			}
			$("#productId"+productId+" table tbody").html($("#productId"+productId+" table tbody").html()+'<tr><td>'+fileStyle+'</td><td>待审批</td></tr>');	
			$("#fileUpload ")
			}
			}
		});
		}else{
		alert("请先填加文件！");
	} 
	}
</script>
	<style type="text/css">
#qr {
	background-color: orange;
	height: 25px;
	width: 100px;
	margin-left: 40%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

td {
	text-align: center;
}

th {
	background-color: #e5e5e5;
	border: 1px solid #999;
}

tr {
	border: 0.5px solid #999;
}

img {
	margin-top: 3px;
}
</style>
</head>
<body>
	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2"> 商品管理 ></span><span
				class="lo2"> 供应申请管理</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<!-- <li><a href="#" title="tab1">新品申请管理</a>
				</li> -->
				<li><a href="#" title="tab2">供应申请管理</a></li>

			</ul>
			<div id="content">
				<div id="tab1">
					<table style="width: 100%">
						<thead>
							<tr>
								<th width="120">商品名称</th>
								<th width="200">申请时间</th>
								<th width="100">申请状态</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${productList}" var="p">
								<tr>
									<td>${p.productName}</td>
									<td align="center"><fmt:formatDate
											value="${p.requestTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td><c:choose>
											<c:when test="${p.status==3}">
												<a
													href="javascript:showProductSafetyPic(${p.id},${p.productId});">待审批</a>
											</c:when>
											<c:when test="${p.status==0 or p.status==1}">审批通过</c:when>
											<%-- <c:when test="${p.status==2}"><a href="javascript:showProductSafetyPic(${p.id},${p.productId});">审批中</a></c:when> --%>
											<c:when test="${p.status==4}">审批无效</c:when>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%-- <c:forEach items="${productLists}" var="p">
					<div id="div_${p.id}_product1" >
					<table style="width: 100%">
						<thead>
							<tr>
								<th width="120">商品图片</th>
								<th width="200">图片状态</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${p.companyProductPics}" var="p2">
								<tr>
									<td><img src="<%=path%>/${p2.filePath}" width="100" height="100" /></td>
										<td>
										<c:choose>
										<c:when test="${p2.status==0}">待审批</c:when>
										<c:when test="${p2.status==1}">待审通过</c:when>
										<c:when test="${p2.status==2}">待审无效</c:when>
										</c:choose>
										</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
					</c:forEach> --%>
				</div>

				<%-- <div id="tab2">
					<table style="width: 100%">
						<thead>
							<tr>		
								<th width="120">商品名称</th>
								<th width="200">申请时间</th>
								<th width="100">申请状态</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${productLists2}" var="pp">
								<tr>
									<td>${pp.productName}</td>
								<td align="center"><fmt:formatDate value="${pp.requestTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>
								<c:choose>
								<c:when test="${pp.status==0}"><a href="javascript:showProductSafetyPic(${pp.id})">待审批</a></c:when>
								<c:when test="${pp.status==1}">审批通过</c:when>
								<c:when test="${pp.status==2}"><a href="javascript:showProductSafetyPic(${pp.id})">审批中</a></c:when>
								<c:when test="${pp.status==3}">审批无效</c:when>
								</c:choose>
								</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:forEach items="${productLists2}" var="pp">
					<div id="div_${pp.id}_product2" >
					${pp.id}
					<table style="width: 100%">
						<thead>
							<tr>
								<th width="120">商品图片</th>
								<th width="200">图片状态</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pp.companyProductPics}" var="pp2">
								<tr>
									<td><img src="<%=path%>/${pp2.filePath}" width="100" height="100" /></td>
										<td>
										<c:choose>
										<c:when test="${pp2.status==0}">待审批</c:when>
										<c:when test="${pp2.status==1}">待审通过</c:when>
										<c:when test="${pp2.status==2}">待审无效</c:when>
										</c:choose>
										</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
					</c:forEach>
				</div> --%>

			</div>
			<div id="page">
				<div id="Pagination" class="meneame" style="clear: left"></div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
