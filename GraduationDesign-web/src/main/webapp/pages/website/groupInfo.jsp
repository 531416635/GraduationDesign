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
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/redcss/address.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector.css" />
<link href="<%=path%>/css/redcss/style.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />

<script type="text/javascript" src="<%=path%>/js/redjs/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/jquery.countdownTimer.js"></script>
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
	
	
	
	
	
	var AddGrouponSheet = function() {
	var buyNum=$("#buyNum").val();
	var GrouponPrice=$("#GrouponPrice").text().trim();
	var id=$("#groupID").val();
	address=$("#addressjoin").val();
		if(buyNum!=""&&buyNum!="0"){
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddGrouponSheet.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"buyNum":buyNum,
				"address":address,
				"GrouponPrice":GrouponPrice,
				"groupID":id
			},
			success : function(data) {		
				var json =eval('(' + data + ')');
				//alert(data);
				if (json.result == "true") {
				//跳转
				//alert(json.inquiryId);
			   if(json.orderId=='null')
				{
					alert("暂时不能询价，请联系管理员");
				   // window.location.href= "<%=path%>/web/toLogin.do";			
				}		
				else	if(json.orderId!=null && json.orderId!='')
				{
				
			window.location.href= "<%=path%>/web/toGrouponPay.do?id="+json.orderId;
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
									javascript: history.go(-1);
									break;
								case "5":
								alert("对不起，你没有操作权限，请与管理员联系");
								break;
								}
							}
						},
						error : function(e) {
							alert(e);
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
	
	//倒计时的js函数
	function countTimer(id, ValidityTime) {
		var time = ValidityTime.replace(/-/g, '/');//时间格式转换为yyyy/mm/dd hh:tt:ss
		$("#future_date_" + id)
				.countdowntimer(
						{
							dateAndTime : time,
							regexpMatchFormat : "([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})",
							regexpReplaceWith : "$1<sup>&nbsp;天</sup>&nbsp;$2<sup>&nbsp;时</sup>&nbsp;$3<sup>&nbsp;分</sup>&nbsp;$4<sup>&nbsp;秒</sup>"
						});
	};
	
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
</script>
</head>
<body>
	<input type="hidden" id="provinceName"
		value="${sessionScope.province.dicName }" />
	<input type="hidden" id="provinceId"
		value="${sessionScope.province.id }" />
	<input type="hidden" id="cityName"
		value="${sessionScope.city.dicName }" />
	<input type="hidden" id="cityId" value="${sessionScope.city.id }" />
	<input type="hidden" id="areaName"
		value="${sessionScope.area.dicName }" />
	<input type="hidden" id="areaId" value="${sessionScope.area.id }" />
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
											value="${proca.id}" />
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
				<span class="scan">精品推荐</span>
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
							<c:forEach items="${product.productPics}" var="p3"
								varStatus="status">
								<a href='#' class='cloud-zoom-gallery' title='Red'
									rel="useZoom: 'zoom1', smallImage: '<%=path%>${p3.filePath}' ">
									<img id="img${status.count}" src="<%=path%>${p3.filePath}"
									alt="Thumbnail 1" width="46" height="44"
									class="zoom-tiny-image" />
								</a>
							</c:forEach>
						</p>

					</div>

				</div>
				<c:forEach items="${groupList }" var="g">
					<div class="zo_right">
						<div class="text_div">
							<input type="hidden" id="groupID" value="${g.id}" />
							<dl>
								<dt>${g.ProductName}</dt>
								<dt style="background-color: #eee">
									团购价：￥<span id="GrouponPrice">${g.GrouponPrice}</span>
									<table style="float: right; border-collapse: collapse;">
										<tr>
											<td
												style="border-right: 2px solid #ccc; width: 60px; text-align: center">${g.Discount}折</td>
											<td style="width: 60px; text-align: center"><span
												style="text-decoration: line-through; font-size: 0.7em;">￥${g.UnitPrice}</span>
											</td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #ccc; text-align: center">折扣</td>
											<td style="text-align: center">价值</td>
										</tr>
									</table>
								</dt>
								<dt
									style="background:url(<%=path%>/images/btn_03.png) no-repeat left;height:1.5em;">
									<span id="future_date_${g.id}"
										style="display: inline; margin-left: 28%;"></span>
									<script type="text/javascript">
							$(document).ready(function() {
								countTimer('${g.id}', '${g.ValidityTime}');
							});
						</script>
								</dt>

								<dt style="height: 50px;">
									<span style="width: 50px;">已售<c:if
											test="${g.SoldOut==null}">0</c:if> <c:if
											test="${g.SoldOut!=null}">${g.SoldOut }</c:if>
										${g.ProductUnit}
									</span>|<span style="width: 50px;">剩余&nbsp;${g.ProductUnit}</span>|<span
										style="width: 50px;">评价</span>
								</dt>
							</dl>


						</div>

						<div class="shop">
							<div class="shop_box">
								<span id="msg" style="color: red; display: none;">*请先填写数量与地址*</span><br />
								<div class="buy">

									<span>购买数量：</span> <input type="button" id="jian" value="-"
										onclick="subNum()" /> <input type="text" id="buyNum"
										name="buyNum" value="1"
										onkeyup="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
										onafterpaste="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')" /><span
										id="one"></span> <input type="button" id="add" value="+"
										onclick="addNum()" /> <span>${product.productUnit}</span>
								</div>
								<div>
									<ul id="list1" style="width: 620px; margin: 40px auto 0 auto;">
										<li>
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
											</div>
										</li>
										<li id="summary-stock"></li>
									</ul>
								</div>
							</div>
							<div class="prefer_box">
								<a href="javascript:AddGrouponSheet();"
									class="button orange medium action">立即抢购</a>
							</div>
						</div>

					</div>
					<div class="detail_list">购买须知：${g.Remark }</div>
				</c:forEach>
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
		<div class="loadingWord">
			<img src="<%=path%>/images/waiting.gif">加载中，请稍候... 
		</div>
	</div>

	<div style="height: 1200px;"></div>
</body>
</html>




<%-- <c:forEach items="${groupList }" var="g">
						<dl>
							<dt>${g.ProductName}</dt>
							<dt>团购价：￥${g.GrouponPrice} <span style="text-decoration:line-through;font-size:0.7em;">￥${g.UnitPrice}</span></dt>
							<dt>有效期：${g.ValidityTime}</dt>
						</dl>
						</c:forEach> --%>




