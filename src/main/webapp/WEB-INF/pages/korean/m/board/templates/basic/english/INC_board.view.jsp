<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

    <!-- 내용보기 -->
        <table class="${boardConfVo.bbsCd eq 1001? 'tbl_view':'tbl_detail_view'}" >
            <caption>
                <strong>${dataVo.bbscttSj} 상세보기</strong>
                <details>
                    <summary>${dataVo.bbscttSj} 게시글 정보입니다.</summary>
                </details>
            </caption>
            <colgroup>
                <c:if test="${boardConfVo.bbsCd ne '1001'}">
                    <col style="width:*">
                    <col style="width:35%">
                </c:if>
                <c:if test="${boardConfVo.bbsCd eq '1001'}"><!-- 공지사항인 경우 -->
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </c:if>
            </colgroup>
            <tbody>
                <!-- 상세 배치에서 설정한 항목 배치 -->
                <c:set var="scoreRow" value="1" />
                <c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
                    <c:choose>
                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                            <c:choose>
                                <c:when test="${boardConfVo.bbsCd eq '1009'}">
                                <!-- 성공사례 -->
                                    <tr>
                                        <td class="tit"><c:out value='${dataVo.bbscttSj}'/> </td>
                                </c:when>
                                <c:when test="${boardConfVo.bbsCd eq '1001'}">
                                <!-- 공지사항 -->
                                <tr>
                                    <td class="tit">Title</td>
                                    <td colspan="3" class="last"><c:out value='${dataVo.bbscttSj}'/></td>
                                </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td class="tit" colspan="2">
                                        <c:if test="${boardConfVo.bbsCd eq '1008'}"><span class="field">[<c:out value='${dataVo.goodsNm}'/>]</span></c:if>
                                            <c:out value='${dataVo.bbscttSj}'/>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'RDCNT' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'CTG_CD'  }">
                        <!-- 등록자명, 조회수, 등록일, 수정삭제버튼 -->
                            <c:choose>
                                <c:when test="${boardConfVo.bbsCd eq '1009'}"> <!--  성공사례인 경우  -->
                                    <c:if test="${arrange.columnId eq 'REGIST_DT'}">
                                        <td>
                                            <div class="cont_r">
                                                <span class="date"><c:out value='${dataVo.registDt}'/></span>
                                    </c:if>
                                    <c:if test="${arrange.columnId eq 'RDCNT'}">
                                                <ul class="function">
                                                     <li>View count <c:out value='${dataVo.rdcnt}'/></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    </c:if>
                                </c:when>
                                <c:when test="${boardConfVo.bbsCd eq '1001'}"><!-- 공지사항인 경우 -->
                                    <c:if test="${arrange.columnId eq 'CTG_CD'}">
                                        <!-- 분류 -->
                                        <c:if test="${boardConfVo.ctgYn eq 'Y'}">
                                            <tr>
                                                <td class="tit">Category</td>
                                                <td><c:out value='${dataVo.ctgNm}'/></td>
                                                <td class="tit">Date posted</td>
                                                <td class="last"><c:out value='${dataVo.registDt}'/></td>
                                            </tr>
                                        </c:if>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${arrange.columnId eq 'REGIST_ID'}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                                                        <span class="name"><c:out value='${dataVo.registId}'/></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="name"><c:out value='${dataVo.maskRegistId}'/></span>
                                                    </c:otherwise>
                                                </c:choose>
                                    </c:if>
                                    <c:if test="${arrange.columnId eq 'RDCNT'}">
                                               <span class="inquiry">View count <c:out value='${dataVo.rdcnt}'/></span>
                                            </td>
                                    </c:if>
                                    <c:if test="${arrange.columnId eq 'REGIST_DT'}">
                                           <td>
                                               <div class="cont_r">
                                                   <span class="date"><c:out value='${dataVo.registDt}'/></span>
                                                   <ul class="function">
                                                       <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002'}">
                                                           <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                                                               <li><a href="#"  onclick="jsUpdateForm('UPDATE');">Edit</a></li>
                                                               <li><a href="#" onclick="jsDelete();">Delete</a></li>
                                                           </c:if>
                                                       </c:if>
                                                   </ul>
                                               </div>
                                           </td>
                                       </tr>
                                   </c:if>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${arrange.columnId eq 'BBSCTT_CN' or arrange.columnId eq 'FILE_SEQ'}">
                            <c:if test="${arrange.columnId eq 'BBSCTT_CN'}">
                                <c:choose>
                                    <c:when test="${boardConfVo.bbsCd eq '1001'}"><!-- 공지사항인 경우 -->
                                        <tr>
                                            <td colspan="4" class="last">
                                                <div class="cont_view">
                                                    <c:out value='${dataVo.bbscttCn}' escapeXml="false" />
                                                </div>
                                                <c:if test="${fn:length(dataVo.fileList) > 0}">
                                                   <div class="add_file">
                                                     <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                         <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})
                                                     </c:forEach>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <!--내용 -->
                                        <tr>
                                            <td colspan="2" class="txt_view"> <c:out value='${dataVo.bbscttCn}' escapeXml="false" />
                                                <c:if test="${boardConfVo.bbsCd ne '1009'}"><!-- 성공사례는 파일이 나오지않음  -->
                                                    <div class="file_area">
                                                        <c:choose>
                                                            <c:when test="${fn:length(dataVo.fileList) > 0}">
                                                                <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                                    <span class="file">
                                                                    <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})</span>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
<!--                                                                 <span class="file">첨부파일이 없습니다.</span> -->
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <!-- 기타 항목 -->
                            <tr>
                                <td colspan="${boardConfVo.bbsCd eq '1001'? '4':'2'}" class="txt_view"><op:bean-util field="${arrange.columnId}" obj="${dataVo}"/></td>
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
                                    <img src="/resources/openworks/theme/default/images/icon/icon_tag.gif" alt="태그" class="vm" />
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

    <!-- 댓글 -->
    <c:if test="${boardConfVo.cmtYn eq 'Y'}">
        <br/><div id="attachedCommentsDiv" class="reply_box"></div>
    </c:if>
    <!-- //댓글 -->
    
    <!-- 버튼 -->
    <div class="btn_area">
        <div class="${boardConfVo.bbsCd eq '1001'? 'btn_r':'btn_l'}">
            <div class="btn_navi"><a href="#" onclick="jsList('<c:out value='${param.q_currPage}'/>');"><span class="list">List</span></a></div>
        </div>
        <div class="btn_r">
        <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002'}">
            <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                <div class="btn_navi_g" onclick="jsUpdateForm('UPDATE');"><a href="#"><span class="modify">Edit</span></a></div>
                <div class="btn_navi_g" onclick="jsDelete();"><a href="#"><span class="trash">Delete</span></a></div>
            </c:if>
        </c:if>
        </div>
        
    </div>
    <!-- //버튼 -->

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
    
