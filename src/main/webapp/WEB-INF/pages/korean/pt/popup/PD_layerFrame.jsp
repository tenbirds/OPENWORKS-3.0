<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.lang.*" %>
<%@ page import="zes.openworks.intra.popup.*" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${dataVo.popupTitle}</title>
<op:jsTag type="openworks" items="web-pop-core"/>
    <script type="text/javascript" src="/resources/web/popup/js/jquery.cookie.js"></script>

    <script type="text/javascript">
    $().ready( function(){
        $("#html").css({height: "${dataVo.heightSize}px", width: "${dataVo.widthSize}px"});
        $("#cUrl").css({height: "${dataVo.heightSize}px", width: "${dataVo.widthSize}px"});
        $("#fileP").css({height: "${dataVo.heightSize}px", width: "${dataVo.widthSize}px"});
        $("#bodyDiv").css("margin", "0px");
        $("#bodyDiv").css("padding", "0px");
        $("#contentDiv").css("margin", "0px");
        $("#contentDiv").css("padding", "0px");
        $(".hideviewCheckbox").hide();
    });

    //쿠기에 저장된 값으로 앞으로 얼마나 유효한지 확인
    var getCookieName = function(domain, seq) {
        return "popup_" +  domain + "_" + seq;
    };

    var jsCheckCookie = function(cookieName) {
        return $.cookie(cookieName);
    };
    //쿠키이름과 시간설정
    var jsSetCookieExpTime = function(domain, popSeq, value, day) {
        var cookieName = "popup_" +  domain + "_" + popSeq;
        var expDate = new Date();
        expDate.setTime(expDate.getTime() + 1000*60*60*24*day);
        $.cookie(cookieName, value, { path: '/', expires: expDate });
    };

    var jsClose = function(domain, popSeq, day) {
        // 관리자는 쿠키 설정 하지 않음
        if ((day != 0) && ($("#viewCheckbox").is(":checked")))
            jsSetCookieExpTime(domain, popSeq, "checked", day);
        $("#${param.divName}", parent.document.body).remove();
    };

    var getCloseMsg = function(cookieDt) {
        if ( cookieDt == '1') return "오늘 하루 이창을 열지 않습니다.";
        else if ( cookieDt == '7')return "일주일간 이창을 열지 않습니다.";
        else return "현재 보는 창을 닫습니다.";
    };

    </script>
	<style>
		/*--------------------------------------------------------------------------
		 * popup
		 *-------------------------------------------------------------------------*/
		#popup{
			/* padding: 10px; */
			/* border:2px solid #000; */
			line-height:140%;
		}
		#popup h4{
			background:url('../images/common/icon_arrow.gif') no-repeat left 5px;
			padding:0 0 0 12px;
			font-weight:bold;
			font-size:13px;
			height:35px;
			color:#000;
		}
		.pop_pad{
			padding:20px 15px;
		}
		
		#popup h1{
			border-bottom:1px solid #aa98c8;
			height:35px;
		}
		#popup .p_pwd{
			padding:30px 0;
			text-align:center;
		}
		#popup .p_pwd label{
			color:#000;
			font-weight:bold;
		}
		#bottom{
			background-color:#eaeaea;
			height:60px;
			position:relative;
		}
		#bottom .today{
			position:absolute;
			left:10px;
			top:6px;
			font-size:11px;
		}
		#bottom .close{
			position:absolute;
			right:10px;
			top:8px;
		}
		#popup .p_tag{
			margin:20px 0 10px 0;
			line-height:160%;
		}
		.tag_01{
			color:#d02643;
			font-size:14px;
			font-weight:bold;
		}
		.tag_02{
			color:#543bb3;
			font-size:13px;
			font-weight:bold;
		}
		
		.tag_03{
			color:#000;
			font-size:12px;
			font-weight:bold;
		}
	</style>
</head>

<body>
<div id="popup2">
    <div class="con">
        <c:if test="${dataVo.makeTyCd == 1001}" ><div id="html" style="background-color: white; z-index:10000;">${dataVo.cnHtml}</div></c:if> <!-- 20150810 헤더와 겹치는 문제로 z-index 속성 추가 -->
        <c:if test="${dataVo.makeTyCd == 1002}" >
            <div id="cUrl"><iframe src="${dataVo.cnUrl}" width="${dataVo.widthSize }px" height="${dataVo.heightSize }px" frameborder="0" style="background-color:white;" title="${dataVo.popupTitle}"></iframe></div></c:if>
        <c:if test="${dataVo.makeTyCd == 1003}" >
            <div id="fileP"><iframe src="<c:url value='${dataVo.popupFilePath}' />" width="${dataVo.widthSize }px" height="${dataVo.heightSize }px;" frameborder="0" style="background-color:white; " title="${dataVo.popupTitle}"></iframe></div>
        </c:if>
    </div>
    <c:if test="${dataVo.cookieYn eq 'Y'}">
    <!-- style="border-left: 2px solid #000000; border-right: 2px solid #000000; border-bottom: 2px solid #000000; width: 295px;" -->
    <div id="bottom">
         <div class="today">
             <fieldset>
              <legend>닫기</legend>
                <input name="viewCheckbox" type="checkbox" id="viewCheckbox" value="checkbox" /> <label for="viewCheckbox">
                ${dataVo.cookieDeCo}일 동안 다시 열지않음
                </label>
             </fieldset>
        </div>

        <div class="close"><a href="#" onclick="jsClose(${dataVo.domainCd}, ${dataVo.popupSn}, ${dataVo.cookieDeCo} );"><img src="/resources/web/theme/default/images/btn/pop_close.gif" alt="닫기"/></a></div>
    </div>
    </c:if>
    <c:if test="${dataVo.cookieYn ne 'Y'}">
    <div id="bottom">
         <div class="today">
        </div>
        <div class="close"><a href="#" onclick="jsClose();"><img src="/resources/web/theme/default/images/btn/pop_close.gif" alt="닫기"/></a></div>
    </div>
    </c:if>
</div>
</body>
</html>