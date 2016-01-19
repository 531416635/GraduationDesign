<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String productId = request.getParameter("ProductId");
	String jsonAddrs = (String) request.getAttribute("jsonAddrs");
	String json = (String) request.getAttribute("json");
	String product = (String) request.getAttribute("productJson");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/redcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/redcss/address.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector.css" />
<link href="<%=path%>/css/redcss/style.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="<%=path%>/js/redjs/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
var jsonAddrs =<%=jsonAddrs%>;
var product = <%=product%>;
var valid=product.productModel;  //radio退回到有效常数；
$(function(){
		$("#defaultImg").attr("src", $(".zoom-desc img:first").attr("src"));
		 $("#msg").hide();
		 $("#city").hide();
		 $("#district").hide();
		});
	$(function() {
	var content='<dd>';
	var flag='';
	var flag1=false;
	var valid='';
		for(var i=0;i<product.productCategorys.length;i++){
	if(product.productCategorys[i].cateGoryName=='规格'){
	content+=product.productCategorys[i].cateGoryName+' :';
	for(var j=0;j<product.productCategorys.length;j++){
	if(product.productCategorys[i].id==product.productCategorys[j].parentCateGory){
	if(product.productModel==product.productCategorys[j].id){
	flag='checked="checked"';
	}else{
	flag='';
	}
	content+=' <input type="radio" name="standard" '+flag+' onclick="changeProduct(this);" value="'+product.productCategorys[j].id+'">'+product.productCategorys[j].cateGoryName;
	}
	};
	flag1=true;
	}
	};
	content+='</dd>';
	if(!flag1){
	content='';
	}
	$("#proInfo").append(content);
	});
	function changeProduct(productModel){
	$.ajax({
			type : "POST",
			url : "/ssm/products/findProductByModel.do",
			dataType : "text",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				"productName" : product.productName.replace(/[^\u4e00-\u9fa5]/g,''),
				"productModel" :$(productModel).val()
			},
			success : function(data) {
				var result=eval("("+data+")");
				//提示问题内容			
				if (result.result == "true") {
					//跳转	
				window.location.href= "toProductInfo.do?ProductId="+result.productId;
				} else{
				alert("此规格商品不存在！请尝试购买其他规格商品！");
				window.location.reload(); 
				}
				
			},
			error : function(data){
			alert("发生错误了！");
			}
			
		});
	}
	var productId =<%=productId%>;
	var address="";
	var addNum=function(){
	var num=1;
	var buyNum=$("#buyNum").val();
	if(buyNum!=null && buyNum!=""){
	num = parseInt(buyNum)+1;
	if(num>=10000)
	{
	num=10000;
	}
	}
	$("#buyNum").val(num);
	};
	var subNum=function(){
	var num=1;
	var buyNum=$("#buyNum").val();
	if(buyNum!=null && buyNum!=""){
	num = parseInt(buyNum)-1;
	if(num<=1)
	{
	num=1;
	}
	}
	$("#buyNum").val(num);
	};
	
	var addNum1=function(){
	
	var buyNum1=$("#buyNum1").val();
	var num1 = parseInt(buyNum1)+1;
	if(num1>=5)
	{
	num1=5;
	}
	$("#buyNum1").val(num1);
	};
	var subNum1=function(){
	var buyNum1=$("#buyNum1").val();
	var num1 = parseInt(buyNum1)-1;
	if(num1<=1)
	{
	num1=1;
	}
	$("#buyNum1").val(num1);
	};
	
	
	
	
	
	var AddInquirySheet = function() {
	var buyNum=$("#buyNum").val();

	/* var address=$("#province").val()+","+$("#city").val()+","+$("#district").val();
	var num = parseInt(buyNum);
	
	if(address.length<8){
	 $("#msg").show();
	}else{
	$("#msg").hide();
	} */
	
	address=$("#addressjoin").val();
		if(buyNum!=""&&buyNum!="0"){
		
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddInquirySheet.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"buyNum":buyNum,
				"address":address
			},
			success : function(data) {	
			//按钮置灰
	$("#t1").hide();
	$("#t11").show();
				var json =eval('(' + data + ')');
				//alert(data);
				if (json.result == "true") {
				//跳转
				//alert(json.inquiryId);
			   if(json.inquiryId=='null')
				{
					alert("暂时不能询价，请联系管理员");
				   // window.location.href= "<%=path%>/web/toLogin.do";			
				}		
				else	if(json.inquiryId!=null && json.inquiryId!='')
				{
					window.location.href= "<%=path%>/merchant/myInquiry.do?InquiryId="+json.inquiryId;
				}
				} else{
				switch(json.result)
				{
					case "1":
					alert("请先登录！");
				    window.location.href= "<%=path%>/web/toLogin.do";			
					break;
					case "2":
					alert("请进行企业认证！");
					window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
					break;
					case "3":
					alert("等待系统后台认证！");
					break;
					case "4":
					alert("未签署协议，请先签署！");
					break;
					case "5":
					alert("对不起，你没有操作权限，请与管理员联系");
					break;
				}
					
			}
			
			},
			error:function(e){
			alert(e);
			}
		});
		}else{
		 $("#msg").show();
		}
	};
	
	var AddFavorite = function() {

		address=$("#addressjoin").val();
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddFavorite.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"address":address,
				"favoriteType":1,//1代表普通商品收藏
			},
			success : function(data) {
					//按钮置灰
					$("#t2").hide();
	$("#t21").show();
				
				//提示问题内容			
				if (data == "true") {
					//跳转
					alert("添加成功");
				window.location.href= "<%=path%>/merchant/myCollection.do?favoriteType=1";
					} else{
				switch(data)
				{
					case "1":
					alert("请先登录");
					window.location.href= "<%=path%>/web/toLogin.do";
					break;
					case "2":
					alert("请进行企业认证！");
					window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
					break;
					case "3":
					alert("等待系统后台认证！");
					break;
					case "4":
					alert("未签署协议，请先签署！");
					break;
					case "5":
					alert("对不起，你没有操作权限，请与管理员联系");
					break;
					case "6":
					alert("商品已收藏");
					break;
				}
			}
			}
		});
	};
	var AddShoppingCart = function() {
	
	var buyNum=$("#buyNum").val();
	/* var address=$("#province").val()+","+$("#city").val()+","+$("#district").val(); if(address.length<8){
	 $("#msg").show();
	} */
	address=$("#addressjoin").val();
	var num = parseInt(buyNum);	
		if(buyNum!=""&&num!=0&&address.match(/\d+/g).length==3){
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/addShoppingCart.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"buyNum":buyNum,
				"address":address
			},
			success : function(data) {
			//按钮置灰
			$("#t3").hide();
	$("#t31").show();
				//提示问题内容			
				if (data == "true") {
					//跳转
					window.location.href= "<%=path%>/merchant/InquiryShoppingCar.do";
						} else{
				switch(data)
				{
					case "1":
					alert("请先登录");
					window.location.href= "<%=path%>/web/toLogin.do";
					break;
					case "2":
					alert("请进行企业认证！");
					window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
					break;
					case "3":
					alert("等待系统后台认证！");
					break;
					case "4":
					alert("未签署协议，请先签署！");
					break;
					case "5":
					alert("对不起，你没有操作权限，请与管理员联系");
					break;
								}
							}
						}
					});
		} else {
			$("#msg").show();
		}
	};
	function checkCitys(id) {
		$.ajax({
			type : "POST",
			url : "provinceLinkage.do",
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
					/* alert(json); */
					$("#city").children().remove();
					listCitys2(json);
				}
			}
		});
	}
	function checkDistrict(id) {
		$.ajax({
			type : "POST",
			url : "provinceLinkage.do",
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
					$("#district").children().remove();
					listDistrict2(json);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}

	//二级显示
	function listCitys2(json) {
		if (json.length > 0) {
			$("#city").show();
			$("#district").hide();
			var option1 = $("<option value=''></option>");
			option1.html("请选择城市");
			$("#city").append(option1);
			for ( var i = 0; i < json.length; i++) {
				var option2 = $("<option></option>");
				option2.html(json[i].dicName);
				option2.val(json[i].id);
				$("#city").append(option2);
			}
		}
	};

	//三级显示
	function listDistrict2(json) {
		/* var option1 = $("<option value=''></option>");
			option1.html("请选择区域");
			$("#district").append(option1); */
		if (json.length > 0) {
			$("#district").show();
			for ( var i = 0; i < json.length; i++) {
				var option2 = $("<option></option>");
				option2.html(json[i].dicName);
				option2.val(json[i].id);
				$("#district").append(option2);
			}
		}
	};
	$(function() {
		var flag = false; //标识生成分页时是否生成查询默认页商品
		var json = eval(<%=json%>
	);
		$("#rows").html(json.rows);
		$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
			$("#Pagination").pagination(json.rows, { // 创建分页按钮
				current_page : json.currentPage - 1,
				num_edge_entries : 3, //边缘页数
				num_display_entries : 3, //主体页数
				callback : pageselectCallback,
				items_per_page : json.pageNum, //每页显示1项
				prev_text : "上一页",
				next_text : "下一页"
			});
		};
		function pageselectCallback(page_index, jq) { //此函数为分页动态按钮展现的回调函数，即分页展现商品
			if (flag) {
				location.href = "toProductInfo.do?currentPage="
						+ (page_index + 1) + "&&ProductId="
						+ $("#productID").val();
			}
			flag = true;
			return false;
		}
		initPagination();
	});
	
//----------------------------------页面加载进度条
 $(document).ready(function(){
	var h = $(document).height();
	$(".overlay").css({"height": h });	
	$(".action").click(function(){
		$(".overlay").css({'display':'block','opacity':'0.8'});
		$(".showbox").stop(true).animate({'margin-top':'300px','opacity':'1'},200);
		setTimeout(function(){
			$(".showbox").stop(true).animate({'margin-top':'250px','opacity':'0'},400);
			$(".overlay").css({'display':'none','opacity':'0'});
		},800);
	});
}); 		

//-----------按钮点击后自灰
function disable(obj){
	 obj.style.color ='#E3E3E3'; 	 
	 obj.removeAttr('href'); 
	 obj.removeAttr('onclick');
	 }
</script>
<style>
div.meneame span {
	display: inline;
}

.gray{
	display:none;
	background-color:#E3E3E3;
    border: medium none;
    border-radius: 3px;
    color: #fff;
    font-size: 14px;
    height: 30px;
    width: 120px;
    padding:1px 12px;

}
</style>
</head>
<body>
	<div class="warp">
		<div class="detail_left">
			<div class="detail_left_nav">
				<div class="left_nav">
					<div class="all-sort-list">
						<c:forEach items="${productCategorys}" var="proca"
							varStatus="status1">
							<c:if test="${proca.parentCateGory == null }">
								<div class="item bo">
									<h3 class="nav_left_con">
										<em style="margin: -5px 10px 0px -30px;"
											class="A-em${status1.count}"></em> <a class="nav_left"
											href="toSecondIndex.do?cateGoryId=${proca.id}&cateGoryLevel=1">${proca.cateGoryName}</a>
										<input type="hidden" id="hidCateGoryId${status1.count}"
											value="${proca.id}">
									</h3>
									<div class="item-list clearfix">
										<!-- 弹出层关闭小叉叉<div class="close">x</div> -->
										<div class="subitem">
											<%-- <c:forEach items="${proca.productCategorys}" var="pcs">
											<c:if test="${pcs.parentCateGory == proca.id }">
												<dl class="fore1">
													<dt>
														<a
															href="toSecondIndex.do?cateGoryId=${proca.id}&cateGorySunId=${pcs.id}&cateGoryLevel=2">${pcs.cateGoryName}</a>
													</dt>
													<c:forEach items="${pcs.productCategorys}" var="pc">
														<c:if
															test="${pc.parentCateGory == pcs.id and pc.cateGoryCode==1}">
															<dd>
																<em>${pc.cateGoryName}:</em>
																<c:forEach items="${sunProductCategorys}" var="pcItem">
																	<c:if test="${pcItem.parentCateGory == pc.id }">
																		<em><a
																			href="toSecondIndex.do?cateGoryId=${proca.id}&cateGorySunId=${pcs.id}&cg3Id=${pcs.id}&cg4Id=${pcItem.id}&cateGoryLevel=4">${pcItem.cateGoryName}</a>
																		</em>
																	</c:if>
																</c:forEach>
															</dd>
														</c:if>
													</c:forEach>
												</dl>
											</c:if>
										</c:forEach> --%>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="hot">
				<span class="scan">精品推荐</span><!--  <span class="more">>>更多</span> -->
				<div class="goods_list">

					<c:forEach items="${subpageShows}" var="pros">
						<dl>
							<dt>
								<b><img width="50" height="50"
									src="<%=path%>${pros.filePath}" /> </b>
							</dt>
							<dd>
								${pros.productName}<b>团餐食材,尽在掌握</b>
							</dd>
						</dl>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="detail_right">

			<div class="con_div">
				<div class="zo_left">
					<div class="zoom-small-image">
						<a href='#' class='cloud-zoom' id='zoom1'
							rel="adjustX:10, adjustY:-4"><img id="defaultImg" src="#"
							width="302" height="299" alt='' title="Optional title display" />
						</a>
					</div>
					<div class="zoom-desc">
						<p>
							<c:forEach items="${productPic}" var="pp" varStatus="status">
							<c:if test="${pp.isDefault==0}">
								<a href='#' class='cloud-zoom-gallery' title='Red'
									rel="useZoom: 'zoom1', smallImage: '<%=path%>${pp.filePath}' ">
									<img id="img${status.count}" src="<%=path%>${pp.filePath}"
									alt="Thumbnail ${status.count}" width="46" height="44"
									class="zoom-tiny-image" /> </a>
							</c:if>
							</c:forEach>
						</p>
					</div>
				</div>

				<div class="zo_right">
					<div class="text_div">
						<dl id="proInfo">
							<dt>${product.productName}</dt>
							<c:forEach items="${product.productCategorys}" var="p3">
								<c:if test="${p3.parentCateGory==null}">
									<c:forEach items="${product.productCategorys}" var="p4">
										<c:if test="${p4.parentCateGory==p3.id}">
											<c:forEach items="${product.productCategorys}" var="p1">
												<c:forEach items="${product.productCategorys}" var="p2">
													<c:if test="${p1.id==p2.parentCateGory&&p1.id!=p3.id&&p1.id!=p4.id and (p1.cateGoryCode==1 or p1.cateGoryCode==2)}">
														<dd>${p1.cateGoryName} : ${p2.cateGoryName}</dd>
													</c:if>
												</c:forEach>
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
						</dl>

					</div>

					<div class="shop">
						<div class="shop_box">
							<span id="msg" style="color:red;display:none;">*请先填写数量与地址*</span><br />
							<div class="buy">

								<span>我要买：</span> <input type="button" id="jian" value="-"
									onclick="subNum()" /> <input type="text" id="buyNum"
									name="buyNum" value="1"
									onkeyup="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
									onafterpaste="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')" /><span
									id="one"></span> <input type="button" id="add" value="+"
									onclick="addNum()" /> <span>${product.productUnit}</span>
							</div>
							<%-- <div class="address_box">
							  配送至<select id="province"
									name="province" onchange="checkCitys(this.value)">
									<option value="">请选择省份</option>
									<c:forEach items="${dictionarys}" var="d">
										<option value="${d.id}">${d.dicName}</option>
									</c:forEach>
								</select> <select id="city" name="city"
									onchange="if(this.value!=1){checkDistrict(this.value);}">
									 <option value="">请选择城市</option> 
								</select> <select id="district" name="district">
									 <option value="">请选择区域</option>
								</select>
							
							</div> --%>
							<div>
								<ul id="list1" style="width:620px;margin:40px auto 0 auto;">
									<li id="summary-stock">
										<div class="dt">配送至：</div>
										<div class="dd">
											<div id="store-selector">
												<div class="text">
													<div></div>
													<b></b><input type="hidden" id="addressjoin" value="" />
												</div>
												<div onclick="$('#store-selector').removeClass('hover')"
													class="close"></div>
											</div>
											<div id="store-prompt">
												<strong></strong>
											</div>
										</div></li>
								</ul>
							</div>

							<div class="btn_box">
								    <a href="javascript:AddInquirySheet();" class="button orange medium action" onclick="disable(this);" id="t1">我要询价</a> 
									<span class="gray" id="t11">我要询价</span>
									<a href="javascript:AddFavorite();" class="button orange medium action" onclick="disable(this);" id="t2">我要收藏</a>
									<span class="gray"  id="t21">我要收藏</span>
									<a href="javascript:AddShoppingCart();" class="button orange medium action" onclick="disable(this);" id="t3">放入进货单</a>
									<span class="gray"  id="t31">放入进货单</span>
							</div>
						</div>

						<div class="prefer_box">
							<dl>
								<dt style="width:100px;">优惠提示：</dt>
								<dd>福临门一级大豆油团购进行中</dd>
								<dd>国宝桥米团购88折全年最低价</dd>
								<dd>一级有机黄金玉米现货特惠中</dd>
								<dd>现货直采想不到的低价疯狂购</dd>
							</dl>
						</div>


						<%-- <table>
							<tr>
							<td>购买数量：
								<input type="text" id="buyNum" name="buyNum"  value="0" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/><span id ="one"></span>
							<span id="msg" style="color:red;">*请先填写数量与地址*</span>
							</td>		
							</tr>
							<tr>
								<td>配送至<select id="province"
							name="province" onchange="checkCitys(this.value)">
							<option value="">请选择省份</option>
							<c:forEach items="${dictionarys}" var="d">
								<option value="${d.id}">${d.dicName}</option>
							</c:forEach>
						</select> <select id="city" name="city"
							onchange="if(this.value!=1){checkDistrict(this.value);}">
							 <option value="">请选择城市</option> 
						</select> <select id="district" name="district"
							onchange="if(this.value!=1){checkDistrict(this.value);}">
							 <option value="">请选择区域</option>
						</select>
								</td>
							</tr>
							<tr>
								<td><input type="button" value="我要询价"
									onclick="AddInquirySheet()" /><input type="button"
									value="我要收藏" onclick="AddFavorite()" /><input type="button"
									value="加入进货单" onclick="AddShoppingCart()" /></td>
							</tr>
						</table> --%>
					</div>
				</div>
			</div>
			<div class="detail_list">
				<ul id="tabs">
					<li id="tabs_li1"><a href="#" title="tab1">商品描述</a>
					</li>
					<!-- <li id="tabs_li2"><a href="#" title="tab2">有机认证</a></li>
					<li id="tabs_li3"><a href="#" title="tab3">用户评价</a></li> -->
					<li id="tabs_li4"><a href="#" title="tab4">商品样品</a>
					</li>
				</ul>
				<div id="content">
					<div id="tab1">
						<p>${product.productInfo}</p>
					</div>
					<%-- <div id="tab2">
						<p></p>
					</div>
					<div id="tab3">
						<p>用户评价</p>
						<table class="tablelist">
							<c:forEach items="${productReviews}" var="pr">
								<tr>
									<td>${pr.reviewBy}</td>
									<td>${pr.reviews}</td>
								</tr>
							</c:forEach>
						</table>
					</div> --%>
					<div id="tab4">
						<c:if test="${user !=null }">
							<c:if test="${findProductSample==1 }">
								<p
									style="float:right;color:red;font-size:1.3em;margin-right:40px;">可申请</p>
							</c:if>
							<c:if test="${findProductSample==null }">
								<p
									style="float:right;color:red;font-size:1.3em;margin-right:40px;">未提供</p>
							</c:if>
							<br /> 往期申请
								<table style="width:100%">
								<tr>
									<th>样品名称</th>
									<th>申请者</th>
									<th>供应商</th>

									<th>小样数量</th>
									<th>规格</th>
									<th>申请时间</th>
									<th>状态</th>
								</tr>
								<c:forEach items="${productSamples}" var="p">

									<tr align="center">
										<td>${p.productName }</td>
										<td>${p.supplierName }</td>
										<td>${p.companyName }</td>

										<td>${p.requestNum }</td>
										<td>${p.requestUnit }</td>
										<td>${p.requestTime }</td>
										<td><c:if test="${p.status==0 }">已申请</c:if> <c:if
												test="${p.status==1 }">已收到</c:if> <c:if
												test="${p.status==2 }">已寄出</c:if></td>
									</tr>

								</c:forEach>

							</table>

						</c:if>
						<!-- 分页 -->
						<div class="pagin" style="clear:left">
							<!-- <p class="meneame" style="display:block;float: left;">
								共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i
									id="currentPage" class="blue"></i>页
							</p> -->
							<div id="Pagination" class="meneame" style="clear:left"></div> 	
						</div> 	
						<input type="hidden" value="${product.id }" id="productID"
							name="productID" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script> -->
	<script type="text/javascript">
		$(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			$("#tabs li:first").attr("id", "current"); // Activate first tab
			$("#content div:first").fadeIn(); // Show first tab content

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide(); //Hide all content
				$("#tabs li").attr("id", ""); //Reset id's
				$(this).parent().attr("id", "current"); // Activate this
				$('#' + $(this).attr('title')).fadeIn(); // Show content for current tab
			});
		})();
	</script>
	<script type="text/javascript" src="<%=path%>/js/redjs/selector.js"></script>
	<script type="text/javascript">
		$(".all-sort-list > .item").hover(
				function() {

					// 对 em 进行 margin 操作; 
					$(this).find(".nav_left_con").find("em").animate({
						margin : '-60px 10px 0 -30px'
					}, 200);

					var eq = $('.all-sort-list > .item').index(this), //获取当前滑过是第几个元素
					h = $('.all-sort-list').offset().top, //获取当前下拉菜单距离窗口多少像素
					s = $(window).scrollTop(), //获取游览器滚动了多少高度
					i = $(this).offset().top, //当前元素滑过距离窗口多少像素
					item = $(this).children('.item-list').height(), //下拉菜单子类内容容器的高度
					sort = $('.all-sort-list').height(); //父类分类列表容器的高度

					if (item < sort) { //如果子类的高度小于父类的高度
						if (eq == 0) {
							$(this).children('.item-list').css('top', (i - h));
						} else {
							$(this).children('.item-list').css('top',
									(i - h) + 1);
						}
					} else {
						if (s > h) { //判断子类的显示位置，如果滚动的高度大于所有分类列表容器的高度
							if (i - s > 0) { //则 继续判断当前滑过容器的位置 是否有一半超出窗口一半在窗口内显示的Bug,
								$(this).children('.item-list').css('top',
										(s - h) + 2);
							} else {
								$(this).children('.item-list').css('top',
										(s - h) - (-(i - s)) + 2);
							}
						} else {
							$(this).children('.item-list').css('top', 3);
						}
					}
					var tmpID = $("#hidCateGoryId" + (eq + 1)).val();
					getSunCateGory(tmpID, this);
					$(this).addClass('hover');
					$(this).children('.item-list').css('display', 'block');
				}, function() {
					// 对 em 进行 margin 操作; 
					$(this).find(".nav_left_con").find("em").animate({
						margin : '0px 10px 0px -30px'
					}, 200);

					$(this).removeClass('hover');
					$(this).children('.item-list').css('display', 'none');
				});

		$('.item > .item-list > .close').click(function() {
			$(this).parent().parent().removeClass('hover');
			$(this).parent().hide();
		});
		var getSunCateGory = function(CateGoryId, obj) {

			$
					.ajax({
						type : "POST",
						url : "getSunCateGory.do",
						dataType : "text",
						data : {
							"CateGoryId" : CateGoryId
						},
						success : function(data) {
							//提示
							var tmpdata = eval('(' + data + ')');
							var tmp = "<div class=\"subitem\">";
							$
									.each(
											tmpdata,
											function(i, item) {

												if (item.parentCateGory == CateGoryId) {
													//alert(item.id);
													tmp += "<dl class=\"fore1\"><dt><a	href=\"toSecondIndex.do?cateGoryId=";
													tmp += CateGoryId;
													tmp += "&cateGorySunId=";
													tmp += item.id;
													tmp += "&cateGoryLevel=2\">";
													tmp += item.cateGoryName;
													tmp += "</a></dt>";
													$
															.each(
																	tmpdata,
																	function(i,
																			pc) {
																		if (pc.parentCateGory == item.id
																				&& pc.cateGoryCode == 1) {
																			tmp += "<dd>";
																			$
																					.each(
																							tmpdata,
																							function(
																									i,
																									pcItem) {
																								if (pcItem.parentCateGory == pc.id) {
																									tmp += "<em><a	href=\"toSecondIndex.do?cateGoryId=";
																									tmp += CateGoryId;
																									tmp += "&cateGorySunId=";
																									tmp += item.id;
																									tmp += "&cg3Id=";
																									tmp += pc.id;
																									tmp += "&cg4Id=";
																									tmp += pcItem.id;
																									tmp += "&cateGoryLevel=4\">";
																									tmp += pcItem.cateGoryName;
																									tmp += "</a></em>";
																								}
																							});
																			tmp += "</dd>";
																		}
																	});
													tmp += "</dl>";
												}
											});
							tmp += "</div>";
							$(obj).children('.item-list').html(tmp);
						}
					});

		};	
	</script>
	
	<div class="overlay"></div>

<div id="AjaxLoading" class="showbox">
	<div class="loadingWord"><img src="<%=path%>/images/waiting.gif">加载中，请稍候...</div>
</div>

<div style="height:1200px;">
	
</div>
</body>
</html>
