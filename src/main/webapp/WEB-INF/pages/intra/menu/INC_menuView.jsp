<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">
    $().ready(function() {
        if ( $("#menuModiForm") ) {
            $("#menuModiForm").validate({
                rules: {
                    nodeText: { required:true, minlength:2, maxlength:15 }
                }
            });
        }

        $("#menuAddForm").validate({
            rules: {
                newNodeText: { required:true, minlength:2, maxlength:15 }
            }
        });
    });
</script>

<c:set var="exist" value="${!empty dataVo && dataVo.menuCd ne '0'}" />
<c:if test="${exist}">

    <h4>선택한 메뉴 정보</h4>
    <form id="menuModiForm">
    <table class="boardWrite">
        <colgroup>
            <col width="120px" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th>메뉴 코드</th>
                <td class="lr_none">
                    <input type="hidden" name="nodeId" id="nodeId" value="${dataVo.menuCd}" />
                    ${dataVo.menuCd}
                </td>
            </tr>
            <tr>
                <th>메뉴 명<span class="tx_red_s">*</span></th>
                <td class="lr_none">
                    <input type="text" name="nodeText" id="nodeText"
                        value="${dataVo.mngrMenuNm}" maxlength="15" class="text" size="35" title="메뉴명을 입력해주세요"/>
                    <span class="tx_blue_s">(최대 <b>15</b>자)</span>
                </td>
            </tr>
        </tbody>
    </table>

    <br class="blank"/>

    <h4>선택한 메뉴 부가 정보</h4>

    <table class="boardWrite">
        <colgroup>
            <col width="120px" />
            <col width="" />
        </colgroup>
        <tbody>
        <tr>
            <th>메뉴 경로</th>
            <td><span id="nodePath"></span></td>
        </tr>
        <tr>
            <th>정렬 순서</th>
            <td>${dataVo.orderNo}</td>
        </tr>
        <tr>
            <th>메뉴 URL</th>
            <td>
                <input type="text" name="menuUrl" id="menuUrl"
                    value="${dataVo.menuUrl}" maxlength="200" class="text" size="50"/>
                <span class="tx_blue_s">(최대 <b>200</b>자)</span>
                <p class="tx_blue_s">
                    <c:if test="${!empty pageContext.request.contextPath}">
                       컨텍스트 경로(<b>${pageContext.request.contextPath}</b>)를 제외한 나머지 URL을 입력합니다.<br/>
                    </c:if>
                    <span>하위레벨 메뉴가 존재할 경우에는 입력하지 않습니다.</span>
                </p>
            </td>
        </tr>
        <tr>
            <th>컨트롤러명</th>
            <td>
                <input type="text" name="controllerNm" id="controllerNm" value="${dataVo.controllerNm}" maxlength="200" class="text" size="70" /><br/>
                <span class="tx_blue_s"><span class="tx_red_s">메뉴별 권한 설정을 적용</span>하려면 반드시 <span class="tx_red_s">컨트롤러 정보를 입력</span>해야 합니다.</span><br/>
                <span class="tx_blue_s">해당 메뉴의 컨트롤러명을 패키지경로를 포함해서 입력해 주세요.</span>
            </td>
        </tr>
        <tr>
            <th>사용 여부<span class="tx_red_s">*</span></th>
            <td>
                <input type="radio" name="useYn" id="useYn_Y" value="Y" class="radio"
                    <c:if test="${dataVo.useYn == 'Y'}">checked="checked"</c:if> />
                    <label for="useYn_Y">사용</label>
                <input type="radio" name="useYn" id="useYn_N" value="N" class="radio"
                    <c:if test="${dataVo.useYn == 'N'}">checked="checked"</c:if> />
                    <label for="useYn_N">미사용</label>
                <p class="tx_blue_s">미사용 선택 시 서비스 화면에는 표시되지 않습니다.</p>
            </td>
        </tr>
        <tr>
            <th>지정된 권한</th>
            <td>
                <c:choose>
                    <c:when test="${fn:length(dataVo.authNms) != 0}">
                        <c:forEach items="${dataVo.authNms}" var="authNm" varStatus="status">
                            ${authNm}<c:if test="${not status.last }">,</c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <span class="tx_blue_s">지정된 권한이 없습니다.</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>등록일</th>
            <td>${dataVo.regDt}</td>
        </tr>
        <c:if test="${!empty dataVo.modiDt}">
            <tr>
                <th>수정일</th>
                <td>${dataVo.modiDt}</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    </form>

    <div class="tx_r mar_t10 mar_b20">
        <button type="button" class="blue" onclick="jsUpdateAction('#menuModiForm');">수정</button>
        <button type="button" class="blue" onclick="jsDeleteAction();">삭제</button>
    </div>
</c:if>

<h4>메뉴 추가</h4>

<form id="menuAddForm">
<table class="boardWrite">
    <colgroup>
        <col width="120px" />
        <col width=""/>
    </colgroup>
    <tbody>
        <tr>
            <th>메뉴 명<span class="tx_red_s">*</span></th>
            <td><input type="text" name="newNodeText" id="newNodeText" maxlength="15" size="35" class="text"/> <span class="tx_blue_s">(최대 <b>15</b>자)</span>
            </td>
        </tr>
        <tr>
            <th>추가 옵션</th>
            <td>
                <div><input type="radio" name="appendOption" id="isSame" value="isSame"
                    class="radio" <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isSame">선택한 메뉴 동일 레벨에 추가</label></div>

                <div><input type="radio" name="appendOption" id="isChild" value="isChild"
                    class="radio" <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isChild">선택한 메뉴 하위 레벨에 추가</label></div>

                <div><input type="radio" name="appendOption" id="isRoot" value="isRoot"
                    class="radio" checked="checked" /> <label for="isRoot">루트 메뉴에 추가</label></div>
            </td>
        </tr>
    </tbody>
</table>
</form>

<div class="tx_r mar_t10 mar_b20">
    <button type="button" class="w_blue" onclick="jsInsertAction('#menuAddForm');">추가</button>
</div>
