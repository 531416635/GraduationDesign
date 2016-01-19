<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "";
	String  productCategoryJson = (String)request.getAttribute("productCategoryJson");
	String  productJson = (String)request.getAttribute("productJson");
	
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
<!--<sc ript type="text/javascript" src="../js/nicEdit.js"></script> -->
<script type="text/javascript">
	//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor().panelInstance('content');
	});
	//全局变量 
	var productCategory = "";
	//保存
	function save() {
		//检验提交标记
		var flag =true;
		//所有商品属性集
		/* var radioChecked = $("#tdId :radio:checked"); */
		var radioChecked = $("#tdId :radio:checked,:checkbox:checked");
		productCategory = $("[name='select1']").val() + ","
				+ $("[name='select2']").val()
				+ $("[name='productCategory']").val();
		$.each(radioChecked, function(i, node) {
			productCategory += "," + node.value;
		});
		$("[name='productCategory']").val(productCategory);

		//图片默认显示集
		var isDefault = "";
		var isDefault2 = ""; //已有图片状态
		var isDefaultNode = $("#upload div :radio");
		$.each(isDefaultNode, function(i, node) {
			//alert($(node).attr("title"));
			if ($(node).attr("title") != "") {
				isDefault2 += ","
						+ $(node).attr("title")
						+ ":"
						+ ($(node).attr("checked") == true
								|| $(node).attr("checked") == "checked" ? 1
								: node.value);
			} else {
				// alert(isDefault);
				isDefault += ","
						+ ($(node).attr("checked") == true
								|| $(node).attr("checked") == "checked" ? 1
								: node.value);
			}
		});
		$("[name='isDefault2']").val(isDefault2);
		$("[name='isDefault']").val(isDefault);

		//商品规格
		$("#productModel").val($(".规格:checked").attr("title"));
		$("#productBrandId").val($(".品牌:checked").attr("title"));
		//商品产地
		/* if($("#province0").val()==""||$("#detailAddress").val().replace(/\s/g,"")==""){
		$("#message").show();
		flag = false;
		}else{
			$("#message").hide();
		}
		$("#originPlace").val($("#province0").val()+","+$("#city0").val()+","+$("#district0").val());
		//提交表单
		$("#form").submit(function(){
		return flag;
		}); */
		$("#form").submit();
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
		productCategory = "";
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
					checkboxss += "<input type='radio' "+As+"class='"+json[i].cateGoryName+"' title='"+jsons[j].cateGoryName+"' name='name"+i+"' value='"+jsons[j].id+"'/>";
					checkboxss += jsons[j].cateGoryName;
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
	function del_3(t, o, picId) {

		$.ajax({
			type : "POST",
			url : "deletePic.do",
			data : {
				picPath : picId,
				id : o
			},
			success : function(data) {

				if (data == true) {
					var e = "cloud-zoom-gallery" + t;

					var r = $("." + e);

					r.remove();
					alert("删除成功！！");
				} else {
					alert("删除失败！！");
				}

			},
			error : function() {
				alert("删除失败");
			}
		});

	}
	//ajax 调出省对应的市
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
	//ajax 调出市对应的区
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

	//二级显示市
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

	//三级显示区
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
	
	var productCategoryJson =<%=productCategoryJson%>;
	var productJson =<%=productJson%>;
	
	//展现规格
	$(function(){
	var checkboxss = "规格: ";
	var content1="";
	var content2="";
	var productCategory = "";
	for(var k=0;k<productJson.productCategorys.length;k++){ 
	if(productJson.productCategorys[k].cateGoryName=="规格"){
		productCategory=productJson.productCategorys[k].id;
	for(var y=0;y<productCategoryJson.length;y++){
	if(productJson.productCategorys[k].id==productCategoryJson[y].parentCateGory){
	for(var j=0;j<productJson.productCategorys.length;j++){
	if(productCategoryJson[y].id==productJson.productCategorys[j].id){
	content1="checked=checked ";
	break;
	}else{
	content1="";
	}
	}
	if(productJson.productModel==productCategoryJson[y].id){
	content2="checked=checked ";
	}else{
	content2="";
	}
	checkboxss += "<input type='checkbox' "+content1+"title='"+productCategoryJson[y].id+"' name='name"+k+"' value='"+productCategoryJson[y].id+"'/>"+"<input type='radio' "+content2+"class='"+productJson.productCategorys[k].cateGoryName+"' title='"+productCategoryJson[y].id+"' name='name"+k+"' value='"+productCategoryJson[y].id+"'/>";
	checkboxss += productCategoryJson[y].cateGoryName+"&nbsp;&nbsp;&nbsp;";
	}	
	}		
	}
	}
	
	$("#tdId").append(checkboxss);
	$("[name='productCategory']").val($("[name='productCategory']").val()+","+productCategory);
	});	
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
	width: 100px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}

#div1 {
	position: absolute;
	top: 10%;
	/* margin-top: -50px; */
	left: 10%;
	margin: 0 auto;
	/* margin-left: -50px; */
}
</style>
</head>
<body>
	<div id="div1" style="margin:0 auto;">
		<form id="form" action="updateProduct.do"
			enctype="multipart/form-data" method="post">
			<input type="hidden" id="productCategory" name="productCategory"
				value="" /> <input type="hidden" id="productBrandId"
				name="productBrandId" value="" /> <input type="hidden" id="isDefault"
				name="isDefault" value="" /> <input type="hidden" id="isDefault2"
				name="isDefault2" value="" /> <input type="hidden"
				id="productModel" name="productModel" value="" /> <input
				type="hidden" name="id" id="Id" value="${product.id}" /> <input
				type="hidden" name="status" id="status" value="${product.status}" />
				<!-- <input type="hidden" id="originPlace" name="originPlace" value=""> -->

			<table border="0" cellpadding="0" cellspacing="0">

				<tr class="info">
					<th>商品名称:</th>
					<td width="200px"><input type="text" name="productName"
						id="productName" value="${product.productName}" /></td>
					<th>商品单价:</th>
					<td><input type="text" name="unitPrice" id="unitPrice"
						value="${product.unitPrice}" />
					</td>

				</tr>
				<tr class="info">
					<th>首页推荐：</th>
					<td><c:if test="${product.isHomeShow==1}">是：<input
								type="radio" name="isHomeShow" checked="checked" value="1" /> 否：<input
								type="radio" name="isHomeShow" value="0" />
						</c:if> <c:if test="${product.isHomeShow!=1}">是：<input
								type="radio" name="isHomeShow" value="1" /> 否：<input
								type="radio" checked="checked" name="isHomeShow" value="0" />
						</c:if>
					</td>
					<th>二级推荐：</th>
					<td><c:if test="${product.isSubPageShow==1}">是：<input
								type="radio" name="isSubPageShow" checked="checked" value="1" />
						否：<input type="radio" name="isSubPageShow" value="0" />
						</c:if> <c:if test="${product.isSubPageShow!=1}">是：<input
								type="radio" name="isSubPageShow" value="1" />
						否：<input type="radio" checked="checked" name="isSubPageShow"
								value="0" />
						</c:if></td>
				</tr>
				<tr class="info">
					<th>热销推荐：</th>
					<td><c:if test="${product.isHotShow==1}">是：<input
								type="radio" name="isHotShow" checked="checked" value="1" /> 否：<input
								type="radio" name="isHotShow" value="0" />
						</c:if> <c:if test="${product.isHotShow!=1}">是：<input type="radio"
								name="isHotShow" value="1" /> 否：<input type="radio"
								checked="checked" name="isHotShow" value="0" />
						</c:if></td>
					<th>商品编码：</th>
					<td><input type="text" name="productCode"
						value="${product.productCode }" />
				</tr>
				<tr class="info">
					<th>是否加入团购：</th>
					<td><input type="checkbox" name="GrouponStatus" value="2"
						<c:if test="${grouponStatus==2 }"> checked="checked"</c:if> />
					</td>
					<th>计量单位：</th>
					<td><select id="ProductUnit" name="ProductUnit">

							<c:forEach items="${dictionarys}" var="Model">
								<c:if test="${Model.dicName==product.productUnit}">
									<option value="${Model.dicName}" selected=selected>${Model.dicName}</option>
								</c:if>
								<c:if test="${Model.dicName!=product.productUnit}">
									<option value="${Model.dicName}">${Model.dicName}</option>
								</c:if>
							</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
				<th>生产地址：</th>
				<td colspan="3" style="text-align: left;">
				<%-- <c:if test="${product.originArea!=null and product.originArea!=''}" var="tr">
				
				
					<select id="province0" name="province" onchange="checkProvince(this.value,0)">
							<option value="">请选择城市</option>
							<c:forEach items="${originArea}" var="d2">
								<c:forEach items="${product.originArea}" begin="0" end="0" var="d1">
										<c:if test="${d2.dicParent==null}">
											<c:if test="${d1.id==d2.id}">
												<option value="${d1.id}" selected="selected">${d1.dicName}</option>
											</c:if>
											<c:if test="${d1.id!=d2.id}">
												<option value="${d2.id}">${d2.dicName}</option>
											</c:if>
										</c:if>
									</c:forEach>
							</c:forEach>
					</select>
					<select id="city0" name="city"  onchange="if(this.value!=1){checkCity(this.value,0);}">
							<option value="">请选择城市</option>
							<c:forEach items="${product.originArea}" begin="1" end="1" var="d1">
									<c:forEach items="${originArea}" var="d2">
										<c:if test="${d2.dicParent==d1.dicParent}">
											<c:if test="${d1.id==d2.id}">
												<option value="${d1.id}" selected="selected">${d1.dicName}</option>
											</c:if>
											<c:if test="${d1.id!=d2.id}">
												<option value="${d2.id}">${d2.dicName}</option>
											</c:if>
										</c:if>
									</c:forEach>
							</c:forEach>
					</select>
					<select id="district0" name="district" >
							<option>请选择地区</option>
							<c:forEach items="${product.originArea}" begin="2" end="2" var="d1">
									<c:forEach items="${originArea}" var="d2">
										<c:if test="${d2.dicParent==d1.dicParent}">
											<c:if test="${d1.id==d2.id}">
												<option value="${d1.id}" selected="selected">${d1.dicName}</option>
											</c:if>
											<c:if test="${d1.id!=d2.id}">
												<option value="${d2.id}">${d2.dicName}</option>
											</c:if>
										</c:if>
									</c:forEach>
							</c:forEach>
					</select>
					 </c:if>
					 <c:if test="${!tr}">
					 <select id="province0" name="province" onchange="checkProvince(this.value,0)">
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
					</select>
					 </c:if> --%>
					 <input type="text" name="originPlace" 
				onfocus="if(this.value=='请输入生产地址') {this.value='';}"
							onblur="if(this.value=='') {this.value='请输入生产地址';}"
				value="${product.originPlace}">
					<span id="message" style="color:red; display: none;">*请填写省份地址及详细地址*</span><br>
					<textarea name="detailAddress" id="detailAddress" style="height: 60px;  width: 500px; resize: none; color:#F08080;">${product.detailAddress}</textarea>
				</td>
				</tr>
				</tr>
				<tr class="info">
					<th>商品品类:</th>
					<td id="selects" colspan="3"><select name="select1"
						onchange=checkSs(this.value)>
							<option>请选择父品类</option>
							<c:forEach items="${productCategorys}" var="pcs">
								<c:if test="${productCategoryItems!='[]'}">
									<c:forEach items="${productCategoryItems}" var="p2">
										<c:if test="${p2.parentCateGory==null}">
											<c:if test="${p2.id==pcs.id}">
												<option value="${pcs.id}" selected="selected">${pcs.cateGoryName}</option>
											</c:if>
											<c:if test="${p2.id!=pcs.id}">
												<option value="${pcs.id}">${pcs.cateGoryName}</option>
											</c:if>
										</c:if>
									</c:forEach>

								</c:if>
								<c:if
									test="${productCategoryItems=='[]'||productCategoryItems==null}">
									<option value="${pcs.id}">${pcs.cateGoryName}</option>
								</c:if>
							</c:forEach>
					</select> <select id="select2" name="select2"
						onchange="if(this.value!=1){checkss(this.value);}">
							<option value="1">请先选择父品类</option>
							<c:forEach items="${productCategory}" var="p2">
								<c:if test="${p2.parentCateGory==null}">
									<c:forEach items="${productCategoryItems}" var="p3">
										<c:if test="${p3.parentCateGory==p2.id}">
											<c:forEach items="${productCategory}" var="p4">
												<c:if test="${p4.parentCateGory==p2.id}">
													<c:if test="${p4.cateGoryName==p3.cateGoryName}">
														<option value="${p4.id}" selected="selected">${p4.cateGoryName}</option>
													</c:if>
													<c:if test="${p4.cateGoryName!=p3.cateGoryName}">
														<option value="${p4.id}">${p4.cateGoryName}</option>
													</c:if>
												</c:if>
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
					</select></td>

				</tr>
				<tr class="info">
					<th>商品类别:</th>
					<td id="tdId" colspan="3"><script>
						productCategory = "";
					</script> <c:forEach items="${productCategory}" var="p1" varStatus="t">
							<c:forEach items="${product.productCategorys}" var="p2"
								varStatus="i">
								<c:if test="${p1.id==p2.parentCateGory and (p1.cateGoryName=='子类' or p1.cateGoryName=='品牌')}">
										<input id="cateGoryName${t.index }" type="hidden" value="${p1.id }" />	${p1.cateGoryName}:						
											<c:forEach items="${productCategory}" var="p5">
										<c:if test="${p1.id==p5.parentCateGory}">
										 <c:if test="${p5.id==p2.id}">
												<input type='radio' class="${p1.cateGoryName}"
													title="<c:if test="${p1.cateGoryName=='品牌'}" >${p5.cateGoryCode}</c:if><c:if test="${p1.cateGoryName!='品牌'}">${p5.cateGoryName}</c:if>" name="name${i.index }"
													value="${p5.id }" checked="checked" />
												<span>${p5.cateGoryName}</span>
											</c:if>
											<c:if test="${p5.id!=p2.id}">
												<input type='radio' class="${p1.cateGoryName}"
													title="<c:if test="${p1.cateGoryName=='品牌'}" >${p5.cateGoryCode}</c:if><c:if test="${p1.cateGoryName!='品牌'}">${p5.cateGoryName}</c:if>" name="name${i.index }"
													value="${p5.id }" />
												<span>${p5.cateGoryName}</span>
											</c:if>			
										</c:if>
									</c:forEach>
									<br>
									<script>
										productCategory += "," + ${p1.id };
									</script>
								</c:if>
							</c:forEach>
						</c:forEach> <script>
							$("[name='productCategory']").val(productCategory);
						</script>
					</td>
				</tr>
				<%-- <tr>
					<th>商品品牌:</th>
					<td style="text-align: left;">
					<select name="productBrandId">
					<c:forEach items="${productBrand}" var="pb">
					<c:if test="${product.productBrandId==pb.id}" var="pdi">
					<option value="${pb.id}" selected="selected">${pb.brandName}</option>
					</c:if>
					<c:if test="${!pdi}">
					<option value="${pb.id}">${pb.brandName}</option>
					</c:if>
					</c:forEach>
					</select>
					</td>
				</tr> --%>
				<%-- <c:if test="${product.productBrand!=null}">
					<tr class="info">
						<th>商品品牌:</th>
						<td><c:forEach items="${productCategory}" var="p1">
								<c:forEach items="${product.productCategorys}" var="p2"
									varStatus="i">
									<c:if test="${p1.id==p2.parentCateGory}">
										<c:if test="${p1.cateGoryCode==2 }">
											<br>
											<c:forEach items="${productCategory}" var="p5">
												<c:if test="${p1.id==p5.parentCateGory}">
													<c:if test="${p5.id==p2.id}">
														<input type='text' class="cateGoryName${i.index }" readonly="readonly"
															title="cateGoryName${i.index }"
															value="${p5.cateGoryName}" />

													</c:if>

												</c:if>
											</c:forEach>
										</c:if>

									</c:if>

								</c:forEach>
							</c:forEach>
					</tr>

				</c:if> --%>

				<tr>
					<th>图片上传:</th>
					<td id="upload" colspan="3" style="text-align:left;">
						<div style="text-align:left;">
							<c:forEach items="${productPic}" var="p3" varStatus="status">
								<a href='#' class='cloud-zoom-gallery${status.index}'
									title='Red'
									rel="useZoom: 'zoom1', smallImage: '<%=path%>${p3.filePath}' ">
									<img id="img" src="<%=path%>${p3.filePath}" alt="Thumbnail 1"
									width="92" height="88" class="zoom-tiny-image" /><input
									id="del${status.index}" type="button" value="删除"
									onclick="del_3('${status.index}','${p3.id}','${p3.filePath}')"> 
									<input type="radio" title="${p3.id}" <c:if test='${p3.isDefault==1 }' ><c:if test='${p3.isDefault==1 }' var='p5'>checked="checked" </c:if></c:if> name="fefe" value="0" />
							</a>
							</c:forEach>
						</div>
						<div id="newUpload2">
							<input type="file" id="file0" name="file0">默认首图：<input
								type="radio" <c:if test="${!p5}">checked="checked"</c:if>
								name="fefe" value="0" />
						</div> <input type="button" id="btn_add" value="新增一行">
					</td>
				</tr>
				<tr class="info">
					<th>商品简介:</th>
					<td colspan="3"><textarea cols="100" id="content"
							style="width:90%; height:auto;min-height:300px;"
							name="productInfo">${product.productInfo}</textarea>
					</td>
				</tr>
				<tr><th>商品标题：</th>
				<td><textarea name="productTitle" id="productTitle" style="height: 115px;  width: 248px; resize: none;">${product.productTitle}</textarea></td>
				<th>商品简述：</th>
				<td><textarea name="productDescription" id="productDescription"  style="height: 115px;  width: 248px; resize: none;">${product.productDescription}</textarea></td>
				</tr>
			</table>

			<input type="submit" value="提交"
				onclick="$('#content').val($('.nicEdit-main').html());save();" /> <input
				type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>