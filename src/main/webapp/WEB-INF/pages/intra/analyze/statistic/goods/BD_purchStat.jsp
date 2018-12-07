<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<!-- 20161213 타이틀명 변경 (구)서비스별 구매 통계 -->
    <title>서비스별 구매 문의통계</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox, extjs4"/>
<script type='text/javascript'>

    $().ready(function () {
        $("#dataForm").validate({
            rules: {
                q_beginDate : { dateISO: true, date: true },
                q_endDate : { dateISO: true, date: true }
            },
            messages: { 
                q_beginDate : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                  date: "시작날짜가 형식에 맞지 않습니다."},
                q_endDate   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
                                  date: "종료날짜가 형식에 맞지 않습니다."}
            },
            submitHandler : function(form) {
//                 if (! $("#q_beginDate").dateValidator()) {
//                     alert("시작날짜가 형식에 맞지 않습니다.");
//                     return false;
//                 }
//                 if (! $("#q_endDate").dateValidator()) {
//                     alert("시작날짜가 형식에 맞지 않습니다.");
//                     return false;
//                 }
                  
                if ($("#q_beginDate").val()=='' &&  $("#q_endDate").val()!='') {
                    alert("시작날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate").val()!='' &&  $("#q_endDate").val()=='') {
                    alert("종료날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate").val() > $("#q_endDate").val()) {
                    alert("종료날짜가 시작날짜 보다 작습니다.");
                    return false;
                }           
                form.submit();
            }
        });
        
//          $( "#q_endDate" ).rules( "add", {
//              dateISO: true,
            
//             messages: {
//                 dateISO: "날짜equired input"
//             }
//           });

        //최초에 값이 존재 하는지 찾는다.. 없으면 패스!!
//         <c:if test="${not empty param.q_goodsTyCd}">
//             jsCtgryList(1,null);
//         </c:if> 

//         $("input[name=chk-all]").click(function() {
//             var isChecked = this.checked;
//             $("input[name=goodsCodes]").each(function() {
//                 this.checked = isChecked;
//             });
//         });
                
//         $("#langCodes").click(function(){
//             if($(this).is(":checked")){
//                 $('input[name="q_langCodes"]:checked').each(function (i) {
//                     $(this).attr("checked",false);
//                 });
//             } 
//         });
//         $('input[name="q_langCodes"]').click(function(){
//             $("#langCodes").attr("checked",false);
//         });       
        
        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            // 기간,발표일 달력 생성
            if($('#q_beginDate').val() == ''){
                var beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth() - 1);
                $('#q_beginDate').val(getDateStr(getCalDate(new Date(),-1,0)));
            }
            if($('#q_endDate').val() == ''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
        }

        $("span#registPeriod  a  button.gray").click(function(){
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;
            
            if ($("#q_endDate").val()==''){
                $('#q_endDate').val(getDateStr(new Date()));                     
            }
            if (! $("#q_endDate").dateValidator()) {
                alert("종료날짜가 형식에 맞지 않습니다.");
                return false;
            }
            switch(sType){
                case '0' :
                    q_beginDate = new Date();
                    $('#q_beginDate').val(getDateStr(q_beginDate));
                    q_endDate = new Date();
                    $('#q_endDate').val(getDateStr(q_endDate));
                    break;
                case '7D':                    
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),0,-7);
                    break;
                case '1M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-1,0);
                    break;
                case '3M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-3,0);
                    break;
                default:
                    $("#q_beginDate").val("2000-01-01");
                    $("#q_endDate").val("2100-12-31");
                    break;
            }
            $('#q_beginDate').val(getDateStr(q_beginDate));
            
//             if($('#q_endDate').val() != "21001231"){
//                 $('#q_endDate').val(getDateStr(q_endDate));
//             }
//             if($('#q_beginDate').val() == ''){
//                 $('#q_beginDate').val(getDateStr(new Date()));
//             }
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        
        $("#q_beginDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
        $("#q_endDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
    });//ready end
    
    var getCalDate = function(date, months, days){
        var newDate = date;
        if(typeof(date.getDate) != 'function'){
            newDate = new Date();
        }
    
        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);
    
        return newDate;
    
    };
    
    var getDateStr = function(date){
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl){
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };
    
//     var jsMovePage = function(page){
//         var p = 1;
//         if(page == 'page'){
//             p = $('input[name=page]').val();
//         }else{
//             p = page;
//         }
//         $("#dataForm input[name=q_currPage]").val(p);
//         $("#dataForm").submit();
//     };
    
    var jsSearch = function(){
      document.dataForm.elements["q_init"].value = "0";
      $("#dataForm").attr("action", "BD_purchStat.do");
      $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_langCodes").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
    };
    
    var reportAction = function(){
        var q_langCodes = "L"+"${param.q_langCodes}";
        var q_beginDate = "${param.q_beginDate}";
        var q_endDate = "${param.q_endDate}";
        
        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            q_beginDate = $("#q_beginDate").val();
            q_endDate = $("#q_endDate").val();
        }
        
        var open = "/report/reporting.jsp?reportSection=1002&q_langCodes="+q_langCodes+"&q_beginDate="+q_beginDate+"&q_endDate="+q_endDate;
        window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
    };
    
    </script>
</head>
<body>

<div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_purchStat.do">
            <input type="hidden" name="q_excel" id="q_excel" value="" />
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}" />
            
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>사이트 구분</th>
                                <td>
                                    <select class="w120" id="q_langCodes" name="q_langCodes" title="사이트구분">
                                        <option value="">전체</option>
                                        <c:forEach items="${codeList}" var="_bean" varStatus="status">
                                        <option value="${_bean.langCode}" <c:if test="${_bean.langCode == param.q_langCodes}">selected</c:if>>${_bean.langNm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>구매기간</th>
                                <td >
                                    <input class="w120" type="text" name="q_beginDate" id="q_beginDate" title="시작날짜선택" maxlength="10"<c:if test="${not empty param.q_beginDate}"> value="${param.q_beginDate}"</c:if>/> ~
                                    <input class="w120" type="text" name="q_endDate" id="q_endDate" title="종료날짜선택" maxlength="10"<c:if test="${not empty param.q_endDate}"> value="${param.q_endDate}"</c:if>/>
                                    <span class="mar_l10" id="registPeriod">
                                        <a href="javascript:;"><button type="button" id="0"   class="gray">오늘</button></a>
                                        <a href="javascript:;"><button type="button" id="7D"   class="gray">일주일</button></a>
                                        <a href="javascript:;"><button type="button" id="1M"   class="gray">1개월</button></a>
                                        <a href="javascript:;"><button type="button" id="3M"   class="gray">3개월</button></a>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                    
                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                    
                </fieldset>
            </div>
            
        <!-- //검색 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width=""/>
                <col width="15%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
            </colgroup>
            <thead>
                <tr>      
                    <th rowspan="2">번호</th>
                    <th rowspan="2">서비스명</th>
                    <th rowspan="2">구매수</th>
                    <th colspan="3">회원구분</th>
                </tr>
                <tr>
                    <th>개인</th>
                    <th>기업</th>
                    <th>정부</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="totValue1" value="0"/>
                <c:set var="totValue2" value="0"/>
                <c:set var="totValue3" value="0"/>
                <c:set var="totValue4" value="0"/>
                <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <c:if test="${(not empty grp && grp ne _dataVo.langCode)}">
                    <tr style="color: white; background-color: #999999;">
                        <td colspan="2">${grpNm} 소계</td>
                        <td>
                            <fmt:formatNumber value="${stotValue1}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${stotValue2}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${stotValue3}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${stotValue4}" type="NUMBER" groupingUsed="true"/>
                        </td>
                    </tr>
                    <c:set var="stotValue1" value="0"/>
                    <c:set var="stotValue2" value="0"/>
                    <c:set var="stotValue3" value="0"/>
                    <c:set var="stotValue4" value="0"/>
                    </c:if>
                    <tr>
                        <td>${status.count}</td>
                        <td>
                            ${_dataVo.textValue2}
                        </td>
                        <td>
                            <fmt:formatNumber value="${_dataVo.value1}" type="NUMBER" groupingUsed="true"/>
                            <c:set var="stotValue1" value="${stotValue1 + _dataVo.value1}"/>
                            <c:set var="gtotValue1" value="${gtotValue1 + _dataVo.value1}"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${_dataVo.value2}" type="NUMBER" groupingUsed="true"/>
                            <c:set var="stotValue2" value="${stotValue2 + _dataVo.value2}"/>
                            <c:set var="gtotValue2" value="${gtotValue2 + _dataVo.value2}"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${_dataVo.value3}" type="NUMBER" groupingUsed="true"/>
                            <c:set var="stotValue3" value="${stotValue3 + _dataVo.value3}"/>
                            <c:set var="gtotValue3" value="${gtotValue3 + _dataVo.value3}"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${_dataVo.value4}" type="NUMBER" groupingUsed="true"/>
                            <c:set var="stotValue4" value="${stotValue4 + _dataVo.value4}"/>
                            <c:set var="gtotValue4" value="${gtotValue4 + _dataVo.value4}"/>
                        </td>
                    </tr>
                    <c:if test="${status.last}">
                    <tr style="color: white; background-color: #999999;">
                        <td colspan="2">${_dataVo.langNm} 소계</td>
                        <td>
                            <fmt:formatNumber value="${stotValue1}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${stotValue2}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${stotValue3}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${stotValue4}" type="NUMBER" groupingUsed="true"/>
                        </td>
                    </tr>
                    </c:if>
                    <c:set var="grp" value="${_dataVo.langCode}"/>
                    <c:set var="grpNm" value="${_dataVo.langNm}"/>
                </c:forEach>
                <tr style="color: white; background-color: #999999;">
                    <td colspan="2">총계</td>
                    <td>
                       <fmt:formatNumber value="${gtotValue1}" type="NUMBER" groupingUsed="true"/>
                    </td>
                    <td>
                       <fmt:formatNumber value="${gtotValue2}" type="NUMBER" groupingUsed="true"/>
                    </td>
                    <td>
                       <fmt:formatNumber value="${gtotValue3}" type="NUMBER" groupingUsed="true"/>
                    </td>
                    <td>
                       <fmt:formatNumber value="${gtotValue4}" type="NUMBER" groupingUsed="true"/>
                    </td>
                </tr>
                
            </tbody>
        </table>
         
        <!-- 버튼 -->
        <div class="mar_t10">  
            <div class="float_r">
                 <button class="w_blue" type="button" onclick="reportAction();">리포트 출력</button>
            </div>
<!--             <div class="float_r"> -->
<!--                 <a href="javascript:;" onclick="jsExcelList(this);"><button class="w_blue" type="button">엑셀다운로드</button></a> -->
<!--             </div> -->
        </div>
        <!--  //버튼 -->
    </form>        
    </div>
</body>
</html>