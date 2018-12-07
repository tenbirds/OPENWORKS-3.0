$(function() {	
	//main > 슬라이더
	$('.btn_prev').on('click',function(){
		$('.thumb li:first')
			.appendTo('.thumb')
	});
	$('.btn_next').on('click',function(){
		$('.thumb li:last')
			.prependTo('.thumb')
	});

	//main > board
	$('.board ul > li > a').on('click',function(){
		$(this).parent().addClass('selectab');
		$(this).parent().siblings('li').removeClass('selectab');
		$('.selectab > .more_btn').css('display','block');
	});
	
	//sub > tab
	$('.tab_con').eq(0).css('display','block').siblings('.tab_con').css('display','none');
    $('.tab_st01 li').eq(0).addClass('on').siblings().removeClass('on');
    $('.tab_st01 li').on('click', function() {
       this.idx = $(this).index();
       $('.tab_st01 li').removeClass('on');
       $(this).addClass("on");
       $('.tab_con').css('display','none');
       $('.tab_con').eq(this.idx).css('display','block');
       return false;
    });
});


