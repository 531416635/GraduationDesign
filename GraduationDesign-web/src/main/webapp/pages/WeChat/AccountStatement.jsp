<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<title>一起采</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			 String num = (String) request.getAttribute("currentPage"); 
%>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/datePicker/WdatePicker.js"></script>
<link href="<%=path%>/css/WeChatcss/public.css" rel="stylesheet"
	type="text/css" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
>
<script type="text/javascript">
    window.onload = function() { 
		var newH=window.screen.height-60;
		document.getElementById("div_body").style.height = newH + "px";
	};
var currentPage =parseInt(<%=num%>);
	function viewMore(){
	  $.ajax({  //此ajax加载分页商品
			type : "POST",
			async : false,
			url : "findMoreCompanyStatement.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				currentPage : ++currentPage,		
			},
			success : function(data) {
				
				if (data == "false") { //提示
				var d = dialog({
   				title: '友情提示',
   			 	content: '加载失败，请稍后重试！'
				});
				d.show();
				} else {
					var json = eval(data);
					var content1 = '';
					for ( var i = 0; i < json.accountStatements.length; i++) {			 
							content1 +='            	<table>'
							+'         	 <tr>'
							+'            	<td style="width:100px;">账单月份：</td>'     
							+'                <td>'+dateJoin(json.accountStatements[i].startTime.time)+'</td>'
							+'            </tr>'
							+'            <tr>'
							+'            	<td>本期账单金额：</td>'
							+'                <td>'+json.accountStatements[i].amount+'</td>'
							+'            </tr>'
							+'         </table>';
					}
					$("#ps").before(content1);
				}
			}
		}); 	
	};
	function dateJoin(time){
     var date=new Date(time); 
		var times="";     
		times+=date.getFullYear()+"-";     
		times+=(date.getMonth()+1)+"-";     
		times+=date.getDate()+" "; 
		return times;
     }
</script>
<style type="text/css">
p {
	font-size: 90%;
	margin: 9px 0;
}

table {
	border-bottom: 1px dashed #999;
	margin: 10px 0;
	width: 100%;
}
</style>
</head>
<body>

	<div class="top">
		<P style="text-align: center; font-size: 120%;">对账单</P>
		<!--          <form>
           
            <P><span>个人账单金额：</span><input style="width:70%" type="text"/></P>
             <P>
                发票状态：<select>
                	<option value="audi">1</option>
                    <option value="audi">2</option>
                    <option value="audi">3</option>
                </select>
                <input style="width:70px; margin-left:10%;" type="button" value="查询"/>
            </P>
         </form> -->
		<hr color="#CCCCCC">
		<c:forEach items="${accountStatements}" var="c">
			<table>
				<tr>
					<td style="width: 100px;">账单月份：</td>
					<td>
						<%-- <fmt:formatDate value="${c.startTime}" type="date"
										pattern="yyyy-MM-dd" var="time" /> <c:out
										value="${time}" /> --%> <fmt:formatDate value="${c.startTime}"
							type="both" pattern="yyyy-MM-dd" />
					</td>
				</tr>
				<tr>
					<td>本期账单金额：</td>
					<td>${c.amount}</td>
				</tr>
			</table>
		</c:forEach>


		<p id="ps" style="text-align: center">
			<input style="outline: none; background-color: #fff; color: #666"
				type="button" value="点击查看更多↓" onclick="viewMore();">
		</p>
	</div>
</body>
</html>