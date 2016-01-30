<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String json = (String) request.getAttribute("json");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".click").click(function() {
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

		$(".sure").click(function() {
			$(".tip").fadeOut(100);
		});

		$(".cancel").click(function() {
			$(".tip").fadeOut(100);
		});

	});
	function checkAll() {
		var ischecked = document.getElementById("checkAll").checked;
		if (ischecked) {
			checkallbox();
		} else {
			discheckallbox();
		}
	}
	function checkallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = true;
		}
	}
	function discheckallbox() {
		var boxarray = document.getElementsByName("box");
		for ( var i = 0; i < boxarray.length; i++) {
			boxarray[i].checked = false;
		}
	}

	function getId() {
		var fileIds = "";
		$("input[name=box]").each(function() {
			if ($(this).attr("checked") == true) {
				fileIds += $(this).val() + "@";
			}
		});
		if (fileIds == "") {
			alert("请选择需要删除的项!");
		}
		fileIds = fileIds.substring(0, fileIds.length - 1);
		return fileIds;
	}
	function getXhr() {
		var xhr = null;
		if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		} else {
			xhr = new ActiveXObject('Microsoft . XMLHTTP');
		}
		return xhr;
	}
	function getText() {

		if (window.confirm("确定要删除吗?")) {
			var countId = getId();
			$.post("/ssm/main/allDeleteMenus.do", {
				Uid : countId
			}, function(result) {

				window.location.reload(true);

			}).success(function() {
				alert("second success");
			}).error(function() {
				alert("error");
			}).complete(function() {
				alert("complete");
			});
			/* var xhr = getXhr();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					//window.location.href = "Menus.do";
					window.location.reload(true);
				}
			};
			xhr.open("post", "/ssm/main/allDeleteMenus.do", true);
			xhr.setRequestHeader('content-type',
					'application/x-www-form-urlencoded');
			var countId = getId();
			xhr.send("Uid=" + countId); */
		} else {
			return;
		}
	}

	function clickPage(url, currentPage, menuName, patform) {

		/* 	<a href="/ssm/main/manegerMenus.do?currentPage=${page.currentPage-1}&&txtMenuName=${menuName}&&patform=${patform}"><span
										class="pagepre"></span> </a> */
		window.location.href = url + "?currentPage=" + currentPage
				+ "&txtMenuName=" + encodeURI(encodeURI(menuName))
				+ "&patform=" + patform;
	}
	$(function() {
		var flag = false; //标识生成分页时是否生成查询默认页商品
		var json = eval(<%=json%>);
		$("#rows").html(json.rows);
	  	$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
			$("#Pagination").pagination(json.rows, { // 创建分页按钮
				current_page : json.currentPage - 1,
				num_edge_entries : 3, //边缘页数
				num_display_entries : 3, //主体页数
				callback : pageselectCallback,
				items_per_page : json.pageNum, //每页显示1项
				prev_text : "上一页",
			next_text: "下一页"
			});
		};
		function pageselectCallback(page_index, jq) { //此函数为分页动态按钮展现的回调函数，即分页展现商品
			if (flag) {
				location.href = $("#patform").val()+".do?currentPage="
						+ (page_index + 1)+"&&txtMenuName="+$("#MenuName").val();
			}
			flag = true;
			return false;
		}
		initPagination();
	});
</script>
<style type="text/css">
div.meneame span {
	display: inline;
}
</style>

</head>


<body>
	<div class="rightinfo">
		<div class="tools">
			<form action="/ssm/main/SearchMenu.do" name="userForm" method="post">
				<ul class="toolbar">
					<li><a class="tablelink" href="/ssm/main/toMenusAdd.do?"><span><img
								src="../images/t01.png" /> </span>添加</a></li>
					<li class="click2"><span><img
							src="<%=path%>/images/t03.png" /> </span> <a href="javascript:;"
						onclick="getText();">删除</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp; <input type="hidden"
						name="hidPatform" value="${patform}" /> 菜单名称：<input type="text"
						name="txtMenuName" id="MenuName" value="${menuName}" />
					</li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" value="查询" />
					</li>
				</ul>
			</form>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th><input id="checkAll" type="checkbox" name="" value=""
						onclick="checkAll();" /></th>
					<th>ID</th>
					<th>菜单名称</th>
					<!-- <th>菜单简码</th> -->
					<th>菜单路径</th>
					<th>父菜单</th>
					<th>状态</th>
					<th>创建时间</th>
					<th>创建人</th>
					<th>菜单类别</th>
					<th>所属平台</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<!-- <tr>
					<td></td>
					<td>ID</td>
					<td><input type="text" name="menuName"/></td>
					<td><input type="text" name="menuCode"/></td>
					<td><input type="text" name="menuUrl"/></td>
					<td><input type="text" name="parentMenuName"/></td>
					<td><input type="text" name="status"/></td>
					<td><input type="text" name="createTime"/></td>
					<td><input type="text" name="createByName"/></td>
					<td><input type="text" name="menuType"/></td>
					<td><input type="text" name="patform"/></td>
					<td></td>
				</tr> -->
				<c:forEach items="${dispatch}" var="dis">
					<tr>
						<td><input name="box" type="checkbox" value="${dis.id}" /></td>
						<td>${dis.id}</td>
						<td>${dis.menuName}</td>
						<%-- <td>${dis.menuCode}</td> --%>
						<td>${dis.menuUrl}</td>
						<td>${dis.parentMenuName}</td>
						<td><c:choose>
								<c:when test="${dis.status==0}">
                        			未启用
                        		</c:when>
								<c:when test="${dis.status==1}">
                        			启用
                        		</c:when>

							</c:choose></td>


						<td>${dis.createTime}</td>
						<td>${dis.createByName}</td>

						<td><c:choose>
								<c:when test="${dis.menuType==1}">
                        			菜单类型
                        		</c:when>
								<c:when test="${dis.menuType==2}">
                        			页面类型
                        		</c:when>
								<c:when test="${dis.menuType==3}">
                        			按钮类型
                        		</c:when>
							</c:choose></td>
						<td><c:choose>
								<c:when test="${dis.patform==1}">
                        			管理端
                        		</c:when>
								<c:when test="${dis.patform==2}">
                        			商户
                        		</c:when>
								<%-- <c:when test="${dis.patform==3}">
                        			供应商
                        		</c:when> --%>
							</c:choose></td>
						<td><a
							href="deleteMenus.do?id=${dis.id}&&menuType=${dis.menuType}"
							class="tablelink"> 删除 </a> <a
							href="toMenusListUpdate.do?id=${dis.id}" class="tablelink">修改</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 分页 -->
		<c:if test="${patform==1}">
			<input type="hidden" value="manegerMenus" id="patform" />
		</c:if>
		<c:if test="${patform==2}">
			<input type="hidden" value="purchaserMenus" id="patform" />
		</c:if>
		<div class="pagin">
			<div id="Pagination" class="meneame" style="clear: left"></div>
		</div>
		<%-- <div class="pagin">
			<div class="message">
				共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<c:choose>
					<c:when test="${page.currentPage==1}">
						<li class="paginItem current"><a href="#"><span
								class="pagepre"></span> </a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><c:choose>
								<c:when test="${patform==1}">
									<a
										href=" javascript:clickPage('/ssm/main/manegerMenus.do',''${page.currentPage-1}',''${menuName}',''${patform}')"><span
										class="pagepre"></span> </a>
								</c:when>
								<c:when test="${patform==2}">
									<a
										href="javascript:clickPage('/ssm/main/purchaserMenus.do','${page.currentPage-1}','${menuName}','${patform}')"><span
										class="pagepre"></span> </a>
								</c:when>
								<c:when test="${patform==3}">
									<a
										href="javascript:clickPage('/ssm/main/supplierMenus.do','${page.currentPage-1}','${menuName}','${patform}')"><span
										class="pagepre"></span> </a>
								</c:when>
							</c:choose>
						</li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="paginItem">
							<c:if  test="${patform eq 1}">${patform}=1</c:if>
								<c:if  test="${patform ne 1}">${patform}=2</c:if>
							<c:choose>
									<c:when test="${patform eq '1'}">
										<a href="javascript:clickPage('/ssm/main/manegerMenus.do','${s3}','${menuName}','${patform}')">${s3}</a>
									</c:when>
									<c:when test="${patform eq '2'}">
										<a
											href="javascript:clickPage('/ssm/main/purchaserMenus.do','${s3}','${menuName}','${patform}')">${s3}</a>
									</c:when>
									<c:when test="${patform eq '3'}">
										<a
											href="javascript:clickPage('/ssm/main/supplierMenus.do','${s3}','${menuName}','${patform}')">${s3}</a>
									</c:when>
									<c:otherwise>
										<a href="#">${s3}</a>
									</c:otherwise>
								</c:choose></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span> </a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><c:choose>
								<c:when test="${patform==1}">
									<a
										href="javascript:clickPage('/ssm/main/manegerMenus.do','${page.currentPage+1}','${menuName}','${patform}')"><span
										class="pagenxt"></span> </a>
								</c:when>
								<c:when test="${patform==2}">
									<a
										href="javascript:clickPage('/ssm/main/purchaserMenus.do','${page.currentPage+1}','${menuName}','${patform}')"><span
										class="pagenxt"></span> </a>
								</c:when>
								<c:when test="${patform==3}">
									<a
										href="javascript:clickPage('/ssm/main/supplierMenus.do','${page.currentPage+1}','${menuName}','${patform}')"><span
										class="pagenxt"></span> </a>
								</c:when>
							</c:choose></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div> --%>



		<script type="text/javascript">
			$('.tablelist tbody tr:odd').addClass('odd');
		</script>
	</div>
</body>

</html>
