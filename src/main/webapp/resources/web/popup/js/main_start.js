    // 20161201 SKYOU 불필요하고 오류로 삭제 
    // var LoopCnt = bennerArray.length;  // 회전되는 팝업이미지 개수
    var clearTimer;

    function goBennerPlay() {
        clearTimeout(clearTimer);
    	this.overMouse = true;
    	this.bennerToggle = 0;
    	$('#btnPause').show();
    	$('#btnPlay').hide();
    	this.clearTimer = window.setInterval("bennerScrolling();",3000);
    }
    function goBennerStop() {
    	clearTimeout(this.clearTimer);
    	$('#btnPlay').show();
        $('#btnPause').hide();
    }

    function selectBanner(el){
        bennerMove(el);
        goBennerStop();
    }

   /*20161201 SKYOU 불필요하고 오류로 삭제
    {{  function bennerScrolling() {
		if (overMouse) {
			bennerMove(loop);
        	loop++;
        	if(loop > LoopCnt) loop = 1;
		} else {
			clearTimeout(clearTimer);
		}
    }
    if(overMouse){
    	goBennerPlay();
    } else {
    	goBennerStop();
    }
    
    }} */

    function bennerMove(indexNum){
    	for(var i=1; i<this.bennerLength+1; i++) {
    		if(i == indexNum)	{
    		    $("#visualNum"+i).children("img").attr("src","/resources/web/theme/default/images/btn/btn_main_on.gif");
                $("#visualImg"+i).css('display','block');
    		} else {
    		    $("#visualNum"+i).children("img").attr("src","/resources/web/theme/default/images/btn/btn_main_off.gif");
                $("#visualImg"+i).css('display','none');
    		}
    	}

    }

    function bennerPrev(){
    	loop--;
    	if(loop <= 0){ loop = this.bennerLength;}
    	bennerMove(loop);
    	clearTimeout(clearTimer);
    }
    function bennerNext(){
    	loop++;
    	if(loop > LoopCnt) loop = 1;
    	bennerMove(loop);
    	clearTimeout(clearTimer);
    }
