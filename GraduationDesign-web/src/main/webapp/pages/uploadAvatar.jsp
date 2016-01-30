<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="zh-cn">
<head>
<meta name="author" content="EdieLei" />
<script type="text/javascript" src="<%=path%>/js/redjs/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/uploadPreview.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/public.css" />
<%-- <script language="javascript" type="text/javascript" src="<%=path%>/js/jquery.js"></script> --%>
<script type="text/javascript">
/* function upload(){
	var img = $("#show").val();
	var   i = img.lastIndexOf('.');
	var   len = img.length;
	var   str = img.substring(len,i+1);
	var   extName = "JPG,GIF,PNG,JPEG,BMP";
	if(extName.indexOf(str.toUpperCase()) < 0)  {    
  	alert("请选择正确的图片文件!");  
  	return; 
  	}
	if(img == null || img == ""){
		$("#msg").text("请选择要上传的头像");
	}else{
		$("#form1").submit();
	}
}  */
$(function(){
 new uploadPreview({ UpBtn: "file", DivShow: "imgdiv", ImgShow: "img" });
});
</script>
<style type="text/css">
#upA {
	width: 220px;
	height: 270px;
	background: #fff none repeat scroll 0 0;
	border: 1px solid #d3d3d3;
	border-radius: 0 5px 5px;
	box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, 0.5);
	padding: 2em;
	z-index: 2;
	margin: 30px 10px;
}

#upAnew {
	background-color: #f5f5f5;
	border: 1px solid #cfcfcf;
	border-radius: 6px 6px 0 0;
	float: left;
	font-size: 14px;
	font-weight: bold;
	margin-left: 10px;
	margin-top: 3px;
	text-align: center;
	width: 100px;
	height: 20px;
	padding-top: 5px;
	color: #999;
}
</style>
</head>
<body>
	<div class="inner_div">
		<div id="upAnew">更改头像</div>
		<div id="upA">
			<form action="uploadAvatar.do" method="post" id="form1"
				enctype="multipart/form-data">
				<input id="file" type="file" name="userPhoto" />
				<!-- onchange="yulans()" -->
				<div id="imgdiv">
					<img id="img"
						style="width: 200px; height: 200px; border: 1px solid #999;"
						src="<%=path%>/images/redimg/sctx.jpg" alt="请先选择浏览图片才可预览">
				</div>
				<br /> <br /> <input style="width: 100px; height: 23px;"
					class="orange" type="button" onclick="$('#form1').submit();"
					value="上传头像" />&nbsp;&nbsp; <span id="msg" style="color: red;"></span>
			</form>
			<!-- <form name="form5" id="form5" method="post" action="#">
<input type="file" name="file5" id="file5" onchange="preview5()"/>
</form> -->
			<!-- <script type="text/javascript">
function preview5(){
var x = document.getElementById("file5");
 if(!x || !x.value) return;
var patn = /\.jpg$|\.jpeg$|\.gif$/i;
if(patn.test(x.value)){ 
var y = document.getElementById("img5");
if(y){
y.src = "file://localhost/" + x.value;
}else{
var img=document.createElement("img");      img.setAttribute("src","file://localhost/"+x.value);
img.setAttribute("width","120");
img.setAttribute("height","90");
img.setAttribute("id","img5");
document.getElementById("form5").appendChild(img);
 }
}else{
alert("您选择的似乎不是图像文件。");
}}
</script> -->
		</div>
	</div>
</body>
</html>