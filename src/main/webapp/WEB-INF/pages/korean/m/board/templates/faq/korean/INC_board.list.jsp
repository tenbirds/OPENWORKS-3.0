<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<script type="text/javascript">
function fn_view_comment(bbscttSeq){
    // 현재 클릭 행의 class 가져오기
    var trgClass = "";
	if($("#contents_"+bbscttSeq).hasClass('show')) {    
	    trgClass = "show";
	}else{
	    trgClass = "hide";	    
	}
    
    // 열려있는 모든 답변 tr 닫기
    $("#commentList").find("tr[id^='contents_']").hide();
    $("#commentList").find("tr[id^='contents_']").removeClass('hide').addClass('show');
    
    // 동작 이전의 class를 참조하여 반대 class 적용(열고 닫기)
	if(trgClass == "show") {    
	    $("#contents_"+bbscttSeq).removeClass('show').addClass('hide');
		$("#contents_"+bbscttSeq).slideDown(1000);
	}else{
	    $("#contents_"+bbscttSeq).removeClass('hide').addClass('show');
		$("#contents_"+bbscttSeq).slideUp(1000);	    
	}
}
</script>

<style>
.hide {display:none;}
</style>
<!-- list -->
<div class="type-list">
	<table>
		<caption>자주찾는 질문</caption>
		<colgroup>
		<!-- 번호(필수) -->
              <c:set var="thCnt" value="${thCnt + 1}" />
              <col style="width:90px;"/>
              <!-- 목록 배치에서 설정한 항목 배치 -->
              <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                  <c:set var="thCnt" value="${thCnt + 1}" />
                  <c:choose>
                      <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                          <col style="width:*;" />
                      </c:when>
                      <c:when test="${arrange.columnId eq 'CTG_CD'}">
                          <col style="width:15%;"/>
                      </c:when>
                      <c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
                          <col style="width:18%;"/>
                      </c:when>
                      <c:otherwise>
                          <col style="10%" />
                      </c:otherwise>                  
                  </c:choose>
              </c:forEach>
		</colgroup>
		<thead>
			<tr>
				<!-- 번호(필수) -->
                   <th id="th-ROWNUM">번호</th>

                   <!-- 목록 배치에서 설정한 항목 배치 -->
                   <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                       <c:choose>
                       <c:when test="${arrange.columnId eq 'CTG_CD'}">
                           <th id="th-CTG_CD"<c:if test="${status.last}"></c:if>>${arrange.langColumnNm}</th>
                       </c:when>
                       <c:otherwise>
                         <th id="th-${arrange.columnId}"<c:if test="${status.last}"></c:if>>${arrange.langColumnNm}</th>
                       </c:otherwise>
                       </c:choose>
                   </c:forEach>
			</tr>
		</thead>
		
		<tbody id="commentList">
			<!-- 공지 목록  -->
               <c:if test="${boardConfVo.noticeBbscttUseYn eq 'Y'}">
                   <c:forEach items="${noticeList}" var="noticeVo" varStatus="status">
                       <c:set var="trClass" value="bg_blue" />
                       <c:if test="${(pageType == 'VIEW') && (dataVo.bbscttSeq == noticeVo.bbscttSeq)}">
                           <c:set var="trClass" value="tr-sel" />
                       </c:if>
                       <!-- list 시작 -->
                       <tr class="item">
                           <!-- 번호(필수) -->
                           <td>
                           	<c:choose>
                                   <c:when test="${(pageType eq 'VIEW') && (noticeVo.bbscttSeq eq dataVo.bbscttSeq)}">
                                       <img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png' />" alt="현재글" />
                                   </c:when>
                                   <c:otherwise>
                                       <img src="<c:url value='/resources/web/theme/default/images/icon/icon_notice.gif' />" alt="공지글" />
                                   </c:otherwise>
                               </c:choose>
                           </td>
                           <!-- 목록 배치에서 설정한 항목 배치 -->
                           <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                               <c:choose>
                                   <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                       <!-- 제목 항목 -->
                                       <td class="title">
                                           <a href="#" rel="#titleNoticeSummary${status.count}"><c:out value='${noticeVo.bbscttSj}'/></a>
                                           <c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
                                           <c:choose>
                                               <c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
                                                   <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a>
                                               </c:when>
                                               <c:when test="${noticeVo.fileCnt > 0}">
                                               </c:when>
                                           </c:choose>
                                       </td>
                                   </c:when>
                                   <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                       <!-- 분류 항목 : 공지 목록이므로 '공지'로 표시 -->
                                       <td class="t_al"><span class="label_notice">공지</span></td>
                                   </c:when>
                                   <c:when test="${arrange.columnId eq 'RDCNT'}">
                                       <!-- 조회수 항목 -->
                                       <td class="t_al">
                                           <c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}"><span class="tx_blue">  <c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                           <c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}"><span><c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                       </td>
                                   </c:when>
                                   <c:otherwise>
                                       <td class="t_al"><op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/></td>
                                   </c:otherwise>
                               </c:choose>
                           </c:forEach>
                       </tr>
                       <!-- 내용 항목 -->
                       <tr id="noticd_${noticeVo.bbscttSeq}" style="display:none;" class="hide">
                           <td class="faq_left"></td>
                           <td colspan="${thCnt-1}" class="faq" >
                               ${noticeVo.bbscttCn}
                           </td>
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
                               <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                   <!-- 제목 항목 -->
                                   <td class="title">
                                       <c:choose>
                                           <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
                                               <p class="tx_blue_l">[관리자에 의하여 삭제되었습니다.]</p>
                                           </c:when>
                                           <c:otherwise>
                                            <a href="#" class="question" onclick="javascript:fn_view_comment('${baseVo.bbscttSeq}');">
                                            
                                            <op:nrToBr content='${baseVo.bbscttSj}'/>
                                            
                                            
                                            <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
                                            <c:choose>
                                            	<c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
                                                	<a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
                                                </c:when>
                                                <c:when test="${baseVo.fileCnt > 0}">
                                                </c:when>
                                            </c:choose>
                            				</a>
                                           </c:otherwise>
                                       </c:choose>
                                   </td>
                               </c:when>
                               
                               <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                   <!-- 분류 항목 -->
                                   <td><c:out value='${baseVo.ctgNm}'/></td>
                               </c:when>
                               
                               <c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
                                   <!-- 분류 항목 -->
                                   <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
                                   	<c:forEach items="${ctgVo.aditCtgList}" var="aditCtgVo" varStatus="status">
                                       	<c:if test="${ctgVo.ctgNm == baseVo.ctgNm and aditCtgVo.aditCtgCd eq baseVo.estnColumn1 }">
                                           	<td>  <c:out value='${aditCtgVo.aditCtgNm}'/></td> 
                                          	</c:if>
                                      	</c:forEach>
                                   </c:forEach>
                               </c:when>
                               
                               <c:otherwise>
                                   <td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td>
                               </c:otherwise>
                               
                           </c:choose>
                       </c:forEach>
                   </tr>
                   
                   <!-- 공지 답변 영역[숨김처리해야함] -->
                   <tr id="contents_${baseVo.bbscttSeq}" class="show" style="display:none;">
                       <td class="faq_left"></td>
                       <td colspan="${thCnt-1}" class="faq" >
                           <table class="tbRl_list">
                               <colgroup>
                                   <col style="width:100%;">
                               </colgroup>
                               <tbody>
                                   <tr>
                                       <td class="title"><op:nrToBr content='${baseVo.bbscttCn}'/></td>
                                   </tr>
                               </tbody>
                           </table>
                       </td>
                   </tr>
                   <!-- 공지 답변 영역[숨김처리해야함] -->
                   
               </c:forEach>
			
			<!-- 데이터가 없을 때 알림 문구 -->
               <c:if test="${empty pager.list}">
                   <op:no-data obj="${pager}" colspan="${thCnt}" />
               </c:if>
		</tbody>
	</table>
</div>
<!-- //list -->

<!-- paging -->
<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
<!-- //paging -->
				