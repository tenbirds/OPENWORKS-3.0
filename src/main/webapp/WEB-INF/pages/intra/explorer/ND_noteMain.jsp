<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>쪽지보기</title>
	<op:jsTag type="spi" items="jquery, timer" />
	<op:jsTag type="openworks" />
	
	<script type="text/javascript">
		//<![CDATA[
	
// 		$().ready(function() {

// 			// 5분 마다 확인
// 			var timerSec = 1000 * 60 * 5;
// 			$.timer(timerSec, function(timer) {
// 				$.post("<c:url value="/intra/note/INC_myNoteCount.do"/>", {}, function(result) {
// 					showNote(result);
// 				}, 'json');
// 			});
// 		});

//         var loadShowNote = function() {
//             // 최초 실행
//             $.post("<c:url value="/intra/note/INC_myNoteCount.do"/>", {}, function(result) {
//                 showNote(result);
//             }, 'json');
//         };

        var showNote = function(result) {
            if(result <= 0) {
                return;
            }
			
            $("#noteAlertDiv", top.mainFrame.document).css("top", "-170px");
            $("#noteAlertDiv", top.mainFrame.document).animate({
                top : "8px"
            }, 800).fadeOut(80).fadeIn(80).fadeOut(80).fadeIn(80).fadeOut(100).fadeIn(100);

            $.timer(5000, function(timer) {
                $("#noteAlertDiv", top.mainFrame.document).fadeOut("slow");
                timer.stop();
            });
        };
        
        var jsNoteClose = function() {
            $("#noteAlertDiv", top.mainFrame.document).fadeOut("slow");
        };
        //
    </script>
</head>

<body>
</body>

</html>