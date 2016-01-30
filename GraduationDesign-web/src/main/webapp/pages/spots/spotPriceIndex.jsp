<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<link href="<%=path%>/css/specialPublic.css" rel="stylesheet"
	type="text/css" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	$(function(){
	var _index7=0;
	$(".lanren ul li").mouseover(function(){
		_index7=$(this).index();
		$(this).stop().stop().animate({width:525},500).siblings("li").stop().animate({width:91},500);
		$(".imgCen").eq(_index7).css("display","block").siblings(".imgCen").css("display","none");
	});
	});
	/*****************加入现货购物车*********************************/
	var AddShoppingCart = function(id) {
	var address=$("#addressjoin3").val();
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/addShoppingCart.do",
			dataType : "text",
			data : {
				"productId" : id,
				"address":address,
				"productType":2
			},
			success : function(data) {
				//提示问题内容			
				if (data == "true") {
					//跳转
					window.location.href= "<%=path%>/merchant/spotShoppingCar.do";
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
		
	};
	/*************加入收藏*******************/
	var AddFavorite = function(id) {
		var address=$("#addressjoin3").val();
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddFavorite.do",
			dataType : "text",
			data : {
				"productId" : id,
				"address":address,
				"favoriteType":2,//2代表现货商品收藏
			},
			success : function(data) {
				//提示问题内容			
				if (data == "true") {
					//跳转
					alert("添加成功");
				window.location.href= "<%=path%>/merchant/myCollection.do?favoriteType=2";
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
	
	function toSecond(cateGoryId){
		location.href="<%=path%>/web/toSpotSecondIndex.do?cateGoryId="+cateGoryId;
	}
</script>
<style type="text/css">
.questionBank {
	line-height: 25px;
	background: transparent;
	border-style: none;
	resize: none;
	overflow-x: hidden;
	overflow-y: hidden;
	font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, "宋体";
	white-space: nowrap;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
}
</style>
</head>
<body>
	<!--  轮播 -->
	<div
		style="width: 100%; height: 497px; background: url(/ssm/images/spots/xianhuo_02.jpg); background-size: cover;">
		<div style="width: 1128px; height: 100%; margin: 0 auto;">
			<img style="width: 100%; height: 100%"
				src="<%=path%>/images/spots/xianhuo_04.png">
		</div>
	</div>
	<%-- <div class="banner" >
			<img src="<%=path%>/images/spots/xianhuo_03.jpg">
	</div> --%>


	<!-----------------------------------这里是一楼-------------------------------------------------------------------->
	<c:forEach items="${productCategorys}" var="pros1" varStatus="status1">
		<c:if test="${pros1.parentCateGory==null}">
			<div class="special_top">
				<div class="special_div_White">
					<div class="special_div_Content" style="padding-top: 102px;">
						<div>
							<span
								style="width: 189px; float: left; margin: 11px 37px 0 284px;"><hr
									width="189px" size="2px" color="#999999" /></span> <span
								style="width: 108px; float: left"><img
								src="<%=path%>/images/spots/xh_${status1.count}_1.png" /></span> <span
								style="width: 189px; float: left; margin: 11px 0 0 37px;"><hr
									width="189px" size="2px" color="#999999" /></span>
						</div>
						<br />
						<div
							style="padding-left: 512px; margin-top: 15px; height: 36px; width: 1128px;">
							<input class="button_gd" type="button"
								onclick="toSecond(${pros1.id});" />
						</div>
						<div class="special_div_Commodity">
							<div class="special_div_profile" style="float: left;">
								<p style="font-size: 24px; color: #5e5e5e; margin-bottom: 15px;">${pros1.soptProducts[0].productName}</p>
								<p
									style="border-bottom: 1px dashed #b7b7b7; font-size: 16px; color: #757575; height: 30px; line-height: 30px;">
									<span style="float: left; width: 20px;">￥</span> <span
										style="float: left;">价格：${pros1.soptProducts[0].unitPrice}</span>
									<span style="float: right;">规格：${pros1.soptProducts[0].productModel}</span>
								</p>
								<p
									style="border-bottom: 1px dashed #b7b7b7; margin-bottom: 30px; height: 30px; font-size: 16px; color: #757575; line-height: 30px;">
									<span style="float: left; margin-top: 10px; width: 20px;"><img
										src="<%=path%>/images/spots/icon_42.png" /></span> <span
										style="float: left;">产地：${pros1.soptProducts[0].OriginPlace}</span>
									<span style="float: right;">品牌：${pros1.soptProducts[0].BrandName}</span>
								</p>
								<textarea class="questionBank"
									style="width: 320px; height: 100px; font-size: 13px; color: #525252;"
									name="questionBank.name" id="questionBankName"
									disabled="disabled">
&nbsp;&nbsp;${pros1.soptProducts[0].ProductDescription}
                        </textarea>
							</div>
							<!---------------------百叶切换---------------------------------->
							<div class="lanren" style="float: right;">
								<ul>
									<li class="first">
										<div class="imgTop">
											<img src="<%=path%>/images/spots/${status1.count}1_53.jpg"
												width="525" height="300" />
										</div>
									</li>
									<li>
										<div class="imgTop">
											<img src="<%=path%>/images/spots/${status1.count}2_53.jpg"
												width="525" height="300" />
										</div>
									</li>
									<li>
										<div class="imgTop">
											<img src="<%=path%>/images/spots/${status1.count}3_53.jpg"
												width="525" height="300" />
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="special_div_Grey">
					<div class="special_div_Content"
						style="padding-top: 15px; width: 1148px;">
						<!----------------------------这里循环读数据！！！-------------------------------------------------------->
						<div class="st_2_${status1.count}">
							<c:forEach items="${pros1.soptProducts}" var="pros2"
								varStatus="status2">
								<div class="special_div_Details">
									<div style="height: 295px;">
										<div>
											<img style="width: 268px; height: 242px;"
												src="<%=path%>${pros2.filePath}" />
										</div>
										<div style="margin-top: -46px; padding-left: 86px;">
											<img style="width: 93px; height: 93px;"
												src="${pros2.logoPath}" />
										</div>
									</div>
									<p>
										<span
											style="font-size: 10px; color: red; float: left; margin-top: 15px;">￥</span>
										<span style="font-size: 25px; color: red; float: left;">${pros2.unitPrice}</span>
										<span
											style="font-size: 12px; color: #686868; float: right; margin-top: 10px;">${pros2.productModel}</span>
									</p>
									<textarea class="questionBank"
										style="width: 260px; height: 60px; font-size: 14px; color: #323232;"
										name="special.name" id="specialName" disabled="disabled">
${pros2.productTitle}
                     </textarea>
									<a href="javascript:AddShoppingCart('${pros2.id}');"><input
										class="button_gwc" type="button" /></a> <a
										href="javascript:AddFavorite('${pros2.id}');"><input
										class="button_scj" type="button" /></a>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</c:forEach>
</body>
</html>