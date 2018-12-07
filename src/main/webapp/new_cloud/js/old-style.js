$(document).ready(function(){
    $('body > span').text(($('#header').width() - 4) / ($('.navi > ul > li').size()));
	
	/*header quick */
	 $('#header .quick li').width($('#header .quick ul').width() / $('#header .quick li').size());

	/* navi li.width */
    /*$('.navi > ul > li').width((($('#header').width() - 4) / ($('.navi > ul > li').size())) - 2);*/
	$('.navi > ul > li').width(($('#header').width() - 28) / $('.navi > ul > li').size());

    /*$('#footer .quick li').width(($('#footer ').width() / $('#footer .quick li').size()) - 1);*/
	 $('#footer .quick li').width(($('#footer .quick ul').width() / $('#footer .quick li').size()) - 1);

	/* egov */
	$('#header .egov').mouseenter(function(){
		$(this).animate({marginTop:'-3px'},200);
	});
	$('#header .egov').mouseleave(function(){
		$(this).stop(true,true).animate({marginTop:'0'},200);
	});

	/* tab-area */
	var tab_depth = $('.tab-area > ul').height() + $('.tab-area ul li ul').height();	
	$('.tab-area ul.full').height(tab_depth);
	$('.tab-area ul.full > li').width((($('.tab-area > ul').width()) / $('.tab-area ul.full > li').size())-1);

	$('.tab-area ul.full > li').click(function(event){
		$('.tab-area ul.full > li ul').hide();
		$(this).find('ul').show();
		event.preventDefault();
    });

	$('.tab-area').each(function(){
		$(this).find('> ul').find('> li').click(function(){
			$(this).parent('ul').find('> li').removeClass('on');
			$(this).addClass("on");
			//$(this).find('li:first-child').addClass('on');
		});
	});

	/* select box */
    var select = $(".select-box select");    
    select.change(function(){
        var select_name = $(this).children("option:selected").text();
        $(this).siblings("label").text(select_name);
    });

	$(".side-content .search > ul > li p").click(function(event){
		$(this).addClass('active');
		$(this).parent().find('ul').slideDown();
		event.preventDefault();
	});

	/* more less */
	chk_o = 1;
	$(".more-view a").click(function(event){
		if (chk_o == 1) {		
			$(".more-view ul").css({height:"100%"});		
			$(this).text('접기').addClass("on");
			chk_o = 2;
		}
		else {			
			$(".more-view ul").css({height:"250px"});
			$(this).text('기능 더보기').removeClass("on");
			chk_o = 1;
		}
		event.preventDefault();
	});
	
	/* detail mark-list */
	$('.mark-list li').width((($('.mark-list').width()) / $('.mark-list li').size())-1);

	/* lnb */
	$('.lnb li').click(function(){
		$(this).parent().removeClass('on');
	});

	/* 20151201 add */
	$('#daegu').show();
	$('.tab-area .map li a').click(function(){
		$('.location').hide();
		$('.tab-area ul.cs-center li').removeClass('on');
		$(this).parent('li').addClass('on');
		var activeTab = $(this).attr("href");
		$(activeTab).show();
		return false;
	});

	/* 20151202 add */
	chk_agree01 = 1;
	$(".btn-toggle.close").click(function(event){
		if (chk_agree01 == 1) {		
			$(".agreement.t01").hide();
			$(".join-area.korean .type-write").hide();
			$(this).text('열기').addClass("on");
			chk_agree01 = 2;
		}
		else {			
			$(".agreement.t01").show();
			$(".join-area.korean .type-write").show();
			$(this).text('닫기').removeClass("on");
			chk_agree01 = 1;
		}
		event.preventDefault();
	});

	chk_agree02 = 1;
	$(".btn-toggle.open").click(function(event){
		if (chk_agree02 == 1) {		
			$(".agreement.t02").show();	
			$(".join-area.english .type-write").show();
			$(this).text('닫기').addClass("on");
			chk_agree02 = 2;
		}
		else {			
			$(".agreement.t02").hide();
			$(".join-area.english .type-write").hide();
			$(this).text('열기').removeClass("on");
			chk_agree02 = 1;
		}
		event.preventDefault();
	});

	chk_agree03 = 1;
	$(".btn-toggle-other.open").click(function(event){
		if (chk_agree03 == 1) {		
			$(".join-area.spanish .type-write").show();
			$(this).text('닫기').addClass("on");
			chk_agree03 = 2;
		}
		else {			
			$(".join-area.spanish .type-write").hide();
			$(this).text('열기').removeClass("on");
			chk_agree03 = 1;
		}
		event.preventDefault();
	});

	$('.layer-pop .btn-close').click(function(){
		$('.layer-pop').hide();
	});
	$('a.post').click(function(event){
		$('.layer-pop').show();
		event.preventDefault();

		/* 잘못되었던 점 : 페이지 이동하였을 때는 Default로 레이어 팝업이 나오지 않음.
		그래서 높이값을 계산하지 못한것임.
		레이어 팝업 버튼을 클릭했을 때 높이값을 계산해야 함 */

		//$('.layer-pop > span').text($('.pop-cont').height());
		cont_pos = ($(window).height() - $('.pop-cont').height()) / 2;
		$('.pop-cont').css({
			top : cont_pos,
			bottom : cont_pos
		});
	});

	$('.btn-qna').click(function(event){
		$('.layer-pop').show();
		event.preventDefault();

		cont_pos = ($(window).height() - $('.pop-cont').height()) / 2;
		$('.pop-cont').css({
			top : cont_pos,
			bottom : cont_pos
		});
	});

	$('.thumb-list > ul > li').width($('.thumb-list > ul').width() / 3);

	/* tooltip */
	$('.tooltip').mouseenter(function(){
		$(this).find('.tooltip-box').show();
	});
	$('.tooltip').mouseleave(function(){
		$(this).find('.tooltip-box').hide();
	});

	$('.fake_input input').css({
		width : $('.fake_input .b-btn').width() + 10,
		height: $('.fake_input .b-btn').height() + 2
	});
	$('.file_del').css({
		marginRight : $('.fake_input .b-btn').width() + 15
	});

});