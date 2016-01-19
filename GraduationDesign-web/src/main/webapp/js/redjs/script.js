$(function(){
	pageSize = 100;				
	$("#select1 dd").click(function () {
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) {
			$("#selectA").remove();
		} else {
			var copyThisA = $(this).clone();
		   if ($("#selectA").length > 0) {
				$("#selectA a").html($(this).text()).attr("title",$(this).children("a").attr("title"));
			} else {
				$(".select-result dl").append(copyThisA.attr("id", "selectA"));
			}
		}
		productList();
		alert("hehe1");		
	});
	function productList(){
		var superclass = $("#superclass").val();
		var subclass = $("#subclass").val();
		var productCategoryIds ="";
		$(".select-result dl dd a").each(function(i, slt) {
			var id=$(slt).attr("title");
			productCategoryIds+=id+((i >= $(".select-result dl dd a").length - 1) ? "" : ",");
	});
		$.ajax({
			type : "POST",
			url : "toProductsList.do",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				superclass : superclass,
				subclass : subclass,
				productCategoryIds : productCategoryIds
			},
			success : function(data) {
				//提示
				if (data == "false") {
					alert("添加失败！");
				} else {
					var json = eval(data);
					$("#search").html("");
					var content = '';
					for ( var i = 0; i < json.products.length; i++) {
						content +='<div class="case_li" style="float:left"><a href="toProductInfo.do?ProductId='+ json.products[i].id+'"><img width="160" height="170" src="<%=path%>'+ json.products[i].filePath+'" /></a><div class="case_li_txt"><div class="span_mr_txt"><a href="toProductInfo.do?ProductId='+ json.products[i].id+'">'+ json.products[i].productName+'</a></div><div class="span_detail"><a href="toProductInfo.do?ProductId='+ json.products[i].id+'" onfocus="blur"> 询价</a></div></div></div>';	
					}
					$("#ptotal").val(json.ptotal);
					$("#search").html(content);
				}
			}
		});
	}
	
	$("#select2 dd").click(function () {
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) {
			$("#selectB").remove();
		} else {
			var copyThisB = $(this).clone();
			if ($("#selectB").length > 0) {
				$("#selectB a").html($(this).text()).attr("title",$(this).children("a").attr("title"));
			} else {
				$(".select-result dl").append(copyThisB.attr("id", "selectB"));
			}
		}
		productList();
	});
	
	$("#select3 dd").click(function () {
		$(this).addClass("selected").siblings().removeClass("selected");
		if ($(this).hasClass("select-all")) {
			$("#selectC").remove();
		} else {
			var copyThisC = $(this).clone();
			if ($("#selectC").length > 0) {
				$("#selectC a").html($(this).text()).attr("title",$(this).children("a").attr("title"));
			} else {
				$(".select-result dl").append(copyThisC.attr("id", "selectC"));
			}
		}
		productList();
	});
	
	$("#selectA").live("click", function () {
		$(this).remove();
		$("#select1 .select-all").addClass("selected").siblings().removeClass("selected");
	});
	
	$("#selectB").live("click", function () {
		$(this).remove();
		$("#select2 .select-all").addClass("selected").siblings().removeClass("selected");
	});
	
	$("#selectC").live("click", function () {
		$(this).remove();
		$("#select3 .select-all").addClass("selected").siblings().removeClass("selected");
	});
	
  $(".select dd").live("click", function () {
		if ($(".select-result dd").length > 1) {
			$(".select-no").hide();
		} else {
			$(".select-no").show();
		}
	});
	
});