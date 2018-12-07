<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>회원관리</title>
<op:jsTag type="spi" items="colorbox" />
<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
<script type="text/javascript">

    $().ready(function() {
        $("#buttonS").show();
        $("#buttonC").hide();
    });

    var check = function(el, gubun){
        
        if(gubun == 'C'){
            paramVal = $("#paramVal").val()+"∬menuType1="+'C';
        }else{//if(gubun == 'S')
            var checkbox1 = '';
//             var checkbox2 = '';
//             var checkbox3 = '';
    
            var checked1 = jsCheckedArray1();
            checkbox1 = $.makeArray(checked1);
//             var checked2 = jsCheckedArray2();
//             checkbox2 = $.makeArray(checked2);
    
//             $("body input[name=checkbox3]:checked").each(function (i) {
//                 checkbox3 = $(this).val();
//             });
//             paramVal = $("#paramVal").val()+"∬checkbox1="+checkbox1+"∬checkbox2="+checkbox2+"∬checkbox3="+checkbox3+"∬menuType1=S";
            paramVal = $("#paramVal").val()+"∬checkbox1="+checkbox1+"∬menuType1=S";
        }

        pwdConfirm(el, '회원 정보 엑셀 출력', 'O', '/intra/user/INC_userListExcel.do', '', '', '', '', paramVal, '리스트', '');

    };
    
    var listCheckYn="N";
    var listCheck = function(){
        if(listCheckYn == 'N'){
            $("#buttonC").show();
            $("#buttonS").hide();
            $("body input[name=checkbox1]").attr("disabled", true);
//             $("body input[name=checkbox2]").attr("disabled", true);
//             $("body input[name=checkbox3]").attr("disabled", true);
            listCheckYn="Y";
        }else{
            $("#buttonS").show();
            $("#buttonC").hide();
            $("body input[name=checkbox1]").attr("disabled", false);
//             $("body input[name=checkbox2]").attr("disabled", false);
//             $("body input[name=checkbox3]").attr("disabled", false);
            listCheckYn="N";
        }
    };

    //체크된 목록을 가져온다.
    var jsCheckedArray1 = function() {
        var checked1 = new Array();
        $("body input[name=checkbox1]:checked").each(function (i) {
            checked1[i] = $(this).val();
        });
        return checked1;
    };
//     var jsCheckedArray2 = function() {
//         var checked2 = new Array();
//         $("body input[name=checkbox2]:checked").each(function (i) {
//             checked2[i] = $(this).val();
//         });
//         return checked2;
//     };
    
    var userList = function(){
        parent.$.fn.colorbox.close();
        parent.location.href = "BD_index.do?pwdYn="+"Y";        
    };
</script>
<style type="text/css">
    .list_al li {display: list-item;}
</style>
</head>
<body>
    <form id="Form">
    <!-- 컨텐츠영역 -->
        <input type="hidden" id="checkedCheckbox1" name="checkedCheckbox1" value=""/>
        <input type="hidden" id="checkedCheckbox2" name="checkedCheckbox2" value=""/>
        <input type="hidden" id="checkedCheckbox3" name="checkedCheckbox3" value=""/>
        <input type="hidden" id="paramVal" name="paramVal" value="${param.paramVal}"/>
        <div id="popup">
            <div class="pop_tit">
                <h1>엑셀 출력 항목 선택</h1>
            </div>
            <ul class="blet">
                <li>회원의 개인정보 중 엑셀로 출력할 항목을 선택합니다. 출력된 엑셀문서에 대해 보안 및 관리를 철저히 하시기 바랍니다.</li>
                <li><span class="tx_red">엑셀출력물에 대해 암호저장</span>을 하여 관리하고, 사용 후에는 바로 <span class="tx_red">폐기</span>하여야합니다.</li>
            </ul>
            <!-- 항목선택 -->
            <fieldset>
            <legend>항목선택</legend>
                <h2 class="mar_t20">검색결과 리스트</h2>
                <ul class="blue_box_tx list_al">
                    <li>
                        <input type="checkbox" id="ckb1" onclick="listCheck()" /><label for="ckb1">리스트 </label>
                        <label for="checkbox">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <!-- <span class="tx_red"> *&nbsp;검색결과 리스트 선택 시 다른 항목은 선택하실 수 없습니다.</span> -->
                        </label>
                    </li>
                </ul>
                <%-- 
                <h2 class="mar_t20">기본정보항목</h2>
                <ul class="blue_box_tx list_al">
                    <li><input type="checkbox" id="ckb2" name="checkbox1" value="1002"/><label for="ckb2">아이디</label></li>
                    <li><input type="checkbox" id="ckb3" name="checkbox1" value="1003"/><label for="ckb3">성명</label></li>
                    <li><input type="checkbox" id="ckb4" name="checkbox1" value="1004"/><label for="ckb4">언어코드</label></li>
                    <li><input type="checkbox" id="ckb5" name="checkbox1" value="1005"/><label for="ckb5">국가코드</label></li>
                    <li><input type="checkbox" id="ckb6" name="checkbox1" value="1006"/><label for="ckb6">이메일</label></li>
                    <li><input type="checkbox" id="ckb7" name="checkbox1" value="1007"/><label for="ckb7">가입유형코드</label></li>
                    <li><input type="checkbox" id="ckb8" name="checkbox1" value="1008"/><label for="ckb8">국제전화번호</label></li>
                    <li><input type="checkbox" id="ckb9" name="checkbox1" value="1009"/><label for="ckb9">전화번호</label></li>
                    <li><input type="checkbox" id="ckb10" name="checkbox1" value="1010"/><label for="ckb10">우편번호</label></li>
                    <li><input type="checkbox" id="ckb11" name="checkbox1" value="1011"/><label for="ckb11">기본주소</label></li>
                    <li><input type="checkbox" id="ckb12" name="checkbox1" value="1012"/><label for="ckb12">상세주소</label></li>
                    <li><input type="checkbox" id="ckb13" name="checkbox1" value="1013"/><label for="ckb13">등록일시</label></li>
                    <li><input type="checkbox" id="ckb14" name="checkbox1" value="1014"/><label for="ckb14">수정일시</label></li>
                    <li><input type="checkbox" id="ckb15" name="checkbox1" value="1015"/><label for="ckb15">최근로그인일시</label></li>
                    <li><input type="checkbox" id="ckb16" name="checkbox1" value="1016"/><label for="ckb16">로그인횟수</label></li>
                    <li><input type="checkbox" id="ckb17" name="checkbox1" value="1017"/><label for="ckb17">사용자유형코드</label></li>
                    <li><input type="checkbox" id="ckb18" name="checkbox1" value="1018"/><label for="ckb18">사용자등급코드</label></li>
                    <li><input type="checkbox" id="ckb19" name="checkbox1" value="1019"/><label for="ckb19">사용자상태코드</label></li>
                    <li><input type="checkbox" id="ckb20" name="checkbox1" value="1020"/><label for="ckb20">비밀번호수정일자</label></li>
                    <c:if test="${dataVo.mbtlnum == 1001 || dataVo.mbtlnum == 1003}">
                        <li><input type="checkbox" id="ckb21" name="checkbox1" value="1021"/><label for="ckb21">휴대전화번호</label></li>
                    </c:if>
                    <c:if test="${dataVo.brthdy == 1001 || dataVo.brthdy == 1003}">
                        <li><input type="checkbox" id="ckb22" name="checkbox1" value="1022"/><label for="ckb22">생년월일</label></li>
                    </c:if>
                    <c:if test="${dataVo.sexdstnCd == 1001 || dataVo.sexdstnCd == 1003}">
                        <li><input type="checkbox" id="ckb23" name="checkbox1" value="1023"/><label for="ckb23">성별</label></li>
                    </c:if>
                </ul>
                <h2 class="mar_t20">추가정보항목</h2>
                <ul class="blue_box_tx list_al">
                    <c:if test="${dataVo.smsRecptnAgreCd == 1001 || dataVo.smsRecptnAgreCd == 1003}">
                        <li><input type="checkbox" id="ckb25" name="checkbox1" value="1025"/><label for="ckb25">개인회원 SMS수신여부</label></li>
                    </c:if>
                    <c:if test="${dataVo.emailRecptnAgreCd == mobileUS || dataVo.emailRecptnAgreCd == mobileUS}">
                        <li><input type="checkbox" id="ckb26" name="checkbox1" value="1026"/><label for="ckb26">이메일수신여부</label></li>
                    </c:if>
                    <c:if test="${dataVo.cmpnyNm == 1001 || dataVo.cmpnyNm == 1003}">
                    	<li><input type="checkbox" id="ckb27" name="checkbox1" value="1027"/><label for="ckb27">회사명</label></li>
                    </c:if>
                    <c:if test="${dataVo.cmpnyZip == 1001 || dataVo.cmpnyZip == 1003}">
                    	<li><input type="checkbox" id="ckb28" name="checkbox1" value="1028"/><label for="ckb28">회사우편번호</label></li>
                    </c:if>
                    <c:if test="${dataVo.cmpnyBassAdres == 1001 || dataVo.cmpnyBassAdres == 1003}">
                        <li><input type="checkbox" id="ckb29" name="checkbox1" value="1029"/><label for="ckb29">회사기본주소</label></li>
                    </c:if>
                    <c:if test="${dataVo.cmpnyDetailAdres == 1001 || dataVo.cmpnyDetailAdres == 1003}">
                        <li><input type="checkbox" id="ckb30" name="checkbox1" value="1030"/><label for="ckb30">회사기본주소</label></li>
                    </c:if>
                    <c:if test="${dataVo.cmpnyTelno == 1001 || dataVo.cmpnyTelno == 1003}">
                        <li><input type="checkbox" id="ckb31" name="checkbox1" value="1031"/><label for="ckb31">회사전화번호</label></li>
                    </c:if>
                    <c:if test="${dataVo.cmpnyRprsntvNm == 1001 || dataVo.cmpnyRprsntvNm == 1003}">
                        <li><input type="checkbox" id="ckb32" name="checkbox1" value="1032"/><label for="ckb32">회사대표자이름</label></li>
                    </c:if>
                    <c:if test="${dataVo2.faxRecptnAgreCd == 1001 || dataVo2.faxRecptnAgreCd == 1003}">
                        <li><input type="checkbox" id="ckb33" name="checkbox1" value="1033"/><label for="ckb33">기업회원 FAX수신여부</label></li>
                    </c:if>
                </ul>
                 --%>
            </fieldset>
            
            <!-- //항목선택 -->
            <p class="tx_c mar_t20">
            <a href="#"><button type="button" id="buttonC" onclick="check(this, 'C');" class="blue">확인</button></a> 
            <a href="#"><button type="button" id="buttonS" onclick="check(this, 'S');" class="blue">확인</button></a> 
            <a href="#"><button type="button" onclick="userList();" class="blue">취소</button></a></p>
        </div>
    <!-- //컨텐츠영역 -->
    </form>
</body>
</html>