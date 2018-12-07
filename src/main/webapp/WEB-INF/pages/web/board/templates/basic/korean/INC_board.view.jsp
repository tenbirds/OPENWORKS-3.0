<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
	
    <!-- contents -->
					    
	<!-- <div class="contents conWrap"> -->
		<!-- title-area -->
		<!-- <div class="title-area"> -->
<%-- 20161223 title 중복처리<h2>${boardConfVo.bbsNm}</h2> --%>
		<!-- </div> -->
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section">
			<!-- view -->
			<div class="type-view">
			  <!-- <iframe src="korean/INC_boardFrame.jsp" id="iframe" name="ifrm" width=300 height=200 frameborder=1></iframe> -->
			<!-- 내용보기 -->
				<table>
				<!-- caption -->
					<caption>
						<strong>${dataVo.bbscttSj} 상세보기</strong>
						<details><summary>${dataVo.bbscttSj} 게시글 정보입니다.</summary></details>
					</caption>
					<!-- //caption -->
					<!-- colgroup -->
					<colgroup>
						<c:choose>
							<c:when test="${boardConfVo.bbsCd eq '1001' || boardConfVo.bbsCd eq '1004' || boardConfVo.bbsCd eq '1007' || boardConfVo.bbsCd eq '1009' || boardConfVo.bbsCd eq '1031'}">
							<col style="width:;"/>
					    <col style="width:;"/>
							</c:when>
							<c:otherwise>
							<col style="width:*"/>
              <col style="width:35%"/>
							</c:otherwise>
						</c:choose>
          </colgroup>
          <!-- colgroup -->
          
          <!-- tbody -->
          <tbody>
          	<!-- 상세 배치에서 설정한 항목 배치 -->
          	<c:set var="scoreRow" value="1" />
          	<c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
          	<c:choose>
          		<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                <!-- c:when 제목부분을 따로 둬야지만 디자인이  먹힘-->
                                    <c:choose>
                                        <%-- 성공스토리[1009] / 지식나눔[1004] / 기타 입찰정보[1011] / 행사 및 이벤트[1007] / 공지사항[1001] --%>
                                        <c:when test="${boardConfVo.bbsCd eq '1008'}">
                                            <tr>
                                                <td class="tit" colspan="2">
                                                    <span class="field">[<c:out value='${dataVo.goodsNm}'/>]</span>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:when test="${boardConfVo.bbsCd eq '1013'}">
                                        	<%-- 클라우드스토어 씨앗 지식맵은 하단에 타이틀이 출력되므로 제목란을 출력하지 않음. --%>
                                        </c:when>
                                        <%-- 위 내역 이외의 게시판 제목 --%>
                                        <c:otherwise>
                                            <thead>
										        <tr>
											        <th colspan="2"><c:out value='${dataVo.bbscttSj}'/></th>
										        </tr>
									        </thead>
                                        </c:otherwise>
                                    </c:choose>
              </c:when>
                                
                                <%-- 등록자 / 조회수 / 등록일자 영역 --%>
                                <c:when test="${arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'RDCNT' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'CTG_CD'  }">
                                    <c:choose>
                                        <%--  성공스토리인 경우  --%>
                                        <c:when test="${boardConfVo.bbsCd eq '1009'}">
                                            <c:if test="${arrange.columnId eq 'REGIST_ID'}">
                                                <tr>
                                                    <td>
	                                                    <c:choose>
	                                                        <c:when test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
	                                                            <span class="name"><c:out value='${dataVo.registId}'/></span>
	                                                        </c:when>
	                                                        <c:otherwise>
	  	                                                        <span class="name"><c:out value='${dataVo.maskRegistId}'/></span>
	  	                                                        <span class="inquiry"> | 조회수 <c:out value='${dataVo.rdcnt}'/></span>
	                                                        </c:otherwise>
	                                                    </c:choose>
	                                                </td>    
                                            </c:if>                                    
                                            <c:if test="${arrange.columnId eq 'REGIST_DT'}">
                                                    <td class= "ar">
                                                       <div class="cont_r">
                                                           <span class="date"><c:out value='${dataVo.registDt}'/></span>                                                   
                                                      </div>
                                                   </td>
                                               </tr>
                                           </c:if>
                                        </c:when>

                                        <%--  공지사항인 경우  --%>
                                        <c:when test="${boardConfVo.bbsCd eq '1001'}"> 
                                            <c:if test="${arrange.columnId eq 'REGIST_ID'}">
                                                <tr>
                                                    <td class="al">
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
                                                | 조회수 <c:out value='${dataVo.rdcnt}'/>
                                                    </td>
                                            </c:if>
                                            
                                            <c:if test="${arrange.columnId eq 'REGIST_DT'}">
                                                    <td class= "ar">
                                                       <div class="cont_r">
                                                           <span class="date"><c:out value='${dataVo.registDt}'/></span>
                                                           <ul class="function">
                                                               <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002'}">
                                                                   <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                                                                       <li><a href="#" class="btns st2 icn icnModi" onclick="jsUpdateForm('UPDATE');">수정</a></li>
                                                                       <li><a href="#" class="btns st2 icn icnDel"  onclick="jsDelete();">삭제</a></li>
                                                                   </c:if>
                                                               </c:if>
                                                           </ul>
                                                       </div>
                                                    </td>
                                               </tr>
                                           </c:if>                                   
                                        </c:when>
                                        
                                        <%-- 공지사항/성공스토리 이외의 게시판일 경우 --%>
                                        <c:otherwise>
                                        	<c:if test="${arrange.columnId eq 'REGIST_ID' and arrange.columnId eq 'RDCNT' and arrange.columnId eq 'REGIST_DT'}">
	                                            <c:if test="${arrange.columnId eq 'REGIST_ID'}">
	                                                <tr>
	                                                    <td class="al">
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
	                                                | 조회수 <c:out value='${dataVo.rdcnt}'/>
	                                                    </td>
	                                            </c:if>
	                                            
	                                            <c:if test="${arrange.columnId eq 'REGIST_DT'}">
	                                                    <td class= "ar">
	                                                        <div class="cont_r">
	                                                            <span class="date">AAA<c:out value='${dataVo.registDt}'/></span>
	                                                        </div>
	                                                    </td>
	                                                </tr>
	                                            </c:if>
                                            </c:if>
                                            <c:if test="${arrange.columnId ne 'REGIST_ID' and arrange.columnId ne 'RDCNT' and arrange.columnId eq 'REGIST_DT'}">
                                            	<tr>
                                                	<td class="ar" colspan="2">
                                                        <div class="cont_r">
                                                            <span class="date"><c:out value='${dataVo.registDt}'/></span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <%-- //등록자 / 조회수 / 등록일자 영역 --%>
                                
                                
                                <%-- 게시글 내용 및 첨부파일 영역 --%>
                                <c:when test="${arrange.columnId eq 'BBSCTT_CN' or arrange.columnId eq 'FILE_SEQ'}">
                                    <c:if test="${arrange.columnId eq 'BBSCTT_CN'}">
                                        <c:choose>
                                            <%-- 지식맵 게시판[1013] 형태인 경우 --%>
                                            <c:when test="${boardConfVo.bbsCd eq '1013'}">
                                                <c:set var="map_bbscttCn" value="${fn:replace(dataVo.bbscttCn, '<br>', '')}" />
                                                <c:set var="map_bbscttCn" value="${fn:replace(map_bbscttCn, '<br />', '')}" />
                                                <tr>
                                                    <td colspan="2" class="last">
                                                        <div class="cont_view" style="text-align: left;">
                                                            <c:out value="${map_bbscttCn}" escapeXml="false" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:when>

                                            <%-- 지식맵 게시판 이외의 게시판일 경우 --%>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="2"> 
                                            	        <div class="txt-cont">
                                            	        <%-- <pre>${dataVo.bbscttCn}</pre> --%>
                                            		        <%-- <c:out value='${dataVo.bbscttCn}' escapeXml="false" /> --%>
                                            		        <c:if test="${boardConfVo.bbsCd eq '1029'}">
	                                            		        <c:set var="map_bbscttCn" value="${fn:replace(dataVo.bbscttCn, '<br>', '')}" />
	                                            		        <c:set var="map_bbscttCn" value="${fn:replace(map_bbscttCn, '<br />', '')}" />
	                                            		        <c:out value="${map_bbscttCn}" escapeXml="false" />
                                            		        </c:if>
                                            		        <c:if test="${boardConfVo.bbsCd ne '1029'}">
                                            		        	<c:out value="${dataVo.bbscttCn}" escapeXml="false" />
                                            		        </c:if>
                                            	            <%-- 첨부파일 영역 - 성공사례는 파일이 나오지않음  --%>
                                                            <c:if test="${boardConfVo.bbsCd ne '1009' && fn:length(dataVo.fileList) > 0}">
                                                                <div class="file_area">
                                                                    <c:choose>
                                                                        <c:when test="${fn:length(dataVo.fileList) > 0}">|&nbsp;
                                                                            <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                                                <span class="file">
                                                                                <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})</span>&nbsp;|&nbsp;
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
<!--                                                                 <span class="file">첨부파일이 없습니다.</span> -->
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:if>
                                                            <%-- //첨부파일 영역 - 성공사례는 파일이 나오지않음  --%>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:when>
                                <%-- //게시글 내용 및 첨부파일 영역 --%>

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
                        	<c:if test="${!empty dataVo.bbsTags}">
                            <tr>
                                <td colspan="2">
                                    <div class="tag">
	                                    <img src="/resources/openworks/theme/default/images/icon/icon_tag.gif" alt="태그" class="vm" />
	                                    <c:forEach var="tag" items="${dataVo.bbsTags}" varStatus="status">
	                                        <a href="#" onclick="jsShowBbsListByTag('<c:out value='${tag}'/>')">${tag}</a> <c:if test="${not status.last}">|</c:if>
	                                    </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                        </c:if>
                        <!-- //태그 -->
                    </tbody>
                    <!-- //tbody -->
                </table>
                <!-- //내용보기 -->

                <!-- 댓글영역 -->
                <c:if test="${boardConfVo.cmtYn eq 'Y' and boardConfVo.bbsCd ne '1007' and boardConfVo.bbsCd ne '1009' and boardConfVo.bbsCd ne '1013'}">
                    <br/>
                    <div id="attachedCommentsDiv"></div>
                </c:if>
                <!-- 댓글영역 -->
	
            </div>
            <!-- //view -->

            <!-- 하단버튼 영역 -->
            <!-- {{BH, 2015.12.24 지식맵 하단의 목록버튼 제거로인한 소스추가-->
            <c:if test="${boardConfVo.bbsCd ne '1013'}">
            <!-- }} -->
            <!-- <div class="btn-area mt20"> -->
			    <div class="btnArea rig">
                    <!-- <p class="fr"> -->
			            <%-- <a href="#" class="btns st1 icn icnList"  return false;" onclick="jsList('<c:out value='${param.q_currPage}'/>');">목록보기</a> --%>
			        <!-- </p> -->
                    <c:if test="${boardConfVo.bbsCd ne '1009' and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002' and boardConfVo.bbsCd ne '1019'}">
	                    <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
	                        <!-- <p class="fr"> -->
	                            	<a href="#" class="btns st2 icn icnModi" return false;" onclick="jsUpdateForm('UPDATE');">수정</a>
                                	<a href="#" class="btns st2 icn icnDel"  return false;" onclick="jsDelete();">삭제</a>
	                       <!--  </p> -->
	                    </c:if>
                    </c:if>
			            <a href="#" class="btns st1 icn icnList"  return false;" onclick="jsList('<c:out value='${param.q_currPage}'/>');">목록보기</a>                    
			    </div>
            <!-- </div> -->
            <!-- {{BH, 2015.12.24 지식맵 하단의 목록버튼 제거로인한 소스추가-->
            </c:if>
            <!-- }} -->
            <!-- //하단버튼 영역 -->

            <!-- 목록 보여주기 시작 -->
	        <form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
	            <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
	            <op:pagerParam view="view" />
	            <input type="hidden" name="domainCd"                value="<c:out value='${dataVo.domainCd}'/>" />
	            <input type="hidden" name="bbsCd"                   value="<c:out value='${dataVo.bbsCd}'/>" />
	            <input type="hidden" name="bbscttSeq"               value="<c:out value='${dataVo.bbscttSeq}'/>" />
	            <input type="hidden" name="ctgCd"     id="ctgCd"    value="<c:out value='${dataVo.ctgCd}' />" />
	            <input type="hidden" name="pageType"  id="pageType" value="<c:out value=''/>" />
	        </form>	

        </div>
	    <!-- //section -->
    <!-- </div> -->
	<!-- //contents -->