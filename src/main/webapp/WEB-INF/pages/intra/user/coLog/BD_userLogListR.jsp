<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
<title>회원정보조회이력관리</title>
<op:jsTag type="spi" items="ui, highlight,validate"/>
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
<script type="text/javascript">
    (function ($) {
        if('${param.pwdYn}' != 'Y'){
            self.location.href = "/intra/user/BD_pwdForm.do?title1="+ "회원정보조회이력관리"+"&title2="+"회원정보조회 이력"+"&menuType="+"L"+"&returnUrl="+"/intra/user/coLog/BD_userLogListR.do";
        }
    })($);

    $().ready(function() {
        $("#${param.selectDateColor}").css("background-color","black"); 
                
        if($("#dateSetYn").val() == "Y"){
            $("#dateSet").show();
        }else{
            $("#dateSet").hide();
        }
        $(".mo_why").hide();

        $("#dateSet1  a  button.gray").click(function() {
            $('#q_enDate').val(getDateStr(new Date()));
            var sType = $(this).attr('id');
            var stDate = null;
            switch(sType) {
            case '0' :
                stDate = new Date();
                $("#selectDateColor").val("0");
                dateButton();
                break;
            case '1D':
                stDate = getCalDate(new Date(),0,-1);
                $("#selectDateColor").val("1D");
                dateButton();
                break;
            case '7D':
                stDate = getCalDate(new Date(),0,-7);
                $("#selectDateColor").val("7D");
                dateButton();
                break;
            case '10D':
                stDate = getCalDate(new Date(),0,-10);
                $("#selectDateColor").val("10D");
                dateButton();
                break;
            case '15D':
                stDate = getCalDate(new Date(),0,-15);
                $("#selectDateColor").val("15D");
                dateButton();
                break;
            case '1M':
                stDate = getCalDate(new Date(),-1,0);
                $("#selectDateColor").val("1M");
                dateButton();
                break;
            case '3M':
                stDate = getCalDate(new Date(),-3,0);
                $("#selectDateColor").val("3M");
                dateButton();
                break;
            case '6M':
                stDate = getCalDate(new Date(),-6,0);
                $("#selectDateColor").val("6M");
                dateButton();
                break;
            case 'ALL':
                stDate = new Date();
                $("#selectDateColor").val("ALL");
                dateButton();
                break;
            default:
                stDate = new Date();
                break;
            }
            $('#q_stDate').val(getDateStr(stDate));
            if ($('#q_enDate').val() == '') {
                $('#q_enDate').val(getDateStr(new Date()));
            }

            if (sType == 'ALL') {
                $('#q_stDate').val("");
                $('#q_enDate').val("");
            }
        });

        var dateButton = function(){
            $(".gray").css("background-color","#979797");
            $("#"+$("#selectDateColor").val()).css("background-color","black");
        }

//         $('span.vt button:contains("검색")').click(function() {
//         $('.gray').click(function() {
//             if ($('#q_stDate').val() > $('#q_enDate').val()) {
//                 jsWarningBox('시작일이 종료일보다 늦습니다.');
//                 return;
//             }
            
//             if($('input[name=txtMovePage]').val() == '' || $('input[name=txtMovePage]').val() == null){
//                 $('input[name=q_currPage]').val("1");            
//             }
//             $('#dataForm').submit();
//         });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_stDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_enDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

    });
    // 아이디 및 이름 검색
    var jsSearchAction = function() {
        $("#dataForm").validate({
            rules : {
                q_stDate : {date:true},
                q_enDate : {date:true}
            }
        });        
        
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
        
        if ($('#q_stDate').val() > $('#q_enDate').val()) {
            jsWarningBox('시작일이 종료일보다 늦습니다.');
            return;
        }

        $('#q_currPage').val("1");
        $('#dataForm').submit();
    };

    var getCalDate = function(date, months, days) {
        var newDate = date;
        if (typeof(date.getDate) != 'function') {
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;

    };

    var getDateStr = function(date) {
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
    };
    
    var dateSet = function(){
        $(".gray").css("background-color","#979797");
        $("#selectDateColor").val("");
        if($("#dateSetYn").val() == "Y"){
            $("#dateSet").hide();
            $('#q_stDate').val('');
            $('#q_enDate').val('');
            $("#dateSetYn").val("N");
        }else{
            $("#dateSet").show();
            $('#q_stDate').val('');
            $('#q_enDate').val('');
            $('#q_stDate').focus();
            $("#dateSetYn").val("Y");
        }
    };

 // 페이징
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $('#dataForm input[name=q_currPage]').val(p);
        $('#dataForm').submit();
    };
    
    // 사유 상세설명 레이어
    var reasonLayer = function(idNum){
        if(idNum == $("#idNum").val() && $("#reasonLayerYn").val() == "Y"){
            $("#mo_why_"+idNum).hide();
            $("#reasonLayerYn").val("N");
        }else{
               $("#mo_why_"+$("#idNum").val()).hide();
            $("#mo_why_"+idNum).show();
            $("#idNum").val(idNum);
            $("#reasonLayerYn").val("Y");
        }
    };
    
    var dateAuto = function(obj){
        // cursor를 문장 끝으로 이동
        if(obj.createTextRange){
            var FieldRange = obj.createTextRange();
            FieldRange.moveStart('character', obj.value.length);
            FieldRange.collapse();
            FieldRange.select();
        }
        
        //입력 허용 키
        if ((event.keyCode >= 48 && event.keyCode <= 57) ||   //숫자열 0 ~ 9 : 48 ~ 57
            (event.keyCode >= 96 && event.keyCode <= 105) ||  //키패드 0 ~ 9 : 96 ~ 105
             event.keyCode == 8  || event.keyCode == 46 ||    //BackSpace, Delete
             event.keyCode == 35 || event.keyCode == 36 ||    //End 키, Home 키
             event.keyCode == 9  || event.keyCode == 45)    {    //Tab 키
            event.returnValue = true;
        }else{
            event.returnValue = false;
        }
        if(event.keyCode != 8){
            var qStDate = $("#q_stDate").val();
            var qEnDate = $("#q_enDate").val();
            if(qStDate.length > 10 || qEnDate.length >10){
                return;
            }

            if(qStDate.length == 4){
                $("#q_stDate").val(qStDate+"-");
            }else if(qStDate.length == 7){
                $("#q_stDate").val(qStDate+"-");
            }

            if(qEnDate.length == 4){
                $("#q_enDate").val(qEnDate+"-");
            }else if(qEnDate.length == 7){
                $("#q_enDate").val(qEnDate+"-");
            }
        }
    };
    
</script>
</head>
<body>
    <form id="dataForm">
        <input type="hidden" id="dateSetYn" name="dateSetYn" value="${param.dateSetYn}"/>
        <input type="hidden" id="idNum" value=""/>
        <input type="hidden" id="reasonLayerYn" value="N"/>
        <input type="hidden" id="pwdYn" name="pwdYn" value="${param.pwdYn}"/>
        <input type="hidden" id="selectDateColor" name="selectDateColor" value="${param.selectDateColor}"/>
    <!-- 컨텐츠영역 -->
    <div id="contents">
        <div class="tx_r">
            <button type="button" class="s_blue mar_l5 mar_b5" onclick="pwdConfirm(this
                                                                                  ,'회원정보조회이력 리스트 엑셀 출력'
                                                                                  ,'O'
                                                                                  ,'/intra/user/coLog/INC_userLogListExcel.do'
                                                                                  ,'1000'
                                                                                  ,'850'
                                                                                  ,''
                                                                                  ,''
                                                                                  ,'∬q_searchKey=${param.q_searchKey}∬q_searchVal=${param.q_searchVal}∬q_stDate=${param.q_stDate}∬q_enDate=${param.q_enDate}∬menuType1=R'
                                                                                  ,'리스트');">엑셀출력</button>
        </div>
        <!-- 검색 -->
        <div class="search">
        <div>
            <fieldset>
                <legend>게시글의 성명,id,조회자,조회자ID로 검색하세요.</legend>
                <select id="q_searchKey" name="q_searchKey" class="over">
                    <option value="">선택</option>
                    <option <c:if test="${param.q_searchKey == 1001}">selected="selected"</c:if> value="1001">전체</option>
                    <option <c:if test="${param.q_searchKey == 1002}">selected="selected"</c:if> value="1002">성명</option>
                    <option <c:if test="${param.q_searchKey == 1003}">selected="selected"</c:if> value="1003">ID</option>
                    <option <c:if test="${param.q_searchKey == 1004}">selected="selected"</c:if> value="1004">조회자ID</option>
                    <option <c:if test="${param.q_searchKey == 1005}">selected="selected"</c:if> value="1005">조회자</option>
                </select>
                <input class="w215" type="text" value="${param.q_searchVal}" id="q_searchVal" name="q_searchVal" title="검색어를 입력하세요."/>
                <button type="button" onclick="jsSearchAction();" class="gray mar_l5 mar_b5">검색</button>
            </fieldset>
        </div>
        <!-- //검색 -->
        <br/>
        <!-- 검색일자-->
        <div id="dateSet1">
            <a href="#"><button type="button" id="0"   class="gray">당일</button></a>
            <a href="#"><button type="button" id="1D"  class="gray">전일</button></a>
            <a href="#"><button type="button" id="7D"  class="gray">7일</button></a>
            <a href="#"><button type="button" id="10D" class="gray">10일</button></a>
            <a href="#"><button type="button" id="15D" class="gray">15일</button></a>
            <a href="#"><button type="button" id="1M"  class="gray">1개월</button></a>
            <a href="#"><button type="button" id="3M"  class="gray">3개월</button></a>
            <a href="#"><button type="button" id="6M"  class="gray">6개월</button></a>
            <a href="#"><button type="button" id="ALL" class="gray">전체</button></a>
            <a href="#"><button type="button" id="DATESET" onclick="dateSet()" class="s_blue">기간지정</button></a>
        </div>
        <br/>
        <div id="dateSet">
            <fieldset>
                <legend>일시를 지정하여 검색하세요.</legend>
                <label><span class="tx_b">검색일자</span></label>
                <input type="text" name="q_stDate" id="q_stDate" onkeydown="dateAuto(this);" class="w120" title="올바른 날짜를 입력하세요." value="${param.q_stDate}" maxlength="10"/> ~
                <input type="text" name="q_enDate" id="q_enDate" onkeydown="dateAuto(this);" class="w120" title="올바른 날짜를 입력하세요." value="${param.q_enDate}" maxlength="10"/>
            </fieldset>
        </div>
        <!-- //검색일자-->
        </div>
        <op:pagerParam title="회원정보조회이력 목록" />
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="20%"/>
                <col width="8%"/>
                <col width="8%"/>
                <col width="12%"/>
                <col width="8%"/>
                <col width="8%"/>
                <col width=""/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>메뉴명</th>
                    <th>ID</th>
                    <th>성명</th>
                    <th>조회일시</th>
                    <th>조회자</th>
                    <th>조회ID</th>
                    <th class="lr_none">조회사유</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td class="tx_l">${_bean.logMenuNm}</td>
                        <td class="tx_l">${_bean.userId}</td>
                        <td class="tx_l">${_bean.userNm}</td>
                        <td>${_bean.accessDt}</td>
                        <td class="tx_l">${_bean.mngrNm}</td>
                        <td class="tx_l">${_bean.mngrId}</td>
                        <td class="tx_l lr_none">
                            <div class="po_rel">
                                <a href="#" onclick="reasonLayer('${index-status.index}'); return false;">${fn:substring(_bean.accessResn,0,18)}<c:if test="${fn:length(_bean.accessResn) > 18}">...</c:if></a>
                                <!-- 변경사유 레이어 -->
                                <div id="mo_why_${index-status.index}" class="mo_why" onclick="reasonLayer('${index-status.index}'); return false;" >
                                    <h5>조회사유</h5>
                                    <pre>${_bean.accessResn}</pre>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager.list}" colspan="8"/>
            </tbody>
        </table>
        <!-- //리스트 -->
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
    </div>
    <!-- //컨텐츠영역 -->
    </form>
</body>
</html>