<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
   
%>
<link rel="stylesheet" type="text/css"	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css" type="text/css" />
<link rel="stylesheet" type="text/css"	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"	href="<%=path%>/css/frontcss/public.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
var showShoppingCart=function(CompanyID,DepartmentID,ProductID,AddressID){
window.location.href='<%=path%>/merchant/CompanyShoppingCarItem.do?companyId='+CompanyID+'&departId='+DepartmentID+'&productId='+ProductID+'&addressId='+AddressID;
};
var AddInquiry = function() {
	//获取选中radio的值
	var fileIds ="";
	$('input[name=shoppingIds]:checked').each(function() {			
			var tmp=$(this).val().split('|');
			//${c.CompanyID}|${c.DepartmentID}|${c.ProductID}
			fileIds += "{id:"+tmp[0]+ ",num:"+tmp[1]+",addressId:'"+tmp[2]+"',companyId:"+tmp[3]+",departId:"+tmp[4]+",productId:"+tmp[5]+"},";			
	});
	if(fileIds.length==0)
	{
		alert("请选择");
		return;
	}
	fileIds = fileIds.substring(0, fileIds.length - 1);
	fileIds="["+fileIds+"]"; 
	$.ajax({
		type : "POST",
		url : "AddInquiry.do",
		dataType : "text",
		data : {
			"shoppingIds":fileIds,
		},
		success : function(data) {
			//提示问题内容		
			var json = eval('(' + data + ')');
			if (json.result="true") {
				//跳转
				window.location.href= "<%=path%>/merchant/myInquiry.do";
		}
	  }
	});
};
</script>
<style type="text/css">
#h{
	margin-top:30px;
	margin-bottom:30px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid;
	color: red;
}
#xun{
    background-color:red;
	height: 30px;
	width: 140px;
	margin-left: 80%;
	font-size: 14px;
	color: white;

}
#t{
	background:#D0D0D0;
}
#qrtj{
	background-color:orange;
	height: 30px;
	width: 140px;
	margin-left: 45%;
	font-size: 14px;
	color: white;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2"></span> 商品管理 > <span class="lo2">部门购物车</span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			送至&nbsp;<input type="text" />提示：请选择你的收货区域，查看更准确的信息
		</div>
		<div>
		<img alt="" src="<%=path%>/images/shoppingCar.png">部门购物车
		</div><br/>
		
		<div>
			<table width="100%" border="1" cellspacing="0" align="center">
			<thead>
				<tr id="t">
					<th style="display: none">ID</th>
					<th>选择商品 </th>
					<th>部门</th>
					<th>图片</th>
					<th>商品名称</th>
					<th>配送地址</th>
					<th>数量</th>
					<th>品牌</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${list}" var="c">
					<tr>
						<td><input type="checkbox" name="shoppingIds" id="shoppingIds" value="${c.ProductID}|${c.sumNum}|${c.address}|${c.CompanyID}|${c.DepartmentID}|${c.ProductID}"/></td>
						<td>${c.DepartmentName}</td>
						<td><img src="<%=path%>${c.FilePath}" style="height: 50px;width: 30px;"></td>
						<td><input type="hidden" name="ProductName" value="${c.ProductName}"/>${c.ProductName}</td>
						<td>${c.AddressName}</td>
						<td><input type="text" name="ProductQuantity" value="${c.sumNum}"/></td>
						<td>${c.BrandName}</td>
						<td><input type="button" value="查看详情" onclick="showShoppingCart(${c.CompanyID},${c.DepartmentID},${c.ProductID},'${c.address}')"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		</div>
		<div class="pagin">
			<div class="message">
				共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<c:choose>
					<c:when test="${page.currentPage==1}">
						<li class="paginItem current"><a href="#"><span
								class="pagepre"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/merchant/CompanyShoppingCar.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
								class="pagepre"></span> </a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a></li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/merchant/CompanyShoppingCar.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/merchant/CompanyShoppingCar.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<input type="button" id="xun" value="询价" onclick="AddInquiry();"/>
	</div>
	
	<hr id="h"/>




</body>
</html>
