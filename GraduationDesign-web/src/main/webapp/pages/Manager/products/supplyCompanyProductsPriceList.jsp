<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>

<script type="text/javascript">
$(document).ready(function(){
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
 function getText(companyProductId){
            var xhr = getXhr();
            xhr.onreadystatechange=function(){
                if(xhr.readyState==4 && xhr.status==200){
                    window.location.href="toCompanyProductPriceInfo.do?id="+companyProductId;
                }
            };
           xhr.open("post","deleteMoreCompanyProductPrice.do",true);
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
function checkDelete(companyProductId,id,grossmMarginPriceId){
	 var r = window.confirm("确定删除此公司商品信息吗？");
	 if(r){
             location.href="/ssm/companyProducts/deleteCompanyProductPrice.do?companyProductId="+companyProductId+"&&id="+id+"&&grossMarginPriceId="+grossmMarginPriceId;
          }
}
function checkDeletes(companyProductId){
	var r = window.confirm("确定删除所选公司商品信息吗？");
	 if(r){
            getText(companyProductId);
          }

}
function addPrice(){
	$('#rightinfo').attr('style','display :none');
	$('#addPrice').attr('style','display :block');
}
function resetAdd(){
	$('#rightinfo').attr('style','display :block');
	$('#addPrice').attr('style','display :none');
}
function historyInfo(){
	$('#tablelist1').attr('style','display :none');
	$('#li1').attr('style','display :none');
	$('#tablelist2').attr('style','display :block');
	$('#li2').attr('style','display :block');
}
function returnInfo(){
	$('#tablelist2').attr('style','display :none');
	$('#li2').attr('style','display :none');
	$('#tablelist1').attr('style','display :block');
	$('#li1').attr('style','display :block');
}
</script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

.addPrice {
	display: none;
	position: absolute;
	top: 40%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}

#tablelist2, #li2 {
	display: none;
}
</style>
</head>


<body>

	<div id="rightinfo" class="rightinfo">

		<div class="tools">

			<ul class="toolbar">
				<li id="li3"><a class="tablelink" href="companyProductsList.do">&nbsp;&nbsp;返回上页</a></li>
				<li><a class="tablelink" href="javaScript:addPrice();"><span><img
							src="../images/t01.png" /></span>添加</a></li>
				<li id="li1"><a class="tablelink"
					href="javaScript:historyInfo();">&nbsp;&nbsp;历史价格</a></li>
				<li id="li2"><a class="tablelink"
					href="javaScript:returnInfo();">&nbsp;&nbsp;返回</a></li>
			</ul>

		</div>


		<table class="tablelist" id="tablelist1">
			<thead>
				<tr>
					<th width="60"><input name="" id="checkAll" type="checkbox"
						onclick="checkAll();" />全选</th>
					<th>ID</th>
					<th>最小数量</th>
					<th>最大数量</th>
					<th>价格</th>
					<th>毛利价格</th>
					<th>商品价格编码</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${companyProductPrices}" var="c">
					<tr>
						<td><input type="checkbox" name="box" onclick="checkBox();"
							value="${c.id}@${c.grossMargins.id}" /></td>
						<td>${c.id}</td>
						<td>${c.minNum}</td>
						<td>${c.maxNum}</td>
						<td>${c.price}</td>
						<td>${c.grossMargins.grossMargin}</td>
						<td>${c.companyProductCode}</td>
						<td>
							<%--  <a class="tablelink" href="/ssm/companyProducts/toCompanyProductPriceUpdate.do?id=${c.id}">历史价格</a> --%>
							<a class="tablelink"
							href="/ssm/supplyCompanyProducts/toCompanyProductPriceUpdate.do?id=${c.id}">修改</a>
							<%-- <a class="tablelink" href="#" onclick="checkDelete(${c.companyProductId},${c.id},${c.grossMargins.id});">删除</a> --%>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table class="tablelist" id="tablelist2">
			<thead>
				<tr>
					<th>ID</th>
					<th>最小数量</th>
					<th>最大数量</th>
					<th>价格</th>
					<th>毛利价格</th>
					<th>价格时间</th>
					<th>商品价格编码</th>
					<!--  <th>操作</th> -->
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${companyProductPriceLogs}" var="c">
					<tr>
						<td>${c.id}</td>
						<td>${c.minNum}</td>
						<td>${c.maxNum}</td>
						<td>${c.price}</td>
						<td>${c.grossMargins.grossMargin}</td>
						<td>${c.priceDate}</td>
						<td>${c.companyProductCode}</td>
						<%-- <td>
        <a class="tablelink" href="/ssm/companyProducts/toCompanyProductPriceUpdate.do?id=${c.id}">历史价格</a>
        <a class="tablelink" href="/ssm/supplyCompanyProducts/toCompanyProductPriceUpdate.do?id=${c.id}">修改</a>
       	<a class="tablelink" href="#" onclick="checkDelete(${c.companyProductId},${c.id},${c.grossMargins.id});">删除</a>
        </td> --%>
					</tr>
				</c:forEach>
			</tbody>
		</table>


		<div class="pagin">
			<div class="message">
				共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<c:choose>
					<c:when test="${page.currentPage==1}">
						<li class="paginItem current"><a href="#"><span
								class="pagepre"></span></a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/companyProducts/companyProductsList.do?currentPage=${page.currentPage-1}"><span
								class="pagepre"></span></a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a></li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/companyProducts/companyProductsList.do?currentPage=${s3}">${s3}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span></a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/companyProducts/companyProductsList.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span></a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>


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
	<div id="addPrice" class="addPrice">
		<form action="companyProductPriceAdd.do" method="post">
			<input type="hidden" name="companyProductId"
				value="${companyProductId}" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th></th>
					<td><input type="hidden" readonly name="userId"
						value="${userInfo.id}" /></td>
				</tr>
				<tr>
					<th>最小数量:</th>
					<td><input type="text" name="minNum" /></td>
				</tr>
				<tr>
					<th>最大数量:</th>
					<td><input type="text" name="maxNum" /></td>
				</tr>
				<tr>
					<th>商品价格编码:</th>
					<td><input type="text" name="companyProductCode" /></td>
				</tr>
				<tr>
					<th>价格:</th>
					<td><input type="text" name="price" /></td>
				</tr>
				<tr>
					<th>毛利价格:</th>
					<td><input type="text" name="grossMargin" /></td>
				</tr>
				<tr>
					<th>到期时间:</th>
					<td><input type="text" name="endTime" onclick="WdatePicker()"
						readonly="readonly" /></td>
				</tr>
			</table>
			<input type="submit" value="增加" /> <input type="reset" value="取消"
				onclick="resetAdd()" />
		</form>
	</div>

	<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd')
	</script>

</body>

</html>
