 /**
 * BxSlider v4.1.2 - Fully loaded, responsive content slider
 * http://bxslider.com
 */
!function(t){var e={},s={mode:"horizontal",slideSelector:"",infiniteLoop:!0,hideControlOnEnd:!1,speed:500,easing:null,slideMargin:0,startSlide:0,randomStart:!1,captions:!1,ticker:!1,tickerHover:!1,adaptiveHeight:!1,adaptiveHeightSpeed:500,video:!1,useCSS:!0,preloadImages:"visible",responsive:!0,slideZIndex:50,touchEnabled:!0,swipeThreshold:50,oneToOneTouch:!0,preventDefaultSwipeX:!0,preventDefaultSwipeY:!1,pager:!0,pagerType:"full",pagerShortSeparator:" / ",pagerSelector:null,buildPager:null,pagerCustom:null,controls:!0,nextText:"Next",prevText:"Prev",nextSelector:null,prevSelector:null,autoControls:!1,startText:"Start",stopText:"Stop",autoControlsCombine:!1,autoControlsSelector:null,auto:!1,pause:4e3,autoStart:!0,autoDirection:"next",autoHover:!1,autoDelay:0,minSlides:1,maxSlides:1,moveSlides:0,slideWidth:0,onSliderLoad:function(){},onSlideBefore:function(){},onSlideAfter:function(){},onSlideNext:function(){},onSlidePrev:function(){},onSliderResize:function(){}};t.fn.bxSlider=function(n){if(0==this.length)return this;if(this.length>1)return this.each(function(){t(this).bxSlider(n)}),this;var o={},r=this;e.el=this;var a=t(window).width(),l=t(window).height(),d=function(){o.settings=t.extend({},s,n),o.settings.slideWidth=parseInt(o.settings.slideWidth),o.children=r.children(o.settings.slideSelector),o.children.length<o.settings.minSlides&&(o.settings.minSlides=o.children.length),o.children.length<o.settings.maxSlides&&(o.settings.maxSlides=o.children.length),o.settings.randomStart&&(o.settings.startSlide=Math.floor(Math.random()*o.children.length)),o.active={index:o.settings.startSlide},o.carousel=o.settings.minSlides>1||o.settings.maxSlides>1,o.carousel&&(o.settings.preloadImages="all"),o.minThreshold=o.settings.minSlides*o.settings.slideWidth+(o.settings.minSlides-1)*o.settings.slideMargin,o.maxThreshold=o.settings.maxSlides*o.settings.slideWidth+(o.settings.maxSlides-1)*o.settings.slideMargin,o.working=!1,o.controls={},o.interval=null,o.animProp="vertical"==o.settings.mode?"top":"left",o.usingCSS=o.settings.useCSS&&"fade"!=o.settings.mode&&function(){var t=document.createElement("div"),e=["WebkitPerspective","MozPerspective","OPerspective","msPerspective"];for(var i in e)if(void 0!==t.style[e[i]])return o.cssPrefix=e[i].replace("Perspective","").toLowerCase(),o.animProp="-"+o.cssPrefix+"-transform",!0;return!1}(),"vertical"==o.settings.mode&&(o.settings.maxSlides=o.settings.minSlides),r.data("origStyle",r.attr("style")),r.children(o.settings.slideSelector).each(function(){t(this).data("origStyle",t(this).attr("style"))}),c()},c=function(){r.wrap('<div class="bx-wrapper"><div class="bx-viewport"></div></div>'),o.viewport=r.parent(),o.loader=t('<div class="bx-loading" />'),o.viewport.prepend(o.loader),r.css({width:"horizontal"==o.settings.mode?100*o.children.length+215+"%":"auto",position:"relative"}),o.usingCSS&&o.settings.easing?r.css("-"+o.cssPrefix+"-transition-timing-function",o.settings.easing):o.settings.easing||(o.settings.easing="swing"),f(),o.viewport.css({width:"100%",overflow:"hidden",position:"relative"}),o.viewport.parent().css({maxWidth:p()}),o.settings.pager||o.viewport.parent().css({margin:"0 auto 0px"}),o.children.css({"float":"horizontal"==o.settings.mode?"left":"none",listStyle:"none",position:"relative"}),o.children.css("width",u()),"horizontal"==o.settings.mode&&o.settings.slideMargin>0&&o.children.css("marginRight",o.settings.slideMargin),"vertical"==o.settings.mode&&o.settings.slideMargin>0&&o.children.css("marginBottom",o.settings.slideMargin),"fade"==o.settings.mode&&(o.children.css({position:"absolute",zIndex:0,display:"none"}),o.children.eq(o.settings.startSlide).css({zIndex:o.settings.slideZIndex,display:"block"})),o.controls.el=t('<div class="bx-controls" />'),o.settings.captions&&P(),o.active.last=o.settings.startSlide==x()-1,o.settings.video&&r.fitVids();var e=o.children.eq(o.settings.startSlide);"all"==o.settings.preloadImages&&(e=o.children),o.settings.ticker?o.settings.pager=!1:(o.settings.pager&&T(),o.settings.controls&&C(),o.settings.auto&&o.settings.autoControls&&E(),(o.settings.controls||o.settings.autoControls||o.settings.pager)&&o.viewport.after(o.controls.el)),g(e,h)},g=function(e,i){var s=e.find("img, iframe").length;if(0==s)return i(),void 0;var n=0;e.find("img, iframe").each(function(){t(this).one("load",function(){++n==s&&i()}).each(function(){this.complete&&t(this).load()})})},h=function(){if(o.settings.infiniteLoop&&"fade"!=o.settings.mode&&!o.settings.ticker){var e="vertical"==o.settings.mode?o.settings.minSlides:o.settings.maxSlides,i=o.children.slice(0,e).clone().addClass("bx-clone"),s=o.children.slice(-e).clone().addClass("bx-clone");r.append(i).prepend(s)}o.loader.remove(),S(),"vertical"==o.settings.mode&&(o.settings.adaptiveHeight=!0),o.viewport.height(v()),r.redrawSlider(),o.settings.onSliderLoad(o.active.index),o.initialized=!0,o.settings.responsive&&t(window).bind("resize",Z),o.settings.auto&&o.settings.autoStart&&H(),o.settings.ticker&&L(),o.settings.pager&&q(o.settings.startSlide),o.settings.controls&&W(),o.settings.touchEnabled&&!o.settings.ticker&&O()},v=function(){var e=0,s=t();if("vertical"==o.settings.mode||o.settings.adaptiveHeight)if(o.carousel){var n=1==o.settings.moveSlides?o.active.index:o.active.index*m();for(s=o.children.eq(n),i=1;i<=o.settings.maxSlides-1;i++)s=n+i>=o.children.length?s.add(o.children.eq(i-1)):s.add(o.children.eq(n+i))}else s=o.children.eq(o.active.index);else s=o.children;return"vertical"==o.settings.mode?(s.each(function(){e+=t(this).outerHeight()}),o.settings.slideMargin>0&&(e+=o.settings.slideMargin*(o.settings.minSlides-1))):e=Math.max.apply(Math,s.map(function(){return t(this).outerHeight(!1)}).get()),e},p=function(){var t="100%";return o.settings.slideWidth>0&&(t="horizontal"==o.settings.mode?o.settings.maxSlides*o.settings.slideWidth+(o.settings.maxSlides-1)*o.settings.slideMargin:o.settings.slideWidth),t},u=function(){var t=o.settings.slideWidth,e=o.viewport.width();return 0==o.settings.slideWidth||o.settings.slideWidth>e&&!o.carousel||"vertical"==o.settings.mode?t=e:o.settings.maxSlides>1&&"horizontal"==o.settings.mode&&(e>o.maxThreshold||e<o.minThreshold&&(t=(e-o.settings.slideMargin*(o.settings.minSlides-1))/o.settings.minSlides)),t},f=function(){var t=1;if("horizontal"==o.settings.mode&&o.settings.slideWidth>0)if(o.viewport.width()<o.minThreshold)t=o.settings.minSlides;else if(o.viewport.width()>o.maxThreshold)t=o.settings.maxSlides;else{var e=o.children.first().width();t=Math.floor(o.viewport.width()/e)}else"vertical"==o.settings.mode&&(t=o.settings.minSlides);return t},x=function(){var t=0;if(o.settings.moveSlides>0)if(o.settings.infiniteLoop)t=o.children.length/m();else for(var e=0,i=0;e<o.children.length;)++t,e=i+f(),i+=o.settings.moveSlides<=f()?o.settings.moveSlides:f();else t=Math.ceil(o.children.length/f());return t},m=function(){return o.settings.moveSlides>0&&o.settings.moveSlides<=f()?o.settings.moveSlides:f()},S=function(){if(o.children.length>o.settings.maxSlides&&o.active.last&&!o.settings.infiniteLoop){if("horizontal"==o.settings.mode){var t=o.children.last(),e=t.position();b(-(e.left-(o.viewport.width()-t.width())),"reset",0)}else if("vertical"==o.settings.mode){var i=o.children.length-o.settings.minSlides,e=o.children.eq(i).position();b(-e.top,"reset",0)}}else{var e=o.children.eq(o.active.index*m()).position();o.active.index==x()-1&&(o.active.last=!0),void 0!=e&&("horizontal"==o.settings.mode?b(-e.left,"reset",0):"vertical"==o.settings.mode&&b(-e.top,"reset",0))}},b=function(t,e,i,s){if(o.usingCSS){var n="vertical"==o.settings.mode?"translate3d(0, "+t+"px, 0)":"translate3d("+t+"px, 0, 0)";r.css("-"+o.cssPrefix+"-transition-duration",i/1e3+"s"),"slide"==e?(r.css(o.animProp,n),r.bind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd",function(){r.unbind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd"),D()})):"reset"==e?r.css(o.animProp,n):"ticker"==e&&(r.css("-"+o.cssPrefix+"-transition-timing-function","linear"),r.css(o.animProp,n),r.bind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd",function(){r.unbind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd"),b(s.resetValue,"reset",0),N()}))}else{var a={};a[o.animProp]=t,"slide"==e?r.animate(a,i,o.settings.easing,function(){D()}):"reset"==e?r.css(o.animProp,t):"ticker"==e&&r.animate(a,speed,"linear",function(){b(s.resetValue,"reset",0),N()})}},w=function(){for(var e="",i=x(),s=0;i>s;s++){var n="";o.settings.buildPager&&t.isFunction(o.settings.buildPager)?(n=o.settings.buildPager(s),o.pagerEl.addClass("bx-custom-pager")):(n=s+1,o.pagerEl.addClass("bx-default-pager")),e+='<div class="bx-pager-item"><a href="" data-slide-index="'+s+'" class="bx-pager-link">'+n+"</a></div>"}o.pagerEl.html(e)},T=function(){o.settings.pagerCustom?o.pagerEl=t(o.settings.pagerCustom):(o.pagerEl=t('<div class="bx-pager" />'),o.settings.pagerSelector?t(o.settings.pagerSelector).html(o.pagerEl):o.controls.el.addClass("bx-has-pager").append(o.pagerEl),w()),o.pagerEl.on("click","a",I)},C=function(){o.controls.next=t('<a class="bx-next" href="">'+o.settings.nextText+"</a>"),o.controls.prev=t('<a class="bx-prev" href="">'+o.settings.prevText+"</a>"),o.controls.next.bind("click",y),o.controls.prev.bind("click",z),o.settings.nextSelector&&t(o.settings.nextSelector).append(o.controls.next),o.settings.prevSelector&&t(o.settings.prevSelector).append(o.controls.prev),o.settings.nextSelector||o.settings.prevSelector||(o.controls.directionEl=t('<div class="bx-controls-direction" />'),o.controls.directionEl.append(o.controls.prev).append(o.controls.next),o.controls.el.addClass("bx-has-controls-direction").append(o.controls.directionEl))},E=function(){o.controls.start=t('<div class="bx-controls-auto-item"><a class="bx-start" href="">'+o.settings.startText+"</a></div>"),o.controls.stop=t('<div class="bx-controls-auto-item"><a class="bx-stop" href="">'+o.settings.stopText+"</a></div>"),o.controls.autoEl=t('<div class="bx-controls-auto" />'),o.controls.autoEl.on("click",".bx-start",k),o.controls.autoEl.on("click",".bx-stop",M),o.settings.autoControlsCombine?o.controls.autoEl.append(o.controls.start):o.controls.autoEl.append(o.controls.start).append(o.controls.stop),o.settings.autoControlsSelector?t(o.settings.autoControlsSelector).html(o.controls.autoEl):o.controls.el.addClass("bx-has-controls-auto").append(o.controls.autoEl),A(o.settings.autoStart?"stop":"start")},P=function(){o.children.each(function(){var e=t(this).find("img:first").attr("title");void 0!=e&&(""+e).length&&t(this).append('<div class="bx-caption"><span>'+e+"</span></div>")})},y=function(t){o.settings.auto&&r.stopAuto(),r.goToNextSlide(),t.preventDefault()},z=function(t){o.settings.auto&&r.stopAuto(),r.goToPrevSlide(),t.preventDefault()},k=function(t){r.startAuto(),t.preventDefault()},M=function(t){r.stopAuto(),t.preventDefault()},I=function(e){o.settings.auto&&r.stopAuto();var i=t(e.currentTarget),s=parseInt(i.attr("data-slide-index"));s!=o.active.index&&r.goToSlide(s),e.preventDefault()},q=function(e){var i=o.children.length;return"short"==o.settings.pagerType?(o.settings.maxSlides>1&&(i=Math.ceil(o.children.length/o.settings.maxSlides)),o.pagerEl.html(e+1+o.settings.pagerShortSeparator+i),void 0):(o.pagerEl.find("a").removeClass("active"),o.pagerEl.each(function(i,s){t(s).find("a").eq(e).addClass("active")}),void 0)},D=function(){if(o.settings.infiniteLoop){var t="";0==o.active.index?t=o.children.eq(0).position():o.active.index==x()-1&&o.carousel?t=o.children.eq((x()-1)*m()).position():o.active.index==o.children.length-1&&(t=o.children.eq(o.children.length-1).position()),t&&("horizontal"==o.settings.mode?b(-t.left,"reset",0):"vertical"==o.settings.mode&&b(-t.top,"reset",0))}o.working=!1,o.settings.onSlideAfter(o.children.eq(o.active.index),o.oldIndex,o.active.index)},A=function(t){o.settings.autoControlsCombine?o.controls.autoEl.html(o.controls[t]):(o.controls.autoEl.find("a").removeClass("active"),o.controls.autoEl.find("a:not(.bx-"+t+")").addClass("active"))},W=function(){1==x()?(o.controls.prev.addClass("disabled"),o.controls.next.addClass("disabled")):!o.settings.infiniteLoop&&o.settings.hideControlOnEnd&&(0==o.active.index?(o.controls.prev.addClass("disabled"),o.controls.next.removeClass("disabled")):o.active.index==x()-1?(o.controls.next.addClass("disabled"),o.controls.prev.removeClass("disabled")):(o.controls.prev.removeClass("disabled"),o.controls.next.removeClass("disabled")))},H=function(){o.settings.autoDelay>0?setTimeout(r.startAuto,o.settings.autoDelay):r.startAuto(),o.settings.autoHover&&r.hover(function(){o.interval&&(r.stopAuto(!0),o.autoPaused=!0)},function(){o.autoPaused&&(r.startAuto(!0),o.autoPaused=null)})},L=function(){var e=0;if("next"==o.settings.autoDirection)r.append(o.children.clone().addClass("bx-clone"));else{r.prepend(o.children.clone().addClass("bx-clone"));var i=o.children.first().position();e="horizontal"==o.settings.mode?-i.left:-i.top}b(e,"reset",0),o.settings.pager=!1,o.settings.controls=!1,o.settings.autoControls=!1,o.settings.tickerHover&&!o.usingCSS&&o.viewport.hover(function(){r.stop()},function(){var e=0;o.children.each(function(){e+="horizontal"==o.settings.mode?t(this).outerWidth(!0):t(this).outerHeight(!0)});var i=o.settings.speed/e,s="horizontal"==o.settings.mode?"left":"top",n=i*(e-Math.abs(parseInt(r.css(s))));N(n)}),N()},N=function(t){speed=t?t:o.settings.speed;var e={left:0,top:0},i={left:0,top:0};"next"==o.settings.autoDirection?e=r.find(".bx-clone").first().position():i=o.children.first().position();var s="horizontal"==o.settings.mode?-e.left:-e.top,n="horizontal"==o.settings.mode?-i.left:-i.top,a={resetValue:n};b(s,"ticker",speed,a)},O=function(){o.touch={start:{x:0,y:0},end:{x:0,y:0}},o.viewport.bind("touchstart",X)},X=function(t){if(o.working)t.preventDefault();else{o.touch.originalPos=r.position();var e=t.originalEvent;o.touch.start.x=e.changedTouches[0].pageX,o.touch.start.y=e.changedTouches[0].pageY,o.viewport.bind("touchmove",Y),o.viewport.bind("touchend",V)}},Y=function(t){var e=t.originalEvent,i=Math.abs(e.changedTouches[0].pageX-o.touch.start.x),s=Math.abs(e.changedTouches[0].pageY-o.touch.start.y);if(3*i>s&&o.settings.preventDefaultSwipeX?t.preventDefault():3*s>i&&o.settings.preventDefaultSwipeY&&t.preventDefault(),"fade"!=o.settings.mode&&o.settings.oneToOneTouch){var n=0;if("horizontal"==o.settings.mode){var r=e.changedTouches[0].pageX-o.touch.start.x;n=o.touch.originalPos.left+r}else{var r=e.changedTouches[0].pageY-o.touch.start.y;n=o.touch.originalPos.top+r}b(n,"reset",0)}},V=function(t){o.viewport.unbind("touchmove",Y);var e=t.originalEvent,i=0;if(o.touch.end.x=e.changedTouches[0].pageX,o.touch.end.y=e.changedTouches[0].pageY,"fade"==o.settings.mode){var s=Math.abs(o.touch.start.x-o.touch.end.x);s>=o.settings.swipeThreshold&&(o.touch.start.x>o.touch.end.x?r.goToNextSlide():r.goToPrevSlide(),r.stopAuto())}else{var s=0;"horizontal"==o.settings.mode?(s=o.touch.end.x-o.touch.start.x,i=o.touch.originalPos.left):(s=o.touch.end.y-o.touch.start.y,i=o.touch.originalPos.top),!o.settings.infiniteLoop&&(0==o.active.index&&s>0||o.active.last&&0>s)?b(i,"reset",200):Math.abs(s)>=o.settings.swipeThreshold?(0>s?r.goToNextSlide():r.goToPrevSlide(),r.stopAuto()):b(i,"reset",200)}o.viewport.unbind("touchend",V)},Z=function(){var e=t(window).width(),i=t(window).height();(a!=e||l!=i)&&(a=e,l=i,r.redrawSlider(),o.settings.onSliderResize.call(r,o.active.index))};return r.goToSlide=function(e,i){if(!o.working&&o.active.index!=e)if(o.working=!0,o.oldIndex=o.active.index,o.active.index=0>e?x()-1:e>=x()?0:e,o.settings.onSlideBefore(o.children.eq(o.active.index),o.oldIndex,o.active.index),"next"==i?o.settings.onSlideNext(o.children.eq(o.active.index),o.oldIndex,o.active.index):"prev"==i&&o.settings.onSlidePrev(o.children.eq(o.active.index),o.oldIndex,o.active.index),o.active.last=o.active.index>=x()-1,o.settings.pager&&q(o.active.index),o.settings.controls&&W(),"fade"==o.settings.mode)o.settings.adaptiveHeight&&o.viewport.height()!=v()&&o.viewport.animate({height:v()},o.settings.adaptiveHeightSpeed),o.children.filter(":visible").fadeOut(o.settings.speed).css({zIndex:0}),o.children.eq(o.active.index).css("zIndex",o.settings.slideZIndex+1).fadeIn(o.settings.speed,function(){t(this).css("zIndex",o.settings.slideZIndex),D()});else{o.settings.adaptiveHeight&&o.viewport.height()!=v()&&o.viewport.animate({height:v()},o.settings.adaptiveHeightSpeed);var s=0,n={left:0,top:0};if(!o.settings.infiniteLoop&&o.carousel&&o.active.last)if("horizontal"==o.settings.mode){var a=o.children.eq(o.children.length-1);n=a.position(),s=o.viewport.width()-a.outerWidth()}else{var l=o.children.length-o.settings.minSlides;n=o.children.eq(l).position()}else if(o.carousel&&o.active.last&&"prev"==i){var d=1==o.settings.moveSlides?o.settings.maxSlides-m():(x()-1)*m()-(o.children.length-o.settings.maxSlides),a=r.children(".bx-clone").eq(d);n=a.position()}else if("next"==i&&0==o.active.index)n=r.find("> .bx-clone").eq(o.settings.maxSlides).position(),o.active.last=!1;else if(e>=0){var c=e*m();n=o.children.eq(c).position()}if("undefined"!=typeof n){var g="horizontal"==o.settings.mode?-(n.left-s):-n.top;b(g,"slide",o.settings.speed)}}},r.goToNextSlide=function(){if(o.settings.infiniteLoop||!o.active.last){var t=parseInt(o.active.index)+1;r.goToSlide(t,"next")}},r.goToPrevSlide=function(){if(o.settings.infiniteLoop||0!=o.active.index){var t=parseInt(o.active.index)-1;r.goToSlide(t,"prev")}},r.startAuto=function(t){o.interval||(o.interval=setInterval(function(){"next"==o.settings.autoDirection?r.goToNextSlide():r.goToPrevSlide()},o.settings.pause),o.settings.autoControls&&1!=t&&A("stop"))},r.stopAuto=function(t){o.interval&&(clearInterval(o.interval),o.interval=null,o.settings.autoControls&&1!=t&&A("start"))},r.getCurrentSlide=function(){return o.active.index},r.getCurrentSlideElement=function(){return o.children.eq(o.active.index)},r.getSlideCount=function(){return o.children.length},r.redrawSlider=function(){o.children.add(r.find(".bx-clone")).outerWidth(u()),o.viewport.css("height",v()),o.settings.ticker||S(),o.active.last&&(o.active.index=x()-1),o.active.index>=x()&&(o.active.last=!0),o.settings.pager&&!o.settings.pagerCustom&&(w(),q(o.active.index))},r.destroySlider=function(){o.initialized&&(o.initialized=!1,t(".bx-clone",this).remove(),o.children.each(function(){void 0!=t(this).data("origStyle")?t(this).attr("style",t(this).data("origStyle")):t(this).removeAttr("style")}),void 0!=t(this).data("origStyle")?this.attr("style",t(this).data("origStyle")):t(this).removeAttr("style"),t(this).unwrap().unwrap(),o.controls.el&&o.controls.el.remove(),o.controls.next&&o.controls.next.remove(),o.controls.prev&&o.controls.prev.remove(),o.pagerEl&&o.settings.controls&&o.pagerEl.remove(),t(".bx-caption",this).remove(),o.controls.autoEl&&o.controls.autoEl.remove(),clearInterval(o.interval),o.settings.responsive&&t(window).unbind("resize",Z))},r.reloadSlider=function(t){void 0!=t&&(n=t),r.destroySlider(),d()},d(),this}}(jQuery);

/*
*
* jqTransform
* by mathieu vilaplana mvilaplana@dfc-e.com
//* Designer ghyslain armand garmand@dfc-e.com
*
*
* Version 1.0 25.09.08
* Version 1.1 06.08.09
* Add event click on Checkbox and Radio
* Auto calculate the size of a select element
* Can now, disabled the elements
* Correct bug in ff if click on select (overflow=hidden)
* No need any more preloading !!
* 
******************************************** */

(function($){
   var defaultOptions = {preloadImg:true};
   var jqTransformImgPreloaded = false;

   /***************************
     Labels
   ***************************/
   var jqTransformGetLabel = function(objfield){
       var selfForm = $(objfield.get(0).form);
       var oLabel = objfield.next();
       if(!oLabel.is('label')) {
           oLabel = objfield.prev();
           if(oLabel.is('label')){
               var inputname = objfield.attr('id');
               if(inputname){
                   oLabel = selfForm.find('label[for="'+inputname+'"]');
               } 
           }
       }
       if(oLabel.is('label')){return oLabel.css('cursor','pointer');}
       return false;
   };
   
   /* Hide all open selects */
   var jqTransformHideSelect = function(oTarget){
       var ulVisible = $('.jq_sel ul:visible');
       ulVisible.each(function(){
           var oSelect = $(this).parents(".jq_sel:first").find("select").get(0);
           //do not hide if click on the label object associated to the select
           if( !(oTarget && oSelect.oLabel && oSelect.oLabel.get(0) == oTarget.get(0)) ){$(this).hide();$(this).parent().css({zIndex: '20'});}
       });
   };
   /* Check for an external click */
   var jqTransformCheckExternalClick = function(event) {
       if ($(event.target).parents('.jq_sel').length === 0) { jqTransformHideSelect($(event.target));};
   };

   /* Apply document listener */
   var jqTransformAddDocumentListener = function (){
       $(document).mousedown(jqTransformCheckExternalClick);
   };  
           
   /* Add a new handler for the reset action */
   var jqTransformReset = function(f){
       var sel;
       $('.jq_sel select', f).each(function(){sel = (this.selectedIndex<0) ? 0 : this.selectedIndex; $('ul', $(this).parent()).each(function(){$('a:eq('+ sel +')', this).click();});});
   };


   
   /***************************
     Select 
    ***************************/   
   $.fn.jqTransSelect = function(){
       return this.each(function(index){
           var $select = $(this);

           if($select.hasClass('jq_sel_hide')) {return;}
           if($select.attr('multiple')) {return;}

           var oLabel  =  jqTransformGetLabel($select);
           /* First thing we do is Wrap it */
           var $wrapper = $select
               .addClass('jq_sel_hide')
               .wrap('<div class="jq_sel"></div>')
               .parent()
               .css({zIndex: 20-index})
           ;
           
           /* Now add the html for the select */
           $wrapper.prepend('<div><span></span><a href="none" class="jqTransformSelectOpen" style="cursor: pointer;" title="선택"><img src="/cloud_ver2/new_cloud/images/icn_arr_down.png" alt="선택"/></a></div><ul></ul>');
           var $ul = $('ul', $wrapper).hide();
           /* Now we add the options */
           $('option', this).each(function(i){
               var oLi = $('<li><a href="#" index="'+ i +'">'+ $(this).html() +'</a></li>');
               $ul.append(oLi);
           });
           
           /* Add click handler to the a */
           $ul.find('a').click(function(){
                   $('a.selected', $wrapper).removeClass('selected');
                   $(this).addClass('selected');   
                   /* Fire the onchange event */
                   if ($select[0].selectedIndex != $(this).attr('index') && $select[0].onchange) { $select[0].selectedIndex = $(this).attr('index'); $select[0].onchange(); }
                   $select[0].selectedIndex = $(this).attr('index');
                   $('span:eq(0)', $wrapper).html($(this).html());
                   $ul.hide();
                   $wrapper.css({zIndex: '20'})
                   return false;
           });
           /* Set the default */
           $('a:eq('+ this.selectedIndex +')', $ul).click();
           $('span:first', $wrapper).click(function(){$("a.jqTransformSelectOpen",$wrapper).trigger('click');});
           oLabel && oLabel.click(function(){$("a.jqTransformSelectOpen",$wrapper).trigger('click');});
           this.oLabel = oLabel;
           
           /* Apply the click handler to the Open */
           var oLinkOpen = $('a.jqTransformSelectOpen', $wrapper)
               .click(function(){
                   //Check if box is already open to still allow toggle, but close all other selects
                   if( $ul.css('display') == 'none' ) {jqTransformHideSelect();$wrapper.css({zIndex: '50'});} 
                   if($select.attr('disabled')){
                       return false;
                       $wrapper.css({zIndex: '20'});
                   }

                   $ul.slideToggle('fast', function(){
                       var offSet = ($('a.selected', $ul).offset().top - $ul.offset().top);
                       $ul.animate({scrollTop: offSet});
                       if( $ul.css('display') == 'none' ) {$wrapper.css({zIndex: '20'});} 
                       
                   });

                   return false;
               })
           ;

           // Set the new width
           var iSelectWidth = $select.outerWidth();
           var oSpan = $('span:first',$wrapper);
           var newWidth = (iSelectWidth > oSpan.innerWidth())?iSelectWidth+oLinkOpen.outerWidth():$wrapper.width();
           $wrapper.parents(".sel_box").css('width',newWidth);
           $ul.css('width',newWidth);
           //$ul.css('width',newWidth-2);
       
           // Calculate the height if necessary, less elements that the default height
           //show the ul to calculate the block, if ul is not displayed li height value is 0
           $ul.css({display:'block',visibility:'hidden'});
           var iSelectHeight = ($('li',$ul).length)*($('li:first',$ul).height());//+1 else bug ff
           (iSelectHeight < $ul.height()) && $ul.css({height:iSelectHeight,'overflow':'hidden'});//hidden else bug with ff
           $ul.css({display:'none',visibility:'visible'});
       });
   };
   $.fn.jqTransform = function(options){
       var opt = $.extend({},defaultOptions,options);
       
       /* each form */
        return this.each(function(){
           var selfForm = $(this);
           if(selfForm.hasClass('jqtransformdone')) {return;}
           selfForm.addClass('jqtransformdone');

           if( $('select', this).jqTransSelect().length > 0 ){jqTransformAddDocumentListener();}
           selfForm.bind('reset',function(){var action = function(){jqTransformReset(this);}; window.setTimeout(action, 10);});
           
       }); /* End Form each */
               
   };/* End the Plugin */

})(jQuery);
                  


//gnb 스크롤
$(window).on("load",function(){
//    $("nav .conWrap li ul").mCustomScrollbar();
});

var outTime;

var autoclose = function()
{
    //console.log('autoclose');
    
    var gnb_li = $('#gnb .conWrap > ul > li');
    var view_allmenu = $('#gnb .view_allmenu');
    var all_menu = $('.all_menu');
    
    view_allmenu.removeClass('on');
    all_menu.removeClass('on');
    gnb_li.removeClass('on');
};

$(document).ready(function() {
    // selectbox design
    $('.sel_box').jqTransform();

    //gnb
	var gnb_li = $('#gnb .conWrap > ul > li');
	var gnb_li_sub = $('#gnb .conWrap > ul > li > ul > li ');
	var view_allmenu = $('#gnb .view_allmenu');
	var all_menu = $('.all_menu');	
	
	gnb_li_sub.children('a').mouseover(function()
    {
        //console.log('mouseover2');
        
        window.clearTimeout(outTime);
        outTime = window.setTimeout(autoclose, 2000);
    });
	
	gnb_li.children('a').mouseover(function()
	{
	    //console.log('mouseover');
	    
	    window.clearTimeout(outTime);
	    outTime = window.setTimeout(autoclose, 2000);
        
	    view_allmenu.removeClass('on');
	    all_menu.removeClass('on');
	    gnb_li.addClass('on');
	    
	    var index = gnb_li.children('a').index(this);
	    
	    if(index != 2){
	        return false;
	    }
    });
	

    //gnb 전체메뉴
	view_allmenu.click(function(){
	    gnb_li.removeClass('on');
		$(this).toggleClass('on');
		all_menu.toggleClass('on');

		return false;
	});

	//gnb 닫기
	$('#gnb > .conWrap,  article, section, .bnrArea, footer > .conWrap').on('mouseover focusin',function(){
		gnb_li.removeClass('on');
		view_allmenu.removeClass('on');
		all_menu.removeClass('on');		
	});
	

	//tnb
	$('#gnb aside li a').click(function(){
		$('#gnb aside li div').removeClass('on');
        $(this).next('div').addClass('on');
	});
	$('#gnb aside li > i > a').click(function(){
		$('#gnb aside li div').removeClass('on');
        $('#gnb aside li > i').next('div').addClass('on');
	});
	$('#gnb .conWrap > ul, article').on('mouseover focusin',function(){
		$('#gnb aside li div').removeClass('on');
	});
	//탭메뉴
	$('.tab_menu').each(function() {
        if( $(this).hasClass('bid')) {
            $(this).find('li:last').addClass('on');            
        } else{
            $(this).find('li:first').addClass('on');            
        }
	});
	$('.tab_menu > li > a').click(function(){
		$(this).parent().siblings().removeClass('on');
		$(this).parent().addClass('on');

		return false;
	});
	$('.tab_menu.mo > li > a').on('mouseover focusin',function(){
		$(this).parent().siblings().removeClass('on');
		$(this).parent().addClass('on');
	});

    //TIP
    $('.tip').on('mouseover focusin',function(){
        $(this).children().addClass('on');        
    });
    $('.tip').on('mouseout focusout',function(){
        $(this).children().removeClass('on');        
    });

     //간단 열고/닫기
    $('.sim_opcl').click(function(){
        $(this).toggleClass('on');
        
        return false;
    });
    
	//slider
	    //main slider
	    $('.slider_1').bxSlider({
	        auto:true
	    });
    	
    	//상세 사용자화면 썸네일
        $('.slider_2').bxSlider({
            slideWidth:178,
            minSlides:1,
            maxSlides:5,
            moveSlides:1,
            slideMargin:10
        });
        
        //상세뷰 사용화면 썸네일
        $('.slider_3').bxSlider({
            slideWidth:680
        });

        //메인 소프트웨어 롤링
        $('.slider_4').bxSlider({
            slideWidth:255,
            minSlides:1,
            maxSlides:4,
            auto:false,
            autoDelay:1000
        });

        //서비스 서비스 비교
        $('.slider_5').bxSlider({
            slideWidth:178,
            minSlides:1,
            maxSlides:4,
            moveSlides:1,
            slideMargin:10,
            infiniteLoop:false
        });

    //faq
    $('.faq a').click(function(){
        $(this).parents('tr').next().toggleClass('on');        
        
        return false;
    });

    //좌측메뉴 기본
    $('.lay_lnb nav > ul > li > a').click(function(){        
        if($(this).next().is('ul')){
            $(this).parent().toggleClass('on');
            return false;            
        }        
    });
    $('.lay_lnb nav a.on').parents('ul:first').parent().addClass('on');
    $('.lay_lnb nav li').find('ul').parent().addClass('sub');

   

    //소프트웨어 목록 필터검색
    $('.swList nav dt a').click(function(){
        $(this).parent().toggleClass('on');
               
        return false;
    });

    //필터검색 checked가 되어 있을 경우 표시
    $(".swList nav input:checked").each(function() {
        $(this).parents('dd').prev().addClass('checked');
    });
    //필터검색 checked 효과
    $('.swList nav input:checkbox').click(function(){
        if($(this).parents('dd').find('input').is(':checked')){
            $(this).parents('dd').prev().addClass('check');            
        } else {
            $(this).parents('dd').prev().removeClass('check');            
        }
    });
    //선택 초기화시 체크박스 효과 삭제
    $('.reset_check').click(function(){        
        $('.swList nav dt').removeClass('checked check');        
        $('.swList nav input').prop("checked",false);
        return false;
    });
    
    ////////////////////////////////////////////////////////////////////////////////////
    //통합검색 필터 시작
    ////////////////////////////////////////////////////////////////////////////////////
    //통합검색 목록 필터검색
    $('.lay_lnb.schResult nav dt a').click(function(){
        $(this).parent().toggleClass('on');
               
        return false;
    });

    //통합검색 필터검색 checked가 되어 있을 경우 표시
    $(".lay_lnb.schResult nav input:checked").each(function() {
        $(this).parents('dd').prev().addClass('checked');
    });
    //통합검색 필터검색 checked 효과
    $('.lay_lnb.schResult nav input:checkbox').click(function(){
        if($(this).parents('dd').find('input').is(':checked')){
            $(this).parents('dd').prev().addClass('check');            
        } else {
            $(this).parents('dd').prev().removeClass('check');            
        }
    });
    //통합검색 선택 초기화시 체크박스 효과 삭제
    $('.totalsch_reset_check').click(function(){        
        $('.lay_lnb.schResult nav dt').removeClass('checked check');        
        $('.lay_lnb.schResult nav input').prop("checked",false);
        return false;
    });
    ////////////////////////////////////////////////////////////////////////////////////
    //통합검색 필터 종료
    ////////////////////////////////////////////////////////////////////////////////////
    
    //서비스비교 팝업
    $('.btnPare').click(function(){        
        $('.serCompare').removeClass('hidden').addClass('on');
        return false;
    });

    $('.serCompare h2 a').click(function(){
        $(this).toggleClass('on');
        $('.serCompare').toggleClass('hidden');
        return false;
    });
    
    //약관 열과 닫기
    $('.agr_opcl').click(function(){
        if( $(this).hasClass('close')) {
            $(this).text('닫기').removeClass('close');
            $(this).parent().next().removeClass('close');            
          }
          else {
              $(this).text('열기').addClass('close');
              $(this).parent().next().addClass('close');            
          }
        return false;
    });


    //확장 검색 열기 / 닫기
    $('.exSch').click(function(){
        if( $(this).hasClass('on')) {
            $(this).removeClass('on');            
            $(this).prev().removeClass('on');
          }
          else {
              $(this).addClass('on');            
              $(this).prev().addClass('on');
          }
        return false;
    });
    
    //게시판 리스트 툴팁
    $('.knowHub.list table a').click(function(){
        if( $(this).hasClass('on')) {
            $('.knowHub.list table a').removeClass('on');
            $('.knowHub.list table a').next().removeClass('on');
        }
        else {
            $(this).addClass('on');
            $(this).next().addClass('on');
        }
        

        return false;
    });
    
    //게시판 상단 검색창 너비값 조절
    var schArea = $('.schArea > div');
    var eleWidth = schArea.parent().children(":first").width();

    
    if($('.schArea').hasClass('noCate')){
        schArea.css('margin-left','0');
    } else {
        schArea.css('margin-left',eleWidth + 10);  
    }
    
    //카테고리 선택 영역 정렬
    $('.cateArea').each(function() {
        var cateWid = $(this).children(".sel_box").width();
        
        $(this).children(".inputWrap").css('margin-left',cateWid + 5);
    });
    
    //입력 서식 옆 단위
    $('.unit').each(function() {
        var unitWid = $(this).children("i").width();
        $(this).children("div").css('margin-right',unitWid + 10);

    });
    
    
    //페이지내 팝업 닫기
    $('.popup h2 a,.popup .alert').click(function(){
        $(this).parents('.popup').removeClass('on');

        return false;
    });
    
   
});

//gnb 상단 고정
$(window).scroll(function(){
	var gnb = $("#gnb nav");
	var st = $(document).scrollTop();	

	if(st < 100){
		gnb.removeClass('fixed');
	} else if( st > 100){
		gnb.addClass('fixed');
	}
	
	
});

// 전체메뉴 보기
$('#allmenu_item > .depth2 > a').on('click',function(){
	$(this).addClass('on')
		.next('.depth3').css('display','block')			
	});
$('#allmenu_item > .depth2').on('mouseleave',function(){
	$(this).children('a').removeClass('on')
		.next('.depth3').css('display','none')	
});

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

//이용실적증명서 발급방법
$('.request_how_select > ul > li').on('click',function(){
	$(this).children('div').css('display','block');
	$(this).siblings('li').children('div').css('display','none');
});

$("#allCheck").click(function(){
	if($("#allCheck").prop("checked")) {
		$("input[type=checkbox]").prop("checked",true);
	} else {
		$("input[type=checkbox]").prop("checked",false);
	}
});
//서비스 비교
$('.btn_compare').on('click',function(){
		if($('.location_wrap').hasClass('active')){
			$('.location_wrap').animate({
				bottom:'-195px'
			}, 300).removeClass('active');
			$('.btn_compare').css('background-image','url(/cloud_ver3/html_web/images/icon_compareOpen.png)')
		}
		else{
			$('.location_wrap').animate({
				bottom:'0'
			}, 300).addClass('active');
			$('.btn_compare').css('background-image','url(/cloud_ver3/html_web/images/icon_compareClose.png)')
		}
	});
//필터검색
$('.btn_open').on('click', function() {
	$('.filter_close').css('display','block');
});
$('.btn_close').on('click', function() {
	$('.filter_close').css('display','none');
});

//이용희망목록 좌측메뉴
$('.left_area > ul > li').on('click',function(){
	if($(this).hasClass('on')){
		$(this).siblings('li').removeClass('on');
	}
	else{
		$(this).addClass('on');
	}
});

//상품상세 > 관련이미지
$('.screen_img_area ul li').on('click', function(){
	var address = $(this).children('img');
	$('#zoom_img img').attr('src',address.attr('src')).attr('alt',address.attr('alt'));
	$(this).addClass('click_screen').siblings().removeClass('click_screen');
	return false;
});

//관리자 대시보드
$(function(){
	$('.tab_content').hide();
	$('.tab_content:first').show();
	$('ul.tabs li').on('click',function () {
		$('ul.tabs li').removeClass('active');
		$(this).addClass('active');
		$('.tab_content').hide();
		var activeTab = $(this).attr('rel');
		$('#' + activeTab).fadeIn();
	});
});

$('#gnb nav ul li.main_menu').on('click', function(){
	$(this).children('ul').css('display','block');
});
/*
  $('#gnb nav ul li:first-child.main_menu').on('mouseenter', function(){
	$(this).children('ul').css('display','block');
});
*/
$('#gnb nav ul li.main_menu').on('mouseleave',function(){
	$(this).children('ul').css('display','none');
});

// 서비스 등록
$('#seviceprocess > a').each(function(){
	var a = $(this);
	var img = a.find('img');
	var src_off = img.attr('src');
	var src_on = src_off.replace('_off','_on');
	if(a.hasClass('active')){
		img.attr('src', src_on);
	}
	else{
		img.attr('src', src_off);
	}
});
