<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css"/>
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
body{width:100%;height:100%;background-color: #FFFFFF;text-align: center;}
.input_txt{width:200px;height:20px;line-height:20px;}
.info{height:40px;line-height:40px;}
.info th{text-align: right;width:65px;color: #4f4f4f;padding-right:5px;font-size: 13px;}
.info td{text-align:left;}
#div1 {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
<script type="text/javascript">
function check_module() {
            	var checkObjs = $(":checkbox[name='productTypeIds']:checked");
            	if(checkObjs.length == 0) {
            		//如果一个都没选中
            		alert("至少选中一个，请重新输入添加！");
            		return false;
            	} else {
            		return true;
            	}
            }
            function save() {
            if(check_module()) {
            				//校验通过，提交表单
	            			document.forms[0].submit();
            			}
            }
</script>
</head>
<body>
<div id= div1>
	<form action="updateCompanyProducts.do" name="userForm" method="post">
	<input type="hidden" name="id" value="${companyProduct.id}"/>
	<input type="hidden" name= "productId" value="${companyProduct.product.id}"/>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr class="info">
			<th>商品名:</th>
			<td><input type="text" name="productName" value="${companyProduct.product.productName}"/></td>
		</tr>
		<tr class="info">
			<th>商品品牌:</th>
			<td><input type="text" name="commodityBrand" value="${companyProduct.product.commodityBrand}"/></td>
		</tr>
		<tr class="info">
			<th>商品单价:</th>
			<td><input type="text" name="unitPrice" value="${companyProduct.product.unitPrice}"/></td>
		</tr>
		<tr class="info">
			<th>商品简介:</th>
			<td><input type="text" name="productInfo" value="${companyProduct.product.productInfo}"/></td>
		</tr>
		<tr class="info">
			<th>商品产地:</th>
			<td><input type="text" name="producingArea" value="${companyProduct.product.producingArea}"/></td>
		</tr>
		<tr class="info">
			<th>状态:</th>
			<td>
			<select name="status">
			<option value="0"
			<c:if test="${companyProduct.status==0}"> selected</c:if>
			>上架</option>
			<option value="1"
			<c:if test="${companyProduct.status==1}"> selected</c:if>
			>下架</option>
			<option value="2"
			<c:if test="${companyProduct.status==2}"> selected</c:if>
			>冷却</option>
			<option value="2"
			<c:if test="${companyProduct.status==3}"> selected</c:if>
			>删除</option>
			</select>
			</td>
		</tr>
		<tr class="info">
			<th>商品品类:</th>
			<td>
			<select name="productCategory">
			<c:forEach items="${productCategorys}" var="p">
			<option value="${p.id}"
			<c:if test="${companyProduct.product.productCategorys.id==p.id}"> selected</c:if>
			>${p.cateGoryName}</option>
			</c:forEach>
			</select>
			</td>
		</tr>
		<tr class="info">
			<th>商品类别:</th>
			<td></td>
		</tr>
	</table>
                    <div class="">
                    <fieldset>
                        <ul>
                        	<c:forEach items="${productTypes}" var="p1">
                            	<li style="display:inline"><input type="checkbox" name="productTypeIds" value="${p1.id}" onclick="check_module();"
                            	<c:forEach items="${companyProduct.product.productTypes}" var="p2">
                            				<c:if test="${p1.id==p2.id}"> checked</c:if>
                            			</c:forEach>
                            	/>${p1.typeName}</li>
                            </c:forEach>	
                        </ul>
                    </fieldset>
    
                    </div>
	<input type="button" value="提交" onclick="save();"/>
	<input type="reset" value="取消" onclick="history.back()">
	</form>
	</div>
</body>
</html>