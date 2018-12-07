<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title></title>

    <op:jsTag type="spi" items="highlight, datepicker, cookie" />
    <op:jsTag type="openworks" items="ui" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/intra/board/board.js"></script>

    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">

    //카테고리 저장용
    bbsCtgAry = new Array();

    $().ready(function(){

        //게시판 설정값들을 초기화 합니다.
        if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
        OpenWorks.pageType      = "LIST";
        OpenWorks.boardNm       = "${boardConfVo.bbsNm}";
        OpenWorks.boardType     = "${boardConfVo.kndCd}";
        OpenWorks.useCategory   = "${boardConfVo.ctgYn}";
        OpenWorks.fileYn        = "${boardConfVo.fileYn}";
        OpenWorks.filePermExtsn = "${boardConfVo.filePermExtsn}";
        OpenWorks.captchaYn     = "${boardConfVo.captchaYn}";
        OpenWorks.tagYn         = "${boardConfVo.tagYn}";
        OpenWorks.bbsNm         = "${boardConfVo.bbsNm}";   
        OpenWorks.bbsCd         = "${boardConfVo.bbsCd}";
        OpenWorks.searchVal     = "${param.q_searchVal}";
        OpenWorks.searchKey     = "${param.q_searchKey}";
        OpenWorks.sortName      = "${param.q_sortName}";
        OpenWorks.sortOrder     = "${param.q_sortOrder}";
        OpenWorks.startDt       = "${param.q_startDt}";
        OpenWorks.endDt         = "${param.q_endDt}";
        OpenWorks.showSummaryYn = "${param.showSummaryYn}";
        OpenWorks.domainCd      = "${boardConfVo.domainCd}";
        OpenWorks.serverNm      = "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";

        onReadyEventFunctions();

        //검색 날짜 입력
        $('#q_startDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
        $('#q_endDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});

	        if($("input[id='q_domainCdAll']").is(":checked")){
	            $("input[id=domainCd1]").attr("disabled",true);
	            $("input[id=domainCd2]").attr("disabled",true);
	            $("input[id=domainCd3]").attr("disabled",true);
	            $("input[id=domainCd1]").attr("checked",false);
	            $("input[id=domainCd2]").attr("checked",false);
	            $("input[id=domainCd3]").attr("checked",false);
	        }
    });
    
    function jsCheck(){
        if($("input[id='q_domainCdAll']").is(":checked")){
	        $("input[id=domainCd1]").attr("disabled",true);
	        $("input[id=domainCd2]").attr("disabled",true);
	        $("input[id=domainCd3]").attr("disabled",true);
	        $("input[id=domainCd1]").attr("checked",false);
	        $("input[id=domainCd2]").attr("checked",false);
	        $("input[id=domainCd3]").attr("checked",false);
        }else{
	        $("input[id=domainCd1]").attr("disabled",false);
	        $("input[id=domainCd2]").attr("disabled",false);
	        $("input[id=domainCd3]").attr("disabled",false);
        }
    }
    
    
    var bizViewPop = function (el,domainCd,bbsCd,bbscttSeq,othbcAt) {
        $(el).colorbox({
            title : "비즈매칭 상세페이지",
            href : "BD_board.view.do?domainCd="+domainCd+"&bbsCd="+bbsCd+"&bbscttSeq="+bbscttSeq+"&othbcAt="+othbcAt,
            width : "100%",
            height : "100%",
            iframe : true
        });
    };
    
    var bizRegisterPop = function (el, registId, langCode) {
        
        $(el).colorbox({
            title : "비즈매칭 문의자정보",
            href : "/intra/user/PD_sellerInfoPop.do?userId="+registId+"&langCode"+langCode,
            width : "800",
            height : "800",
            iframe : true
        });
    };
    
    var jsSearchReset2 = function(){
        self.location.href = "BD_board.list.do?domainCd=2&bbsCd=1010";
    };

    </script>
    <!-- 사용자 스크립트 끝 -->
</head>

<body>

    <form name="convertForm" id="convertForm" method="post" onsubmit="return false;">
        <!--  변환 옵션 사항 -->
        <input type="hidden" name="domainCd" id="domainCd" value="${param.domainCd}" />
        <input type="hidden" name="bbsCd" value="${param.bbsCd}" />
        <input type="hidden" name="maxResult" id="maxResult" value="" />
        <input type="hidden" name="showAll" id="showAll" value="N" />
        <input type="hidden" name="noticeBbscttAtYn" id="noticeBbscttAtYn" value="N" />
        <input type="hidden" name="bbscttSjYn" id="bbscttSjYn" value="N" />
        <input type="hidden" name="cnSummaryYn" id="cnSummaryYn" value="N" />
        <input type="hidden" name="registDtYn" id="registDtYn" value="N" />
        <input type="hidden" name="updtDtYn" id="updtDtYn" value="N" />
        <input type="hidden" name="rdcntYn" id="rdcntYn" value="N" />
        <input type="hidden" name="registerNmYn" id="registerNmYn" value="N" />
        <input type="hidden" name="mngrIdYn" id="mngrIdYn" value="N" />
        <input type="hidden" name="userKeyYn" id="userKeyYn" value="N" />
        <input type="hidden" name="accuseCntYn" id="accuseCntYn" value="N" />
        <input type="hidden" name="recomendCntYn" id="recomendCntYn" value="N" />
        <input type="hidden" name="type" value="" />

        <input type="hidden" name="q_currPage" value="${param.q_currPage}" />
        <input type="hidden" name="q_ctgCd" value="-1" />
        <input type="hidden" name="q_aditCtgCd"  />
        <input type="hidden" name="q_sortName" value="${param.q_sortName}" />
        <input type="hidden" name="q_sortOrder" value="${param.q_sortOrder}" />
        <input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
        <input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
        <input type="hidden" name="q_startDt" value="${param.q_startDt}" />
        <input type="hidden" name="q_endDt" value="${param.q_endDt}" />
    </form>

    <!-- 검색 폼 -->
    <form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();">
        <!-- 기본 검색 사항 -->
        <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
        <input type="hidden" name="bbsCd" value="${param.bbsCd}" />
        <input type="hidden" name="domainCd" id="domainCd" value="${param.domainCd}" />
        <input type="hidden" name="pageType" value="" />
        <input type="hidden" name="showSummaryYn" value="${param.showSummaryYn}" />
        <input type="hidden" name="delDesc" id="delDesc" value="" />

        <!-- 도메인 삽입. -->
        <%@include file="../common/INC_domainSearch.jsp" %>
        
        <!-- 검색 삽입. -->
        <%@include file="../common/INC_bizSearch.jsp" %>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="${boardConfVo.bbsNm} 목록" />

        <!-- 목록 삽입. -->
        <%@include file="INC_board.list.jsp" %>

        <!-- 페이징 -->
        <op:pager pager="${pager}" script="jsListReq" />
        <!-- //페이징 -->

        <!-- 버튼 -->
        <div>
            <div class="float_l">
                <button type="button" class="w_blue mar_l5" id="excelBtn">EXCEL</button>
                <button type="button" class="w_blue mar_l5" onclick="jsSummaryShow();">SUMMARY</button>
            </div>
            <div class="float_r">
                <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'}">
<!--                     <button type="button" class="w_blue mar_l5" onclick="jsInsertForm('INSERT');">등록</button> -->
                </c:if>
                <c:if test="${MenuAssignType eq 'G'}">
                    <button type="button" class="w_blue mar_l5" onclick="jsDeleteList('${param.bbsCd}', '${param.domainCd}');">선택항목삭제</button>
                </c:if>
            </div>
        </div>

    </form>

</body>
</html>