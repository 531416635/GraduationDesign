<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script language="javascript" type="text/javascript">
	//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor({
			fullPanel : true
		}).panelInstance('content', {
			hasPanel : true
		}).removeInstance('content');
	});
	function findCompanyProductPrice() {

	}
</script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: right;
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
/* div {
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left:30%;
	margin-left: -50px;
} */
#div1 {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 20%;
	margin-left: -50px;
	width: 80%;
}
</style>
</head>
<body onload="findCompanyProductPrice();">
	<div id=div1>


		<form action="findSupplier.do" method="post">
			<table border="0" cellpadding="0" cellspacing="0"
				style="text-align: left; margin: 0px; padding: 0px; width: 90%; margin-bottom: 30px;">
				<%-- <tr>
				<th>商品ID:</th>
				<td>
				<span>${product.id}</span>
				</td>
			
			</tr> --%>
				<tr>
					<th width="80px">商品名称：</th>
					<td><span>${product.productName}</span></td>
					<th width="80px">商品单价：</th>
					<td><span>${product.unitPrice}</span></td>

				</tr>
				<tr>
					<th>首页推荐：</th>
					<td><c:if test="${product.isHomeShow==1}">是</c:if> <c:if
							test="${product.isHomeShow==0}">否</c:if></td>
					<th>二级推荐：</th>
					<td><c:if test="${product.isSubPageShow==1}">是</c:if> <c:if
							test="${product.isSubPageShow==0}">否</c:if></td>
				</tr>
				<tr>
					<th>热销推荐：</th>
					<td colspan="3"><c:if test="${product.isHotShow==1}">是</c:if>
						<c:if test="${product.isHotShow==0}">否</c:if></td>
				</tr>
				<tr>
					<th>商品品类：</th>
					<td><c:forEach items="${productCategoryItems}" var="p3">
							<c:if test="${p3.parentCateGory==null}">
								<c:forEach items="${productCategoryItems}" var="p4">
									<c:if test="${p4.parentCateGory==p3.id}">

										<span>${p3.cateGoryName}&nbsp;&nbsp;&nbsp;&nbsp;${p4.cateGoryName}</span>


									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach></td>
					<th>计量单位：</th>
					<td><span>${product.productUnit}</span></td>
				</tr>
				<tr>
					<th>商品类别：</th>
					<td colspan="3"><c:forEach items="${productCategoryItems}"
							var="p3">
							<c:if test="${p3.parentCateGory==null}">
								<c:forEach items="${productCategoryItems}" var="p4">
									<c:if test="${p4.parentCateGory==p3.id}">
										<c:forEach items="${productCategoryItems}" var="p1">
											<c:forEach items="${product.productCategorys}" var="p2">
												<c:if
													test="${p1.id==p2.parentCateGory&&p1.id!=p3.id&&p1.id!=p4.id}">
													<span>${p1.cateGoryName}:${p2.cateGoryName}</span>
												</c:if>
											</c:forEach>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach></td>

				</tr>
				<tr>
					<th>商品品牌：</th>
					<td>${product.productBrand}</td>
					<th>商品产地：</th>
					<td>${product.originPlaces}${product.detailAddress}</td>

				</tr>

				<tr>
					<th>图片展示：</th>
					<td colspan="3"><c:forEach items="${productPic }" var="p3"
							varStatus="status">
							<a href='#' class='cloud-zoom-gallery' title='Red'
								rel="useZoom: 'zoom1', smallImage: '<%=path%>${p3.filePath}' ">
								<img id="img${status.count}" src="<%=path%>${p3.filePath}"
								alt="Thumbnail 1" width="92" height="88" class="zoom-tiny-image" />
							</a>
						</c:forEach></td>
				</tr>

				<tr>
					<th valign=top>商品简介：</th>
					<td colspan="4">

						<div id="content" cols="100"
							style="width: 90%; height: auto; min-height: 300px; border: 1px solid #000;">${product.productInfo}</div>

					</td>

				</tr>
				<tr>
					<th>商品标题：</th>
					<td><textarea name="productTitle" id="productTitle"
							disabled="disabled"
							style="height: 115px; width: 248px; resize: none;">${product.productTitle}</textarea></td>
					<th>商品简述：</th>
					<td><textarea name="productDescription"
							id="productDescription" disabled="disabled"
							style="height: 115px; width: 248px; resize: none; disabled: disabled;">${product.productDescription}</textarea></td>
				</tr>
				<%-- <tr>
					<th>商品产地:</th>
					<td> span>${product.producingArea}</span> </td>

				</tr>
				<tr>
					<th>商品品类:</th>
					<td>
						 <span>${product.productCategorys.cateGoryName}</span> 
					</td>

				</tr>
				<tr>
					<th>供应商如下：</th>
				</tr>
				<c:forEach items="${product.companys}" var="c">
					<tr>
						<th>供应商公司名：</th>
						<td><span>${c.companyName}</span>
						</td>
					</tr>
					<tr>
						<th>区间价格如下：</th>
					</tr>
					<c:forEach items="${product.companys}" var="c">
						<tr>
							<th>区间：</th>
							<td><span>${c.companyName}</span>
							</td>
							<th>价格：</th>
							<td><span>${c.companyName}</span>
							</td>
						</tr>
					</c:forEach>
				</c:forEach> --%>
			</table>
		</form>
	</div>
</body>

</html>