<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String pageRights = request.getAttribute("pageRights").toString();
	String t1 = request.getSession().getAttribute("provinceId").toString();
	String t2 = request.getSession().getAttribute("cityId").toString();
	String t3 = request.getSession().getAttribute("areaId").toString();
%>
<script language="javascript" type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
//----------------查看账户流水
function showLog(){
	location.href="<%=path%>/merchant/accountWater.do";
}
function doit(para,id){ 
    var num =parseInt( $("#inp"+id).val());
    //alert(num);
    if(num >0){
    num = num + para;
    $("#inp"+id).val(num);
    }else{
    	if(num==0&para==1){
        	num = num + 1;
        	$("#inp"+id).val(num);
        }
    }
}	
//--------上架
function sjia(id){
	location.href="/ssm/merchant/grounding.do?id="+id;
}
//--------下架
function xjia(id){
	location.href="/ssm/merchant/undercarriage.do?id="+id;
}
//----------询价
function xunjia(id,ProductID){
	var num = $("#inp"+id).val();
	if(num == 0 ||num < 0){
	alert("数量必须大于0！");
	return;
	}
	var address = <%=t1%>+","+<%=t2%>+","+<%=t3%>;
	$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddInquirySheet.do",
			dataType : "text",
			data : {
				"productId" : ProductID,
				"buyNum":num,
				"address":address
			},
			success : function(data) {
				var json =eval('(' + data + ')');
				if (json.result == "true") {
			   if(json.inquiryId=='null')
				{
					alert("暂时不能询价，请联系管理员");
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
}
</script>
<style type="text/css">

 #b1,#b2,#b3,#b4 {
	height: 20px;
	width: 70px;
	font-size: 12px;
	color: white;
	margin-left: 60px;
} 
hr{
    margin: 3px 0px;
}

#d1,#d2,#d3,#d4,#d5{
	width:100%;
	border:1px solid #D1D1D1;
	margin-top:15px;	
}
#p_head{
	background-color:#ECECEC;
	height:35px;
	line-height:35px;
	margin:0 0 12px 0;
	font-size:16px;
	padding-left:15px;
	color:#000000;
}
#p1{
	height:26px;
	line-height:26px;
	font-size:12px;
	margin:0 0 1px 28px;	
}
.span_p{
	width:40px;
	font-size:20px;
	color:red;
	border-bottom:1px solid #666;
	text-align:center;
}
span{
	float:left;
	display:block;
}
.div_Commodity{
	width:140px;
	height:171px;
	float:left;
}
.img_Commodity{
	width:121px;
	height:110px;
	border:2px solid #e5e5e5;
	margin:0 8px;
}
.p2{
	text-align:center;
	margin:3px 0 0 0;
	font-size:13px;	
}
.p3{
	text-align:center;	
	margin:3px 0 0 0;
	font-size:11px;
	color:#737373;
	white-space:nowrap;
	width:130px; 
	text-overflow :ellipsis;
	-o-text-overflow:ellipsis;
	overflow: hidden;
}
.input_but_sx{
	padding:0;
	width:8px;
	height:8px;
	font-size:6px;
	border:none;
	background-color:#fff;
	color:#666;
	background-repeat:no-repeat;
	background-size:cover;
	-moz-background-size:cover;
	-webkit-background-size:cover;
}
.input_txt_sx{
	width:40px;
	border:none;
}
td{
	border:1px solid #D1D1D1;
	
}
#anniu{
	height:20px;
	width:55px;
	font-size:12px;
	border-radius: 0px;
}
.div_anniu{
	margin:5px 0 0 10px;
	float:left;
}
/*--------------上架中状态按钮-----------------------------------*/
.anniu_sjia{
	width: 60px;
    height: 18px;
    background-color: #fb4949;
    color: #FFF;
    font-size: 12px;
    border: medium none;
	text-align:center;
}
/*--------------下架中状态按钮-----------------------------------*/
.anniu_xjia {
	width: 60px;
    height: 18px;
    background-color: #d1d1d1;
    color: #FFF;
    font-size: 12px;
    border: medium none;
	text-align:center;
}
/*----------上下架按钮---------------*/
.anniu_sxjia{
	width: 50px;
    height: 20px;
    background-color: #fff;
    color: #fb4949;
    font-size: 12px;
    border:1px solid #fb4949;	
}
.anniu_sxjia:hover {
	background: #B80000;
	color:#fff;
}
.anniu_sxjia:active {
    background-color: #fb4949;
}
#p4 span{
	margin-right:10px;
}
p{
	margin: 16px 0;
}
</style>
</head>

<body style="font-family:"Microsoft YaHei",Arial,Helvetica,sans-serif,"宋体";">

	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
				<span>当前位置：</span><span>商品管理 ></span><span>首页</span>
		</div>
		<%
			if (pageRights != null && pageRights.contains("IsPurchase,")) {
		%>

		<div id="d1" style="height:153px;">
			<p id="p_head">我的采购业务</p>
			<%
			if (pageRights != null && pageRights.contains("bargainingResponse,")) {
		%>
		<p id="p1"><span>议价管理：有</span><span class="span_p"><a style="color: #B00100; font-size: 22px;" href="myPriceSheet.do">${rows1}</a>
		</span><span>个议价单供应商已响应</span></p>
			<%
			}
		%>
		<%
			if (pageRights != null && pageRights.contains("OrderAddressNum,")) {
		%>
		<p id="p1"><span>配送管理：有</span><span class="span_p"><a style="color: #B00100; font-size: 22px;" href="myOrder.do">${rows2}</a></span><span>个订单等待您分配地址</span></p>
			<%
			}
		%>
		<%
			if (pageRights != null && pageRights.contains("purchaserCheckNum,")) {
		%>
		<p id="p1"><span>验收管理：有</span><span class="span_p"><a style="color: #B00100; font-size: 22px;" href="myDispatchBillToChecker.do">${rows3}</a></span><span>个验收单等待您的处理</span></p>
		<%
			}
		%>	
		</div>
		<%
			}
		%>
		<%
			if (pageRights != null && pageRights.contains("IsSupply,")) {
		%>
		<div id="d2" style="height:153px;">
			<p id="p_head">我的供应业务</p>
			<%
			if (pageRights != null && pageRights.contains("bargainingWait,")) {
		%>
		<p id="p1"><span>议价管理：有</span><span class="span_p"><a style="color: #B00100; font-size: 22px;" href="Bargaining.do">${r1}</a></span><span>个议价单等待您的处理</span></p>
		<%
			}
		%>	 
			<%
			if (pageRights != null && pageRights.contains("OrderSendNum,")) {
		%>
		<p id="p1"><span>配送管理：有</span><span class="span_p"><a style="color: #B00100; font-size: 22px;" href="myDispatchBillToSupplier.do">${r2}</a></span><span>个订单等待您发货配送</span></p>
			<%
			}
		%>	
		<%
			if (pageRights != null && pageRights.contains("supplierCheckNum,")) {
		%>
		<p id="p1"><span>验收管理：有</span><span class="span_p"><a style="color: #B00100; font-size: 22px;" href="myDispatchBillToDeliveryUser.do">${r3}</a></span><span>个验收单等待您的处理</span></p>
			<%
			}
		%>	</div>
			
		
		<%
			}
		%>
		
		<%
			if (pageRights != null
					&& pageRights.contains("IsCompanyStatement,")) {
		%>
		<div id="d1">
			对账单信息
			<a href="financeInfo.do"><input class="orange" id="b1" type="button" value="我的财务" /> </a>
			<hr />
			<div class="div_list">
			<table width="200" border="1" cellspacing="0">
				<tr>
					<td align="center">日期</td>
					<td align="center">采购金额</td>
					<td align="center">已支付金额</td>
					<td align="center">未结算金额</td>
				</tr>
				<c:forEach items="${cbs}" var="c">
					<tr>
						<td align="right">${c.startTime}</td>
						<td align="right">${c.amount}元</td>
						<td align="right">${c.settledAmount}元</td>
						<td align="right">${c.amount-c.settledAmount}元</td>
					</tr>
				</c:forEach>
			</table>
			</div>
			
				
		</div>
		<%
			}
		%>
		
		<%
			if (pageRights != null && pageRights.contains("IsShoppingCart,")) {
		%>
		<div id="d2">
			购物车&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"><input class="orange" id="b2" type="button" value="我的购物车" /> </a>
			<hr />
			<div class="div_list">
			<table width="200" border="1" cellspacing="0">
				<thead>
					<tr>
						<th align="center">商品名称</th>
						<th align="center">规格</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${shoppingCart}" var="sc">
						<tr>
							<td>${sc.productName}</td>
							<td>${sc.productCategoryName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
         </div>
			

		</div>
		<%
			}
		%>
		<%
			if (pageRights != null && pageRights.contains("IsProductFavorite,")) {
		%>
		<div id="d3" style="height:236px;">
			<p id="p_head">我的商品收藏   <span style="float:right;margin-right:20px;display:block;"><a href="<%=path%>/merchant/myCollection.do?favoriteType=1">更多>></a></span></p>
			 <div style="margin-left:10px;">
			<c:forEach items="${favorites}" var="f" begin="0" end="5">
			<div class="div_Commodity">
			 <img class="img_Commodity" src="<%=path%>${f.FilePath}"/>
                    <P class="p2">${f.ProductName}</P>
                    <P class="p3">${f.ProductTitle}&nbsp;</P>
                    <div class="div_anniu">
                        <table cellpadding=0 cellspacing=0>
                          <tr>
                            <td rowspan="2"><input class="input_txt_sx" type="text" id="inp${f.ID}" value="1"></td>
                            <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/shang.png);" onclick="doit(1,${f.ID});"/></td>
                          </tr>
                          <tr>
                            <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/xia.png);" onclick="doit(-1,${f.ID})"/></td>
                          </tr>
                       </table>
                    </div>
                   <div class="div_anniu"><input id="anniu" class="orange" type="button" value="询价" onclick="xunjia(${f.ID},${f.ProductID});"/></div>
			</div>
			</c:forEach>
           </div>
		</div>
		<%
			}
		%>
		<%
			if (pageRights != null
					&& pageRights.contains("IsCompanyProduct,") == true) {
		%>
		<div id="d4" style="height:236px;">
			<p id="p_head">我的商品供应 <span style="float:right;margin-right:20px;display:block;"><a href="<%=path%>/merchant/toProductEdit3.do">更多>></a></span></p>
			 <div style="margin-left:10px;">
				<c:forEach items="${companyProducts}" var="cp" begin="0" end="5">
				<div class="div_Commodity">
				<img class="img_Commodity" src="<%=path%>${cp.FilePath}"/>
                    <P class="p2">${cp.ProductName}</P>
                    <P class="p3">${cp.ProductTitle}&nbsp;</P>
                    <div class="div_anniu">
                    <c:if test="${cp.Status == 1}">
                    <input class="anniu_sjia" type="text" disabled value="上架中"/>
                    </c:if>
                    <c:if test="${cp.Status == 0}">
                    <input class="anniu_xjia" type="text" disabled value="下架中"/>
                    </c:if>
                    </div>
                    <div class="div_anniu">
                    <c:if test="${cp.Status == 0}">
                    <input class="anniu_sxjia" type="button" value="上架" onclick="sjia(${cp.ID});"/>
                    </c:if>
                    <c:if test="${cp.Status == 1}">
                    <input class="anniu_sxjia" type="button" value="下架" onclick="xjia(${cp.ID});"/>
                    </c:if>
                    </div>
				</div>	
				</c:forEach>
			</div>
		</div>
		<%
			}
		%>
		
		<%
			if (pageRights != null && pageRights.contains("IsCompanyBalance,")) {
		%>
		<div id="d5" style="height:192px;">
        	<p id="p_head" style="margin:0;">我的财务管理</p>
            <div style=" float:left; height:147px; width:374px; border-right:1px solid #D1D1D1; padding:10px 0 0 25px;">
            	<p style="font-size:12px; color:#484442;">
            	<%
				java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy年MM月dd日");
				java.util.Date currentTime = new java.util.Date();//得到当前系统时间
				String date = formatter.format(currentTime); 
				%>
            	截止到<%=date%>
            	</p>
                <p style="font-size:14px; color:#484442;">账户余额</p>
                <p id="p4" style="height:34px;">
                    <span style="font-size:24px; color:#787878;">${companyBalance}元</span>
                    <span style="margin-top:10px;"><input style=" color:#787878; font-weight:700;" type="button" value="充值"/></span>
                    <span style="margin-top:10px;"><input style=" color:#787878; font-weight:700;" type="button" value="提现"/></span>
                </p>
            </div>
            <c:if test="${companyType==1 || companyType==2}">
            <div style=" float:left; height:157px; width:235px;text-align:center;">
            	<P  style="font-size:14px; color:#484442;">累计采购金额：</p>
                <P style="height:30px; padding-left:60px;"><span style="font-size:20px; color:#787878;">${CountPurchaseAmount}</span><span style="font-size:14px; color:#484442; margin-top:8px;">元</span></p>
                <P><input style=" color:#787878; font-weight:700;" type="button" value="查看" onclick="showLog();"/></p>
                <P  style="font-size:12px; color:#8E8E8E;">点击查看历史采购交易流水</p>
            </div>
            </c:if>
            <c:if test="${companyType==1 || companyType==3}">
            <div style=" float:left; height:157px; width:234px; text-align:center;border-left:1px solid #D1D1D1;">
            	<P  style="font-size:14px; color:#484442;">累计供应金额：</p>
                <P style="height:30px; padding-left:60px;"><span style="font-size:20px; color:#787878;">${CountSupplyAmount}</span><span style="font-size:14px; color:#484442; margin-top:8px;">元</span></p>
                <P><input style=" color:#787878; font-weight:700;" type="button" value="查看" onclick="showLog();"/></p>
                <P  style="font-size:12px; color:#8E8E8E;">点击查看历史采购交易流水</p>
            </div>
            </c:if>
        </div>
		<%
			}
		%>
	</div>





</body>
</html>
