<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!-- container -->
<div id="container">
    <!-- contents -->
    <div id="contents">
        <div class="location"><span class="home">Inicio</span><strong>Encuentro comercial</strong></div>
        <section class="content rela">
            <h3>Encuentro comercial</h3>
            <!-- 내용보기 -->
            <table class="tbl_view">
                <caption>
                    <strong>${dataVo.bbscttSj} 상세보기</strong>
                    <details>
                        <summary>${dataVo.bbscttSj} 게시글 정보입니다.</summary>
                    </details>
                </caption>
                <colgroup>
                    <col style="width:12%"/>
                    <col style="width:11%"/>
                    <col style="width:11%"/>
                    <col style="width:15%"/>
                    <col style="width:11%"/>
                    <col style="width:15%"/>
                    <col style="width:11%"/>
                    <col style="width:*"/>
                </colgroup>
                <tbody>
                    <!-- 상세 배치에서 설정한 항목 배치 -->
                    <c:set var="scoreRow" value="1" />
                    <c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
                        <c:choose>
                            <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'RDCNT'}">
                                <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                    <tr>
                                        <td class="tit"><label for="cs">Categoría</label></td>
                                        <td class="last cs" colspan="7"> 
                                            <c:if test="${not empty dataVo.ctgryList}">
                                                <c:forEach items="${dataVo.ctgryList}" var="ctgryVo">
                                                    [<c:out value='${ctgryVo.ctgryClNm }'/>] <c:out value='${ctgryVo.ctgryPath }'/><br/>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty dataVo.ctgryList}">
                                                No se puede encontrar la categoría que ha seleccionado.
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tit">Título</td>
                                        <td colspan="3"><c:out value='${dataVo.bbscttSj}'/></td>
                                </c:if>
                                <c:if test="${arrange.columnId eq 'RDCNT'}">
                                        <td class="tit">Cantidad de encuentros</td>
                                        <td><c:out value='${dataVo.commentCnt}'/></td>
                                        <td class="tit">Cantidad de visualizaciones</td>
                                        <td class="last"><c:out value='${dataVo.rdcnt}'/></td>
                                    </tr>
                                </c:if>
                            </c:when>
                            <c:when test="${arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'ESTN_COLUMN6'}">
                                <c:if test="${arrange.columnId eq 'REGIST_ID'}">
                                    <tr>
                                        <td class="biz tit">ID del autor</td>
                                        <td><c:out value='${dataVo.maskRegistId}'/></td>
                                </c:if>
                                <c:if test="${arrange.columnId eq 'REGIST_DT'}">
                                        <td class="biz tit">Fecha de publicación</td>
                                        <td><c:out value='${dataVo.registDt}'/></td>
                                </c:if>
                                <c:if test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                                        <td class="biz tit">Fecha de cierre</td>
                                        <%--<td><c:out value='${dataVo.estnColumn6}'/></td>--%>
                                        <c:choose>
                                            <c:when test="${dataVo.estnColumn6 eq '2030.12.31 00:00'}">
                                                <td><c:out value='-'/></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><c:out value='${dataVo.estnColumn6}'/></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td class=" tit">Condición</td>
                                        <td class="last">
                                            <c:if test="${dataVo.bizProgression eq 'COM'}"><span class="condi_a">Completo</span></c:if>
                                            <c:if test="${dataVo.bizProgression eq 'INC'}"><span class="condi_b">Incompleto</span></c:if>
                                            <c:if test="${dataVo.bizProgression eq 'PRO'}"><span class="condi_d">En curso</span></c:if>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:when>
                            <c:when test="${arrange.columnId eq 'BBSCTT_CN' }">
                                <tr>
                                    <td colspan="8" class="cont_view">${dataVo.bbscttCn}</td>
                                </tr>
                            </c:when>
                            <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
                                <tr>
                                    <td colspan="8" class="last">
                                        <div class="add_file">
                                            <c:choose>
                                                <c:when test="${fn:length(dataVo.fileList) > 0}">
                                                    <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                        <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#"></a> No hay archivos adjuntos.
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <!-- 기타 항목 -->
                                <tr>
                                    <td colspan="8" class="txt_view"><op:bean-util field="${arrange.columnId}" obj="${dataVo}"/></td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- 태그 -->
                    <c:if test="${boardConfVo.tagYn eq 'Y'}">
                        <tr>
                            <td colspan="2">
                                <div class="tag">
                                    <img src="/resources/openworks/theme/default/images/icon/icon_tag.gif" alt="tag" class="vm" />
                                    <c:if test="${!empty dataVo.bbsTags}">
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

            <!-- 버튼 -->
            <div class="btn_area">
                <div class="btn_l">
                    <div class="btn_navi"><a href="#" onclick="jsList('1');"><span class="list">Lista</span></a></div>
                </div>
                <div id="btn_modify_trash" class="btn_r">
                    <!-- 완료 상태에서는 수정 및 삭제 할 수 없다. -->
                    <c:if test="${dataVo.bizProgression ne 'COM'}">
                        <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                            <div class="btn_navi_g" onclick="jsUpdateForm('UPDATE');"><a href="#"><span class="modify">Editar</span></a></div>
                            <div class="btn_navi_g" onclick="jsDelete();"><a href="#"><span class="trash">Eliminar</span></a></div>
                        </c:if>
                    </c:if>
                </div>
            </div>
            <!-- //버튼 -->

            <!-- 댓글 -->
            <c:if test="${boardConfVo.cmtYn eq 'Y'}">
                <br/><div id="attachedCommentsDiv2" ></div>
            </c:if>
            <!-- //댓글 -->

            <!-- 목록 보여주기 시작 -->
            <form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
                <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
                <op:pagerParam view="view" />

                <!-- 다음/이전을 다음/이전으로 보기 -->
                <c:if test="${boardConfVo.listViewCd == 1002}">
                    <%@include file="/WEB-INF/pages/web/board/templates/common/korean/INC_prev.next.list.jsp" %>
                </c:if>
                <!-- 다음/이전을 다음/이전으로 보기 끝 -->

                <input type="hidden" name="section" value="<c:out value='${param.section}'/>"/>
                <input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}'/>"/>
                <input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>"/>
                <input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}'/>"/>
                <input type="hidden" name="ctgCd" id="ctgCd" value="<c:out value='${dataVo.ctgCd}'/>"/>
                <input type="hidden" name="pageType" id="pageType" value="<c:out value=''/>"/>
            </form>
        </section>
    </div>
    <!-- //contents -->
</div>
<!-- //container -->