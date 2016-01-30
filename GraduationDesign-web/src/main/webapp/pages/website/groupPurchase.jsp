<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

<link href="<%=path%>/css/public.css" rel="stylesheet" type="text/css"
	media="all" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/jquery.countdownTimer.js"></script>
<script type="text/javascript">
function forGroup(cateGorySunId,index) {
	var i=1;
		
		$.ajax({
					dataType : "text",
					async : false,
					type : "POST",
					url : "toGroupPurchase1.do",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					data : {
						"i" : i
					},
					success : function(data) {
						i++;
						alert(i);
						if (data == "false") {
							alert("加载失败！");
						} else {
										var divPic = "";
							var json = eval('(' + data + ')');
							alert(json);
							 for ( var i = 0; i < json.length; i++) {
												 divPic+= "<div class='grid_1'><div class='banner_item'><div class='banner_item_bg'></div>"
										+ "<div class='banner_item_info'><a href='toProductInfo.do?ProductId="
										+ json[i].id
										+ "'>"
										+ json[i].productName
										+ "</a></div>"
										+ "<ul class='gr_j'"
											+	" style='position: absolute;left: 0px;top: 0px;'>"
										+ "<li class='j_1'><a	href='toProductInfo.do?ProductId="
										+ json[i].id
										+ "' style='height: 196px;'><img src='<%=path%>"
										+ json[i].filePath
										+ "' /> </a></li></ul>"
										+ "<div class='banner_item_price'>"
										+ "<a href='toProductInfo.do?ProductId="
										+ json[i].id
										+ "'></a>"
										+ "</div></div></div>";

								;
							}
							if (divPic != "") {
								$(".st_2_" + index).html(divPic);
							}

						}
					},
					error : function(e) {
						alert("失败");
					}
				});
	}

	//倒计时的js函数
	function countTimer(id, ValidityTime) {
		var time = ValidityTime.replace(/-/g, '/');//时间格式转换为yyyy/mm/dd hh:tt:ss
		$("#future_date_" + id)
				.countdowntimer(
						{
							dateAndTime : time,
							regexpMatchFormat : "([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})",
							regexpReplaceWith : "$1<sup class='displayformat'>天</sup>$2<sup class='displayformat'>时</sup>$3<sup class='displayformat'>分</sup>$4<sup class='displayformat'>秒</sup>"
						});
	};
</script>
</head>
<body>
	<div class="div_top" style="background-color: #FFED29">
		<div class="gp_head logo">
			<div style="width: 100%; height: 577px;">
				<img src="" />
			</div>
			<div style="width: 1050px; height: 290px; margin: -50px 0 0 200px;">
				<c:forEach items="${productlist1 }" var="p2">

					<c:forEach items="${p2 }" varStatus="status" var="p1">
						<c:if test="${status.index%2==0 }">
							<div class="div_head"
								style="margin-top:74px; background-image:url(<%=path %>${p1.filePath })">
								<span class="span_1">￥${p1.GrouponPrice }</span> <span
									class="span_2">原价${p1.UnitPrice }</span>
							</div>
						</c:if>
					</c:forEach>

				</c:forEach>
			</div>
		</div>
	</div>
	<div class="div_top" style="background-color: #5CC5FF">
		<div id="id_toplist" class="gp_toplist top">
			<c:forEach items="${productlist1 }" var="p2">

				<c:forEach items="${p2 }" varStatus="status" var="p1">
					<c:if test="${status.index%2==1 }">
						<div class="div_toplist" style="background-color: #FFF;">
							<img src="<%=path %>${p1.filePath }" />
							<table>
								<tr>
									<td class="td_list1" colspan="3"><b>${p1.ProductName }</b>
									</td>
								</tr>
								<tr>
									<td class="td_list2" colspan="3">餐饮专用 健康安全 成交10000桶团购即成立</td>
								</tr>
								<tr>
									<td class="td_list3">原价￥${p1.UnitPrice }</td>
									<td class="td_list4" rowspan="2"></td>
									<td class="td_list5" rowspan="3"><a
										href="toGrouponInfo.do?id=${p1.id}&&ProductId=${p1.ProductID}">立即抢购</a>
									</td>
								</tr>
								<tr>
									<td class="td_list6" colspan="2">团购价￥${p1.GrouponPrice }</td>
								</tr>
								<tr>
									<td class="td_list7" colspan="2"><span
										style="width: 65px; float: left; font-size: 18px;">现成<br />交数
									</span> <span class="txt"
										style="color: #C03; width: 149px; float: right; font-size: 34px;">
											<c:if test="${p1.SoldOut==null }">0</c:if> <c:if
												test="${p1.SoldOut!=null }">${p1.SoldOut }</c:if>${p1.ProductUnit
											}</span>
										</span></td>
								</tr>
							</table>
						</div>
					</c:if>
				</c:forEach>

			</c:forEach>
		</div>
	</div>
	<div class="div_top"
		style="background-image:url(<%=path%>/images/bj.jpg); background-size:200px 705px; ">
		<div class="gp_logo logo">
			<span style="float: left; width: 760px; margin-top: 75px;"><img
				src="<%=path%>/images/index_32.png"
				style="width: 760px; height: 250px;" /> </span> <span
				style="float: left; margin-top: 290px"> <span><img
					src="<%=path%>/images/index_31.png"
					style="width: 350px; height: 250px;" /> </span>
				<div
					style="background-image:url(<%=path%>/images/index_33.png); height:107px; margin-top:20px;">
				</div>
			</span>
		</div>
	</div>

	<c:forEach items="${productGroupMap }" var="p4" varStatus="status">
		<div class="div_top${status.index }" style="background-color: #FFD6DC">
			<div id="id_list" class="gp_list top">
				<c:forEach items="${p4.value }" var="p" varStatus="status1">

					<div class="div_list" style="background-color: #FFF;">
						<img src="<%=path %>${p.filePath }" />距离结束还有:<span
							id="future_date_${p.id}" style="display: inline"></span>
						<table>
							<tr>
								<td colspan="2"><b>${p.ProductName }</b></td>
								<td id="1span${p.id}"
									style="width: 90px; background-color: #DD5C78; text-align: center; vertical-align: middle; color: #DD5C78"
									rowspan="3"><a
									href="toGrouponInfo.do?id=${p.id}&&ProductId=${p.ProductID}">立即抢购</a>
								</td>
								<td id="2span${p.id}"
									style="display: none; width: 90px; background-color: #DD5C78; text-align: center; vertical-align: middle;"
									rowspan="3"><span color="#000">抢光了</span></td>
							</tr>
							<tr>
								<td style="height: 20px; font-size: 14px; color: #B71F1B"
									colspan="2">餐饮专用 健康安全</td>
							</tr>
							<tr>
								<td style="height: 20px; font-size: 14px; color: #B71F1B"
									colspan="2">成交10000桶团购即成立</td>
							</tr>
							<tr>
								<td class="td_list3">原价￥${p.UnitPrice }</td>
								<td style="width: 80px; color: #AF0415" rowspan="1"></td>

							</tr>
							<tr>
								<td class="td_list6" colspan="2">团购价￥${p.GrouponPrice }</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="2"><span
									style="width: 212px; height: 50px; border: 1px solid #F00;">
										<span style="width: 63px; float: left; font-size: 18px;">现成<br />交数
									</span> <span class="txt"
										style="color: #C03; width: 149px; float: right; font-size: 34px;">
											<c:if test="${p.SoldOut==null }">0</c:if> <c:if
												test="${p.SoldOut!=null }">${p.SoldOut }</c:if>${p.ProductUnit
											}</span>
								</span></td>

							</tr>
						</table>

						<script type="text/javascript">
							$(document).ready(
									function() {
										countTimer('${p.id}',
												'${p.ValidityTime}');

										if ($("#future_date_${p.id}").text()
												.trim() == "00天00时00分00秒") {
											$("#2span${p.id}").show();
											$("#1span${p.id}").hide();
										}
									});
						</script>
					</div>


				</c:forEach>
			</div>
		</div>
	</c:forEach>



	<div class="div_top" style="background-color: #FFF2CD">
		<div id="id_list" class="gp_list top"></div>

	</div>



</body>
</html>