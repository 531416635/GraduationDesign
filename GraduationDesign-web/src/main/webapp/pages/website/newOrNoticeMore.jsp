<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一起采</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript"
	src="../js/jquery.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
body {text-align:center;}
table1 {aligh:center;font-size:150%;}

#mydiv1 {margin:0 auto;width:1000px;font-size:150%; }
</style>
</head>
<body>
<div id="mydiv1">
	<table id="table1"  >
	 <tbody>
        
        <c:forEach items="${news}" var="c">
        <tr>
        <td><a href="newOrNoiceInfo.do?newOrNoticeId=${c.id}&&type=${type}">${c.title}</a></td>
        <td><fmt:formatDate value="${c.releaseTime}" pattern="yyyy-MM-dd"/></td>
        </tr> 
        </c:forEach>
        </tbody>
	</table>
	<div class="pagin">
    	<div class="message">共<i class="blue">${page.rows}</i>条记录，当前显示第&nbsp;<i class="blue">${page.currentPage}&nbsp;</i>页</div>
        <ul class="paginList">
        		<c:choose>
                		<c:when test="${page.currentPage==1}">
                		 <li style="float:left"><a href="#"><button >上一页</button></a></li>
                		</c:when>
                		<c:otherwise>
                		<li style="float:left"><a href="newOrNoiceMore.do?currentPage=${page.currentPage-1}&&type=${type}"><button >上一页</button></a></li>
                		</c:otherwise>
                </c:choose>
        		<c:forEach begin="1" end="${page.totalPage}" var="s3">
        		
					 	<c:choose>
                    		<c:when test="${s3==page.currentPage}">
                    		 <li style="float:left"><a href="#">${s3}</a></li>
                    		</c:when>
                    		<c:otherwise>
                    		<li style="float:left"><a href="newOrNoiceMore.do?currentPage=${s3}&&type=${type}">${s3}</a></li>
                    		</c:otherwise>
                    	</c:choose>
				</c:forEach>
				<c:choose>
                		<c:when test="${page.currentPage==page.totalPage or s3<=50}">
                		 <li style="float:left"><a href="#"><button >下一页</button></a></li>
                		</c:when>
                		<c:otherwise>
                		 <li style="float:left"><a href="newOrNoiceMore.do?currentPage=${page.currentPage+1}&&type=${type}"><button >下一页</button></a></li>
                		</c:otherwise>
                </c:choose>    
        </ul>
    </div>
    </div>
</body>
</html>
