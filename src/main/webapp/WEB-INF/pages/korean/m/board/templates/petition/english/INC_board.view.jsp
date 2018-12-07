<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

    <!-- 답변 달기 -->
        <c:if test="${not empty dataVo.replyDt and not empty dataVo.replyCn }">
            <table class="tbl_view" >
                <caption>
                    <strong>${dataVo.bbscttSj} Reply</strong>
                    <details>
                        <summary>${dataVo.bbscttSj} Reply Form</summary>
                    </details>
                </caption>
                <colgroup>
                    <col style="width:20%;">
                    <col style="width:30%;">
                    <col style="width:20%;">
                    <col style="width:30%;">
                </colgroup>
                <tbody>
                    <tr>
                        <td class="tit">Date posted</td>
                        <td  colspan="3"><c:out value='${dataVo.replyDt}'/></td>
                    </tr>
                    <tr>
                        <td class="cont_view" colspan="4"><c:out value='${dataVo.replyCn}' escapeXml="false"/></td>
                    </tr>
                </tbody>
            </table>
        </c:if>    
            

    <!-- 내용보기 -->
        <table class="tbl_view">
            <caption>
                <strong>${dataVo.bbscttSj} View More</strong>
                <details>
                    <summary>${dataVo.bbscttSj} posts information </summary>
                </details>
            </caption>
            <colgroup>
                <col style="width:20%;"/>
                <col style="width:30%;"/>
                <col style="width:20%;"/>
                <col style="width:30%;"/>
            </colgroup>
            <tbody>
                <!-- 상세 배치에서 설정한 항목 배치 -->
                <c:set var="scoreRow" value="1" />
                <c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
                    <c:choose>
                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                            <!-- 제목 -->
                                <tr>
                                    <td class="tit">Title</td>
                                    <td class="last" colspan="3"> <c:out value='${dataVo.bbscttSj}'/></td>
                                </tr>
                        </c:when>
                        <c:when test="${arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'OTHBC_AT'}">
                            <c:if test="${arrange.columnId eq 'REGIST_ID'}"><!-- 등록자명 -->
                                <tr>
                                    <td class="tit">Author ID</td>
                                    <c:choose>
                                        <c:when test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                                            <td><c:out value='${dataVo.registId}'/></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><c:out value='${dataVo.maskRegistId}'/></td>
                                        </c:otherwise>
                                    </c:choose>
                            </c:if>
                            <c:if test="${arrange.columnId eq 'OTHBC_AT'}"><!-- 공개여부 -->
                                    <td class="tit">Disclosure status</td>
                                    <td class="last">
                                        <c:if test="${dataVo.othbcAt eq 'N'}"> Hidden</c:if>
                                        <c:if test="${dataVo.othbcAt eq 'Y'}"> Disclosure</c:if>
                                    </td>
                                </tr>
                            </c:if>
                        </c:when>
                        <c:when test="${arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'ESTN_COLUMN3'}">
                            <c:if test="${arrange.columnId eq 'REGIST_DT'}"><!-- 등록일 -->
                                <tr>
                                    <td class="tit">Date posted</td>
                                    <td><c:out value='${dataVo.registDt}'/></td>
                            </c:if>
                            <c:if test="${arrange.columnId eq 'ESTN_COLUMN3'}"><!-- 상태 -->
                                    <td class="tit">Condition</td>
                                    <td class="last">
                                        <c:if test="${dataVo.estnColumn3 eq 'N'}">Complete completed</c:if>
                                        <c:if test="${dataVo.estnColumn3 eq 'Y'}">Not completed </c:if>
                                    </td>
                                </tr>
                            </c:if>
                        </c:when>
                        
                        <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
                            <!-- 첨부파일 -->
                            <c:if test="${!empty dataVo.fileList}">
                                <tr>
                                    <td class="tit"><label for="${arrange.beanNm}">Attached file</label></td>
                                    <td class="last" colspan="3">
                                        <c:if test="${fn:length(dataVo.fileList) > 0}">
                                           <div class="add_file">
                                             <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                 <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})
                                             </c:forEach>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>
                        </c:when>
                        
                        <c:when test="${arrange.columnId eq 'BBSCTT_CN'}"><!-- 내용 -->
                        <tr>
                            <td class="cont_view" colspan="4"><c:out value='${dataVo.bbscttCn}' escapeXml="false" /></td>
                        </tr>
                        </c:when>
                        <c:otherwise>
                            <!-- 기타 항목 -->
                            <tr>
                                <th><label for="${arrange.beanNm}">${arrange.columnNm}</label></th>
                                <td><op:bean-util field="${arrange.columnId}" obj="${dataVo}"/></td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- 태그 -->
                <c:if test="${boardConfVo.tagYn eq 'Y'}">
                    <tr>
                        <td colspan="2">
                            <div class="tag">
                                <c:if test="${!empty dataVo.bbsTags}">
                                    <img src="/resources/openworks/theme/default/images/icon/icon_tag.gif" alt="tag" class="vm" />
                                    <c:forEach var="tag" items="${dataVo.bbsTags}" varStatus="status">
                                        <a href="#" onclick="jsShowBbsListByTag('<c:out value='${tag}'/>')">${tag}</a> <c:if test="${not status.last}">|</c:if>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
        <div class="btn_area">
            <div class="${empty dataVo.replyDt and empty dataVo.replyCn? 'btn_l':'btn_r' }">
                <div class="btn_navi"><a href="#" onclick="jsList('1');"><span class="list">List</span></a></div>
            </div>
            <div class="btn_r">
                <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                    <c:if test="${empty dataVo.replyDt and empty dataVo.replyCn }"> <!-- 답변이 없는경우에만 가능  -->
                        <div class="btn_navi_g" onclick="jsUpdateForm('UPDATE');"><a href="#"><span class="modify">Edit</span></a></div>
                        <div class="btn_navi_g" onclick="jsDelete();"><a href="#"><span class="trash">Delete</span></a></div>
                    </c:if>
                </c:if>
            </div>
        </div>
    

    <!-- 댓글 -->
    <c:if test="${boardConfVo.cmtYn eq 'Y'}">
        <br/><div id="attachedCommentsDiv" class="reply_box"></div>
    </c:if>
    <!-- //댓글 -->
    

    <!-- 목록 보여주기 시작 -->
    <form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />

        <!-- 다음/이전을 다음/이전으로 보기 -->
        <c:if test="${boardConfVo.listViewCd == 1002}">
            <%@include file="/WEB-INF/pages/web/board/templates/common/english/INC_prev.next.list.jsp" %>
        </c:if>
        <!-- 다음/이전을 다음/이전으로 보기 끝 -->

        <input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}'/>" />
        <input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>" />
        <input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}'/>" />
        <input type="hidden" name="ctgCd" id="ctgCd" value="<c:out value='${dataVo.ctgCd}' />" />
        <input type="hidden" name="pageType" id="pageType" value="<c:out value=''/>" />

    </form>
