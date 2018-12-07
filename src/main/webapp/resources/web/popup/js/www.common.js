
	$().ready(function() {

	});

	/*
	 *  rollingTime : viewTime경과 후 스크립트 호출 시간,
	 *  viewTime : 정지시간,
	 *  rollingFrame : 프레임 이동시간
	 *  결과적으로 rollingTime과 rollingFrame두 속성이 속도를 조정한다.
	 */
	var rollingStart = function(rollingObj, rollingTime, viewTime, rollingFrame) {
		rollingObj.startRolling(rollingTime, viewTime, rollingFrame);
	}

	var rollingAddItem = function(rollingObj, item){
		rollingObj.addRollingItem(item);
	}

	var rollingLeft = function(rollingObj) {
		rollingObj.resumeRolling();
		if(rollingObj.getRollingDirection() == "right") {
			rollingObj.reverseRolling();
		}
	}

	var rollingRight = function(rollingObj) {
		rollingObj.resumeRolling();
		if(rollingObj.getRollingDirection() == "left") {
			rollingObj.reverseRolling();
		}
	}

	stopVal = false;
	var rollingStop = function(rollingObj) {
		stopVal = true;
		rollingObj.stopRolling();
	}

	var rollingResume = function(rollingObj) {
		stopVal = false;
		rollingObj.resumeRolling();
	}

	// quickmenu
	function initMoving(target, topPosition, topLimit, btmLimit) {
	    if (!target)
	        return false;

	    var obj = target;
	    obj.initTop = topPosition;
	    obj.topLimit = topLimit;
	    obj.bottomLimit = document.documentElement.scrollHeight - btmLimit;

	    obj.style.position = "absolute";
	    obj.top = obj.initTop;
	    obj.left = obj.initLeft;
	    obj.style.top = obj.top + "px";

	    obj.getTop = function() {
	        if (document.documentElement.scrollTop) {
	            return document.documentElement.scrollTop;
	        } else if (window.pageYOffset) {
	            return window.pageYOffset;
	        } else {
	            return 0;
	        }
	    }
	    obj.getHeight = function() {
	        if (self.innerHeight) {
	            return self.innerHeight;
	        } else if(document.documentElement.clientHeight) {
	            return document.documentElement.clientHeight;
	        } else {
	            return 620;
	        }
	    }
	    obj.move = setInterval(function() {
	        //pos = obj.getTop() + obj.getHeight() / 2 - 15;
	        pos = obj.getTop() + topPosition;

	        if (pos > obj.bottomLimit)
	            pos = obj.bottomLimit
	        if (pos < obj.topLimit)
	            pos = obj.topLimit

	        interval = obj.top - pos;
	        obj.top = obj.top - interval / 5;
	        obj.style.top = obj.top + "px";
	    }, 30)
	    }
