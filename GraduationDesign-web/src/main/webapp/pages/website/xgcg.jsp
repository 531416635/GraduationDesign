<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link rel="stylesheet" type="text/css" href="../css/frontcss/public.css" />
<link rel="stylesheet" type="text/css" href="../css/frontcss/wjmm.css" />
<style type="text/css">
#cg{
	background: url(../images/frontimages/button-red.png) no-repeat;
	border: none;
	width: 300px;
	height: 40px;
	margin-top: 20px;
	margin-bottom: 15px;
	font-size: 20px;
	color: white;
	margin-top: 10%;
	margin-left: 20%;
	margin-right: auto;
	margin-bottom: auto;
}
#pp{
	margin-top: auto;
	margin-left: 23%;
	margin-bottom: 10%;
}
</style>
</head>

<body>

<div class="warp">
   <div class="location">
      <span class="lo1">首页</span>
      >
      <span class="lo2">找回密码</span>
  </div>
  <div class="common-bag">
      <div class="common-tit">
         <h1>找回密码</h1>
      </div>
      
      <div class="formdiv">
         <form action="/ssm/web/ljdl.do" method="post">
           <input type="submit" name="czmm" id="cg" value="点击登录"/><br/><br/>
           <p id="pp">重置密码成功！请记下您的密码以防丢失</p>
         </form>

      </div>
      
  </div>
</div>





</body>
</html>
