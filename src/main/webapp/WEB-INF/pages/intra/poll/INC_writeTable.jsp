<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

    <form name="dataForm" id="dataForm" action="<c:url value="ND_pollUpdateAction.do" />" method="post">

        <%-- 페이징 관련 파라미터 생성.  --%>
        <op:pagerParam view="view" />
        
        <!-- 기본 조건 항목 -->
        <input type="hidden" name="seq" value='${dataVo.seq}' />

        <h4 class="tx_13">기본 정보</h4>

        <table class="boardWrite" width="100%" border="0" cellspacing="0" cellpadding="0" summary="기본 정보">
            <caption class="title">기본 정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>

            <tr>
                <th>등록부서</th>
                <td>${dataVo.deptNm}</td>
                <th>등록자</th>
                <td>${dataVo.regNm}</td>
            </tr>

            <tr>
                <th>설문상태<span class="tx_red tx_b">*</span></th>
                <td>
                    <select name="state" id="state" class="select"  title="선택">
                        <option value="N" <c:if test="${dataVo.state eq 'N'}">selected='selected'</c:if>>정상</option>
                        <option value="S" <c:if test="${dataVo.state eq 'S'}">selected='selected'</c:if>>중지</option>
                    </select>
                </td>
                <th>적용도메인<span class="tx_red tx_b">*</span></th>
                <td>
                    <select id="domainCd" name="domainCd" class="select" title="선택">
                        <option value="">-- 도메인 선택 --</option>
                        <c:forEach items="${domainList}" var="domain">
                        <option value="${domain.domainCd}" <c:if test="${domain.domainCd eq dataVo.domainCd}">selected='selected'</c:if>>${domain.domainNm}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <th>제목<span class="tx_red tx_b">*</span></th>
                <td colspan="3">
                    <input type="text" id="title" name="title" value='${dataVo.title}' maxlength="100" class="w85_p" />
                </td>
            </tr>

            <tr>
                <th>목적<span class="tx_red tx_b">*</span></th>
                <td colspan="3">
                    <textarea name="purpose" id="purpose" rows="5" cols="30" class="w99_p">${dataVo.purpose}</textarea>
                 </td>
            </tr>

            <tr>
                <th>설문조사일<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="text" name="startTime" id="startTime" value="${dataVo.startTime}" class="w80" /> ~ 
                    <input type="text" name="endTime" id="endTime" value="${dataVo.endTime}" class="w80" />
                </td>
                <th>중복참여제한<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="text" id="limitCnt" name="limitCnt" class="w15" value='<c:out value="${dataVo.limitCnt}" default="1"/>' maxlength="5" />
                    <span class="tx_blue_s">'0' 설정시 제한이 없습니다.</span>
                </td>
            </tr>

            <tr>
                <th>중복차단여부<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="radio" class="radio" name="dupYn" id="dupYnY" value="Y" <c:if test="${dataVo.dupYn eq 'Y'}">checked='checked'</c:if> />&nbsp;<label for="dupYnY">차단</label>
                    <input type="radio" class="radio" name="dupYn" id="dupYnN" value="N" <c:if test="${dataVo.dupYn eq 'N'}">checked='checked'</c:if> />&nbsp;<label for="dupYnN">허용</label>
                </td>
                <th>중복차단 방법</th>
                <td>
                    <input type="radio" class="radio" name="dupCheck" id="dupCheckU" value="U" <c:if test="${dataVo.dupCheck eq 'U'}">checked='checked'</c:if> />&nbsp;<label for="dupCheckU">회원전용</label>
                    <input type="radio" class="radio" name="dupCheck" id="dupCheckI" value="I" <c:if test="${dataVo.dupCheck eq 'I'}">checked='checked'</c:if> />&nbsp;<label for="dupCheckI">IP 확인</label>
                    <input type="radio" class="radio" name="dupCheck" id="dupCheckC" value="C" <c:if test="${dataVo.dupCheck eq 'C'}">checked='checked'</c:if> />&nbsp;<label for="dupCheckC">Cookie 확인</label>
                </td>
            </tr>

            <tr>
                <th>공개여부<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="radio" class="radio" name="openYn" id="openYnY" value="Y" <c:if test="${dataVo.openYn eq 'Y'}">checked='checked'</c:if> />&nbsp;<label for="openYnY">공개</label>
                    <input type="radio" class="radio" name="openYn" id="openYnN" value="N" <c:if test="${dataVo.openYn eq 'N' or empty dataVo.openYn}">checked='checked'</c:if> />&nbsp;<label for="openYnN">미공개</label>
                    <p class="tx_blue_s">설문 작성이 완료된 후 공개로 변경.</p>
                </td>
                <th>베너여부</th>
                <td>
                    <input type="radio" class="radio" name="bannerYn" id="bannerYnN" value="N" <c:if test="${dataVo.bannerYn eq 'N'}">checked="checked"</c:if> />&nbsp;<label for="bannerYnN">설문</label>
                    <input type="radio" class="radio" name="bannerYn" id="bannerYnY" value="Y" <c:if test="${dataVo.bannerYn eq 'Y'}">checked="checked"</c:if> />&nbsp;<label for="bannerYnY">설문 + 베너</label>
                    <p class="tx_blue_s">(메인 페이지 베너 기능이 있을 시)</p>
                </td>
            </tr>
            
        </tbody>
    </table>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="submit" class="w_blue">수정</button></li>
            <li><button type="button" class="w_blue" onclick="jsPollDelete();">삭제</button></li>
            <li><button type="button" class="blue" onclick="jsPollList();">목록</button></li>
        </ul>
    </div>
    <!-- //버튼 -->

    </form>