<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
img {
	display: inline;
}
</style>
<script type="text/javascript">
	window.onload = function() {
		/* 
		 alert($("#picContent").text().replace(/\s+/g, "")); */

		if ($("#picContent").text().trim() == null
				|| $("#picContent").text().trim() == "") {
			$("#span").text("页面无图片详情，请及时上传！");

		}
		;

	}
</script>
</head>
<body>
	<div>
		商品图片详情： <br /> <span id="span" style="color: red;"></span>
		<div id="picContent">
			<c:forEach items="${companyProductPic}" var="c1">
				<c:if test="${c1.fileClass==1 }">

					<img id="img" src="<%=path%>${c1.filePath }" alt="Thumbnail 1"
						class="zoom-tiny-image" />
					<a
						href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c1.filePath }&id=${companyProductId}">下载</a>
				</c:if>

			</c:forEach>
		</div>
	</div>
	<div>
		<c:forEach items="${companyProductPic}" var="c">

			<c:if test="${c.fileClass==2 }">食品安全资质：
				<img id="img" src="<%=path%>${c.filePath }" alt="Thumbnail 1" />
				<a
					href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c.filePath }&id=${companyProductId}"">下载</a>
			</c:if>
			<c:if test="${c.fileClass==3 }">生产许可证：
				<img id="img" src="<%=path%>${c.filePath }" alt="Thumbnail 1" />
				<a
					href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c.filePath }&id=${companyProductId}"">下载</a>

			</c:if>
			<c:if test="${c.fileClass==4 }">QS商城许可证：
				<img id="img" src="<%=path%>${c.filePath }" alt="Thumbnail 1" />
				<a
					href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c.filePath }&id=${companyProductId}"">下载</a>
			</c:if>
			<c:if test="${c.fileClass==5 }">检测报告：
				<img id="img" src="<%=path%>${c.filePath }" alt="Thumbnail 1" />
				<a
					href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c.filePath }&id=${companyProductId}"">下载</a>
			</c:if>
			<c:if test="${c.fileClass==6 }">品牌资质授权：
				<img id="img" src="<%=path%>${c.filePath }" alt="Thumbnail 1" />
				<a
					href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c.filePath }&id=${companyProductId}"">下载</a>
			</c:if>
			<c:if test="${c.fileClass==7 }">厂家代理授权：
				<img id="img" src="<%=path%>${c.filePath }" alt="Thumbnail 1" />
				<a
					href="/GraduationDesign/companyProducts/downloadFile.do?filePath=${c.filePath }&id=${companyProductId}"">下载</a>
			</c:if>
		</c:forEach>
	</div>
</body>

</html>
