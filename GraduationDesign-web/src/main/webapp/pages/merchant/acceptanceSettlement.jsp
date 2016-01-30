<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" href="<%=path%>/css/frontcss/shouye.css"
	type="text/css" />
<link rel="stylesheet" href="<%=path%>/css/header/global.css"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
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
                    window.location.href="myInquiry.do";
                }
            };
           xhr.open("post","AddToInquiry.do",true);
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
</script>
<style type="text/css">
#img2 {
	margin-left: auto;
	margin-right: auto;
	width: 60%;
	height: 58px;
	border: 1px solid;
	color: #D0D0D0;
	font-size: 20px;
}

#qrtj {
	margin-top: 40px;
	margin-left: 45%;
	font-size: 12px;
	color: white;
}

#p1 {
	margin-top: 2%;
	margin-left: 38%;
}

#cx {
	font-size: 12px;
	color: white;
}

.input_text {
	width: 150px;
	height: 20px;
}

.input_but1 {
	width: 70px;
	height: 20px;
}

.input_but2 {
	width: 40px;
	height: 20px;
}

th {
	background-color: #F0F0F0;
	border: 0.5px solid #999;
}

td {
	border: 0.5px solid #999;
	height: 32px;
	text-align: center;
}

p {
	margin: 8px;
}
</style>
</head>

<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">订单管理 ></span><span
				class="lo2">验收管理</span>
		</div>

		<p>
			验收管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数量如有出入请拨打客服电话：88888888
		</p>
		<p>
			日期&nbsp;<input class="input_text" onclick="WdatePicker()"
				readonly="readonly" />&nbsp; 至&nbsp;<input class="input_text"
				onclick="WdatePicker()" readonly="readonly" />
			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input_but2 orange" id="cx"
				type="button" value="查询" />
		</p>

		<p>
			订单号&nbsp;<input class="input_text" type="text" />&nbsp;&nbsp;配送地址&nbsp;<select
				class="input_text"><option>&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
		</p>

		<div>
			<table width="100%" border="1" cellspacing="0" align="center">
				<thead>
					<tr>
						<th style="display: none">ID</th>
						<th style="display: none">用户ID</th>
						<th>订单编号</th>
						<th>商品名称</th>
						<th>验收日期</th>
						<th>单位</th>
						<th>实收量</th>
						<th>验收人</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${dispatchBill}" var="c">
						<tr>
							<td><input type="checkbox" name="box" onclick="checkBox()" /></td>
							<td>${c.OrderID}</td>
							<td>${c.ProductName}</td>
							<td>${c.AcceptTime}</td>
							<td>${c.ProductUnit}</td>
							<td>${c.PackagesNumber}</td>
							<td>${c.Accepter}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>


		<div class="pagin">
			<div class="message">
				共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<c:choose>
					<c:when test="${page.currentPage==1}">
						<li class="paginItem current"><a href="#"><span
								class="pagepre"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/web/merchant/myStatement.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
								class="pagepre"></span> </a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a></li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/merchant/myStatement.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/merchant/myStatement.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<input class="input_but1 orange" type="button" value="确认提交" id="qrtj" />
	</div>



</body>
</html>
