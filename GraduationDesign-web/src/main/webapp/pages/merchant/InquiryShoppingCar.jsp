<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	String jsonAddrs = (String) request.getAttribute("jsonAddrs");
	String json = (String) request.getAttribute("json");
	String departId = (String) request.getAttribute("departId");
	String companyId = (String) request.getAttribute("companyId");
	Integer userId = (Integer) request.getAttribute("userId");
	String productId = (String) request.getAttribute("productId");
	String addressID = (String) request.getAttribute("addressID");
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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/redcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<link rel="stylesheet" href="<%=path%>/css/redcss/jindutiao.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector4.css" />
<script type="text/javascript">
	function collect(id,shoppingCartId){
	var addrsss=$("#addressShopping"+shoppingCartId).val();
	location.href="addMyCollection.do?favoriteType=1&&pid="+id+"&&addrsss="+addrsss;
	}
var xunjia = function() {
	//获取选中radio的值
	var shoppingCartId = $('input:radio:checked').val();
	var productQuantity = $("#ProductQuantity" + shoppingCartId).val().trim();
	var addressShopping = $("#addressShopping" + shoppingCartId).val();
		if(productQuantity!=null&&productQuantity!=""){
		$.ajax({
			type : "POST",
			url : "AddToInquiry.do",
			dataType : "text",
			data : {
				"shoppingCartId":shoppingCartId,
				 "productQuantity":productQuantity,
				 "addressShopping":addressShopping
			},
			success : function(data) {
				//提示问题内容		
				var json = eval('(' + data + ')');
				if(json.result=="1"){
					alert("请先登录！");
				    //window.location.href= "<%=path%>/web/toLogin.do";
				    return;
				}else if(json.result=="2"){
					alert("请进行企业认证！");
					window.location.href= "<%=path%>/merchant/merchantAccountManager.do";
					return;
				}else if(json.result=="3"){
					alert("等待系统后台认证！");
					return;
				}else if(json.result=="true") {
					//跳转
					window.location.href= "<%=path%>/merchant/myInquiry.do?InquiryId="+json.inquiryId;
				}
					//alert(data);
			}
		});
		}else{
			alert("请输入合适的数量");
		}
	};
 $(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=json%>);
	  	$("#rows").html(json.rows);
	  	$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination").pagination(json.rows, { // 创建分页按钮
			current_page: json.currentPage-1,
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		
		if(<%=departId%>==null){
		
		location.href="CompanyShoppingCarItem.do?currentPage="+(page_index+1)+"&&userId="+<%=userId%>+"&&companyId="+<%=companyId%>+"&&departId="+<%=departId%>+"&&productId="+<%=productId%>+"&&addressID="+<%=addressID%>;
		}else{
		
		location.href="InquiryShoppingCar.do?currentPage="+(page_index+1)+"&&userId="+<%=userId%>;
		}
		
		}
		flag=true;
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
/*************购物车地址***************/
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
//数量加减
var subNum = function(id) {
		var num = 1;
		var buyNum = $("#ProductQuantity"+id).val();
		if (buyNum != null && buyNum != "") {
			num = parseInt(buyNum) - 1;
			if (num <= 1) {
				num = 1;
			}
		}
		$("#ProductQuantity"+id).val(num);
	};
var addNum = function(id) {
		var num = 1;
		var buyNum = $("#ProductQuantity"+id).val();
		if (buyNum != null && buyNum != "") {
			num = parseInt(buyNum) + 1;
			if (num >= 10000) {
				num = 10000;
			}
		}
		$("#ProductQuantity"+id).val(num);
	};
	
	
//删除对应的购物车数据
var deleteShoppingCart=function(ShoppingCartId,ProductQuantity){
$.ajax({
			type : "POST",
			url : "deleteShoppingCart.do",
			dataType : "text",
			data : {
				"shoppingCartId" : ShoppingCartId,
				"productQuantity" : ProductQuantity
			},
			success : function(data) {
			var json =eval('(' + data + ')');
				//提示	
				var msg = "";
				if (json.result == "true") {
					msg = "删除成功";
				}else{
					msg = "删除失败";
				}
				alert(msg);
				window.location.reload();
			}
		});
};
</script>
<style type="text/css">
#h {
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid;
	color: red;
}

#xun {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
}


#qrtj {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
}

.input_srk {
	width: 40px;
	height: 19px;
	text-align:center;
	
}
#add, #jian{
margin:0px 1px;
padding:0px;
float:none;
}
td {
	text-align: center;
	height: 100px;
}

#th1{
	width:150px;
}
#th2{
	width:250px;
}
tr {
	border-bottom: 1px solid #999;
	height:15px;
}

.button_sc {
	width: 50px;
	height: 20px;
}
.divHead{
background-color:#F5F5F5;
height:50px;
border:2px solid #DFDFDF;
}
#tabs{
   list-style: outside none none;
    margin: 0px;
    overflow: hidden;
    padding: 0;
    width: 100%;
   
}

</style>
</head>

<body>

	<div class="inner_div">
		<%-- <div class="divHead"><jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
			<img src="" style="height:30px;width:30px;padding:10px;" /><span>当前位置：</span>
			<span>商品管理</span><span style="margin-left:500px;"><fmt:formatDate value="${now}" pattern="yyyy年MM月dd日  E"/></span>
		</div>
		<div class="location">
			<hr id="h" />
			<div style="border:2px solid #F5F5F5;border-top:0px;height:25px;padding:10px;"><span style="font-size:18px;"><b>询价购物车</b></span><br />
			</div>
		</div> --%>
<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">商品管理 ></span><span class="lo2">我的购物车</span>
		</div><br/>
		<ul id="tabs">
			<li><a title="tab1" href="<%=path%>/merchant/spotShoppingCar.do">现货购物车</a>
			</li>
			<li ><a title="tab4" href="<%=path %>/merchant/InquiryShoppingCar.do"  style="background:#9a1101 none repeat scroll 0 0;color:#fff;">我的购物车</a>
			</li>
		</ul>
		
		<div id="content">
			<table width="100%" cellspacing="0" align="center">
				<thead>
					<tr id="">
						<th style="display: none">ID</th>
						<th>选择商品</th>
						<th>图片</th>
						<th>商品名称</th>
						<th>规格</th>
						<th>价格</th>
						<th id="th1">数量</th>
						<th>品牌</th>
						<th  id="th2">送货地址</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${list}" var="c">
						<input type="hidden" name="address" value="${c.Address}" />
						<tr>
							<td style="display: none"></td>
							<td><input type="radio" name="box"
								id="shoppingCartId${c.ShoppingCartId}"
								value="${c.ShoppingCartId}" /><input type="hidden"
								name="productId" id="productId" value="${c.ID}" /></td>
							<td><img src="<%=path%>${c.FilePath}"
								style="height: 50px;width: 55px;"></td>
							<td>
								<%-- <input type="hidden" name="ProductName" id="ProductName"
								value="${c.ProductName}" /> --%>${c.ProductName}</td>
							<td>${c.ProductModel}</td>
							<td>${c.UnitPrice}</td>
							<td><input type="button" id="jian" value="-"
									onclick="subNum('${c.ShoppingCartId}')" /><input class="input_srk" type="text"
								name="ProductQuantity" id="ProductQuantity${c.ShoppingCartId}"
								onkeyup="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
										onafterpaste="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
								value="${c.ProductQuantity}" /><input type="button" id="add" value="+"
									onclick="addNum('${c.ShoppingCartId}')" /></td>
							<td>${c.ProductBrand}</td>
							<td><span style="border:1px solid #ABADB3;background-color:#FFFFFF;padding:3px;" onclick = "shoppingAddressClick('${c.ShoppingCartId}')" id="shoppingCart1Id${c.ShoppingCartId}">${c.ShoppingAddressName}
							<img src="<%=path %>/images/redimg/btn20121210.png"/></span>
								<p style="display:none;" id="address${c.ShoppingCartId}"
									name="address${c.ShoppingCartId}">${c.ShoppingCartAddressName}</p>
									<input type="hidden" id="addressShopping${c.ShoppingCartId}" value="${c.Address}"
									name="addressShopping${c.ShoppingCartId}"/>
									
							</td>
							<td><input class="orange button_sc" type="button" style="margin-bottom:10px;"
								name="collect" value="收藏" onclick="collect('${c.ID}','${c.ShoppingCartId}')">
								<input class="orange button_sc" type="button" style="margin-top:10px;"
								name="collect" value="删除" onclick="deleteShoppingCart('${c.ShoppingCartId}','${c.ProductQuantity}')"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
		<!-- 分页 -->
		<div class="pagin">
			<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
			<div id="Pagination" class="meneame" style="clear:left"></div>
		</div>
		<div style="text-align: center; margin: 10px 0px;">
			<input class="action orange" type="button" value="询价" onclick="xunjia();" id="xun" />
		</div>
	</div>

	<div class="overlay"></div>

	<div id="AjaxLoading" class="showbox">
		<div class="loadingWord">
			<img src="<%=path%>/images/waiting.gif">加载中，请稍候...
		</div>
	</div>

	<div style="height:1200px;"></div>



</body>
</html>
