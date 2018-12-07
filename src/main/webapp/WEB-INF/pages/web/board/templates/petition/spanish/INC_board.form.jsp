<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

        <!-- 내용쓰기 -->
        <table class="tbl_view" >
            <caption>
	            <strong>게시판 글입력 페이지</strong>
	            <details>
	                <summary>게시판 내용 작성페이지입니다.</summary>
	            </details>
	        </caption>
            <colgroup>
                <col style="width:20%;"/>
                <col style="width:*"/>
            </colgroup>
            <tbody>
                <tr>
                    <td class="tit">Categoria</td>
                    <td class="last">
                        <c:if test="${boardConfVo.ctgYn eq 'Y'}">
                            <select id="ctgCd" name="ctgCd" title="Seleccione una categoría." style="width:175px;">
                                <option value="">Seleccione una categoría.</option>
                                <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
                                    <option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>><c:out value='${ctgVo.ctgNm}'/></option>
                                </c:forEach>
                            </select>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td class="tit"><label for="bbscttSj">Título</label></td>
                    <td class="last">
                        <input type="text" name="bbscttSj" id="bbscttSj" class="input" style="width:570px;" title="Ingrese la Título" value="${dataVo.bbscttSj}" />
                    </td>
                </tr>
                <tr>
                    <td class="tit"><label for="bbscttCn">contenido</label></td>
                    <td class="last">
                        <div id="contentsErrorDiv"></div>
                        <c:if test="${boardConfVo.userEditorYn eq 'Y'}" >
                            <textarea name="bbscttCn" id="bbscttCn" rows="15" cols="30" title="Ingrese la contenido" style="width:570px; height:315px;">${dataVo.bbscttCn}</textarea>
                            <!-- <textarea name="bbscttCn" id="htmlContent" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.bbscttCn}</textarea> -->
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
                            <textarea name="bbscttCn" id="bbscttCn" rows="15" title="Ingrese la contenido" style="width:570px; height:315px;">${dataVo.bbscttCn}</textarea>
                        </c:if>
                    </td>
                </tr>

                <!-- 파일 업로드 -->
                <c:if test="${boardConfVo.fileYn eq 'Y'}" >
                    <tr>
                        <td class="tit">Archivo adjunto</td>
                        <td class="last">
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

                            <div class="mar_t5 mar_b5">
                                <input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>"/>
                                <input type="file"  name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기"  style="width:570px; height: 24px;"/>
                                
                                <div id="multiFilesListDiv" class="regist-file"></div>
                            </div>

                            <div class="guide_txt">※ Se pueden cargar archivos de hasta ${boardConfVo.maxFileSize} MB en formato <script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script>.</div>
                            <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>"/>
                        </td>
                    </tr>
                </c:if>
                
                <c:if test="${ boardConfVo.othbcYn eq 'Y' }">
                    <tr>
                        <td class="tit">Estado de divulgación</td>
                        <td class="last">
                            <c:choose>
                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if>  />
                                    <label for="othbcAtY" class="space">&nbsp;Divulgación</label>
                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> />
                                    <label for="othbcAtN">&nbsp;Oculto</label>
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
                        <th><label for="bbsTags">Introducir etiquetas</label></th>
                        <td>
                            <input type="text" name="bbsTags" id="bbsTags" class="w85_p" value="${fn:join(dataVo.bbsTags, ',')}" title="etiquetas" />
                            <p class="tx_blue_s">- Separe las etiquetas con comas.</p>
                        </td>
                    </tr>
                </c:if>

            </tbody>
        </table>
    <!-- //내용쓰기 -->

     <div class="btn_area">
         <div class="btn_r">
             <div class="btn_navi_g"><a href="#" onclick="jsCancel(); return false;"><span class="cancel">Cancelar</span></a></div>
             <div class="btn_navi_g"><a href="#"  onclick="jsSubmit();"><span class="disk">Registrarse</span></a></div>
         </div>
     </div>

     <div class="guide_box">
	    <ul>
	        <li>Aquí se recopilan sus valiosos comentarios. Ingrese sus comentarios y opiniones acerca del mercado CEART MARKET.</li>
	        <li>Las publicaciones que sean de naturaleza comercial o contengan información falsa, lenguaje obsceno, calumnias o información personal podrán ser borradas sin previo aviso.</li>
	    </ul>
	</div>

                
