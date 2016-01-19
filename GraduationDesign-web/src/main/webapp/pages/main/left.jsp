<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=path%>/js/jquery.js"></script>

<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active");
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
});/* 
$(function(){
	
    $("#tabSearch").toggle(function(){
               $("#cnd").css({display:"block"});
    },function(){
              $("#cnd").css({display:"none"});
   });
    $("#tabSearch1").toggle(function(){
               $("#cnd1").css({display:"block"});
    },function(){
              $("#cnd1").css({display:"none"});
   });
   $("#tabSearch2").toggle(function(){
               $("#cnd2").css({display:"block"});
    },function(){
              $("#cnd2").css({display:"none"});
   });
    $("#tabSearch3").toggle(function(){
               $("#cnd3").css({display:"block"});
    },function(){
              $("#cnd3").css({display:"none"});
   });
    $("#tabSearch4").toggle(function(){
               $("#cnd4").css({display:"block"});
    },function(){
              $("#cnd4").css({display:"none"});
   });
    $("#tabSearch5").toggle(function(){
               $("#cnd5").css({display:"block"});
    },function(){
              $("#cnd5").css({display:"none"});
   });
    $("#tabSearch6").toggle(function(){
               $("#cnd6").css({display:"block"});
    },function(){
              $("#cnd6").css({display:"none"});
   });
    $("#tabSearch6").toggle(function(){
               $("#cnd6").css({display:"block"});
    },function(){
              $("#cnd6").css({display:"none"});
   });
    $("#tabSearch7").toggle(function(){
               $("#cnd7").css({display:"block"});
    },function(){
              $("#cnd7").css({display:"none"});
   });
   $("#tabSearch8").toggle(function(){
               $("#cnd8").css({display:"block"});
    },function(){
              $("#cnd8").css({display:"none"});
   });
    $("#tabSearch9").toggle(function(){
               $("#cnd9").css({display:"block"});
    },function(){
              $("#cnd9").css({display:"none"});
   });
   $("#cnd9").css({display:"none"});
    $("#cnd7").css({display:"none"});
   $("#cnd8").css({display:"none"});
   $("#cnd").css({display:"none"});
   $("#cnd1").css({display:"none"});
   $("#cnd2").css({display:"none"});
   $("#cnd3").css({display:"none"});
   $("#cnd4").css({display:"none"});
   $("#cnd5").css({display:"none"});
   $("#cnd6").css({display:"none"});
   $("#menuson").css({display:"none"});
   
});	 */
function link(){
 window.parent.rightFrame.location.href="/ssm/users/userManager.do";
}

function showmenu(menuid) {
		if ($("#cnd"+menuid).css("display") == "none") {
			$("#cnd"+menuid).css({
				display : "block"
			});
		} else {
			$("#cnd"+menuid).css({
				display : "none"
			});
		}
	}
</script>


</head>

<body style="background:#f0f9fd;">
	<div class="lefttop">
		<span></span>系统后台
	</div>

	<dl class="leftmenu">
		<c:if test="${!empty menusList }">
			<c:forEach items="${menusList}" var="menu">
				<c:if test="${menu.parentMenu==null}">
					<dd>
						<div class="title">
							<span><img src="<%=path%>/images/leftico0${menu.id}.png" />
							</span> ${menu.menuName}
						</div>
						<!--这个ul是二级菜单 cite为二级标志 -->
						<ul class="menuson" id="menuson">
							<c:forEach items="${menusList}" var="menuItem">
								<c:if test="${menuItem.parentMenu==menu.id}">
									<li class="" id="tabSearch${menuItem.id}"
										onclick="showmenu(${menuItem.id})"><cite></cite> <a
										href="${menuItem.menuUrl}" target="rightFrame">${menuItem.menuName}</a> <i></i></li>
									<ul id="cnd${menuItem.id}" style="display:none;">
										<c:forEach items="${menusList}" var="menuSun">
											<c:if test="${menuSun.parentMenu==menuItem.id}">
												<li><nextss></nextss><a href="${menuSun.menuUrl}"
													target="rightFrame">${menuSun.menuName} </a><i></i>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</c:forEach>
						</ul>
					</dd>
				</c:if>
			</c:forEach>
		</c:if>
	</dl>
</body>
</html>
