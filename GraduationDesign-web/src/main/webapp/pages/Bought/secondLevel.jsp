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
<title>一起采</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/script.js"></script>
<script>
	$(function() {

		$(".case_li").hover(function() {
			$(".case_li_txt", this).stop().animate({
				top : "100px"
			}, {
				queue : false,
				duration : 160
			});
			$(".case_li_txt", this).css("background-color", "#000000");
			$(".case_li_txt .span_mr_txt", this).attr("class", "span_font");
		}, function() {
			$(".case_li_txt", this).stop().animate({
				top : "118px"
			}, {
				queue : false,
				duration : 160
			});
			$(".case_li_txt", this).css("background-color", "#ffffff");
			$(".case_li_txt .span_font", this).attr("class", "span_mr_txt");
		});
		//绑定
		$("#select1 dd").click(function () {	
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) {
			$("#selectA").remove();
		} else {
			var copyThisA = $(this).clone();
			if ($("#selectA").length > 0) {
				$("#selectA a").html($(this).text());
			} else {
				$(".select-result dl").append(copyThisA.attr("id", "selectA"));
			}
		}
	});
	$("#selectA").live("click", function () {
		$(this).remove();
		$("#select1 .select-all").addClass("selected").siblings().removeClass("selected");
	});
	});
	
	function checksBrand() {
		var brandId = $(this).children(":first").text();
		$.ajax({
			type : "POST",
			url : "toSaveArguments.do",
			dataType : "text",
			data : {
				"brandId" : brandId
			},
			success : function(data, textStatus) {
				//提示
				if (data == "true") {
					alert(data);
					$.ajax({
						type : "POST",
						url : "toProductsList.do",
						dataType : "text",
						success : function(data, textStatus) {
							//提示
							alert("fefef");
							alert(data);

							/*  if(data=="true") {
								alert("添加成功！");
							} else {
								alert("添加失败！");
							}  */
						}
					});
				} else {
					alert("添加失败！");
				}
			}
		});
	};
	function checksType() {
		var productTypeId = $(this).children(":first").text();

		$.ajax({
			type : "POST",
			url : "toSaveArguments.do",
			dataType : "json",
			contentType : "application/json",
			data : {
				"productTypeId" : productTypeId
			},
			success : function(data, textStatus) {
				//提示
				if (data == "true") {
					alert("添加成功！");
				} else {
					alert("添加失败！");
				}
			}
		});
	};
	function checksrank() {
		var rank = $(this).children(":first").text();

		$.ajax({
			type : "POST",
			url : "toSaveArguments.do",
			dataType : "text",
			data : {
				"rank" : rank
			},
			success : function(data, textStatus) {
				//提示
				if (data == "true") {
					alert("添加成功！");
				} else {
					alert("添加失败！");
				}
			}
		});
	function change(id){
	
	}
	};
</script>
<style>
#myli1 {
	width: 250px;
	height: 89px;
	border-top: 1px solid #d7d7d7;
	text-align: center;
}
</style>
</head>
<body>
	<div class="warp">
		<div class="detail_left">
			<div class="all-sort-list">
				<c:forEach items="${productCategorys}" var="proca">
					<c:if test="${proca.parentCateGory == cateGoryId }">
						<div class="item bo">
							<h3>
								<a class="nav_left"
									href="toSecondIndex.do?cateGoryId=${cateGoryId}&cateGorySunId=${proca.id}&cateGoryLevel=2">${proca.cateGoryName}</a>
							</h3>
							<div class="item-list clearfix">
								<div class="close">x</div>
								<div class="subitem">
									<c:forEach items="${productCategorys}" var="pcs">
										<c:if test="${pcs.parentCateGory == proca.id}">
											<dl class="fore1">
												<dt>
													<a
														href="toSecondIndex.do?cateGoryId=${cateGoryId}&cateGorySunId=${proca.id}&cateGoryLevel=3">${pcs.cateGoryName}</a>
												</dt>
												<dd>
													<c:forEach items="${productCategorys}" var="pcItem">
														<c:if test="${pcItem.parentCateGory == pcs.id }">
															<em><a
																href="toSecondIndex.do?cateGoryId=${cateGoryId}&cateGorySunId=${proca.id}&cateGoryLevel=4">${pcItem.cateGoryName}</a>
															</em>
														</c:if>
													</c:forEach>
												</dd>
											</dl>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="hot">
				<span class="scan">热销排行</span> <span class="more">>>更多</span>
				<div class="goods_list">
					<c:forEach items="${hotProducts}" var="pros" varStatus="status1">
						<dl>
							<dt>
								<b>${status1.count}</b><b><img
									src="${pros.productPic.filePath}" /> </b>
							</dt>
							<dd>
								${pros.productName}<b>${pros.productName}</b>
							</dd>
						</dl>
					</c:forEach>
				</div>
			</div>
			<%-- <div class="hot">
				<span class="scan">最近浏览</span> <span class="more">>>更多</span>
				<div class="goods_list">
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_1.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_2.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_3.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_4.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_5.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_6.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_7.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_8.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_9.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
					<dl>
						<dt>
							<b><img src="<%=path%>/images/frontimages/goods_10.jpg" /> </b>
						</dt>
						<dd>
							面筋<b>团餐食材,尽在掌握</b>
						</dd>
					</dl>
				</div>
			</div> --%>
		</div>
		<div class="detail_right">
			<div class="loca2">
				<span class="tit2">全部分类 > ${productCategory.cateGoryName}> <strong>${subordinateCateGory.cateGoryName}</strong>
				</span>
			</div>
			<div class="xbt_div">
				<div class="xbt">精品推荐</div>
			</div>

			<!-- 精品推荐列表 -->
			<div class="zzsc">
				<c:forEach items="${subpageShows}" var="pros">
					<div class="case_li">
						<img src="<%=path%>${pros.productPic.filePath}" />
						<div class="case_li_txt">
							<div class="span_mr_txt">${pros.productName}</div>
							<div class="span_detail">
								<a href="#" onfocus="blur"> 询价</a>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>

			<!-- 条件筛选框 -->
			<div class="screen">

				<ul class="select">
					<li class="select-result">
						<h3>${productCategoryType.cateGoryName}-商品筛选</h3>
					</li>
					<li class="select-result">
						<dl>
							<dt>已选条件：</dt>
							<dd class="select-no">暂时没有选择过滤条件</dd>
						</dl>
					</li>
					<li class="select-list"><c:forEach items="${productCategorys}"
							var="proca">
							<c:if test="${proca.parentCateGory == cateGoryId }">
								<div class="item bo">
									<div class="item-list clearfix">
										<div class="subitem">
											<c:forEach items="${productCategorys}" var="pcs">
												<c:if
													test="${pcs.parentCateGory == proca.id and proca.id==cateGorySunId}">
													<dl class="fore1">
														<dt>
															<a href="javascript:change(${pcs.id});">${pcs.cateGoryName}</a>
														</dt>
														<dd>
															<c:forEach items="${productCategorys}" var="pcItem">
																<c:if test="${pcItem.parentCateGory == pcs.id }">
																	<em><a href="javascript:change(${pcItem.id});">${pcItem.cateGoryName}</a>
																	</em>
																</c:if>
															</c:forEach>
														</dd>
													</dl>
												</c:if>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach></li>
					<li class="select-list">
						<dl class="selectss">
							<dt>排序：</dt>
							<dd onclick="checksrank();">
								<span style="display: none">0</span><a href="#">默认</a>
							</dd>
							<dd onclick="checksrank();">
								<span style="display: none">1</span><a href="#">畅销</a>
							</dd>
							<dd onclick="checksrank();">
								<span style="display: none">2</span><a
									href="toSaveArguments.do?rank=2" target="iframe1">最新</a>
							</dd>
						</dl>
					</li>
				</ul>

			</div>
			<!-- 产品列表框 -->
			<div>
				<





				<iframe src="toProductsList.do" name="iframe1" width="100%"
					height="828px"> </iframe>
			</div>






		</div>
	</div>
	<script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
	<script>
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
	<script type="text/javascript">
		$(".all-sort-list > .item").hover(
				function() {
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
