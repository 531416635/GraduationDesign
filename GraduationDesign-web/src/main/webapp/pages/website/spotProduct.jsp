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
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#defaultImg").attr("src", $("#img1").attr("src"));
		 $("#msg").hide();
		 $("#city").hide();
		 $("#district").hide();
	});
	var productId =<%=productId%>;
	var address="";
	var addNum=function(){
	var buyNum=$("#buyNum").val();
	var num = parseInt(buyNum)+1;
	if(num>=10000)
	{
	num=10000;
	}
	$("#buyNum").val(num);
	};
	var subNum=function(){
	var buyNum=$("#buyNum").val();
	var num = parseInt(buyNum)-1;
	if(num<=1)
	{
	num=1;
	}
	$("#buyNum").val(num);
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
			url : "AddInquirySheet.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"buyNum":buyNum,
				"address":address
			},
			success : function(data) {
				var json =eval('(' + data + ')');
				if (json.result == "true") {
				//跳转
				//alert(json.inquiryId);
				window.location.href= "<%=path%>/merchant/myInquiry.do?InquiryId="+json.inquiryId;
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
				}
					//alert(data);
			}
			}
		});
		}else{
		 $("#msg").show();
		}
	};
	var AddFavorite = function() {
		$.ajax({
			type : "POST",
			url : "AddFavorite.do",
			dataType : "text",
			data : {
				"productId" : productId,
			},
			success : function(data) {
				//提示问题内容			
				if (data == "true") {
					//跳转
					alert("添加成功");
				window.location.href= "<%=path%>/merchant/myCollection.do";
					} else{
				switch(data)
				{
					case "1":
					alert("请先登录");
					window.location.href= "<%=path%>/web/toLogin.do";
					break;
					case "2":
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
			url : "addShoppingCart.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"buyNum":buyNum,
				"address":address
			},
			success : function(data) {
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
									alert("商品已收藏");
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
	var jsonAddrs =
<%=jsonAddrs%>
	;
</script>
<style>
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
									</h3>
									<div class="item-list clearfix">
										<!-- 弹出层关闭小叉叉<div class="close">x</div> -->
										<div class="subitem">
											<c:forEach items="${proca.productCategorys}" var="pcs">
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
																	<%-- <em>${pc.cateGoryName}:</em> --%>
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
											</c:forEach>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="hot">
				<span class="scan">精品推荐</span> <span class="more">>>更多</span>
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
				主体显示区域
				<c:forEach items="${productCategorys}" var="pros1"
					varStatus="status1">
					<c:if test="${pros1.parentCateGory==null}">
						<div class="storey_box">
							<div class="st_title" style="position: relative;width:80%;">
								<div style="float: left; ">
									<b><span class="n${status1.count}"><img
											src="<%=path%>/images/index/00_${status1.count}.png">
												${status1.count}F/ 
									</span><span class="nn1">${pros1.cateGoryName}</span> </b>
								</div>
								<div class="st_intro">
									<!--  精品推荐：品牌名称 | 品牌名称 -->
									精品推荐：
									<c:set scope="page" var="counter" value="0"></c:set>
									<c:forEach items="${pros1.productCategorys}" var="pcs">

										<c:if test="${pcs.parentCateGory == pros1.id }">
											<c:if test="${ counter > 0}">|</c:if>
											<!-- 调用ajax,实现商品替换	 -->
											<a
												href="toSecondIndex.do?cateGoryId=${pros1.id}&cateGorySunId=${pcs.id}&cateGoryLevel=2">${pcs.cateGoryName}</a>
											<c:set scope="page" var="counter" value="${ counter + 1 }"></c:set>
										</c:if>
									</c:forEach>
								</div>
								
							</div>

							
							<div class="storey">

								<!--中推荐商品展现-->
								<div class="st_2">
									<c:forEach items="${pros1.products}" var="pros2"
										varStatus="status2">
										<div class="grid_1">
											<div class="banner_item">
											<img src="<%=path %>${pros2.filePath }" height="90%" width="90%"/><br/>
										原价：${pros2.unitPrice } |	${pros2.productName }	|${pros2.spotUnitPrice }	
											</div>
											
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>


			</div>
		</div>
	</div>
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
	<!--  <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script> -->
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
	</script>
</body>
</html>
