/*
***********************************************
* @description    : 자바스크립트 > 공통 
***********************************************
* DATE			AUTHOR		DESCRIPTION
* ---------------------------------------------
* 2014.09.24	장경진		최초작성
***********************************************
*/

$(document).ready(function(){
	

	/********************************************
	// TOP20 
	********************************************/
	$('.rank h4 a').bind('click focusin',function(){
		$('.rank ul li').removeClass('on');
		$(this).parent().parent().addClass('on');
		return false;
	});

	/********************************************
	// 판매하기 서비스,컨설팅 등록 언어별 정보 입력
	********************************************/
	$('.language .tab a').bind('click focusin',function(){
		$('.language .wrap').removeClass('on');
		$(this).parent().parent().addClass('on');
		return false;
	}); 	

	/********************************************
	* 판매하기 서비스관리 확장검색
	********************************************/
	$('.btn_ext > a').click(10, function() {
		$('#exttbl').slideToggle(function(){
			$('.btn_ext a span').toggleClass('off');
			$('.btn_ext a span').toggleClass('on');
		});
		return false;
	});

	/********************************************
	* 회원가입 약관동의 show hide
	********************************************/
	$('.btn_func').click(function(){ 
		var terms = $(this).next('.terms');     
		if( terms.is(':visible') ){ 
			terms.hide(); 
			$(this).removeClass('on').text('Open');
		} else { 
			terms.show();
			$(this).addClass('on').text('Close');
		}
	});

	/********************************************
	* 회원가입 구매 + 판매 언어별 show hide
	********************************************/
//	$('h5').click(function(){ 
//		var terms = $(this).next('.store_info');     
//		if( terms.is(':visible') ){ 
//			terms.hide();
//			$(this).removeClass('on');
//		} else { 
//			terms.show();
//			$(this).addClass('on');
//		}
//	});	

	/********************************************
	// Q&A
	********************************************/
	var article = ('.type_A .show');  
	$('.type_A .item  td .question').click(function() {  
		var myArticle =$(this).parents().next('tr');  
		if($(myArticle).hasClass('hide')) {  
			$(article).removeClass('show').addClass('hide');  
			$(myArticle).removeClass('hide').addClass('show');  
		}  
		else {  
			$(myArticle).addClass('hide').removeClass('show');  
		}  
		return false;
	});  

	/********************************************
	// SCROLLING 
	********************************************/
	$('a[href*=#]:not([href=#])').click(function() {
		if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
		  var target = $(this.hash);
		  target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
		  if (target.length) {
			$('html,body').animate({
			  scrollTop: target.offset().top
			  //scrollTop: target.offset().top-46
			}, 500);
			return false;
		  }
			
		}
		
	});

	/********************************************
	// SKIPNAVI FOCUS 
	********************************************/
	$('.skip_navi a').each(function(){
		$(this).click(function(){
			var thishref = $(this).attr('href');
			$(thishref).attr('tabindex','-1');
			$(thishref).focus();
		});
	});

	/********************************************
	// 말풍선
	********************************************/
	$('.advice a').bind('mouseenter focusin', function() {
		$(this).next().css('display','block');
		$(this).parent().css('z-index','1');
	});
	$('.advice a').bind('mouseleave focusout', function() {
		$(this).next().css('display','none');
		$(this).parent().css('z-index','');
	});

	/********************************************
	// 회원 가입 도움말 tooltip
	********************************************/
	$('.q_mark').bind('mouseenter focusin', function() {
		$(this).next().css('left','130px');
		$(this).next('.balloon').css('left','-23px');	//프리미엄,솔루션 서비스상세(구매 신청하기 버튼 말풍선)
		$('.balloon_area').next('.balloon').css('left','-43px');	// 판매하기 서비스등록
		$(this).parent().css('z-index','1');
	});
	$('.q_mark').bind('mouseleave focusout', function() {
		$(this).next().css('left','-9999px');
		$(this).parent().css('z-index','');
	});	
	
	/********************************************
	// 정보변경 도움말 tooltip
	********************************************/
	$('#tip').bind('mouseenter focusin', function() {			// 판매하기 전문가상담 내역에서 전문가상담 알림설정 말풍선
		$('.q_guide2').css('left','0');
	});
	$('#tip').bind('mouseleave focusout', function() {			// 판매하기 전문가상담 내역에서 전문가상담 알림설정 말풍선
		$('.q_guide2').css('left','-9999px');
	});
	
	/* 2014-12-02 추가 */
	$('.tip').bind('mouseenter focusin', function() {
		$(this).next().css('left','0');
	});
	$('.tip').bind('mouseleave focusout', function() {
		$(this).next().css('left','-9999px');
	});
	
	$('.tip02').bind('mouseenter focusin', function() {			// 회원쪽 정보입력 상점 명 말풍선	
		$(this).next().css('left','200px');
	});
	$('.tip02').bind('mouseleave focusout', function() {       // 회원쪽 정보입력 상점 명	말풍선
		$(this).next().css('left','-9999px');
	});
	/* //2014-12-02 추가 */

	/********************************************
	// 서비스 상세 메뉴바 (해당되는 페이지에 삽입)
	********************************************/
	/*var tab = $('#tab_area'),
		offset = tab.offset(),
		tabOffset = [],
		flag = 0,
		loaded  = false;*/
	
	//스크롤시 저장된 배열값과 스크롤값을 비교하여 탭 활성화 처리
	/*var tabActive = function(scrtop,bottom){
		for(var i=0; i<tabOffset.length; i++){
			if(scrtop >= tabOffset[i].top){
				flag = i;
			}
		}

		if(bottom == false){
			$('#tab_area ul li').find('a').removeClass('on');
			$('#tab_area ul li').find('a[href='#'+tabOffset[flag].id+'']').addClass('on');
		}else if(bottom == undefined){
			$('#tab_area ul li').find('a').removeClass('on');
			$('#tab_area ul li:first-child').find('a').addClass('on');
		}else{
			$('#tab_area ul li').find('a').removeClass('on');
			$('#tab_area ul li:last-child').find('a').addClass('on');
		}
	};*/
	
	//$(window).on('scroll',function(){
		//스크롤시 탭 fixed 처리
		/*var scrTop = $(window).scrollTop();
		var docHeight = $(document).height();
		var screenHeight = $(window).height();

		if(offset.top <= scrTop){
			tab.addClass('fixed');
			tab.css({
				top : '0'
			});
		}else{
			tab.removeClass('fixed');
			tab.css({
				top : '0'
			});
		}
		if(loaded == true){
			if(screenHeight + scrTop < docHeight){
				tabActive($(window).scrollTop(),false);
			}else{
				tabActive($(window).scrollTop(),true);
			}
		}*/
		//tabActive($(window).scrollTop());
	//});
	
	//탭 클릭시 동작 처리
	/*tab.find('a').click(function(){
		var anc = $(this).attr('href'),
		ancOffset = $(anc).offset();*/
		// 스크롤시에만 바뀌는걸로
		/*tab.find('a').removeClass('on');
		$(this).addClass('on');*/
		/*$(window).scrollTop(ancOffset.top);
		return false;
	});*/
	
	//$(window).load(function(){
		//onload시 아이디가 review로 시작하는 div 엘리먼트의 offset.top 값을 id와 함께 배열로 저장
		/*$('div[id*='productInfo']').each(function(index, element) {
			var offset = $(this).offset();
			tabOffset.push({
				id : $(this).attr('id'),
				top : offset.top
			});
		});
		loaded = true;
		tabActive($(window).scrollTop());*/
	//});

	/********************************************
	// checkbox check show/hide
	********************************************/
	$('#approv').click(function(){
		if ($(this).is(':checked'))
		{
			$('.approv_com').show();
		} else {
			$('.approv_com').hide();
		}
	});
	
	/********************************************
	// familysite
	********************************************/
	/*$('.siteLink a').bind('click focusin', function(){
		$('.familySite ul li').removeClass('on');
		$(this).parent().parent().parent().addClass('on');
		$(this).parent().addClass('on');
		return false;
	});
	$('.familySite').bind('mouseleave', function(){
		$('.familySite ul li').removeClass('on');
		$('.siteLink').removeClass('on');
		return false;
	});
	$('.familySite ul li:last-child ul.familyDetail li:last-child').bind('focusout', function(){
		$('.familySite ul li').removeClass('on');
	});*/

	
	/********************************************
	// border none
	********************************************/
	$('.list_colum ul li:last-child').addClass('last');		// 프리미엄 서비스
	$('.aside ul li:last-child').addClass('last');			// 인기 판매자 리스트
	$('.rank ul li:last-child').addClass('last');			// TOP20
	$('.rank ul li:nth-child(19)').addClass('last');		// TOP20
	
	
	/********************************************
	* 서비스상세 show hide
	********************************************/
	$('.btn_more').click(function(){ 
		var cont_more = $(this).next('.cont_more');     
		if( cont_more.is(':visible') ){ 
			cont_more.hide(); 
			$(this).removeClass('on').text('Open');
		} else { 
			cont_more.show();
			$(this).addClass('on').text('Close');
		}
		return false;
	});

});

/*****************************************************
// Image, List형 서비스 리스트, 고객센터(자주 찾는 질문)
******************************************************/
function viewCategory(num) {
	$('.tab_array ul > li > a').click(function() {
	    $('.category').addClass('hide');
		$('#category' + num).removeClass('hide');
		$('.tab_array ul > li > a').removeClass('on');
		$(this).addClass('on');

		$('.depth').addClass('hide');			//자주 찾는 질문
		$('#depth' + num).removeClass('hide');	//자주 찾는 질문

		/*for (i=1; i <= $('.tab_array ul li').length;i++) {
			$('img').eq(i).attr('src', $('img').eq(i).attr('src').replace(/(_on.gif|_off.gif)$/i, '_off.gif'));
		}
		$(this).find('a img').attr('src', $(this).find('a img').attr('src').replace(/(_on.gif|_off.gif)$/i, '_on.gif'));*/
	});	

	$('.image_colum .tab li a').click(function() {
		$('.image_colum .tab li a').removeClass('on');
		$(this).addClass('on');
		$('.image_colum .list').addClass('hide');
		$('#image' + num).removeClass('hide');		
	});

	$('.list_colum .tab li a').click(function()	{
		$('.list_colum .tab li a').removeClass('on');
		$(this).addClass('on');
		$('.list_colum .list').addClass('hide');
		$('#list' + num).removeClass('hide');		
	});
	
}

/* 2014-12-22 추가 */
/*****************************************************
// 회원가입
******************************************************/
function viewHistory(num) {
	$('.tab li .menu a').click(function() {
		$('.cont').addClass('hide');
		$('#join' + num).removeClass('hide');
		$('.tab li .menu a').removeClass('on');
		$(this).addClass('on');
	});	
}
/*//2014-12-22 추가 */

/********************************************
// Main Rolling (해당되는 페이지에 삽입)
********************************************/
/*var popup_timer = null;	
var popup_pause = false;
var popup_button_pause = false;
var select_popup_num = 1;
var popup_object_num = 3; 

function popup_display(popupIDX, move) {
	if(!popupIDX)  {
		popupIDX = select_popup_num;
		if(popup_pause==true && !move) return;
		if(popup_button_pause==true && !move) return;
		if(!move) move = 'next';
		hide_popup(popupIDX);
	} else {
		hide_popup(select_popup_num);
	}
	if(move=='prev') {
		if(popupIDX==1) {
			popupIDX = popup_object_num;
		} else {
			popupIDX--;
		}
	} else if(move=='next') {
		if(popupIDX==popup_object_num) {
			popupIDX = 1;
		} else {
			popupIDX++;
		}
	} else if(move=='pause') {			
		popup_button_pause=true;
		$('#btnPlay').show();
		$('#btnPause').hide();
	}else if(move=='play') {			
		popup_button_pause=false;
		$('#btnPlay').hide();
		$('#btnPause').show();
	}
	show_popup(popupIDX);
	select_popup_num = popupIDX;
}

function hide_popup(num) {	
	$('#hongboImg' + num).hide();	
	var imgSrc = $('#hongboNum' + num).find('input').attr('src');
	$('#hongboNum' + num).find('input').attr('src',imgSrc.replace('_on','_off'));		
}

function show_popup(num) {		
	$('#hongboImg' + num).show();
	var imgSrc = $('#hongboNum' + num).find('input').attr('src');
	$('#hongboNum' + num).find('input').attr('src',imgSrc.replace('_off','_on'));
}
function popup_scroll() {
	popup_timer = setInterval('popup_display()',3000); 
}	

$(document).ready(function(){         		   
  $('.mainBanner li a').bind('focus mouseenter',function(e){   		  
	popup_button_pause=true;	
	  return false;		  
  });
  $('.mainBanner li a').bind('focusout mouseleave',function(e){   		  
	popup_button_pause=false;
	  return false;		  
  });

	popup_scroll();

});*/

/********************************************
// layer show/hide
********************************************/
function showLayer(id) {
	document.getElementById(id).style.display = 'block';
}
function hideLayer(id) {
	document.getElementById(id).style.display = 'none';
}

/********************************************
// ID 영역 프린트
********************************************/
 function print(printArea) {
	win = window.open(); 
	self.focus(); 
	win.document.open();
	/*
	1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
	2. window.open() 을 사용하여 새 팝업창을 띄운다.
	3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
	4. <body> 안에 매개변수로 받은 printArea를 추가한다.
	5. window.print() 로 인쇄
	6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
	*/
	win.document.write('<html><head><title></title><style>');
	win.document.write('body {font-family:dotum;font-size:12px;color#333;');
	win.document.write('</style></haed><body>');
	win.document.write(printArea);
	win.document.write('</body></html>');
	win.document.close();
	win.print();
	win.close();
}

/********************************************
// GNB 
********************************************/
$.fn.gnbAct  = function () {
 	/* gnb items, mouse and focus effect */
    $('.gnbNavi li > a').bind('mouseenter focus', function() {
 	    var thisA = $(this);
 	    var thisId = thisA.attr("id");

 	    if(thisId == "premium" || thisId == "solution" || thisId == "cnsl"){ 	        
 	        if(thisId == "premium"){
 	           ctgryClCd = '1001';
 	        }else if(thisId == "solution"){
 	           ctgryClCd = '1002';
 	        }else{
 	           ctgryClCd = '1003';
 	        }
 	        $.ajax({
 	            url      : "/english/common/commonduty/ND_ctgryView.do",
 	            type     : "POST",
 	            data     : { ctgryClCd : ctgryClCd },
 	            dataType : "json",
 	            async    : false,
 	            success  : function(response){
 	                $(".depth1").empty();
 	                //검색된 카테고리 목록 셋팅
 	                var ctgryTotal = response.ctgryList.length;
 	                var ctgry2Total = response.ctgry2List.length;
 	                var eventTotal = response.eventList.length;
 	                if(ctgryTotal > 0){
 	                    for(var i = 0; i < ctgryTotal; i++){
 	  	                    $('<li><a href="/english/pt/store/' + thisId + '/BD_index.do?ctgryCode=' + response.ctgryList[i].id + '" id="' + response.ctgryList[i].id + '" onmouseover="javascript:get2dCtgry(this);" onfocus="javascript:get2dCtgry(this);">' + response.ctgryList[i].text + '</a><ul id="depth2_' + (i+1) + '" class="depth2"></ul><ul id="depth2_more_' + (i+1) + '" class="depth2"></ul></li>').appendTo(".depth1");
 	                    }
 	                }
 	                //최초 2Depth
                    if(ctgry2Total > 0){
                        $(".depth2").empty();
                        for(var j = 0; j < ctgry2Total; j++){
                            if(j < 7){
                                $('<li><a href="/english/pt/store/' + thisId + '/BD_index.do?ctgryCode=' + response.ctgry2List[j].id + '" id="' + response.ctgry2List[j].id + '">' + response.ctgry2List[j].text + '</a></li>').appendTo("#"+thisId+"_depth1 #depth2_1");
                            }else{
                                $('<li><a href="/english/pt/store/' + thisId + '/BD_index.do?ctgryCode=' + response.ctgry2List[j].id + '" id="' + response.ctgry2List[j].id + '">' + response.ctgry2List[j].text + '</a></li>').appendTo("#"+thisId+"_depth1 #depth2_more_1");
                            }
                        }
                    }
                    //이벤트
                    if(eventTotal > 0){
                        for(var l = 0; l < $('ul[id^=scrollerFrame]').length; l++){
                            $("#scrollerFrame"+(l+1)).empty();
                            for(var k = 0; k < eventTotal; k++){
                                $('<li><img width="319" height="213" style="cursor:pointer;" onclick="javascript:moveEvent('+ response.eventList[k].eventSn +');" src="' + response.eventList[k].eventFilePath + '" alt="' + response.eventList[k].imageAlt + '"></li>').appendTo("#scrollerFrame"+(l+1));
                            }
                        }
                        $("#eventBtn").show();
                    }
 	            }
 	        });

    		if (thisA.parent('li').parent('ul').hasClass('gnbNavi')) {
    			/* gnb image rolling */
    			gnbFirstDepAct(thisA);
    		} else {
    			thisA.parent('li').siblings('li').each( function() {
    			    thisA.removeClass('active').children('a').removeClass('on'); 
    			});
    			thisA.addClass('on').parent('li').addClass('active');
    		}
    		gnbHtAdjust(thisA); // gnb submenu box height animate
 	    //카테고리 외의 메뉴는 선택레이어 표시 안함
 	    }else{
 	        $('.gnbNavi > li').removeClass('active');
 	        $('.gnbNavi > li').removeClass('active_on');
 	    }
 	});
 	
 	$('.gnbNavi li > a').bind('mouseleave focusout', function() {
 		$('.depth2 li a').removeClass('on');
 	});
 	
 	/* submenu hide act */
 	$('.gnbNavi').mouseleave( function() {
 	    $('.depth1 li a').removeClass('on');
 	    $('.depth1 li').removeClass('active');
        $('.gnbNavi li > a').removeClass('on');
 		$('.gnbMenu').removeClass('hover');
 	});
 };

 /* 1depth a over actions */
 function gnbFirstDepAct(thisAItm) {
 	//if(thisAItm.hasClass('on')){
 	    //thisAItm.addClass('on').parent('li').addClass('active');
 	//} else {
 		$('.gnbNavi .active').removeClass('active');
 		$('.gnbNavi .active_on').removeClass('active_on');
 		$('.gnbNavi .on').removeClass('on');
 		thisAItm.addClass('on').parent('li').addClass('active').children('a').addClass('on');
 		thisAItm.addClass('on').parent('li').addClass('active_on').children('a').addClass('on');
 		thisAItm.parent('li').find('.depth1').children('li:first').addClass('active').children('a').addClass('on');
 	//}
 }

 /* submenu - wrapper - height adjust and animate */
 function gnbHtAdjust(overItm) {
 	var subHtItm = $('.active .gnbMenu');
 	var visibleUl = subHtItm.find('ul:visible');
 	var visibleUlLen = visibleUl.length;
 	var thisItmHt2 = 0;
 	animateHts(thisItmHt2);
 }
 
 function animateHts(thisItmHt2) {
	 $('.gnbNavi .gnbMenu, .gnbNavi .gnbMenu').stop().addClass('hover');
 }

 function get2dCtgry(el){
     var thisA = $(el);
     var thisId = thisA.parent().parent('ul').attr("id").split("_depth1")[0];
     var cateVal = thisA.attr("id");

     if(thisId == "premium"){
         ctgryClCd = '1001';
     }else if(thisId == "solution"){
         ctgryClCd = '1002';
     }else{
         ctgryClCd = '1003';
     }

     $(el).parent().parent().children('li').children('a').removeClass('on');
     $(el).parent().parent().children('li').removeClass('active');
     
     $.ajax({
         url      : "/english/common/commonduty/ND_ctgry2dView.do",
         type     : "POST",
         data     : { ctgryClCd : ctgryClCd, upperMenuCd : cateVal },
         dataType : "json",
         async    : false,
         success  : function(response){
            $('.depth2').empty();
            $('.depth2').attr("style","display:none");
            $("#"+thisId+"_depth1 #depth2_1").attr("style","display:block");
            $("#"+thisId+"_depth1 #depth2_more_1").attr("style","display:block");
            //검색된 카테고리 목록 셋팅
            var ctgryTotal = response.ctgryList.length;
            if(ctgryTotal > 0){
                
                for(var a = 0; a < ctgryTotal; a++){
                    if(a < 7){
                        $('<li><a href="/english/pt/store/' + thisId + '/BD_index.do?ctgryCode=' + response.ctgryList[a].id + '" id="' + response.ctgryList[a].id + '">' + response.ctgryList[a].text + '</a></li>').appendTo("#"+thisId+"_depth1 #depth2_1");
                    }else{
                        $('<li><a href="/english/pt/store/' + thisId + '/BD_index.do?ctgryCode=' + response.ctgryList[a].id + '" id="' + response.ctgryList[a].id + '">' + response.ctgryList[a].text + '</a></li>').appendTo("#"+thisId+"_depth1 #depth2_more_1");
                    }
                }
            }
         }
     });
     thisA.parent('li').addClass('active');
     thisA.addClass('on');
 }
 
 function moveEvent(sn){
     location.href="/english/pt/webevent/BD_eventView.do?flag=N&eventSn="+sn;
 }

 function fn_mainSearch(){
     serachKeyword = document.getElementById("totalKeyword");
     if(serachKeyword.value == ""){
         alert(Message.msg.enterSrchWrd);
         serachKeyword.focus();
         return;
     }else{
         location.href="/english/pt/search/BD_index.do?searchKeyword="+encodeURIComponent(serachKeyword.value);
     }
 }

 $.fn.gnbInit = function() {
 	//GNB
 	$('div.gnbWr > ul.gnbNavi', this).gnbAct();
 };
 
 $(function() {
 	$('body').gnbInit();
 });