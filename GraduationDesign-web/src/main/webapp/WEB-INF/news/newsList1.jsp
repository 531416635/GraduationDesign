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
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});
</script>


</head>


<body>

	<div class="rightinfo">

		<div class="tools">

			<ul class="toolbar">
				<li class="click"><a class="tablelink"
					href="/GraduationDesign/news/toAddNew.do?newType=1"><span><img
							src="../images/t01.png" /></span>添加</a></li>
				<li><span><img src="../images/t03.png" /></span>删除</li>
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th><input name="" type="checkbox" value="" checked="checked" />全选</th>
					<th>序号</th>
					<th>新闻标题</th>
					<th>发布时间</th>
					<th>发布人</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${news}" var="c">
					<tr>
						<td><input name="" type="checkbox" value="" /></td>
						<td>${c.newsIndex}</td>
						<td>${c.title}</td>
						<td><fmt:formatDate value="${c.releaseTime}"
								pattern="yyyy/MM/dd" /></td>

						<td>${c.publishers}</td>
						<td>${c.status}</td>
						<td><a class="tablelink" href="#">修改</a> <a class="tablelink"
							href="/GraduationDesign/news/deleteNew.do?id=${c.id}&&newType=${c.newType}">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


		<div class="pagin">
			<div class="message">
				共<i class="blue">1256</i>条记录，当前显示第&nbsp;<i class="blue">2&nbsp;</i>页
			</div>
			<ul class="paginList">
				<li class="paginItem"><a href="javascript:;"><span
						class="pagepre"></span></a></li>
				<li class="paginItem"><a href="javascript:;">1</a></li>
				<li class="paginItem current"><a href="javascript:;">2</a></li>
				<li class="paginItem"><a href="javascript:;">3</a></li>
				<li class="paginItem"><a href="javascript:;">4</a></li>
				<li class="paginItem"><a href="javascript:;">5</a></li>
				<li class="paginItem more"><a href="javascript:;">...</a></li>
				<li class="paginItem"><a href="javascript:;">10</a></li>
				<li class="paginItem"><a href="javascript:;"><span
						class="pagenxt"></span></a></li>
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
	$('.tablelist tbody tr:odd').addClass('odd')
	</script>

</body>

</html>
