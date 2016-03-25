<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String companyProductLists = (String)request.getAttribute("companyProductLists"); //json对象字符串
	String json = (String) request.getAttribute("json"); //分页
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/artDialog/dialog-plus-min.js"></script>
<link href="<%=path%>/js/artDialog/ui-dialog.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript">
//全局变量
var productLists =<%=companyProductLists%>;
$(document).ready(function(){
  $('.tablelist tbody tr:odd').addClass('odd');
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});
function getId() {
			var fileIds = "";
			$("input[name=box]").each(function() {
				 if ($(this).attr("checked") == true) {
             		 fileIds += $(this).val() + ",";
                  }     
			}); 
			fileIds = fileIds.substring(0, fileIds.length - 1);
			return fileIds;
		}
function  getXhr(){
        var xhr = null;
        if(window . XMLHttpRequest){
            xhr  = new XMLHttpRequest();
        }else{
            xhr = new ActiveXObject('Microsoft . XMLHTTP');
        }
        return xhr;
}
 function getText(){
            var xhr = getXhr();
            xhr.onreadystatechange=function(){
                if(xhr.readyState==4 && xhr.status==200){
                    window.location.href="companyProductsList.do";
                }
            };
           xhr.open("post","deleteMore.do",true);
           xhr.setRequestHeader('content-type',
                'application/x-www-form-urlencoded');
           var countId = getId();
           xhr.send("Uid="+countId);
  }
  
function checkAll(){
  var ischecked=document.getElementById("checkAll").checked;
  if(ischecked){
    checkallbox();
  }else{
    discheckallbox();
  }
}
function checkallbox(){
   var boxarray = document.getElementsByName("box");
   for(var i = 0; i < boxarray.length; i++) { 
     boxarray[i].checked = true;
   }
}
function discheckallbox() { 
  var boxarray = document.getElementsByName("box"); 
  for(var i = 0; i < boxarray.length; i++) { 
    boxarray[i].checked = false;
  }
}
function checkBox(){
            			
            		var checkObjs1 = $(":checkbox[name='box']:checked");
            		var checkObjs2 = $(":checkbox[name='box']");
            		  	if(checkObjs1.length==checkObjs2.length) {
                			document.getElementById("checkAll").checked=true;
                }else{
                			document.getElementById("checkAll").checked=false;
    }
}
function checkDelete(id){
	 var r = window.confirm("确定删除此公司商品信息吗？");
	 if(r){
             location.href="/GraduationDesign/supplyCompanyProducts/deleteCompanyProducts.do?id="+id;
          }
}
function checkDeletes(){
	var r = window.confirm("确定删除所选公司商品信息吗？");
	 if(r){
            getText();
          }

}
function productCheck(id,productId,status){
	$.ajax({
			dataType : "text",
			type : "POST",
			url : "/GraduationDesign/products/toProductCheck.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				id : productId
			},
			success : function(data) {
				
				var l='';  //商品资质是否全部通过
				var flag=false;
				if (data == "false") {  //提示
					alert("该商品尚未审核通过不能对其进行此操作，请待商品审核通过！");
				}else if(data == "true") {
				for(var i=0;i<productLists.length;i++){
					
					if(id==productLists[i].id){
					for(var k=2;k<8;k++){
					for(var j=0;j<productLists[i].companyProductPics.length;j++){
					if(productLists[i].companyProductPics[j].fileClass==k){
					if(productLists[i].companyProductPics[j].status==1){
					l+='1';
					break;
					}else if(j==(productLists[i].companyProductPics.length-1)){
					l+='0';
					}
					
					}
					
					}
					}
					if(l=='111111'){
					flag=true;
					}else{
					flag=false;
					alert("该商品的所有资质认证类型通过才能进行此操作,请进行资质认证！");
					}
					}
					
				}
				if(status==1&&flag){
				location.href="/GraduationDesign/products/supplyapproveCheckUp.do?id="+id;
				}else if(status==0&&flag){
				location.href="/GraduationDesign/products/supplyapproveCheckDown.do?id="+id;
				}else if(status==4){
				location.href="/GraduationDesign/products/supplydisapproveCheck.do?id="+id;
				}else if(status==2){
				location.href="/GraduationDesign/products/supplydeleteCheck.do?id="+id;
				}
			}
			},
			error : function(data){
			alert(data);
			}
		});
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
		var s="";
		var productName=$("#productName1").val().trim();
		if(flag){
		if(productName!=null&&productName!=""){
		s+="&&productName="+productName;
		}
		location.href="supplyCheckList.do?currentPage="+(page_index+1)+s;
		}
		flag=true;
		return false;	
	   }
	    initPagination();
	});
	function showProductSafetyPic(id,productId){
	var titles = '商品名称：';
	var contents1 = '<div id="productId'+id+'"><table style="width: 100%"><thead><tr><th width="120">资质名称</th><th width="100">状态</th><th width="200">审核操作</th></tr></thead><tbody>';
	var fileStyle = '';
	var fileStatus = '';
	
	for(var i=0;i<productLists.length;i++){
	if(productLists[i].id==id){
	titles+=productLists[i].productName+' 公司名称：'+productLists[i].companyName;
	for(var j=0;j<productLists[i].companyProductPics.length;j++){
	switch(productLists[i].companyProductPics[j].fileClass){
	case 2:fileStyle='食品安全资质'; break;
	case 3: fileStyle='生产许可证'; break;
	case 4: fileStyle='QS商城许可证'; break;
	case 5: fileStyle='检测报告'; break;
	case 6: fileStyle='品牌资质授权'; break;
	case 7: fileStyle='厂家代理授权'; break;
	}
	switch(productLists[i].companyProductPics[j].status){
	case 0: fileStatus = '初始'; break;
	case 1: fileStatus = '通过'; break;
	case 2: fileStatus = '无效'; break;
	}
	contents1+='<tr><td>'+fileStyle+'</td><td>'+fileStatus+'</td><td><a id="product'+productLists[i].companyProductPics[j].id+'" href="javascript:void(0)" onclick="changePPSStatus('+productLists[i].companyProductPics[j].id+',1,this);">通过</a> <a href="javascript:void(0)" onclick="changePPSStatus('+productLists[i].companyProductPics[j].id+',2,this);">无效</a> <a href="/GraduationDesign/companyProducts/downloadFile.do?filePath='+productLists[i].companyProductPics[j].filePath+'&&id='+productLists[i].id+'">下载</a></td></tr>';
/* 	contents1+='<tr><td>'+fileStyle+'</td><td><img width="50" height="50" src="/ssm'+productLists[i].companyProductPics[j].filePath+'"/><a href="/GraduationDesign/companyProducts/downloadFile.do?filePath='+productLists[i].companyProductPics[j].filePath+'&&id='+productLists[i].id+'">下载</a></td><td>'+fileStatus+'</td></tr>'; */
	};
	};
	}
	contents1+='</tbody></table></div>';
   var d = dialog({
   				 title: titles,
   			 	 content: contents1
				});
	d.addEventListener('close', function () {
    			 window.location.reload();
});			
	d.show();
	}
	//修改状态
	
	function changePPSStatus(id,status,node){
	var fileStatus = '';
	$.ajax({
			async : false,
			dataType : "text",
			type : "POST",
			url : "/GraduationDesign/products/changePPSStatus.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				id : id,
				status : status
			},
			success : function(data) {
				if (data == "false") {
					alert("修改失败，请稍后重试！");
					
				}else if(data == "true") {
				switch(status){
					case 0: fileStatus = '初始';break;
					case 1: fileStatus = '通过'; break;
					case 2: fileStatus = '无效'; break;
					}
				$(node).parent().prev().html(fileStatus);
			}
			},
			error : function(data){
			alert(data);
			
			}
		});	
	}
</script>

<style type="text/css">
div.meneame span {
	display: inline;
}
</style>
</head>


<body>

	<div class="rightinfo">

		<div class="tools">

			<ul class="toolbar">
				<li><a class="tablelink"
					href="/GraduationDesign/supplyCompanyProducts/toAddCompanyProducts.do"><span><img
							src="../images/t01.png" /></span>添加</a></li>
				<li><a class="tablelink" href="#" onclick="checkDeletes();"><span><img
							src="../images/t03.png" /></span>删除</a></li>
				<li><form action="supplyCheckList.do" method="post">
						<input type="hidden" id="productName1" value="${productName }" />
						<input type="text" name="productName" placeholder="请输入商品名称"
							id="productName" value="${productName }" /> <input type="submit"
							value="点击搜索" name="submitButton" />
					</form></li>
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th width="60"><input name="" id="checkAll" type="checkbox"
						onclick="checkAll();" />全选</th>
					<th>ID</th>
					<th>商品名称</th>
					<th>公司名称</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${companyProductList}" var="c">
					<tr>
						<td><input type="checkbox" name="box" onclick="checkBox();"
							value="${c.id}" /></td>
						<td>${c.id}</td>
						<td><a
							href="javascript:showProductSafetyPic(${c.id},${c.productId});">${c.productName}</a></td>
						<td>${c.companyName}</td>
						<c:choose>
							<c:when test="${c.status==0 }">
								<td>下架</td>
							</c:when>
							<c:when test="${c.status==1 }">
								<td>上架</td>
							</c:when>
							<c:when test="${c.status==3 }">
								<td>初始</td>
							</c:when>
							<c:when test="${c.status==4 }">
								<td>否决</td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>

						<td><a class="tablelink"
							href="javascript:productCheck(${c.id},${c.productId},1);">上架</a>
							<a class="tablelink"
							href="javascript:productCheck(${c.id},${c.productId},0);">下架</a>
							<a class="tablelink"
							href="javascript:productCheck(${c.id},${c.productId},4);">否决</a>
							<a class="tablelink"
							href="javascript:productCheck(${c.id},${c.productId},2);">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 分页 -->
		<div class="pagin">
			<!-- 	<div class="message">
				共<i id="rows" class="blue"></i>条记录，当前显示第&nbsp;<i id="currentPage" class="blue"></i>页
			</div> -->
			<div id="Pagination" class="meneame" style="clear: left"></div>
		</div>

		<%--  <div class="pagin">
    	<div class="message">共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页</div>
        <ul class="paginList">
        		<c:choose>
                		<c:when test="${page.currentPage==1}">
                		 <li class="paginItem current"><a href="#"><span class="pagepre"></span></a></li>
                		</c:when>
                		<c:otherwise>
                		 <li class="paginItem"><a href="/GraduationDesign/products/supplyCheckList.do?currentPage=${page.currentPage-1}"><span class="pagepre"></span></a></li>
                		</c:otherwise>
                </c:choose>
        		<c:forEach begin="1" end="${page.totalPage}" var="s3">
					 	<c:choose>
                    		<c:when test="${s3==page.currentPage}">
                    		 <li class="paginItem current"><a href="#">${s3}</a></li>
                    		</c:when>
                    		<c:otherwise>
                    		<li class="paginItem"><a href="/GraduationDesign/products/supplyCheckList.do?currentPage=${s3}">${s3}</a></li>
                    		</c:otherwise>
                    	</c:choose>
				</c:forEach>
				<c:choose>
                		<c:when test="${page.currentPage==page.totalPage or s3<=10}">
                		 <li class="paginItem current"><a href="#"><span class="pagenxt"></span></a></li>
                		</c:when>
                		<c:otherwise>
                		 <li class="paginItem"><a href="/GraduationDesign/products/supplyCheckList.do?currentPage=${page.currentPage+1}"><span class="pagenxt"></span></a></li>
                		</c:otherwise>
                </c:choose>    
        </ul>
    </div>
     --%>

		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="../images/ticon.png" /></span>
				<div class="tipright">
					<p>是否确认对信息的修改 ？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>

			<div class="tipbtn">
				<input name="" type="button" class="sure" value="确定" />&nbsp; <input
					name="" type="button" class="cancel" value="取消" />
			</div>

		</div>




	</div>

	<!-- <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script> -->

</body>

</html>
