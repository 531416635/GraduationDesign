 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"	
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String page1=(String)session.getAttribute("productPage1");
	String page2=(String)session.getAttribute("productPage2");
	String show=(String)request.getAttribute("show");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<%-- <script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script> --%>
<script type="text/javascript">
	var saveAll = function(show, status) {
		ChangeAllStatus(getIds(show), status, show);
	};
	var delAll = function(show) {
		if (window.confirm("确定删除所选商品吗？")) {
			ChangeAllStatus(getIds(show), 2, show);
		}
	};
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
		if ($("#checkAll" + index).attr("checked")) {
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

	function ChangeAllStatus(ids, status, show) {
		/* 		alert(ids);
		 alert(status); */
		 if(ids!=""){
		 $.ajax({
			type : "POST",
			url : "editCompanyProductsStatus.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				"ids" : ids,
				"status" : status
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
				location.href = "toProductEdit3.do?show=" + show;
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
		 }else{
		 alert("请选择有效数据进行此操作！");
		 }
		
	}

	var delCompanyProduct = function(id, show) {
		ChangeAllStatus(id, 2, show);
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
		location.href="/ssm/merchant/toProductEdit3.do?currentPage1="+(page_index+1)+"&&show=1";
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
		location.href="/ssm/merchant/toProductEdit3.do?currentPage2="+(page_index+1)+"&&show=2";
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});	
</script>
<style type="text/css">
#qr {
	/* background-color: orange; */
	height: 25px;
	width: 100px;
	margin-left: 40%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}
table{
	margin-bottom: 20px;
}
td{
	text-align: center;
}
th{
	background-color: #e5e5e5;
	border: 1px solid #999;
}
tr{
	border: 0.5px solid #999;
}
img{
	margin-top: 3px;
}
.pagin {
	position: relative;
	margin-top: 10px;
	padding: 0 12px;
}

.pagin .blue {
	color: #056dae;
	font-style: normal;
}

.pagin .paginList {
	margin: 10px;
	right: 12px;
	top: 0;
}

.pagin .paginList .paginItem {
	float: left;
}

.pagin .paginList .paginItem a {
	float: left;
	width: 31px;
	height: 28px;
	border: 1px solid #DDD;
	text-align: center;
	line-height: 30px;
	border-left: none;
	color: #3399d5;
}

.pagin .paginList .paginItem:first-child a {
	border-left: 1px solid #DDD;
}

.pagin .paginList .paginItem:first-child a {
	border-bottom-left-radius: 5px;
	border-top-left-radius: 5px;
}

.pagin .paginList .paginItem:last-child a {
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
}

.pagin .paginList .paginItem.current,.pagin .paginList .paginItem.current a
	{
	background: #f5f5f5;
	cursor: default;
	color: #737373;
}

.pagin .paginList .paginItem:hover {
	background: #f5f5f5;
}

.pagin .paginList .paginItem.more,.pagin .paginList .paginItem.more a:hover
	{
	cursor: default;
}

.pagin .paginList .paginItem.more:hover {
	background: #FFF;
}

.pagin .paginList .paginItem.more a {
	color: #737373;
}

.pagepre {
	background: url(../images/pre.gif) no-repeat center center;
	width: 31px;
	height: 28px;
}

.pagenxt {
	background: url(../images/next.gif) no-repeat center center;
	width: 31px;
	height: 28px;
}
</style>
</head>
<body>
	<div class="inner_div">
			<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2"> 商品管理 ></span><span class="lo2"> 商品上货</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab1">出售中商品</a>
				</li>
				<li><a href="#" title="tab2">已下架商品</a>
				</li>

			</ul>
			<div id="content">
				<div id="tab1">
					<table style="width: 100%">
						<thead>
							<tr>
								<th style="width:5%"><input name="" id="checkAll1"
									type="checkbox" onclick="checkAll(1);" />全选</th>
								<th width="120">宝贝名称</th>
								<th width="200">商品编码</th>
								<th width="100">生产日期</th>
								<th width="150">发布时间</th>
								<th width="100">备注</th>
								<th width="100">操作</th>
						
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${productLists1}" var="temp">
								<tr>
									<td><input type="checkbox" name="box1"
										onclick="checkBox(1);" value="${temp.ID}" />
									</td>
									<td><img src="<%=path%>/${temp.FilePath}" width="55" height="50" /><br/>品名：${temp.ProductName}<br /><%-- 商品编号:${temp.CompanyProductCode}
										&nbsp;&nbsp;&nbsp;&nbsp; 规格：${temp.CateGoryName} --%></td>
										<td>${temp.CompanyProductCode}</td>
									<td>${temp.ProductDate}</td>
									<td align="center"><fmt:formatDate
											value="${temp.RequestTime}" pattern="yyyy-MM-dd" /></td>
											<td>${temp.ProductRemark} </td>
											<td><a class="tablelink"  href="/ssm/merchant/toEditCompanyProducts.do?id=${temp.ID}">商品编辑</a> </td>
									<%-- <td><a href="#${temp.id}"
										onclick="delCompanyProduct('${temp.ID}',1)">商品删除 </a></td>  --%>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<input type="button" class="orange" value="批量下架" id="qr" onclick="saveAll(1,0)" />
					<!-- <input type="button" value="批量删除" id="qr" onclick="delAll(1)" /> -->
				</div>

				<div id="tab2">
					<table style="width: 100%">
						<thead>
							<tr>
								<th style="width:5%"><input name="" id="checkAll2"
									type="checkbox" onclick="checkAll(2);" />全选</th>
								<th width="160">宝贝名称</th>
								<th width="200">商品编码</th>
								<th width="100">生产日期</th>
								<th width="300">发布时间</th>
								<th width="100">备注</th>
								<th width="100">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${productLists2}" var="temp">
								<tr>
									<td><input type="checkbox" name="box2"
										onclick="checkBox(2);" value="${temp.ID}" />
									</td>
									<td><img src="<%=path%>/${temp.FilePath}" width="55" height="50" /><br/>品名：${temp.ProductName}<br /><%-- 商品编号:${temp.CompanyProductCode}
										&nbsp;&nbsp;&nbsp;&nbsp; 规格：${temp.CateGoryName}</td> --%>
											<td>${temp.CompanyProductCode}</td>
									<td>${temp.ProductDate}</td>
									<td align="center"><fmt:formatDate
											value="${temp.RequestTime}" pattern="yyyy-MM-dd" /></td>
												<td>${temp.ProductRemark} </td>
									 <td><a class="tablelink"  href="/ssm/merchant/toEditCompanyProducts.do?id=${temp.ID}">商品编辑</a> </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<input type="button" class="orange" value="批量上架" id="qr" onclick="saveAll(2,1)" />
					<!-- <input type="button" value="批量删除" id="qr" onclick="delAll(2)" /> -->
				</div>

			</div>
			 <div id="page">
			 <!-- 分页1 -->
			<div id="pagin1" class="pagin">
			<!-- <div class="message">
				共<i id="rows1" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage1" class="blue"></i>页
			</div> -->
			<div id="Pagination1" class="meneame" style="clear:left"></div> 	
			</div>
			<!-- 分页2 -->
			<div id="pagin2" class="pagin">
			<!-- <div class="message">
				共<i id="rows2" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage2" class="blue"></i>页
			</div> -->
			<div id="Pagination2" class="meneame" style="clear:left"></div> 	
			</div>
			<!-- <div id="Pagination1" class="meneame" style="clear:left"></div> 
			<div id="Pagination2" class="meneame" style="clear:left"></div> -->
				<%-- <div id="page1" class="pagin">
					<div class="message">
						共有上架宝贝<i class="blue">${page1.rows}</i>条记录，当前显示第&nbsp;<i
							class="blue">${page1.currentPage}&nbsp;</i>页
					</div>
					<ul class="paginList">
						<c:choose>
							<c:when test="${page1.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/toProductEdit3.do?currentPage1=${page1.currentPage-1}&&show=1"><span
										class="pagepre"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${page1.totalPage}" var="s3">
							<c:choose>
								<c:when test="${s3==page1.currentPage}">
									<li class="paginItem current"><a href="#">${s3}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/ssm/merchant/toProductEdit3.do?currentPage1=${s3}&&show=1">${s3}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${page1.currentPage==page1.totalPage or s3<=10}">
								<li class="paginItem current"><a href="#"><span
										class="pagenxt"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/toProductEdit3.do?currentPage1=${page1.currentPage+1}&&show=1"><span
										class="pagenxt"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div id="page2" class="pagin">
					<div class="message">
						共有下架宝贝<i class="blue">${page2.rows}</i>条记录，当前显示第&nbsp;<i
							class="blue">${page2.currentPage}&nbsp;</i>页
					</div>
					<ul class="paginList">
						<c:choose>
							<c:when test="${page2.currentPage==1}">
								<li class="paginItem current"><a href="#"><span
										class="pagepre"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem"><a
									href="/ssm/merchant/toProductEdit3.do?currentPage2=${page2.currentPage-1}&&show=2"><span
										class="pagepre"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${page2.totalPage}" var="s3">
							<c:choose>
								<c:when test="${s3==page2.currentPage}">
									<li class="paginItem current"><a href="#">${s3}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="paginItem"><a
										href="/ssm/merchant/toProductEdit3.do?currentPage2=${s3}&&show=2">${s3}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${page2.currentPage==page2.totalPage or s3<=10}">
								<li class="paginItem current"><a href="#"><span
										class="pagenxt"></span> </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="paginItem">&lt;<a
									href="/ssm/merchant/toProductEdit3.do?currentPage2=${page2.currentPage+1}&&show=2"><span
										class="pagenxt"></span> </a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div> --%>
			</div>
		</div>
	</div>
		
	<!-- <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script> -->
	<script type="text/javascript">
		$(document).ready(function() {
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
				var tmp=$(this).attr('title');
				var page="#pagin" +tmp.replace("tab","");
				$(page).show();
			});
		});
	</script>
</body>
</html>
