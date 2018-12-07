<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
			<div class="knowHub write">
				<p>
					찾고자 하는 클라우드서비스가 없는 경우 또는 어떤 솔루션, 서비스를 선택해야 하는지 모를 때 문의 글을 등록하면 전문가(제공자) 들과 매칭시켜주는 서비스입니다.
				</p>
				<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return false;">
                <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
                <op:pagerParam view="view" />
                <input type="hidden" name="setCtgryCodes" id="setCtgryCodes" value="" />
                <input type="hidden" name="langCode" id="langCode" value="<c:out value='${dataVo.langCode}' />" />
                <input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}' />" />
                <input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}' />" />
                <input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}' />" />
                <input type="hidden" name="refrnSeq" value="<c:out value='${dataVo.refrnSeq}' />" />
                <input type="hidden" name="bbscttOrdrNo" value="<c:out value='${dataVo.bbscttOrdrNo}' />" />
                <input type="hidden" name="bbscttDp" value="<c:out value='${dataVo.bbscttDp}' />" />
                <input type="hidden" name="mngrId" value="<c:out value='${dataVo.mngrId}' />" />
                <input type="hidden" name="brwsrAgent" id="brwsrAgent" value="<c:out value='${dataVo.brwsrAgent}' />" />
                <input type="hidden" name="estnColumn1" id="estnColumn1" value="<c:out value='${dataVo.estnColumn1}' />" />
                <input type="hidden" name="estnColumn2" id="estnColumn2" value="<c:out value='${dataVo.estnColumn2}' />" />
                <input type="hidden" name="estnColumn6" id="estnColumn6" value="<c:out value='${dataVo.estnColumn6}' />" />
                <input type="hidden" name="estnColumn5" id="estnColumn5" value='N' />
                <table class="tbl_st4" id="goodsCtgry">
					<tr>
						<th class="requ">연결된 카테고리</th>
						<td>
							<a href="#" onclick="jsCtgrySelPop(this);" class="btns st3">카테고리 선택</a>
							※ 카테고리 선택은 최대 3개 까지 가능합니다.
							<p class="desc">
								<c:forEach items="${dataVo.ctgryList}" var="ctgryVo" varStatus="status">
		                        [<c:out value='${ctgryVo.ctgryClNm }'/>] <c:out value='${ctgryVo.ctgryPath}'/><c:if test="${!status.last}">, </c:if>
		                        <input type="hidden" name="ctgryCds" id="ctgryCds" class="getCtgryCodes" value="<c:out value='${ctgryVo.ctgryCode}'/>" />
		                        </c:forEach>
							</p>
						</td>
					</tr>
					<tr>
						<th>희망 답변자</th>
						<td>
							<a href="#" onclick="jsCtgryUserSelPop(this);" class="btns st3">전문가 선택</a>
							※ 전문가 선택은 최대 5개 기업 까지 가능합니다
							<p id="viewCtgryUserNms" class="desc">
								<c:out value='${dataVo.estnColumn2 }'/>
							</p>
						</td>
					</tr>
					<tr>
						<th class="requ">제목</th>
						<td><input type="text" name="bbscttSj" id="bbscttSj" class="w603" title="제목을 입력해주세요" value="<c:out value='${dataVo.bbscttSj}'/>"/></td>
					</tr>
					<!-- 확장 컬럼 입력 -->
                    <c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
                        <c:if test="${!empty extensionVo.columnTy}">
							<tr>
								<th>종료일</th>
								<td class="term">
									<c:choose>
                                    	<c:when test="${extensionVo.columnTy eq 'TEXT'}">
                                    		<c:choose>
                                            	<c:when test="${extensionVo.columnId  eq 'ESTN_COLUMN6' }">
                                            		<input type="text" id="endDt" name="endDt" value="${param.endDt}" title="종료일 입력" readonly="readonly"/>
                                               		<!-- static select -->
                                               		<span class="sel_box">
														<select id="endHH" name="endHH" title="종료일 시 선택">
                                               				<c:forEach begin="0" end="23" varStatus="sts" >
                                                   				<c:set value="${sts.index >= 0 and sts.index < 10 ? '0':''}${sts.index}" var="endHH"/>
                                                   				<option value="${endHH}" ${fn:substring(dataVo.estnColumn6,11,13) eq endHH? 'selected':''} >
                                                   					<c:if test="${sts.index >= 0 and sts.index < 10 }">0</c:if>${sts.index}
                                                   				</option>
                                               				</c:forEach>
                                           				</select>
													</span>
													시
													<%-- <div class="select-area">
														<!-- select box -->
														<div class="sech_form">
															<div class="cont_wrap">
																<div class="selected">
																	<select id="endHH" name="endHH" title="종료일 시 선택" style="width: 115px; position: absolute; left: -100000px; height: auto;">
                                                        				<c:forEach begin="0" end="23" varStatus="sts" >
                                                            				<c:set value="${sts.index >= 0 and sts.index < 10 ? '0':''}${sts.index}" var="endHH"/>
                                                            				<option value="${endHH}" ${fn:substring(dataVo.estnColumn6,11,13) eq endHH? 'selected':''} >
                                                            					<c:if test="${sts.index >= 0 and sts.index < 10 }">0</c:if>${sts.index}
                                                            				</option>
                                                        				</c:forEach>
                                                    				</select>
																</div>														
															</div>
														</div>
														<!-- //select box -->
													</div>
													<!-- //static select -->
													<span class="space">시</span> --%>
													<!-- static select -->
													<span class="sel_box">
														<select id="endMM" name="endMM" title="종료일 분 선택">
                                                       		<c:forEach begin="0" end="60" step="1" varStatus="sts" >
	                                                           	<c:set value="${sts.index >= 0 and sts.index < 10 ? '0':''}${sts.index}" var="endMM"/>
	                                                           	<option value="${endMM}"  ${fn:substring(dataVo.estnColumn6,14,16) eq endMM? 'selected':''}>
	                                                           	<c:if test="${sts.index >= 0 and sts.index < 10 }">0</c:if>${sts.index}
	                                                           	</option>
                                                         	</c:forEach>
                                                  		</select>
													</span>
													분
													<!-- //static select -->
													<p class="desc">※ 입력이 없을시 오늘로부터 30일을 더한 날짜로 자동 저장됩니다.</p>
                                               </c:when>
                                               <c:otherwise>
                                                   <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" />
                                               </c:otherwise>
                                           </c:choose>
                                        </c:when>
                                        <c:when test="${extensionVo.columnTy eq 'TEXTAREA'}">
                                            <textarea name="${extensionVo.beanName}" id="${extensionVo.beanName}" cols="30" rows="3" class="w99_p"><op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/></textarea>
                                        </c:when>
                                        <c:when test="${extensionVo.columnTy eq 'DATE'}">
                                            <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" maxlength="14" /> 예 : 20120101093000
                                            <p class="tx_blue_s">- 반드시 년월일시분초(14자리)까지 입력해야 합니다.</p>
                                        </c:when>
                                        <c:when test="${extensionVo.columnTy eq 'EMAIL'}">
                                            <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" class="w200" />
                                        </c:when>
                                    </c:choose>
                                    <c:if test="${not empty extensionVo.columnCm}">
                                        <p class="tx_blue_s">- ${extensionVo.columnCm}</p>
                                    </c:if>
								</td>
							</tr>
						</c:if>
                    </c:forEach>
					<!-- 내용 -->        
					<tr>
						<th class="requ">내용</th>
						<td class="text">
							<div id="contentsErrorDiv"></div>
                            <c:if test="${boardConfVo.userEditorYn eq 'Y'}" >
                                <textarea name="bbscttCn" id="bbscttCn" rows="15"  style="width:817px; height:244px;" cols="30" onkeyup="javascripｔ:cal_pre();" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
                                    <script type="text/javascript">
                                    //<![CDATA[
                                    CKEDITOR.replace('htmlContent', {
                                        height : 200,
                                        enterMode : "2",
                                        skin : "moono",
                                        allowedContent: true,
                                        toolbar : toolbar_config.default_toolbar,
                                        filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
                                    });
                                    //]]>
                                    </script>
                            </c:if>
                            <c:if test="${boardConfVo.userEditorYn eq 'N'}" >
                                <textarea name="bbscttCn" id="bbscttCn" rows="15" class="h210" onkeyup="javascripｔ:cal_pre();" title="내용을 입력해주세요" placeholder="장시간 내용 작성시 세션이 끊겨 작성중인 내용이 사라질 수 있으니 주의하시기 바랍니다.">${dataVo.bbscttCn}</textarea>
                            </c:if>
							<p class="desc"><input type="hidden" name="contentsByteCntDiv" id="contentsByteCntDiv" class="input" style="border:0px; width:40px; text-align:right !important" value="0"/><i id="contentByteCntEm">0</i>byte / 20000byte</p>
						</td>
					</tr>
					<!-- 파일 업로드 -->
		            <c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd ne '1008'}" >                
					<tr>
						<th>첨부파일</th>
						<td>
							<!-- file upload -->
							<input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}' />" />
							<input type="file" name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> title="파일찾기"/>
							<div id="multiFilesListDiv" class="regist-file"></div>
							<input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}' />" />
							<c:if test="${pageType eq 'UPDATE'}">
                                <c:if test="${fn:length(dataVo.fileList) > 0}">
                                    <c:forEach items="${dataVo.fileList}" var="fileVo">
                                    	<p class="uploaded">
							            	<span>
							            		${fileVo.localNm}
							            		<a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '${fileVo.fileId}');">삭제</a>
							            	</span>
							            </p>
                                    </c:forEach>
                                </c:if>
                            </c:if>
				            <p class="desc">
				            	※ <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> 파일 첨부 가능<br /></c:if>
				             	형식의 ${boardConfVo.maxFileSize} MB 미만 파일만 업로드 가능합니다.
				            </p>
						</td>
					</tr>
					</c:if>
				</table>
				
				<div class="btnArea rig">
					<a href="#" onclick="jsSubmit();" class="btns st1 icn icnSave">저 장</a>
					<a href="#" onclick="jsList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>
				</form>
			</div>