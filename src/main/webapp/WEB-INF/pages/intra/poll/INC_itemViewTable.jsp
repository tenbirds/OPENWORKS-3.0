<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <div id="colorbox"></div>

    <h4 class="tx_13">설문 결과</h4>

                    <c:if test="${not empty dataList}">

                            <c:set value="0" var="preGroupSeq" />
                            <c:set value="0" var="groupIndex" />
                            <c:forEach items="${dataList}" var="pollGroupBean" varStatus="status">

                                <c:if test="${pollGroupBean.groupSeq ne preGroupSeq && preGroupSeq ne 0}" >
                                            </tbody>
                                    </table>
                                </c:if>
    
                                <c:if test="${pollGroupBean.groupSeq ne preGroupSeq}" >
                                    <c:set value="${pollGroupBean.groupSeq}" var="preGroupSeq" />
                                    <c:set value="${groupIndex + 1}" var="groupIndex" />

                                <table class="boardWrite" id="pollGroup${pollGroupBean.groupSeq}" width="100%" cellspacing="0" cellpadding="0" summary="등록된 설문 항목">
                                    <caption class="title">등록된 설문 항목</caption>
                                    <colgroup>
                                        <col width="*" />
                                        <col width="35%" />
                                        <col width="15%" />
                                    </colgroup>
                                    <tbody>

                                        <!-- 설문 그룹 제목 -->
                                        <tr>
                                            <th colspan="3">
                                                <strong>${groupIndex}. ${pollGroupBean.groupTitle}</strong>
                                                <c:choose>
                                                    <c:when test="${pollGroupBean.type eq 'C'}">
                                                        <span class="tx_blue_s">(1~${pollGroupBean.multiChoiceCnt}개 선택 가능)</span>
                                                    </c:when>
                                                    <c:when test="${pollGroupBean.type eq 'R'}">
                                                        <span class="tx_blue_s">(1개 선택 가능)</span>
                                                    </c:when>
                                                    <c:otherwise><span class="tx-alert">(단답형 항목)</span></c:otherwise>
                                                </c:choose>
                                            </th>
                                        </tr>
                                </c:if>

                                        <tr>

                                    <c:choose>
                                        <c:when test="${pollGroupBean.type eq 'I'}">
                                        <!-- 단답형 항목 -->
                                            <td colspan="2">
                                                <c:choose>
                                                    <c:when test="${pollGroupBean.choiceCnt > 0}">
                                                        <input type="button" class="blue" value="단답형보기"
                                                            name="short_${pollGroupBean.seq}_${pollGroupBean.groupSeq}_${pollGroupBean.itemSeq}"
                                                            id="short_${pollGroupBean.seq}_${pollGroupBean.groupSeq}_${pollGroupBean.itemSeq}"
                                                            onclick="jsViewComment('short', '${pollGroupBean.seq}', '${pollGroupBean.groupSeq}', '${pollGroupBean.itemSeq}');return false;" />
                                                    </c:when>
                                                    <c:otherwise>등록된 답변이 없습니다.</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="tx_r">
                                                <c:choose>
                                                    <c:when test="${pollGroupBean.choiceCnt eq 0 or dataVo.responseCnt eq 0}">
                                                        [0명 / 총 ${dataVo.responseCnt}명]
                                                    </c:when>
                                                    <c:otherwise>
                                                        [${pollGroupBean.choiceCnt}명 / 총 ${dataVo.responseCnt}명]
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </c:when>
                                        <c:otherwise>
                                        <!-- 선택형 항목 -->
                                            <td>
                                                <span>
                                                    ${pollGroupBean.itemSeq}. ${pollGroupBean.item}
                                                    <c:if test="${pollGroupBean.etcYn eq 'Y' and pollGroupBean.choiceCnt > 0}">
                                                        <input type="button" class="blue" value="의견보기"
                                                            name="etc_${pollGroupBean.seq}_${pollGroupBean.groupSeq}_${pollGroupBean.itemSeq}"
                                                            id="etc_${pollGroupBean.seq}_${pollGroupBean.groupSeq}_${pollGroupBean.itemSeq}"
                                                            onclick="jsViewComment('etc', '${pollGroupBean.seq}', '${pollGroupBean.groupSeq}', '${pollGroupBean.itemSeq}');return false;" />
                                                    </c:if>
                                                </span>
                                            </td>
                                            <td>
                                                <div style="margin-top:2px;width:98%;border:1px solid;border-color:#666666;">
                                                    <c:choose>
                                                        <c:when test="${pollGroupBean.choiceCnt eq 0 or dataVo.responseCnt eq 0}">
                                                            <div style="background-color:#FF99FF;width:0%;">&nbsp;</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div style="background-color:#FF99FF;width:<fmt:formatNumber type="number" 
                                                                    value="${pollGroupBean.choiceCnt / dataVo.responseCnt * 100}" 
                                                                    pattern="###" />%;">&nbsp;
                                                             </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td class="tx_r">
                                                <c:choose>
                                                    <c:when test="${pollGroupBean.choiceCnt eq 0 or dataVo.responseCnt eq 0}">
                                                        0% / [${pollGroupBean.choiceCnt}명 / 총 ${dataVo.responseCnt}명]
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber type="number" 
                                                            value="${pollGroupBean.choiceCnt / dataVo.responseCnt * 100}" 
                                                            pattern="###.#" /> % / [${pollGroupBean.choiceCnt}명 / 총 ${dataVo.responseCnt}명]
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </c:otherwise>
                                    </c:choose>

                                        </tr>
                                        
                            </c:forEach>

                                    <op:no-data obj="${pager}" colspan="3" />

                                    </tbody>
                                </table>

                    </c:if>

    <!-- 설문 항목 목록  끝 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="blue" onclick="jsPollList();">목록</button></li>
        </ul>
    </div>
    <!-- //버튼 -->
