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
%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/wjmm.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
//获取选中box的ID
	function getId() {
			var ids = [];
			 $('input[name="box"]:checked').each(function(){
          		 ids.push($(this).val());
          
     			});
     		return ids;
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

function queren(){
		var fileIds=''; 
		$("input[name=box]:checked").each(function() {			
				var ids=$(this).val();
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0){
			alert("请选择");
			return;
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		$.ajax({
		type:"POST",
		url:"reconciliation.do",
		dataType:"text",
		data:{
			"ids":fileIds
		},
		success : function(data) {
		var json =eval('(' + data + ')');
			if(json.result="true"){
			//$("#cb").html(json.companyBalance);
			location.href="financeInfo.do?fileIds="+fileIds;
			} 
		}
		});
}

function pay(){
		var fileIds=''; 
		$("input[name=box]:checked").each(function() {			
				var ids=$(this).val();
				
				//alert(ids);
				fileIds += ids+ ",";			
		});
		if(fileIds.length==0){
			alert("请选择");
			return;
		}
		//判断账单是否对过账，已对账的才能结算
		
		fileIds = fileIds.substring(0, fileIds.length - 1);
		$.ajax({
		type:"POST",
		url:"iWantPay.do",
		dataType:"text",
		data:{
			"ids":fileIds
		},
		success : function(data) {
		var json =eval('(' + data + ')');
			if(json.result="true"){
			//$("#cb").html(json.companyBalance);
			/* if(json.status == 0){
				alert("请先对账");
			}else{ */
				location.href="statement.do?fileIds="+fileIds;
			/* } */
			} 
		}
		});
}
</script>
<style type="text/css">
.qrtj {
	height: 25px;
	width: 100px;
	font-size: 14px;
	color: white;
	margin: 10px 20px;
}

tr {
	border: 1px solid #999;
}

td {
	/*     text-align: center; */
	height: 30px;
}

th {
	border: 1px solid #999;
}
</style>

</head>

<body>

	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">结算管理 ></span><span
				class="lo2">对账详情</span>
		</div>

		<p align="center">对账单明细</p>
		<div>
			<table width="100%" cellspacing="0" align="center">
				<thead>
					<tr style="background-color: #E0E0E0;">
						<th style="display: none">ID</th>
						<th style="display: none">公司ID</th>
						<th>发货单号</th>
						<th>商品名称</th>
						<th>供应商</th>
						<th>价格</th>
						<th>实收数量</th>
						<th>金额小计</th>
						<th>对账人</th>
						<th>对账时间</th>
						<th>备注</th>
						<!-- <th>状态</th> -->
						<!-- <th>操作</th> -->
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${cbs}" var="c">
						<tr>
							<td style="display: none">${c.ID}</td>
							<td style="display: none">${c.CompanyID}</td>
							<td align="center">${c.DispatchBillID}</td>
							<td>${c.ProductName}</td>
							<td>${c.SupplierName}</td>
							<td align="right">${c.UnitPrice}</td>
							<td align="right">${c.PackagesNumber}</td>
							<td align="right">${c.Amount}</td>
							<td align="center">${c.AccepterUserName}</td>
							<td align="right">${c.AcceptTime}</td>
							<td align="right"></td>
							<%-- <td name="status" align="center">
						<c:choose>
							<c:when test="${c.STATUS==0}">
							未对账
							</c:when>
							<c:when test="${c.STATUS==1}">
							已对账
							</c:when>
						</c:choose>
						</td> --%>
							<!-- <td><a href="financialSettlement.do">对账详情</a></td> -->
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br />

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
							href="/ssm/merchant/financialSettlement.do?id=${id}&&currentPage=${page.currentPage-1}"><span
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
								href="/ssm/merchant/financialSettlement.do?id=${id}&&currentPage=${s3}">${s3}</a>
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
							href="/ssm/merchant/financialSettlement.do?id=${id}&&currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>

		</div>
		<hr style="color: red; border: 1px solid; margin-top: 50px;" />
		<input class="orange qrtj" type="reset" value="返回上页"
			onclick="history.back()" />
	</div>





</body>
</html>
