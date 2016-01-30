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

</head>


<body>

	<div class="rightinfo">

		<div class="tools">
			<form action="searchSupplierAuthenticationInfo.do" method="post">
				<table style="border: 1px solid #999; padding: 3px;">
					<tr>
						<td><input type="text" name="companyName"
							value="${companyName}" /><input type="submit" value="搜索" /></td>
					</tr>
				</table>
			</form>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th style="display: none">ID</th>
					<th>公司名称</th>
					<th>公司规模</th>
					<th>公司电话</th>
					<th>公司网址</th>
					<th>状态</th>
					<th>公司联系人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${companys}" var="c">
					<tr>
						<td style="display: none">${c.id}</td>
						<td><a href="/ssm/findSupplierInfo.do?id=${c.id}">${c.companyName}</a></td>
						<td>${c.companyScale}</td>
						<td>${c.companyTel}</td>
						<td>${c.companyWebsite}</td>
						<td><c:choose>
								<c:when test="${c.status==1}">已认证</c:when>
								<c:when test="${c.status==0}">未认证</c:when>
								<c:when test="${c.status==2}">等待系统认证</c:when>
							</c:choose></td>
						<td>${c.companyContact}</td>
						<td><a class="tablelink"
							href="/ssm/supplierAuthenticationInfo.do?companyId=${c.id}">认证信息</a>
						</td>
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
							href="/ssm/supplierAuthentication.do?currentPage=${page.currentPage-1}"><span
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
								href="/ssm/supplierAuthentication.do?currentPage=${s3}">${s3}</a>
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
							href="/ssm/supplierAuthentication.do?currentPage=${page.currentPage+1}"><span
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

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
