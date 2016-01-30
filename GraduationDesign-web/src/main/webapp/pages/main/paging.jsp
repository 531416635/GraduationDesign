<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="pagin">
	<div class="message">
		共<i class="blue">${page.totalPage}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
	</div>
	<ul class="paginList">
		<c:choose>
			<c:when test="${page.currentPage==1}">
				<li class="paginItem current"><a href="#"><span
						class="pagepre"></span></a></li>
			</c:when>
			<c:otherwise>
				<li class="paginItem"><a
					href="/ssm/products/productsList.do?currentPage=${page.currentPage-1}"><span
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
						href="/ssm/products/productsList.do?currentPage=${s3}">${s3}</a></li>
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
					href="/ssm/products/productsList.do?currentPage=${page.currentPage+1}"><span
						class="pagenxt"></span></a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
