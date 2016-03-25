<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//page
	String json = (String) request.getAttribute("json");
	//所有品类(便于已有条件展现)
	String productCategory = (String) request.getAttribute("productCategory");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<%-- <link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />  --%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<%-- <script type="text/javascript" src="<%=path%>/js/jquery.js"></script> --%>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/uploadPreview.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
//图片预览
$(function(){
 new uploadPreview({ UpBtn: "file0", DivShow: "pimgdiv0", ImgShow: "pimg0" });
 new uploadPreview({ UpBtn: "file_safety0_1", DivShow: "pimgdiv_safety0_1", ImgShow: "pimg_safety0_1" });
 new uploadPreview({ UpBtn: "file_safety1_1", DivShow: "pimgdiv_safety1_1", ImgShow: "pimg_safety1_1" });
 new uploadPreview({ UpBtn: "file_safety2_1", DivShow: "pimgdiv_safety2_1", ImgShow: "pimg_safety2_1" });
 new uploadPreview({ UpBtn: "file_safety3_1", DivShow: "pimgdiv_safety3_1", ImgShow: "pimg_safety3_1" });
 new uploadPreview({ UpBtn: "file_safety4_1", DivShow: "pimgdiv_safety4_1", ImgShow: "pimg_safety4_1" });
 new uploadPreview({ UpBtn: "file_safety5_1", DivShow: "pimgdiv_safety5_1", ImgShow: "pimg_safety5_1" });
});

$(function(){
		//展现已输入条件
	  	var json = eval(<%=json%>);
	  	 var productCategory1 = eval(<%=productCategory%>);
	  	var productCategory2 = eval(<%=productCategory%>);
	  	var productCategory3 = eval(<%=productCategory%>);	
		$("#productName").val(json.productName);
		var productCategoryIds = json.productCategory;
		if(productCategoryIds!=null&&productCategoryIds!=""){
		var productCategoryIds1 = productCategoryIds.split(',');
		var productCategoryIds2 = productCategoryIds.split(',');
		var productCategoryIds3 = productCategoryIds.split(',');
		var content1 ='<option value="">请选择父品类</option>';
		var content2 ='<option value="">请选择子品类</option>';
		var content3 ='';
		var content4 ='';
		var flag1=false;
		var flag2=false;
		for(var j = 0;j<productCategory1.length;j++){
		if(productCategory1[j].parentCateGory==null||productCategory1[j].parentCateGory==""){
		//此for为一级与二级品类
		for(var i = 0; i<productCategoryIds1.length;i++) {
		if(productCategory1[j].id==parseInt(productCategoryIds1[i])){
		for(var k = 0;k<productCategory2.length;k++){
		if(productCategory1[j].id==productCategory2[k].parentCateGory){
		for(var s = 0;s<productCategoryIds2.length;s++){
		if(productCategory2[k].id==parseInt(productCategoryIds2[s])){
		flag2=true;
		break;
		}else if(s==productCategoryIds2.length-1){
		flag2=false;
		}	
		}
		if(flag2){
		content2+='<option selected="selected" value="'+productCategory2[k].id+'">'+productCategory2[k].cateGoryName +'</option>';
		}else{
		content2+='<option value="'+productCategory2[k].id+'">'+productCategory2[k].cateGoryName +'</option>';
		}
		}
		}
		flag1=true;
		break;
		}else if(i==productCategoryIds1.length-1){
		flag1=false;
		}
		}
		if(flag1){
		content1+='<option selected="selected" value="'+productCategory1[j].id+'">'+productCategory1[j].cateGoryName +'</option>';
		}else{
		content1+='<option value="'+productCategory1[j].id+'">'+productCategory1[j].cateGoryName +'</option>';
		}
		}			
		}
		//商品类型展现
		var productCategory ="";
		for(var j = 0;j<productCategory1.length;j++){
		for(var i = 0; i<productCategoryIds1.length;i++) {
		if(parseInt(productCategoryIds1[i])==productCategory1[j].id&&(productCategory1[j].cateGoryCode==1||productCategory1[j].cateGoryCode==2||productCategory1[j].cateGoryCode==3)){
		content3+='<b>'+productCategory1[j].cateGoryName+':</b>';
		for(var k = 0;k<productCategory2.length;k++){
		if(productCategory1[j].id==productCategory2[k].parentCateGory){
		for(var s = 0; s<productCategoryIds2.length;s++) {
		if(productCategory2[k].id==parseInt(productCategoryIds2[s])){
		content4='checked="checked"';
		break;
		}else if(s==productCategoryIds2.length-1){
		content4='';
		}
		}	
			content3+='<input type="radio" '+content4+' name="name'+i+'" value="'+productCategory2[k].id+'"/>'+productCategory2[k].cateGoryName;
		}
		if(k==productCategory2.length-1){
		content3+='<br>';
		productCategory += "," + productCategory1[j].id;
		}
		}
		}
		}
		}
		$("[name='productCategory']").val(productCategory);	
		$("[name='select1']").html(content1);
		$("[name='select2']").html(content2);
		$("#tdId").html(content3);  
		}
		var flag = false; //标识生成分页时是否生成查询默认页商品
	  	$("#rows").html(json.rows);
	  	$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination").pagination(json.rows, { // 创建分页按钮
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
		var radioChecked = $("#tdId :radio:checked");
		
		var productCategory = $("[name='select1']").val()+ "," + $("[name='select2']").val() + $("[name='productCategory']").val();
		$.each(radioChecked, function(i, node) {
			productCategory += "," + node.value;
		});
		if($("[name='select1']").val() == ''){
		productCategory="";
		}else if($("[name='select2']").val() == ''){
		productCategory=$("[name='select1']").val();
		}
		 location.href="toProductEdit.do?currentPage="+(page_index+1)+"&&productCategory="+productCategory+"&&productName="+$("#productName").val(); 
		
		/*  $("#currentPage").val(page_index+1); 
		alert("111");
		change(); 为什么这种不行了呢！？？？*/
				
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	$(function(){ 
		$('#tabs li:eq(2)').hide();
		$('#tabs li:eq(1)').hide();

		$("#unitPrice").blur(function() {
			var s = $.trim($(this).val()).toString();
			////alert(s.length);
			if (s.length < 1) {
				$(".hong1").show();
			} else {
				$(".hong1").hide();
			}
		});
		$("#text1").blur(function() {
			var s = $.trim($(this).val()).toString();

			if (s.length < 1) {
				$(".hong2").show();
			} else {
				$(".hong2").hide();
			}
		});
		$("#text2").blur(function() {
			var s = $.trim($(this).val()).toString();

			if (s.length < 1) {
				$(".hong3").show();
			} else {
				$(".hong3").hide();
			}
		});
		$("#text3").blur(function() {
			var s = $.trim($(this).val()).toString();

			if (s.length < 1) {
				$(".hong4").show();
			} else {
				$(".hong4").hide();
			}
		});
		$("#text4").blur(function() {
			var s = $.trim($(this).val()).toString();

			if (s.length < 1) {
				$(".hong5").show();
			} else {
				$(".hong5").hide();
			}
		});
		$("input[name='goodsNum']").blur(function() {

			var s = $.trim($(this).val()).toString();

			if (s.length < 1 || $(this).val() == 0) {
				$(".hong6").show();
			} else {
				$(".hong6").hide();
			}
		});
		$("#qr")
				.click(
						function() {

$(".input_text1").val($(".name").text().trim());
							var k = $("#file_safety0_1").val();
							var k1 = $("#file_safety1_1").val();
							var k2 = $("#file_safety2_1").val();
							var k3 = $("#file_safety3_1").val();
							var k4 = $("#file_safety4_1").val();
							var k5 = $("#file_safety5_1").val();
							if (k == "") {
								$(".image1").show();
								//return false;
							} else {
								$(".image1").hide();
							}
							if (k1 == "") {
								$(".image2").show();
								//return false;
							} else {
								$(".image2").hide();
							}
							if (k2 == "") {
								$(".image3").show();
								//return false;
							} else {
								$(".image3").hide();
							}
							if (k3 == "") {
								$(".image4").show();
								//return false;
							} else {
								$(".image4").hide();
							}
							if (k4 == "") {
								$(".image5").show();
								//return false;
							} else {
								$(".image5").hide();
							}
							if (k5 == "") {
								$(".image6").show();
								//return false;
							} else {
								$(".image6").hide();
							}
							var k = $("#file0").val();
							if (k == "") {
								$(".tupian").show();
							}
							var s = $.trim($("#unitPrice").val()).toString();
							////alert(s.length);
							if (s.length < 1) {	
								$(".hong1").show();
							} else {
								$(".hong1").hide();
							}

							var s1 = $.trim($("#text1").val()).toString();

							if (s1.length < 1) {
								$(".hong2").show();
							} else {
								$(".hong2").hide();
							}

							var s2 = $.trim($("#text2").val()).toString();

							if (s2.length < 1) {
								$(".hong3").show();
							} else {
								$(".hong3").hide();
							}

							var s3 = $.trim($("#text3").val()).toString();

							if (s3.length < 1) {
								$(".hong4").show();
							} else {
								$(".hong4").hide();
							}

							var s4 = $.trim($("#text4").val()).toString();

							if (s4.length < 1) {
								$(".hong5").show();
							} else {
								$(".hong5").hide();
							}

							var s5 = $.trim($("input[name='goodsNum']").val())
									.toString();
							//alert(s5);
							if (s5.length < 1
									|| $("input[name='goodsNum']").val() == 0) {
								$(".hong6").show();
							} else {
								$(".hong6").hide();
							}

							if (k != "" && s.length >= 1 && s1.length >= 1
									&& s2.length >= 1 && s3.length >= 1
									&& s4.length >= 1 && s5.length >= 1
									&& $("input[name='goodsNum']").val() != 0
									&& k != "" && k1 != "" && k2 != ""
									&& k3 != "" && k4 != "" && k5 != ""
									) {
									
								alert("商品供应填写完毕！");
								
								$("#qr").hide();
							$("#qr1").show();
								return true;
								/* $("#form2").submit; */
								
							} else {
								
								/* $("#form2").submit(function(e) {
									e.preventDefault();

								}); */
								alert("商品详情、商品资质页面未完善，请按红色提示语完善相应内容！");
								return false;
							}
						});
		$('#tabs li:eq(0) a').click(function() {
			$('#tabs li:eq(2)').hide();
			$('#tabs li:eq(1)').hide();

		});

	});

	bkLib.onDomLoaded(function() {
		nicEditors.allTextAreas();
	});
	function change() {
		//拼接商品属性集
		var radioChecked = $("#tdId :radio:checked");
		
		var productCategory = $("[name='select1']").val()+ "," + $("[name='select2']").val() + $("[name='productCategory']").val();
		$.each(radioChecked, function(i, node) {
			productCategory += "," + node.value;
		});
		if($("[name='select1']").val() == ''){
		productCategory="";
		}else if($("[name='select2']").val() == ''){
		productCategory=$("[name='select1']").val();
		}
		$("[name='productCategory']").val(productCategory);
		$("#form1").submit;
	}
	function save() {
		/* //拼接多个省市区字符串
		var spans = $("#tab2 p span[id]");
		address = "";
		//多个省市区及详细地址
		$.each(spans, function(i, node1) {
			var node2 = $(node1).children("select,input[id]");
			//省市区中的多个select
			$.each(node2, function(j, node3) {
				//将省市区拼成一个字符串以‘,’分割
				address += $(node3).val()
						+ ((j >= node2.length - 1) ? "" : ",");
			});
			//多个省市区拼成一个字符串以‘;’分割
			address += ((i >= spans.length - 1) ? "" : ";");
		});
		$("#address").val(address.substring(1));
		
		//验证省市区是否一致
		if($("#address").val().match(";")){
		var addrs = address.split(";");
		var flag = true;
		for(var i = 0;i<addrs.length-1;i++){
		for(var j = i+1;j<addrs.length;j++){
		if(addrs[i].substring(0,addrs[i].lastIndexOf(",")).match(addrs[j].substring(0,addrs[j].lastIndexOf(",")))!=null){
		alert($("#msg").text());
		flag = false;
		$("#msg").show();  
		}
		}
		}
		 if(flag){
		$("#msg").hide();
		 return;
		}
		} */
		//拼接图片默认显示集
		var isDefault = "";
		/* var isDefaultNode = $("#newUpload2 :radio:checked");
		$.each(isDefaultNode, function(i, node) {
			isDefault += node.value
					+ ((i >= isDefaultNode.length - 1) ? "" : ",");
		}); */
		var isDefaultNode = $("#newUpload2 div :radio");
		$.each(isDefaultNode, function(i, node) {
			isDefault += "," + ($(node).attr("checked")==true||$(node).attr("checked")=="checked"?1:node.value);
		});
		$("#isDefault").val(isDefault);
		//拼接区间价
		var PriceRange = "";
		$("#tab2body tr td input")
				.each(
						function(i, node) {
							var id = $(node).val();
							PriceRange += id
									+ ((i >= $("#tab2body tr td input").length - 1) ? ""
											: ",");
						});

		$("#priceRange").val(PriceRange);
		//拼接安全认证成json
	/* 	var safetys = "{";
		$.each($("#tab3 input[name]"), function(i, next) {
			var val = $(next).val();
			safetys += "\"" + $(next).attr("id") + "\"" + ":" + "\""
					+ ((val == "") ? "null" : val) + "\""
					+ ((i >= $("#tab3 input[name]").length - 1) ? "}" : ",");
		}); */
		var safetys="";
		for(var i=0;i<=5;i++){
		$.each($("#safety"+i+" input[name]"), function(j, next) {
		safetys+=","+(i+2);
		});
		}
		$("#safetys").val(safetys);
		$("#form2").submit;
	}

	//二级子品类ajax获取数据
	function checkCategory(productCategoryId) {
		$.ajax({
			type : "POST",
			url : "/GraduationDesign/products/listProductCategoryson.do",
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
		var option1 = $("<option value=''></option>");
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
	function checkCategorysun(productCategoryId) {
		$.ajax({
			type : "POST",
			url : "/GraduationDesign/products/listProductTypes.do",
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
					checkboxss += "<input type='radio' "+As+"name='name"+i+"' value='"+jsons[j].id+"'/>";
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

	// 地址管理
	function checkSs(id, s) {
		$.ajax({
			type : "POST",
			url : "/GraduationDesign/merchant/provinceUrbanLinkage.do",
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
					listCitys(json, s);
				}
			}
		});
	}
	function checkss(id, s) {
		$.ajax({
			type : "POST",
			url : "/GraduationDesign/merchant/provinceUrbanLinkage.do",
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
		var option1 = $("<option value='1'></option>");
		option1.html("请选择城市");
		$("#city" + s).append(option1);
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#city" + s).append(option2);
		}
	};

	//三级显示
	function listDistrict(json, s) {
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#district" + s).append(option2);
		}
	};
	//下一页切换
	function checksupply(productId) {
		var flagss = false;
		var name = $(".j_1[name=" + productId + "]").text();
		$("span[class=name]").text(name);

		$.ajax({
			type : "POST",
			url : "checksupply.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "text",
			async : false,
			data : {
				productId : productId
			},
			success : function(data) {
				//提示
				if (data == "error") {
					alert("错误！");
				} else {
					var json = eval('(' + data + ')');
					if (json.result == "true") {
						var r = confirm("该商品已供应是否对商品进行管理？");
						if (r == true) {

							location.href = "toProductEdit3.do";
						} else {

							flagss = true;
						}
					}
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
		if (flagss == true) {
		} else {
			$('#tabs li:eq(2)').show();
			$('#tabs li:eq(1)').show();
			$("#id").val(productId);
			$("#content div").hide();
			$("#tabs li").attr("id", "");
			$('#tabs li:eq(1)').attr('id', 'current');
			$('#tab2,#tab2 div').fadeIn();
		}

	}
	//下一页切换
	function next2() {

		$("#content div").hide();
		$("#tabs li").attr("id", "");
		$('#tabs li:eq(1)').attr('id', 'current');
		$('#tab3,#tab3 div').fadeIn();
	}

	function span(o) {
		$("#span" + o).remove();
	}
	function del_2(o) {
		document.getElementById("newUpload2").removeChild(
				document.getElementById("div_" + o));
	}
	function check1(obj)
			{
			var v = obj.value;
			var reg = /^\d*\.(\d{2})$/gi;
			if (reg.test(obj.value))
			{
			return false;
			}
			return true;
			}
			function check2(obj)
			{
			var v = obj.value;
			obj.value = v.replace(/[^\d\.]/g,'');
			}
			//添加资质图片上传个数
	ks1=1;ks2=1;ks3=1;ks4=1;ks5=1;ks6=1;
	$(function() {
		$("#btn_addSafety0,#btn_addSafety1,#btn_addSafety2,#btn_addSafety3,#btn_addSafety4,#btn_addSafety5").click(
						function() {
							var kk1 = 0;
							var content = "";
							switch($(this).attr("id")){
							case "btn_addSafety0":kk1 = (++ks1);content="食品安全资质上传"; break;
							case "btn_addSafety1":kk1 = (++ks2);content="生产许可证上传";break;
							case "btn_addSafety2":kk1 = (++ks3);content="QS商城许可证上传";break;
							case "btn_addSafety3":kk1 = (++ks4);content="检测报告上传";break;
							case "btn_addSafety4":kk1 = (++ks5);content="品牌资质授权上传";break;
							case "btn_addSafety5":kk1 = (++ks6);content="厂家代理授权上传";break;
							}
							$(this).prev().append(
											"<div id='"+$(this).prev().attr("id")+"_"
													+ kk1
													+ "' >"+content+"_"+kk1+"&nbsp;&nbsp;&nbsp;&nbsp;<input  name='file_"+$(this).prev().attr("id")+"_"+kk1+"' id='file_"+$(this).prev().attr("id")+"_"+kk1+"' type='file'  />"
													+ "<div id='pimgdiv_"+$(this).prev().attr("id")+"_"+kk1+"'><img id='pimg_"+$(this).prev().attr("id")+"_"+kk1
													+"' style='width: 200px; height: 200px; border: 1px solid #999;' src='<%=path%>/images/redimg/sctx.jpg' alt='请先选择浏览图片才可预览'><input type='button' value='删除'  onclick='del_safety("+$(this).prev().attr("id")+","+ kk1+ ");'/></div>");
							new uploadPreview({
								UpBtn : "file_"+$(this).prev().attr("id")+"_" + kk1,
								DivShow : "pimgdiv_"+$(this).prev().attr("id")+"_" + kk1,
								ImgShow : "pimg_"+$(this).prev().attr("id")+"_" + kk1
							});
						});

	});
	function del_safety(id,o) {
	/* alert($(id).attr("id"));
	var i=$(id).parent().parent().attr("id"); */
	var i=$(id).attr("id");
		document.getElementById(i).removeChild(
				document.getElementById(i+"_" + o));
	}
</script>

<style type="text/css">
.grid_1 {
	float: left;
	height: 229px;
	/* overflow: hidden; */
	width: 192px;
	margin-right: 10px;
}
/* .grid_1 {
	float: left;
	height: 229px;
	/* overflow: hidden; */
width




:


 


204
px




;
margin-right




:


 


10
px




;
}
* /
	/* .gr_j{
    height: 229px;
	width: 204px;
} */   
.gr_j {
	height: 229px;
	width: 180px;
}

}
#bc {
	background-color: #C01000;
	height: 30px;
	width: 120px;
	margin-left: 10%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

#qr {
	/* 	background-color: #FF4030; */
	height: 30px;
	width: 120px;
	margin-left: 2%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

#qx {
	/* background-color: orange; */
	height: 30px;
	width: 120px;
	margin-left: 2%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

.pagin {
	position: relative;
	margin-top: 10px;
	padding: 0 12px;
}

.pagin .blue {
	color: #056dae;
	font-style: normal;
}

.pagin .paginList {
	margin: 10px;
	right: 12px;
	top: 0;
}

.pagin .paginList .paginItem {
	float: left;
}

.pagin .paginList .paginItem a {
	float: left;
	width: 31px;
	height: 28px;
	border: 1px solid #DDD;
	text-align: center;
	line-height: 30px;
	border-left: none;
	color: #3399d5;
}

.pagin .paginList .paginItem:first-child a {
	border-left: 1px solid #DDD;
}

.pagin .paginList .paginItem:first-child a {
	border-bottom-left-radius: 5px;
	border-top-left-radius: 5px;
}

.pagin .paginList .paginItem:last-child a {
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
}

.pagin .paginList .paginItem.current, .pagin .paginList .paginItem.current a
	{
	background: #f5f5f5;
	cursor: default;
	color: #737373;
}

.pagin .paginList .paginItem:hover {
	background: #f5f5f5;
}

.pagin .paginList .paginItem.more, .pagin .paginList .paginItem.more a:hover
	{
	cursor: default;
}

.pagin .paginList .paginItem.more:hover {
	background: #FFF;
}

.pagin .paginList .paginItem.more a {
	color: #737373;
}

.pagepre {
	background: url(../images/pre.gif) no-repeat center center;
	width: 31px;
	height: 28px;
}

.pagenxt {
	background: url(../images/next.gif) no-repeat center center;
	width: 31px;
	height: 28px;
}

.j_1 a {
	color: #626262;
}

.j_1 {
	text-align: center;
}

#qr1 {
	font-size: 14px;
	height: 30px;
	margin-left: 2%;
	margin-right: 50px;
	width: 120px;
	display: none;
}

.gray {
	background-color: gray;
	border: medium none;
	border-radius: 3px;
	color: #fff;
}
</style>
</head>
<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2"> 商品管理 ></span><span
				class="lo2"> 商品供应</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab1">商品选择</a></li>
				<li><a href="#" title="tab2">商品详情</a></li>
				<li><a href="#" title="tab3">商品资质</a></li>
			</ul>
			<div id="content">
				<form id="form1" action="toProductEdit.do" method="post">
					<input type="hidden" id="currentPage" name="currentPage" value="1" />
					<input type="hidden" id="productCategory" name="productCategory"
						value="" />
					<div id="tab1" class="nextDiv">
						<span><b>条件(模糊)筛选</b> </span>
						<table style="border: 1px solid #d7d7d7; width: 100%;">

							<tr>
								<th>商品名称：</th>
								<td><input class="mch_input" type="text" name="productName"
									id="productName" /></td>
							</tr>
							<tr>
								<th>商品品类：</th>
								<td id="selects" colspan="3"><select
									style="width: 100px; height: 20px;" name="select1" id="select1"
									onchange=checkCategory(this.value)>
										<option value="">请选择父品类</option>
										<c:forEach items="${productCategorys}" var="pcs">
											<option value="${pcs.id}">${pcs.cateGoryName}</option>
										</c:forEach>
								</select> <select style="width: 110px; height: 20px;" id="select2"
									name="select2"
									onchange="if(this.value==''){$('tdId').html('')};checkCategorysun(this.value);">
										<option value="">请先选择父品类</option>
								</select></td>
							</tr>
							<tr>
								<th>商品类别：</th>
								<td id="tdId" colspan="2">请先选择品类</td>
							</tr>
							<tr>
								<th></th>
								<td><input style="height: 20px; width: 100px;"
									class="orange" type="submit" onclick="change();" value="搜索" />
								</td>
							</tr>

						</table>
						<hr color="red" />
						<p>搜索结果</p>
						<div id="productInfo">
							<c:forEach items="${products}" var="product" varStatus="status2">
								<div class="grid_1">
									<ul class="gr_j">
										<li class="j_1"><a
											href="<%=path%>/web/toProductInfo.do?ProductId=${product.id}"><img
												<%-- height="181" width="200" src="<%=path%>${product.filePath}" /> --%>
												height="181"
												width="180" src="<%=path%>${product.filePath}" /> </a></li>
										<li class="j_1" name="${product.id}"><a
											href="<%=path%>/web/toProductInfo.do?ProductId=${product.id}">${product.productName}</a>
										</li>
										<li class="j_1"><a
											href="javascript:checksupply(${product.id});">我要供应</a></li>
										<%-- $('#tab2 span[class=name]').html(${product.productName}); --%>
									</ul>
								</div>
							</c:forEach>
						</div>
						<!-- 分页 -->
						<div class="pagin" style="clear: both">
							<div id="Pagination" class="meneame" style="clear: left"></div>
						</div>
						<%-- <div class="pagin" style="clear:both">
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
											href="toProductEdit.do?currentPage=${page.currentPage-1}"><span
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
												href="toProductEdit.do?currentPage=${s3}">${s3}</a></li>
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
											href="toProductEdit.do?currentPage=${page.currentPage+1}"><span
												class="pagenxt"></span> </a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div> --%>
					</div>
				</form>
				<form id="form2" action="productEdit.do"
					enctype="multipart/form-data" method="post">
					<!-- 公司ID -->
					<input type="hidden" id="id" name="id" value=""> <input
						type="hidden" id="address" name="address" value=""> <input
						type="hidden" id="isDefault" name="isDefault" value="" /> <input
						type="hidden" id="priceRange" name="priceRange" value="" /> <input
						type="hidden" id="safetys" name="safetys" value="" /> <input
						class="input_text1" type="hidden" name="productName"
						id="productName" />
					<div id="tab2" class="nextDiv">
						<%-- 	<p style="background-color:#D0D0D0;">请提供供应地域             <span id="msg" style="color:red;">*新增地址重复，请更改！*</span></p>		
				<p ><!-- <input type="radio"/> 全选   <input type="button" value="删除"/> --><input type="button" id="sele_add" value="新增地址"> </p>
				<p><span id="span0"><select id="province0" name="province"
							onchange="checkSs(this.value,0)">
								<option value="">请选择省份</option>
								<c:forEach items="${dictionarys}" var="d">
									<option value="${d.id}">${d.dicName}</option>
								</c:forEach>
						</select> <select id="city0" name="city"
							onchange="if(this.value!=1){checkss(this.value,0);}">
								<option value="1">请选择城市</option>
						</select> <select id="district0" name="district"
							onchange="if(this.value!=1){checkss(this.value,0);}">
								<option value="1">请选择地区</option>
						</select>&nbsp;<input type="text"  id="shoppingAddress0" name="shoppingAddress0" value="三环以外不配送"/>
					</span>
				</p> --%>
						<!-- <p><input type="radio"/>&nbsp;<select><option>湖北省</option></select>&nbsp;<select><option>武汉市</option></select>&nbsp;<select><option>洪山区</option></select>&nbsp;<input type="text" value="三环以外不配送"/></p> -->
						<p>
							商品名字：<span class="name"></span>
						</p>
						<p style="background-color: #D0D0D0;">选择本地图片：
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提示：1.图片大小不超过500KB&nbsp;&nbsp;2.本品类图片不超过10张</p>
						<input type="button" id="btn_add" class="orange"
							style="width: 80px; height: 20px; margin-bottom: 5px;"
							value="新增图片"><span class="tupian"
							style="color: red; display: none;">请新增合适图片</span>
						<!-- <span
							style="float:right;margin-right:30%;font-size:16px;color:red;">是否提供商品小样&nbsp;<input
							id="isSample" name="isSample" value="1" type="checkbox" /> </span> -->

						<!-- class="tupian" style="color:red;display:none;">请新增合适图片</span>
						</span> -->

						<div id="newUpload2">
							<div id="div_" name="divPic">
								<input type="file" id="file0" name="file0">
								<div id="pimgdiv0">
									<img id="pimg0"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								默认首图：<input type="radio" checked="checked" name="fefe" value="1" />
							</div>
						</div>

						<p style="background-color: #D0D0D0;">价格编辑</p>
						<p>
							单价：<input type="text" name="unitPrice" id="unitPrice"
								onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
								onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" /><span
								class="hong1" style="color: red; display: none;">请输入合适的单价</span>
						</p>
						<p>区间价：</p>
						<table style="width: 80%; border: 1px soild; color: gray;">
							<thead>
								<tr>
									<th>数量</th>
									<th width="150px;">价格</th>
									<th width="100px;"></th>
								</tr>
							</thead>
							<tbody id="tab2body">
								<tr>
									<td align="center">0~500</td>
									<td align="center"><input type="text" value="100"
										id="text1"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong2" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
								<tr>
									<td align="center">500~1000</td>
									<td align="center"><input type="text" value="80"
										id="text2"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong3" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
								<tr>
									<td align="center">1000~2000</td>
									<td align="center"><input type="text" value="60"
										id="text3"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong4" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
								<tr>
									<td align="center">2000及以上</td>
									<td align="center"><input type="text" value="40"
										id="text4"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong5" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
							</tbody>
						</table>

						<p style="background-color: #D0D0D0;">库存编辑</p>
						<p>
							库存数量&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="goodsNum"
								value="0" onkeyup="this.value=this.value.replace(/\D/g,'')"
								onafterpaste="this.value=this.value.replace(/\D/g,'')" /><span
								class="hong6" style="color: red; display: none;">请输入合适的库存数量</span>

						</p>
						<p>
							购物车数量上限&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" />
						</p>
						<p>
							存量过低通知&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" />&nbsp;&nbsp;
							<input type="checkbox" checked="checked" />使用短信通知
						</p>
						<p style="height: 30px; background-color: #D0D0D0;">
							<span
								style="float: left; margin-right: 30%; font-size: 16px; color: red;">是否提供商品小样&nbsp;<input
								id="isSample" name="isSample" value="1" type="checkbox" />
						</p>
						<input type="button" class="orange" value="下一步" onclick="next2()"
							id="bc" />
						<!-- <input type="submit"  onclick="save();" value="确认提交" id="qr"/> -->
						<input type="button" class="orange"
							onclick="location.href='<%=path%>/merchant/toPurchaserList.do';"
							value="取消返回" id="qx" />
						<div style="clear: both"></div>
					</div>

					<div id="tab3" class="nextDiv">
						<p>
						<div id="safety0">
							<div id="safety0_1">
								食品安全资质上传_1&nbsp;&nbsp;&nbsp;&nbsp;<input type="file"
									id="file_safety0_1" name="file_safety0_1">
								<div id="pimgdiv_safety0_1">
									<img id="pimg_safety0_1"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								<span class="image1" style="color: red; display: none;">请选择合适的图片</span>
							</div>
						</div>
						<input class="orange input_but1" type="button" id="btn_addSafety0"
							style="width: 100px;" value="新增该资质图片">
						</p>
						<p>
						<div id="safety1">
							<div id="safety1_1">
								生产许可证上传_1&nbsp;&nbsp;&nbsp;&nbsp;<input type="file"
									id="file_safety1_1" name="file_safety1_1">
								<div id="pimgdiv_safety1_1">
									<img id="pimg_safety1_1"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								<span class="image2" style="color: red; display: none;">请选择合适的图片</span>
							</div>
						</div>
						<input class="orange input_but1" type="button" id="btn_addSafety1"
							style="width: 100px;" value="新增该资质图片">
						</p>
						<p>
						<div id="safety2">
							<div id="safety2_1">
								QS商城许可证上传_1&nbsp;&nbsp;&nbsp;&nbsp;<input type="file"
									id="file_safety2_1" name="file_safety2_1">
								<div id="pimgdiv_safety2_1">
									<img id="pimg_safety2_1"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								<span class="image3" style="color: red; display: none;">请选择合适的图片</span>
							</div>
						</div>
						<input class="orange input_but1" type="button" id="btn_addSafety2"
							style="width: 100px;" value="新增该资质图片">
						</p>
						<p>
						<div id="safety3">
							<div id="safety3_1">
								检测报告上传_1&nbsp;&nbsp;&nbsp;&nbsp;<input type="file"
									id="file_safety3_1" name="file_safety3_1">
								<div id="pimgdiv_safety3_1">
									<img id="pimg_safety3_1"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								<span class="image4" style="color: red; display: none;">请选择合适的图片</span>
							</div>
						</div>
						<input class="orange input_but1" type="button" id="btn_addSafety3"
							style="width: 100px;" value="新增该资质图片">
						</p>
						<p style="background-color: #D0D0D0;">品牌授权</p>
						<p>
						<div id="safety4">
							<div id="safety4_1">
								品牌资质授权上传_1&nbsp;&nbsp;&nbsp;&nbsp;<input type="file"
									id="file_safety4_1" name="file_safety4_1">
								<div id="pimgdiv_safety4_1">
									<img id="pimg_safety4_1"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								<span class="image5" style="color: red; display: none;">请选择合适的图片</span>
							</div>
						</div>
						<input class="orange input_but1" type="button" id="btn_addSafety4"
							style="width: 100px;" value="新增该资质图片">
						</p>
						<p>
						<div id="safety5">
							<div id="safety5_1">
								厂家代理授权上传_1&nbsp;&nbsp;&nbsp;&nbsp;<input type="file"
									id="file_safety5_1" name="file_safety5_1">
								<div id="pimgdiv_safety5_1">
									<img id="pimg_safety5_1"
										style="width: 200px; height: 200px; border: 1px solid #999;"
										src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
								</div>
								<span class="image6" style="color: red; display: none;">请选择合适的图片</span>
							</div>
						</div>
						<input class="orange input_but1" type="button" id="btn_addSafety5"
							style="width: 100px;" value="新增该资质图片">
						</p>
						<input type="submit" class="orange" onclick="save();" value="确认提交"
							id="qr" /> <input type="button" class="gray" value="确认提交"
							id="qr1" /><input type="button" class="orange"
							onclick="location.href='<%=path%>/merchant/toPurchaserList.do';"
							value="取消返回" id="qx" />
					</div>
				</form>
			</div>
		</div>

	</div>
	<!-- <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>  -->
	<script>
		$(document)
				.ready(
						function() {
							$("#msg").hide();
							$("#content div").hide(); //隐藏所有div
							$("#tabs li:first").attr("id", "current");
							$("#tab1,#tab1 div").fadeIn();//显示默认div
							$('#tabs a').click(
									function(e) {
										e.preventDefault();
										if ($("#id").val() == "") {
											return;
										}
										$("#content div").hide();
										$("#tabs li").attr("id", "");
										$(this).parent().attr("id", "current");
										$(
												'#' + $(this).attr('title')
														+ ',#'
														+ $(this).attr('title')
														+ ' div').fadeIn();
									});
							//新增地址项
							j = 0;
							$("#sele_add")
									.click(
											function() {
												var addr1 = $("#province0")
														.html();
												$("#span" + j)
														.after(
																'<span id="span'
																		+ (++j)
																		+ '"><br/><select id="provice'
																		+ j
																		+ '" name="provice'
																		+ j
																		+ '" onchange="checkSs(this.value,'
																		+ j
																		+ ')">'
																		+ addr1
																		+ '</select><select id="city'
																		+ j
																		+ '" name="city'
																		+ j
																		+ '" onchange="checkss(this.value,'
																		+ j
																		+ ')"><option value="1">请选择城市</option></select><select id="district'
																		+ j
																		+ '" name="district'
																		+ j
																		+ '" onchange="checkss(this.value,'
																		+ j
																		+ ')"><option value="1">请选择地区</option></select><input type="text"  id="shoppingAddress'+j+'" name="shoppingAddress'+j+'" value="三环以外不配送"/><input type="button" value="删除"  onclick="span('
																		+ j
																		+ ')"/></span>');

											});

							k = 0;
							//动态修改图片上传个数
							$("#btn_add")
									.click(
											function() {
												$("#newUpload2")
														.append(
																"<div id='div_"
																		+ (++k)
																		+ "' ><input  name='file_"+k+"' id='file"+k+"' type='file'  />"
																		+ "<input type='button' value='删除'  onclick='del_2("
																		+ k
																		+ ")'/><div id='pimgdiv"+k+"'><img id='pimg"+k+"' style='width: 200px; height: 200px; border: 1px solid #999;' src='<%=path%>/images/redimg/sctx.jpg' alt='请先选择浏览图片才可预览'></div><input type='radio' name='fefe' value='0' />");
											new uploadPreview({ UpBtn: "file"+k, DivShow: "pimgdiv"+k, ImgShow: "pimg"+k });
											});
						})();
	</script>
</body>
</html>
