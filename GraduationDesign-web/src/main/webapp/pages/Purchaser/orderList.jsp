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
	function click(it) {
		alert(it);
	}
	$(document).ready(function() {
		$(".click").click(function() {
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

		$(".sure").click(function() {
			$(".tip").fadeOut(100);
		});

		$(".cancel").click(function() {
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
				window.location.href = "productsList.do";
			}
		};
		xhr.open("post", "allDeleteDis.do", true);
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

	function checkBox() {

		var checkObjs1 = $(":checkbox[name='box']:checked");
		var checkObjs2 = $(":checkbox[name='box']");
		if (checkObjs1.length == checkObjs2.length) {
			document.getElementById("checkAll").checked = true;
		} else {
			document.getElementById("checkAll").checked = false;
		}
	}
</script>


</head>


<body>

	<div class="rightinfo">

		<div class="tools">

			<ul class="toolbar">
				<!--   <li><a class="tablelink" href="/GraduationDesign/products/toAddProduct.do"><span><img src="../images/t01.png" /></span>添加</a></li>
        <li><a class="tablelink" href="#" onclick="checkDeletes();"><span><img src="../images/t03.png" /></span>删除</a></li> -->
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th>货品</th>
					<th>单价</th>
					<th>数量</th>
					<th>总金额</th>
					<th>订单状态</th>
					<th>交易操作</th>
					<th>交易日期</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${orders}" var="d">
					<tr>
						<td>${d.productName}</td>
						<td>${d.unitPrice}</td>
						<td>${d.quantity}</td>
						<td align="right">${d.totolAmount}</td>
						<td><c:choose>
								<c:when test="${d.status==0}">待付款</c:when>
								<c:when test="${d.status==1}">待发货</c:when>
								<c:when test="${d.status==2}">待收货</c:when>
								<c:when test="${d.status==3}">待评价</c:when>
								<c:when test="${d.status==4}">交易成功</c:when>
							</c:choose></td>
						<td><a href="#">查看评价</a>&nbsp;<a href="#">验收情况</a>&nbsp;<!-- <a href="#">申请售后</a> -->
						</td>
						<td>${d.deliveryDate}</td>
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
							href="/GraduationDesign/main/orderList.do?currentPage=${page.currentPage-1}&&userId=${userId}"><span
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
								href="/GraduationDesign/main/orderList.do?currentPage=${s3}&&userId=${userId}">${s3}</a>
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
							href="/GraduationDesign/main/orderList.do?currentPage=${page.currentPage+1}&&userId=${userId}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>




	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>



