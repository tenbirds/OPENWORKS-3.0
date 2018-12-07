<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<op:jsTag type="spi" items="ui"/>
<script type="text/javascript" src="/resources/web/popup/js/jquery.cookie.js"></script>
<script type="text/javascript">
//<CDATA[[
//쿠기이름 가져옴
var getCookieName = function(domain, seq) {
    return "popup_" +  domain + "_" + seq;
};

var jsClose = function(divName) {
    $("#" + divName).remove();
};

<c:forEach items="${popup}" var="_bean" varStatus="status">
        var count = '${status.count}';//카운트
        var title = '${_bean.popupTitle}'; //제목
        var widthSize = '${_bean.widthSize}'; //팝업넓이
        var heightSize = '${_bean.heightSize}';//팝업높이
        var positionTop = '${_bean.topLc}';//팝업위치
        var positionLeft = '${_bean.leftLc}';//팝업위치
        var scrollYn = '${_bean.scrlYn}';//스크롤바유무
        var filePath = '${_bean.popupFilePath}';//파일경로
        var resizingYn = '${_bean.resizingYn}';//리라이징
        var cookieDt = '${_bean.cookieDeCo}';
        var cookiesYn = '${_bean.cookieYn}';
        var popupType = '${_bean.popupTyCd}';//팝업종류(팝업:레이어)
        var makeType = '${_bean.makeTyCd}';//작성방법
        var windowName = "popup" + count;
        var url = "<c:url value='/korean/pt/popup/PD_popupView.do' />?seq=${_bean.popupSn}&domainCd=${_bean.domainCd}&makeType=${_bean.makeTyCd}";
        if(scrollYn == 'true'){
            var scroll = 'yes';
        }else{
            var scroll = 'no';

        }
        if(resizingYn == 'Y'){
            var resizable = 'yes';
        }else{
            var resizable = 'no';

        }
        var heightSize2 = ${_bean.heightSize+30};
    //<!-- 팝업창으로 팝업 표시 -->
    if( popupType == '1001' || popupType == '') {
            if (($.cookie(getCookieName("${_bean.domainCd}", "${_bean.popupSn}")) != "checked")){
                var childWin = window.open(url, title,
                        'resizable='+ resizable +',scrollbars='+ scroll +',width='+ widthSize +',height='+ heightSize2 +',top='+ positionTop +',left='+ positionLeft );
           }
            //if ( childWin == null ) jsWarningBox('팝업이 뜨지 않을시 아래와 같이 팝업을 허용해 주세요.<BR />[도구]-[팝업 차단(P)]-[팝업 차단 사용 안함(B)]');
    }
//border : 2px solid #000000;
    //<!-- 레이어로 팝업 표시 -->
    else if ( popupType == '1002') {
        if (($.cookie(getCookieName("${_bean.domainCd}", "${_bean.popupSn}")) != "checked") || (isPreView == 'true')){
            var layerName = "popupDiv${status.count}";
            var imgUrl = "<c:url value='/resources/web/theme/default/images/btn/pop_close.gif' />";
            var popupLayer = $('<div />').attr("id", layerName);
            // 20150810 헤더와 겹쳐서 색 background-color 추가 시작
            popupLayer.attr("style", "background-color:white;");
            // 20150810 헤더와 겹쳐서 색 background-color 추가 끝
            var titleDiv = $('<div id="bottom" class="'+layerName+' "></div>');
            popupLayer.append(titleDiv);
            $("body").append(popupLayer);

            $("#" + layerName).css({ position: "absolute", top: "${_bean.topLc}px", left : "${_bean.leftLc}px" });
            $("#" + layerName).css({height: "${_bean.heightSize + 107}px"});
            $("#" + layerName).css({width: "${_bean.widthSize }px"});
            $("#" + layerName).css({border : "2px solid #000000"});
            $("#" + layerName).css({zIndex : "99999"});
            $("#bottom").css({width: "${_bean.widthSize}px" ,height: "30px"});
            $("#" + layerName).draggable();

            url += ("&divName=" + layerName);
            var contents = $('<iframe id="'+layerName+'" src="' + url + '" width="${_bean.widthSize}px" height="${_bean.heightSize + 75}px" frameborder="0" scrolling="'+ scroll +'" style="bgacground-color:white" resizable="'+resizable+'"></iframe> ');
            contents.css({position:'relative'});

            $("#" + layerName).append(contents);
            var leftSpan = $('<div id="today" class="today">' + '${_bean.popupTitle}' + '</div>');
            $("."+layerName).append(leftSpan);

//            var img = $('<img src="'+imgUrl+'" style="margin-bottom:2px;" />');
            var atag = $('<a href="#" onclick="jsClose(\''+layerName+'\');\"></a>');
            var rightSpan = $('<div id="close'+layerName+'" class="close" ></div>');

            $("."+layerName).append(rightSpan);
            $("#close"+layerName).append(atag);
            //$("#close"+layerName+" a").append(img);
        }
    }
</c:forEach>

//]]>
</script>
