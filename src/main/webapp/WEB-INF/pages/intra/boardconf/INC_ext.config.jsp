<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
    var confTabz;

    $().ready(function(){
        $("#extensionConfigForm").submit(function(){
            dataString = $("#extensionConfigForm").serialize();
            $.ajax({
                type: "POST",
                url: "ND_boardconf.ext.update.do",
                data: dataString,
                dataType: "json",
                success: function(response){
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.processOk);
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        // 시스템 오류 발생시 처리 구간
                        jsSysErrorBox(response, e);
                        return;
                    }
                    changeFlag = false;
                    jsReloadTab();
                }
            });
            return false;
        });
    });
</script>

<!-- 캡션 영역 시작 -->
<div class="bbs-caption">
    <div class="caption-right"> 
        <span id="authResult" class="result"></span>
    </div>
</div>
<!-- 캡션 영역 끝 -->

<form id="extensionConfigForm" method="post" action="ND_boardconf.ext.update.do">

    <input type="hidden" name="domainCd" value="${param.domainCd}" />
    <input type="hidden" name="bbsCd" value="${param.bbsCd}" />

    <!-- 컬럼 목록 상세보기 시작 -->
    <fieldset>  
        <legend>컬럼설정</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="컬럼설정 정보를 표시" >
            <caption>컬럼설정</caption>
            <colgroup>
                <col width="10%" />
                <col width="15%" />
                <col />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>컬럼</th>
                    <th>명칭</th>
                    <th>설명</th>
                    <th>입력유형</th>
                    <th>검색</th>
                    <th>검색유형</th>
                    <th>필수</th>
                    <th>사용</th>
                </tr>
                <c:forEach items="${dataList}" var="extensionVo">
                    <tr>
                        <td class="tl">
                            ${extensionVo.columnId}
                            <input type="hidden" id="columnId" name="columnId" value="${extensionVo.columnId}" />
                        </td>
                        <td class="tl">
                            <input type="text" id="columnNm" name="${extensionVo.columnId}_columnNm" value="${extensionVo.columnNm}" class="w120" onchange="jsChkValueChange('text', '${extensionVo.columnId}_columnNm', '${extensionVo.columnNm}');" />
                            <valid:msg name="columnNm" />
                        </td>
                        <td class="tl">
                            <input type="text" id="columnCm" name="${extensionVo.columnId}_columnCm" value="${extensionVo.columnCm}" class="w180" onchange="jsChkValueChange('text', '${extensionVo.columnId}_columnCm', '${extensionVo.columnCm}');" />
                        </td>
                        <td>
                            <select id="columnTy" name="${extensionVo.columnId}_columnTy" onchange="jsChkValueChange('select', '${extensionVo.columnId}_columnTy', '${extensionVo.columnTy}');">
                                <option value="" selected="selected"></option>
                                <option value="TEXT"<c:if test="${extensionVo.columnTy eq 'TEXT'}"> selected="selected"</c:if>>한줄</option>
                                <option value="TEXTAREA"<c:if test="${extensionVo.columnTy eq 'TEXTAREA'}"> selected="selected"</c:if>>여러줄</option>
                                <option value="EMAIL"<c:if test="${extensionVo.columnTy eq 'EMAIL'}"> selected="selected"</c:if>>이메일</option>
                                <option value="DATE"<c:if test="${extensionVo.columnTy eq 'DATE'}"> selected="selected"</c:if>>날짜</option>
                            </select>
                        </td>
                        <td>
                            <select id="searchCndYn" name="${extensionVo.columnId}_searchCndYn" onchange="jsChkValueChange('select', '${extensionVo.columnId}_searchCndYn', '${extensionVo.searchCndYn}');">
                                <option value="Y"<c:if test="${extensionVo.searchCndYn eq 'Y' or empty extensionVo.searchCndYn}"> selected="selected"</c:if>>예</option>
                                <option value="N"<c:if test="${extensionVo.searchCndYn eq 'N'}"> selected="selected"</c:if>>아니오</option>
                            </select>
                        </td>
                        <td>
                            <select id="searchTy" name="${extensionVo.columnId}_searchTy" onchange="jsChkValueChange('select', '${extensionVo.columnId}_searchTy', '${extensionVo.searchTy}');">
                                <option value=""></option>
                                <c:forEach items="${dataVo}" var="searchTy">
                                    <option value="${searchTy.code}"<c:if test="${searchTy.code eq extensionVo.searchTy}"> selected="selected"</c:if>>${searchTy.codeNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <select id="essntlYn" name="${extensionVo.columnId}_essntlYn" onchange="jsChkValueChange('select', '${extensionVo.columnId}_essntlYn', '${extensionVo.essntlYn}');">
                                <option value="Y"<c:if test="${extensionVo.essntlYn eq 'Y' or empty extensionVo.essntlYn}"> selected="selected"</c:if>>예</option>
                                <option value="N"<c:if test="${extensionVo.essntlYn eq 'N'}"> selected="selected"</c:if>>아니오</option>
                            </select>
                        </td>
                        <td>
                            <select id="useYn" name="${extensionVo.columnId}_useYn" onchange="jsChkValueChange('select', '${extensionVo.columnId}_useYn', '${extensionVo.useYn}');">
                                <option value="Y"<c:if test="${extensionVo.useYn eq 'Y' or empty extensionVo.useYn}"> selected="selected"</c:if>>예</option>
                                <option value="N"<c:if test="${extensionVo.useYn eq 'N'}"> selected="selected"</c:if>>아니오</option>
                            </select>
                        </td>
                    </tr>
               </c:forEach>
            </tbody>
        </table>
    </fieldset>
    <!-- 게시판 목록 상세보기 끝 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="submit" id="btnSubmit" value="저장" class="w_blue mar_r5" /></li>
            <li><input type="reset" id="btnCancel" value="취소" class="w_blue mar_r5" /></li>
            <li><input type="button" id="btnList" value="목록" class="blue" onclick="jsList();" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

</form>
