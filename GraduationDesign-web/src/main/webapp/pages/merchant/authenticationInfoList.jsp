<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	String json = (String)request.getAttribute("json");
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/css/frontcss/public.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=path%>/js/artDialog/dialog-plus-min.js"></script>
<link href="<%=path%>/js/artDialog/ui-dialog.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript">
$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=json%>);
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
		location.href="authenticationInfoList.do?currentPage="+(page_index+1);
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});

//--------------------------------------------------------------------上传文件	
  			
  function renzheng(){
   if ($("#imgFile").val().length > 0) {
      	var tc = $("#authenticationName option:selected").val();//用户选择项
		var ser = $("td[name='ser']");//列表
		var flag=true;
			$.each(ser,function(j,note){
			var tt1 = $(note).html();
				if(tc==tt1){
				$("#msgS").text("已经上传过该种证件");
				flag=false;
				}
			});
			if(flag){
				ajaxFileUpload();
			}
         }else {
          alert("请选择图片");
         }
 }
function ajaxFileUpload(){
		var name=$("#authenticationName option:selected").val();
 		$.ajaxFileUpload({
			type : "POST",
			url : "uploadAuthenticationfile.do",
			secureuri : false,  
            fileElementId:'imgFile',// 上传控件的id  
			data : {
				authenticationName : name
			},
			success : function(data) {
				location.href="authenticationInfoList.do";
			}
		});
	} 
	
	
	function zhanshi(id){
	var filePath = $("#renz"+id).val();
		var d = dialog({
   				 title: '认证资料',
   			 	content: '<img id="img"  src="<%=path%>'+filePath+'">'
   			 	});
				d.show(); 
	}
	function checkInfo(){
	    var tt = $("#authenticationName option");
		var ser = $("td[name='ser']");
		var strflag="";
		$.each(tt,function(i,note){
		var se = $(note).val();
		var flag=false;
		$.each(ser,function(j,note){
		var tt1 = $(note).html();
		if(se==tt1){
		flag=true;	
		}
		if(j>=ser.length-1){
		if(flag){
		strflag+="1";
		}else{
		strflag+="0";
		}
		}
		})
		})
		if(strflag.match("11111")){
			$("#t1").css("display","none");
			$(".t2").css("display","none");
			alert("等待系统认证");
		}else{
		alert("您还有未上传的证件");
	}
		
	}
</script>
<style type="text/css">
div.meneame span {
	display: inline;
}

input,select{
	width: 140px;
	height: 20px;
}
.input_but{
	width: 70px;
	height: 20px;
}
.input_radio{
	width: 13px;
	height: 13px;
}
</style>
</head>

<body>


	<div class="inner_div">
		<div style="height:45px; line-height:45px; border-bottom:1px solid #D1D1D1; font-size:14px; padding-left:15px;">
			<span class="lo1">首页</span> > <span class="lo2">账户管理 ></span><span class="lo2">账户信息</span>
		</div>
		<div class="detail_list">
			<ul id="tabs">
				<li><a href="#" title="tab3">资料认证</a></li>
			</ul>
			<div id="content">
				
				<div id="tab3">
					<!-- <p align="right">
						<span style="color: red;">*&nbsp;</span>表示必填项
					</p> -->
					<p style="background-color:#D0D0D0;font-weight: bold;">企业基本资格证书</p>
					<table width="100%" cellspacing="0" align="center">
						<thead style="border: 1px solid #D0D0D0">
							<tr style="background-color: #f1f1f1;">
								<th>证书名称</th>
								<th>发证机构</th>
								<th>状态</th>
								<th>上传时间</th>
								<c:if test="${authenticationManagers[4].status!=1}">
								<th id="t1">操作</th>
								</c:if>
							</tr>
						</thead>
						<tbody style="border: 1px solid #D0D0D0">
							<c:forEach items="${authenticationManagers}" var="c">
								<tr>
									<td align="center" name="ser">${c.authenticationName}</td>
									<td style="display: none"><input type="hidden" id="renz${c.id}" value="${c.filePath}"/><a href="#" onclick="zhanshi(${c.id})">${c.filePath}</a></td>
									<td align="center"><img src="<%=path%>${c.filePath}" style="width: 240px;height: 300px;"/></td>
									<td align="center">
									<c:choose>
										<c:when test="${c.status==0}">未审核</c:when>
										<c:when test="${c.status==1}">已审核</c:when>
										<c:when test="${c.status==2}">等待审核</c:when>
									</c:choose>
									</td>
									<td align="center">${c.uploadTime}</td>
									<c:if test="${c.status!=1}">
									<td align="center" class="t2"><a href="deleteAuthenticationInfo.do?id=${c.id}&&show=3">删除</a></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- 分页 -->
					<div id="Pagination" class="meneame" style="clear:left"></div>
					<!-- <hr style="color: red;border: 1px solid;" /> -->
					<c:if test="${authenticationManagers[4].status!=1}">
						<select name="authenticationName" id="authenticationName">
							<option value="组织机构代码证" id="t1"><span style="color: red;">*&nbsp;</span>组织机构代码证</option>
							<option value="经营许可证" id="t2"><span style="color: red;">*&nbsp;</span>经营许可证</option>
							<option value="委托证明" id="t3"><span style="color: red;">*&nbsp;</span>委托证明</option>
							<option value="企业税务登记证" id="t4"><span style="color: red;">*&nbsp;</span>企业税务登记证</option>
							<option value="主要经营者身份证正反复印件" id="t5"><span style="color: red;">*&nbsp;</span>主要经营者身份证正反复印件</option>
						</select>&nbsp;&nbsp;&nbsp;
						<input type="file" id="imgFile" name="file"/>&nbsp;&nbsp;&nbsp;
					<input class="input_but orange" type="button" value="上传" onclick="renzheng()" id="btn"/>
					<input class="input_but orange" type="button" value="保存" onclick="checkInfo()"/>
					<span id="msgS" style="color: red;"></span>
					<br/><br/>
					<span id="msgSub" style="color: red;"></span>
					</c:if>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
