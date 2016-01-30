<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	String page1=(String)request.getAttribute("newsPage");
	String page2=(String)request.getAttribute("noticePage");
    String page3=(String)request.getAttribute("industryNewsPage");

 %>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />

<script type="text/javascript">
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
			callback: pageselectCallback1,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback1(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		
		$.ajax({
		dataType:"text",
		type: "POST",
		async: false,
		url:"findNewsList.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data:{
		currentPage1:page_index+1
		},
		success:function(data){   
		if(data=="false"){
		alert("加载失败");
		}else{
		var json = eval('('+data+')');
		$("#xinwen1").html("");
		var content = '';
		for(var i=0;i<json.newsList.length;i++){
		content+='<li><span style="float: left;">'
					+'<a href="newOrNoiceInfo.do?newOrNoticeId='+json.newsList[i].id+'&&type=1">'+json.newsList[i].title+'</a>'
				    +'</span><span style="float:right;">'+json.newsList[i].releaseTime.time+'</span></li>';	    
					}
		$("#xinwen1").html(content);
		}		
		}		
		});		
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
			callback: pageselectCallback2,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback2(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		$.ajax({
		dataType:"text",
		type:"POST",
		async:false,
		url:"findNoticeList.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data:{
		currentPage2:page_index+1
		},
		success:function(data){
		if(data=="false"){
		alert("加载失败");
		}else{
		var json=eval('('+data+')');
		$("#xinwen2").html("");
		var content = '';
		for(var i=0;i<json.noticeList.length;i++){
		content+='<li><span style="float: left;">'
					 +' <a href="newOrNoiceInfo.do?newOrNoticeId='+json.noticeList[i].id+'&&type=2">'+json.noticeList[i].title+'</a>'
					 +' </span><span style="float:right;">'+json.noticeList[i].releaseTime.time+'</span></li>';
					}
		$("#xinwen2").html(content);
		}
		}
		});
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=page3%>);
	  	$("#rows3").html(json.rows);
	  	$("#currentPage3").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination3").pagination(json.rows, { // 创建分页按钮
			current_page: json.currentPage-1,
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback3,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback3(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		$.ajax({
		dataType:"text",
		type:"POST",
		async:false,
		url:"industryNewsList.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data:{
		currentPage3:page_index+1
		},
		success:function(data){
		if(data=="false"){
		alert("加载失败");
		}else{
		var json=eval('('+data+')');
		$("#xinwen3").html("");
		var content = '';
		for(var i=0;i<json.industryNewsList.length;i++){
		content+='<li><span style="float: left;">'
					 +' <a href="newOrNoiceInfo.do?newOrNoticeId='+json.industryNewsList[i].id+'&&type=2">'+json.industryNewsList[i].title+'</a>'
					 +' </span><span style="float:right;">'+json.industryNewsList[i].releaseTime.time+'</span></li>';
					}
		$("#xinwen3").html(content);
		}
		}
		});
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});	
	
	
	function search(title,newType){
		$.ajax({
			dataType:"text",
			type:"POST",
			url:"<%=path%>/news/searchNewsInfo.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data:{
			title:title,
			newType:newType
			},
			success:function(data){
				var json =eval('(' + data + ')');
				switch (newType) {
				//alert("2");
				case 1:
					$("#xinwen1").html("");
					var content = '';
					for(var i=0;i<json.newsList.length;i++){
					content+='<li><span style="float: left;">'
					+'<a href="newOrNoiceInfo.do?newOrNoticeId='+json.newsList[i].id+'&&type=1">'+json.newsList[i].title+'</a>'
				    +'</span><span style="float:right;">'+dateJoin(json.newsList[i].releaseTime.time)+'</span></li>';	    
					}
					$("#xinwen1").html(content);
					$("#Pagination1").html("");
					$(function(){
	 				var flag = false;
					var initPagination = function() { //此函数为分页动态按钮展现
				 	$("#Pagination1").pagination(json.newsPage.rows, { // 创建分页按钮
						current_page: json.newsPage.currentPage-1,
						num_edge_entries: 3, //边缘页数
						num_display_entries: 3, //主体页数
						callback: pageselectCallback1,
						items_per_page: json.newsPage.pageNum, //每页显示1项
						prev_text: "上一页",
						next_text: "下一页"
						}); 
					};
					function pageselectCallback1(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		
		$.ajax({
		dataType:"text",
		type: "POST",
		async: false,
		url:"findNewsList.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data:{
		currentPage1:page_index+1
		},
		success:function(data){   
		if(data=="false"){
		alert("加载失败");
		}else{
		var json = eval('('+data+')');
		$("#xinwen1").html("");
		var content = '';
		for(var i=0;i<json.newsList.length;i++){
		content+='<li><span style="float: left;">'
					+'<a href="newOrNoiceInfo.do?newOrNoticeId='+json.newsList[i].id+'&&type=1">'+json.newsList[i].title+'</a>'
				    +'</span><span style="float:right;">'+json.newsList[i].releaseTime.time+'</span></li>';	    
					}
		$("#xinwen1").html(content);
		}		
		}		
		});		
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
					break;
				case 2:
					$("#xinwen2").html("");
					var content = '';
					for(var i=0;i<json.noticeList.length;i++){
					content+='<li><span style="float: left;">'
					 +' <a href="newOrNoiceInfo.do?newOrNoticeId='+json.noticeList[i].id+'&&type=2">'+json.noticeList[i].title+'</a>'
					 +' </span><span style="float:right;">'+dateJoin(json.noticeList[i].releaseTime.time)+'</span></li>';
					}
					$("#xinwen2").html(content);
					$("#Pagination2").html("");
					$(function(){
	 				var flag = false;
					var initPagination = function() { //此函数为分页动态按钮展现
				 	$("#Pagination2").pagination(json.noticePage.rows, { // 创建分页按钮
						current_page: json.noticePage.currentPage-1,
						num_edge_entries: 3, //边缘页数
						num_display_entries: 3, //主体页数
						callback: pageselectCallback2,
						items_per_page: json.noticePage.pageNum, //每页显示1项
						prev_text: "上一页",
						next_text: "下一页"
					}); 
					};
					function pageselectCallback2(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		$.ajax({
		dataType:"text",
		type:"POST",
		async:false,
		url:"findNoticeList.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data:{
		currentPage2:page_index+1
		},
		success:function(data){
		if(data=="false"){
		alert("加载失败");
		}else{
		var json=eval('('+data+')');
		$("#xinwen2").html("");
		var content = '';
		for(var i=0;i<json.noticeList.length;i++){
		content+='<li><span style="float: left;">'
					 +' <a href="newOrNoiceInfo.do?newOrNoticeId='+json.noticeList[i].id+'&&type=2">'+json.noticeList[i].title+'</a>'
					 +' </span><span style="float:right;">'+json.noticeList[i].releaseTime.time+'</span></li>';
					}
		$("#xinwen2").html(content);
		}
		}
		});
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
					break;
				case 3:
					$("#xinwen3").html("");
					var content = '';
					for(var i=0;i<json.industryNewsList.length;i++){
					content+='<li><span style="float: left;">'
					 +' <a href="newOrNoiceInfo.do?newOrNoticeId='+json.industryNewsList[i].id+'&&type=2">'+json.industryNewsList[i].title+'</a>'
					 +' </span><span style="float:right;">'+dateJoin(json.industryNewsList[i].releaseTime.time)+'</span></li>';
					}
					$("#xinwen3").html(content);
					$("#Pagination3").html("");
					$(function(){
	 				var flag = false; 
					var initPagination = function() { //此函数为分页动态按钮展现
				 	$("#Pagination3").pagination(json.industryNewsPage.rows, { // 创建分页按钮
						current_page: json.industryNewsPage.currentPage-1,
						num_edge_entries: 3, //边缘页数
						num_display_entries: 3, //主体页数
						callback: pageselectCallback3,
						items_per_page: json.industryNewsPage.pageNum, //每页显示1项
						prev_text: "上一页",
						next_text: "下一页"
					}); 
					};
					function pageselectCallback3(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		$.ajax({
		dataType:"text",
		type:"POST",
		async:false,
		url:"industryNewsList.do",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data:{
		currentPage3:page_index+1
		},
		success:function(data){
		if(data=="false"){
		alert("加载失败");
		}else{
		var json=eval('('+data+')');
		$("#xinwen3").html("");
		var content = '';
		for(var i=0;i<json.industryNewsList.length;i++){
		content+='<li><span style="float: left;">'
					 +' <a href="newOrNoiceInfo.do?newOrNoticeId='+json.industryNewsList[i].id+'&&type=2">'+json.industryNewsList[i].title+'</a>'
					 +' </span><span style="float:right;">'+json.industryNewsList[i].releaseTime.time+'</span></li>';
					}
		$("#xinwen3").html(content);
		}
		}
		});
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});	
					break;
				}
			}
		});
	}
	
	//-----------毫秒数转换为时间格式
	function dateJoin(time){
     var date=new Date(time); 
		var times="";     
		times+=date.getFullYear()+"-";     
		times+=(date.getMonth()+1)+"-";     
		times+=date.getDate()+" "; 
		return times;
     }	
</script>
<style type="text/css">
body {
	text-align: center;
}

h1 {
	font-size: 200%;
}

h3 {
	margin-top: 20px;
}

a {
	color: #666;
}

.newsList, .noticeList, .industryNewsList {
	width: 1128px;
	margin: 0 auto;
}

#content {
	font-size: 150%;
}

.list_p1 {
	width: 1116px;
	height: 38px;
	line-height: 38px;
	margin: 30px 0 20px 0;
	border-top: 2px solid #c3c3c3;
	padding-left: 10px;
	background-color: #e3e3e3;
}

.list_p1 span {
	font-size: 22px;
	font-weight: 700;
	float: left;
	margin-right: 20px;
	display: block;
}

.list_p1 input[type="text"] {
	float: left;
	height: 25px;
	width: 200px;
	margin: 5px 20px 0 0;
}

.list_p1 input[type="button"] {
	float: left;
	height: 22px;
	width: 50px;
	margin-top: 8px;
	border-radius: 5px;
	background-color: #fff;
	border: 1px solid #a6a6a6;
}

.list_p2 {
	width: 1126px;
	height: 38px;
	border: 1px solid #a6a6a6;
	border-bottom: none;
}

.list_p2 span {
	float: left;
	text-align: left;
	line-height: 38px;
	padding-left: 30px;
	font-size: 20px;
	display: block;
}

.list_ul {
	list-style: none;
	border: 1px solid #a6a6a6;
	overflow: hidden;
	padding: 30px;
}

.list_ul li {
	border-bottom: 1px dashed #a6a6a6;
	width: 1000px;
	height: 38px;
	float: left;
	line-height: 38px;
	padding: 0 20px;
}
</style>
</head>

<body>
	<div id="newsList" class="newsList">
		<p class="list_p1">
			<span>商城新闻</span> <input type="text" id="title1" /> <input
				type="button" value="搜索" onclick="search($('#title1').val(),1)" />
		</p>
		<P class="list_p2">
			<span style="width: 900px;">标题</span> <span style="width: 100px;">发布时间</span>
		</P>
		<ul class="list_ul" id="xinwen1">
			<c:forEach items="${newsList}" var="list">
				<li><span style="float: left;"><a
						href="newOrNoiceInfo.do?newOrNoticeId=${list.id}&&type=1">${list.title}</a></span>
					<span style="float: right;"><fmt:formatDate
							value="${list.releaseTime}" pattern="yyyy-MM-dd" /></span></li>
			</c:forEach>
		</ul>
	</div>
	<!-- 分页1 -->
	<div id="pagin1" class="pagin"
		style="width: 1128px; height: 60px; margin: 0 auto;">
		<!-- <div class="message">
				共<i id="rows1" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage1" class="blue"></i>页
			</div> -->
		<div id="Pagination1" class="meneame"
			style="clear: left; width: 500px; float: right;"></div>
	</div>


	<div id="noticeList" class="noticeList">
		<p class="list_p1">
			<span>最新活动</span> <input type="text" id="title2" /> <input
				type="button" value="搜索" onclick="search($('#title2').val(),2)" />
		</p>
		<P class="list_p2">
			<span style="width: 900px;">标题</span> <span style="width: 100px;">发布时间</span>
		</P>
		<ul class="list_ul" id="xinwen2">
			<c:forEach items="${noticeList}" var="list">
				<li><span style="float: left;"><a
						href="newOrNoiceInfo.do?newOrNoticeId=${list.id}&&type=2">${list.title}</a></span>
					<span style="float: right;"><fmt:formatDate
							value="${list.releaseTime}" pattern="yyyy-MM-dd" /></span></li>
			</c:forEach>
		</ul>
	</div>
	<!-- 分页2 -->
	<div id="pagin2" class="pagin"
		style="width: 1128px; height: 60px; margin: 0 auto;">
		<!-- <div class="message">
				共<i id="rows2" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage2" class="blue"></i>页
			</div> -->
		<div id="Pagination2" class="meneame"
			style="clear: left; width: 500px; float: right;"></div>
	</div>
	<div id="industryNewsList" class="industryNewsList">
		<p class="list_p1">
			<span>行业新闻</span> <input type="text" id="title3" /> <input
				type="button" value="搜索" onclick="search($('#title3').val(),3)" />
		</p>
		<P class="list_p2">
			<span style="width: 900px;">标题</span> <span style="width: 100px;">发布时间</span>
		</P>
		<ul class="list_ul" id="xinwen3">
			<c:forEach items="${industryNewsList}" var="list">
				<li><span style="float: left;"><a
						href="newOrNoiceInfo.do?newOrNoticeId=${list.id}&&type=3">${list.title}</a></span>
					<span style="float: right;"><fmt:formatDate
							value="${list.releaseTime}" pattern="yyyy-MM-dd" /></span></li>
			</c:forEach>
		</ul>
	</div>
	<!-- 分页3 -->
	<div id="pagin3" class="pagin"
		style="width: 1128px; height: 60px; margin: 0 auto;">
		<!-- <div class="message">
				共<i id="rows3" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage3" class="blue"></i>页
			</div> -->
		<div id="Pagination3" class="meneame"
			style="clear: left; width: 500px; float: right;"></div>
	</div>
</body>
</html>
