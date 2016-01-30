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
			String json = (String)request.getAttribute("json");
			String result = (String)request.getParameter("result");
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">
//全局变量
var addressIdss = new Array(); //地址数组保存便于更改与拼接保存

	function checkSs(id, s) {	
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
					$("#city" + s).children().remove();
					$("#allSelect0").hide();
					$("#district0").hide();
					listCitys(json, s);
				}
			}
		});
	}
	function checkss(id, s) {
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
					$("#district" + s).children().remove();
					$("#allSelect0").show();
					$("#district0").show();
					listDistrict(json, s);
				}
			},
			error : function(data) {
				alert("出错了………………………………");
			}
		});
	}

	//二级显示
	function listCitys(json, s) {
		var option1 = $("<option value=''></option>");
		option1.html("请选择城市");
		$("#city" + s).append(option1);
		/* if(json.length>0){
		$("#city" + s).show();
		}else{
		$("#city" + s).hide();
		}
		$("#district" + s).hide(); */
		for ( var i = 0; i < json.length; i++) {	
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#city" + s).append(option2);
		}
	};

	//三级显示
	function listDistrict(json, s) {
	/* var option1 = $("<option value=''></option>");
		option1.html("请选择地区");
		$("#district" + s).append(option1);
		  if(json.length>0){
		$("#district" + s).show();
		}else{
		$("#district" + s).hide();
		}  
		for ( var i = 0; i < json.length; i++) {
			var option2 = $("<option></option>");
			option2.html(json[i].dicName);
			option2.val(json[i].id);
			$("#district" + s).append(option2);
		} */
	var contents ='<tr>';
	for ( var i = 0; i < json.length; i++) {
			contents+='<td style="height:25px;"><input type="checkbox" id="checkDistrict'+s+'" name="checkDistrict'+s+'" onclick="checkDistrict(this,'+s+')" value="'+json[i].id+'"/>'+json[i].dicName+'&nbsp;&nbsp;&nbsp;</td>'+(((i+1)%5==0)?'</tr><tr>':'');
			$("#district" + s).html(contents);
		}
		contents+='</tr>';
	};	
	//校验区域选择
	function checkDistrict(node1,s){     
	var addressIds='';  
	var checkObjs = $("#"+$(node1).attr("id")+":checked");
            	if(checkObjs.length == 0){
            	//如果一个都没选中
            	$("#SpanInfo"+s).show();
            	}else{
            	$("#SpanInfo"+s).hide();
            	$.each(checkObjs,function(i,node2){
            	addressIds +=$("#province" + s).val()+','+$("#city" + s).val()+','+$(node2).val()+((i >= checkObjs.length - 1) ? '' : ';');
            	});
            	addressIdss[s]=addressIds;	
            	} 
            	//下一步就是如何拼接多个qitadizhi
            	
	}
	function allSelect(){
	var addressIds='';
	/* $.each($(node).prev("ul").find(":checkbox"),function(i,node2){
	 $(node2).attr("checked",true);
	 }); */
	  var boxarray = document.getElementsByName("checkDistrict0");
	  var flag = 0; //作为状态标记
	   for(var i = 0; i < boxarray.length; i++) {
     if(boxarray[i].checked==true){
     flag++;
     };
   }
   if(flag==boxarray.length){
    for(var i = 0; i < boxarray.length; i++) {
     boxarray[i].checked = false;
   }
   }else{
    for(var i = 0; i < boxarray.length; i++) {
     boxarray[i].checked = true;
   }
   }
  
    $.each($(boxarray),function(i,node2){
	 addressIds +=$(node2).parent().parent().prev("select").prev("select").val()+','+$(node2).parent().parent().prev("select").val()+','+$(node2).val()+((i >= $(boxarray).length - 1) ? '' : ';');
	 });
      addressIdss[0]=addressIds;	
	}
	//页面载入时初始地址参数
/* 	$(function(){
	$("#city0").hide();
	$("#district0").hide();
	}); */
	j = 0;
	$(function() {
		$("#sele_add")
				.click(
						function() {
							var addr1 = $("#province0").html();
							 $("#sele_add").before(
											'<span id="span'
													+ (++j)
													+ '"><br/><select id="province'
													+ j
													+ '" name="provice'
													+ j
													+ '" onchange="checkSs(this.value,'
													+ j
													+ ')">'
													+ addr1
													+ '</select><select id="city'
													+ j
													+ '" name="city'
													+ j
													+ '" onchange="checkss(this.value,'
													+ j
													+ ')"><option value="">请选择城市</option></select>'
													+ '<table id="district'+j+'"></table><br><span id="SpanInfo'+j+'" style="color:red; display: none;">*至少填写一个区域*</span><input style="width: 40px; height: 20px;" class="orange" type="button" value="删除"  onclick="span('
													+ j
													+ ')"/></span>');

						/* $("#city"+j).hide();
						$("#district"+j).hide(); */
						});

	});
	function span(o) {
		addressIdss.splice(o,1,"n");
		$("#span" + o).remove();
	}
	function finish() {
		/* var spans = $("#tab1 span[id]");
		address = "";
		var addflag=true;
		//多个省市区及详细地址
		$.each(spans, function(i, node1) {
			var node2 = $(node1).children("select");
			if($(node2).val()==null||$(node2).val()==""){
		 	 addflag=false;
		  }
			//省市区中的多个select
			$.each(node2, function(j, node3) {
				//将省市区拼成一个字符串以‘,’分割
				address += $(node3).val()
						+ ((j >= node2.length - 1) ? "" : ",");
			});
			//多个省市区拼成一个字符串以‘;’分割
			address += ((i >= spans.length - 1) ? "" : ";");
		});
		$("#address").val(address);
		if (addflag) {
			$("#form1").submit();	
		} else {
			alert("请至少选择省份!");	
		} */
/* 		var province = $("#province0 option:selected").val();
			if(province == null || province == ""){
			alert("请至少选择省份!");
			return;
		}else{
			
		} */
		//最新地址提交添加
		$("#address").val(addressIdss.join(';').replace(/n;/g, "").replace(/n/g, ""));
		if($("#address").val()==""){
		alert("请先填写完成的供应地域！");	
		}else{
		$("#form1").submit();	
		}
		
		
	}
	function deleteAddress(addressId){
					if (confirm("确定要删除该供应地域？")){
 				 	location.href="deleteSupplyAddress.do?addressId="+addressId;
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
		location.href="toaddSupplyArea.do?currentPage="+(page_index+1);
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

select {
	width: 150px;
	height: 25px;
	margin-right: 5px;
}

th {
	background-color: #e5e5e5;
	border: 0.5px solid #999;
}

td {
	height: 50px;
}
</style>
</head>

<body>


	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2"> 地址管理 ></span><span
				class="lo2"> 供应地域</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li>供应地域</li>
			</ul>
			<div id="content">
				<form action="addSupplyArea.do" id="form1" method="post">
					<input type="hidden" id="address" name="address" value="">
					<div id="tab1">
						<!--  <p align="right">
							<span style="color: white;"> ~</span>
						</p>  -->
						<!-- <p style="background-color: #E0E0E0;">
							供应区域选择&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">增加供应区域</a>&nbsp;<a
								href="#">修改</a>
						</p> -->
						<span id="span0"> <select id="province0" name="province"
							onchange="checkSs(this.value,0)">
								<option value="">请选择省份</option>
								<c:forEach items="${dictionarys}" var="d">
									<option value="${d.id}">${d.dicName}</option>
								</c:forEach>
						</select> <select id="city0" name="city"
							onchange="if(this.value!=1){checkss(this.value,0);}">
								<option value="">请选择城市</option>
						</select> <!-- <select id="district0" name="district" >
								<option value="">请选择地区</option>
						</select> --> <!-- 	<input id="detail0" type="text" name="detail0" value="请输入详细地址"
							onfocus="if(this.value=='请输入详细地址') {this.value='';}"
							onblur="if(this.value=='') {this.value='请输入详细地址';}"
							style="color:red;" /> 
						<input id="short0" type="text"
							name="short0" value="请输入地址简称 :如(关谷食堂)"
							onfocus="if(this.value=='请输入地址简称 :如(关谷食堂)') {this.value='';}"
							onblur="if(this.value=='') {this.value='请输入地址简称 :如(关谷食堂)';}"
							style="color:red;" /> -->
							<ul id="district0" style="display: none;"></ul> <br> <input
							style="width: 70px; height: 20px; margin-left: 0px; display: none;"
							class="orange" type="button" id="allSelect0"
							onclick="allSelect(this);" value="全选"><span
							id="SpanInfo0" style="color: red; display: none;">*至少填写一个区域*</span>
						</span>
					</div>
					<!-- <input style="width: 70px; height: 20px;margin-left:4px;" class="orange" type="button" id="sele_add"
							value="新增地址"> -->
					<br> <input style="width: 70px; height: 20px;" class="orange"
						type="button" onclick="finish();" value="提交" />
			</div>

			</form>
			<table style="width: 100%; margin-top: 5px;">
				<tr>
					<th>省</th>
					<th>市</th>
					<th>区</th>
					<th style="width: 70px;">操作</th>
				</tr>
				<c:forEach items="${shoppingAddress}" var="sd">
					<tr class="trs1">
						<td>${sd.provinceName}</td>
						<td>${sd.cityName }</td>
						<td>${sd.districtName }</td>
						<td><button style="width: 40px; height: 20px;" class="orange"
								onclick="deleteAddress(${sd.id});">删除</button></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	</div>
	<!-- 分页 -->
	<div class="pagin" style="clear: left">
		<!-- <div >
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
		<div id="Pagination" class="meneame" style="clear: left"></div>
	</div>
	<script>
		/* $(document).ready(function() {
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
		})(); */
	</script>
</body>
</html>
