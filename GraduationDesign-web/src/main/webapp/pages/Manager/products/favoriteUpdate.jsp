<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
function save() {
	 var content1 = $("#productId").val(); 
	  var content2 = $("#favoriteName").val(); 
	  if($.trim(content1).length !=0 && content2.match(/[\u4E00-\uFA29\uE7C7-\uE7F3a-zA-Z]+/g) !=null){
	   document.forms[0].submit(); 
	  } else{
	  alert("请务必填写商品名称与收藏名称！");
	  }   	
            }
</script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
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

div {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
</head>
<body>
	<div>
		<form action="fovoriteUpdate.do" name="userForm" method="post">
			<input type="hidden" name="id" id="id" value="${favorite.id}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>商品名称:</th>
					<td><input type="hidden" id="productId" name="productId"
						readonly value="${favorite.product.id}" /> <input type="text"
						readonly value="${favorite.product.productName}" /></td>
				</tr>
				<tr>
					<th>收藏名称:</th>
					<td><input type="text" id="favoriteName" name="favoriteName"
						value="${favorite.favoriteName}" /></td>
				</tr>
				<tr>
					<th>收藏类别:</th>
					<td><select name="favoriteType">
							<option value="1"
								<c:if test="favorite.favoriteType==1"> selected</c:if>>商品</option>
							<option value="2"
								<c:if test="favorite.favoriteType==2"> selected</c:if>>模板</option>
					</select></td>
				</tr>
			</table>
			<input type="button" value="提交" onclick="save();" /> <input
				type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>