<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>


<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

.input_txt {
	width: 200px;
	height: 20px;
	line-height: 20px;
}

.info {
	height: 40px;
	line-height: 40px;
}

.info th {
	text-align: right;
	width: 65px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}

#div1 {
	position: absolute;
	top: 20%;
	margin-top: -50px;
	left: 40%;
	margin-left: -50px;
}
</style>
<script type="text/javascript" src="../js/nicEdit.js"></script>
<script type="text/javascript">
	bkLib.onDomLoaded(function() {
		nicEditors.allTextAreas();
	});
	function save(newType) {
	
		var title = $("#title").val();
		var content2 = $('.nicEdit-main').text();
		var releaseAging = $("#shixiao").val();
		if(title == null || title == ""){
		alert("请填写标题");
		return;
		}
		if(content2 == null || content2 == ""){
		alert("请填写内容");
		return;
		}
		
		if ($.trim(title).length != 0
				&& content2.match(/[\u4E00-\uFA29\uE7C7-\uE7F3a-zA-Z]+/g) != null) {
			/* document.forms[0].submit(); */
			if (newType == 1) {
				$.ajax({
					type : "POST",
					url : "addNew.do",
					dataType : "text",
					data : {title:title,
							content2:content2,
							releaseAging2:releaseAging,
							newType:newType
					},
					success : function(data, textStatus) {
						//提示
						if (data == "true") {
							alert("添加成功！");
						} else {
							alert("添加失败！");
						}
						location.href = "newsList.do";
					}
				});
			} else if (newType == 2) {
				$.ajax({
					type : "POST",
					url : "addNotice.do",
					dataType : "text",
					data : {title:title,
							content2:content2,
							releaseAging2:releaseAging,
							newType:newType
					},
					success : function(data) {
						//提示
						if (data == "true") {
							alert("添加成功！");
						} else {
							alert("添加失败！");
						}
						location.href = "noticeList.do";
						return;
					}
				});

			}
		}
	}
</script>
</head>
<body>
	<div id="div1">

		<form
			action="<c:choose>
    <c:when test="${newType==1}">addNew.do</c:when>
    <c:when test="${newType==2}">addNotice.do</c:when>
	</c:choose>"
			name="userForm" id="form" method="post">
			<input type="hidden" name="userId" id="userId" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>标题:</th>
					<td><input type="text" id="title" name="title"
						required="required" />
					</td>
				</tr>
				<tr class="info">
					<th>内容:</th>
					<td><textarea id="content" name="content" cols="35"
							style="width: 300px; height: 100px;"></textarea></td>
				</tr>
				<tr class="info">
					<th>发布时效:</th>
					<td><input id="shixiao" type="text" required="required" name="releaseAging"
						onclick="WdatePicker()" readonly="readonly" style="width:70px;" />
					</td>
				</tr>
				<tr class="info" style="display: none">
					<th>新闻序号:</th>
					<td><input type="text"  name="newsIndex" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="newType" value="${newType}" /> <input
				type="button" value="提交"
				onclick="$('#content').val($('.nicEdit-main').html());save('${newType}');" />

			<input type="reset" value="取消" onclick="history.back()">
		</form>
	</div>
</body>
</html>