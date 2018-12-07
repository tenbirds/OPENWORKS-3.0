<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
        <!-- 내용쓰기 -->
        <table class="tbl_view" >
            <caption>
                <strong>게시판 글입력 페이지 </strong>
                <details>
                    <summary>게시판 내용 작성페이지입니다.</summary>
                </details>
            </caption>
            <colgroup>
                <col width="20%" />
                <col width="*%" />
            </colgroup>
            <thead></thead>
            <tbody>
                <!-- 제목 -->
                <tr>
                    <td class="tit"><label for="bbscttSj">Title</label></td>
                    <td class="last">
                        <input type="text" name="bbscttSj" id="bbscttSj" class="input" style="width:570px;" title="Please enter Title" value="<c:out value='${dataVo.bbscttSj}'/>"/>
                    </td>
                </tr>
                <!-- 썸네일, 서비스 (서비스리뷰 사용) -->
                <c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd eq '1008' }" >
                    <tr>
                        <td class="tit"><label for="multiFiles">Thumbnail</label></td>
                        <td class="last">
                            <div class="file">
                                    <c:if test="${pageType eq 'UPDATE'}">
                                        <c:if test="${fn:length(dataVo.fileList) > 0}">
                                            <p class="tx_blue_s">
                                                - <span class="tx_red">click the X icon</span> below to <span class="tx_red">delete</span> the existing attachment
                                            </p>
                                            <ul>
                                                <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                    <li class="mar_b5">
                                                        <a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '<c:out value='${fileVo.fileId}'/>');"><img alt="삭제" src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />"></img></a>
                                                        ${fileVo.localNm} <span class="tx_gray vm">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </c:if>
                                    <input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>"/>
                                    <div> 
                                        <input type="file" name="multiFiles" id="multiFiles"  <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기"  style="width:570px; height: 24px; border: 1px solid #ccc ;"/>
                                        <div id="multiFilesListDiv" class="regist-file"></div>
                                    </div>
                                </div>
                                <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>"/>
                                <br/>
                                <div class="guide_txt" >※ This is the image that will be displayed in the list.</div>
                                <div class="guide_txt">※ Files less than ${boardConfVo.maxFileSize}MB in size in <script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> format can be uploaded.</div>
                                <div class="guide_txt">※ Uploaded files are enlarged or reduced to 640 x 480 pixels when they are displayed.</div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tit">Product</td> 
                        <td class="last">
                            <div >
                                <input type="text" id="estnColumn7" name="estnColumn7" title="Select Product" readonly="readonly" class="input" style="width:477px;" value="<c:out value='${dataVo.goodsNm}'/>"/>
                                <span class="btn_light_gray02" style="overflow: inherit;">
                                    <a href="#" onclick="jsProductPop(this);" title="팝업 창 열림">Select Product</a>
                                </span>
                            </div>
                            <div class="guide_txt">※ You can choose one of your purchased products and it will be displayed in the purchased product review.</div>
                        </td>
                    </tr>
                </c:if>
                <!-- 내용 -->
                <tr>
                    <td class="last" colspan="2">
                        <label for="bbscttCn">
                        <div id="contentsErrorDiv"></div>
                        <c:if test="${boardConfVo.userEditorYn eq 'Y'}" >
                            <textarea name="bbscttCn" id="bbscttCn" rows="15"  style="width:570px; height:360px;" cols="30" title="Please enter information here."  >${dataVo.bbscttCn}</textarea>
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
                        <c:if test="${boardConfVo.userEditorYn eq 'N'}" >
                            <textarea name="bbscttCn" id="bbscttCn" rows="15" style="width:720px; height:360px;" title="Please enter information here." >${dataVo.bbscttCn}</textarea>
                        </c:if>
                    </td>
                </tr>

                <!-- 분류 / 공지 지정여부 / 공개여부 -->
                <c:if test="${boardConfVo.ctgYn eq 'Y' or boardConfVo.noticeBbscttUseYn eq 'Y' or boardConfVo.othbcYn eq 'Y'}">
                    <tr>
                        <td class="tit">기본 설정 <span class="tx_red tx_b">*</span></td>
                        <td class="last">
                            <c:if test="${boardConfVo.ctgYn eq 'Y'}">
                                <select id="ctgCd" name="ctgCd" title="Please enter Classification">
                                    <option value="">Classification Select</option>
                                    <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
                                        <option value="<c:out value='${ctgVo.ctgCd}'/>" <c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
                                    </c:forEach>
                                </select>
                            </c:if>

                            <c:choose>
                                <c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
                                    <input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='Y'/>"  <c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
                                    <label for="noticeBbscttAt">&nbsp;Specified in the notice</label>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='N'/>"/>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="<c:out value='N'/> <c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> onclick="$('#registPasswordTR').show();" />
                                    <label for="othbcAtN">&nbsp;Hidden</label>
                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="<c:out value='Y'/>  <c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if> onclick="$('#registPasswordTR').hide();" />
                                    <label for="othbcAtY">&nbsp;Disclosure</label>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="othbcAt" value="<c:out value='Y'/>" />
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:if>
                <!-- 확장 컬럼 입력 -->
                <c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
                    <c:if test="${!empty extensionVo.columnTy}">
                        <tr>
                            <td class="tit">${extensionVo.langColumnNm}<c:if test="${extensionVo.essntlYn eq 'Y'}"><span class="tx_red tx_b"> *</span></c:if></td>
                            <td class="last">
                                <c:choose>
                                    <c:when test="${extensionVo.columnTy eq 'TEXT'}">
                                        <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" class="w85_p" />
                                    </c:when>
                                    <c:when test="${extensionVo.columnTy eq 'TEXTAREA'}">
                                        <textarea name="${extensionVo.beanName}" id="${extensionVo.beanName}" cols="30" rows="3" class="w99_p"><op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/></textarea>
                                    </c:when>
                                    <c:when test="${extensionVo.columnTy eq 'DATE'}">
                                        <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" maxlength="14" /> 예 : 20120101093000
                                        <p class="tx_blue_s">- You must enter the year, month, day, hour, minute, and second (14 digits)</p>
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

                <!-- 파일 업로드 -->
                <c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd ne '1008'}" >
                    <tr>
                        <td class="tit"><label for="multiFiles">Attached file</label></td>
                        <td class="last">
                            <div class="file">
                                    <c:if test="${pageType eq 'UPDATE'}">
                                        <c:if test="${fn:length(dataVo.fileList) > 0}">
                                            <p class="tx_blue_s">
                                                - <span class="tx_red">click the X icon</span> below to <span class="tx_red">delete</span> the existing attachment
                                            </p>
                                            <ul>
                                                <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                    <li class="mar_b5">
                                                        <a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '<c:out value='${fileVo.fileId}'/>');"><img alt="delete" src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />" class="vm"></img></a>
                                                        <c:out value='${fileVo.localNm}'/> <span class="tx_gray vm">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </c:if>
                                    <input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>"/>
                                    <div style="width:570px; height:24px; border: 1px solid #ccc ;">
                                        <input type="file" name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="select file"  style="width:570px; height: 24px;"/>
                                        <div id="multiFilesListDiv" class="regist-file"></div>
                                    </div>
                                </div>
                                <div class="guide_txt" style="padding-top: 5px;">
                                    <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>"/>
                                    ※ Files less than ${boardConfVo.maxFileSize}MB in size in <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script>
                                    </c:if> format can be uploaded.
                                </div>
                                
                            </td>
                        </tr>
                </c:if>

                <!-- 태그 입력 -->
                <c:if test="${boardConfVo.tagYn eq 'Y'}">
                    <tr>
                        <td class="tit"><label for="bbsTags">Tag</label></td>
                        <td class="last">
                            <input type="text" name="bbsTags" id="bbsTags"  value="${fn:join(dataVo.bbsTags, ',')}" title="태그 입력" class="input" style="width:570px;"/>
                            <p class="tx_blue_s">- Please separate tags using commas.</p>
                        </td>
                    </tr>
                </c:if>

            </tbody>
        </table>
        <!-- //내용쓰기 -->

        <!-- 버튼 -->
        <div class="btn_area">
            <div class="btn_l">
                <div class="btn_navi"><a href="#" onclick="jsList(); return false;"><span class="list">List</span></a></div>
            </div>
            <div class="btn_r">
                <div class="btn_navi_g"><a href="#" onclick="jsSubmit();"><span class="disk">Save</span></a></div>
            </div>
        </div>
        <!-- //버튼 -->
        