<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>


	<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
	<op:pagerParam page="param/webEngListPagerParam.jsp" />
                
    <!-- 게시판 (서비스리뷰, 성공사례를 제외한 -->
            <c:if test="${boardConfVo.bbsCd ne '1008' and boardConfVo.bbsCd  ne '1009'}">
            <!-- 목록 시작 -->
                <table class="tbl_list type_A" > 
                    <caption>
		                <strong>기본게시판 목록 </strong>
		                <details>
		                    <summary>기본게시판 목록으로 번호,분류,제목,작성자,작성일 등의 조회 정보를 제공합니다.</summary>
		                </details>
		            </caption>
                    <colgroup>
                        <!-- 번호(필수) -->
                        <c:set var="thCnt" value="${thCnt + 1}" />
                        <col width="10%" />
        
                        <!-- 목록 배치에서 설정한 항목 배치 -->
                        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                            <c:set var="thCnt" value="${thCnt + 1}" />
                            <c:choose>
                                <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                   <col style="width:12%">
                                </c:when>
                                <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                   <col style="width:*%">
                                </c:when>
                                <c:when test="${arrange.columnId eq 'REGIST_ID'}">
                                   <col style="width:12%">
                                </c:when>
                                <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                                   <col style="width:15%">
                                </c:when>
                                <c:when test="${arrange.columnId eq 'RDCNT'}">
                                   <col style="width:10%">
                                </c:when>
                                <c:otherwise>
                                   <col style="width:*%">
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </colgroup>
                    <thead>
                        <tr>
                            <!-- 번호(필수) -->
                            <th id="th-ROWNUM" scope="col"><span class="sort cs_pointer" id="ROWNUM">Número</span></th>
                
                            <!-- 목록 배치에서 설정한 항목 배치 -->
                            <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                                <th id="th-${arrange.columnId}" scope="col"><span class="sort cs_pointer" id="${arrange.columnId}"><c:out value='${arrange.langColumnNm}'/></span></th>
                            </c:forEach>
                        </tr>
                    </thead>
                    <tbody id="odd-color">
                        <!-- 공지 목록  -->
                        <c:if test="${boardConfVo.noticeBbscttUseYn eq 'Y'}">
        
                            <c:forEach items="${noticeList}" var="noticeVo" varStatus="status">
        
                                <c:set var="trClass" value="bg_blue" />
                                <c:if test="${(pageType == 'VIEW') && (dataVo.bbscttSeq == noticeVo.bbscttSeq)}">
                                    <c:set var="trClass" value="tr-sel" />
                                </c:if>
        
                                <tr class="${trClass}">
                                    <!-- 번호(필수) -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${(pageType eq 'VIEW') && (noticeVo.bbscttSeq eq dataVo.bbscttSeq)}">
                                                <img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png' />" alt="현재글" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="<c:url value='/resources/web/theme/default/images/icon/icon_notice.gif' />" alt="공지알림" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
        
                                    <!-- 목록 배치에서 설정한 항목 배치 -->
                                    <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                                        <c:choose>
                                            <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                                <!-- 제목 항목 -->
                                                <td class="tx_l">
                                                    <a href="#" rel="#titleNoticeSummary${status.count}"
                                                        onclick="jsView('${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
                                                        <c:out value='${noticeVo.bbscttSj}'/>
                                                        <c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
                                                    </a>
        
                                                    <c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
        
                                                    <c:choose>
                                                        <c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
                                                            <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다."><img alt="첨부된 이미지" src="/resources/web/theme/default/images/common/ico/ico_image.gif"></a>
                                                        </c:when>
                                                        <c:when test="${noticeVo.fileCnt > 0}">
                                                            <span class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다."><img alt="첨부된 이미지" src="/resources/web/theme/default/images/common/ico/ico_image.gif"></span>
                                                        </c:when>
                                                    </c:choose>
        
                                                    <c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
                                                        <span class="t_reply" title="의견글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span>
                                                    </c:if>
        
                                                    <c:if test="${boardConfVo.newArticleNum > 0}">
                                                        <c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
        <!--                                                    <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
                                                        </c:if>
                                                    </c:if>
        
<%--                                                     <div id="titleNoticeSummary${status.count}" class="tx_blue_s"><c:out value="${noticeVo.cnSumry}" escapeXml="true" /></div> --%>
                                                </td>
                                            </c:when>
                                            <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                                <!-- 분류 항목 : 공지 목록이므로 '공지'로 표시 -->
                                                <td>공지</td>
                                            </c:when>
                                            <c:when test="${arrange.columnId eq 'RDCNT'}">
                                                <!-- 조회수 항목 -->
                                                <td>
                                                    <c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}"><span class="tx_blue"><c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                                    <c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}"><span><c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </c:if>
        
                        <!-- 공지 제외 게시물 목록 -->
                        <c:set var="index" value="${pager.indexNo}"/>
                        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                            <tr>
                                <!-- 번호(필수) -->
                                <td>
                                    <c:choose>
                                        <c:when test="${(pageType eq 'VIEW') && (baseVo.bbscttSeq eq dataVo.bbscttSeq)}">
                                            <img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png' />" alt="현재글" />
                                        </c:when>
                                        <c:otherwise>
                                            ${index-status.index}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
        
                                <!-- 목록 배치에서 설정한 항목 배치 -->
                                <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                                    <c:choose>
                                        <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                             <!-- 분류 항목 -->
                                             <td class="classify"><c:out value='${baseVo.ctgNm}'/></td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                            <!-- 제목 항목 -->
                                            <td class="t_al">
	                                            <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                                                onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
	                                                <c:out value='${baseVo.bbscttSj}'/> 
	                                                <c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
	                                                <c:if test="${baseVo.fileCnt > 0}">
	                                                    <img alt="첨부된 이미지" class="ico" src="/resources/web/theme/default/images/common/ico/ico_image.gif">
	                                                </c:if>
	                                            </a>
	
	                                            <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
	
	                                            <c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
	                                                <span class="num" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">[${baseVo.commentCnt}]</span>
	                                            </c:if>
	
	                                            <c:if test="${boardConfVo.newArticleNum > 0}">
	                                                <c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
	<!--                                                        <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
	                                                </c:if>
	                                            </c:if>
	
	                                            <c:if test="${baseVo.othbcAt eq 'N'}">
	                                                <div id="titleSummary${status.count}" class="tx_blue_s">* 비밀글 입니다. *</div>
	                                            </c:if>
                                            </td>
                                        </c:when>
                                        
                                        <c:when test="${arrange.columnId eq 'REGIST_ID'}">
                                            <!-- 아이디 항목 -->
                                            <td class="date">${baseVo.maskRegistId}
                                            </td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                                            <!-- 조회수 항목 -->
                                            <td class="date">${baseVo.registDt}
                                            </td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'RDCNT'}">
                                            <!-- 조회수 항목 -->
                                            <td>
                                                <c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}"><span class="tx_blue"><c:out value='${baseVo.rdcnt}'/></span></c:if>
                                                <c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}"><span><c:out value='${baseVo.rdcnt}'/></span></c:if>
                                            </td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </tr>
                        </c:forEach>
        
                        <!-- 데이터가 없을 때 알림 문구 -->
	                    <c:if test="${empty pager.list}">
	                        <op:no-data obj="${pager}" colspan="${thCnt}" msg="<strong>No hay datos</strong>"/>
	                    </c:if>       
        
                    </tbody>
                </table>
                <!-- //목록 끝 -->
            </c:if>
            
            <!-- 서비스리뷰, 성공사례 게시판(이미지형식) -->
            <c:if test="${boardConfVo.bbsCd eq '1008' or boardConfVo.bbsCd eq '1009'}">
                <!-- 리스트 -->
                <div class="product_list">
                    <ul>     
                    <!-- 공지목록 --> 
                        <c:forEach items="${noticeList}" var="noticeVo" varStatus="status">
                            <li>
                                <c:set var="index" value="${pager.indexNo}"/>
                                <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                                    <c:choose>
                                        <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
                                            <!-- 썸네일 이미지 -->
                                            <div class="photo">
                                                <c:choose>
                                                    <c:when test="${(noticeVo.fileCnt > 0) && (noticeVo.fileList[0].localNm != '')}">
                                                        <img src="<c:url value="${noticeVo.fileList[0].fileUrl}" />"  title="${noticeVo.fileList[0].localNm}" alt="${noticeVo.fileList[0].localNm}"style="width: 156px; height: 177px; "/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">
                                        <div class="info">
                                        <!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
                                            <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}"> <!--제목 -->
	                                            <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                                                onclick="jsView('${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
	                                                <c:if test="${boardConfVo.bbsCd eq '1008'}"><span class="field">[${noticeVo.goodsNm}]</span></c:if>
	                                                <strong><c:out value='${noticeVo.bbscttSj}'/> </strong>
	                                                <c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
	                                            </a>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'CN_SUMRY'}"> <!--내용요약 -->
                                                <div class="txt"><c:out value='${noticeVo.cnSumry}'/></div>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'REGIST_ID'}"> <!--등록자명 -->
                                                <div class="desc">  
                                                    <span><c:out value='${noticeVo.maskRegistId}'/></span>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'REGIST_DT'}"> <!--등록일시 -->
                                                    <span><c:out value='${noticeVo.registDt}'/></span>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'RDCNT'}"> <!--조회수 -->
                                                    <span>Cantidad de visualizaciones <c:out value='${noticeVo.rdcnt}'/></span>
                                                </div>
                                            </c:if>
                                        </div>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </li>
                        </c:forEach>
                        
                        
                        <!-- 공지 제외목록 -->
                        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">  
                            <li>
                                <c:set var="index" value="${pager.indexNo}"/>
                                <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                                    <c:choose>
                                        <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
                                            <!-- 썸네일 이미지 -->
                                            <div class="photo">
                                                <c:choose>
                                                    <c:when test="${(baseVo.fileCnt > 0) && (baseVo.fileList[0].localNm != '')}">
                                                        <img src="<c:url value="${baseVo.fileList[0].fileUrl}" />"  title="${baseVo.fileList[0].localNm}" alt="${baseVo.fileList[0].localNm}" style="width: 156px; height: 117px;"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">
                                        <!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
                                           <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}"> <!--제목 -->
                                               <div class="info">
                                                <c:choose>
                                                    <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
                                                        <strong>[관리자에 의하여 삭제되었습니다.]</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                           <a href="#" rel="#titleSummary${status.count}" class="contentTip"
                                                               onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
                                                               <c:if test="${boardConfVo.bbsCd eq '1008'}"><span class="field">[<c:out value='${baseVo.goodsNm}'/>]</span></c:if>
                                                               <strong>
                                                                   <c:out value='${fn:substring(baseVo.bbscttSj,0,45)}'/><c:if test="${baseVo.bbscttSjLength > 45}">...</c:if>
                                                               </strong>
                                                           </a>
                                                           <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
               
                                                           <c:choose>
                                                               <c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
   <%--                                                                    <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a> --%>
                                                               </c:when>
                                                               <c:when test="${baseVo.fileCnt > 0}">
   <%--                                                                    <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span> --%>
                                                               </c:when>
                                                           </c:choose>
               
                                                           <c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
   <%--                                                                <span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span> --%>
                                                           </c:if>
               
                                                           <c:if test="${boardConfVo.newArticleNum > 0}">
                                                               <c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
   <!--                                                                    <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
                                                               </c:if>
                                                           </c:if>
               
                                                           <c:if test="${baseVo.othbcAt eq 'Y'}">
<%--                                                                <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div> --%>
                                                           </c:if>
               
                                                           <c:if test="${baseVo.othbcAt eq 'N'}">
   <%--                                                                <div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div> --%>
                                                           </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                           <c:if test="${arrange.columnId eq 'CN_SUMRY'}"> <!--내용요약 -->
                                                <div class="txt"><c:out value='${baseVo.cnSumry}'/></div>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'REGIST_ID'}"> <!--등록자명 -->
                                                <div class="desc">  
                                                    <span><c:out value='${baseVo.maskRegistId}'/> </span>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'REGIST_DT'}"> <!--등록일시 -->
                                                    <span><c:out value='${baseVo.registDt}'/> </span>
                                            </c:if>
                                            <c:if test="${arrange.columnId eq 'RDCNT'}"> <!--조회수 -->
                                                    <span>Cantidad de visualizaciones <c:out value='${baseVo.rdcnt}'/> </span>
                                                </div>
                                            </c:if>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </li>
                        </c:forEach>
                        
                        <!-- 데이터가 없을 때 알림 문구 -->
                        <c:if test="${empty pager.list}">
                            <li style="text-align: center;">No hay datos</li>
                        </c:if> 
	                        
                     </ul>
                </div>
            </c:if>
            
            