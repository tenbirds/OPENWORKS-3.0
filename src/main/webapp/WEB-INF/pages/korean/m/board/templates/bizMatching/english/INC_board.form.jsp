<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!-- container -->
<div id="container">
    <!-- contents -->
    <div id="contents">
        <div class="visual">
            <img src="/resources/web/theme/english/images/bizmatching/img_bizmatching_visual.jpg" alt="Can't find the product you're looking for? You can more easily find the solutions or services you want through the Bizmatching service."/>
        </div>
        <!-- location -->
        <div class="location"><span class="home">Home</span><span>Bizmatching</span><strong>Bizmatching</strong></div>
        <!-- //location -->
        <section class="content">
            <h3>Bizmatching</h3>
            <p class="txt_desc">If you cannot find a product (service) that you are looking for or cannot decide which solution or service to choose, this service matches you with sellers when products that you are looking for are registered.</p>
            <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return false;">
                <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
                <op:pagerParam view="view" />

                <input type="hidden" name="setCtgryCodes" id="setCtgryCodes" value=""/>
                <input type="hidden" name="langCode" id="langCode" value="<c:out value='${dataVo.langCode}'/>"/>
                <input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}'/>"/>
                <input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>"/>
                <input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}'/>"/>
                <input type="hidden" name="refrnSeq" value="<c:out value='${dataVo.refrnSeq}'/>"/>
                <input type="hidden" name="bbscttOrdrNo" value="<c:out value='${dataVo.bbscttOrdrNo}'/>"/>
                <input type="hidden" name="bbscttDp" value="<c:out value='${dataVo.bbscttDp}'/>"/>
                <input type="hidden" name="mngrId" value="<c:out value='${dataVo.mngrId}'/>"/>
                <input type="hidden" name="brwsrAgent" id="brwsrAgent" value="<c:out value='${dataVo.brwsrAgent}'/>"/>
                <input type="hidden" name="estnColumn6" id="estnColumn6" value="<c:out value='${dataVo.estnColumn6}'/>"/>
                <input type="hidden" name="estnColumn5" id="estnColumn5" value='N'/>

                <!-- 내용쓰기 -->
                <table class="tbl_write" id="goodsCtgry">
                    <caption>
                        <strong>게시판 글입력 페이지 </strong>
                        <details>
                            <summary>게시판 내용 작성페이지입니다.</summary>
                        </details>
                    </caption>
                    <colgroup>
                        <col style="width:15%"/>
                        <col style="width:*"/>
                    </colgroup>
                    <thead></thead>
                    <tbody>
                        <!-- 카테고리(구분) -->
                        <tr style="height: 62px;">
                            <td class="tit"><label for="cs">Category</label></td>
                            <td class="last" id ="ctgryCodes" style="padding-top: 0px;">
                                <span class="btn_light_gray02"><a href="#" class="big" onclick="jsCtgrySelPop(this);">Select</a></span>
                                <span id="ctgry" style="position: absolute;">
                                    <c:forEach items="${dataVo.ctgryList}" var="ctgryVo">
                                    [<c:out value='${ctgryVo.ctgryClNm }'/>] <c:out value='${ctgryVo.ctgryPath}'/><br/>
                                    <input type="hidden" name="ctgryCds" id="ctgryCds" class="getCtgryCodes" value="<c:out value='${ctgryVo.ctgryCode}'/>"/>
                                    </c:forEach>
                                </span>
                            </td>
                        </tr>
                        <!-- 제목 -->
                        <tr>
                            <td class="tit"><label for="bbscttSj">Title</label></td>
                            <td class="last">
                                <input type="text" name="bbscttSj" id="bbscttSj" class="input" style="width:565px;" title="Please Enter Title" value="<c:out value='${dataVo.bbscttSj}'/>"/>
                            </td>
                        </tr>
                        <!-- 확장 컬럼 입력 -->
                        <c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
                            <c:if test="${!empty extensionVo.columnTy}">
                                <tr>
                                    <td class="tit">Date of closure</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${extensionVo.columnTy eq 'TEXT'}">
                                                <c:choose>
                                                    <c:when test="${extensionVo.columnId eq 'ESTN_COLUMN6'}">
                                                        <div class="calendar_input">
                                                            <input type="text" id="endDt" name="endDt" value="${param.endDt}" title="Enter Date of closure" class="input" style="width:207px;" readonly="readonly"/>
                                                        </div>
                                                        <span class="txt"></span>
                                                        <select id="endHH" name="endHH" style="width:88px;" title="">
                                                            <c:forEach begin="0" end="23" varStatus="sts">
                                                                <c:set value="${sts.index >= 0 and sts.index < 10 ? '0':''}${sts.index}" var="endHH"/>
                                                                <option value="${endHH}" ${fn:substring(dataVo.estnColumn6,11,13) eq endHH? 'selected':''}>
                                                                <c:if test="${sts.index >= 0 and sts.index < 10 }">0</c:if>${sts.index}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <span class="txt">time</span>
                                                        <select id="endMM" name="endMM" style="width:88px;" title="">
                                                            <c:forEach begin="0" end="60" step="1" varStatus="sts">
                                                                <c:set value="${sts.index >= 0 and sts.index < 10 ? '0':''}${sts.index}" var="endMM"/>
                                                                <option value="${endMM}" ${fn:substring(dataVo.estnColumn6,14,16) eq endMM? 'selected':''}>
                                                                <c:if test="${sts.index >= 0 and sts.index < 10 }">0</c:if>${sts.index}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <span class="txt">minutes</span>
                                                        <!--<span class="txt"> ※ 입력이 없을시 오늘로부터 30일을 더한 날짜로 자동 저장됩니다.</span>-->
                                                        <!--<span class="txt" style="display: block; margin-top: 5px;"> ※ If you not enter Date of closure then It stored plus thirty days from today automatically.</span>-->
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${extensionVo.columnTy eq 'TEXTAREA'}">
                                                <textarea name="${extensionVo.beanName}" id="${extensionVo.beanName}" cols="30" rows="3" class="w99_p"><op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/></textarea>
                                            </c:when>
                                            <c:when test="${extensionVo.columnTy eq 'DATE'}">
                                                <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" maxlength="14"/> 예 : 20120101093000
                                                <p class="tx_blue_s">- 반드시 년월일시분초(14자리)까지 입력해야 합니다.</p>
                                            </c:when>
                                            <c:when test="${extensionVo.columnTy eq 'EMAIL'}">
                                                <input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" class="w200"/>
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
                            <td class="tit"><label for="bbscttCn">Contents</label></td>
                            <td class="last">
                                <div id="contentsErrorDiv"></div>
                                <c:if test="${boardConfVo.userEditorYn eq 'Y'}">
                                    <textarea name="bbscttCn" id="bbscttCn" rows="15" style="width:817px; height:244px;" cols="30" onKeyUP="javascript:cal_pre();" title="Please Enter Contents">${dataVo.bbscttCn}</textarea>
                                    <%--<textarea name="bbscttCn" id="htmlContent" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.bbscttCn}</textarea>--%>
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
                                <c:if test="${boardConfVo.userEditorYn eq 'N'}">
                                    <%--<textarea name="bbscttCn" id="bbscttCn" rows="15" style="width:817px; height:244px;" onKeyUP="javascript:cal_pre();" title="Please Enter Contents" placeholder="Please be aware that session will be disconnected when writing content for a long time.">${dataVo.bbscttCn}</textarea>--%>
                                    <textarea name="bbscttCn" id="bbscttCn" rows="15" style="width:817px; height:244px;" onKeyUP="javascript:cal_pre();" title="Please Enter Contents">${dataVo.bbscttCn}</textarea>
                                </c:if>
                                <p align="right" style="margin-right: 15px;"><input type="text" name="contentsByteCntDiv" id="contentsByteCntDiv" class="input" style="border:0px; width:40px; text-align:right !important" value="0" readonly/>byte / 20000byte</p>
                            </td>
                        </tr>
                        <!-- 작성자 -->
                        <%--<tr>
                            <th><label for="registerNm">작성자 <span class="tx_red tx_b">*</span></label></th>
                            <td>
                                <input type="text" name="registerNm" id="registerNm" value="${dataVo.registerNm}"/>
                            </td>
                        </tr>--%>
                        <!-- 분류 / 공지 지정여부 / 공개여부 -->
                        <c:if test="${boardConfVo.ctgYn eq 'Y' or boardConfVo.noticeBbscttUseYn eq 'Y' or boardConfVo.othbcYn eq 'Y'}">
                            <tr>
                                <td class="tit">preferences <span class="tx_red tx_b">*</span></td>
                                <td class="last">
                                    <c:if test="${boardConfVo.ctgYn eq 'Y'}">
                                        <select id="ctgCd" name="ctgCd" title="">
                                            <option value="">Classification Select</option>
                                            <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
                                            <option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
                                            </c:forEach>
                                        </select>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
                                            <input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="Y"<c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
                                            <label for="noticeBbscttAt">&nbsp;Specified in the notice</label>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='N'/>"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${boardConfVo.othbcYn eq 'Y'}">
                                            <input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> onclick="$('#registPasswordTR').show();"/>
                                            <label for="othbcAtN">&nbsp;Hidden</label>
                                            <input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if> onclick="$('#registPasswordTR').hide();"/>
                                            <label for="othbcAtY">&nbsp;Disclosure</label>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="othbcAt" value="<c:out value='Y'/>"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                        <!-- 비공개 선택 시 비밀번호 입력 -->
                        <%--<tr id="registPasswordTR"<c:if test="${dataVo.othbcAt eq 'Y'}"> class="none"</c:if>>
                            <th><label for="registPassword">비밀번호<span class="tx_red tx_b"> *</span></label></th>
                            <td>
                                <input type="password" name="registPassword" id="registPassword" value="${dataVo.registPassword}" maxlength="20"/>
                            </td>
                        </tr>--%>
                        <!-- 파일 업로드 -->
                        <c:if test="${boardConfVo.fileYn eq 'Y' and boardConfVo.bbsCd ne '1008'}">
                            <tr>
                                <td class="tit"><label for="multiFiles">Attached file</label></td>
                                <td class="last">
                                    <div class="file">
                                        <c:if test="${pageType eq 'UPDATE'}">
                                            <c:if test="${fn:length(dataVo.fileList) > 0}">
                                                <p class="tx_blue_s">
                                                - <span class="tx_red">click the X icon</span> below to <span class="tx_red">delete</span> the existing attachment.
                                                </p>
                                                <ul>
                                                    <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                        <li class="mar_b5">
                                                            <a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '${fileVo.fileId}');"><img src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />" alt="delete" class="vm"/></a>
                                                            ${fileVo.localNm} <span class="tx_gray vm">(download <c:out value='${fileVo.downCnt}'/>, <c:out value='${fileVo.fileSize}'/>, <c:out value='${fileVo.fileType}'/>)</span>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>
                                        </c:if>
                                        <input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>"/>
                                        <div style="width:570px; height:24px; border: 1px solid #ccc;">
                                            <input type="file" name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="select file" style="width:500px;"/>
                                            <div id="multiFilesListDiv" class="regist-file"></div>
                                        </div>
                                    </div>
                                    <div class="guide_txt" style="padding-top: 5px;">
                                        <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>"/>
                                        * Files less than ${boardConfVo.maxFileSize}MB in size in 
                                        <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }">
                                            <script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script>
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
                                    <input type="text" name="bbsTags" id="bbsTags" value="${fn:join(dataVo.bbsTags, ',')}" title="Enter tags" class="input" style="width:570px;"/>
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
                        <div class="btn_navi_g"><a href="#" onclick="jsList(); return false;"><span class="total">List</span></a></div>
                    </div>
                    <div class="btn_r">
                        <div class="btn_navi"><a href="#" onclick="jsSubmit();"><span class="reg">Register</span></a></div>
                        <div class="btn_navi_g"><a href="#" onclick="jsCancel();" ><span class="cancel">Cancel</span></a></div>
                    </div>
                </div>
                <!-- //버튼 -->
            </form>
        </section>
    </div>
    <!-- //contents -->
</div>
<!-- //container -->