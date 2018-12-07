<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>이벤트 관리</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="highlight" />

<!-- 기능별 스크립트 정의 -->
<script type="text/javascript">
//<CDATA[[
    $().ready(function(){
        $("input[name=chk-all]").click(function() {
            var isChecked = this.checked;
            $("input[name=eventSns]").each(function() {
                this.checked = isChecked;
            });
        });
    }); //ready

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

    var jsView = function(el,vl){
        document.dataForm2.action = "BD_view.do?eventSn=" + vl;
        document.dataForm2.submit();
    };
    
    var jsUpdate = function(el,vl){
        document.dataForm2.action = "BD_updateForm.do?eventSn=" + vl;
        document.dataForm2.submit();
    };

    var jsViewImg = function(el, vl, zl){
        $(el).colorbox({
            title : zl,
            href  : vl,
            width : "300",
            height: "300"
        });
    };

    var jsSearch = function(){
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    var jsOrder = function(el){
        $(el).colorbox({
            title : "이벤트 정렬 관리",
            href  : "PD_order.do",
            width : "700",
            height: "700",
            iframe: true
        });
    };

    var jsAnswerList = function(el,eventSn,beginDate,endDate){

        var url = "eventSn=" + eventSn;
             url += "&eventTitle=" + $("#eventTitle_" + eventSn).val() ;
             url += "&beginDate=" + beginDate ;
             url += "&endDate=" + endDate ;
        
        $(el).colorbox({
            title : "이벤트 댓글",
            href  : "PD_answerList.do?" + url,
            width : "800",
            height: "500",
            iframe: true
        });
    };


    var jsenfrcClosAt = function(eventSn,endDate){
        <c:set var="now" value="<%=new java.util.Date()%>" />
        var nowDate = '<fmt:formatDate pattern="yyyyMMdd" value="${now}" />';

        if(nowDate>endDate){
            jsWarningBox("이벤트 기간이 지나 진행중상태로 변경할 수 없습니다.");
            return ;
        }
        
        var elementz = $('#enfrcClosAt_' + eventSn);
        var enfrcClosAtVal = elementz.html() == '진행중' ? 'Y' : 'N';
        $.post("ND_eventEnfrcClosAtUpdateAction.do", {
            eventSn : eventSn,
            enfrcClosAt : enfrcClosAtVal
        },
        function(response){
            try {
                if(eval(response)) {
                    jsSuccessBox(Message.msg.processOk);
                    elementz.removeClass();

                    if(enfrcClosAtVal == 'N'){
                        elementz.addClass("ico-chk");
                        elementz.attr("title", "클릭 시 미사용으로 변경");
                        elementz.text("진행중");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_chk_blue.png");

                        
                    }else{
                        elementz.addClass("tx_red");
                        elementz.attr("title", "클릭 시 사용으로 변경");
                        elementz.text("마감");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_cancel_red.png");
                        
                    }

                    self.location.reload();
                    
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
        var eventSns = new Array();
        $("input[name=eventSns]:checked").each(function (i) {

            var strObj = $(this).val().split(',');
            eventSns[i] = strObj[0];
            
            url += "eventSns=" + strObj[0] + "&fileIds=" +  strObj[1] + "&" ;
        });

        
        if(eventSns.length == 0){
            jsWarningBox("삭제 대상 이벤트를 1개 이상 선택하세요.");
            return false;
        }else{
            if(confirm("선택한 " + eventSns.length + "개의 이벤트를 정말 삭제하시겠습니까?")){
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

    var jsEnfrcClosAt = function(varEnfrcClosAt){
        $("#q_enfrcClosAt").val(varEnfrcClosAt);
        $("#dataForm").attr("action","BD_index.do").submit();
    };
    
//]]>
</script>
</head>
<body>
    <div id="contents">
        <form name="dataForm2" id="dataForm2" method="post">
        </form>
        
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
            <input type="hidden" name="q_seq" id="q_seq" value="" />
            <input type="hidden" name="q_enfrcClosAt" id="q_enfrcClosAt" value="" />
            <div class="search">
                <fieldset>
                    <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
                    <label class="skip" for="boardsearch">게시물 검색항목</label>
                    <select id="q_domainCd" title="전체" name="q_domainCd">
                        <option value="">전체</option>
                        <c:forEach items="${dataVo}" var="_bean">
                        <option value="${_bean.domainCd }" <c:if test="${param.q_domainCd eq  _bean.domainCd}">selected="selected"</c:if>>${_bean.domainDc}</option>
                        </c:forEach>
                    </select>
                    <label class="skip" for="boardsearch2">게시물 검색항목2</label>
                    <op:code id="q_eventTyCd" grpCd="1006" defaultValues="${param.q_eventTyCd}" type="select" defaultLabel="전체" />
                    <label class="skip" for="boardsearch2">게시물 검색항목3</label>
                    <%--
                    <select id="q_enfrcClosAt" name="q_enfrcClosAt" title="마감상태를 선택해주세요">
                        <option value="">마감상태를 선택해주세요</option>
                        <option value="Y" <c:if test="${param.q_enfrcClosAt eq  'N'}">selected="selected"</c:if>>진행중</option>
                        <option value="N" <c:if test="${param.q_enfrcClosAt eq  'Y'}">selected="selected"</c:if>>마감</option>
                    </select>
                     --%>
                    <label class="skip" for="searchText">검색단어 입력</label>
                    <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
                    <button class="gray mar_l5 mar_b5" onclick="jsSearch();">검색</button>
                </fieldset>
            </div>
            
            
            <op:pagerParam title="이벤트 목록" />
             <!-- 탭 -->
            <ul class="tab">
                <li id="enfrcClosAt_A"><a href="JavaScript:jsEnfrcClosAt('A')" <c:if test="${ searchMap.q_enfrcClosAt eq 'A' }"> class="on"</c:if>>전체</a></li>
                <li id="enfrcClosAt_N"><a href="JavaScript:jsEnfrcClosAt('N')" <c:if test="${ searchMap.q_enfrcClosAt eq 'N' }">class="on"</c:if>>진행중</a></li>
                <li id="enfrcClosAt_Y"><a href="JavaScript:jsEnfrcClosAt('Y')" <c:if test="${ searchMap.q_enfrcClosAt eq 'Y' }">class="on"</c:if>>마감</a></li>
            </ul>
            
            
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="3%"/>
                <col width="5%"/>
                <col width="10%"/>
                <col width="120"/>
                <col width=""/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="5%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                    <th>번호</th>
                    <th>사이트</th>
                    <th>이미지</th>
                    <th>특성</th>
                    <th>메뉴</th>
                    <th>강제마감</th>
                    <th>강제마감일시</th>
                    <th>댓글</th>
                    <th>진행상태</th>
                    <th>조회수</th>
                    <th class="lr_none">참여자수</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="eventSns" value="${baseVo.eventSn},${baseVo.eventThumbFileSeq}"/></td>
                        <td>${index-status.index}</td><!-- <td>${baseVo.eventSn}</td> -->                        
                        <td>
                            <p class="mar_t5">
                                <c:forEach items="${baseVo.domainCdList }" var="_bean" varStatus="status">
                                    ${_bean.domainDc}
                                    <c:if test="${not status.last }">, </c:if>
                                    <c:if test="${status.count % 3 eq 0}"><br /></c:if>
                                </c:forEach>
                            </p>
                        </td>
                        <td>
                            <c:if test="${not empty baseVo.eventFilePath}">
                                <a href="#" onclick="jsViewImg(this,'${baseVo.eventFilePath }','<c:out value="${fn:escapeXml(baseVo.eventTitle)}"/>');">
                                <img src="${baseVo.eventFilePath }" alt="${baseVo.imageAlt }" style="border: 1px solid #333333;height:60px;width: 100px;"/></a>
                            </c:if>
                        </td>
                        <td>
                            <div class="tx_l">
                                <a href="#" onclick="jsView(this,'${baseVo.eventSn}');">
                                    <span style="font-weight: bold;">종류 </span><span style="font-weight: bold; margin-left: 31px;">: &nbsp;&nbsp;</span><span>${baseVo.eventTyNm}</span>
                                    <br />
                                    <span style="font-weight: bold;">제목 </span><span style="font-weight: bold; margin-left: 31px;">: &nbsp;&nbsp;</span><span>${fn:substring(baseVo.eventTitle,0,30)}<c:if test="${fn:length(baseVo.eventTitle) > 30}">...</c:if></span>
                                    <br />
                                    <span style="font-weight: bold;">기간 </span><span style="font-weight: bold;">: &nbsp;&nbsp;</span><span>${fn:substring(baseVo.beginDate,0,4)}-${fn:substring(baseVo.beginDate,4,6)}-${fn:substring(baseVo.beginDate,6,8)}
                                    ~ ${fn:substring(baseVo.endDate,0,4)}-${fn:substring(baseVo.endDate,4,6)}-${fn:substring(baseVo.endDate,6,8)}</span>
                                    
                                    <c:if test="${not empty baseVo.presnatnDate}">
                                        <br />
                                        <span style="font-weight: bold;">발표 </span><span style="font-weight: bold; margin-left: 31px;">: &nbsp;&nbsp;</span><span>
                                            ${fn:substring(baseVo.presnatnDate,0,4)}-${fn:substring(baseVo.presnatnDate,4,6)}-${fn:substring(baseVo.presnatnDate,6,8)}
                                        </span>
                                    </c:if>
                                </a>
                            </div>
                        </td>
                        <td>
	                        <c:forEach items="${baseVo.eventLcSeCdList }" var="_bean" varStatus="status">
	                            ${_bean.eventLcSeNm}<c:if test="${not status.last }">,<br /></c:if>
	                        </c:forEach>
                        </td>
                        <td>
                             <c:if test="${baseVo.enfrcClosAt eq 'Y'}">
                                <a href="javaScript:jsenfrcClosAt('${baseVo.eventSn}','${baseVo.endDate}');">
                                    <span id="enfrcClosAt_${baseVo.eventSn}" class="tx_red" popupTitle="클릭 시 사용으로 변경">마감</span> <img src="/resources/intra/mgr/icon_cancel_red.png" style="vertical-align:middle;" />
                                </a>
                            </c:if>
                            <c:if test="${baseVo.enfrcClosAt eq 'N'}">
                                <a href="javaScript:jsenfrcClosAt('${baseVo.eventSn}','${baseVo.endDate}');">
                                    <span id="enfrcClosAt_${baseVo.eventSn}" class="ico-chk" title="클릭 시 미사용으로 변경">진행중</span> <img src="/resources/intra/mgr/icon_chk_blue.png" style="vertical-align:middle;" />
                                </a>
                            </c:if>
                        </td>
                        <td>${baseVo.enfrcClosDt}</td>
                        <td>    
                            <c:if test="${baseVo.partcptnCnt > 0}">
                                <button class="blue" type="button" onclick="jsAnswerList(this, '${baseVo.eventSn}' ,'${baseVo.beginDate}','${baseVo.endDate}');">댓글확인</button>
                                <input type="hidden" name="eventTitle_${baseVo.eventSn}" id="eventTitle_${baseVo.eventSn}" value="<c:out value="${baseVo.eventTitle}" />" />
                                
                            </c:if>
                        </td>
                        <td>${baseVo.eventStatus}</td>
                        <td>${baseVo.eventRdcnt}</td>
                        <td class="lr_none">
                            ${baseVo.partcptnCnt}
                        </td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="12" />
            </tbody>
        </table>
            
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
        <div class="tx_r">          
            <a href="#" onclick="jsOrder(this);"><button class="blue" type="button">이벤트정렬</button></a>
            <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
                <button class="blue" type="button" onclick="jsInsertForm();">이벤트 등록</button>
                <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
            </c:if>
        </div>
            
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>