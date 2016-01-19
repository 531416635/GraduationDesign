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
<!-- <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script> -->
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/nicEdit.js"></script>
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
 bkLib.onDomLoaded(function() {
		new nicEditor({fullPanel : true}).panelInstance('content',{hasPanel : true}).removeInstance('content');
	}); 

/* $(function(){
	print();
});

function print()
{
	html2canvas( $("#content") , 
	{
  		onrendered: function(canvas) 
  		{   var name=$("#title").val();
    		$('#down_button').attr( 'href' , canvas.toDataURL() ) ;
    		$('#down_button').attr( 'download' , name+'.pdf' ) ;
    		//$('#down_button').css('display','inline-block');
  		}
  	});
} */
</script>
<style type="text/css">
 #yangs{
	/* position: absolute; */
    width:1128px;
	margin: 10px auto;
} 
#title{
	font-size: 24px;
	font-style: inherit;
}
</style>
</head>
<body>
	<div id="yangs">
	<%-- 	<textarea id="content" cols="140"  value="${faq.answer}"></textarea> --%>
		<div id="content" cols="100" name="answer" style="width:100%;">
			<input style="width:100%; text-align: center;" type="text"
				name="title" id="title" value="${faq.title}" readonly="readonly" /><br />
			<div style="text-align:center;">${faq.answer}</div>
			<c:if test="${faq.title=='采购商操作说明'}">
				<div style="text-align:center;">
					<a style="font-size:16px;color:blue;"
						href="<%=path%>/web/downloadPDF.do?filePath=/editor/采购商操作手册.pdf">点击下载链接进行操作说明下载</a>
				</div>
			</c:if>
			<c:if test="${faq.title=='供应商操作说明'}">
				<div style="text-align:center;">
					<a  style="font-size:16px;color:blue;"
						href="<%=path%>/web/downloadPDF.do?filePath=/editor/供应商用户操作手册.pdf">点击下载链接进行操作说明下载</a>
				</div>
			</c:if>
		</div>

	</div>
</body>
</html>