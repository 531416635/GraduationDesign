<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >

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
<link type="text/css" rel="stylesheet" href="<%=path%>/css/main.css" />
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>

<script type="text/javascript">
	//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor().panelInstance('content');
	});
	//保存
	function save() {
		//检验提交标记
		var flag =true;
		//所有商品属性集
		var radioChecked = $(".子类:checked,.品牌:checked,:checkbox:checked");
		var productCategory = $("[name='select1']").val() + ","
				+ $("[name='select2']").val()
				+ $("[name='productCategory']").val();
		$.each(radioChecked, function(i, node) {
			productCategory += "," + node.value;
		});
		$("[name='productCategory']").val(productCategory);

		//图片默认显示集
		var isDefault = "";
		var isDefaultNode = $("#upload div :radio");
		$.each(isDefaultNode, function(i, node) {
			isDefault += "," + ($(node).attr("checked")==true||$(node).attr("checked")=="checked"?1:node.value);
		});
		$("[name='isDefault']").val(isDefault);

		//商品规格
		$("#productModel").val($(".规格:checked").attr("title"));
		$("#productBrandId").val($(".品牌:checked").attr("title"));
		alert(productCategory);
		return;
		
		//商品产地
		/* if($("#province0").val()==""||$("#detailAddress").val().replace(/\s/g,"")==""){
		$("#message").show();
		flag = false;
		}else{
			$("#message").hide();
		}
		$("#originPlace").val($("#province0").val()+","+$("#city0").val()+","+$("#district0").val());
 */
		/* var productName = $("#productName").val();
		var unitPrice = $("#unitPrice").val();
		var content = $(".nicEdit-main").text(); */
		//提交表单s
		/* $("#form").submit(function(){
		return flag;
		}); */
		$("#form").submit();
		/* document.forms[0].submit(); */

	}
	//二级子品类ajax获取数据
	function checkSs(productCategoryId) {
		$.ajax({
			type : "POST",
			url : "listProductCategoryson.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				productCategoryId : productCategoryId
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					var json = eval(data);
					$("#tdId").html("");
					$("#select2").children().remove();
					listproductCategorys(json);
				}
			}
		});
	}
	//二级子品类显示
	function listproductCategorys(json) {
		var option1 = $("<option value='1'></option>");
		option1.html("请选择子品类");
		$("#select2").append(option1);
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].cateGoryName);
			option2.val(json[i].id);
			$("#select2").append(option2);
		}
	};
	//三级子品类ajax获取数据
	function checkss(productCategoryId) {
		$.ajax({
			type : "POST",
			url : "listProductTypes.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				"productCategoryId" : productCategoryId
			},
			success : function(data) {
				//提示

				if (data == "false") {
					alert("添加失败！");
				} else {
					//alert(data);
					var json = eval(data);
					$("#tdId").html("");
					listproductTypes(json);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}
	//三级类别显示
	function listproductTypes(json) {
		//json表示所属栏，jsons表示所属栏的每个值
		var jsons = json;
		var checkboxss = "";
		var productCategory = "";
		for ( var i = 0; i < json.length; i++) {
			flag1 = 0;
			for ( var j = 0; j < jsons.length; j++) {
				if (json[i].id == jsons[j].parentCateGory) {
					flag1 += 1;
					if (flag1 == 1) {
						//所属栏
						checkboxss += "<b>" + json[i].cateGoryName + ":</b>";
						As = "checked ='checked' ";
					} else {
						As = "";
					}
					//所属栏的每个值
					if(json[i].cateGoryName=="规格"){
					checkboxss += "<input type='checkbox' "+As+"title='"+jsons[j].id+"' name='name"+i+"' value='"+jsons[j].id+"'/>"+"<input type='radio' "+As+"class='"+json[i].cateGoryName+"' title='"+jsons[j].cateGoryName+"' name='name"+i+"' value='"+jsons[j].id+"'/>";
					checkboxss += jsons[j].cateGoryName+'&nbsp;&nbsp;&nbsp;';
					}else if(json[i].cateGoryName=="品牌"){
					checkboxss += "<input type='radio' "+As+"class='"+json[i].cateGoryName+"' title='"+jsons[j].cateGoryCode+"' name='name"+i+"' value='"+jsons[j].id+"'/>";
					checkboxss += jsons[j].cateGoryName;
					}else{
					checkboxss += "<input type='radio' "+As+"class='"+json[i].cateGoryName+"' title='"+jsons[j].cateGoryName+"' name='name"+i+"' value='"+jsons[j].id+"'/>";
					checkboxss += jsons[j].cateGoryName;
					}
					
				}
			}
			if (flag1 != 0) {
				checkboxss += "</br>";
				//存放所有该子类下的所有所属栏id
				productCategory += "," + json[i].id;
			}
		}
		$("#tdId").html(checkboxss);
		$("[name='productCategory']").val(productCategory);
	};
	//动态修改图片上传个数
	j = 1;
	$(function() {
		$("#btn_add")
				.click(
						function() {
							document.getElementById("newUpload2").innerHTML += '<div id="div_'+j+'"><input  name="file_'+j+'" id="file'+j+'" type="file"  /><input type="button" value="删除"  onclick="del_2('
									+ j
									+ ')"/><input type="radio" name="fefe" value="0" /></div>';
							j = j + 1;
						});
	});
	function del_2(o) {
		document.getElementById("newUpload2").removeChild(
				document.getElementById("div_" + o));
	}
	function checkProvince(id, s) {
			if(id==""){
		$("#message").show();
		flag = false;
		}else{
			$("#message").hide();
		}
		$.ajax({
			type : "POST",
			url : "<%=path%>/merchant/provinceUrbanLinkage.do",
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
					$("#city" + s).children().remove();
					$("#allSelect0").hide();
					$("#district0").hide();
					listCitys(json, s);
				}
			}
		});
	}
	function checkCity(id, s) {
		$.ajax({
			type : "POST",
			url : "<%=path%>/merchant/provinceUrbanLinkage.do",
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
					$("#district" + s).children().remove();
					listDistrict(json, s);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}

	//二级显示
	function listCitys(json, s) {
		var option1 = $("<option value=''></option>");
		option1.html("请选择城市");
		$("#city" + s).append(option1);
		if(json.length>0){
		$("#city" + s).show();
		}else{
		$("#city" + s).hide();
		}
		$("#district" + s).hide();
		for ( var i = 0; i < json.length; i++) {	
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#city" + s).append(option2);
		}
	};

	//三级显示
	function listDistrict(json, s) {
	var option1 = $("<option value=''></option>");
		option1.html("请选择地区");
		$("#district" + s).append(option1);
		  if(json.length>0){
		$("#district" + s).show();
		}else{
		$("#district" + s).hide();
		}  
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#district" + s).append(option2);
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

#div1 {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 20%;
	margin-left: -50px;
	width: 80%;
}

.span {
	coler: red;
}
</style>
</head>
<body>
	<div id=div1>

		<form id="form" action="addProduct.do" enctype="multipart/form-data"
			method="post">
			<input type="hidden" id="productCategory" name="productCategory"
				value="" /> <input type="hidden" id="isDefault" name="isDefault"
				value="" /> <input type="hidden" id="productModel"
				name="productModel" value="" /> <input type="hidden"
				id="productBrandId" name="productBrandId" value="" />
			<!-- <input type="hidden" id="originPlace" name="originPlace" value=""> -->
			<table style="border: 1px solid #d7d7d7; width: 90%;">
				<tr>
					<th>商品名称：</th>
					<td><input type="text" name="productName" required="required"
						id="productName" /><span>*</span></td>
					<th>商品单价：</th>
					<td><input type="text" required="required" name="unitPrice"
						id="unitPrice" /><span id="">*</span></td>
				</tr>
				<tr>
					<th>首页推荐：</th>
					<td>是：<input type="radio" name="isHomeShow" value="1" /> 否：<input
						type="radio" checked="checked" name="isHomeShow" value="0" /></td>

					<th>二级推荐：</th>
					<td>是：<input type="radio" name="isSubPageShow" value="1" />
						否：<input type="radio" checked="checked" name="isSubPageShow"
						value="0" /></td>
				</tr>
				<tr>
					<th>热销推荐：</th>
					<td>是：<input type="radio" name="isHotShow" value="1" /> 否：<input
						type="radio" checked="checked" name="isHotShow" value="0" /></td>
					<th>商品编码：</th>
					<td><input type="text" name="productCode" />
				</tr>
				<tr>
					<th>生产地址：</th>
					<td colspan="3">
						<%-- <select id="province0" name="province" onchange="checkProvince(this.value,0)">
								<option value="">请选择省份</option>
								<c:forEach items="${provinces}" var="d">
									<option value="${d.id}">${d.dicName}</option>
								</c:forEach>
				</select>
				<select id="city0" name="city" style="display: none;"
							onchange="if(this.value!=1){checkCity(this.value,0);}">
								<option value="">请选择城市</option>
				</select>
				<select id="district0" name="district" style="display: none;">
								<option value="">请选择地区</option>
				</select> --%> <input type="text" name="originPlace"
						onfocus="if(this.value=='请输入生产地址') {this.value='';}"
						onblur="if(this.value=='') {this.value='请输入生产地址';}"
						value="请输入生产地址"> <span id="message"
						style="color: red; display: none;">*请填写省份地址及详细地址*</span><br>
						<!-- <textarea name="detailAddress" id="detailAddress" 
				onfocus="if(this.value=='建议您如实填写详细产地地址，例如街道名称，门牌号码等信息') {this.value='';}"
							onblur="if(this.value=='') {this.value='建议您如实填写详细产地地址，例如街道名称，门牌号码等信息';}"
				style="height: 60px;  width: 500px; resize: none; color:#F08080;">建议您如实填写详细产地地址，例如街道名称，门牌号码等信息</textarea> -->
						<textarea name="detailAddress" id="detailAddress"
							style="height: 60px; width: 500px; resize: none; color: #F08080;"></textarea>

					</td>
				</tr>
				<tr>
					<th>商品品类：</th>
					<td id="selects"><select name="select1"
						onchange=checkSs(this.value)>
							<option>请选择父品类</option>
							<c:forEach items="${productCategorys}" var="pcs">
								<option value="${pcs.id}">${pcs.cateGoryName}</option>
							</c:forEach>
					</select> <select id="select2" name="select2"
						onchange="if(this.value!=1){checkss(this.value);}">
							<option value="1">请先选择父品类</option>
					</select></td>
					<th>计量单位：</th>
					<td><select id="productUnit" name="productUnit">
							<c:forEach items="${dictionarys}" var="Model">
								<option value="${Model.dicName}">${Model.dicName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>商品类别：</th>
					<td id="tdId" colspan="3"></td>
				</tr>

				<%-- <tr>
					<th>商品品牌:</th>
					<td>
					<select name="productBrandId">
					<c:forEach items="${productBrand}" var="pb">
					<option value="${pb.id}">${pb.brandName}</option>
					</c:forEach>
					</select>
					</td>
				</tr> --%>

				<tr>
					<th>商品简介：</th>
					<td colspan="3"><textarea id="content" cols="100"
							style="width: 90%; height: 300px;" name="productInfo"></textarea>
					</td>
				</tr>
				<tr>
					<th>商品标题：</th>
					<td><textarea name="productTitle" id="productTitle"
							style="height: 115px; width: 248px; resize: none;"></textarea></td>
					<th>商品简述：</th>
					<td><textarea name="productDescription"
							id="productDescription"
							style="height: 115px; width: 248px; resize: none;"></textarea></td>
				</tr>
				<tr>
					<th>图片上传：</th>
					<td id="upload" colspan="3">
						<div id="newUpload2">
							<input type="file" id="file0" name="file0">默认首图：<input
								type="radio" checked="checked" name="fefe" value="0" />
						</div> <input type="button" id="btn_add" value="新增一行">
					</td>
				</tr>
				<tr>
					<th></th>
					<td></td>
				</tr>
			</table>
			<input type="submit" value="增加"
				onclick="$('#content').val($('.nicEdit-main').html());save();" /> <input
				type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>
