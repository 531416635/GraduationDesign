<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link type="text/css" rel="stylesheet" href="<%=path%>/css/main.css" />
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

#div1 {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 20%;
	margin-left: -50px;
	width: 80%;
}

#content {
	width: 90%;
	height: 300px;
}
</style>
<script type="text/javascript">
	//图文编辑器
	bkLib.onDomLoaded(function() {
		new nicEditor().panelInstance('content');
	});
	function save() {
		var content = $(".nicEdit-main").text();
		//提交表单
		$("#form").submit;
	}
</script>
</head>
<body>
	<div id=div1>
		<form action="FAQUpdate.do" method="post"
			enctype="multipart/form-data" id="form">
			<input type="hidden" name="id" value="${FAQ.id}" />
			<table
				style="border: 1px solid #d7d7d7; width: 90%; text-align: left;">
				<tr>
					<th>问题类型:</th>
					<td><c:forEach items="${questionType }" var="q">
							<input type="radio" name="questionType" value="${q.id }"
								<c:if test="${q.id ==FAQ.questionType }">checked="checked"</c:if>>${q.typeName }
					</c:forEach></td>
				</tr>
				<tr>
					<th>问题名称:</th>
					<td><input type="text" name="title" value="${FAQ.title}" /></td>
				</tr>
				<tr>
					<th>显示序列:</th>
					<td><input type="text" name="showIndex"
						value="${FAQ.showIndex}" /></td>
				</tr>
				<tr>
					<th>问题回答:</th>
					<td colspan="3"><textarea id="content" cols="100"
							name="answer">${FAQ.answer}</textarea></td>
				</tr>
			</table>

			<input type="submit" value="修改"
				onclick="$('#content').val($('.nicEdit-main').html());save();" /> <input
				type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>
