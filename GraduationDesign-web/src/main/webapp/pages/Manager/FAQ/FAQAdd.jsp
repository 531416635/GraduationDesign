<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String json = (String) request.getAttribute("json");
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>

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
		<form action="FAQAdd.do" method="post" enctype="multipart/form-data"
			id="form">
			<table style="border: 1px solid #d7d7d7;width: 90%;">
				<tr>
					<th>问题类别:</th>
					<td><select name="questionType">
							<c:forEach items="${questionType}" var="c">
								<option value="${c.id}">${c.typeName}</option>

							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>标题:</th>
					<td><input type="text" name="title" required="required" />
					</td>
				</tr>
				<tr>
					<th>显示序列:</th>
					<td><input type="text" name="showIndex"
						onkeyup="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
						onafterpaste="this.value=this.value.replace(/^0/,'').replace(/\D/g,'')"
						required="required" />
					</td>
				</tr>
				<!-- <tr>
			<th>创建时间:</th>
		</tr> -->
				<tr>
					<th>创建者:</th>
					<td>${user.userName } <input type="hidden" name="createBy"
						value="${user.id }" /></td>
				</tr>
				<tr>
					<th>问题回答:</th>
					<td colspan="3"><textarea id="content" cols="100"
							name="answer"></textarea></td>
				</tr>
			</table>
			<input type="submit" value="增加"
				onclick="$('#content').val($('.nicEdit-main').html());save();" /> <input
				type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>
