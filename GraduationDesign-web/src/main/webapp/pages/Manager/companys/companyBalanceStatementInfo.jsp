<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">
$('.tablelist tbody tr:odd').addClass('odd');
	function getId() {
		var fileIds = "";
		$("input[name=box]").each(function() {
			if ($(this).attr("checked") == true) {
				fileIds += $(this).val() + "@";
			}
		});
		if (fileIds == "") {
			alert("请选择需要删除的项!");
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		return fileIds;
	}
	function getXhr() {
		var xhr = null;
		if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		} else {
			xhr = new ActiveXObject('Microsoft . XMLHTTP');
		}
		return xhr;
	}
	function getText() {
		var xhr = getXhr();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				alert("确定要删除吗?");
				window.location.href = "findSupplierBalance.do";
			}
		};
		xhr.open("post", "allDeleteBalance.do", true);
		xhr.setRequestHeader('content-type',
				'application/x-www-form-urlencoded');
		var countId = getId();
		xhr.send("Uid=" + countId);
	}

	function checkAll() {
		var ischecked = document.getElementById("checkAll").checked;
		if (ischecked) {
			checkallbox();
		} else {
			discheckallbox();
		}
	}
	function checkallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = true;
		}
	}
	function discheckallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = false;
		}
	}
	//----------------------------------------对账
	function duizhang(id,amount,discount,companyId,stateType){
		//$("#form").submit();
		location.href="balanceOfAccount.do?id="+id+"&&amount="+amount+"&&discount="+discount+"&&companyId="+companyId+"&&stateType="+stateType;
	}
	
	//---------------------------------------发票签收	
	function qianshou(tmpStatementId,companyId){
		location.href="supplys/invoiceSign.do?tmpStatementId="+tmpStatementId+"&&companyId="+companyId;
	}
	//----------------------------------------发票寄出
		function fapiao(tmpStatementId,companyId){
		location.href="supplys/purchaserInvoiceSend.do?tmpStatementId="+tmpStatementId+"&&companyId="+companyId;
	}
	//---------------------------------------发票申请
		function shenqing(tmpSettledAmount,tmpCompanyId,tmpStatementId){
		location.href="supplys/toInvoiceAdd.do?tmpSettledAmount="+tmpSettledAmount+"&&tmpCompanyId="+tmpCompanyId+"&&tmpStatementId="+tmpStatementId;
		}
</script>
<style type="text/css">
th {
	align: center;
}
</style>

</head>


<body>

	<div class="rightinfo">

		<!-- <div class="tools">
			<ul class="toolbar">
				<li class="click"><span><img src="images/t01.png" /> </span><a
					href="/ssm/toInsertSupplierBalance.do">添加</a></li>
				<li><a class="tablelink" href="#" onclick="getText();"><span><img
							src="images/t03.png" />
					</span>删除</a>
				</li>
			</ul>
		</div> -->

		<table class="tablelist">
			<thead>
				<tr>
					<th style="display: none">ID</th>
					<th style="display: none">公司ID</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>币种</th>
					<th>金额</th>
					<th>折扣</th>
					<th>结算金额</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${cbs}" var="c">
					<tr>
						<td style="display: none"><input name="id" value="${c.id}" /></td>
						<td style="display: none"><input name="companyId"
							value="${c.companyId}" /></td>
						<td>${c.startTime}</td>
						<td>${c.endTime}</td>
						<td>${c.currency}</td>
						<td align="right"><c:if test="${c.stateType==1}">
						${c.amount}
						</c:if> <c:if test="${c.stateType==2}">
						${-c.amount}
						</c:if></td>
						<td><input name="discount" id="discount${c.id}" type="text"
							value="${c.discount}" /></td>
						<%-- 	<td align="right">
							<c:choose>
								<c:when test="${c.settledAmount==null || c.settledAmount==''}">
									0
								</c:when>
								<c:otherwise>								
									${c.settledAmount}
								</c:otherwise>
							</c:choose>
						</td> --%>
						<td align="right"><c:if test="${c.stateType == 1}">
						${c.settledAmount}
						</c:if> <c:if test="${c.stateType == 2}">
						${-c.settledAmount}
						</c:if></td>
						<td>
							<!--<input readonly="true" name="status"/> --> <c:choose>
								<c:when test="${c.status==0}">未对账</c:when>
								<c:when test="${c.status==1}">已对账</c:when>
								<c:when test="${c.status==2}">系统对账</c:when>
								<c:when test="${c.status==3}">发票已申请</c:when>
								<c:when test="${c.status==4}">发票已寄出</c:when>
								<c:when test="${c.status==5}">发票已签收</c:when>
							</c:choose>
						</td>
						<td><c:if test="${c.status==0}">
								<input type="button" value="对账"
									onclick='duizhang(${c.id},${c.amount},$("#discount"+"${c.id}").val(),${c.companyId},${c.stateType});' />
							</c:if> <c:if test="${c.stateType == 1}">
								<c:if test="${c.status==2}">
									<input type="button" value="申请发票"
										onclick="shenqing(${c.settledAmount},${c.companyId},${c.id})" />
								</c:if>
								<c:if test="${c.status==4}">
									<input type="button" value="发票签收"
										onclick="qianshou(${c.id},${companyId})" />
								</c:if>
							</c:if> <c:if test="${c.stateType == 2}">
								<c:if test="${c.status==3}">
									<input type="button" value="发票寄出"
										onclick="fapiao(${c.id},${c.companyId})" />
								</c:if>
							</c:if></td>
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
								class="pagepre"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/companyBalanceLog.do?currentPage=${page.currentPage-1}&&id=${companyId}"><span
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
								href="/ssm/companyBalanceLog.do?currentPage=${s3}&&id=${companyId}">${s3}</a></li>
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
							href="/ssm/companyBalanceLog.do?currentPage=${page.currentPage+1}&&id=${companyId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>

		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="../images/ticon.png" /> </span>
				<div class="tipright">
					<p>是否确认对信息的修改 ？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>

		</div>




	</div>


</body>

</html>
