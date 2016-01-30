<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="<%=path%>/css/redcss/style.css" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/css/redcss/public.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/nav.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/5icool.org.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/script.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.masonry.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.easing.1.3.js"></script>

<script type="text/javascript">
	$(function() {
		$('#ul2').css({
			display : 'none'
		});
	});

	$(function() {
		$(".left_nav dd").hover(function() {
			$(".nav_right", this).show();
		});
		$(".left_nav dd").mouseleave(function() {
			$(".nav_right", this).hide();
		});
	});
	function viewMorwInfo() {
		if ($('#ul1').css("display") == "none") {
			type = 2;
		} else {
			type = 1;
		}
		;
		location.href = "newOrNoiceMore.do?type=" + type;
	}
	$(function() {
		$(".left_nav dd").hover(function() {
			$(".nav_right", this).show();
		});
		$(".left_nav dd").mouseleave(function() {
			$(".nav_right", this).hide();
		});
	});

	/* $(function() {
		$(".gr_d").hover(function() {
			x = $(".gr_d").index(this);
			$(".gr_d").eq(x).animate({
				left : -10
			}, 500);
		}, function() {
			$(".gr_d").eq(x).animate({
				left : 0
			}, 500);
		});
	});
	$(function() {
		$(".grid_2").hover(function() {
			x = $(".grid_2").index(this);
			$(".grid_2").eq(x).animate({
				left : -8
			}, 500);
		}, function() {
			$(".grid_2").eq(x).animate({
				left : 0
			}, 500);
		});
	});

	$(function() {
		//点击左右按钮切换图片
		//点左按钮向左走
		var n = 0;
		$(".ro_btn_1").click(function() {
			if (n < 5) { //有多少图片就填多少数值
				n = n + 1;
			} else {
				n = 5;
			}
			$(".roll_d").animate({
				top : -39 * n
			}, 500);//图片框
		});
		$(".ro_btn_2").click(function() {
			if (n > 0) {
				n = n - 1;
			} else {
				n = 0;
			}
			$(".roll_d").animate({
				top : 0 * n
			}, 500);
		});
	}); */

	$(function() {
		$('.tab ul.menu li').click(function() {
			//获得当前被点击的元素索引值
			var Index = $(this).index();
			//给菜单添加选择样式
			$(this).addClass('active').siblings().removeClass('active');
			//显示对应的div
			$('.tab').children('div').eq(Index).show().siblings('div').hide();

		});
	});
	function findProduct(cateGorySunId,index) {
	
		/* alert("p"); */
		$.ajax({
					dataType : "text",
					async : false,
					type : "POST",
					url : "findProductCategory.do",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					data : {
						cateGorySunId : cateGorySunId
					},
					success : function(data) {
						if (data != "false") {
							/* var json = eval(data);
							alert(json); */
							var divPic = "";
							var json = eval('(' + data + ')');
							for ( var i = 0; i < json.length; i++) {
								

								//var json = eval('(' + data + ')');
							
								//alert(json[i].id+"--"+json[i].productName +"--"+json[i].filePath );
								 divPic+= "<div class='grid_1'><div class='banner_item'><ul class='gr_j' style='position: absolute;left: 0px;top: 0px;'>"
								 +"<li class='j_1'><a href='toProductInfo.do?ProductId="+json[i].id+"' style='height: 196px;'><img src='<%=path%>"
								 	+json[i].filePath 
								 	+"' /> </a></li>"
								 	+"<li><div style='text-align: center;'>"
										+"<p style='font-size: 13px;'><a href='toProductInfo.do?ProductId='"+json[i].id+"'>"+json[i].productName+"</a></p>"
											+"	<p  class ='yangs'>"+json[i].productTitle+"</p>"
										+"	</div> </li> </ul> </div> </div> ";
								
							}
							if (divPic != "") {
								$(".st_2_" + index).html(divPic);
							}
						}
					},
					error : function(e) {
						//alert("失败");
					}
				});
		//alert("cateGoryId:"+cateGoryId+"cateGorySunId:"+cateGorySunId+"cateGoryLevel:"+cateGoryLevel);

	}
	function fun(id) {
		$("#banner_item_bg" + id).css("opacity", "0.4");//alert($("#banner_item_price" + id).html());
		$("#banner_item_price" + id).css({"display": "block","position": "absolute"});
	};
	function funo(id) {
		$("#banner_item_bg" + id).css("opacity", "0.3");//alert($("#banner_item_price" + id).html());
		$("#banner_item_price" + id).css("display", "none");
	};
	function changeColor(){
	$("#color").css("color","blue");
	}
	function changeColors(){
	$("#color").css("color","#55546C");
	}
</script>
<!-----------------------------询价按钮和数量选择框------- <style type="text/css">
.input_but_sx{
	padding:0;
	width:8px;
	height:8px;
	font-size:6px;
	border:none;
	background-color:#fff;
	color:#666;
}
.input_txt_sx{
	width:60px;
	border:none;
	padding-left: 5px;
}
.div_anniu td{
	border:1px solid #D1D1D1;
	
}
#anniu{
	height:20px;
	width:55px;
	font-size:12px;
	border-radius: 0px;
}
.div_anniu{
	margin:5px 0 0 13px;
	float:left;
}
</style>
<script type="text/javascript">
        function doit(para){ 
        
    var num =parseInt( $("#inp").val());
    if(num >0){
    inp.value = num + para;
    }else{
    	if(num==0&para==1){
        	inp.value = num + 1;
        }
    }
}
</script> -->
<style type="text/css">
p {
	font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, "宋体";
}

.yangs {
	text-align: center;
	font-size: 12px;
	color: #a4a1a1;
	white-space: nowrap;
	width: 160px;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
}
</style>
</head>

<body>

	<!--  轮播 -->
	<div class="banner">
		<a href="#"><div
				style="background-size:100% 100%; background-image: url(<%=path%>/images/index/banner01.jpg);">
				<img src="<%=path%>/images/index/banner01_1.png">
			</div></a> <a href="#"><div
				style="background-size:100% 100%; background-image: url(<%=path%>/images/index/banner02.jpg);">
				<img src="<%=path%>/images/index/banner02_2.png">
			</div></a>
		<ul class="ba_1">
			<li class="ba_2"></li>
			<li class="ba_2"></li>
		</ul>
	</div>

	<div class="warp">
		<div class="banner_box">
			<!--左导航-->
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
										<%-- 	<c:forEach items="${productCategorys}" var="pcs">
											<c:if test="${pcs.parentCateGory == proca.id }">
												<dl class="fore1">
													<dt>
														<a
															href="toSecondIndex.do?cateGoryId=${proca.id}&cateGorySunId=${pcs.id}&cateGoryLevel=2">${pcs.cateGoryName}</a>
													</dt>
													<c:forEach items="${productCategorys}" var="pc">
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

		<!-- 一起大牌 -->
		<div class="div_hot">
			<div class="div_title_hot" style="font-style: 微软雅黑；">热门品牌</div>
			<div class="div_hot_con">

				<div class="div_hot_img">
					<img style="margin-top: 3px;"
						src="<%=path%>/images/index/gystpq.jpg">
					<%-- <ul class="iw_thumbs" id="iw_thumbs">
					      	<li><a href="#"><img src="<%=path%>/images/redimg/1.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/2.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/3.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/4.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/5.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/6.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/7.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/1.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/2.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/3.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/4.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/5.jpg"></a></li>
							<li><a href="#"><img src="<%=path%>/images/redimg/6.jpg"></a></li>	
					     </ul> --%>
					<div style="clear: both;"></div>
				</div>
				<script type="text/javascript">
					$(function() {
						$('#iw_thumbs').masonry({
							itemSelector : '.post',
							columnWidth : 70
						});
					});
				</script>

				<div class="div_hot_board">
					<div style="line-height: 30px;">
						<div id="new1"
							style="float: left; width: 96px; text-align: center;"
							onmouseover="$('#new2').attr('class','hovered');$(this).attr('class','');$('.div_board_a').show();$('.div_board_b').hide();">商城公告</div>
						<div id="new2"
							style="float: left; width: 100px; text-align: center;"
							class="hovered"
							onmouseover="$('#new1').attr('class','hovered');$(this).attr('class','');$('.div_board_a').hide();$('.div_board_b').show();">最新活动</div>
					</div>
					<div>
						<div class="div_board_a">
							<ul>
								<c:forEach items="${listNews}" var="list">
									<li><a
										href="newOrNoiceInfo.do?newOrNoticeId=${list.id}&&type=1">${list.title}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						<div class="div_board_b" style="display: none;">
							<ul>
								<c:forEach items="${listNotices}" var="list">
									<li><a
										href="newOrNoiceInfo.do?newOrNoticeId=${list.id}&&type=2">${list.title}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						<div style="height: 20px; padding: 10px 5px 0 120px;">
							<a href="<%=path%>/web/newsLists.do" style="color: #55546C;"
								id="color" onmouseover="changeColor()"
								onmouseout="changeColors()">更多资讯>></a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<c:forEach items="${productCategorys}" var="pros1" varStatus="status1">
			<c:if test="${pros1.parentCateGory==null}">
				<div class="storey_box">
					<div class="st_title" style="position: relative;">
						<div style="float: left;">
							<b><span class="n${status1.count}"><img
									src="<%=path%>/images/index/00_${status1.count}.png">
									${status1.count}F/</span><span class="nn1">${pros1.cateGoryName}</span>
							</b>
						</div>
						<div class="st_intro">
							<!--  精品推荐：品牌名称 | 品牌名称 -->
							精品推荐：
							<c:set scope="page" var="counter" value="0"></c:set>
							<c:forEach items="${sunProductCategorys}" var="pcs">

								<c:if test="${pcs.parentCateGory == pros1.id }">
									<c:if test="${ counter > 0}">|</c:if>
									<!-- 调用ajax,实现商品替换     toSecondIndex.do?cateGoryId=${pros1.id}&cateGorySunId=${pcs.id}&cateGoryLevel=2-->
									<a href="javascript:void(0);"
										onmouseover="findProduct('${pcs.id}','${status1.count}')">${pcs.cateGoryName}</a>
									<c:set scope="page" var="counter" value="${ counter + 1 }"></c:set>
								</c:if>
							</c:forEach>
						</div>
						<div style="clear: both;"></div>
					</div>
					<%-- 
					<div class="st_title">
					   <B>
						<span class="n${status1.count}"><img src="<%=path%>/images/index/00_${status1.count}.png"> ${status1.count}F/</span><span class="nn1">${pros1.cateGoryName}</span> 
						</B>
						<!--广告上方链接 
						<div></div><ul>
								<c:forEach items="${productCategorys}" var="pcs">
									<c:if test="${pcs.parentCateGory == pros1.id }">
										<li><a
											href="toSecondIndex.do?cateGoryId=${pros1.id}&cateGorySunId=${pcs.id}&cateGoryLevel=2">${pcs.cateGoryName}</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
							</div>-->
					</div>
					--%>
					<div style="width: 200px; text-align: center;">
						<img src="<%=path%>/images/index/${status1.count}f.png">
					</div>
					<div
						style="background-image:url(<%=path%>/images/index/${status1.count}f.gif); height: 3px;"></div>
					<div class="storey">
						<!--左-->
						<div class="st_1 st_1_${status1.count}">

							<%--  
							  <a href="#"><img title="图片广告"src="<%=path%>/images/redimg/st_03_${status1.count}.png"></a> 
							--%>
							<ul class="ul_maq_imgs">
								<li><a href="#"><img title="图片广告"
										src="<%=path%>/images/redimg/st_${status1.count}_1.png">
								</a></li>
								<li><a href="#"><img title="图片广告"
										src="<%=path%>/images/redimg/st_${status1.count}_2.png">
								</a></li>
								<li><a href="#"><img title="图片广告"
										src="<%=path%>/images/redimg/st_${status1.count}_3.png">
								</a></li>
							</ul>

						</div>
						<!--中推荐商品展现-->
						<div class="st_2_${status1.count}"
							style="float: right; width: 880px; overflow: hidden;">
							<c:forEach items="${pros1.products}" var="pros2"
								varStatus="status2">
								<div class="grid_1">
									<div class="banner_item">
										<%--原先的商品名称和半透明灰色层 <div class="banner_item_bg"></div>
										<div class="banner_item_info">
											<a href="toProductInfo.do?ProductId=${pros2.id}">${pros2.productName}
											</a>
										</div> --%>
										<ul class="gr_j"
											style="position: absolute; left: 0px; top: 0px;">
											<li class="j_1"><a
												href="toProductInfo.do?ProductId=${pros2.id}"
												style="height: 196px;"><img
													src="<%=path%>${pros2.filePath}" /> </a></li>
											<%-- 	
										<li class="j_2"><a
											href="toProductInfo.do?ProductId=${pros2.id}">${pros2.productName}</a>
										</li>
										<li class="j_3"><a
											href="toProductInfo.do?ProductId=${pros2.id}">询价</a>
										</li>  --%>
											<li>
												<div style="text-align: center;">
													<p style="font-size: 13px;">
														<a href="toProductInfo.do?ProductId=${pros2.id}">${pros2.productName}</a>
													</p>
													<p class="yangs">${pros2.productTitle}</p>
												</div> <!-- <div class="banner_item_xunj">
												 <div class="div_anniu">
							                        <table cellpadding=0 cellspacing=0>
							                          <tr>
							                            <td rowspan="2"><input class="input_txt_sx" type="text" id="inp" value="0"></td>
							                            <td><input class="input_but_sx" type="button" value="▲" onclick="doit(1)"/></td>
							                          </tr>
							                          <tr>
							                            <td><input class="input_but_sx" type="button" value="▼" onclick="doit(-1)"/></td>
							                          </tr>
							                       </table>
							                    </div>
							                    <div class="div_anniu"><input id="anniu" class="orange" type="button" value="询价"/></div>
											</div> -->
											</li>
										</ul>
										<%-- <div class="banner_item_price">
											<a href="toProductInfo.do?ProductId=${pros2.id}"></a>
										</div> --%>

									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<!--右-->

				<!--右边-->
			</c:if>
		</c:forEach>
	</div>
	<script type="text/javascript">
		// 添加轮播;
		var bgimgs = [ 'banner01.jpg', 'banner02.jpg' ];
		var t = n = 0, count = bgimgs.length;
		function showAuto() {
			n = n >= (count - 1) ? 0 : ++n;
			$("#banner li").eq(n).trigger('click');
		}
		window.onload = function() {
			// $('.banner_container')
			count = $("#banner_list a").length;
			$("#banner_list a:not(:first-child)").hide();
			$("#banner_info").html(
					$("#banner_list a:first-child").find("img").attr('alt'));
			$("#banner_info").click(
					function() {
						window.open($("#banner_list a:first-child")
								.attr('href'), "_blank")
					});
			$("#banner li")
					.click(
							function() {
								var i = $(this).text() - 1;//获取Li元素内的值，即1，2，3，4
								n = i;
								if (i >= count)
									return;
								$("#banner_info").html(
										$("#banner_list a").eq(i).find("img")
												.attr('alt'));
								$("#banner_info").unbind().click(
										function() {
											window.open($("#banner_list a").eq(
													i).attr('href'), "_blank")
										})
								$("#banner_list a").filter(":visible").fadeOut(
										500).parent().children().eq(i).fadeIn(
										1000);
								document.getElementById("banner").style.background = "";
								$(this).toggleClass("on");
								$(this).siblings().removeAttr("class");
							});
			t = setInterval("showAuto()", 4000);
			$("#banner").hover(function() {
				clearInterval(t)
			}, function() {
				t = setInterval("showAuto()", 4000);
			});

			// 添加 tips 显示/隐藏
		/* 	$('.grid_1 .banner_item').hover(function() {
				// hover
				$(this).find('.banner_item_shangp').hide();
				$(this).find('.banner_item_xunj').show();
				$(this).find(".banner_item_bg").animate({
					filter : 'Alpha(Opacity=40)',
					opacity : '0.4'
				}, 200);
				
			}, function() {
				// out
				$(this).find('.banner_item_shangp').show();
				$(this).find('.banner_item_xunj').hide();
				$(this).find(".banner_item_bg").animate({
					filter : 'Alpha(Opacity=30)',
					opacity : '0.3'
				}, 200);
			}); */

		} // end

		$(".all-sort-list > .item").hover(
				function() {
					// 对 em 进行 margin 操作; 

					$(this).find(".nav_left_con").find("em").animate({
						margin : '-60px 10px 0 -30px'
					}, 238);

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
					//alert(tmpitemlist);
					//$(this).children('.item-list').html(tmpitemlist);
					$(this).addClass('hover');
					$(this).children('.item-list').css('display', 'block');

				}, function() {
					// 对 em 进行 margin 操作; 
					$(this).find(".nav_left_con").find("em").animate({
						margin : '0px 10px 0px -30px'
					}, 238);

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

		// 实现楼层中间区域图片轮播
		function maqfloor(objs, isauto) {
			var o = {
				i : 0,
				speed : 300,
				auto : true, // 是否自动轮播
				init : function() { // jquey objects,
					this.li = objs;
					this.n = this.li.length - 1;
					this.auto = !!(isauto == undefined ? this.auto : isauto);

					this.li.not(":first").css({
						left : "238px"
					});
					this.li.eq(this.n).css({
						left : "-238px"
					});

					if (this.auto) {
						this.lxfNext();
					}
					return this;
				},
				lxfNext : function() {

					if (!this.li.is(":animated")) {

						if (this.i >= this.n) {
							this.i = 0;
							this.li.eq(this.n).animate({
								left : "-238px"
							}, this.speed);
							this.li.eq(this.i).animate({
								left : "0px"
							}, this.speed);
						} else {
							this.i = this.i + 1;
							this.li.eq(this.i - 1).animate({
								left : "-238px"
							}, this.speed);
							this.li.eq(this.i).animate({
								left : "0px"
							}, this.speed);
						}
						;

						this.li.not(this.li.eq(this.i)).css({
							left : "238px"
						});
					}

					var self = this;
					this.t = setTimeout(function() {
						self.lxfNext(); // 设置自动轮播
					}, this.speed * 10);
				},
				stop : function() {
					clearInterval(this.t);
				},
				lxfLast : function() {
					if (!this.li.is(":animated")) {
						if (this.i <= 0) {
							this.i = this.n;
							this.li.eq(0).animate({
								left : "238px"
							}, this.speed);
							this.li.eq(this.n).animate({
								left : "0px"
							}, this.speed);
						} else {
							this.i = this.i - 1;
							this.li.eq(this.i + 1).animate({
								left : "238px"
							}, this.speed);
							this.li.eq(this.i).animate({
								left : "0px"
							}, this.speed);
						}

						this.li.not(this.li.eq(this.i)).css({
							left : "-238px"
						});
						// this.li.not("eq(i)").css({left:"-200px"});  
					}
					;
				}
			};

			// 自动初始化;
			o.init();
			return o;
		}

		// 1. 自动播放；  2. 随时停止；
		$(".st_1 .ul_maq_imgs").each(function() {
			// var self = $(this);
			var imgs = $(this).find("li");
			var mf = maqfloor(imgs); // $(this).find("li") 

			//鼠标在图片上悬停让切换暂停 
			imgs.hover(function() {
				mf.stop();
			});

			//鼠标离开图片切换继续
			imgs.mouseleave(function() {
				mf.lxfNext();
			});
		});
	</script>
</body>