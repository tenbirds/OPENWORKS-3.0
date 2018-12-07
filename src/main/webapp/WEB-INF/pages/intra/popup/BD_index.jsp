<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>팝업 관리</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="highlight" />
<!-- 기능별 스크립트 정의 -->
<script type="text/javascript">
//<![CDATA[
    $().ready(function(){
         $('.cnHtml').hide();

         $("input[name=chk-all]").click(function() {
             var isChecked = this.checked;
             $("input[name=popupSns]").each(function() {
                 this.checked = isChecked;
             });
         });

         
    });

    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };

    var jsInsertForm = function(){
        document.dataForm2.action = "BD_insertForm.do";
        document.dataForm2.submit();
    };

    var jsUpdate = function(el, vl){
        document.dataForm2.action = "BD_updateForm.do?popupSn=" + vl;
        document.dataForm2.submit();
    };

    var jsViewPop = function(el, popupSn){
        $.ajax({
            url: 'ND_viewPop.do',
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async   : false,
            data: {
                popupSn : popupSn
            },
            success: function(json){
                if(json.makeTyCd == '1001'){
                    $(el).colorbox({
                        title :  json.popupTitle,
                        html  :  json.cnHtml ,
                        width :  json.widthSize ,
                        height:  json.heightSize ,
                        top   :  json.topLc,
                        left  :  json.leftLc,
                        scrolling : json.scrlYn
                       });
                }else if(json.makeTyCd == '1002'){
                    $(el).colorbox({
                        title :  json.popupTitle,
                        href  :  json.cnUrl ,
                        width :  json.widthSize ,
                        height:  json.heightSize ,
                        top   :  json.topLc,
                        left  :  json.leftLc,
                        scrolling : json.scrlYn,
                        iframe: true
                       });
                }else{
                    $(el).colorbox({
                        title :  json.popupTitle,
                        href  :  json.popupFilePath ,
                        width :  json.widthSize ,
                        height:  json.heightSize ,
                        top   :  json.topLc,
                        left  :  json.leftLc,
                        scrolling : json.scrlYn,
                        iframe: true
                    });
                }
            }
        });
    };

    var jsSearch = function(){
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    var jsUseYn = function(popupSn){
        var elementz = $('#UseYn_' + popupSn);
        var useYnVal = elementz.html() == '사용' ? 'N' : 'Y';
        $.post("ND_popupUseYnUpdateAction.do", {
            popupSn : popupSn,
            useYn : useYnVal
        },
        function(response){
            try {
                if(eval(response)) {
                    jsSuccessBox(Message.msg.processOk);
                    elementz.removeClass();

                    if(useYnVal == 'Y'){
                        elementz.addClass("ico-chk");
                        elementz.attr("title", "클릭 시 미사용으로 변경");
                        elementz.text("사용");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_chk_blue.png");
                    }else{
                        elementz.addClass("tx_red");
                        elementz.attr("title", "클릭 시 사용으로 변경");
                        elementz.text("미사용");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_cancel_red.png");
                    }
                } else {
                    jsErrorBox(Message.msg.processFail);
                }
            } catch (e) {
                jsSysErrorBox(response, e);
                return;
            }
        });
    };


    /**
     * 목록 삭제
     */
    var jsDeleteList = function(){
        var url = "ND_deleteAction.do?";
        var popupSns = new Array();
        $("input[name=popupSns]:checked").each(function (i) {
            popupSns[i] = $(this).val();
            url += "popupSns=" + $(this).val() + "&";
        });

        if(popupSns.length == 0){
            jsWarningBox("삭제 대상 팝업을 1개 이상 선택하세요.");
            return false;
        }else{
            if(confirm("선택한 " + popupSns.length + "개의 팝업을 정말 삭제하시겠습니까?")){
                $.post(url,
                function(response){
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            self.location.reload();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                });
            }
        }
    };    
    
//]]>
</script>
</head>
<body>
	<!-- 컨텐츠영역 -->
    <div id="content">
        <form name="dataForm2" id="dataForm2" method="post">
        </form>
        <!-- 타이틀 및 상단아이콘 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
        	<!-- 검색 -->
	        <div class="search">
	            <fieldset>
	                <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
	                <select id="q_domainCd" title="도메인을 선택해주세요" name="q_domainCd">
	                        <option value="">전체</option>
	                        <c:forEach items="${dataVo}" var="_bean">
	                        <option value="${_bean.domainCd}" <c:if test="${param.q_domainCd eq _bean.domainCd}">selected="selected"</c:if>>${_bean.domainDc}</option>
	                        </c:forEach>
	                </select>
	                <input class="w215" type="text" value="${param.q_searchVal}" name="q_searchVal"  id="q_searchVal" title="검색어를 입력하세요." />
	                <button type="button" class="gray mar_l5" onclick="jsSearch();">검색</button>
	            </fieldset>
	        </div>
        	<!-- //검색 -->
        	<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="팝업 목록" />
        </form>

        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="5%"/>
                <col width="15%"/>
                <col width=""/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="8%"/>
                <col width="8%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                    <th>번호</th>
                    <th>사이트</th>
                    <th>제목</th>
                    <th>광고주</th>
                    <th>표시기간</th>
                    <th>미리보기</th>
                    <th>상태</th>
                    <th class="lr_none">사용여부</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	                <tr>
                        <td><input type="checkbox" name="popupSns" value="${baseVo.popupSn}"/></td>
                        <td>${index-status.index}</td><!-- <td>${baseVo.popupSn}</td> -->
	                    <td>
	                        <p class="mar_t5">
		                        <c:forEach items="${baseVo.domainCdList }" var="_bean" varStatus="status">
		                            <c:if test="${not status.first }">, </c:if>
		                            ${_bean.domainDc}
		                        </c:forEach>
	                        </p>
	                    </td>
	                    <td class="tx_l">
	                        <a href="#" onclick="jsUpdate(this,'${baseVo.popupSn}');">${fn:substring(baseVo.popupTitle,0,30)}
	                        	<c:if test="${fn:length(baseVo.popupTitle) > 30}">...</c:if>
	                        </a>
	                    </td>
                        <td class="tx_l">
                            ${baseVo.advrtsClientNm}
                        </td>
	                    <td>
	                    	${fn:substring(baseVo.beginDate,0,4)}-${fn:substring(baseVo.beginDate,4,6)}-${fn:substring(baseVo.beginDate,6,8)}
	                    	~ ${fn:substring(baseVo.endDate,0,4)}-${fn:substring(baseVo.endDate,4,6)}-${fn:substring(baseVo.endDate,6,8)}
	                    </td>
	                    <td>
	                      <button class="blue" type="button" onclick="jsViewPop(this,'${baseVo.popupSn}');">미리보기</button>
	                    </td>
	                    <td <c:if test="${baseVo.gubun eq 1}">class="tx_red"</c:if><c:if test="${baseVo.gubun eq 2}">class="tx_blue"</c:if>>
	                        <c:if test="${baseVo.gubun eq 1}">진행중</c:if>
	                        <c:if test="${baseVo.gubun eq 0}">종료</c:if>
	                        <c:if test="${baseVo.gubun eq 2}">대기중</c:if>
	                    </td>
	                    <td class="lr_none">
	                        <c:if test="${baseVo.useYn eq 'N'}">
	                            <a href="javaScript:jsUseYn('${baseVo.popupSn}');">
	                                <span id="UseYn_${baseVo.popupSn}" class="tx_red" popupTitle="클릭 시 사용으로 변경">미사용</span> <img src="/resources/intra/mgr/icon_cancel_red.png" style="vertical-align:middle;" />
	                            </a>
	                        </c:if>
	                        <c:if test="${baseVo.useYn eq 'Y'}">
	                            <a href="javaScript:jsUseYn('${baseVo.popupSn}');">
	                            	<span id="UseYn_${baseVo.popupSn}" class="ico-chk" title="클릭 시 미사용으로 변경">사용</span> <img src="/resources/intra/mgr/icon_chk_blue.png" style="vertical-align:middle;" />
	                            </a>
	                        </c:if>
	                    </td>
	                </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="9" />
            </tbody>
        </table>
        <!-- //리스트 -->

        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

        <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
        	<div class="tx_r">
                <button class="blue" type="button" onclick="jsInsertForm();">팝업 등록</button>
                <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
            </div>
        </c:if>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>