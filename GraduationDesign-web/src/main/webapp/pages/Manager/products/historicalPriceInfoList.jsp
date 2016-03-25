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
             location.href="/GraduationDesign/companyProducts/deleteCompanyProductPrice.do?companyProductId="+companyProductId+"&&id="+id+"&&grossMarginPriceId="+grossmMarginPriceId;
          }
}
function checkDeletes(companyProductId){
	var r = window.confirm("确定删除所选公司商品信息吗？");
	 if(r){
            getText(companyProductId);
          }

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
				<li id="li3"><a class="tablelink" href="historicalPriceList.do">&nbsp;&nbsp;返回上页</a></li>
			</ul>

		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>ID</th>
					<th>最小数量</th>
					<th>最大数量</th>
					<th>价格</th>
					<th>毛利价格</th>
					<th>价格时间</th>
					<th>商品价格编码</th>
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
							href="/GraduationDesign/historicalPrice/toHistoricalPriceInfo.do?currentPage=${page.currentPage-1}"><span
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
								href="/GraduationDesign/historicalPrice/toHistoricalPriceInfo.do?currentPage=${s3}">${s3}</a></li>
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
							href="/GraduationDesign/historicalPrice/toHistoricalPriceInfo.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span></a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>





	</div>

	<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd')
	</script>

</body>

</html>
