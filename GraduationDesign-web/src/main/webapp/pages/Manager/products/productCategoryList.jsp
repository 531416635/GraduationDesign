<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	String productCategorys =(String)request.getAttribute("productCategorys");
%>
<script type="text/javascript"
	src="<%=path%>/js/redjs/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/zTree/jquery.ztree.all-3.5.min.js"></script>
<link href="<%=path%>/js/zTree/zTreeStyle.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="<%=path%>/js/artDialog/dialog-plus-min.js"></script>
<link href="<%=path%>/js/artDialog/ui-dialog.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">  
    var zTree;  
    var setting = {
            view:{  
            	showIcon: false,
                addHoverDom:addHoverDom,  
                removeHoverDom:removeHoverDom,  
                selectedMulti:false  
            },  
            edit: {  
                enable: true,  
                editNameSelectAll:true,  
                removeTitle:'删除',  
                renameTitle:'重命名'  
            },  
            data: {  
                simpleData: {  
                    enable: true
                } 
            },  
            callback:{  
                beforeRemove:beforeRemove,//点击删除时触发，用来提示用户是否确定删除  
                beforeEditName: beforeEditName,//点击编辑时触发，用来判断该节点是否能编辑  
                beforeRename:beforeRename,//编辑结束时触发，用来验证输入的数据是否符合要求  
                onRemove:onRemove,//删除节点后触发，用户后台操作  
                onRename:onRename,//编辑后触发，用于操作后台  
                beforeDrag:beforeDrag,//用户禁止拖动节点  
                onClick:clickNode//点击节点触发的事件  
            }  
        }; 
    var flag = true;//状态标识  
    var zNodes =<%=productCategorys%>;    
    $(document).ready(function(){  
        zTree = $.fn.zTree.init($("#tree"), setting, zNodes);  
    });  
    function beforeRemove(treeId,treeNode){
    	if(confirm("你确定要删除吗？")){	
   	deleteCategory(treeNode.id);
   	if(flag){
   	return true;
   	}else{
   	return false;
   	}
   	}else{
   	 return false; 
   	}  
    }  
    function onRemove(treeId,treeNode){  
        if(treeNode.isParent){  
            var childNodes = zTree.removeChildNodes(treeNode);  
            var paramsArray = new Array();  
            for(var i = 0; i < childNodes.length; i++){  
                paramsArray.push(childNodes[i].id);  
            }  
            /* alert("删除父节点的id为："+treeNode.id+"\r\n他的孩子节点有："+paramsArray.join(","));   */
            return;  
        }  
       /*  alert("你点击要删除的节点的名称为："+treeNode.name+"\r\n"+"节点id为："+treeNode.id);   */
    }  
    function beforeEditName(treeId,treeNode){  
        /* if(treeNode.isParent){  
            alert("不准编辑非叶子节点！");  
            return false;  
        } */  
        return true;  
    }  
    function beforeRename(treeId,treeNode,newName,isCancel){  
        if(newName.length < 2){  
            var d = dialog({
   				 title: '友情提示',
   			 	content: '名称不能少于2个字符！'
				});
				d.show(); 
        return false;  
        }else{ 
         updateCategory(treeNode.id,newName);
         if(!flag){
         return false;  
         }  
        }
        return true;  
    }  
    function onRename(e,treeId,treeNode,isCancel){ 
     /* alert("2:"+treeNode.name); 
        alert("修改节点的id为："+treeNode.id+"\n修改后的名称为："+treeNode.name);  */ 
    }  
    function clickNode(e,treeId,treeNode){  
        if(treeNode.id == 11){  
            location.href=treeNode.url;  
        }else{  
            /* alert("节点名称："+treeNode.name+"\n节点id："+treeNode.id);   */
        }  
    }  
    function beforeDrag(treeId,treeNodes){  
        return false;  
    }  
    var newCount = 1; 
    var nodes; //全局节点变量便于数据交换
    function addHoverDom(treeId,treeNode){
    	nodes= treeNode;
        var sObj = $("#" + treeNode.tId + "_span");  
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;  
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId  
            + "' title='添加子节点' onfocus='this.blur();'></span>";  
        sObj.after(addStr);  
        var btn = $("#addBtn_"+treeNode.tId);  
        if (btn) btn.bind("click", function(){          
            //在这里向后台发送请求保存一个新建的叶子节点，父id为treeNode.id,让后将下面的100+newCount换成返回的id  
            //zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"新建节点" + (newCount++)});  
            if(treeNode.isParent){
            var d =dialog({  
                id: 'testID',  
                content: '您想要添加同级节点还是子节点？',  
                button: [  
                    {  
                        value: '同级节点',  
                        callback: function () {  
                            if(!treeNode.isParent){  
                                art.dialog({  
                                    content:'叶子节点不能建立同级节点',  
                                    ok:function(){}  
                                });  
                                return;  
                            }  
                           var parentNode = treeNode.getParentNode();  
                           var pId = 0;  
                           if(parentNode != null){  
                               pId = parentNode.id;  
                           }
                             addCategory(parentNode,'新建同级节点');
                        },  
                        focus: true  
                    },  
                    {  
                        value: '子节点',  
                        callback: function () {
                        if(treeNode.name=="品牌"){   //添加品牌 
                        var flag11=false; //是否包含回调品牌集
                        var contentBody='<div><form action="#" method="post">增添品牌：<select id="cateGoryName">';
                        	$.ajax({
								type : "POST",
								url : "/GraduationDesign/products/findProductBrand.do",
								async : false,
								dataType : "text",
								contentType : "application/x-www-form-urlencoded; charset=UTF-8",
								success : function(data) {
								
									var result=eval("("+data+")");
									//提示问题内容	
									if (result.result == "true") {
									for(var i=0;i<result.productBrands.length;i++){
									contentBody+='<option lev="'+result.productBrands[i].id+'" value="'+result.productBrands[i].brandName+'">'+result.productBrands[i].brandName+'</option>';	
									}				
									contentBody+='</select><input type="button" onclick="addProductBrand();" value="添加"/></form></div>';								
									flag11=true;
									}else{
									alert("系统维护中请稍后重试!");
									}		
								},
								error : function(data){
								alert("发生错误了！");
								}							
							});
                        if(flag11){
                         d1 = dialog({
                        	id:'dialog1',
		   				 title: '品牌添加',
		   			 	content: contentBody
						});
						d1.show(); 
						
                        }
                        }else{
                         var i =newCount++;
                        addCategory(treeNode,"新建子节点" + i);                 
                        }   
                        },  
                        focus:true  
                    },  
                    {  
                        value: '取消'  
                    }  
                ]  
            });
            }else{
            var d =dialog({  
                id: 'testID',  
                content: '您想要添加子节点？',  
                button: [   
                    {  
                        value: '添加',  
                        callback: function () {
                         var i =newCount++;
                        addCategory(treeNode,"新建子节点" + i);
                        },  
                        focus:true  
                    },  
                    {  
                        value: '取消'  
                    }  
                ]  
            }); 
            }
            d.show(); 
            return false;  
        });  
    }
    //添加商品品牌
    function addProductBrand(){
    var cateGoryCode= $('#cateGoryName option:selected').attr('lev');
    var cateGoryName= $("#cateGoryName").val();
	    $.ajax({
						type : "POST",
						url : "/GraduationDesign/products/addProductBrand.do",
						async : false,
						dataType : "text",
						data : {
						parentCateGory : nodes.id,
						cateGoryName : cateGoryName,
						cateGoryCode : cateGoryCode
						},
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(data) {
						
							var result=eval("("+data+")");
							//提示问题内容	
							if (result.result == "true") {
							 alert("添加成功");
							d1.close();
							 zTree.addNodes(nodes, {id:result.categoryId, pId:nodes.id, name:cateGoryName}); 
							}else{
							alert("系统维护中请稍后重试!");
							}		
						},
						error : function(data){
						alert("发生错误了！");
						}							
					});
    
    }
     function removeHoverDom(treeId,treeNode){
        $("#addBtn_"+treeNode.tId).unbind().remove();  
    }
    function addCategory(treeNode,cateGoryName){
     $.ajax({
			dataType : "text",
			async : false,
			type : "POST",
			url : "addProductCategory.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				parentCateGory :treeNode.id,
				cateGoryName : cateGoryName
				
			},
			success : function(data) {
				//提示
				var result=eval("("+data+")");
				//提示问题内容			
				if (result.result == "true") {
				var d = dialog({
   				 title: '友情提示',
   			 	content: '添加成功！'
				});
				d.show();
				flag=true;
				 if(flag){ 
				 if(cateGoryName=="新建同级节点"){
                              zTree.addNodes(treeNode, {id:result.categoryId, pId:treeNode.id, name:cateGoryName, isParent:true}); 
                             }else{
                              zTree.addNodes(treeNode, {id:result.categoryId, pId:treeNode.id, name:cateGoryName}); 
                             }                    
                            }
                            
                           
				}else{
				var d = dialog({
   				 title: '友情提示',
   			 	content: '添加失败！'
				});
				d.show();
				flag=false;
				}
			},
		}); 
    }
      function updateCategory(id,cateGoryName){
      $.ajax({
			dataType : "text",
			async : false,
			type : "POST",
			url : "updateProductCategory.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				id :id,
				cateGoryName : cateGoryName
				
			},
			success : function(data) {
				//提示
				if (data == "false") {
				var d = dialog({
   				 title: '友情提示',
   			 	content: '更新失败！'
				});
				d.show();
				flag=false;
				} else {
				var d = dialog({
   				 title: '友情提示',
   			 	content: '更新成功！'
				});
				d.show();
				flag=true;
				}
			},
		});
      }
      function deleteCategory(id){
       $.ajax({
			dataType : "text",
			async : false,
			type : "POST",
			url : "deleteProductCategory.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				id :id
			},
			success : function(data) {
				//提示
				if (data == "false") {
				var d = dialog({
   				 title: '友情提示',
   			 	content: '删除失败！'
				});
				d.show();
				flag=false;
				} else {
				var d = dialog({
   				 title: '友情提示',
   			 	content: '删除成功！'
				});
				d.show();
				flag=true;
				}
			},
		});
      }
     
    </script>
</head>


<body>
	<ul id="tree" class="ztree"></ul>
</body>

</html>
