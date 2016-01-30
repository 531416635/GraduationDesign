<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String json = (String) request.getAttribute("json");
%>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/redjs/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery.pagination.js"></script>
<link rel="stylesheet" href="<%=path%>/css/redcss/pagination.css" />

<script type="text/javascript">
function getId() {
			var fileIds = "";
			$("input[name=box]:checked").each(function() {
             		 fileIds += $(this).val() + ",";   
			}); 
			if (fileIds == "") {
				alert("请选择需要删除的项!");
			} else{
				fileIds = fileIds.substring(0, fileIds.length - 1);
			}
			return fileIds;
		}
function  getXhr(){
        var xhr = null;
        if(window . XMLHttpRequest){
            xhr  = new XMLHttpRequest();
        }else{
            xhr = new ActiveXObject('Microsoft . XMLHTTP');
        }
        return xhr;
}
 function getText(){
            var xhr = getXhr();
            xhr.onreadystatechange=function(){
                if(xhr.readyState==4 && xhr.status==200){
                    window.location.href="findBuyerBalance.do";
                }
            };
           xhr.open("post","allDeleteBalance.do",true);
           xhr.setRequestHeader('content-type',
                'application/x-www-form-urlencoded');
           var countId = getId();
           xhr.send("Uid="+countId);
  }
  
function checkAll(){
  var ischecked=document.getElementById("checkAll").checked;
  if(ischecked){
    checkallbox();
  }else{
    discheckallbox();
  }
}
function checkallbox(){
   var boxarray = document.getElementsByName("box");
   for(var i = 0; i < boxarray.length; i++) { 
     boxarray[i].checked = true;
   }
}
function discheckallbox() { 
  var boxarray = document.getElementsByName("box"); 
  for(var i = 0; i < boxarray.length; i++) { 
    boxarray[i].checked = false;
  }
}
function checkBox(){
            			
            		var checkObjs1 = $(":checkbox[name='box']:checked");
            		var checkObjs2 = $(":checkbox[name='box']");
            		  	if(checkObjs1.length==checkObjs2.length) {
                			document.getElementById("checkAll").checked=true;
                }else{
                			document.getElementById("checkAll").checked=false;
    }
}
function checkDelete(id,balance){
	if(balance>0){
		window.confirm("只有金额为0才能删除");
	}else{
	 	var r = window.confirm("确定删除此资金账户信息？");
		 if(r){
             location.href="deleteBuyerBalance.do?id="+id;
          }
    }
}	
function checkDeletes(){
	var r = window.confirm("确定删除所选资金账户信息吗？");
	 if(r){
            getText();
          }

}
$(function(){
	 	var flag = false; //标识生成分页时是否生成查询默认页商品
	  	var json = eval(<%=json%>);
	  	$("#rows").html(json.rows);
	  	$("#currentPage").html(json.currentPage);
		var initPagination = function() { //此函数为分页动态按钮展现
	 	$("#Pagination").pagination(json.rows, { // 创建分页按钮
			current_page: json.currentPage-1,
			num_edge_entries: 3, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback,
			items_per_page: json.pageNum, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		}); 
	 };  
	function pageselectCallback(page_index, jq){  //此函数为分页动态按钮展现的回调函数，即分页展现商品
		if(flag){
		location.href="findBuyerBalance.do?currentPage="+(page_index+1);
		}
		flag=true;
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

		<!-- < <div class="tools">
			<ul class="toolbar">
				<li class="click"><span><img src="images/t01.png" /> </span><a
					href="/ssm/toInsertBuyerBalance.do">添加</a></li>
				<li><a class="tablelink" href="#" onclick="checkDeletes();"><span><img
							src="images/t03.png" /> </span>删除</a>
				</li>
			</ul>
		</div>  -->


		<table class="tablelist">
			<thead>
				<tr>
					<th><input name="" id="checkAll" type="checkbox"
						onclick="checkAll();" />全选</th>
					<th>公司ID</th>
					<th>公司名称</th>
					<th>币种</th>
					<th>账户金额</th>
					<th>账户状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${companyBalance}" var="c">
					<tr>
						<td><input name="box" type="checkbox" value="${c.id}" /></td>
						<td>${c.companys.id}</td>
						<td><a href="/ssm/findSupplierInfo.do?id=${c.id}">${c.companys.companyName}</a>
						</td>
						<td>${c.currency}</td>
						<td align="right">${c.balance}</td>
						<td><c:choose>
								<c:when test="${c.status==0}">
                        			初始
                        		</c:when>
								<c:when test="${c.status==1}">
                        			可用
                        		</c:when>
								<c:when test="${c.status==2}">
                        			冻结
                        		</c:when>
								<%-- <c:otherwise>
                        			删除
                        		</c:otherwise> --%>
							</c:choose></td>
						<td><a class="tablelink"
							href="/ssm/toUpdateBuyerBalance.do?id=${c.id}">修改</a> <%-- <a
							class="tablelink" href="#"
							onclick="checkDelete(${c.id},${c.balance})">删除</a> --%> <a
							href="/ssm/frozenBuyerBalance.do?id=${c.id}">冻结</a> <a
							class="tablelink" href="companyBalanceLog.do?id=${c.id}">历史流水</a>
							<a class="tablelink"
							href="findCompanyBalanceStatement.do?companyId=${c.companys.id}">查看对账单</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 分页 -->
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
								class="pagepre"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/findBuyerBalance.do?currentPage=${page.currentPage-1}"><span
								class="pagepre"></span> </a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${page.totalPage}" var="s3">
					<c:choose>
						<c:when test="${s3==page.currentPage}">
							<li class="paginItem current"><a href="#">${s3}</a></li>
						</c:when>
						<c:otherwise>
							<li class="paginItem"><a
								href="/ssm/findBuyerBalance.do?currentPage=${s3}">${s3}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${page.currentPage==page.totalPage or s3<=10}">
						<li class="paginItem current"><a href="#"><span
								class="pagenxt"></span> </a></li>
					</c:when>
					<c:otherwise>
						<li class="paginItem"><a
							href="/ssm/findBuyerBalance.do?currentPage=${page.currentPage+1}"><span
								class="pagenxt"></span> </a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
 --%>

		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>

			<div class="tipinfo">
				<span><img src="../images/ticon.png" /> </span>
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

</body>

</html>
