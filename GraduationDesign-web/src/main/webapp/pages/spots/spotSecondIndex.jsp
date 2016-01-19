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
<link href="<%=path%>/css/specialPublic.css" rel="stylesheet" type="text/css" media="all"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
 	function paixu(i){
		for(var j=1;j<4;j++){
				   $("#input_" + j).css({"color":"#686868", "background":"#fff"});
				   }
			   $("#input_" + i).css({"color":"#fff", "background":"#FE5C4D"});
	}
	
	/*点击子类显示规格和商品信息*/
	function subclass(subclassCateGoryId){
		$.ajax({
			type : "POST",
			url : "conditionSearch.do",
			dataType : "text",
			data : {
				"subclassCateGoryId" : subclassCateGoryId
			},
			success : function(data) {
				//提示	
				var json =eval('(' + data + ')');
				if(json.result="true"){
				
				}
			}
		});
	}
	
	/*点击价格显示对应商品信息*/
	function price(priceNum){
		$.ajax({
			type : "POST",
			url : "conditionSearch.do",
			dataType : "text",
			data : {
				"priceNum" : priceNum
			},
			success : function(data) {
				//提示	
				var json =eval('(' + data + ')');
				if(json.result="true"){
				
				}
			}
		});
	}
	
	/*点击价格显示对应商品信息*/
	function brand(brandId){
		$.ajax({
			type : "POST",
			url : "conditionSearch.do",
			dataType : "text",
			data : {
				"brandId" : brandId
			},
			success : function(data) {
				//提示	
				var json =eval('(' + data + ')');
				if(json.result="true"){
				
				}
			}
		});
	}
</script>
<style type="text/css">
.questionBank{ 
	line-height:20px;  
	width: 154px; 
	height: 45px; 
	font-size:12px; 
	color:#8B8B8B;
	background:transparent;
	border-style:none; 
	resize: none;
	overflow-x:hidden;
	overflow-y:hidden;
	margin:5px;
	font-family:"Microsoft YaHei",Arial,Helvetica,sans-serif,"宋体";
}
p{
	font-family:"Microsoft YaHei",Arial,Helvetica,sans-serif,"宋体";
	margin:0 0 0 5px;
	}
#p_jiage{
	height:33px;
}
#p_jiage span{
	float:left;
	display:block;
}
#p_tiaojian{
	height:38px;
	line-height:38px;
	background-color:#FAFAFA; 
	border:1px solid #E5E5E5;
	margin-left:0;
	margin-bottom:10px;
}
#p_tiaojian span{
	float:left;
	display:block;
	margin:0 20px 0 10px;
	font-size:14px;
	color:#9A9A9A;
}
#p_tiaojian span input[type="button"]{
	height:27px;
	border:1px solid #e5e5e5;
	margin-right:5px;
	background-color:#fff;
	color:#686868;
}
.div_tmtop{
	width:362px; 
	height:182px; 
	position:relative;
	float:left;
	margin:0 10px;
}
.div_temai{
	position:absolute; 
	z-index:2; 
	left:0px; 
	top:0px;
}
.div_shangping{
	position:absolute; 
	z-index:1; 
	width:344px; 
	height:158px; 
	margin:5px 0 0 5px; 
	padding:19px 0 0 14px; 
	border:1px solid #f5f5f5;
}
.div_shangping:hover{
	border:1px solid #FE5C4D;
}
.div_xiangqing{
	height:294px; 
	width:169px;
	float:left;
	margin-left:10px;
}
.div_liulan{
	height:265px; 
	width:169px;
	margin:0 auto;
}
/*------------------按钮--------------------*/
.button_qg{
	width:82px;
	height:23px;
	border:0;
	float:left;
	background-image:url(../images/spots/imageslist/btn.png);
}
.button_qg:hover {
	background-image:url(../images/spots/imageslist/btn_1.png);
}
.button_sc{
	width:82px;
	height:23px;
	border:0;
	float:right;
	background-image:url(../images/spots/imageslist/btn2.png);
}
.button_sc:hover {
	background-image:url(../images/spots/imageslist/btn2_2.png);
}
/*------------------筛选--------------------*/
#div_shaixuan{
	width:1128px; 
	height:260px; 
	margin:33px auto; 
	border:1px solid #e5e5e5;
}
#div_shaixuan p{
	height:55px;
	line-height:55px;
	border-top:1px dashed #e5e5e5;
	margin:0;
	padding-left:50px;
}
#div_shaixuan span{
	float:left;
	margin-right:15px;
	color:#999999;
	font-size:12px;
}
</style>
</head>
<body>
<div style="width:1146px; height:30px; line-height:30px; margin:0 auto;"><p style="float: right;font-size: 14px;color:#666">全部分类 》${productCategory.cateGoryName}</p></div>
    <div style="width:1146px; height:185px; margin:0 auto;">
        <!------------------------------------这里开始循环----------------------------> 
    	<c:forEach items="${hotProduct}" var="h" begin="0" end="2">
    	<div class="div_tmtop">
        	<div class="div_temai"><img src="<%=path%>/images/spots/imageslist/tj_03.png"/></div>
        	<div class="div_shangping">
            	<div style="width:154px; float:left;"><img style="width:154px; height:139px;" src="<%=path%>${h.filePath}"/></div>
                <div style="float:left; margin-left:10px; width:170px;">
                	<p style="font-size:15px; font-weight:600; color:#5e5e5e; margin-bottom:7px;">${h.productName}</p>
                    <textarea class="questionBank" name="special.name" id="specialName" disabled="disabled" >
${h.productTitle}
                     </textarea>
                     <p id="p_jiage">
                         <span style="font-size:12px; margin-top:13px; color:#757575;">特卖价</span>
                         <span style="font-size:12px; margin-top:13px; color:#FE5C4D;">￥</span>
                         <span style="font-size:24px; color:#FE5C4D;">${h.spotUnitPrice}</span>
                     </p>
                     <input class="button_qg" type="button"/>
                     <input class="button_sc" type="button"/>
                </div>
            </div>
        </div>
        </c:forEach>
        </div>
    <!----------------------------------------筛选条件--------------------------------------->
    <div id="div_shaixuan">
    	<p style="height:38px; line-height:38px; background-color:#FAFAFA; padding-left:15px; border:0;">
        	<span style="font-size:18px; color:#FE5C4D">${productCategory.cateGoryName}</span>
        	<span style="font-size:14px; color:#494949;">商品筛选</span>
            <span>（共125个商品）</span>
        </p>
        <p style="border:0;">
        	<span style="font-size:14px; font-weight:600;">子类：</span>
            <!----------------这里循环选择条件---------------------->
            <span onclick="subclass(${productCategory.id});">全部</span>  
            <c:forEach items="${productCategoryName}" var="p">
            <span onclick="subclass(${p.id});">&nbsp;&nbsp;${p.cateGoryName}</span>
            </c:forEach>
        </p>
        <p>
        	<span style="font-size:14px; font-weight:600;">价格：</span>
            <!----------------这里循环选择条件---------------------->
            <span onclick="price(0);">全部</span> 
            <span onclick="price(1);">50以内</span>
            <span onclick="price(2);">50~100</span>
            <span onclick="price(3);">100~150</span>
            <span onclick="price(4);">150~200</span>
            <span onclick="price(5);">200以上</span>
        </p>
        <p>
        	<span style="font-size:14px; font-weight:600;">品牌：</span>
            <!----------------这里循环选择条件---------------------->
            <span onclick="brand(4);">全部 </span>
            <c:forEach items="${productBrandName}" var="pb">
            <span onclick="brand(${p.id});">&nbsp;&nbsp;${pb.brandName}</span>
            </c:forEach>
            
        </p>
        <p>
        	<span style="font-size:14px; font-weight:600;">规格：</span>
            <!----------------这里循环选择条件---------------------->
            <span>全部  100  200  300  </span>
        </p>
    </div>
    
    <div style="width:1128px; margin:0 auto;">
    	<p id="p_tiaojian">
            <span>配送地区：<input type="text"/></span>
            <span>排序：
                <input id="input_1" onclick="paixu(1);" type="button" value="销量"/>
                <input id="input_2" onclick="paixu(2);" type="button" value="价格"/>
                <input id="input_3" onclick="paixu(3);" type="button" value="上架时间"/>
            </span>
            <span><input type="radio"/>仅显示有货商品</span>
        </p>
        <!-----------------------------左边------------------------------------------->
    	<div style="width:225px; float:left; border:1px solid #e5e5e5;">
        	<p style="height:38px; line-height:38px; border-top:2px solid #FE5C4D; margin:0; padding-left:25px; color:#787878;">最近浏览</p>
           <c:forEach items="${recentProducts}" var="r" begin="0" end="5">
            <!-----------------------------这里开始循环------------------------------------------->
            <div class="div_liulan">
            	<div style="width:167px; height:149px; padding:1px; border:1px solid #DFDFDF;"><img style="width:167px; height:149px;" src="<%=path%>${r.filePath}"/></div>
                <p style="font-size:16px; color:#FE5C4D">￥${r.spotUnitPrice}</p>
                <textarea class="questionBank" name="special.name" id="specialName" disabled="disabled" >
${r.productTitle}
                </textarea>
            </div>
            </c:forEach>
        </div>
        <!-----------------------------右边-------------------------------------------> 
    	<div style="width:895px; float:right;">
            </div><!-----------------------------这里开始循环------------------------------------------->
        	<c:forEach items="${productInfo}" var="p">
        	<div class="div_xiangqing">
            	<div style="width:167px; height:149px; padding:1px; border:1px solid #DFDFDF;"><img style="width:167px; height:149px;" src="<%=path%>${p.filePath}"/></div>
                <p style="font-size:16px; color:#FE5C4D">${p.spotUnitPrice}</p>
                <textarea class="questionBank" name="special.name" id="specialName" disabled="disabled" >
${p.productTitle}
                </textarea>
                <input class="button_qg" type="button"/>
                <input class="button_sc" type="button"/>
            </div><!-----------------------------这里开始循环------------------------------------------->
        	</c:forEach>
        </div>
    </div>
</body>
</html>