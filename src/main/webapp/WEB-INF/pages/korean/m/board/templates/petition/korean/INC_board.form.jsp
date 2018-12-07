<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

        	<!-- contents -->
			<div class="contents">
				<!-- title-area -->
				<div class="title-area">
					<h2>묻고 답하기</h2>					
				</div>
				<!-- //title-area -->
				
				<!-- section -->
				<div class="section">
					<!-- write -->
					<div class="type-write-board">
						<table>
							<caption>글쓰기</caption>
							<colgroup>
							<col style="width:110px;"/>
							<col style="width:;"/>
							</colgroup>							
							<tbody>
								<tr>
									<th><span>구분</span></th>
									<td>
										<c:if test="${boardConfVo.ctgYn eq 'Y'}">
											<!-- static select -->
											<div class="select-area">
												<!-- select box -->
												<div class="sech_form">
													<div class="cont_wrap">
														<div class="selected">
															<select id="ctgCd" name="ctgCd" title="구분을 선택해주세요" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 115px; position: absolute; left: -100000px; height: auto;">
																<option value="">선택해 주세요.</option>
							                                    <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
							                                        <option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>><c:out value='${ctgVo.ctgNm}'/></option>
							                                    </c:forEach>
															</select>
														</div>
													</div>
												</div>
												<!-- //select box -->
											</div>
											<!-- //static select -->
			                            </c:if>
									</td>
								</tr>
								<tr>
									<th><span>제목</span></th>
									<td>
										<input type="text" name="bbscttSj" id="bbscttSj" class="w700" title="제목을 입력해주세요" value="${dataVo.bbscttSj}" />
									</td>
								</tr>
								<c:if test="${ boardConfVo.noticeBbscttUseYn eq 'Y' }">
				                    <tr>
				                        <th><span>기본 설정 *</span></th>
				                        <td>
				                            <c:choose>
				                                <c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
				                                    <input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="Y"<c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
				                                    <label for="noticeBbscttAt">&nbsp;공지로 지정</label>
				                                </c:when>
				                                <c:otherwise>
				                                    <input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='N' />"/>
				                                </c:otherwise>
				                            </c:choose>
				                        </td>
				                    </tr>
				                </c:if>
				                <tr>
									<td colspan="2">
										<div id="contentsErrorDiv"></div>
										<c:if test="${boardConfVo.userEditorYn eq 'Y'}" >
				                            <textarea name="bbscttCn" id="bbscttCn" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
				                            <script type="text/javascript">
				                                //<![CDATA[
				                                CKEDITOR.replace('bbscttCn', {
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
				                            <textarea name="bbscttCn" id="bbscttCn" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
				                        </c:if>
									</td>
								</tr>
								<!-- 파일 업로드 -->
				                <c:if test="${boardConfVo.fileYn eq 'Y'}" >
				                    <tr>
				                        <th><span>첨부파일</span></th>
				                        <td>
				                            <c:if test="${pageType eq 'UPDATE'}">
				                                <c:if test="${fn:length(dataVo.fileList) > 0}">
				                                    <p class="tx_blue_s">
				                                        - 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요.
				                                    </p>
				                                    <ul>
				                                        <c:forEach items="${dataVo.fileList}" var="fileVo">
				                                            <li class="mar_b5">
				                                                <a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '<c:out value='${fileVo.fileId}'/>');"><img src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />" alt="삭제" class="vm" /></a>
				                                                <c:out value='${fileVo.localNm}'/> <span class="tx_gray vm">(download <c:out value='${fileVo.downCnt}'/>, <c:out value='${fileVo.fileSize}'/>, <c:out value='${fileVo.fileType}'/>)</span>
				                                            </li>
				                                        </c:forEach>
				                                    </ul>
				                                </c:if>
				                            </c:if>
				                            <input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>"/>
				                            <input type="file"  name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기"  style="width:570px; height: 24px;"/>
				                            <div id="multiFilesListDiv" class="regist-file"></div>
				                            <p class="caption mt10">
				                                * <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if>최대 ${boardConfVo.maxFileCnt}개까지 업로드 할 수 있습니다.
				                                <c:if test="${boardConfVo.maxFileSize > 0}">파일당 ${boardConfVo.maxFileSize}MB</c:if>
				                                <c:if test="${(boardConfVo.maxFileSize > 0) && (boardConfVo.totalFileSize > 0)}">, </c:if>
				                                <c:if test="${boardConfVo.totalFileSize > 0}">전체 ${boardConfVo.totalFileSize}MB</c:if>
				                                <c:if test="${(boardConfVo.maxFileSize > 0) || (boardConfVo.totalFileSize > 0)}"> 업로드 할 수 있습니다.</c:if>
				                            </p>
				                            <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>"/>
				                        </td>
				                    </tr>
				                </c:if>
				                <c:if test="${ boardConfVo.othbcYn eq 'Y' }">
				                    <tr>
				                        <th><span>공개여부</span></th>
				                        <td>
				                            <c:choose>
				                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
				                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if>  />
				                                    <label for="othbcAtY" class="space">&nbsp;공개</label>
				                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> />
				                                    <label for="othbcAtN">&nbsp;비공개</label>
				                                </c:when>
				                                <c:otherwise>
				                                    <input type="hidden" name="othbcAt" value="<c:out value='Y' />"/>
				                                </c:otherwise>
				                            </c:choose>
				                        </td>
				                    </tr>
				                </c:if>
				                <!-- 태그 입력 -->
				                <c:if test="${boardConfVo.tagYn eq 'Y'}">
				                    <tr>
				                        <th><span>태그</span></th>
				                        <td>
				                        	<input type="text" name="bbsTags" id="bbsTags" class="w700" value="${fn:join(dataVo.bbsTags, ',')}" title="태그"/>
											<p class="caption mt10">* 쉼표로 구분하여 태그를 입력해 주세요.</p>
				                        </td>
				                    </tr>
				                </c:if>
							</tbody>
						</table>
					</div>
					<!-- //write -->
					<!-- btn area -->
					<div class="btn-area ar mt20">
						<a href="#" onclick="jsSubmit();" class="b-btn save type2"><strong><span>저 장</span></strong></a>
						<a href="#" onclick="jsCancel(); return false;" class="b-btn cancel type1"><strong><span>취 소</span></strong></a>
					</div>
					<!-- //btn area -->
					<div class="btn-area mt20">
				         <ul>
				             <li>고객님의 소중한 의견을 수렴하는 공간입니다. 씨앗 소프트웨어에 바라는 내용을 등록해 주세요.</li>
				             <li>상업적 글이나 무고, 욕설, 비방, 개인정보등과 관련된 글을 올리는 경우 삭제 될 수 있습니다.</li>
				         </ul>
				     </div>
				</div>
				<!-- //section -->
			</div>
			<!-- //contents -->