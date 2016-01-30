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
	String ProductQuantity = request.getParameter("ProductQuantity");
	String ProductName = request.getParameter("ProductName");
	String json = (String) request.getAttribute("json");

	String jsonAddrs = (String) request.getAttribute("jsonAddrs");
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
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector5.css" />
<script type="text/javascript">
	function baojia() {
	
	//ajax存入报价单
		var data=getId();
		//alert(ids);
		if(data!=null && data.length>=0)
		{		
			$.ajax({
			type : "POST", 
			url : "AddPriceSheet.do",
			dataType : "text",
			data : {
				"data" : data
			},
			success : function(data) {
				//---------------------------点击后置灰
       		$("#qrtj").attr('disabled',"true");
      		 $("#qrtj").css('background-color','#E3E3E3');
				//提示	
				var json =eval('(' + data + ')');
				//alert(data);
			//	alert("结果为："+json.result+","+json.ids);
				if(json.result=="true")
				{
					location.href = "myPriceSheet.do?ids="+json.ids;
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
	
	}

	function getId() {
		var fileIds = "";
		var tmpmsg = "";
		$("input[name=box]:checked").each(
				function() {
					var id = $(this).val();
					var time = $("#txtExpectTime_" + id).val();
					if (time == "") {
						tmpmsg = "请给询价单【" + id + "】填写期望交期";
						return null;
					}
					var inquiryAddress=$("#addressShopping"+id).val().trim();
					
					var num = $("#txtProductQuantity_" + id).val();
					fileIds += "{id:'" + id + "',time:'" + time + "',num:'"
							+ num+ "',address:'" + inquiryAddress + "'},";
				});
		fileIds = fileIds.substring(0, fileIds.length - 1);
		if (tmpmsg != "") {
			alert(tmpmsg);
			return null;
		}
		//alert(ids);
		if (fileIds == null || fileIds == '') {
			alert("请选择需要提交的单据");
			return null;
		}
		fileIds = "[" + fileIds + "]";
		return fileIds;
	}

	function checkAll() {
		var ischecked = document.getElementById("checkAll").checked;
		if (ischecked) {
			checkallbox();
		} else {
			discheckallbox();
		}
	}
	function checkallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = true;
		}
	}
	function discheckallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = false;
		}
	}
	function checkBox() {

		var checkObjs1 = $(":checkbox[name='box']:checked");
		var checkObjs2 = $(":checkbox[name='box']");
		if (checkObjs1.length == checkObjs2.length) {
			document.getElementById("checkAll").checked = true;
		} else {
			document.getElementById("checkAll").checked = false;
		}
	}
	$(function() {
		var flag = false; //标识生成分页时是否生成查询默认页商品
		var json = eval(
<%=json%>
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
			var inquiryId=$("#inquiryId1").val();
			var productName=$("#productName1").val();
			var orderTime=$("#orderTime1").val();
			var status = $("#status1").val();
			var s="";
			if(inquiryId.length>0){
				s+="&&inquiryId2="+inquiryId;
			}
			if(productName.length>0){
				s+="&&productName="+productName;
			}
			if(orderTime.length>0){
				s+="&&orderTime="+orderTime;
			}
			if (status.length > 0) {
				s += "&&status=" + status;
			}
			if (flag) {
				location.href = "myInquiry.do?currentPage=" + (page_index + 1)+s;
			}
			flag = true;
			return false;
		}
		initPagination();
	});
	function changeExpectTime(inquiryId) {
	
		var ExpectTime = $("#txtExpectTime_" + inquiryId).val();
		//var orderTime = $("#orderTime_" + inquiryId).text().trim().substring(0,
		//		10);
		var date1 = new Date();
		var date2 = new Date(Date.parse(ExpectTime));
		if (date1.getTime() > date2.getTime()) {
			alert("期望交期时间不得小于当前时间。");
			$("#txtExpectTime_" + inquiryId).val("");
		}

	}
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

/*************询价单地址***************/
var jsonAddrs =<%=jsonAddrs%>;
var shoppingCartId;
function shoppingAddressClick(ShoppingCartId){
		shoppingCartId=ShoppingCartId;
		var addressDiv="";
		if($("#remDiv").length>0){
		$("#remDiv").replaceWith(s);
		}	
		addressDiv+='<div id="remDiv">'
					+'<ul id="list1" style="width:100%;margin:0px auto 0 auto;">'
					+'<li id="summary-stock">'
					
					+'<div class="dd">'
					+'<div id="store-selector">'
					+'<div class="text">'
					+'<div></div>'
					+'<b></b><input type="hidden" id="addressjoin" value="" />'
					+'</div>'
					+'<div onclick=$("#store-selector").removeClass("hover")'
					+' class="close"></div>'
					+'</div>'
					+'<div id="store-prompt">'
					+'<strong></strong>'
					+'</div>'
					+'</div></li>'
					+'</ul> </div>';
		$("#shoppingCart1Id"+ShoppingCartId).replaceWith(addressDiv);
		$.getScript("<%=path%>/js/redjs/selector4.js");
		//$("#remDiv").remove();
	}
</script>
<style type="text/css">
#qrtj {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
}

#qxfh {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
	margin-left: 20px;
}

#h {
	margin-top: 50px;
	margin-bottom: 30px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid;
	color: red;
}

.input_text {
	height: 20px;
}

table {
	font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, "宋体";
	border: 1px solid #f1f1f1;
	width: 100%;
	margin-top: 20px;
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
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页 </span>> <span class="lo2">询价管理 ></span><span
				class="lo2"> 我的询价单</span><br />
		</div>
		<div
			style="border: 1px solid #D6D6D6; margin: 5px 0; height: 80px; line-height: 40px;">
			<input type="hidden" id="inquiryId1" value="${inquiryId }" /> <input
				type="hidden" id="productName1" value="${productName }" /> <input
				type="hidden" id="orderTime1" value="${orderTime }" /> <input
				type="hidden" id="status1" value="${status }" />
			<form action="myInquiry.do" method="post">
				<span style="margin-left: 15px; font-size: 18px;">询价单查询</span>&nbsp;&nbsp;&nbsp;&nbsp;
				询价单号：<input name="inquiryId2" type="text"
					style="height: 20px; width: 150px;" id="inquiryId2"
					value="${inquiryId }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商品：<input
					name="productName" type="text" style="height: 20px; width: 150px;"
					id="productName" value="${productName }" /><br> <span
					style="margin-left: 120px;">询价日期：</span><input name="orderTime"
					type="text" id="orderTime" value="${orderTime }"
					style="height: 20px; width: 150px;" readonly="readonly"
					onclick="WdatePicker()" />
				<%-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：<select
						name="status" type="text" id="status" style="height:20px;width:65px;">
						<option value="10" <c:if test="${status==10 }">selected="selected"</c:if>>全部</option>
						<option value="0" <c:if test="${status==0 }">selected="selected"</c:if> >初始</option>
						<option value="1" <c:if test="${status==1 }">selected="selected"</c:if> >已询价</option>
						
						</select> --%>
				<span style="margin-left: 200px;"><input name="submitButton"
					class="orange" type="submit" id="submitButton" value="查询" /></span>
			</form>
			<c:if test="${empty inquirySheet}">
				<script type="text/javascript">
			alert("查询结果为空,请重新输入！");
			</script>
			</c:if>

		</div>
		<c:if test="${!empty inquirySheet}">
			<div>
				<table width="100%" border="0" cellspacing="0" align="center">

					<c:forEach items="${inquirySheet}" var="c">
						<tr style="background-color: #FAFAFA;">
							<td colspan="6" style="height: 35px; line-height: 35px;">
								<p style="margin: 0; font-size: 14px; color: #2a2a2a;">
									<span style="float: left;">询价单编号： <c:if
											test="${c.status==1 }">
											<a href="myPriceSheet.do?ids=${c.inquiryId}">${c.inquiryId}</a>
										</c:if> <c:if test="${c.status!=1 }">${c.inquiryId}</c:if>
									</span>
								</p>
							</td>
							<td style="text-align: center"><c:choose>
									<c:when test="${c.status==0}">
										<span class="span_zt zt_dcl">初始</span>
									</c:when>
									<c:when test="${c.status==1}">
										<span class="span_zt zt_ywc">已询价</span>
									</c:when>
								</c:choose></td>
						</tr>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td rowspan="2" style="width: 50px; text-align: center;"><input
								type="radio" name="box" value="${c.inquiryId}" /></td>
							<td rowspan="2" style="width: 90px;"><c:if
									test="${c.productPic!=null && c.productPic!=''}">
									<div
										style="width: 79px; height: 64px; padding: 1px; border: 1px solid #d9d9d9;">
										<img style="width: 79px; height: 64px;"
											src="<%=path%>${c.productPic}" />
									</div>
								</c:if></td>
							<td style="width: 190px;"><span class="span_name">产品名称：</span><span
								class="span_value">${c.productName}</span></td>
							<td style="width: 250px;"><span class="span_name">询价时间：
							</span> <span class="span_value" id="orderTime_${c.id}"><jsp:useBean
										id="date" class="java.util.Date" /> <fmt:formatDate
										value="${c.orderTime}" type="both"
										pattern="yyyy-MM-dd HH:mm:ss" /> </span></td>
							<%-- <td>币种:</td>
							<td>${c.currency}</td> --%>
							<td style="width: 115px;"><span class="span_name">配送区域：</span></td>
							<td><span class="span_value"
								style="border: 1px solid #ABADB3; background-color: #FFFFFF; overflow: hidden; white-space: nowrap; display: block; padding: 2px; width: 115px;"
								onclick="shoppingAddressClick('${c.inquiryId}')"
								id="shoppingCart1Id${c.inquiryId}">${c.inquiryAddressName}
							</span>
								<p style="display: none;" id="address${c.inquiryId}"
									name="address${c.inquiryId}">${c.inquiryAddressNames}</p> <input
								type="hidden" id="addressShopping${c.inquiryId}"
								value="${c.address}" name="addressShopping${c.inquiryId}" /></td>
						</tr>
						<tr>

							<td><span class="span_name">产品规格：</span><span
								class="span_value">${c.productModel}</span></td>
							<td><span class="span_name">购买数量：</span> <span
								class="span_value"><input class="input_text" type="text"
									name="productQuantity" id="txtProductQuantity_${c.inquiryId}"
									style="width: 70px; text-align: right;"
									onkeyup="this.value=this.value.replace(/^[0]/g,'').replace(/\D/g,'')"
									onafterpaste="this.value=this.value.replace(/^[0]/g,'').replace(/\D/g,'')"
									value="${c.productQuantity}">${c.productUnit}</span></td>
							<td><span class="span_name">期望交期：</span></td>
							<td><span class="span_value"><c:if
										test="${c.status==0 }">
										<input style="height: 20px; width: 120px;"
											onclick="WdatePicker()"
											onchange="changeExpectTime('${c.inquiryId}')"
											id="txtExpectTime_${c.inquiryId}" value="${c.expectTime}" />
									</c:if> <c:if test="${c.status!=0 }">${c.expectTime}</c:if> </span></td>

						</tr>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<!-- 分页 -->
			<div class="pagin">
				<!-- <div class="message">
					共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage"
						class="blue"></i>页
				</div> -->
				<div id="Pagination" class="meneame" style="clear: left"></div>
			</div>
			<div class="demo" style="text-align: center; margin-top: 10px;">
				<input type="button" value="确认提交" id="qrtj" class="action orange"
					onclick="baojia();" /> <input type="button" value="取消返回" id="qxfh"
					class="orange" onclick="history.back()" />
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
							href="/ssm/merchant/myInquiry.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
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
								href="/ssm/merchant/myInquiry.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
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
							href="/ssm/merchant/myInquiry.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
								class="pagenxt"></span> </a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
			<hr id="h" />		
		</div> --%>
		</c:if>
	</div>

	<div class="overlay"></div>

	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord">
			<img src="<%=path%>/images/waiting.gif">加载中，请稍候...
		</div>
	</div>

	<div style="height: 1200px;"></div>
</body>
</html>
