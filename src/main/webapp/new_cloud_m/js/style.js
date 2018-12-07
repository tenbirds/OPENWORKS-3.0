$(document).ready(function(){
    $('body > span').text(($('#header').width() - 4) / ($('.navi > ul > li').size()));
    
    /*header quick */
    $('#header .quick li').width($('#header .quick ul').width() / $('#header .quick li').size());

    $('#header .navi li').width(($('#header .navi ul').width() - 4) / $('.navi li').resize());

    /* search */
    chk = 1;
    $("#header .btn-search").click(function(event){
        if (chk == 1) {     
            $('.sech_form').show();
            $(this).addClass("on");
            chk = 2;
        }
        else {          
            $('.sech_form').hide();
            $(this).removeClass("on");
            chk = 1;
        }
        event.preventDefault();
    });

    /*$('#footer .quick li').width(($('#footer ').width() / $('#footer .quick li').size()) - 1);*/
     /*$('#footer .quick li').width($('#footer .quick ul').width() / $('#footer .quick li').size());*/

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

    $('.tab-list ul li').width($('.tab-list ul').width() / $('.tab-list ul li').size());
    $(window).resize(function() {
        $('.tab-list ul li').width($('.tab-list ul').width() / $('.tab-list ul li').size());
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
            $(".more-view > div").css({height:"100%"});        
            $(this).text('주요기능 영역 접기').addClass("on");
            chk_o = 2;
        }
        else {          
            $(".more-view > div").css({height:"60px"});
            $(this).text('주요기능 영역 열기').removeClass("on");
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

    $('.file-area').width($('.file-area input[type="text"]').width() + $('.fake_input input').width() + 20 + $('.file_del').width());
    
    $('.file_del').css({
        marginRight : $('.fake_input .b-btn').width() + 15
    });

    center_cont = $('.center-cont li').each(function(){$(this).width($(this).find('span.agree').width());});
    
    $('.center-cont').width(center_cont.width());

    $('a.filter-pop').click(function(){
        $('div.filter-pop').show();
    });
    $('.filter-pop a.b-btn').click(function(){
        $('div.filter-pop').hide();
    });
    $('.filter-pop > div').height($(window).height() - 70);
    $('.filter-pop h2').append('<button>X</button>');
    $('.filter-pop h2 button').click(function(){
        $('div.filter-pop').hide();
    });

    $(window).resize(function(){
        $('.filter-pop > div').height($(window).height() - 70);
    });
    
    $('.type-view img').each(function(){
        width_chk = $('.type-view img').width();
        body_chk = $(window).width();
        if (body_chk < width_chk)
        {
            $(this).removeAttr("style");
        }
    });
});

//gnb 상단 고정
$(window).scroll(function(){
    var gnb = $(".navi");
    var st = $(document).scrollTop();   

    if(st < 78){
        gnb.removeClass('fixed');
    } else if( st > 79){
        gnb.addClass('fixed');
    }
});