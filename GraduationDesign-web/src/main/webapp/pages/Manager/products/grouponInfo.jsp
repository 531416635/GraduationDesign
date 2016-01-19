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


		<c:forEach items="${groupon }" var="g">

			<input type="hidden" name="id" value="${g.id }" />
			<input type="hidden" name="productId" value="${g.ProductID }" />

			<input type="hidden" name="SoldOut" value="${g.SoldOut }" />

			<table border="0" cellpadding="0" cellspacing="0">

				<tr class="info">
					<th>商品名称:</th>
					<td width="200px">${g.ProductName }</td>
					<th>商品原价:</th>
					<td>${g.UnitPrice }</td>

				</tr>
				<tr class="info">
					<th>团购价：</th>
					<td>${g.GrouponPrice }</td>
					<th>成交数：</th>
					<td><c:if test="${g.SoldOut==null }">0</c:if> <c:if
							test="${g.SoldOut!=null }">${g.SoldOut }</c:if>&nbsp;${g.ProductUnit
						}</td>
				</tr>


				<tr class="info">
					<th>有效期限：</th>
					<td>${g.ValidityTime }</td>
					<th>团购状态：</th>
					<td><c:if test='${g.Status==2}'>是</c:if> <c:if
							test='${g.Status!=2}'>否</c:if>
					</td>

				</tr>
				<tr class="info">
					<th>折扣：</th>
					<td>${g.Discount }</td>
					<th>节省：</th>
					<td>${g.Spare }
				</tr>
				<tr>
					<th>图片展示：</th>
					<td><c:if test="${g.IsDefault==1}"><img src="<%=path %>${g.filePath}" /></c:if>
					</td>
				</tr>
				<tr class="info">
					<th>购买须知:</th>
					<td colspan="3"><textarea cols="100" id="content"readonly="readonly"
							style="overflow:auto;background-attachment:fixed;background-repeat:no-repeat;border-style:solid;border-color:#FFFFFF;width:90%;height:auto;min-height:300px;"
							name="Remark">${g.Remark}</textarea></td>
				</tr>
			</table>
			<div style="margin:0 auto;text-align:center;"><input type="button" value="返回" onclick="history.back()"></div>
		</c:forEach>
	</div>
</body>

</html>