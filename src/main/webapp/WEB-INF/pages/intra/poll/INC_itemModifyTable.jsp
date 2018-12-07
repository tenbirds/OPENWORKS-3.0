<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

    <h4 class="tx_13">등록된 설문 항목</h4>

    <table class="boardWrite" width="100%" border="0" cellspacing="0" cellpadding="0" summary="등록된 설문 항목">
        <caption class="title">등록된 설문 항목</caption>
        <tbody>
            <tr>
                <td>

                    <c:if test="${not empty dataList}">

                        <c:set value="0" var="preGroupSeq" />
                        <c:set value="0" var="groupIndex" />
                        <c:forEach items="${dataList}" var="pollGroupBean" varStatus="status">

                            <c:if test="${pollGroupBean.groupSeq ne preGroupSeq && preGroupSeq ne 0}" >

                                    </tbody>
                                </table>
                                </form>
                            </c:if>

                            <c:if test="${pollGroupBean.groupSeq ne preGroupSeq}" >
                                <c:set value="${pollGroupBean.groupSeq}" var="preGroupSeq" />
                                <c:set value="${groupIndex + 1}" var="groupIndex" />

                                <form name="pollGroup_${pollGroupBean.groupSeq}" id="pollGroup_${pollGroupBean.groupSeq}"
                                    method="post" action="ND_pollGroupUpdateAction.do" class="pollGroupForm">
                                    <input type="hidden" name="seq" value="${pollGroupBean.seq}" />
                                    <input type="hidden" name="groupSeq" value="${pollGroupBean.groupSeq}" />

                                <table class="boardView" width="100%" cellspacing="0" cellpadding="0" summary="${pollGroupBean.groupSeq} 번째 설문그룹">
                                    <caption class="title">${pollGroupBean.groupSeq} 번째 설문그룹</caption>
                                    <tbody>
                                    <!-- 설문 그룹 제목 -->
                                    <tr>
                                        <th>
                                            <strong>그룹 ${groupIndex}.</strong>
                                            <input type="text" name="groupTitle" id="pollGroup_${pollGroupBean.groupSeq}_groupTitle" class="w_50p"
                                                value='${pollGroupBean.groupTitle}' maxlength="400" />

                                            <button type="submit" class="s_blue">그룹수정</button>
                                            <button type="button" class="s_blue" onclick="jsPollGroupDelete('${pollGroupBean.seq}', '${pollGroupBean.groupSeq}');">그룹삭제</button>

                                            <c:if test="${pollGroupBean.type eq 'I'}">
                                                <input type="hidden" name="items" id="pollGroup_${pollGroupBean.groupSeq}_items" 
                                                    value="${pollGroupBean.groupTitle}" />
                                                <input type="hidden" name="multiChoiceCnt" id="pollGroup_${pollGroupBean.groupSeq}_multiChoiceCnt" 
                                                    value="${pollGroupBean.multiChoiceCnt}" />
                                                <input type="hidden" name="commentUseYn" id="pollGroup_${pollGroupBean.groupSeq}_commentUseYn" 
                                                    value="${pollGroupBean.commentUseYn}" />
                                            </c:if>

                                        </th>
                                    </tr>
                                <c:if test="${pollGroupBean.type ne 'I'}">
                                    <tr>
                                        <td style="padding-left:30px;">
                                            [복수선택수]: 
                                            <input type="text" name="multiChoiceCnt" id="pollGroup_${pollGroupBean.groupSeq}_multiChoiceCnt" 
                                                value='${pollGroupBean.multiChoiceCnt}' maxlength="2" class="w15"/>
                                            [의견글사용여부]:
                                            <input type="radio" class="radio" name="commentUseYn" 
                                                id="pollGroup_${pollGroupBean.groupSeq}_commentUseYnY" value="Y"
                                                <c:if test="${pollGroupBean.commentUseYn eq 'Y'}"> checked="checked"</c:if>
                                                    />&nbsp;<label for="dupYnY">사용</label>
                                            <input type="radio" class="radio" name="commentUseYn" 
                                                id="pollGroup_${pollGroupBean.groupSeq}_commentUseYnN" value="N"
                                                <c:if test="${pollGroupBean.commentUseYn eq 'N'}"> checked="checked"</c:if>
                                                    />&nbsp;<label for="dupYnN">미사용</label>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:if>
                            <c:if test="${pollGroupBean.type ne 'I' and pollGroupBean.etcYn ne 'Y'}">
                                    <tr>
                                        <td style="padding-left:30px;">항목
                                            ${pollGroupBean.itemSeq}.
                                            <input type="text" name="items"
                                                id="pollGroup_${pollGroupBean.groupSeq}_${pollGroupBean.itemSeq}" value="${pollGroupBean.item}" 
                                                    class="w_50p" maxlength="100" />
                                        </td>
                                    </tr>
                            </c:if>
                        </c:forEach>

                                    </tbody>
                                </table>
                                </form>

                    </c:if>
                        
                    <c:if test="${empty dataList}">

                        <span class="tx-alert">데이타가 존재하지 않습니다.</span>

                    </c:if>

                </td>
            </tr>

        </tbody>
    </table>

    <!-- 설문 항목 목록  끝 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="blue" onclick="jsPollList();">목록</button></li>
        </ul>
    </div>
    <!-- //버튼 -->
