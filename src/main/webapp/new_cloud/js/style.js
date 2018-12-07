$(document).ready(function(){
    $('body > span').text(($('#header').width() - 4) / ($('.navi > ul > li').size()));

    main_div_chk = $('.soft-it > div').attr('class');
    main_tab_chk = $(this).attr('class');
    $('.soft-it .tab-area li').each(function(){
        $(this).click(function(event){
            main_div_chk = $('.soft-it > div').attr('class');
            main_tab_chk = $(this).attr('class');
            $('.soft-it > div.tab > div').hide();
            $('.soft-it > div.tab > div' + '.' + main_tab_chk).show();
            event.preventDefault();
        });
    });

    experience_div = $('#experience > div ul li').attr('class');
    experience_tab = $(this).attr('class');
    $('#experience > div ul li').each(function(){
        $(this).click(function(event){
            experience_div = $('#experience div.section').attr('class');
            experience_tab = $(this).attr('class');
            $('#experience div.section').hide();
            $('#experience div.section' + '.' + experience_tab+' iframe').attr("width","550px");
            $('#experience div.section' + '.' + experience_tab).show();   
            $('#experience div.section .flexslider li').css({
                width:'811px'
            });
            event.preventDefault();
        });
    });

    $('.join-wrap .main .tab-area li').click(function(){
        Class_Mat = $(this).attr('class');
        $('div.multi-section-half').hide();
        $('div#' + Class_Mat).show();
    });
    
    /*header quick */
    /*$('#header .quick li').width($('#header .quick ul').width() / $('#header .quick li').size());*/

    /* navi li.width */
    $('.navi > ul > li').width( ($('#header').width() - 12) / $('.navi > ul > li').size() );
    /*$('.navi > ul > li').width(($('#header').width() - 30) / $('.navi > ul > li').size());*/

    /*$('#footer .quick li').width(($('#footer ').width() / $('#footer .quick li').size()) - 1);*/
     $('#footer .quick li').width(($('#footer .quick ul').width() / $('#footer .quick li').size()) - 1);

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
            $(this).parent('ul').find('> li > a').removeClass('on');
            $(this).find("a").addClass("on");
            //$(this).find('li:first-child').addClass('on');
        });
    });

    /* select box */
    var select = $(".select-box select");    
    select.change(function(){
        var select_name = $(this).children("option:selected").text();
        $(this).siblings("label").text(select_name);
    });

    /*$(".side-content .search > ul > li p").click(function(event){
        $(this).addClass('active');
        $(this).parent().find('ul').slideDown();
        event.preventDefault();
    });*/

    $(".side-content .search > ul > li p").click(function(event){
        filter_chk = $(this).attr('class');
        if (filter_chk == 'active')
        {
            $(this).parent().find('ul').slideUp();
            $(this).removeClass('active');
        } else {
            $(this).parent().find('ul').slideDown();
            $(this).addClass('active');
        }
         event.preventDefault();
    });

    /* more less */
    chk_o = 1;
    $(".more-view a").click(function(event){
        if (chk_o == 1) {       
            $(".more-view > div").css({height:"100%"});        
            $(this).text('접기').addClass("on");
            chk_o = 2;
        }
        else {          
            $(".more-view > div").css({height:"70px"});
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
        $('.tab-area ul.cs-center li a').removeClass('on');
        $(this).addClass('on');
        var activeTab = $(this).attr("href");
        $(activeTab).show();
        return false;
    });

    /* 20151202 add */
    chk_agree01 = 1;
    $(".btn-toggle.agree1").click(function(event){
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
    $(".btn-toggle.agree2").click(function(event){
        if (chk_agree02 == 1) {     
            $(".agreement.t02").show(); 
            $(this).text('닫기').addClass("on");
            chk_agree02 = 2;
        }
        else {          
            $(".agreement.t02").hide();
            $(this).text('열기').removeClass("on");
            chk_agree02 = 1;
        }
        event.preventDefault();
    });

    
    chk_agree03 = 1;
    $(".btn-toggle.agree3").click(function(event){
        if (chk_agree03 == 1) {     
            $(".agreement.t03").show(); 
            $(this).text('닫기').addClass("on");
            chk_agree03 = 2;
        }
        else {          
            $(".agreement.t03").hide();
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

    //$('.pop-tab > ul > li').width(($('.pop-tab > ul').width() / $('.pop-tab > ul > li').size()) -1 );  SKYOU 삭제 요망.. 팝업에다 삽입했어요..

    win_H = $(window).height()/2;
    error_H = $('.error-page').parent('div').height()/2;
    $('.error-page').parents('#container').offset({
        top:win_H - error_H
    });

    $('.stipulation-pop > div').height($('.stipulation-pop').height() - 160);
    $('.stipulation p a').click(function(){
        $('.stipulation-pop').show();
    });
    $('.stipulation-pop .type1').click(function(){
        $('.stipulation-pop').hide();
    });

});