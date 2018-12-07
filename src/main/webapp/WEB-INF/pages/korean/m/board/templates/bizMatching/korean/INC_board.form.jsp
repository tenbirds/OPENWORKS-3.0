<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

		<!-- container -->
		<div id="container" class="join-wrap">

			<!-- contents -->
			<div class="contents">
				<!-- title-area -->
				<div class="title-area">
					<h2>비즈매칭</h2>
					<p class="ml20 txt-explain">찾고자 하는 서비스가 없는 경우 또는 어떤 솔루션, 서비스를 선택해야 하는지 모를 때 <span class="txt-point">찾고자 하는 서비스를 등록하면 판매자들과 매칭시켜주는 서비스</span>입니다.</p>
				</div>
				<!-- //title-area -->
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
                <input type="hidden" name="estnColumn6" id="estnColumn6" value="<c:out value='${dataVo.estnColumn6}' />" />
                <input type="hidden" name="estnColumn5" id="estnColumn5" value='N' />
				<!-- section -->
				<div class="section">				

					<div class="join-area mt30">					
						<div class="type-write">
							<table id="goodsCtgry">
								<colgroup>
									<col style="width:150px;" />
									<col style="width:*;" />
								</colgroup>
								<tbody>
									<tr>
										<th><span>연결된 카테고리</span></th>
										<td>
										<a href="#" onclick="jsCtgrySelPop(this);" class="s-btn radius type1"><strong><span>카테고리 선택</span></strong></a>
										<span id="ctgry" style="position: absolute;">
		                                    <c:forEach items="${dataVo.ctgryList}" var="ctgryVo">
		                                    [<c:out value='${ctgryVo.ctgryClNm }'/>] <c:out value='${ctgryVo.ctgryPath}'/><br/>
		                                    <input type="hidden" name="ctgryCds" id="ctgryCds" class="getCtgryCodes" value="<c:out value='${ctgryVo.ctgryCode}'/>" />
		                                    </c:forEach>
	                                    </span>
										</td>
									</tr>
									<tr>
										<th><span>제목</span></th>
										<td><input type="text" name="bbscttSj" id="bbscttSj" class="w603" title="제목을 입력해주세요" value="<c:out value='${dataVo.bbscttSj}'/>"/></td>
									</tr>
									<!-- 확장 컬럼 입력 -->
		                            <c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
		                                <c:if test="${!empty extensionVo.columnTy}">
											<tr>
												<th><span>종료일</span></th>
												<td>
													<c:choose>
		                                                <c:when test="${extensionVo.columnTy eq 'TEXT'}">
		                                                    <c:choose>
		                                                       <c:when test="${extensionVo.columnId  eq 'ESTN_COLUMN6' }">
		                                                       	<div class="calendar_input mr10">
																  <input type="text" class="input" id="endDt" name="endDt" value="${param.endDt}" title="종료일 입력" style="width:100px;" readonly="readonly"/>
																</div>
		                                                        <span class="txt"></span>
		                                                        <!-- static select -->
																<div class="select-area">
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
																<span class="space">시</span>
																<!-- static select -->
																<div class="select-area">
																	<!-- select box -->
																	<div class="sech_form">
																		<div class="cont_wrap">
																			<div class="selected">
																				<select id="endMM" name="endMM" title="종료일 분 선택" style="width: 115px; position: absolute; left: -100000px; height: auto;">
					                                                               <c:forEach begin="0" end="60" step="1" varStatus="sts" >
					                                                                   <c:set value="${sts.index >= 0 and sts.index < 10 ? '0':''}${sts.index}" var="endMM"/>
					                                                                   <option value="${endMM}"  ${fn:substring(dataVo.estnColumn6,14,16) eq endMM? 'selected':''}>
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
																<span class="space">분</span>
		                                                        <p class="caption mt10">※ 입력이 없을시 오늘로부터 30일을 더한 날짜로 자동 저장됩니다.</p>
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
										<th><span>내용</span></th>
										<td>
											<div id="contentsErrorDiv"></div>
		                                    <c:if test="${boardConfVo.userEditorYn eq 'Y'}" >
		                                        <textarea name="bbscttCn" id="bbscttCn" rows="15"  style="width:817px; height:244px;" cols="30" onKeyUP="javascripｔ:cal_pre();" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
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
		                                        <textarea name="bbscttCn" id="bbscttCn" rows="15" class="h210" onKeyUP="javascripｔ:cal_pre();" title="내용을 입력해주세요" placeholder="장시간 내용 작성시 세션이 끊겨 작성중인 내용이 사라질 수 있으니 주의하시기 바랍니다.">${dataVo.bbscttCn}</textarea>
		                                    </c:if>
		                                    <p class="caption ar mt10"><input type="hidden" name="contentsByteCntDiv" id="contentsByteCntDiv" class="input" style="border:0px; width:40px; text-align:right !important" value="0" readonly/><em id="contentByteCntEm">0</em>byte / 20000byte</p>
										</td>
									</tr>
									
									
									<!-- 분류 / 공지 지정여부 / 공개여부 -->
		                            <c:if test="${boardConfVo.ctgYn eq 'Y' or boardConfVo.noticeBbscttUseYn eq 'Y' or boardConfVo.othbcYn eq 'Y'}">
		                                <tr>
											<th><span>기본설정</span></th>
											<td>
												<c:if test="${boardConfVo.ctgYn eq 'Y'}">
		                                            <select id="ctgCd" name="ctgCd" title="분류를 선택해주세요">
		                                                <option value="">분류 선택</option>
		                                                <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
		                                                    <option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
		                                                </c:forEach>
		                                            </select>
		                                        </c:if>
		            
		                                        <c:choose>
		                                            <c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
		                                                <input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="Y"<c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
		                                                <label for="noticeBbscttAt">&nbsp;공지로 지정</label>
		                                            </c:when>
		                                            <c:otherwise>
		                                                <input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='N'/>"/>
		                                            </c:otherwise>
		                                        </c:choose>
<!-- 		            
		                                        <c:choose>
		                                            <c:when test="${boardConfVo.othbcYn eq 'Y'}">
		                                            	<span class="agree">
			                                            	<input type="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> onclick="$('#registPasswordTR').show();" /><label for="">비공개</label>
			                                            	<input type="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if> onclick="$('#registPasswordTR').hide();" /><label for="">공개</label>
		                                            	</span>
		                                            </c:when>
		                                            <c:otherwise>
		                                                <input type="hidden" name="othbcAt" value="<c:out value='Y'/>" />
		                                            </c:otherwise>
		                                        </c:choose>
-->
		                                        <input type="hidden" name="othbcAt" value="<c:out value='Y'/>" />
											</td>
										</tr>
		                            </c:if>
									<!-- 파일 업로드 -->
		                            <c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd ne '1008'}" >
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
                                                                    <a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '${fileVo.fileId}');"><img src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />" alt="삭제" class="vm"/></a>
                                                                    ${fileVo.localNm} <span class="tx_gray vm">(download <c:out value='${fileVo.downCnt}'/>, <c:out value='${fileVo.fileSize}'/>, <c:out value='${fileVo.fileType}'/>)</span>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </c:if>
                                                </c:if>
                                                <!-- file upload -->
												<input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}' />" />
												<input type="file" name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> title="파일찾기"/>
												<div id="multiFilesListDiv" class="regist-file"></div>
												<input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}' />" />
												<p class="caption mt20">※ <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if> 형식의 ${boardConfVo.maxFileSize} MB 미만 파일만 업로드 가능합니다.</p>
											</td>
										</tr>
		                            </c:if>
		                            <!-- 태그 입력 -->
		                            <c:if test="${boardConfVo.tagYn eq 'Y'}">
		                                <tr>
		                                    <td class="tit"><label for="bbsTags">태그</label></td>
		                                    <td class="last">
		                                        <input type="text" name="bbsTags" id="bbsTags"  value="${fn:join(dataVo.bbsTags, ',')}" title="태그 입력" class="input" style="width:570px;"/>
		                                        <p class="tx_blue_s">- 쉼표로 구분하여 태그를 입력해 주세요.</p>
		                                    </td>
		                                </tr>
		                            </c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- //section -->
				<!-- btn -->
				<div class="btn-area">
					<p class="fl">
						<a href="#" onclick="jsList(); return false;" class="b-btn list type1"><strong><span>목 록</span></strong></a>
					</p>
					<p class="fr">
						<a href="#" onclick="jsSubmit();" class="b-btn save3 mr10 type2"><strong><span>저 장</span></strong></a>
						<a href="#" onclick="jsCancel();" class="b-btn cancel type1"><strong><span>취 소</span></strong></a>
					</p>
				</div>
				<!-- //btn -->
				</form>
			</div>
			<!-- //contents -->

		</div>
		<!-- //container -->