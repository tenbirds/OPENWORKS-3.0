<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>소스비교</title>

    <op:jsTag type="openworks" />

    <script type="text/javascript">

    //<![CDATA[
        var width = $(window).width() - 20;
        var height= $(window).height()- 50;

        $().ready(function(){
            $("#leftContentForm").submit();
            $("#rightContentForm").submit();
        });

        /** 
         * 비교 대상 버전 창의 화면 위치를 동일하게 위치 시키기 위한 이벤트 통합관리.
         * 이벤트를 공유하려는 하위 iframe 객체 윈도우에서 현재 부모창에 스스로 등록한다.
         * 부모는 자식 iframe 객체 윈도우가 몇개인지 스스로 찾지 않는다.
         */
        var childArr = new Array();
        var idx = 0;
        var jsAddChildEvent = function(child, body) {

            childArr[idx] = new Array(2);
            childArr[idx][0] = child;
            childArr[idx][1] = body;

            idx++;

            child.scroll(function() {
                for(var i = (childArr.length - 1) ; i >= 0 ; i--) {

                    if($(this).attr("name") != childArr[i][0].attr("name")) {

                        var childY = childArr[i][0].scrollTop();
                        var childX = childArr[i][0].scrollLeft();

                        if(childY < childArr[i][1].height()) {
                            childArr[i][0].scrollTop($(this).scrollTop());
                        }
                        if(childX < childArr[i][1].width()) {
                            childArr[i][0].scrollLeft($(this).scrollLeft());
                        }

                    }
                }
            });
        };

        /** 하위 iframe 객체의 갯수에 따라서 화면을 분할한다. */
        var jsWindowDivision = function() {
            width = $(window).width() - 20;
            height= $(window).height()- 50;
        };
        
        /** 
         * 수평 비교
         * 비교 윈도우를 수평으로 배치한다.
         */
        var jsHorizontalDiff = function() {
            $("#leftContentWindow").css("width","49%").css("height","600px");
            $("#rightContentWindow").css("width","49%").css("height","600px");
            $("#leftContentWindow").css("float","left");
        };

        /** 
         * 수직 비교
         * 비교 윈도우를 수직으로 배치한다.
         */
        var jsVerticalDiff = function() {
            $("#leftContentWindow").css("width","100%").css("height","300px");
            $("#rightContentWindow").css("width","100%").css("height","300px");
            $("#leftContentWindow").css("clear","both");
        };

    //]]>
    </script>
</head>

<body>

    <div id="tabDiv">
        <ul class="tab">
            <li><a href="<c:url value="/intra/cms/content/PD_SourceDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}&q_rightContentSeqNo=${dataVo.rightContent.contentSeqNo}"><span>소스비교</span></a></li>
            <li><a class="on" href="<c:url value="/intra/cms/content/PD_ScreenDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}&q_rightContentSeqNo=${dataVo.rightContent.contentSeqNo}"><span>화면비교</span></a></li>
        </ul>
    </div>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="s_blue" onclick="jsVerticalDiff();" >수직비교</button></li>
            <li><button type="button" class="s_blue" onclick="jsHorizontalDiff();" >수평비교</button></li>
        </ul>
    </div>
    <!-- //버튼 -->

    <iframe id="leftContentWindow" name="leftContentWindow" style="border:1px solid #333333; width:100%;height:300px;" 
        src="<c:url value="/intra/cms/layout/PD_LayoutPreView.do" />?q_domainCd=${dataVo.leftContent.domainCd}&q_layoutCode=${dataVo.leftContent.layoutCode}&q_menuCode=${dataVo.leftContent.menuCode}&q_contentSeqNo=${dataVo.leftContent.contentSeqNo}"></iframe>

    <iframe id="rightContentWindow" name="rightContentWindow" style="border:1px solid #333333; width:100%;height:300px;"
        src="<c:url value="/intra/cms/layout/PD_LayoutPreView.do" />?q_domainCd=${dataVo.rightContent.domainCd}&q_layoutCode=${dataVo.rightContent.layoutCode}&q_menuCode=${dataVo.rightContent.menuCode}&q_contentSeqNo=${dataVo.rightContent.contentSeqNo}"></iframe>

    <h4>승인/반려 사유</h4>
    <table class="boardWrite" summary="승인/반려 사유">
        <caption class="title">승인/반려 사유</caption>
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tbody>
            <tr>
                <th>발행 사유</th>
                <td>${dataVo.leftContent.publishReason}</td>
            </tr>
            <tr>
                <th>승인/반려 사유</th>
                <td>${dataVo.leftContent.approvalReason}</td>
            </tr>
        </tbody>
    </table>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="w_blue" onclick="self.close();" >닫기</button></li>
        </ul>
    </div>
    <!-- //버튼 -->
</body>
</html>