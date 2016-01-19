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
	href="<%=path%>/css/frontcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="../js/frontjs/lanrenzhijia.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript">
	//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor().panelInstance('content');
	});
</script>
</head>

<body>
	<div class="warp">
			<div class="detail_list">
			<ul id="tabs">
				<li><a href="#">用户合作协议</a></li>
			</ul>
			<div id="content">
				<div id="tab1">
						<table style="border: 1px solid #d7d7d7;width: 100%;">
							<tr>
								<td colspan="5"><textarea id="content" cols="100"
										style="width:90%; height: 300px;" name="productInfo"></textarea>
								</td>
							</tr>
							
						</table>
			     </div>
			 </div>
		 </div>
	</div>
	
	<script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
</body>
</html>
