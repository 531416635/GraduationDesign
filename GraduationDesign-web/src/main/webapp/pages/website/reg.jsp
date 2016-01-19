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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/frontcss/detail.css" />
<script type="text/javascript" src="<%=path%>/js/lanrenzhijia.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="../js/frontjs/lanrenzhijia.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
	function reloadcode() {
		var verify = document.getElementById('code');
		verify.setAttribute('src', '/ssm/pages/website/makeCertPic.jsp?it='
				+ Math.random());
	}

	function check1() {
		$.ajax({
			type : "POST",
			url : "reg.do",
			dataType : "text",
			data : $("#form1").serialize(),
			success : function(data) {
				if (data == "nullError") {
					$("#msgg").text("请输入用户名");
				} else if (data == "nameError2") {
					$("#msgg").text("用户名必须是6位以上英文和数字或手机号或邮箱");
				} else if (data == "null2Error") {
					$("#msgg").text("请输入手机号");
				} else if (data == "telError") {
					$("#msgg").text("手机号已注册");
				} else if (data == "telError2") {
					$("#msgg").text("手机号不存在");
				} else if (data == "null3Error") {
					$("#msgg").text("请输入密码");
				} else if (data == "null4Error") {
					$("#msgg").text("请输入确认密码");
				} else if (data == "pwdError") {
					$("#msgg").text("两次输入密码不一致");
				} else if (data == "nameError") {
					$("#msgg").text("用户名已注册");
				} else if (data == "success") {
					alert("恭喜您，注册成功！");
					location.href = "ljdl.do";
				} else if (data == "emailError") {
					$("#msgg").text("邮箱已注册");
				}else if(data == "yzError"){
					$("#msgg").text("请输入验证码");
				}else if(data == "yzError2"){
					$("#msgg").text("验证码不正确");
				}
			}
		});
	}

	function check2() {
		var clientHeight = document.getElementById('textarea').clientHeight;
		var scrollTop = document.getElementById('textarea').scrollTop;
		var scrollHeight = document.getElementById('textarea').scrollHeight;

		if (clientHeight + scrollTop == scrollHeight) {
			$("#check").removeAttr("disabled");
		}

	}
	function checkbutton(){
		var xieyi = $("input[type='checkbox']").is(':checked');
		if(!xieyi){
			$("#msg4").text("您还没有阅读用户协议");
		}else{
			$("#xieyi1").show();
	     	$("#xieyi2").show();
		}
	    
	}
	function checkbutton2(){
	     $("#xieyi1").hide();
	     $("#xieyi2").hide();
	}
	
	//-------------------发送手机验证码
	var InterValObj; //timer变量，控制时间
	var count = 60; //间隔函数，1秒执行
	var curCount;//当前剩余秒数
	function sendCode(){
		var tel = $("#tel").val();
		var reg=/^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
		if(!reg.test(tel)){
			$("#msgg").text("手机号码为11位，要求以13、14、15、17、18开头！");
			return;
		}
		curCount = count;
			$.ajax({
			type : "POST",
			url : "sendTelCode.do",
			dataType : "text",
			data : {"tel":tel},
			success : function(data) {
			var json =eval('(' + data + ')');
				$("#yzCode").val(json.code);
				if (json.result =="fscg") {
					$("#btnSendCode").attr("disabled", "true");
				     $("#btnSendCode").val("请在" + curCount + "秒内输入验证码");
				     InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
				}else if(json.result == "existError"){
					$("#msgg").text("手机号已注册");
				}else if(json.result=="nullError"){
					$("#msgg").text("请输入手机号");
				}  
			}
	});
	}
//timer处理函数
function SetRemainTime() {
            if (curCount == 0) {                
                window.clearInterval(InterValObj);//停止计时器
                $("#btnSendCode").removeAttr("disabled");//启用按钮
                $("#btnSendCode").val("重新发送验证码");
            }
            else {
                curCount--;
                $("#btnSendCode").val("请在" + curCount + "秒内输入验证码");
            }
        }	
</script>
<style type="text/css">
 table{
 	margin: 0 auto;
 	color: #666;
 }
 tr{
   height: 50px;
 }
.input_trxt{
    width: 300px;
    height: 30px;
    margin: 0 10px;
    font-size: 14px;
}
span{
	font-size: 14px;
}
</style>
</head>

<body>

	<div class="warp">
		<div class="detail_list" style="height: 500px;">
            <!--<ul id="tabs">
				<li><a href="#" title="tab1">商户注册</a></li>
			</ul> -->
			<div id="content"  style="height: 435px;">
			<div id="tab1" style="width: 870px; margin-left: 240px;" >
				<h4 style="color: #666;">用户注册协议</h4>
	   <textarea  onmouseout="check2();" style=" font-size:12px; line-height: 25px; width: 656px; height: 330px" readonly="readonly" id="textarea">
                                             
一、总则
   一起采网（http://www.51yqc.com）的所有权和运营权归公采网络科技有限公司所有，为获得网络信息服务，服务使用人（以下简称“用户”）必须仔细阅读和完全同意本协议的全部条款并完成注册申请程序，才能正式成为一起采网（以下简称“本网站”）的正式用户。用户在进行注册申请程序过程中点击“同意”按钮即表示用户完全接受本协议项下的全部条款。
二、服务内容
　　1、本网站的网络信息服务具体内容由本网站根据实际情况提供，并保留随时变更、中断或终止部分或全部网络信息服务的权利。
　　2、本网站仅提供相关的网络信息服务，除此之外与网络信息服务有关的设备（如电脑、调制解调器及其他与接入互联网有关的装置等）及所需的费用（如为接入互联网而支付的电话费及上网费等）均应由用户自行承担。
三、使用规则
　　1、用户在申请使用本网站的网络信息服务时，必须提供准确的公司/个人资料，如资料有任何变动，必须及时更新。
　　2、用户注册成功后，本网站将给予每个用户相应的用户帐号和密码，该用户帐号和密码在服务期内由用户负责保管；用户应当对以其用户帐号进行的所有活动和事件负全部法律责任。如用户发现帐号遭到未授权的使用或发生其他任何安全问题，应立即修改帐号密码并妥善保管，如有必要，请通知本网站。因黑客行为或用户的保管疏忽等非本网站原因导致帐号非法使用，本网站不承担任何责任。
　　3、用户在使用网络信息服务和发布信息的过程中，应单独承担其所发布内容而产生的全部责任，并遵守相关的法律法规及规则。
　　（1）从中国境内向外传输技术性资料时必须符合中国有关法规。
　　（2）使用网络服务不作非法用途。
　　（3）不干扰或混乱网络服务。
　　（4）遵守所有使用网络服务的网络协议、规定、程序和惯例。
　　4、用户应承诺不传输任何非法的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽等信息资料。另外，用户也不能传输任何教唆他人构成犯罪行为的资料；不能传输助长国内不利条件和涉及国家安全的资料；不能传输任何不符合当地法规、国家法律和国际法律的资料；未经许可不得非法进入其它电脑系统。
　　5、若用户的行为不符合以上提到的服务条款及原则，本网站将作出独立判断立即取消用户帐号。用户应对其在网上的行为承担法律责任。用户若在本网站上散布和传播反动、色情或其他违反国家法律的信息等，本网站的系统记录有可能作为用户违反法律的证据提交给相关部门。
四、商务声明
　　1、本网站公布的商品价目表和声明并不构成要约，且该类信息将随时更改且不发任何通知。本网站有权在发现网站上显现的商品及订单等的错误或缺货的情况下，单方面撤回任何承诺。
　　2、所有在本网站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点的基础上估计得出的。
　　3、本网站对在本网站上得到的任何商品购物服务或交易进程，不作任何担保。
　　4、如因不可抗力或其它本网站无法控制的原因致使本网站系统崩溃或无法正常使用导致网上交易无法完成或丢失有关信息、记录等，本网站不承担责任，但本网站会尽可能合理地协助处理善后事宜。
五、版权声明
　　1、本网站提供的网络信息服务内容可能包括：文字、软件、图片、录像、图表等。所有这些内容受版权、商标和其它财产所有权法律的保护。
　　2、用户只有在获得本网站或其他相关权利人的授权之后才能使用这些内容，而不能擅自复制、再造这些内容，或创造与内容有关的派生产品。
六、隐私保护
　　1、尊重用户个人隐私是本网站的一项基本政策。本网站保证不对外公开用户的注册资料及用户在使用网络信息服务时存储在网络系统的非公开内容，但下列情况除外：
　　（1）用户授权透露这些信息；
　　（2）相关法律法规和程序要求透露用户资料；
　　（3）在紧急情况下竭力维护用户个人和社会大众的隐私安全。
　　2、本网站可能会与第三方合作向用户提供相关的网络信息服务，在此情况下，如该第三方同意承担与本网站同等的保护用户隐私的责任，则本网站可将用户的注册资料等提供给该第三方。
　　3、在不透露单个用户隐私资料的前提下，本网站有权对整个用户数据库进行分析并对用户数据库进行商业上的利用。 
七、免责声明
　　1、若本网站已经明示其网络信息服务提供方式发生变更并提醒用户应当注意事项，用户未按要求操作所产生的一切后果由用户自行承担。
　　2、用户明确同意其使用网络信息服务所存在的风险将完全由其自己承担；因其使用网络信息服务而产生的一切后果也由其自己承担，本网站对用户不承担任何责任。
八、服务变更、中断或终止
　　1、如因系统维护或升级的需要而需暂停网络信息服务，本网站将尽可能事先进行通告。
　　2、如发生下列任何一种情形，本网站有权随时中断或终止向用户提供本协议项下的网络信息服务而无需通知用户：
　　（1）用户提供的资料不真实；
　　（2）用户违反本协议中规定的使用规则或相关法律法规。
　　3、除前款所述情形外，本网站保留在不事先通知用户的情况下随时中断或终止部分或全部网络信息服务的权利，对于由于服务的中断或终止而造成的任何损失，本网站无需对用户或任何第三方承担任何责任。
九、违约赔偿
　　用户同意保障和维护本网站及其他用户的利益，如因用户违反有关法律、法规或本协议项下的任何条款而给本网站或任何其他第三人造成损失，用户同意承担由此造成的损害赔偿责任。
十、修改协议
　　1、本网站将可能不时的修改本协议的有关条款，一旦条款内容发生变动，一起采网将会在相关的页面提示修改内容。
　　2、如果不同意本网站对服务条款所做的修改，用户有权停止使用本网站的网络信息服务。如果用户继续使用本网站的网络信息服务，则视为用户接受服务条款的变动。
十一、法律管辖
　　1、本协议的订立、执行和解释及争议的解决均应适用中国法律。
　　2、如双方就本协议内容或其执行发生任何争议，双方应尽量友好协商解决；协商不成时，任何一方均可向本网站所有权人所在地的人民法院提起诉讼。
十二、通知和送达
　　本协议项下所有的通知均可通过页面公告、电子邮件或常规的信件传送等方式进行，且该等通知于发送之日视为已送达收件人。
十三、其他规定
    1、如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍应有效并且有约束力。
    2、本协议中的标题仅为方便阅读而设。
    3、用户在其发表的信息中加入宣传资料或参与广告策划，在本网站的服务上展示他们的产品，任何这类促销方法，包括运输货物、付款、服务、商业条件、担保及与广告有关的描述都只是在相应的用户和广告销售商之间发生。本网站不承担任何责任，没有义务为这类广告销售负任何一部分的责任。
    			                                一起采网
		</textarea>
		<p style="margin: 8px 0;">
			<input type="checkbox" name="check" id="check" disabled="true" />
			<span style="font-size:13px""> 我已阅读并同意</span>
			<span style="color: red;font-size:13px"">《一起采团餐平台商户注册协议》</span>
		</p>
		<P style="padding-left: 110px;">
			<input style="height: 25px;" class="button orange medium" type="button" value="确认" onclick="checkbutton();">
		    
		    <span style="color: red;" id="msg4">
		</P>
			</div>
		</div>
	</div>
	<!-- 注册层，点击提交弹出，浮于协议页面之上 
	<div id="xieyi1" style="display:none; position:absolute; width:1128px; height:500px; margin-left:-564px; left: 50%; background-color: #d5d5d5;filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity: 0.5; " ></div>-->
	<div id="xieyi2" style="display:none; position:absolute; border:1px solid #d5d5d5; border-radius:10px; margin-left:-325px; left: 50%; padding: 30px; margin-top:30px; background-color: #fff;">
	   
					<br />
					<form action="reg.do" method="post" id="form1">
						<input type="hidden" name="userType" value="2" />
						<P style="font-size: 20px; text-align: center; width: 650px; height:40px; line-height:40px; margin: 0 auto; background-color: #e5e5e5;">商 户 注 册</P>
						<table>
							<tr>
								<td align="right" width="75">会员名:</td>
								<td><input class="input_trxt" type="text" name="userCode" />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="color: red; font-size: 14px;" id="msg"></span></td>
								<td style="width:5%">&nbsp;</td>
							</tr>
							<tr>
								<td align="right">手机号:</td>
								<td><input class="input_trxt" type="text" name="tel" id="tel"/><input style="height: 23px;width:150px; color:#FAA51A; border: 1px solid #DA7C0C; padding: 0;" class="button" type="button" value="&nbsp;&nbsp;发送验证码到手机&nbsp;&nbsp;&nbsp;" onclick="sendCode();" id="btnSendCode"/>
								<span style="color: red;" id="msg1"></span></td>
								<input type="hidden" id="yzCode" name="yzCode"/>
							</tr>
							<tr>
								<td align="right">验证码:</td>
								<td><input class="input_trxt" type="text" name="yzm" id="yzm" onchange="checkCode();"/>
								<span style="color: red;" id="msgy"></span></td>
								<td></td>
							</tr>
							<tr>
								<td>登录密码:</td>
								<td><input class="input_trxt" type="password" name="userPsw" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="color: red;" id="msg2"></span>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>确认密码:</td>
								<td><input class="input_trxt" type="password" name="qrmm" /><span style="color: red;" id="msg3"></span></td>
								<td></td>
							</tr>
							</tr>
							<tr style="height: 20px;"><td colspan="3" align="center"><span style="color: red;" id="msgg"></span></td></tr>
							<tr>
								<td colspan="3" align="center">
								    <input style="height: 25px;" class="button orange medium" type="button" value="立即注册" onclick="check1();">
									 <input style="height: 25px; margin-left: 50px;" class="button orange medium" type="button" value="返回" onclick="checkbutton2();">
								</td>
							</tr>
						</table>
					</form>
				
	   </div>
		
	</div>
	<script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#content div").hide(); // Initially hide all content
			$("#tabs li:first").attr("id", "current"); // Activate first tab
			$("#content div:first").fadeIn(); // Show first tab content

			$('#tabs a').click(function(e) {
				e.preventDefault();
				$("#content div").hide(); //Hide all content
				$("#tabs li").attr("id", ""); //Reset id's
				$(this).parent().attr("id", "current"); // Activate this
				$('#' + $(this).attr('title')).fadeIn(); // Show content for current tab
			});
		})();
	</script>
</body>
</html>
