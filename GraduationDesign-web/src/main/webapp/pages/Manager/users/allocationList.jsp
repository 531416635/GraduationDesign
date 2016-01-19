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
<script language="JavaScript" src="<%=path%>/js/jquery.js"></script>
<link href="<%=path%>/css/menuRight.css" rel="stylesheet"
	type="text/css" />
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
});
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

	<form action="MenuRightEdit.do" name="MenuRightForm" method="post">
		<input type="hidden" id="hidRoleID" name="hidRoleID"
			value="${roles.id}" /> <input type="submit" value="提交" />
		<dl class="leftmenu">
			<c:if test="${!empty menuLists }">
				<c:forEach items="${menuLists}" var="parentMenu">
					<c:if test="${parentMenu.parentMenu==null }">
						<dd>
							<div class="title">
								<c:if test="${parentMenu.isChecked==false}">
									<input name="ckbMenuID" type="checkbox"
										value="${parentMenu.id}">${parentMenu.menuName}</input>
								</c:if>
								<c:if test="${parentMenu.isChecked==true}">
									<input name="ckbMenuID" type="checkbox"
										value="${parentMenu.id}" checked="checked">${parentMenu.menuName}</input>
								</c:if>
							</div>
							<!--这个ul是二级菜单 cite为二级标志 -->
							<ul class="menuson" id="menuson">
								<c:forEach items="${menuLists}" var="menuItem">
									<c:if test="${menuItem.parentMenu==parentMenu.id}">
										<li class="" onclick="showmenu(${menuItem.id})"><cite></cite>
											<c:if test="${menuItem.isChecked==false}">
												<input name="ckbMenuID" type="checkbox"
													value="${menuItem.id}">${menuItem.menuName} </input>
											</c:if> <c:if test="${menuItem.isChecked==true}">
												<input name="ckbMenuID" type="checkbox"
													value="${menuItem.id}" checked="checked">${menuItem.menuName} </input>
											</c:if> <i></i>
										</li>
										<ul id="cnd${menuItem.id}" style="display:none;">
											<c:forEach items="${menuLists}" var="pageItem">
												<c:if test="${pageItem.parentMenu==menuItem.id}">
													<li onclick="showmenu(${pageItem.id})"><nextss></nextss>
														<c:if test="${pageItem.isChecked==false}">
															<input name="ckbMenuID" type="checkbox"
																value="${pageItem.id}">${pageItem.menuName}</input>
														</c:if> <c:if test="${pageItem.isChecked==true}">
															<input name="ckbMenuID" type="checkbox"
																value="${pageItem.id}" checked="checked">${pageItem.menuName} </input>
														</c:if> <i></i>
													</li>
													<ul id="cnd${pageItem.id}" style="display:none;">
														<c:forEach items="${menuLists}" var="rightItem">
															<c:if test="${rightItem.parentMenu==pageItem.id}">
																<li><nextss1></nextss1> <c:if
																		test="${rightItem.isChecked==false}">
																		<input name="ckbMenuID" type="checkbox"
																			value="${rightItem.id}">${rightItem.menuName}</input>
																	</c:if> <c:if test="${rightItem.isChecked==true}">
																		<input name="ckbMenuID" type="checkbox"
																			value="${rightItem.id}" checked="checked">${rightItem.menuName}
																		</input>
																	</c:if> <i></i>
																</li>
																	<ul id="cnd${rightItem.id}" style="display:none;">
																		<c:forEach items="${menuLists}" var="yewuItem">
																			<c:if test="${yewuItem.parentMenu==rightItem.id}">
																				<li><nextss2></nextss2> <c:if
																						test="${yewuItem.isChecked==false}">
																					<input name="ckbMenuID" type="checkbox"
																						value="${yewuItem.id}">${yewuItem.menuName}</input>
																				</c:if> <c:if test="${yewuItem.isChecked==true}">
																					<input name="ckbMenuID" type="checkbox"
																						value="${yewuItem.id}" checked="checked">${yewuItem.menuName}
																					</input>
																				</c:if> <i></i>
																			</li>
																		</c:if>
																	</c:forEach>
																</ul>
															</c:if>
														</c:forEach>
													</ul>
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
	</form>
</body>
</html>
