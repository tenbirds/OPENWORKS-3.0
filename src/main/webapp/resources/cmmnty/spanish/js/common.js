/*
***********************************************
* @description    : 자바스크립트 > 공통 
***********************************************
* DATE			AUTHOR		DESCRIPTION
* ---------------------------------------------
* 2014.10.01	장경진		최초작성
***********************************************
*/

$(document).ready(function(){
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
			}, 1000);
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
	// FAQ,Q&A
	********************************************/
	var article = ('.tbl_list .show');  
	$('.tbl_list .item  td .question').click(function() {  
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
	
});


/********************************************
// tabChage
********************************************/
function tabChange(obj,num,imgId,total) {
    for (i=1; i<=total; i++)    {
        var imgIds = document.getElementById(imgId+i);
        var imgSrc = imgIds.getAttribute('src');
        if (i==num) {
            document.getElementById(obj+i).style.display = 'block';
            imgIds.setAttribute('src',imgSrc.replace('_off','_on'));
        }
        else {
            document.getElementById(obj+i).style.display = 'none';
            imgIds.setAttribute('src',imgSrc.replace('_on','_off'));
        }
    }
}

/********************************************
// layer show/hide
********************************************/
function showLayer(id) {
	document.getElementById(id).style.display = 'block';
}
function hideLayer(id) {
	document.getElementById(id).style.display = 'none';
}






