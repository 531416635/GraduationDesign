Pagination<%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String json = (String)request.getAttribute("json");
	
	String superclass = (String)request.getAttribute("superclass");

	String subclass = (String)request.getAttribute("subclass");
	String t1 = request.getSession().getAttribute("provinceId").toString();
	String t2 = request.getSession().getAttribute("cityId").toString();
	String t3 = request.getSession().getAttribute("areaId").toString();
	
	/* String rows = (String)request.getAttribute("rows"); */
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="<%=path%>/css/redcss/style.css" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/css/redcss/public.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript" src="<%=path%>/js/redjs/nav.js"></script>
<script type="text/javascript">
   function doit(para,id){ 
    var num =parseInt($("#inp"+id).val());
    if(num >0){
    $("#inp"+id).val(num + para);
   /*  inp.value = num + para; */
    }else if(num==0&para==1){	
    	$("#inp"+id).val( num + 1); 
    }else{
    $("#inp"+id).val(1);
    }
}
 function doits(para,id){ 
    var num =parseInt($("#inps"+id).val());
    if(num >0){
    $("#inps"+id).val(num + para);
    }else if(num==0&para==1){	
    	$("#inps"+id).val( num + 1); 
    }else{
    $("#inps"+id).val(1);
    }
}
function xunjia(id,a){
	if(a==0){
	var num = $("#inps"+id).val();
	}else{
	var num = $("#inp"+id).val();
	}
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
				"productId" : id,
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
	$(function() {
		//点击后判断ul是否隐藏
		$(".purchase p").click(function() {
			var ul = $(".listUl");
			if (ul.css("display") == "none") {
				ul.slideDown(200);
			} else {
				ul.slideUp(200);
			}
		});
		//选中某个内容后赋值给p标签，并隐藏ul列表
		$(".purchase li").click(function() {
			var txt = $(this).text();
			$(".purchase p").html(txt);
			$(".listUl").hide();
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

	$(function() {
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

	$(function() { //点击左右按钮切换图片
		/*点左按钮向左走*/
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
	});

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
          $(function(){ 
          var json = eval(<%=json%>);  //此数据为左上菜单分页展现的首行商品及指定品类商品总条数
          var subclass = "";  //保存临时子类
          var superclass =""; //保存父类
          if(<%=superclass%>!="5"){
          superclass =<%=superclass%>;
          }; 
          if(<%=subclass%>!="5"){   //"5"代表空置，因jsp中的java中接受request或session中保存的参数对象时，该对象只能保存数字型字符串对象而不能保存字符型字符串对象并且不能保存空字符串，否则将无法执行Query.ready()
     	   subclass =<%=subclass%>;
          }
		  var productCategoryIds =""; //设置商品其他品类信息
		  var pageNum =16;   //设置每页显示商品数量
		  var rows =parseInt(json.rows);     //每页显示条数初始化，修改显示条数，修改这里即可    */	
		  var currentPage = 0;//设置默认页
		  var flag = false; //标识生成分页时是否生成查询默认页商品
			$("#search").html("");
			var content = '';
		
			for ( var i = 0; i < json.products.length; i++) {
						 content +='<div class="case_li" style="float:left;margin-left: 0px; margin-right: 25px; overflow:visible;"> <div><a href="toProductInfo.do?ProductId='+json.products[i].id+'"><img width="170" height="165" src="<%=path%>'
						 + json.products[i].filePath
						 +'" /></a></div><div class="span_mr_txt"><p><a href="toProductInfo.do?ProductId='+json.products[i].id+'">'+json.products[i].productName+'</a></p>'
						+' <p class="yangs">'+json.products[i].productTitle+'</p>'
						 +'<p style="color: #c4c4c4;">已有<span style="color: #0e5380; font-weight: 700;">1376</span>人评价</p>'
						 +'</div>'
						 +'<div class="div_anniu">'
                        +'<table cellpadding=0 cellspacing=0>'
                          +'<tr>'
                           +' <td rowspan="2"><input class="input_txt_sx" type="text" id="inp'+json.products[i].id+'" value="0" onkeyup="numCheck(this);" onafterpaste="numCheck(this);" ></td>'
                           +' <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/shang.png);" onclick="doit(1,'+json.products[i].id+')"/></td>'
                         +' </tr>'
                         +' <tr>'
                         +'   <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/xia.png);" onclick="doit(-1,'+json.products[i].id+')"/></td>'
                          +'</tr>'
                      +' </table>'
                   +' </div>'
                    +'<div class="div_anniu"><a href="javascript:xunjia('+json.products[i].id+',1);" class="button orange medium"> 询价</a></div></div>';			
				}
			$("#rows").val(json.rows);
			$("#search").html(content);
	  
	  var initPagination = function() { //此函数为分页动态按钮展现
		$("#Pagination").pagination(rows, { // 创建分页按钮	
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback,
			items_per_page: pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		});
	 }; 
	function pageselectCallback(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
	$("#currentPage").html(page_index+1);
		 if(flag){
		 $.ajax({  //此ajax加载分页商品
			type : "POST",
			async : false,
			url : "toProductsList.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				superclass : superclass,
				subclass : subclass,
				productCategoryIds : productCategoryIds,
				currentPage : page_index+1,
				pageNum : pageNum
			},
			success : function(data) {
				
				if (data == "false") { //提示
					alert("添加失败！");
				} else {
					var json = eval(data);
					$("#search").html("");
					var content = '';
					for ( var i = 0; i < json.products.length; i++) {
						<%-- content +=' <div class="case_li" style="float:left;margin-left: 0px; margin-right: 22px; overflow:visible;"><div style="border:1px solid #dbdbdb;"><a href="toProductInfo.do?ProductId='
						 + json.products[i].id
						 +'"><img width="170" height="165" src="<%=path%>'
						 + json.products[i].filePath
						 +'" /></a><div class="case_li_txt"><div class="span_mr_txt"><a href="toProductInfo.do?ProductId='
						 + json.products[i].id
						 +'">'
						 + json.products[i].productName
						 +'</a></div></div></div><div class="span_detail_new"><a href="toProductInfo.do?ProductId='
						 + json.products[i].id
						 +'" class="button orange medium"> 询价</a></div></div>';	 --%>
						  content +='<div class="case_li" style="float:left;margin-left: 0px; margin-right: 25px; overflow:visible;"> <div><a href="toProductInfo.do?ProductId='+json.products[i].id+'"><img width="170" height="165" src="<%=path%>'
						 + json.products[i].filePath
						 +'" /></a></div><div class="span_mr_txt"><p><a href="toProductInfo.do?ProductId='+json.products[i].id+'">'+json.products[i].productName+'</a></p>'
						+' <p class="yangs">'+json.products[i].productTitle+'</p>'
						 +'<p style="color: #c4c4c4;">已有<span style="color: #0e5380; font-weight: 700;">1376</span>人评价</p>'
						 +'</div>'
						 +'<div class="div_anniu">'
                        +'<table cellpadding=0 cellspacing=0>'
                          +'<tr>'
                           +' <td rowspan="2"><input class="input_txt_sx" type="text" id="inp" value="0"></td>'
                           +' <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/shang.png);" onclick="doit(1)"/></td>'
                         +' </tr>'
                         +' <tr>'
                         +'   <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/xia.png);" onclick="doit(-1)"/></td>'
                          +'</tr>'
                      +' </table>'
                   +' </div>'
                    +'<div class="div_anniu"><a href="toProductInfo.do?ProductId="+json.products[i].id class="button orange medium"> 询价</a></div></div>'
					}
					$("#search").html(content);
				}
			}
		}); 
		}
		flag=true;
		return false;
	   }
		 initPagination();
		
		 function productList(){  //二级界面品类菜单筛选商品列表	  
		 subclass = "";
	/* productCategoryIds="";
		$(".select-result dl dd a").each(function(i, slt) {
			var id=$(slt).attr("title");	
			alert(i);	
			productCategoryIds+=id+((i >= $(".select-result dl dd a").length - 1) ? "" : ",");
	}); */
		var condition0='';//商品成分
		var condition1='';//商品品牌
		var condition2='';//商品规格
		$(".select-list dl .selected a").each(function(i,slt1){
		switch($(slt1).parent().parent().find("dt a").attr("title")){
		case "子类": condition0=$(slt1).attr("title"); break;
		case "品牌": condition1=$(slt1).attr("title"); break;
		case "规格": condition2=$(slt1).attr("title"); break;
		}
		});
		$.ajax({ //此ajax获取rows及初始第一页商品
			type : "POST",
			url : "toProductsList.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				superclass : superclass,
				condition0 :condition0,
				condition1 :condition1,
				condition2 :condition2,
				pageNum : pageNum
			},
			async : false,
			success : function(data) {
				
				if (data == "false") { //提示
					alert("添加失败！");
				} else {				
					var json = eval(data);
					$("#search").html("");
					var content = '';
					for ( var i = 0; i < json.products.length; i++) {
						content +='<div class="case_li" style="float:left;margin-left: 0px; margin-right: 25px; overflow:visible;"> <div><a href="toProductInfo.do?ProductId='+json.products[i].id+'"><img width="170" height="165" src="<%=path%>'
						 + json.products[i].filePath
						 +'" /></a></div><div class="span_mr_txt"><p><a href="toProductInfo.do?ProductId='+json.products[i].id+'">'+json.products[i].productName+'</a></p>'
						+' <p class="yangs">'+json.products[i].productTitle+'</p>'
						 +'<p style="color: #c4c4c4;">已有<span style="color: #0e5380; font-weight: 700;">1376</span>人评价</p>'
						 +'</div>'
						 +'<div class="div_anniu">'
                       +'<table cellpadding=0 cellspacing=0>'
                         +'<tr>'
                          +' <td rowspan="2"><input class="input_txt_sx" type="text" id="inp" value="0"></td>'
                          +' <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/shang.png);" onclick="doit(1)"/></td>'
                        +' </tr>'
                        +' <tr>'
                        +'   <td><input class="input_but_sx" type="button" style="background-image:url(<%=path%>/images/xia.png);" onclick="doit(-1)"/></td>'
                         +'</tr>'
                     +' </table>'
                  +' </div>'
                   +'<div class="div_anniu"><a href="toProductInfo.do?ProductId="+json.products[i].id class="button orange medium"> 询价</a></div></div>'	;	
					}
					$("#rows").val(json.rows);
					rows = json.rows;
					if(json.rows==0){
					$("#search").html("&nbsp;&nbsp;&nbsp;&nbsp;");
					}else{
					$("#search").html(content);
					}				
				}
				location.href="#";
			}
		});
	}
	
	$("#select1 dd").click(function () { //以下js代码可累计简化，子类筛选
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) {
			$("#selectA").remove();
		} else {
			var copyThisA = $(this).clone();
		   if ($("#selectA").length > 0) {
				$("#selectA a").html($(this).text()).attr("title",$(this).children("a").attr("title"));
			} else {
				$(".select-result dl").append(copyThisA.attr("id", "selectA"));
			}
		}
		productList();	
		flag=false;
		initPagination();	
	});
	
	$("#select2 dd").click(function () { //品牌筛选
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) { 
			$("#selectB").remove();
		} else {
			var copyThisB = $(this).clone();
			if ($("#selectB").length > 0) {
				$("#selectB a").html($(this).text()).attr("title",$(this).children("a").attr("title"));
			} else {
				$(".select-result dl").append(copyThisB.attr("id", "selectB"));
			}
		}
		productList();	
		flag=false;
		initPagination();	
	});
	
	$("#select3 dd").click(function () { //规格筛选 
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) {
			$("#selectC").remove();
		} else {
			var copyThisC = $(this).clone();
			if ($("#selectC").length > 0) {
				$("#selectC a").html($(this).text()).attr("title",$(this).children("a").attr("title"));
			} else {
				$(".select-result dl").append(copyThisC.attr("id", "selectC"));
			}
		}
		productList();	
		flag=false;
		initPagination();
	});  
	
         }); 
        
	$("#selectB").live("click", function () {
		$(this).remove();
		$("#select2 .select-all").addClass("selected").siblings().removeClass("selected");
	});
	 $("#selectA").live("click", function () {
		$(this).remove();
		
		$("#select1 .select-all").addClass("selected").siblings().removeClass("selected");
	});
	$("#selectC").live("click", function () {
		$(this).remove();
		$("#select3 .select-all").addClass("selected").siblings().removeClass("selected");
	}); 
	function numCheck(node){
	$(node).val($(node).val().replace(/^0/,'').replace(/\D/g,''));
	}
</script>
<style type="text/css">
.input_but_sx {
	padding: 0;
	width: 8px;
	height: 8px;
	font-size: 6px;
	border: none;
	background-color: #fff;
	color: #666;
	background-repeat: no-repeat;
	background-size: cover;
	-moz-background-size: cover;
	-webkit-background-size: cover;
}

.input_txt_sx {
	width: 60px;
	border: none;
	padding-left: 5px;
}

td {
	border: 1px solid #D1D1D1;
}

#anniu {
	height: 20px;
	width: 55px;
	font-size: 12px;
	border-radius: 0px;
}

.div_anniu {
	margin: 5px 0 0 15px;
	float: left;
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
	<%-- <input id="superclass" type="hidden" value="${cateGoryId}">
<input id="subclass" type="hidden" value="${cateGorySunId}"> --%>
	<!--通栏-->
	<div class="warp">
		<div class="detail_left">
			<div class="detail_left_nav">
				<div class="left_nav">
					<c:if test="${empty sessionScope.filtratePage }">
						<div class="all-sort-list">
							<c:forEach items="${productCategorys}" var="proca">
								<c:if test="${proca.parentCateGory == cateGoryId }">
									<div class="item bo">
										<h3>
											<a class="nav_left"
												href="toSecondIndex.do?cateGoryId=${cateGoryId}&cateGorySunId=${proca.id}&cateGoryLevel=2">${proca.cateGoryName}</a>
										</h3>
										<div class="item-list clearfix">
											<!--关闭弹出层小叉叉 <div class="close">x</div> -->
											<div class="subitem">
												<c:forEach items="${productCategorys}" var="pcs">
													<c:if test="${pcs.parentCateGory == proca.id}">
														<dl class="fore1">
															<dt>
																<a
																	href="toSecondIndex.do?cateGoryId=${cateGoryId}&cateGorySunId=${proca.id}&cg3Id=${pcs.id}&cateGoryLevel=3">${pcs.cateGoryName}</a>
															</dt>
															<dd>
																<c:forEach items="${productCategorys}" var="pcItem">
																	<c:if test="${pcItem.parentCateGory == pcs.id }">
																		<em><a
																			href="toSecondIndex.do?cateGoryId=${cateGoryId}&cateGorySunId=${proca.id}&cg3Id=${pcs.id}&cg4Id=${pcItem.id}&cateGoryLevel=4">${pcItem.cateGoryName}</a>
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
					</c:if>
					<c:if test="${! empty sessionScope.filtratePage }">
						<div class="all-sort-list">
							<c:forEach items="${productCategorys2}" var="proca"
								varStatus="status1">
								<%-- ${proca.parentCateGory} --%>
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
											<div class="subitem"></div>
										</div>
									</div>
								</c:if>
							</c:forEach>

						</div>
					</c:if>

				</div>
			</div>

			<!--  热销商品推荐 -->
			<div class="hot">
				<span class="scan">热销商品</span>
				<!--  <span class="more">>>更多</span> -->
				<div class="goods_list">
					<c:forEach items="${hotProducts}" var="pros" varStatus="status1">
						<c:if test="${status1.count<=10}">
							<dl>
								<dt>
									<b class="b_num"><span class="span_item">${status1.count}</span></b>
									<b class="b_img"> <a
										href="toProductInfo.do?ProductId=${pros.id}"> <img
											height="50" width="50" src="<%=path%>${pros.filePath}" /></a>
									</b>
								</dt>
								<dd>
									<a href="toProductInfo.do?ProductId=${pros.id}">${pros.productName}</a><b></b>
								</dd>
							</dl>
							<!-- 华丽的分割线 -->
							<hr class="hr_hot_line" />
						</c:if>
					</c:forEach>
					<div style="padding-bottom: 10px;"></div>
				</div>
			</div>

			<!--  最近浏览 -->
			<div class="recvisit">
				<span class="scan">最近浏览</span>
				<!-- <span class="more">>>更多</span> -->
				<div class="goods_list">
					<c:forEach items="${viewProducts}" var="pros" varStatus="status1">
						<dl>
							<dt>
								<a href="toProductInfo.do?ProductId=${pros.id}"> <b
									class="b_img"> <c:if test="${pros.productPics!=null}">
											<c:forEach items="${pros.productPics}" var="pros2"
												varStatus="status2">
												<c:if test="${status2.count==1}">
													<img height="58" width="58"
														src="<%=path%>${pros2.filePath}" />
												</c:if>
											</c:forEach>
										</c:if> <%-- <img height="68" width="68"src="<%=path%>${pros.filePath}" /> --%>
								</b>
								</a>
							</dt>
							<dd>
								<a href="toProductInfo.do?ProductId=${pros.id}">${pros.productName}</a><b></b>
							</dd>
						</dl>
						<!-- 华丽的分割线 -->
						<hr class="hr_hot_line" />
					</c:forEach>
					<div style="padding-bottom: 10px;"></div>
				</div>
			</div>


		</div>


		<div class="detail_right">
			<div class="loca2">
				<span class="tit2">全部分类 > <c:forEach
						items="${productCategorys}" var="pro">
						<c:if test="${pro.id == cateGoryId }">${pro.cateGoryName}
							</c:if>
					</c:forEach> <c:if test="${null != cateGorySunId && '' != cateGorySunId }">
					 > <strong><c:forEach items="${productCategorys}"
								var="proca">
								<c:if test="${proca.id == cateGorySunId }">${proca.cateGoryName}
							</c:if>
							</c:forEach>
					</c:if> </strong>
				</span>
			</div>
			<div class="xbt_div">
				<div class="xbt">精品推荐</div>
			</div>

			<div class="zzsc" style="overflow: visible;">
				<c:forEach items="${subpageShows}" var="pros" varStatus="status1">
					<c:if test="${ status1.count <=4}">
						<!-- fn:length(subpageShows) -->
						<div class="case_li"
							style='${ status1.count eq  4 ? "margin-left: 0px; margin-right:0px;" : "margin-right: 25px;" }  overflow:visible; '>
							<div>
								<a href="toProductInfo.do?ProductId=${pros.id}"> <!--   -->
									<img width="170" height="165" src="<%=path%>${pros.filePath}" /></a>
								<%--  /ssm/img/167/104.jpg  --%>

								<%-- 灰色半透明遮罩层<div class="zzcs_li_txt" style="width: 171px; border: 0px;">
									<div class="span_mr_txt"><a href="toProductInfo.do?ProductId=${pros.id}">${pros.productName}</a></div>
								</div> --%>
							</div>
							<%--询价按钮 <div class="span_detail_new">
									<a href="toProductInfo.do?ProductId=${pros.id}" class="button orange medium"> 询价</a>
								</div> --%>
							<div class="span_mr_txt">
								<p>
									<a href="toProductInfo.do?ProductId=${pros.id}">${pros.productName}</a>
								</p>
								<p class="yangs">${pros.productTitle}</p>
								<p style="color: #c4c4c4;">
									已有<span style="color: #0e5380; font-weight: 700;">1376</span>人评价
								</p>
							</div>

							<div class="div_anniu">
								<table cellpadding=0 cellspacing=0>
									<tr>
										<td rowspan="2"><input class="input_txt_sx" type="text"
											id="inps${pros.id}" value="0"
											onkeyup="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
											onafterpaste="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"></td>
										<td><input class="input_but_sx" type="button"
											style="background-image:url(<%=path%>/images/shang.png);"
											onclick="doits(1,${pros.id})" /></td>
									</tr>
									<tr>
										<td><input class="input_but_sx" type="button"
											style="background-image:url(<%=path%>/images/xia.png);"
											onclick="doits(-1,${pros.id})" /></td>
									</tr>
								</table>
							</div>
							<div class="div_anniu">
								<a href="javascript:xunjia(${pros.id},0);"
									class="button orange medium"> 询价</a>
							</div>

						</div>
					</c:if>

				</c:forEach>
			</div>

			<div class="screen">
				<ul class="select">
					<li class="select-result">
						<dl>
							<dt>已选条件：</dt>
						</dl>
					</li>

					<c:forEach items="${productCategorys}" var="proca">
						<c:if test="${proca.parentCateGory == cateGoryId }">
							<% int i=1; %>
							<c:forEach items="${productCategorys}" var="pcs">
								<c:if
									test="${pcs.parentCateGory == proca.id and proca.id==cateGorySunId}">

									<li class="select-list">
										<dl id="select<%=i%>">
											<% i++; %>
											<dt>
												<a title="${pcs.cateGoryName}" href="javascript:void(0);">${pcs.cateGoryName}</a>
											</dt>
											<dd class="select-all selected">
												<a title="" href="javascript:void(0);">全部</a>
											</dd>

											<c:forEach items="${productCategorys}" var="pcItem">
												<c:if test="${pcItem.parentCateGory == pcs.id }">
													<dd>
														<a href="javascript:void(0);" title="${pcItem.id}">${pcItem.cateGoryName}</a>
													</dd>
												</c:if>
											</c:forEach>
										</dl>
									</li>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<!-- 筛选商品展示 -->
			<div id="search">
				<!--  id 为 search -->
				<!--  测试数据；-->

				<!--  测试数据； end..-->

				<%-- <c:forEach items="${searchProducts}" var="pros">
					<div class="case_li" style="float:left">
					
					<a href="toProductInfo.do?ProductId=${pros.id}">
						<img width="170" height="165" src="<%=path%>${pros.filePath}" /></a>
						<div class="case_li_txt">
							<div class="span_mr_txt"><a href="toProductInfo.do?ProductId=${pros.id}">${pros.productName}</a></div>
						</div>
						
						<div class="span_detail">
								<a href="toProductInfo.do?ProductId=${pros.id}" class="button orange medium"> 询价</a>
							</div>
					</div>
				</c:forEach> --%>
			</div>
			<!-- 分页 -->
			<div class="pagin" style="clear: left">
				<!-- 			<div class="meneame" style="float: left;" >
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
				<div id="Pagination" class="meneame" style="clear: left"></div>
			</div>
			<%-- <div class="pagin" style="clear:both">
    	   		<div class="message">共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页</div>
        			<ul class="paginList">
        		<c:choose>
                		<c:when test="${page.currentPage==1}">
                		 <li class="paginItem current"><a href="#"><span class="pagepre"></span></a></li>
                		</c:when>
                		<c:otherwise>
                		 <li class="paginItem"><a href="toSecondIndex.do?currentPage=${page.currentPage-1}&&cateGoryId=${cateGoryId}"><span class="pagepre"></span></a></li>
                		</c:otherwise>
                </c:choose>
        		<c:forEach begin="1" end="${page.totalPage}" var="s3">
        		
					 	<c:choose>
                    		<c:when test="${s3==page.currentPage}">
                    		 <li class="paginItem current"><a href="#">${s3}</a></li>
                    		</c:when>
                    		<c:otherwise>
                    		<li class="paginItem"><a href="toSecondIndex.do?currentPage=${s3}&&cateGoryId=${cateGoryId}">${s3}</a></li>
                    		</c:otherwise>
                    	</c:choose>
				</c:forEach>
				<c:choose>
                		<c:when test="${page.currentPage==page.totalPage or s3<=10}">
                		 <li class="paginItem current"><a href="#"><span class="pagenxt"></span></a></li>
                		</c:when>
                		<c:otherwise>
                		 <li class="paginItem"><a href="toSecondIndex.do?currentPage=${page.currentPage+1}cateGoryId=${cateGoryId}"><span class="pagenxt"></span></a></li>
                		</c:otherwise>
                </c:choose>    
        </ul>
   			 </div> --%>
		</div>

	</div>
	<%-- <script type="text/javascript" src="<%=path%>/js/redjs/script.js"></script> --%>
	<script type="text/javascript">
		$(".all-sort-list > .item").hover(
				function() {
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

					$(this).addClass('hover');
					$(this).children('.item-list').css('display', 'block');
				}, function() {
					$(this).find(".nav_left_con").find("em").animate({
						margin : '0px 10px 0px -30px'
					}, 238);
					$(this).removeClass('hover');
					$(this).children('.item-list').css('display', 'none');
				});
		//begin  搜索商品品类菜单展现
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
		//end
	</script>
</body>
</html>
