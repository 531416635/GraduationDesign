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
	String json = (String) request.getAttribute("json");
	//String tmpStatus=request.getParameter("status");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />



<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<script type="text/javascript">
		function EidtPriceSheet(status) {
	//ajax存入报价单
		/* var priceSheetID = ${priceSheetId}; */
		var priceSheetID = $("#chkPS").val();
		if(priceSheetID==null || priceSheetID=='')
		{
			alert("请选择需要提交的单据");
			return;
		}
		var fileIds = '';
		$("input[name=priceSheetId]:checked").each(function() {			
				var ids=$(this).val();
				var num = $("#txtBargainPrice"+ids).val();
				if(num == null || num == ""){
					num = $("#jiage").val();	
				}
				fileIds += "{id:"+ids+ ",num:"+num+"},";			
		});
		if(fileIds.length==0)
		{
			alert("请选择");
			return;
		}
		//-------------采购商确认提交按钮点击后自灰
		$("#sub").attr('disabled',"true");
		 $("#sub").css('background-color','#E3E3E3');
		//-------------供应商确认或拒绝议价按钮点击后自灰
		$("#confirm").attr('disabled',"true");
		 $("#confirm").css('background-color','#E3E3E3');
		$("#deny").attr('disabled',"true");
		 $("#deny").css('background-color','#E3E3E3');
		
		fileIds = fileIds.substring(0, fileIds.length - 1);
		fileIds="["+fileIds+"]"; 
		//alert(fileIds);
		$.ajax({
		type : "POST",
		url : "EidtPriceSheet.do",
		dataType : "text",
		data : {
			"priceSheetID" : priceSheetID,
			"bargainPrice":fileIds,
			"status":status
		},
		success : function(data) {
			//提示	
			var json =eval('(' + data + ')');
			if(json.result="true")
			{
				switch(status)
				{
					case 2:
					location.href = "myPriceSheet.do";	
					break;
					case 3:
					case 4:
					location.href = "ProcessBargainPrice.do?ids="+priceSheetID;
					break;
				}							
			}	
			else{
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
						}
					}
				});
	}
	$(function() {
		var flag = false; //标识生成分页时是否生成查询默认页商品
		var json = eval(<%=json%>);
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
				location.href = "toBargaining.do?currentPage="
						+ (page_index + 1);
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
</script>
<style type="text/css">
#img2 {
	margin-left: auto;
	margin-right: auto;
	width: 60%;
	height: 58px;
	border: 1px solid;
	color: #D0D0D0;
	font-size: 20px;
}

.qrtj {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
}

.jjyj {
	height: 25px;
	width: 100px;
	margin-left: 20px;
	font-size: 14px;
	color: white;
}

#p1 {
	margin-top: 2%;
	margin-left: 38%;
}

#t {
	background: #D0D0D0;
}

.tbody1 {
	border: 1px solid #D0D0D0;
}

td {
	height: 30px;
}

/*******/

table {
	font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, "宋体";
	border: 1px solid #f1f1f1;
	width: 100%;
	
}

tr {
	width: 100%;
}

td {
	padding-left: 8px;
}

.span_name {
	color: #000;
	font-size: 12px;
}

.span_value {
	color: #4d4d4d;
	font-size: 12px;
}

.span_red {
	color: #FF5C4D;
	font-size: 12px;
}

.input_text {
	width: 115px;
	height: 20px;
}
/*------------商品状态---------------------------------*/
.span_zt {
	float: right;
	width: 80px;
	height: 24px;
	color: #fff;
	border-radius: 2px;
	font-size: 14px;
	line-height: 24px;
	text-align: center;
	margin: 4px 10px 0 0;
}
/*--------已完成-------------------*/
.zt_ywc {
	background-color: #89C24D;
}
/*--------未完成--------------------*/
.zt_wwc {
	background-color: #FF5C4D;
}
/*--------待处理--------------------*/
.zt_dcl {
	background-color: #FEBF18;
}
</style>
</head>

<body>
	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<c:choose>
				<c:when test="${ status == '0'}">
					<span class="lo1">首页</span> > <span class="lo2">询价管理 ></span>
					<span class="lo2">采购商议价</span>
				</c:when>
				<c:when test="${ status == '2'}">
					<span class="lo1">首页</span> > <span class="lo2">询价管理 ></span>
					<span class="lo2"> 供应商议价处理</span>
				</c:when>
				<c:otherwise>
					<span class="lo1">首页</span> > <span class="lo2">询价管理 ></span>
					<span class="lo2"> 供应商议价单</span>
				</c:otherwise>
			</c:choose>

		</div>
		<c:if test="${!empty list}">
			<div>
				<table width="100%" border="0" cellspacing="0" align="center"
					style="margin-top: 20px;">
					<c:forEach items="${list}" var="c">
						<tbody class="tbody1">
							<tr style="background-color:#FAFAFA;">
								<td colspan="3" style="height:35px; line-height:35px;"><p
										style="margin:0; font-size:14px; color:#2a2a2a;">
										<span style="float:left;">报价单号： ${c.PriceSheetID}</span>
									</p></td>
								<td style="height:35px; line-height:35px;"><jsp:useBean id="date"
											class="java.util.Date" /> <p
										style="margin:0; font-size:14px; color:#2a2a2a;">
										<span style="float:left;">报价时间： 
										<fmt:formatDate
											value="${c.CreateDate}" type="date" dateStyle="long"
											pattern="yyyy-MM-dd hh:mm:ss" var="time" /> <c:out value="${time }" />
										</span>
									</p>
								</td>
								<td><c:choose>
										<c:when test="${c.Status==0}">
											<span class="span_zt zt_dcl" style="padding:2px 5px;">报价</span>
										</c:when>
										<c:when test="${c.Status==1}">
											<span class="span_zt zt_ywc" style="padding:2px 5px;">报价成功</span>
										</c:when>
										<c:when test="${c.Status==2}">
											<span class="span_zt zt_dcl" style="padding:2px 5px;">议价</span>
										</c:when>
										<c:when test="${c.Status==3}">
											<span class="span_zt zt_ywc" style="padding:2px 5px;">议价通过</span>
										</c:when>
										<c:when test="${c.Status==4}">
											<span class="span_zt zt_wwc" style="padding:2px 5px;">议价不通过</span>
										</c:when>
										<c:when test="${c.Status==5}">
											<span class="span_zt zt_wwc" style="padding:2px 5px;">报价失效</span>
										</c:when>
									</c:choose>
								</td>
							</tr>
							<!-- 采购商议价单 -->
							<tr>
								<td rowspan="4" style="text-align:center;"><input
									type="hidden" name="ids" value="${ids}" /> <c:if
										test="${status=='2' ||status=='0'}">
										<input type="radio" id="chkPS" name="priceSheetId"
											value="${c.ID}">
									</c:if>
								</td>
								<td rowspan="4"
									style="height:30px;width:90px;text-align:center;"><c:if
										test="${c.productPic!=null && c.productPic!=''}">
										<div
											style="width:79px; height:64px; padding:1px; border:1px solid #d9d9d9;">
											<img style="width:79px; height:64px;"
												src="<%=path%>${c.productPic}">
										</div>
									</c:if>
								</td>
								<td colspan="2"><span class="span_name">商品名称：</span><span
									class="span_value">${c.ProductName}</span></td>
								<td><c:choose>
										<c:when test="${status=='0'}">
											<span class="span_name">供应商：</span><span
									class="span_value">${c.CompanyName}</span>
									</c:when>
										<c:when test="${status=='2' ||status=='3,4'}">
											<span class="span_name">采购商：</span><span
									class="span_value">${c.UserCompanyName}</span>
									</c:when>
									</c:choose></td>
							</tr>
							<tr>

								<td><input type="hidden" value="${c.UnitPrice}" id="jiage" /><span class="span_name">报价单价：</span><span
									class="span_value">${c.UnitPrice}&nbsp;</span></td>
								<td><span class="span_name">购买数量：</span><span
									class="span_value">${c.Quantity}</span></td>
								<td><span class="span_name">配送地域：</span><span
									class="span_value">${c.InquirySheetAddress}</span></td>
							</tr>
							<tr>
								<td><span class="span_name">报价总额：</span><span
									class="span_value">${c.Quantity*c.UnitPrice}</span></td>
								<td><span class="span_name">产品规格：</span><span
									class="span_value">${c.ProductModel}&nbsp;</span></td>
								<td><span class="span_name">有效期至：</span><span
									class="span_value"><fmt:formatDate
											value="${c.ValidUntil}" type="date" dateStyle="long"
											pattern="yyyy-MM-dd" var="time" /> <c:out value="${time }" /></span></td>
							</tr>
							<tr>
								<td><c:if test="${status=='2'}">
										<span class="span_name">填写成交价格：</span>
										<input type="text" id="txtBargainPrice${c.ID}"
											onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											value="${c.BargainPrice}" />
									</c:if> <c:if test="${status=='0'}">
										<span class="span_name">填写心理价格：</span>
										<input style="height:20px;" type="text" id="txtBargainPrice${c.ID}"
											onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											onkeyup="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'').replace(/^\./g,'').replace(/\.{2,}/g,'.').replace('.','$#$').replace(/\./g,'').replace('$#$','.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
											value="${c.BargainPrice}" />
									</c:if></td>
								<td><c:if test="${c.Status==0}">
										<span class="span_name">议价电话：</span><span
									class="span_value">${c.CompanyTel}</span>
											</c:if></td>
							</tr>
							<tr>
								<td colspan="10" style="height: 20px;"></td>
							</tr>
						</tbody>
					</c:forEach>
				</table>
			</div>

			<!-- 分页 -->
			<div class="pagin">
			<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
			<div id="Pagination" class="meneame" style="clear:left"></div> 	
			</div>
			<%-- <div class="pagin">
				<div class="message">
					共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
				</div>
				<ul class="paginList">
					<c:choose>
						<c:when test="${page.currentPage==1}">
							<li class="paginItem current"><a href="#"><span
									class="pagepre"></span> </a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/merchant/
							<c:choose>
							<c:when test="${status=='2'}">
							Bargaining.do
							</c:when>
							<c:when test="${status=='0'}">
							toBargaining.do
							</c:when>
							<c:when test="${status=='3,4'}">
							ProcessBargainPrice.do
							</c:when>
							</c:choose>
							?currentPage=${page.currentPage-1}&&ids=${ids}"><span
									class="pagepre"></span> </a>
							</li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="1" end="${page.totalPage}" var="s3">
						<c:choose>
							<c:when test="${s3==page.currentPage}">
								<li class="paginItem current"><a href="#">${s3}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/
							<c:choose>
							<c:when test="${status=='2'}">
							Bargaining.do
							</c:when>
							<c:when test="${status=='0'}">
							toBargaining.do
							</c:when>
							<c:when test="${status=='3,4'}">
							ProcessBargainPrice.do
							</c:when>
							</c:choose>
							?currentPage=${s3}&&ids=${ids}">${s3}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${page.currentPage==page.totalPage or s3<=10}">
							<li class="paginItem current"><a href="#"><span
									class="pagenxt"></span> </a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/merchant/
							<c:choose>
							<c:when test="${status=='2'}">
							Bargaining.do
							</c:when>
							<c:when test="${status=='0'}">
							toBargaining.do
							</c:when>
							<c:when test="${status=='3,4'}">
							ProcessBargainPrice.do
							</c:when>
							</c:choose>
							?currentPage=${page.currentPage+1}&&ids=${ids}"><span
									class="pagenxt"></span> </a><br>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div> --%>
			<br />
			<!-- <p id="p1">议价可直接拨打客服电话进行议价——400 991 3966</p> -->
			<br />
			<div calss="demo" style="text-align: center;">
				<c:if test="${status=='0'}">
					<input type="button" value="确认提交"  id="sub" class="action qrtj orange"
						onclick="EidtPriceSheet(2)" />
				</c:if>
				<c:if test="${status=='2'}">
					<input type="button" value="确认议价" id="confirm" class="action qrtj orange"
						onclick="EidtPriceSheet(3)" />
					<input type="button" value="拒绝议价" id="deny"class="action jjyj orange"
						onclick="EidtPriceSheet(4)" />
				</c:if>
			</div>
		</c:if>
	</div>
	
	<div class="overlay"></div>

<div id="AjaxLoading" class="showbox">
	<div class="loadingWord"><img src="<%=path%>/images/waiting.gif">加载中，请稍候...</div>
</div>

<div style="height:1200px;">
	
</div>
</body>
</html>
