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
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />

<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
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
	//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor().panelInstance('contents');
	});
	//保存
	function save() {
		//拼接商品属性集
		var radioChecked = $(".子类:checked,.品牌:checked,:checkbox:checked");
		var productCategory = $("[name='select1']").val() + ","
				+ $("[name='select2']").val()
				+ $("[name='productCategory']").val();
		$.each(radioChecked, function(i, node) {
			productCategory += "," + node.value;
		});
		$("[name='productCategory']").val(productCategory);

		//拼接多个省市区字符串
		/* var spans = $("#tab2 p span[id]");
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
			address +=(i >= spans.length - 1) ? "" : ";";
		});
		alert(address);
		$("#address").val(address.substring(1));
		//验证新增省市区是否与该供应商数据库地址一致
		
		
		
		//验证新增省市区是否不一致
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
		/* var isDefaultNode = $("#newUpload2 :radio:checked"); */
	/* 	$.each(isDefaultNode, function(i, node) {
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
		$("#tab2body input").each(
				function(i, node) {
					var id = $(node).val();
					PriceRange += id
							+ ((i >= $("#tab2body input").length - 1) ? ""
									: ",");
				});
		$("#priceRange").val(PriceRange);

		//拼接安全认证成json
		/* var safetys = "{";
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
		//商品规格
		$("#productModel").val($(".规格:checked").attr("title"));
		//商品品牌
		$("#productBrandId").val($(".品牌:checked").attr("title"));
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
					if(json[i].cateGoryName=="规格"){
					checkboxss += "<input type='checkbox' "+As+"title='"+jsons[j].cateGoryName+"' name='name"+i+"' value='"+jsons[j].id+"'/>"+"<input type='radio' "+As+"class='"+json[i].cateGoryName+"' title='"+jsons[j].cateGoryName+"' name='name"+i+"' value='"+jsons[j].id+"'/>";
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
	//商品详情块

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
	j = 0;
	//新增地址项
	$(function() {
		$("#sele_add")
				.click(
						function() {
							var addr1 = $("#province0").html();
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
													+ j + ')"/></span>');

						});

	});
	function span(o) {
		$("#span" + o).remove();
	}
	k = 0;
	//动态修改商品图片上传个数
	$(function() {
		$("#btn_add")
				.click(
						function() {
							$("#newUpload2")
									.append( 
											"<div id='div_"
													+ (++k)
													+ "' ><input  name='file_"+k+"' id='file"+k+"' type='file'  />"
													+ "<input class='orange input_but2' type='button' value='删除'  onclick='del_2("+ k+ ")'/><div id='pimgdiv"+k+"'><img id='pimg"+k
													+"' style='width: 200px; height: 200px; border: 1px solid #999;' src='<%=path%>/images/redimg/sctx.jpg' alt='请先选择浏览图片才可预览'></div><input type='radio' name='fefe' value='0' />");
							new uploadPreview({
								UpBtn : "file" + k,
								DivShow : "pimgdiv" + k,
								ImgShow : "pimg" + k
							});
						});

	});
	function del_2(o) {
		document.getElementById("newUpload2").removeChild(
				document.getElementById("div_" + o));
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
	
	//下一页切换
	function next() {

		$("#content div").hide();
		$("#tabs li").attr("id", "");
		$('#tabs li:eq(1)').attr('id', 'current');
		$('#tab2,#tab2 div').fadeIn();
	}

	function next2() {

		$("#content div").hide();
		$("#tabs li").attr("id", "");
		$('#tabs li:eq(2)').attr('id', 'current');
		$('#tab3,#tab3 div').fadeIn();
	}

	$(function() {

		$("#productName").blur(function() {
			var s = $.trim($(this).val()).toString();
			//alert(s.length);
			if (s.length < 1) {
				$(".hongxing").show();
			} else {
				$(".hongxing").hide();
			}
		});
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
		$("select[name=select1]").blur(function() {
			if ($("select[name=select1]").val() != "请选择父品类") {
				$(".Category").hide();
			} else {
				$(".Category").show();
			}

		});
		$("select[name=select2]").blur(function() {
			if ($("select[name=select2]").val() != "1") {
				$(".Category").hide();
			} else {
				$(".Category").show();
			}

		});

		$("#qr").click(
				function() {
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

					/**/
					var s = $.trim($("#productName").val()).toString();

					if (s.length < 1) {
						$(".hongxing").show();
					}
					if (s.length >= 1) {
						$(".hongxing").hide();
					}

					var t = $.trim($('.nicEdit-main').html()).toString();
					var str1 = t.substring(0, t.length - 4);

					/* if (/[\u4E00-\u9FA5]/g.test(str1)) {  是否含有中文*/
					if (str1 != "") {
						$(".content").hide();
					} else {
						$(".content").show();
						//	alert("输入错误");
					}

					if ($("select[name=select1]").val() == "请选择父品类"
							&& $("select[name=select2]").val() ==

							"1") {

						$(".Category").show();
					}
					//alert()

					/**/

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

					var s5 = $.trim($("input[name='goodsNum']").val

					()).toString();
					//alert(s5);
					if (s5.length < 1 || $("input[name='goodsNum']").val() ==

					0) {
						$(".hong6").show();
					} else {
						$(".hong6").hide();
					}

					if ($("select[name=select1]").val() != "请选择父品类"
							&& $("select[name=select2]").val() != "1"
							&& s.length >= 1 && t.length >= 5 && str1 != ""
							&& k != "" && s.length >= 1 && s1.length >= 1
							&& s2.length >= 1 && s3.length >= 1
							&& s4.length >= 1 && s5.length >= 1
							&& $("input[name='goodsNum']").val() != 0
							&& k != "" && k1 != "" && k2 != "" && k3 != ""
							&& k4 != "" && k5 != "") {
							
							$("#qr").hide();
							$("#qr1").show();
						return true;
						/* $("#form").submit; */
					} else {

						/* $("#form").attr("action","#");
						$("#form").submit; */
						alert("商品详情、商品资质页面未完善，请按红色提示语完善相应内容！");
						return false;
					}
				});

	});
</script>
<style type="text/css">
#bc {
	/* background-color: #C01000; */
	height: 23px;
	width: 80px;
	margin-left: 10%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

#qr {
	/* background-color: #FF4030; */
	height: 23px;
	width: 80px;
	margin-left: 2%;
	margin-right: 50px;
	font-size: 14px;
	/* color: white; */
}

#qx {
	/* background-color: orange; */
	height: 23px;
	width: 80px;
	margin-left: 2%;
	margin-right: 50px;
	font-size: 14px;
	/* color: white; */
}

#content {
	background: #fff;
	padding: 2em;
	/* position: relative; */
	z-index: 2;
	-moz-border-radius: 0 5px 5px 5px;
	-webkit-border-radius: 0 5px 5px 5px;
	border-radius: 0 5px 5px 5px;
	-moz-box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, .5);
	-webkit-box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, .5);
	box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, .5);
	border: 1px solid #d3d3d3;
}

.input_text1 {
	width: 150px;
	height: 20px;
}

.input_text2 {
	width: 120px;
	height: 20px;
}

.input_but1 {
	width: 70px;
	height: 20px;
}

.input_but2 {
	width: 40px;
	height: 20px;
}

#qr1 {
	font-size: 14px;
	height: 23px;
	margin-left: 2%;
	margin-right: 50px;
	width: 80px;
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
				class="lo2"> 商品申请</span>
		</div>
		<form id="form" action="productEdit.do" enctype="multipart/form-data"
			method="post">
			<input type="hidden" id="productCategory" name="productCategory"
				value="" /> <input type="hidden" id="address" name="address"
				value=""> <input type="hidden" id="isDefault"
				name="isDefault" value="" /> <input type="hidden" id="priceRange"
				name="priceRange" value="" /> <input type="hidden" id="safetys"
				name="safetys" value="" /> <input type="hidden" id="productModel"
				name="productModel" value="" /> <input type="hidden"
				id="productBrandId" name="productBrandId" value="" />

			<div class="detail_list">
				<ul id="tabs">
					<li><a href="#" title="tab1">商品简介</a></li>
					<li><a href="#" title="tab2">商品详情</a></li>
					<li><a href="#" title="tab3">商品资质</a></li>
				</ul>
				<div id="content">
					<div id="tab1" class="div1" style="height: auto;">
						<table
							style="border: 1px solid #d7d7d7; width: 90%; margin-bottom: 5px;">
							<tr>
								<th>商品名称：</th>
								<td><input class="input_text1" type="text"
									name="productName" id="productName" /><span
									style="color: red;">*</span><span class="hongxing"
									style="color: red; display: none;">有红星'*'的必填</span> <!-- <span>有红星'*'的必填</span> --></td>
								<th>计量单位：</th>
								<td><select id="productUnit" name="productUnit">
										<c:forEach items="${dictionarys}" var="Model">
											<option value="${Model.dicName}">${Model.dicName}</option>
										</c:forEach>
								</select></td>
								<!-- <th>商品单价:</th>
					<td><input type="text" required="required" name="unitPrice"
						id="unitPrice" /><span id="">*</span></td> -->
							</tr>
							<tr>
								<th>商品品类：</th>
								<td id="selects" colspan="3"><select class="input_text2"
									name="select1" onchange=checkCategory(this.value)>
										<option>请选择父品类</option>
										<c:forEach items="${productCategorys}" var="pcs">
											<option value="${pcs.id}">${pcs.cateGoryName}</option>
										</c:forEach>
								</select> <select class="input_text2" id="select2" name="select2"
									onchange="if(this.value!=1){checkCategorysun(this.value);}">
										<option value="1">请先选择父品类</option>
								</select><span class="Category" style="color: red; display: none;">请选择相应品类</span>
								</td>
							</tr>
							<tr>
								<th>商品类别：</th>
								<td id="tdId" colspan="3">请先选择品类</td>
							</tr>

							<tr>
								<th><span class="content"
									style="color: red; display: none;">请输入<br />适当的<br />简介内容<br />
								</span>商品简介：</th>
								<td colspan="3"><textarea id="contents" cols="100"
										style="width: 90%; height: 300px;" name="productInfo"></textarea>
								</td>
							</tr>
						</table>
						<input type="button" class="orange input_but1" value="下一步"
							onclick="next()" id="bc" />
						<!-- <input type="submit" value="确认提交" onclick="$('#contents').val($('.nicEdit-main').html());save();" id="qr"/> -->
						<input class="orange input_but1" type="button"
							onclick="location.href='<%=path%>/merchant/toPurchaserList.do';"
							value="取消返回" id="qx" />
					</div>

					<div id="tab2" class="div1" style="height: auto;">
						<%-- <p style="background-color:#D0D0D0;">请提供供应地域          <span id="msg" style="color:red;">*新增地址重复，请更改！*</span></p>		
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

						<p style="background-color: #D0D0D0;">选择本地图片：
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提示：1.图片大小不超过500KB&nbsp;&nbsp;2.本品类图片不超过10张</p>
						<input class="orange input_but1" type="button" id="btn_add"
							value="新增图片"><span style="color: red; display: none;">请新增合适图片</span>
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
							单价：&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="input_text1"
								name="unitPrice" id="unitPrice"
								onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
								onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" /><span
								class="hong1" style="color: red; display: none;">请输入合适的单价</span>
						</p>
						<p>区间价：</p>
						<table
							style="width: 80%; border: 1px soild; color: gray; margin-right: 50px;">
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
									<td align="center"><input class="input_text1" type="text"
										value="100" id="text1"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong2" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
								<tr>
									<td align="center">500~1000</td>
									<td align="center"><input class="input_text1" type="text"
										value="80" id="text2"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong3" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
								<tr>
									<td align="center">1000~2000</td>
									<td align="center"><input class="input_text1" type="text"
										value="60" id="text3"
										onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
										onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')" />
									</td>
									<td><span class="hong4" style="color: red; display: none;">请输入合适的单价</span>
									</td>
								</tr>
								<tr>
									<td align="center">2000及以上</td>
									<td align="center"><input class="input_text1" type="text"
										value="40" id="text4"
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
							库存数量：<input style="margin-left: 48px;" class="input_text1"
								type="text" name="goodsNum" value="0"
								onkeyup="this.value=this.value.replace(/\D/g,'')"
								onafterpaste="this.value=this.value.replace(/\D/g,'')" /><span
								class="hong6" style="color: red; display: none;">请输入合适的库存数量</span>

						</p>
						<p>
							购物车数量上限：&nbsp;&nbsp;&nbsp;&nbsp;<input class="input_text1"
								type="text" />
						</p>
						<p>
							存量过低通知：<input style="margin-left: 24px;" class="input_text1"
								type="text" />&nbsp;&nbsp; <input type="checkbox"
								checked="checked" />使用短信通知
						</p>
						<p style="background-color: #D0D0D0; font-size: 16px; color: red;">
							是否提供商品小样&nbsp;<input id="isSample" name="isSample" value="1"
								type="checkbox" />
						</p>
						<input class="orange" type="button" value="下一步" onclick="next2()"
							id="bc" />
						<!-- <input type="submit"  onclick="save();" value="确认提交" id="qr"/> -->
						<input type="button" class="orange"
							onclick="location.href='<%=path%>/merchant/toPurchaserList.do';"
							value="取消返回" id="qx" />
					</div>

					<div id="tab3">
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
								<c:if test="${productType=='1' }">
									<script type="text/javascript">
								$(function() {
									alert("新品申请成功");
								});
							</script>
								</c:if>
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
						<input type="hidden" name="productType" value="1"> <input
							type="submit" class="orange"
							onclick="$('#contents').val($('.nicEdit-main').html());save()"
							value="确认提交" id="qr" /> <input type="button" class="gray"
							value="确认提交" id="qr1" /> <input type="button" class="orange"
							onclick="location.href='<%=path%>/merchant/toPurchaserList.do';"
							value="取消返回" id="qx" />

					</div>
				</div>

			</div>
		</form>
	</div>

	<script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
	<script>
		$(document).ready(
				function() {
					$("#msg").hide();
					$("#content div").hide();
					$("#tabs li:first").attr("id", "current");
					$("#tab1,,#tab1 div").fadeIn();

					$('#tabs a').click(
							function(e) {
								e.preventDefault();
								$("#content div").hide();
								$("#tabs li").attr("id", "");
								$(this).parent().attr("id", "current");
								$(
										'#' + $(this).attr('title') + ',#'
												+ $(this).attr('title')
												+ ' div').fadeIn();
							});
				})();
	</script>
</body>
</html>
