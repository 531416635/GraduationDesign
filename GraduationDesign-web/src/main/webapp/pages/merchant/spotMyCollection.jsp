<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	String page1=(String)request.getAttribute("collectionPage1");
	String page2=(String)request.getAttribute("collectionPage2");
	String show=(String)request.getAttribute("show");
	String jsonAddrs = (String) request.getAttribute("jsonAddrs");
	
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<%-- <script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script> --%>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript" src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/frontcss/public.css" />
<link type="text/css" rel="stylesheet"
	href="<%=path%>/css/redcss/selector4.css" />
<style type="text/css">
#ss {
	margin-left: 50%;
}
td{
    text-align: center;
}
</style>
<script type="text/javascript">
	var getIds = function(index) {
		var ids = "";
		$("input[name=box" + index + "]:checked").each(function() {
			ids += $(this).val() + ",";
		});
		return ids.substring(0, ids.length - 1);
	};

	function checkBox(box) {
		var checkObjs1 = $("input[name=box" + box + "]:checked");
		var checkObjs2 = $("input[name=box" + box + "]");
		if (checkObjs1.length == checkObjs2.length) {
			$("#checkAll" + box).attr("checked", true);
		} else {
			$("#checkAll" + box).attr("checked", false);
		}
	}

	function checkAll(index) {
	var ischecked = document.getElementById("checkAll"+index).checked;
		if (ischecked) {
			checkallbox(index);
		} else {
			discheckallbox(index);
		}
	}

	function checkallbox(index) {
		var boxarray = document.getElementsByName("box" + index);
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = true;
		}
	}
	function discheckallbox(index) {
		var boxarray = document.getElementsByName("box" + index);
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = false;
		}
	}

	function delFavorite() {
		var ids = getIds(1);
		if (ids == "" || ids == null) {
			alert("请选择需要删除的项!");
			return;
		}
		$.ajax({
			type : "POST",
			url : "DelFavorite.do",
			dataType : "text",
			data : {
				"ids" : ids
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

	function ChangeAllIsDefault(ids, isDefault, show) {
		/* 		alert(ids);
		 alert(status); */
		//明天当个模块的全选以及返回当前操作模块！！！	
		$.ajax({
			type : "POST",
			url : "editSuppliersIsDefault.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				"ids" : ids,
				"isDefault" : isDefault
			},
			success : function(data) {
				//alert(data);
				if (data == "1") {
					alert("操作成功！");
				} else if (data == "2") {
					location.href = "toLogin.do";
				} else {
					alert("操作失败");
				}
				location.href = "myCollection.do?show=" + show;
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}
	function ChangeAllIsLock(ids, isLock, show) {
		/* 		alert(ids);
		 alert(status); */
		//明天当个模块的全选以及返回当前操作模块！！！	
		$.ajax({
			type : "POST",
			url : "editSuppliersIsLock.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				"ids" : ids,
				"isLock" : isLock
			},
			success : function(data) {
				//alert(data);
				if (data == "1") {
					alert("操作成功！");
				} else if (data == "2") {
					location.href = "toLogin.do";
				} else {
					alert("操作失败");
				}
				location.href = "myCollection.do?show=" + show;
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}
	function delSuppliers(ids, show) {
	/* 			alert(ids);
		 alert(show); */
		//明天当个模块的全选以及返回当前操作模块！！！	
		$.ajax({
			type : "POST",
			url : "delSuppliers.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				"ids" : ids
			},
			success : function(data) {
				//alert(data);
				if (data == "1") {
					alert("操作成功！");
				} else if (data == "2") {
					location.href = "toLogin.do";
				} else {
					alert("操作失败");
				}
				location.href = "myCollection.do?show=" + show;
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}
	//Isdefault,Islock,
	var editIsdefault = function(show, Isdefault,ids) {
		ChangeAllIsDefault(ids, Isdefault, show);
	};
	var editIslock = function(show, Islock,ids) {
		ChangeAllIsLock(ids, Islock, show);
	};
	var delAll = function(show) {
		if (window.confirm("确定删除所选项吗？")) {
			delSuppliers(getIds(show), show);
		}
	};
	 $(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=page1%>);
	  	$("#rows1").html(json.rows);
	  	$("#currentPage1").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination1").pagination(json.rows, { // 创建分页按钮
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
		location.href="/ssm/merchant/myCollection.do?favoriteType=2&&currentPage1="+(page_index+1)+"&&show=1";
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=page2%>);
	  	$("#rows2").html(json.rows);
	  	$("#currentPage2").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination2").pagination(json.rows, { // 创建分页按钮
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
		location.href="/ssm/merchant/myCollection.do?favoriteType=2&&currentPage2="+(page_index+1)+"&&show=2";
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	
	var AddInquirySheet = function(productId,id) {
	var buyNum=$("#buyNum"+productId).val();
	var address=$("#addressShopping"+id).val();
	if(buyNum!=null&&buyNum!=""){
		$.ajax({
			type : "POST",
			url : "<%=path%>/web/AddInquirySheet.do",
			dataType : "text",
			data : {
				"productId" : productId,
				"buyNum":buyNum,
				"address":address
			},
			success : function(data) {			
				var json =eval('(' + data + ')');
				//alert(data);
				if (json.result == "true") {
				//跳转
				//alert(json.inquiryId);
			   if(json.inquiryId=='null')
				{
					alert("暂时不能询价，请联系管理员");
				   // window.location.href= "<%=path%>/web/toLogin.do";			
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
		}else{
		alert("请输入合适的数量");
		}
	};
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
</script>
<style type="text/css">
#th1{
	width:50px;
}
#th2{
	width:250px;
}
.divHead{
background-color:#F5F5F5;
height:50px;
border:2px solid #DFDFDF;
margin-bottom:10px;
}
#tabs{
   list-style: outside none none;
    margin: 0px;
    overflow: hidden;
    padding: 0;
    width: 100%;
   
}
.location{
margin-bottom:10px;
}
tr{
border-bottom:1px solid #999999;
}
td {
	text-align: center;
	height: 100px;
}
.gray{
	background-color:#f4f4f4;
    border: medium none;
    border-radius: 3px;
    color: #b5b5b5;
    font-size: 14px;
    height: 30px;
    width: 120px;
    padding:1px 12px;
    border:1px solid #e2e3e4;

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
			<hr style="color: red;border: 1px solid;" />
			<div style="border:2px solid #F5F5F5;border-top:0px;height:25px;padding:10px;"><span style="font-size:18px;"><b>现货收藏</b></span><br />
			</div>
		</div> --%>
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">商品管理 ></span><span class="lo2">现货收藏</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li><a href="<%=path %>/merchant/myCollection.do?favoriteType=2" title="tab1" style="background:#9a1101 none repeat scroll 0 0;color:#fff;">现货收藏</a></li>
				<li><a href="<%=path %>/merchant/myCollection.do?favoriteType=1" title="tab2">商品收藏</a></li>
			</ul>
			<div id="content">
				<div id="tab1">
					<input style="width: 80px; height: 30px; margin-bottom: 3px;" type="button" class="orange" value="删除所选项" onclick="delFavorite()" />
					<table width="100%"  cellspacing="0">
						<thead >
							<tr>
								<th style="width: 40px;"><input name="" id="checkAll1" type="checkbox"
									onclick="checkAll(1);" />全选</th>
								<th>商品图片</th>
								<th>商品名称</th>
								<th id="th1">数量</th>
								<th  id="th2">地址</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="c">
								<tr>
									<td><input type="checkbox" name="box1" value="${c.ID}"
										onclick="checkBox(1);" />
									</td>
									<td><img title="商品图片" src="<%=path%>${c.FilePath}"
										style="height: 50px;width: 55px;margin-left: 20px;" />
									</td>
									<td>${c.ProductName}</td>
									<td><input style="width:80px;height:20px;" id="buyNum${c.ProductID}"
										name="buyNum${c.ProductID}"
										onkeyup="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
										onafterpaste="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')" />
									</td>
									<td><span
										style="border:1px solid #ABADB3;background-color:#FFFFFF;padding:3px;"
										onclick="shoppingAddressClick('${c.ID}')"
										id="shoppingCart1Id${c.ID}">${c.FavoriteAddressName}<img src="<%=path %>/images/redimg/btn20121210.png"/></span>
										<p style="display:none;" id="address${c.ID}"
											name="address${c.ID}">${c.FavoriteAddressNameJson}</p> <input
										type="hidden" id="addressShopping${c.ID}" value=""
										name="addressShopping${c.ID}" /></td>
									<td><c:if test="${c.ProductType==1  }">
											<span style="text-align:center;padding:5px 10px;"
												class="orange"> <c:if test="${c.IsHotShow==1  }">热卖中</c:if>
												<c:if test="${c.IsHotShow!=1  }">有&nbsp;&nbsp;货</c:if> </span>
										</c:if> <c:if test="${c.ProductType!=1  }">
											<span style="text-align:center;padding:5px 10px;"
												class="gray">已下架</span>
										</c:if>
									</td>
									<td>
									<c:if test="${c.ProductType==1  }">
									 <a href="javascript:AddInquirySheet('${c.ProductID}','${c.ID}');">我要询价</a>
									</c:if>
									<c:if test="${c.ProductType!=1  }">我要询价</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<%-- <div id="tab2">
					<input type="button" value="删除" onclick="delAll(2)" /> |<input
						type="text" id="ss" placeholder="&nbsp;输入搜索的商品" />
					<table width="100%" border="1" cellspacing="0" align="center">
						<thead>
							<tr>
								<th><input name="" id="checkAll2" type="checkbox"
									onclick="checkAll(2);" />全选</th>
								<th>供应商名称</th>
								<th>供应商供应商品</th>
								<th>是否默认</th>
								<th>是否锁定</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list2}" var="c">
								<tr>
									<td><input type="checkbox" name="box2" value="${c.ID}"
										onclick="checkBox(2);" /></td>
									<td>${c.SellCompanyName}</td>
									<td><img src="${c.FilePath}" width="40" height="40" />${c.ProductName}</td>
									<td><c:if test="${c.IsDefault==1}">是  
									<input	type="button" value="取消默认" onclick="editIsdefault(2,0,${c.ID})" /> </c:if>
									<c:if test="${c.IsDefault==0}">否 
									<input type="button" value="设为默认" onclick="editIsdefault(2,1,${c.ID})" />
									</c:if>									
									</td>
									<td><c:if test="${c.IsLock==1}">是 
									<input	type="button" value="取消锁定" onclick="editIslock(2,0,${c.ID})" /></c:if>
									<c:if test="${c.IsLock==0}">否
									<input	type="button" value="锁定" onclick="editIslock(2,1,${c.ID})" /> 
									</c:if>									
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div> --%>

			</div>
			<div id="page">
			<!-- 分页1 -->
			<div id="pagin1" class="pagin">
			<!-- <div class="message">
				共<i id="rows1" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage1" class="blue"></i>页
			</div> -->
			<div id="Pagination1" class="meneame" style="clear:left"></div> 	
			</div>
			<!-- 分页2
			<div id="pagin2" class="pagin">
			<div class="message">
				共<i id="rows2" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage2" class="blue"></i>页
			</div>
			<div id="Pagination2" class="meneame" style="clear:left"></div> 	
			</div> -->
			<!-- <div id="Pagination1" class="meneame" style="clear:left"></div> 
			分页
			<div id="Pagination2" class="meneame" style="clear:left"></div> -->
				<%-- <div id="page1" class="pagin">
					<div class="message">
						共有<i class="blue">${page1.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page1.currentPage}&nbsp;</i>页
					</div>
					<ul class="paginList">
						<c:choose>
							<c:when test="${page1.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a></li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myCollection.do?currentPage=${page1.currentPage-1}&&show=1"><span
										class="pagepre"></span> </a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${page1.totalPage}" var="s3">
							<c:choose>
								<c:when test="${s3==page1.currentPage}">
									<li class="paginItem current"><a href="#">${s3}</a></li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/ssm/merchant/myCollection.do?currentPage=${s3}&&show=1">${s3}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${page1.currentPage==page1.totalPage or s3<=10}">
								<li class="paginItem current"><a href="#"><span
										class="pagenxt"></span> </a></li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myCollection.do?currentPage=${page1.currentPage+1}&&show=1"><span
										class="pagenxt"></span> </a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div id="page2" class="pagin">
					<div class="message">
						共有<i class="blue">${page2.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page2.currentPage}&nbsp;</i>页
					</div>
					<ul class="paginList">
						<c:choose>
							<c:when test="${page2.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a></li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myCollection.do?currentPage=${page2.currentPage-1}&&show=2"><span
										class="pagepre"></span> </a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${page2.totalPage}" var="s3">
							<c:choose>
								<c:when test="${s3==page2.currentPage}">
									<li class="paginItem current"><a href="#">${s3}</a></li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/ssm/merchant/myCollection.do?currentPage=${s3}&&show=2">${s3}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${page2.currentPage==page2.totalPage or s3<=10}">
								<li class="paginItem current"><a href="#"><span
										class="pagenxt"></span> </a></li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/myCollection.do?currentPage=${page2.currentPage+1}&&show=2"><span
										class="pagenxt"></span> </a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div> --%>
			</div>
		</div>
	</div>

	<script>
		/* $(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			//$("#page div").hide(); 
			if ("${show}" == "1" || "${show}" == "") {
				$("#tabs li:first").attr("id", "current"); // Activate first tab
				$("#tabs li:last").attr("id", ""); // Activate first tab
				$("#content div:first").fadeIn(); // Show first tab content	
				$("#pagin1").show();
				$("#pagin2").hide();
			} else {
				$("#tabs li:last").attr("id", "current"); // Activate first tab
				$("#tabs li:first").attr("id", ""); // Activate first tab
				$("#content div:last").fadeIn(); // Show first tab content
				$("#pagin1").hide();
				$("#pagin2").show();
			}

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide();
				$("#tabs li").attr("id", "");
				$(this).parent().attr("id", "current");
				$('#' + $(this).attr('title')).fadeIn();
				$("#pagin1").hide();
				$("#pagin2").hide();
				var tmp = $(this).attr('title');
				//alert(tmp.replace("tab",""));
				var page = "#pagin" + tmp.replace("tab", "");
				//alert(page);
				$(page).show();
			});
		})(); */
	</script>
</body>
</html>
