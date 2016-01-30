<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起采</title>
<link type="text/css" rel="stylesheet" href="../css/main.css" />
<script type="text/javascript" src="../js/datePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
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
	function updates(newType) {
	 var title = $("#title").val(); 
	  var content2 = $('.nicEdit-main').text();	
	  var releaseAging = $("#shixiao").val();
	  var status = $("#st option:selected").val();
	  var id = $("#tt").val();
	  var releaseTime = $("#shij").val();
	  var publishers = $("#fub").val();
	  if($.trim(title).length !=0 && content2.match(/[\u4E00-\uFA29\uE7C7-\uE7F3a-zA-Z]+/g) !=null){
	 /*  $("#form").submit(); */
	 if(newType==1){
          $.ajax({
                	type: "POST",
             url: "updateNew.do",
             dataType:"text", 
             data: {title:title,
							content2:content2,
							releaseAging2:releaseAging,
							newType:newType,
							status:status,
							id:id,
							releaseTime2:releaseTime,
							publishers:publishers
					},
             success: function(data,textStatus){
             	//提示
                		if(data=="true") {
                			alert("更新成功！");
                		} else {
                			alert("更新失败！");
                		}
                		location.href="newsList.do";
                      }
                });
	  }else if(newType==2){
	  $.ajax({
             type: "POST",
             url: "updateNotice.do",
             dataType:"text", 
             data: {title:title,
							content2:content2,
							releaseAging2:releaseAging,
							newType:newType,
							status:status,
							id:id,
							releaseTime2:releaseTime,
							publishers:publishers
					},
             success: function(data){
             	//提示
                		if(data=="true") {
                			alert("更新成功！");
                		} else {
                			alert("更新失败！");
                		}
                		location.href="noticeList.do";
                		return;
                      }
         });
	  
	  }
	  } else{
	  alert("请务必填写标题与内容信息！");
	 
	  }   	
            }
            $(function(){
  var title=$("#title").val();
  
});
</script>

</head>
<body>


	<div id="div1">

		<form
			action="<c:choose>
    <c:when test="${news.newType==1}">updateNew.do</c:when>
    <c:when test="${news.newType==2}">updateNotice.do</c:when>
	</c:choose>"
			name="userForm" id="form" method="post">
			<input type="hidden" name="id" id="tt" value="${news.id}" />

			<table border="0" cellpadding="0" cellspacing="0">
				<tr class="info">
					<th>标题:</th>
					<td><input type="text" id="title" name="title"
						value="${news.title}" /></td>

				</tr>
				<script type="text/javascript">
var p=document.getElementById("title").val();
alert(p);
</script>
				<tr class="info">
					<th>内容:</th>
					<td><textarea cols="35" style="width: 300px; height: 100px;"
							id="content" name="content">${news.content}</textarea></td>
				</tr>

				<tr class="info">
					<th>发布时间:</th>
					<td><input id="shij" type="text" name="releaseTime"
						value="<fmt:formatDate value="${news.releaseTime}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker()" readonly="readonly" style="width: 70px;" /></td>
				</tr>
				<tr class="info">
					<th>发布时效:</th>
					<td><input id="shixiao" type="text" name="releaseAging"
						value="<fmt:formatDate value="${news.releaseAging}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker()" readonly="readonly" style="width: 70px;" /></td>
				</tr>

				<tr class="info">
					<th>发布人:</th>
					<td><input id="fabu" type="text" name="publishers"
						value="${news.publishers}" /></td>
				</tr>
				<tr class="info">
					<th>状态:</th>
					<%-- <td><input type="text" name="status" value="${news.status}" /></td> --%>
					<td><select name="status" id="st">
							<option value="0" <c:if test="${news.status==0}"> selected</c:if>>未发布</option>
							<option value="1" <c:if test="${news.status==1}"> selected</c:if>>已发布</option>
							<option value="2" <c:if test="${news.status==2}"> selected</c:if>>删除</option>
					</select></td>
				</tr>
				<tr class="info" style="display: none">
					<th>新闻序号:</th>
					<td><input type="text" name="newsIndex"
						value="${news.newsIndex}" /></td>
				</tr>
			</table>
			<input type="hidden" name="newType" value="${news.newType}" /> <input
				type="button" value="提交"
				onclick="$('#content').val($('.nicEdit-main').html());updates('${news.newType}');" />
			<input type="reset" value="取消" onclick="history.back()">
		</form>
	</div>

</body>
</html>