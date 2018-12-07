<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>${dataVo.popupTitle}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <op:jsTag type="openworks" items="web-pop-core"/>
    <script type="text/javascript" src="/resources/web/popup/js/jquery.cookie.js"></script>
    <script type="text/javascript">

    $().ready( function(){
        $("#html").css({height: "${dataVo.heightSize}px", width: "${dataVo.widthSize }px"});
        $("#popup").css({height: "${dataVo.heightSize + 30}px", width: "${dataVo.widthSize }px"});
        //$("#bottom").css({width: "${dataVo.widthSize}px"});

        $.ajax({
            url      : "/korean/common/commonduty/ND_popupShowCount.do",
            type     : "POST",
            data     : {popupSn : '${dataVo.popupSn}'},
            success  : function (response) {
                if(response != 'true') {
                    console.log(Message.msg.processError);
                }
            }
        });
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
        expDate.setTime(expDate.getTime() + day*24*60*60*1000);
        $.cookie(cookieName, value, { path: '/', expires: expDate });
    };

    var jsClose = function(domain, popSeq, day) {
        if ((day != 0) && ($("#viewCheckbox").is(":checked")))
            jsSetCookieExpTime(domain, popSeq, "checked", day);
        window.close();
    };

    var getCloseMsg = function(cookieDt) {
        if ( cookieDt != '') return cookieDt+"일동안 이창을 열지 않습니다.";
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
			height:30px;
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
			top:5px;
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
		.close a:link { color: black; text-decoration: none;}
		.close a:visited { color: black; text-decoration: none;}
		.close a:hover { color: black; text-decoration: none;}
		.close a:active { color: black; text-decoration: none;}
	</style>
</head>
<body style="margin:0 0 0 0;">
<div id="popup">
    <div class="con">
        <c:if test="${dataVo.makeTyCd == 1001}" ><div id="html">${dataVo.cnHtml}</div></c:if>
        <c:if test="${dataVo.makeTyCd == 1002}" >
        	<iframe src="${dataVo.cnUrl}" width="${dataVo.widthSize}px" height="${dataVo.heightSize}px" frameborder="0" style="bgacground-color:white" title="${dataVo.popupTitle}"></iframe>
        </c:if>
        <c:if test="${dataVo.makeTyCd == 1003}" >
            <iframe src="<c:url value='${dataVo.popupFilePath}' />" width="${dataVo.widthSize}px" height="${dataVo.heightSize}px" frameborder="0" style="bgacground-color:white" title="${dataVo.popupTitle}"></iframe>
        </c:if>
    </div>
    <c:if test="${dataVo.cookieYn eq 'Y'}">
	    <c:if test="${dataVo.popupTyCd ne 1002}">
		    <div id="bottom">
		        <div class="today">
		        	<input name="viewCheckbox" type="checkbox" id="viewCheckbox" value="checkbox" /> <label for="viewCheckbox" style="position: relative; top:-3px;">${dataVo.cookieDeCo}일 동안 다시 열지않음</label>
		        </div>
		        <div class="close"><a href="javascript:;" onclick="jsClose(${dataVo.domainCd}, ${dataVo.popupSn}, ${dataVo.cookieDeCo} );return false;"><img src="/new_cloud/images/icon-btn/btn_close.gif" title="닫기"/></a></div>
		    </div>
	    </c:if>
    </c:if>
    <c:if test="${dataVo.cookieYn ne 'Y'}">
        <c:if test="${dataVo.popupTyCd ne 1002}">
	    <div id="bottom">
	         <div class="today">
	        </div>
	        <div class="close"><a href="javascript:;" onclick="jsClose();return false;"><img src="/new_cloud/images/icon-btn/btn_close.gif" title="닫기"/></a><!-- <a href="#" onclick="jsClose();" style="font-size: 13px;color: black;">닫기</a> --></div>
	    </div>
        </c:if>
    </c:if>
</div>
</body>
</html>