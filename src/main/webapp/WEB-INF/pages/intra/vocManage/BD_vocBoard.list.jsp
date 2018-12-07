<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>VOC 목록</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<%-- <op:jsTag type="spi" items="validate,ui,form"/> --%>
</head>
<script type="text/javascript">
/**
 * 목록 삭제
 */
var vocDeleteList = function(){
    alert("목록 삭제 이벤트 발생");
};

/**
 * voc 등록
 */
vocInsertForm1 = function(){
    alert("등록 이벤트 발생");
    //document.vocInsertForm.submit();
};
</script>
<body>
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_vocBoard.list.do">
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                            <colgroup>
                                <col width="10%" />
			                    <col width="35%" />
			                    <col width="10%" />
			                    <col width="*%" />
                            </colgroup>
                            <tbody>
                           		<tr>
	                        		<th>회원구분</th>
	                        		<td>
				                        <select id="q_member_at" name="q_member_at" title="회원 구분을 선택해주세요" class="over">
											<option value="">전체</option>
											<option value="">Y</option>
											<option value="">N</option>
										</select>
				                    </td>
	                        		<th>고객명</th>
	                        		<td >
			                        	<input class="w215" type="text" value="${param.q_user_nm}" id="q_user_nm" name="q_user_nm" title="검색어를 입력하세요."/>
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th>기관분류</th>
	                        		<td>
				                        <select id="q_instt_ty_nm" name="q_instt_ty_nm" title="기관 유형을 선택해주세요" class="over">
											<option value="">전체</option>
											<option value="">공공기관</option>
											<option value="">중앙행정기관</option>
											<option value="">지자체</option>
											<option value="">제공기업</option>
											<option value="">기타</option>
										</select>
				                    </td>
	                        		<th>소속</th>
	                        		<td>
			                        	<input class="w215" type="text" value="${param.q_pstinst_nm}" id="q_pstinst_nm" name="q_pstinst_nm" title="소속을 입력하세요."/>
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th>VOC 종류</th>
	                        		<td>
				                        <select id="q_instt_ty_nm" name="q_instt_ty_nm" title="VOC 종류를 선택해주세요" class="over">
											<option value="">전체</option>
											<option value="">회원가입</option>
											<option value="">회원탈퇴</option>
											<option value="">협약체결</option>
											<option value="">서비스등록/수정</option>
											<option value="">서비스문의</option>
											<option value="">기타</option>
										</select>
				                    </td>
	                        		<th>처리상태</th>
	                        		<td>
				                        <select id="q_voc_progress_sttus" name="q_voc_progress_sttus" title="기관 유형을 선택해주세요" class="over">
											<option value="">전체</option>
											<option value="">접수</option>
											<option value="">처리중</option>
											<option value="">처리완료</option>
										</select>
				                    </td>
	                        	</tr>
	                        	<tr>
	                        		<th>조회기간</th>
	                        		<td colspan="3">
								        <input type='text' id='startDate' name='startDate' class='w120' value='<c:out value='${searchVo.startDateFmt}'/>' title='시작일'/>
								        ~ 
								        <input type='text' id='endDate' name='endDate' class='w120' value='<c:out value='${searchVo.endDateFmt}'/>' title='날짜선택'/>
								        <button class='gray mar_l5 mar_b5' onclick='search();'>검색</button>
								        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								        <button id="d-0" class='s_blue mar_l5 mar_b5'>당일</button>
								        <button id="d-7" class='s_blue mar_l5 mar_b5'>7일</button>
								        <button id="m-1" class='s_blue mar_l5 mar_b5'>1개월</button>
								        <button id="m-3" class='s_blue mar_l5 mar_b5'>3개월</button>
	                        		</td>
	                        	</tr>
                            </tbody>
                        </table>
                      <div>
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                      </div>
                </fieldset>
               
            </div>
            
            <br /></br>
            <%-- <op:pagerParam title="계약목록" /> --%>
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        <div class="float_r">
            <!-- <a href="javascript:;" onclick="vocInsertForm1();"><button class="w_blue" type="button">등록1</button></a> -->
            <a href="javascript:;" onclick="javascript:aaa();"><button class="w_blue" type="button">등록1</button></a>
        </div>
        <br /><br />
        
        <!-- 목록 삽입. -->
        <%@include file="INC_vocBoard.list.jsp" %>
        
        <br />
        <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'}">
        	<div class="float_l">
                <button class="blue" type="button" onclick="vocDeleteList();">선택항목삭제1</button>
            </div>
            <div class="float_r">
	            <a href="javascript:;" onclick="jsExcelList(this);"><button class="w_blue" type="button">엑셀다운로드</button></a>
	        </div>
        </c:if>
    </div>
    <form name="vocInsertForm" id="vocInsertForm" method="get" action="BD_vocBoard.form.do">
		<input type="hidden" name="testvalue1" id="testvalue1" value="testvalue1" />
	</form>
</body>

<script type="text/javascript">

aaa = function() {
  alert("aaa함수입니다.");  
};
           
    $().ready(function () {
        $("input[name=chk-all]").click(function() {
            var isChecked = this.checked;
            $("input[name=cntrctSns]").each(function() {
                this.checked = isChecked;
            });
        });
        
        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
                
    });//ready end

    var jsSearch = function(){
        document.dataForm.action = "BD_cntrctManageList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };
    
    var jsExcelList = function() {
        $("#q_excel").val("2");
        location.href = "INC_cntrctExcel.do?" + $("#dataForm").serialize();
        $("#q_excel").val("");
    };
    
//]]>
</script>
</html>