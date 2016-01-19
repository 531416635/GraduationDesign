// JavaScript Document
$(function(){
	$(".i_2").hide();
	$(".nav_y").mousemove(function(){
		$(".i_2").hide();
		$(".i_1").show();
		x=$(".nav_y").index(this);
		$(".i_1").eq(x).hide();
		$(".i_2").eq(x).show();
	})
	$(".nav_y").mouseout(function(){
		$(".i_2").hide();
		$(".i_1").show();
		})
})

$(function(){
	$(".nav_y").mousemove(function(){
		x=$(".nav_y").index(this);
		$(".n").eq(x).css("color","#f9f9f9")
		});
	$(".nav_y").mouseout(function(){
		$(".n").css("color","#464b5e")
		});
})

$(function(){
	/*整合图片，初始化*/
	var n=0;
	$(".banner img").hide();
	$(".banner img:first").show();
	/*鼠标指向按钮*/
	$(".ba_2").click(function(){
		/*当前项添加whiteLi类*/
		$(".ba_2").removeClass("whiteLi");
		$(this).addClass("whiteLi");
		/*找到当前按钮索引值*/
		n = $(".ba_2").fadeIn(1000).index(this);	
		/*指定显示哪张图片*/
		$(".banner img").hide();
		$(".banner img:eq("+n+")").fadeIn(1000).show();
		/*指定显示哪个文本*/
	})
	/*动画的变化函数*/
	function changeImg(){
		if(n<$(".banner img").length-1){
			n=n+1;
		}else{
			n=0;
		}
		$(".banner img").hide();
		$(".banner img:eq("+n+")").fadeIn(1000).show();
		
		$(".ba_2").removeClass("whiteLi");
		$(".ba_2:eq("+n+")").addClass("whiteLi");
	}
	var timer = setInterval(changeImg,5000);
	/*控制定时器*/
	$(".banner").mouseover(function(){
		clearInterval(timer);	
	}).mouseout(function(){
		timer = setInterval(changeImg,5000);	
	})
})
$(function(){
	$(".ba_2").eq(0).addClass("whiteLi");
})

$(function(){								//css调用
	$(".no").eq(0).addClass("noT");
	$(".no").click(function(){
		xBtn=$(".no").index(this);
		$(".no").removeClass("noT");
		$(this).addClass("noT");
		})
})

$(function(){							//点击显示
	$(".n_each").hide();
	$(".n_each").eq(0).show();
	$(".no").click(function(){
		x=$(".no").index(this);
		$(".n_each").hide();
		$(".n_each").eq(x).show();
		});
})

$(function(){							//鼠标移入显示，移除隐藏
	$(".subpage").hide();
	$(".all_t").hover(function(){
		n=$(".all_t").index(this);
		$(".subpage").eq(n).slideDown(300);
		},function(){
		$(".subpage").slideUp(300);	
			})
})

