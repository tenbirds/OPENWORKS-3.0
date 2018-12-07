<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

    <div class="contents">
					<!-- section -->
					<div class="section">
					<!-- 답변 달기 -->
				
		
			            <table class="tbl_st2">
			                <caption>
				                <strong>${dataVo.bbscttSj} 답변달기</strong>
				                <details>
				                    <summary>${dataVo.bbscttSj} 답변달기 폼입니다.</summary>
				                </details>
				            </caption>
			                <colgroup>
			        			<col style="width:100px;"/>
								<col style="width:;"/>
			                </colgroup>
			                <tbody>
			                    <tr>
			                        <td class="tit" align="left">제목</td>
									<td class="last">						
										<input type="text" name="bbscttSj"
										id="bbscttSj" class="input" style="width: 700px;"
										title="제목을 입력해주세요" value="<c:out value='${dataVo.bbscttSj}'/>" />
									</td>
								</tr>
								<!-- 썸네일, 서비스 (서비스리뷰 사용) -->
								<c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd eq '1008' }">
									<tr>
										<td class="tit"><label for="multiFiles">썸네일</label></td>
										<td class="last">
											<div class="file">
												<c:if test="${pageType eq 'UPDATE'}">
													<c:if test="${fn:length(dataVo.fileList) > 0}">
														<p class="tx_blue_s">- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 
														<span class="tx_red">X 아이콘을 클릭</span>하세요.
														</p>
														<ul>
															<c:forEach items="${dataVo.fileList}" var="fileVo">
																<li class="mar_b5">
																	<a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '<c:out value='${fileVo.fileId}'/>');">
																	<img alt="삭제" src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />"></img></a>
																	${fileVo.localNm} <span class="tx_gray vm">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
																</li>
															</c:forEach>
														</ul>
													</c:if>
												</c:if>
												<input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>" />
												<input type="file" name="multiFiles" id="multiFiles"
													<c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if>
													value="찾아보기" style="width: 700px; height: 24px; border: 1px solid #ccc;" />
												<div id="multiFilesListDiv" class="regist-file"></div>
												
											</div> <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>" /> <br />
											<div class="guide_txt">※ 리스트에 표시되는 이미지 입니다. ${boardConfVo.maxFileSize}MB 미만의 파일만 업로드 가능합니다.</div>
											<div class="guide_txt">
												※
												<script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script>
												형식의 ${boardConfVo.totalFileSize}MB 미만 파일만 업로드 가능합니다.
											</div>
											<div class="guide_txt">※ 업로드된 파일은 640 x 480 사이즈로 확대 또는 축소되어 표시됩니다.</div>
										</td>
									</tr>
							<tr>
								<td class="tit">서비스</td>
								<td class="last">
									<div>
										<input type="text" id="estnColumn7" name="estnColumn7"
											title="서비스 입력" readonly="readonly" class="input"
											style="width: 500px;"
											value="<c:out value='${dataVo.goodsNm}'/>" /> <span
											class="btn_light_gray02" style="overflow: inherit;"> <a
											href="#" onclick="jsProductPop(this);" title="팝업 창 열림">서비스선택</a>
										</span>
									</div>
									<div class="guide_txt">※ 구매한 서비스 중에 선택 가능하며 구매한 서비스의 리뷰에 표시됩니다.</div>
								</td>
							</tr>
						</c:if>
						<!-- 내용 -->
						<tr>
							<td class="last" colspan="2">
								<label for="bbscttCn"></label>
								<div id="contentsErrorDiv"></div> 
								<c:if test="${boardConfVo.userEditorYn eq 'Y'}">
									<textarea name="bbscttCn" id="bbscttCn" rows="15" style="width: 690px; height: 360px;resize:none;" cols="30" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
									<!-- <textarea name="bbscttCn" id="htmlContent" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.bbscttCn}</textarea> -->
									<script type="text/javascript">
			                           	//<![CDATA[
			                           	CKEDITOR.replace('bbscttCn', {
			                               	height : 200,
			                               	enterMode : "2",
			                               	skin : "moono",
			                               	toolbar : toolbar_config.default_toolbar,
			                               	allowedContent: true,
			                               	filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
			                           	});
			                           	//]]>
		                           	</script>
								</c:if>
								<c:if test="${boardConfVo.userEditorYn eq 'N'}">
									<textarea name="bbscttCn" id="bbscttCn" rows="15" style="width: 767px; height: 360px;resize:none;" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
								</c:if>
							</td>
						</tr>
		
						<!-- 분류 / 공지 지정여부 / 공개여부 -->
						<c:if test="${boardConfVo.ctgYn eq 'Y' or boardConfVo.noticeBbscttUseYn eq 'Y' or boardConfVo.othbcYn eq 'Y'}">
							<tr>
								<th><span>기본 설정 *</span></th>
								<td class="last">
									<!-- static select -->
									<div class="select-area">
										<!-- select box -->
										<div class="sech_form">
											<div class="cont_wrap">
												<div class="selected">
													<c:if test="${boardConfVo.ctgYn eq 'Y'}">
														<c:if test="${param.bbsCd ne 1031}">
															<select name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 115px; position: absolute; left: -100000px; height: auto;">
																<option value="">분류 선택</option>

																<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
																	<option value="<c:out value='${ctgVo.ctgCd}'/>"
																	<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
																</c:forEach>
															</select>
														</c:if>
														
														<c:if test="${param.bbsCd eq 1031}">
														
															<select id="q_searchKeyType" name="q_searchKeyType" title="분류를 선택해주세요" onchange="aditCtgSel(this.value);"  style="width: 115px; position: absolute; left: -100000px; height: auto;">
															<!-- <select name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="aditCtgSel();" style="width: 115px; position: absolute; left: -100000px; height: auto;"> -->
																<option value="">구분선택 1</option>
																<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
																	<option value="<c:out value='${ctgVo.ctgCd}'/>"
																	<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
																</c:forEach>
															</select>
														&nbsp;
														<span id="aditCtgList">
						                 <select id="aditCtgCd" name="aditCtgCds" title="분류를 선택해주세요" style="width: 115px; position: absolute; left: -100000px; height: auto;">
					                     <option value="">구분선택 2</option>
					                      <c:forEach items="${aditCtgList}" var="ctgVo">
					                          <option value="${ctgVo.aditCtgCd}" <c:if test='${ctgVo.aditCtgCd == dataVo.estnColumn1}' > selected='selected'</c:if>>${ctgVo.aditCtgNm}</option>
					                      </c:forEach>
						                 </select>
						                 </span>
					                 </c:if>
													</c:if>
												</div>
											</div>
										</div>
									</div>						 					
								<c:choose>
									<c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
										<input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='Y'/>"
										<c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
										<label for="noticeBbscttAt">&nbsp;공지로 지정</label>
									</c:when>
									<c:otherwise>
										<input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='N'/>" />
									</c:otherwise>
								</c:choose> 
								<c:choose>
									<c:when test="${boardConfVo.othbcYn eq 'Y'}">
										<input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="<c:out value='N'/> <c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> onclick=" $('#registPasswordTR').show();" />
										<label for="othbcAtN">&nbsp;비공개</label>
										<input type="radio" class="radio" name="othbcAt" id="othbcAtY"
										value="<c:out value='Y'/>  <c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if> onclick=" $('#registPasswordTR').hide();" />
										<label for="othbcAtY">&nbsp;공개</label>
									</c:when>
									<c:otherwise>
										<input type="hidden" name="othbcAt" value="<c:out value='Y'/>" />
									</c:otherwise>
								</c:choose></td>												
							</tr>
						</c:if>
						<!-- 확장 컬럼 입력 -->
						<c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
							<c:if test="${!empty extensionVo.columnTy}">
								<tr>
									<td class="tit">${extensionVo.langColumnNm}
										<c:if test="${extensionVo.essntlYn eq 'Y'}">
											<span class="tx_red tx_b"> *</span>
										</c:if></td>
									<td class="last"><c:choose>
											<c:when test="${extensionVo.columnTy eq 'TEXT'}">
												<input name="${extensionVo.beanName}" id="${extensionVo.beanName}"
													value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>"
													type="text" class="w85_p" />
											</c:when>
											<c:when test="${extensionVo.columnTy eq 'TEXTAREA'}">
												<textarea name="${extensionVo.beanName}" id="${extensionVo.beanName}" cols="30" rows="3" class="w99_p" style="resize:none;">
												<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}" /></textarea>
											</c:when>
											<c:when test="${extensionVo.columnTy eq 'DATE'}">
												<input name="${extensionVo.beanName}" id="${extensionVo.beanName}"
													value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>"
													type="text" maxlength="14" /> 예 : 20120101093000
		                                   <p class="tx_blue_s">- 반드시 년월일시분초(14자리)까지 입력해야 합니다.</p>
											</c:when>
											<c:when test="${extensionVo.columnTy eq 'EMAIL'}">
												<input name="${extensionVo.beanName}" id="${extensionVo.beanName}"
													value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>"
													type="text" class="w200" />
											</c:when>
										</c:choose> <c:if test="${not empty extensionVo.columnCm}">
											<p class="tx_blue_s">- ${extensionVo.columnCm}</p>
										</c:if></td>
								</tr>
							</c:if>
						</c:forEach>
		
						<!-- 파일 업로드 -->
						<c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd ne '1008'}">
							<tr>
								<td class="tit" align="left"><label for="multiFiles">첨부파일</label></td>
								<td >
									<!-- div class="file" -->
									<c:if test="${pageType eq 'UPDATE'}">
										<c:if test="${fn:length(dataVo.fileList) > 0}">
											<p class="tx_blue_s">										
												- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 
												<span class="tx_red">X 아이콘을 클릭</span>하세요.
											</p>
											<ul>
												<c:forEach items="${dataVo.fileList}" var="fileVo">
													<li class="mar_b5">
													<a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '<c:out value='${fileVo.fileId}'/>');">
													<img alt="삭제" src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />" class="vm"/></a> 
													<c:out value='${fileVo.localNm}' /> 
													<span class="tx_gray vm">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
													</li>
												</c:forEach>
											</ul>
										</c:if>
									</c:if>
									<input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>" />
									<input type="file" name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기"/>
									<div id="multiFilesListDiv" class="regist-file"></div>
									<input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>" />
									<!-- /div -->
									<p class="caption mt20"> *
										<c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }">
											<script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if>
										형식의 ${boardConfVo.maxFileSize} MB 미만 파일만 업로드 가능합니다.
									</p>
								</td>
							</tr>
						</c:if>
		
						<!-- 태그 입력 -->
						<c:if test="${boardConfVo.tagYn eq 'Y'}">
							<tr>
								<td class="tit" align="left"><label for="bbsTags">태그</td>
								<td class="last"><input type="text" name="bbsTags"
									id="bbsTags" value="${fn:join(dataVo.bbsTags, ',')}"
									title="태그 입력" class="input" style="width: 700px;" />
									<p class="tx_blue_s">* 쉼표로 구분하여 태그를 입력해 주세요.</p></td>
							</tr>
						</c:if>
		
					</tbody>
				</table>
				<!-- //내용쓰기 -->
				</div>
				<!-- //write -->
				<!-- 버튼 -->
				<br /></br />
				<div class="btnArea rig">
					<a href="#" onclick="jsSubmit();" class="btns st1 icn icnSave">저 장</a>
					<a href="#" onclick="jsList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>		
				<!-- //버튼 -->
			</div>
			<!-- //section -->
		</div>
		<!-- //contents -->