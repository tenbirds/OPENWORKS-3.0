<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
    <head>
        <title>휴면회원관리</title>
        <op:jsTag type="spi" items="validate,ui,highlight"/>
        <op:jsTag type="openworks" items="ui"/>

        <script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
        <script type="text/javascript">
        //<![CDATA[
        (function ($) {
            var pwdYn = "${param.pwdYn}";
            if(pwdYn != 'Y'){
                self.location.href = "BD_pwdForm.do?title1="+ "회원관리"+"&title2="+"회원정보 조회"+"&menuType="+"R"+"&returnUrl="+"BD_drmncy.do";
            }
        })($);

        $().ready(function() {

            // 검색 엔터 이벤트
            jsSetSearchEnterEvent();

            $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

            $('#startDt').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonImageOnly : true
            });
            $('#endDt').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonImageOnly : true
            });
            <c:forEach items="${searchMap.q_searchKey0}" var="searchKey">
            $("input:checkbox[name='q_searchKey0']:checkbox[value='${fn:trim(searchKey)}']").attr("checked",true);
            </c:forEach>
            
            $("#dataForm").validate({
                rules: {
                    q_stDate : { dateISO: true, date: true },
                    q_enDate : { dateISO: true, date: true }
                },
                messages: {
                    q_stDate : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                      date: "시작날짜가 형식에 맞지 않습니다."},
                    q_enDate   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
                                      date: "종료날짜가 형식에 맞지 않습니다."}
                },
                submitHandler : function(form) {
                 	if ($("#startDt").val()=='' &&  $("#endDt").val()!='') {
                     	alert("시작날짜가 존재하지 않습니다.");
                     	return false;
                 	}
                 	if ($("#startDt").val()!='' &&  $("#endDt").val()=='') {
                     	alert("종료날짜가 존재하지 않습니다.");
                     	return false;
                 	}
                 	if ($("#startDt").val() > $("#endDt").val()) {
                     	alert("종료날짜가 시작날짜 보다 작습니다.");
                     	return false;
                 	}
                 	if($("#startDt").val() > $("#endDt").val()){
                        jsWarningBox("회원가입일 조회 시작일이 종료일보다 먼저이어야 합니다.");
                        $("#startDt").focus();
                        return false;
                    }
                 	form.submit();
             	}
            });
        });

        var jsDateReset = function() {
            $('#startDt').val("");
            $('#endDt').val("");
        };

        var jsReloadTab = function() {
            tabs.refresh();
        };
        
        var jsMoveTab = function(index) {
            tabs.moveTab(index);
        };

        // 검색 엔터 이벤트
        var jsSetSearchEnterEvent = function() {
            $("#q_searchVal").keydown(function(event){
                if(event.keyCode == 13) {
                    $(this).next().click();
                    return false;
                }
            });
        };

        //통합검색바
        var jsSearchAction = function() {
            if ( $("#q_searchKey").val() != "" ) {
                if ( $("#q_searchVal").val() == "" ) {
                    jsWarningBox("검색어를 입력하세요.");
                    $("#q_searchVal").focus();
                    return false;
                }
            }else{
                if ( $("#q_searchVal").val() != "") {
                    jsWarningBox("검색조건을 선택하세요.");
                    $("#q_searchKey").focus();
                    return false;
                }
            }
            
            $('#q_currPage').val("1");
            $('#dataForm').submit();
        };

        var InsertPop = function (el, userTy) {
            $(el).colorbox({
                title : "회원 등록",
                href : "PD_userForm.do?userTy="+userTy,
                width : "100%",
                height : "100%",
                overlayClose : false,
                iframe : true
            });
        };

        var jsMovePage = function(page) {
            var p = 1;
            if (page == 'page') {
                p = $('input[name=page]').val();
            } else {
                p = page;
            }
            $("#q_currPage").val(p);
            $("#dataForm").action= "BD_drmncy.do";
            $("#dataForm").submit();
        };

        var submitEvent = function() {
            if(event.keyCode == 13) {
                jsSearchAction();
            }
        };

        var userListExel = function(el, paramVal){
            $(el).colorbox({
                title : "엑셀 출력 항목 선택",
                href : "PD_checkUserListExel.do?paramVal=" +paramVal,
                width : "850",
                height : "550",
                iframe : true
            });
        };

        var jsSearchReset = function(){
            self.location.href = "BD_drmncy.do?pwdYn=Y";
        };
        
        
        var userNanDrmncy = function() {
            var items = []; 
            var checkCnt = 0;
            var sessionid = '${sessionScope.tempId}';
            
            $('input:checkbox[name=drmncyChk]:checked').each(function () {
                items.push($(this).val());
            });
            checkCnt = items.length;
            
            if (checkCnt == 0 ) {
               alert('적어도 1개 이상 선택 하셔야 합니다.');
               return false;
           }else{
               alert(items);
           }
           //$('input:checkbox[name=drmncyChk]:checked').attr("checked", false);
        }

        //]]>
        </script>
    </head>

    <body>
        <form id="dataForm" name="dataForm">
        <input type="hidden" id="pwdYn" name="pwdYn" value="${param.pwdYn}"/>
        <!-- 컨텐츠영역 -->
        <div id="contents">
            <!-- 인원수정보
            <div class="mar_b30">
            <table class="boardWrite" cellspacing="0" border="0" summary="인원수 정보">
                <caption class="hidden"> 인원수 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>현재 방문자수</th>
                        <td><fmt:formatNumber value="${presentVisitNum}" type="number" /> 명</td>
                        <th>금일 가입 회원수</th>
                        <td><fmt:formatNumber value="${dataVo.todayRegUserCnt }" type="number" /> 명</td>
                    </tr>
                    <tr>
                        <th>전체 회원 수</th>
                        <td><fmt:formatNumber value="${dataVo.totalUserCnt }" type="number" /> 명</td>
                        <th>전체 탈퇴 회원수</th>
                        <td><fmt:formatNumber value="${dataVo.totalUserStateNCnt }" type="number" /> 명</td>
                    </tr>
                </tbody>
            </table>
            </div>
            //인원수정보 -->
            <div class="mar_b30">
            <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                <caption class="hidden"> 검색 조건 </caption>
                <colgroup>
                    <col width="10%" />
                    <col width="40%" />
                    <col width="10%" />
                    <col width="40%" />
                </colgroup>
                <tbody>
                    <%-- <tr>
                        <th>가입경로</th>
                        <td>
                            <op:code id="q_searchKey1" grpCd="1001" defaultValues="${param.q_searchKey1}"/>
                        </td>
                        <th>국적</th>
                        <td>
                            <select id="countryCd" name="q_searchKey3">
                                <option value="">-- 선택 --</option>
                                <c:forEach items="${countryList}" var="country" varStatus="status">
                                    <option value="${country.NATIONCODE}" ${country.NATIONCODE eq param.q_searchKey3 ? 'selected="selected"' : ''}>${country.LANGNATIONNM}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr> --%>
                    <%-- <tr>
                        <th>대륙</th>
                        <td>
                            <select id="continent" name="q_continent">
                                <option value="">-- 선택 --</option>
                                <c:forEach items="${continentList}" var="continent">
                                    <option value="${continent.CNTT_SE_NM}" ${continent.CNTT_SE_NM eq param.q_continent ? 'selected="selected"' : ''}>${continent.CNTT_SE_NM}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <th>성별</th>
                        <td>
                            <op:code id="q_sexdstnCd" grpCd="75" defaultValues="${param.q_sexdstnCd}"/>
                        </td>
                    
                        <th>연령</th>
                        <td colspan="3">
                            <select id="q_ageGroup" name="q_ageGroup">
                                <option value="">-- 선택 --</option>
                                <option value="20" ${param.q_ageGroup eq '20' ? 'selected="selected"' : ''}>20대 이하</option>
                                <option value="30" ${param.q_ageGroup eq '30' ? 'selected="selected"' : ''}>30대</option>
                                <option value="40" ${param.q_ageGroup eq '40' ? 'selected="selected"' : ''}>40대</option>
                                <option value="50" ${param.q_ageGroup eq '50' ? 'selected="selected"' : ''}>50대</option>
                                <option value="60" ${param.q_ageGroup eq '60' ? 'selected="selected"' : ''}>60대 이상</option>
                            </select>
                        </td>
                    </tr> --%>
                    <tr>
                        <th>회원가입일</th>
                        <td colspan="3">
                            <input class="w120" type="text" name="q_stDate" id="startDt" title="날짜선택" value="${param.q_stDate}" />
                            <input class="w120" type="text" name="q_enDate" id="endDt" title="날짜선택" value="${param.q_enDate}" />
                            <button type="button" class="gray mar_l5 mar_b5" onclick="jsDateReset();">초기화</button>
                        </td>
                        <%-- 
                        <th>회원등급</th>
                        <td>
                            <c:forEach items="${userGradeList}" var="grade" varStatus="status">
                                <input type="checkbox" value="${grade.userGradCode}" name="q_searchKey2" id="userGrade${status.count}" ${fn:contains(searchMap.q_searchKey2, grade.userGradCode) ? 'checked="checked"' : ''}/>
                                <label for="userGrade${status.count}">${grade.userGradNm}</label>
                            </c:forEach>
                        </td>
                         --%>
                    </tr>
                    <tr>
                        <th>키워드</th>
                        <td>
                            <select id="q_searchKey" name="q_searchKey" class="over">
                                <option value="">선택</option>
                                <option <c:if test="${param.q_searchKey == 1000}">selected="selected"</c:if> value="1000"> 전체</option>
                                <option <c:if test="${param.q_searchKey == 1001}">selected="selected"</c:if> value="1001"> 성명</option>
                                <option <c:if test="${param.q_searchKey == 1002}">selected="selected"</c:if> value="1002"> ID</option>
                                <!-- 20150727 이메일 검색조건 추가 시작 -->
                                <option <c:if test="${param.q_searchKey == 1003}">selected="selected"</c:if> value="1003"> 이메일</option>
                                <!-- 20150727 이메일 검색조건 추가 끝 -->
                                <!-- 20150728 회사명, 스토어명 검색조건 추가 시작 -->
                                <option <c:if test="${param.q_searchKey == 1004}">selected="selected"</c:if> value="1004"> 기관·기업명</option>
                                <option <c:if test="${param.q_searchKey == 1005}">selected="selected"</c:if> value="1005"> 스토어명</option>
                                <option <c:if test="${param.q_searchKey == 1006}">selected="selected"</c:if> value="1006"> 사업자번호</option>
                                <%-- <option <c:if test="${param.q_searchKey == 1006}">selected="selected"</c:if> value="1005"> ?</option> --%>
                                <!-- 20150728 회사명, 스토어명 검색조건 추가 끝 -->
                            </select>
                            <input class="w215" type="text" value="${param.q_searchVal}" id="q_searchVal" name="q_searchVal" title="검색어를 입력하세요."/>
                        </td>
                        <th>회원구분</th>
                        <td>
                            <%-- <op:code type="checkbox" id="q_searchKey0" grpCd="5" /> --%>
                            <op:code id="q_searchKey0" grpCd="5" defaultValues="${param.q_searchKey0}"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <button type="button" class="gray mar_l5 mar_b5" onclick="jsSearchAction();">검색</button>
                            <button type="button" class="gray mar_l5 mar_b5" onclick="jsSearchReset();">검색초기화</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            </div>
            <op:pagerParam title="회원 목록" />
            <!-- 리스트 -->
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <!-- 20150727 colgroup 원본 
                <colgroup>
                    <col width="3%"/>
                    <col width="8%"/>
                    <col width="7%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="4%"/>
                    <col width="7%"/>
                    <col width="5%"/>
                    <col width="4%"/>
                    <col width="8%"/>
                    <col width="6%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                </colgroup>
                -->
                <!-- 20150727 시작 -->
                <colgroup>
                    <col width="5%"/>
                    <col width="8%"/>
                    <col width="7%"/>
                    <col width="12%"/>
                    <col width="*%"/>
                    <col width="4%"/>
                    <col width="4%"/>
                    <col width="4%"/>
                    <col width="12%"/>
                    <col width="4%"/>
                    <col width="4%"/>
                    <col width="4%"/>
                    <%-- <col width="4%"/>
                    <col width="4%"/>
                    <col width="4%"/> --%>
                    <%-- <col width="4%"/> --%>
                    <col width="9%"/>
                    <col width="9%"/>
                </colgroup>
                <!-- 20150727 끝 -->
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>ID</th>
                        <th>이름</th>
                        <th>기관·기업명</th>
                        <!-- 20150727 이메일 항목 추가 시작 -->
                        <th>이메일</th>
                        <!-- 20150727 이메일 항목 추가 끝 -->
                        <th>국적</th>
                        <th>회원<br/>구분</th>
                        <th>사용<br/>권한</th>
                        <th>스토어</th>
                        <!-- <th>신고<br/>건수</th>
                        <th>회원<br/>등급</th>
                        <th>활동<br/>레벨</th> -->
                        <th>광고<br/>홍보</th>
                        <th>뉴스<br/>레터</th>
                        <th>입찰<br/>공고</th>
                        <!-- <th>SMS<br/>수신</th> -->
                        <th>가입일</th>
                        <th class="lr_none">최근<br />접속일</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                	<!-- 20150728 게시물 번호(indexNo+1을 indexNo로 변경) 수정 시작 -->
                    <c:set var="index" value="${pager.indexNo}"/>
                    <!-- 20150728 게시물 번호(indexNo+1을 indexNo로 변경) 수정 끝 -->
                    <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="drmncyChk" name="drmncyChk" value="${_bean.userId}"/><%-- ${index-status.index} --%></td>
                            <td class="tx_l"><a href="#" onclick="pwdConfirm(this, '회원정보조회', 'R', 'PD_userForm.do', '100%', '100%', '${_bean.userId}', '${_bean.userTyCd}', '', '', '');">${_bean.userId}</a></td>
                            <td class="tx_l"><c:out value="${_bean.userNm}" /></td>
                            <td class="tx_l"><c:out value="${_bean.cmpnyNm}" /></td>
                            <!-- 20150727 이메일 항목 추가 시작 -->
                            <td class="tx_l"><c:out value="${_bean.email}" /></td>
                            <!-- 20150727 이메일 항목 추가 끝 -->
                            <td>${_bean.nationCode == '대한민국' ? '한국' : _bean.nationCode}</td>
                            <td>
                                <c:if test="${fn:startsWith(_bean.userTyCd, '10')}">개인</c:if>
                                <c:if test="${fn:startsWith(_bean.userTyCd, '20')}">기업</c:if>
                                <c:if test="${fn:startsWith(_bean.userTyCd, '30')}">공공</c:if>
                            </td>
                            <td>
                                <c:if test="${fn:endsWith(_bean.userTyCd, '01')}">구매</c:if>
                                <c:if test="${fn:endsWith(_bean.userTyCd, '02')}">판매</c:if>
                            </td>
                            <td class="tx_l">
                                <c:forEach items="${_bean.userstore}" var="store">
                                    ${store.LANG_STORE_NM}(${store.LANG_NM})<br />                                    
                                </c:forEach>
                            </td>
                            <%-- <td class="tx_r">${_bean.accuseAtCdCnt}</td>
                            <td>${_bean.userGradNm}</td>
                            <td>${_bean.actLevelNm}</td> --%>
                            <!-- 20150728 email, sms 수신동의, 거부 표 시작 -->
                            <td>${_bean.emailRecptnAgreCd == 1001 ? '동의' : _bean.emailRecptnAgreCd == 1002 ? '거부' : '-'}</td>
                            <td>${_bean.nsletRecptnAgreCd == 1001 ? '동의' : _bean.nsletRecptnAgreCd == 1002 ? '거부' : '-'}</td>
                            <td>${_bean.bidRecptnAgreCd == 1001 ? '동의' : _bean.bidRecptnAgreCd == 1002 ? '거부' : '-'}</td>
                            <%-- <td>${_bean.smsRecptnAgreCd == 1001 ? '동의' : _bean.smsRecptnAgreCd == 1002 ? '거부' : '-'}</td> --%>
                            <!-- 20150728 email, sms 수신동의, 거부 표시 끝 -->
                            <td>${_bean.registDt}</td>
                            <td class="lr_none">${_bean.recentLoginDt}</td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="14"/>
                </tbody>
            </table>
            <!-- //리스트 -->
            <!-- 페이징 -->
            <op:pager pager="${pager}"/>
            <!-- //페이징 -->

            <!-- 버튼 -->
            <div>
                <div class="float_r">
                	<!-- 회원등록 막음 2016.11.30 -->
                    <!-- <a href="#" class="btn"><button type="button" onclick="InsertPop(this, '10');" class="blue">개인회원등록</button></a>
                    <a href="#" class="btn"><button type="button" onclick="InsertPop(this, '20');" class="blue">기업회원등록</button></a> -->
                    <!-- 공공기관등록 막음 2017.03.22-->
                    <!-- <a href="#" class="btn"><button type="button" onclick="InsertPop(this, '30');" class="blue">공공기관등록</button></a> -->
                    <button class="w_blue" type="button" onclick="userNanDrmncy();">비휴면계정 전환</button>
                    <button class="w_blue" type="button" onclick="userListExel(this, '∬q_searchKey0=${param.q_searchKey0}∬q_searchKey1=${param.q_searchKey1}∬q_searchKey2=${param.q_searchKey2}∬q_searchKey3=${param.q_searchKey3}∬q_searchKey=${param.q_searchKey}∬q_searchVal=${param.q_searchVal}∬q_stDate=${param.q_stDate}∬q_enDate=${param.q_enDate}∬q_userSttusCd=1001');">엑셀출력</button>
                </div>
            </div>

        </div>
        <!-- //컨텐츠영역 -->
        </form>
    </body>
</html>