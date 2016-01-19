<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link rel="stylesheet" type="text/css" href="../css/frontcss/public.css" />
<link rel="stylesheet" type="text/css" href="../css/frontcss/wjmm.css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
var InterValObj; //timer变量，控制时间
var count = 60; //间隔函数，1秒执行
var curCount;//当前剩余秒数

function check1() {
curCount = count;
var ty = $("#email").val();
var reg=/^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/;
if(ty == null || ty == ""){
alert("请输入邮箱");
return;
}
if(!reg.test(ty)){
			//用户名格式不正确，提示错误信息
			alert("邮箱格式不正确");
			return;
			}
		$.ajax({
			type : "POST",
			url : "verification.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "fscg") {
					//设置button效果，开始计时
				     $("#yzm").attr("disabled", "true");
				     $("#yzm").val("请在" + curCount + "秒内输入验证码");
				     InterValObj = window.setInterval(SetRemainTime2, 1000); //启动计时器，1秒执行一次
				} 
			}
		});
		
	}
	
		function check2() {
		var email = $("#email").val();
		var tel = $("#tel").val();
		if(email != null && email != ""){
		$.ajax({
			type : "POST",
			url : "aqrz.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "success") {
					location.href = "toReset.do";
					return;
				} else if (data == "fail") {
					$("#msg").text("验证码错误");
				}
			}
		});
		}
		if(tel!=null && tel!=""){
		$.ajax({
			type : "POST",
			url : "phoneCheck.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
				if (data == "success") {
					location.href = "toReset.do";
					return;
				} else if (data == "fail") {
					$("#msg").text("验证码错误");
				}
			}
		});
		}
	}
//-------------------------------发送手机验证码
function sendMsg(){
curCount = count;
var asd = $("#tel").val();
var reg=/^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
if(asd == null || asd == ""){
alert("请输入手机号");
return;
}
if(!reg.test(asd)){
			//用户名格式不正确，提示错误信息
	alert("手机号不存在");
	return;
}
	$.ajax({
			type : "POST",
			url : "sendTelCode.do",
			dataType : "text",
			data : $("#form").serialize(),
			success : function(data) {
			var json =eval('(' + data + ')');
			alert(json.result);
				if (json.result == "fscg") {
					//设置button效果，开始计时
				     $("#btn").attr("disabled", "true");
				     $("#btn").val("请在" + curCount + "秒内输入验证码");
				     InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
				} 
			}
	});
}	
	
//timer处理函数
function SetRemainTime() {
            if (curCount == 0) {                
                window.clearInterval(InterValObj);//停止计时器
                $("#btn").removeAttr("disabled");//启用按钮
                $("#btn").val("重新发送验证码");
            }
            else {
                curCount--;
                $("#btn").val("请在" + curCount + "秒内输入验证码");
            }
        }
        
function SetRemainTime2() {
            if (curCount == 0) {                
                window.clearInterval(InterValObj);//停止计时器
                $("#yzm").removeAttr("disabled");//启用按钮
                $("#yzm").val("重新发送验证码");
            }
            else {
                curCount--;
                $("#yzm").val("请在" + curCount + "秒内输入验证码");
            }
        }        
</script>
<style type="text/css">
input[type=text]{
	font-size: 16px;
}
</style>

</head>

<body>

	<div class="warp">
		<div class="location">
			<span class="lo1">首页</span> > <span class="lo2">找回密码</span>
		</div>
		<div class="common-bag">
			<div class="common-tit">
				<h1>找回密码</h1>
			</div>

			<div class="formdiv">
				<h1>验证方式一:</h1>

				<form action="aqrz.do" method="post" id="form">
					<p>
						邮&nbsp;&nbsp;&nbsp;箱 : <input placeholder="&nbsp;请输入您的邮箱" type="text" name="email" id="email"
							class="search-input" />
					</p>
					<br />
					<p>
						验证码 : <input type="text" name="yzm" class="search-input1" /> <input
							type="button" value="发送验证码" class="sub3"  onclick="check1();" id="yzm"/><span style="color: red;" id="msg1"></span>
					</p>

					<br /> <br />
					<h1>验证方式二:</h1>

					<p>
						手机号 : <input  placeholder="&nbsp;请输入您的手机号" type="text" name="tel" class="search-input" id="tel"/>
					</p>
					<br />
					<p>
						验证码 : <input type="text" name="yzm2" class="search-input1" /> <input
							type="button" value="发送短信" class="sub3" onclick="sendMsg();" id="btn"/><span style="color: red;" id="msg2"></span>
					</p>
					<br />
				<span style="color: red;" id="msg"></span>
					<input type="button" value="下一步" class="sub1" onclick="check2();" />
				</form>


			</div>

		</div>

	</div>





</body>
</html>
