<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE >
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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/houtai.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
var InterValObj; //timer变量，控制时间
var count = 60; //间隔函数，1秒执行
var curCount;//当前剩余秒数
	function test() {
		alert($('#').val());
	}

	bkLib.onDomLoaded(function() {
		nicEditors.allTextAreas();
	});
	function save() {
		$.ajax({
			type : "POST",
			url : "productEdit.do",
			dataType : "text",
			data : $('#form').serialize(),
			success : function(data, textStatus) {
				//提示
				if (data == "true") {
					alert("添加成功！");
				} else {
					alert("添加失败！");
				}
				location.href = "myProducts.do";
			}
		});
	}
	//-------------------显示/隐藏切换	
	function displayDiv() {
		$("#sj").toggle();
	}
	function displayDiv2() {
		$("#yx").toggle();
	}
	function displayDiv3() {
		 $("#mima").toggle();
	} 
	

	//-----------------------手机验证码
	function send() {
	curCount = count;
	var phone = $("#phone").val();
	var reg =/^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
	if(phone == null || phone == ""){
		alert("请输入手机号");
		return;
	}
	if(!reg.test(phone)){
		alert("手机号不正确");
		return;
	}
		$.ajax({
			type : "post",
			url : "telCode.do",
			dataType : "text",
			data : $("#form1").serialize(),
			success : function(data) {
				if (data == "done") {
					//设置button效果，开始计时
				     $("#btn").attr("disabled", "true");
				     $("#btn").val("请在" + curCount + "秒内输入验证码");
				     InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
				}
			}
		});
	}
	//------------------------邮箱验证码
	function sendMail() {
	curCount = count;
	var email = $("#mail").val();
	var reg=/^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$/;
	if(email == null || email == ""){
		alert("请输入邮箱");
		return;
	}
	if(!reg.test(email)){
		alert("邮箱格式不正确");
		return;
	}
		$.ajax({
			type : "post",
			url : "sendMail.do",
			dataType : "text",
			data : $("#form2").serialize(),
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
	//--------------------校验手机号
	function check() {
		$.ajax({
			type : "post",
			url : "checkTel.do",
			dataType : "text",
			data : $("#form1").serialize(),
			success : function(data) {
				if (data == "success") {
					$("#msg1").text("验证成功");
					alert("已绑定手机号");
					location.reload();
				}
				if (data == "fail") {
					$("#msg1").text("验证码错误");
				}
			}
		});
	}
	//--------------------校验邮箱
	function check2() {
		$.ajax({
			type : "post",
			url : "checkMail.do",
			dataType : "text",
			data : $("#form2").serialize(),
			success : function(data) {
				if (data == "success") {
					$("#msg2").text("验证成功");
					alert("已绑定邮箱");
					location.reload();
				}
				if (data == "fail") {
					$("#msg2").text("验证码错误");
				}
			}
		});
	}
	//------------------------------------
	function check3() {
		$.ajax({
			type : "post",
			url : "chageAccountPsw.do",
			dataType : "text",
			data : $("#form3").serialize(),
			success : function(data) {
				if (data == "nullError") {
					$("#msg3").text("请输入原始密码！");
				} else if (data == "pwdError") {
					$("#msg3").text("原始密码不正确！");
				} else if (data == "null2Error") {
					$("#msg3").text("请输入新密码！");
				} else if (data == "null3Error") {
					$("#msg3").text("请确认密码！");
				} else if (data == "confirmError") {
					$("#msg3").text("两次输入的密码不一致！");
				} else if (data == "success") {
					$("#msg3").text("恭喜您修改密码成功！");
					location.reload();
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
#bc {
	background-color: #C01000;
	height: 30px;
	width: 120px;
	margin-left: 10%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

#qr {
	background-color: #FF4030;
	height: 30px;
	width: 120px;
	margin-left: 2%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

#qx {
	background-color: orange;
	height: 30px;
	width: 120px;
	margin-left: 2%;
	margin-right: 50px;
	font-size: 14px;
	color: white;
}

.inner_div p {
	background-color: #F0F0F0;
	padding-left: 10px;
	font-size: 14px;
	margin-top: 5px;
	height: 30px;
	line-height: 30px;
}

p span {
	float: right;
	color: red;
	margin-top: 0%;
	cursor: pointer;
}

.mima {
	width: 200px;
	height: 20px;
	background-color: green;
	font-size: 14px;
	text-align: center;
	color: white;
}

#sj, #yx, #mima {
	display: none;
	font-size: 14px;
	margin-left: 50px;
	line-height: 35px;
}

input {
	width: 200px;
	height: 23px;
	/*  margin-right: 20px; */
}

.input_but1 {
	width: 150px;
	height: 23px;
}

.input_but2 {
	width: 70px;
	height: 23px;
}

div button {
	background-color: #E05010;
}

td {
	padding-right: 10px;
}
</style>
</head>
<body>
	<div class="inner_div">
		<div
			style="height: 45px; line-height: 45px; border-bottom: 1px solid #D1D1D1; font-size: 14px; padding-left: 15px;">
			<span class="lo1">首页</span> > <span class="lo2">账户管理 ></span><span
				class="lo2"> 账户安全</span>
		</div>
		<%-- <c:if test="${userinfo.parentID == null || userinfo.parentID == '' }"> --%>

		<form action="chageAccountPsw.do" method="post" id="form3">
			<!-- <p>
					修改密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密码安全度 <input type="text"
						class="mima" readonly="readonly" value="100%" /> <span class="tel"
						onclick="displayDiv3();" id="sz">设置/修改</span>
				</p> -->
			<br />
			<div id="mima">
				<table>
					<tr>
						<td>原始密码：</td>
						<td><input type="text" placeholder="请输入原始密码" name="psw" /></td>
					</tr>
					<tr>
						<td>新密码：</td>
						<td colspan="3"><input type="text" placeholder="请输入新密码"
							name="newPsw" /></td>
					</tr>
					<tr>
						<td>确认密码：</td>
						<td><input type="text" placeholder="请确认" name="rNewPsw" /></td>
						<td><input class="input_but2 orange" type="button" value="提交"
							onclick="check3();" /></td>
						<td><span id="msg3" style="color: red; font-size: 14px;"></span></td>
					</tr>
				</table>

			</div>
		</form>
		<%-- </c:if> --%>

		<form action="telCode.do" method="post" id="form1">
			<p id="tel">
				绑定手机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<c:choose>
					<c:when test="${userinfo.tel=='' || userinfo.tel == null}">
                        			为了安全，请绑定手机号
                </c:when>
					<c:otherwise>
                     ${userinfo.tel} 
                </c:otherwise>
				</c:choose>
				<span class="tel" onclick="displayDiv();">设置/修改</span>
			</p>
			<br />
			<div id="sj">
				<table>
					<tr>
						<td>手机验证：</td>
						<td><input type="text" placeholder="请输入您的手机号" name="phone"
							id="phone" /></td>
						<td colspan="2"><input class="input_but1 orange"
							type="button" id="btn" value="发送短信验证码" onclick="send();" /></td>
					</tr>
					<tr>
						<td>输入验证码：</td>
						<td><input type="text" name="telCode" /></td>
						<td><input type="button" class="input_but2 orange" value="提交"
							onclick="check();" /></td>
						<td><span id="msg1" style="color: red; font-size: 14px;"></span></td>
					</tr>
				</table>
			</div>
		</form>

		<form action="sendMail.do" method="post" id="form2">
			<p>
				安全邮箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<c:choose>
					<c:when test="${userinfo.email==''|| userinfo.email == null}">
                        			为了安全，请绑定邮箱
                </c:when>
					<c:otherwise>
                  	${userinfo.email} 
                 </c:otherwise>
				</c:choose>
				<span class="mail" onclick="displayDiv2();">设置/修改</span>
			</p>
			<br />
			<div id="yx">
				<table>
					<tr>
						<td>邮箱验证：</td>
						<td><input type="text" placeholder="请输入您的邮箱" name="mail"
							id="mail" /></td>
						<td><input class="input_but1 orange" type="button" id="yzm"
							value="发送验证码" onclick="sendMail();" /></td>
						<td></td>
					</tr>
					<tr>
						<td>输入验证码：</td>
						<td><input type="text" name="mailCode" /></td>
						<td><input type="button" class="input_but2 orange" value="提交"
							onclick="check2();" /></td>
						<td><span id="msg2" style="color: red; font-size: 14px;"></span></td>
					</tr>
				</table>
			</div>
		</form>
	</div>


</body>
</html>
