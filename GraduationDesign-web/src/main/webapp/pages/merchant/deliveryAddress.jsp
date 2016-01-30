<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	String result = (String)request.getParameter("result");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<%-- <script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script> --%>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
	function checkSs(id,s) {
		$.ajax({
			type : "POST",
			url : "provinceUrbanLinkage.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				id : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("获取失败！");
				} else {
					var json = eval(data);
					$("#city"+s).children().remove();
					listCitys(json,s);
				}
			}
		});
	}
	function checkss(id,s) {
		$.ajax({
			type : "POST",
			url : "provinceUrbanLinkage.do",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				"id" : id
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					var json = eval(data);
					$("#district"+s).children().remove();
					listDistrict(json,s);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}

	//二级显示
	function listCitys(json,s) {
		if(json.length>0){
		$("#city" + s).show();
		}else{
		$("#city" + s).hide();
		}
		$("#district" + s).hide();
		var option1 = $("<option value=''></option>");
		option1.html("请选择城市");
		$("#city"+s).append(option1);
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#city"+s).append(option2);
		}
	};

	//三级显示
	function listDistrict(json,s) {
	if(json.length>0){
		$("#district" + s).show();
		}else{
		$("#district" + s).hide();
		}
	var option1 = $("<option value=''></option>");
		option1.html("请选择区域");
		$("#district"+s).append(option1);
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#district"+s).append(option2);
		}
	};
	//页面载入时初始地址参数
	$(function(){
	$("#city0").hide();
	$("#district0").hide();
	});
j = 0;
	$(function() {
		$("#sele_add")
				.click(function() {
						var addr1 = $("#province0").html();		
								 $("#sele_add").before('<span id="span'+(++j)+'"><br><br/><div class="detail_short"><select style="margin-right: 5px; width: 100px; height: 23px;" id="provice'+j+'" name="provice'+j+'" onchange="checkSs(this.value,'+j+')">'+addr1+'</select><select id="city'+j+'" name="city'+j+'" onchange="checkss(this.value,'+j+')"><option value="">请选择城市</option></select><select style="margin-right: 5px; width: 100px; height: 23px;" id="district'+j+'" name="district'+j+'"><option value="">请选择地区</option></select></div>'
									+ '<input style="margin-right: 4px; width: 200px; height: 23px; color:#F08080;" id="detail'+j+'" type="text" name="detail'+j+'" value="请输入详细地址" /><input  style="margin-right: 4px; width: 100px; height: 23px; color:#F08080;" id="short'+j+'" type="text" name="short'+j+'" value="请输入地址简称" />'
									+'<input class="orange" style="margin-right: 4px; width: 40px; height: 20px;" type="button" value="删除"  onclick="span('+ j+ ')"/></span>');				

						$("#city"+j).hide();
						$("#district"+j).hide();
						});
						

	});
	function span(o) {
	 	$("#span"+o).remove();
	}
			function finish() {
		 var spans = $("#tab1 span[id] ");
		 address = "";
		var addflag=true;
		 //多个省市区及详细地址
		 $.each(spans, function(i, node1) {
		 var node2 = $(node1).find("select,input[id]");
		 //省市区中的多个select
		  $.each(node2, function(j, node3) {
		  if($(node3).val()==null||$(node3).val()==""||$(node3).val()=="请输入详细地址"||$(node3).val()=="请输入地址简称"){
		  addflag=false;
		  }
		  //将省市区拼成一个字符串以‘,’分割
		  address+=$(node3).val()+((j>=node2.length-1)?"":","); 
		 });
		  //多个省市区拼成一个字符串以‘;’分割
			 address+=((i>=spans.length-1)?"":";");	 
		}); 
		$("#address").val(address.replace(/请输入详细地址/g, "").replace(/请输入地址简称/g, ""));
		if (addflag) {
		$("#form1").submit();	
		} else {
		alert("地址必须完整填写！");	
		}
	}
	function deleteAddress(addressId){
					if (confirm("确定要删除该收货地域？")){
 				 	location.href="deleteDeliveryAddress.do?addressId="+addressId;
 					}
	}
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
		location.href="toaddDeliveryAddress.do?currentPage="+(page_index+1);
		}
		flag=true;
		return false;	
	   }
	    initPagination();	   
	});
	$(function(){
	if(<%=result%>=="true"){
	alert("新地址添加成功");
	}else if(<%=result%>=="false"){
	alert("新地址已存在，请重新编写！");
	}
	});
</script>
<style type="text/css">
.trs1 {
	text-align: center
}

.detail_short {
	margin-bottom: 5px
}

select {
	margin-right: 5px;
	width: 100px;
	height: 23px;
}

tr {
	border: 1px solid #999;
}

td {
	height: 100px
}

th {
	border-left: 1px solid #999;
	background-color: #d0d0d0;
}
</style>
</head>

<body>


	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2"> 地址管理 ></span><span
				class="lo2"> 收货地址</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li>收货地域</li>
			</ul>
			<div id="content">
				<form action="addDeliveryAddress.do" id="form1" method="post">
					<input type="hidden" id="address" name="address" value="">
					<div id="tab1">
						<p align="right">
							<span style="color: white;"> ~</span>
						</p>
						<span id="span0">
							<div class="detail_short">
								<select id="province0" name="province"
									onchange="checkSs(this.value,0)">
									<option value="">请选择省份</option>
									<c:forEach items="${dictionarys}" var="d">
										<option value="${d.id}">${d.dicName}</option>
									</c:forEach>
								</select> <select id="city0" name="city"
									onchange="if(this.value!=1){checkss(this.value,0);}">
									<option value="">请选择城市</option>
								</select> <select id="district0" name="district">
									<option value="">请选择地区</option>
								</select>
							</div> <input id="detail0" type="text" name="detail0" value="请输入详细地址"
							onfocus="if(this.value=='请输入详细地址') {this.value='';}"
							onblur="if(this.value=='') {this.value='请输入详细地址';}"
							style="color: #F08080; height: 23px; width: 200px;" /> <input
							id="short0" type="text" name="short0" value="请输入地址简称"
							onfocus="if(this.value=='请输入地址简称') {this.value='';}"
							onblur="if(this.value=='') {this.value='请输入地址简称';}"
							style="color: #F08080; height: 23px; width: 100px;" />
						</span> <input class="orange" style="width: 70px; height: 20px;"
							type="button" id="sele_add" value="新增地址"> <input
							class="orange" style="width: 40px; height: 20px;" type="button"
							onclick="finish();" value="提交">
					</div>
				</form>
				<table style="width: 100%; margin-top: 5px;">
					<tr>
						<th style="width: 50px">省</th>
						<th style="width: 100px">市</th>
						<th style="width: 70px">区</th>
						<th style="width: 200px">详细地址</th>
						<th style="width: 70px">地址简称</th>
						<th style="width: 50px">操作</th>
					</tr>
					<c:forEach items="${shoppingAddress}" var="sd">
						<tr class="trs1">
							<td>${sd.provinceName}</td>
							<td>${sd.cityName }</td>
							<td>${sd.districtName }</td>
							<td>${sd.shoppingAddress }</td>
							<td>${sd.adderssName }</td>
							<td><button class="orange"
									style="width: 40px; height: 20px;"
									onclick="deleteAddress(${sd.id});">删除</button></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

	</div>
	<!-- 分页 -->
	<div class="pagin" style="clear: left">
		<!-- <div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
		<div id="Pagination" class="meneame" style="clear: left"></div>
	</div>
	<script>
		$(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			$("#tabs li:first").attr("id", "current"); // Activate first tab
			$("#content div:first").fadeIn(); // Show first tab content

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide(); //Hide all content
				$("#tabs li").attr("id", ""); //Reset id's
				$(this).parent().attr("id", "current"); // Activate this
				$('#' + $(this).attr('title')).fadeIn(); // Show content for current tab
			});
		})();}
	</script>
</body>
</html>
