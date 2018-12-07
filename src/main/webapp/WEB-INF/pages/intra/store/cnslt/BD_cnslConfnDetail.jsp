<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>IT전문가서비스 승인 상세조회/수정</title>
    <op:jsTag type="openworks" items="form, validate, ckeditor" />
    <op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
    <script type="text/javascript" src="<c:url value="/resources/intra/store/goods.js" />"></script>

    <script type="text/javascript">
       //<CDATA[[
    //]]>
    </script>
</head>
<body>

    <form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">

    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
    <op:pagerParam view="view" />

    <input type="hidden" name="goodsCode" id="goodsCode" value="${dataVo.goodsCode}" />
    <input type="hidden" name="userId" id="userId"  value="${dataVo.userId}"/>
    <input type="hidden" name="sleMthdCd" id="sleMthdCd"  value="1002"/>
    <input type="hidden" name="goodsStatus" value="${dataVo.goodsRegistSttus}" id="goodsStatus"/>
    <input type="hidden" name="goodsRegistSttus" id="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" />
    <table class="boardWrite">
        <colgroup>
            <col width="150" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th><span class="tx_red_s">*</span>서비스 언어</th>
                <td>
                    <input name="langCode" id="langCode" type="hidden" value="${dataVo.langCode}"/>
                    ${dataVo.langNm}
                </td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>카테고리</th>
                <td><div>
                       <input type="button" id="ctgryBtn" value="카테고리 선택" class="blue" onclick="jsCtgrySelPop(this,'ST02');" />
                       <input type="hidden" id="setCtgryCodes"/>
                    </div>
                     <table id="goodsCtgry">
                     <tr><td colspan="3"><div class="mar_t10 tx_b" id="test">연결된 카테고리</div></td></tr>
                     <c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
                         <tr id="goodsCtgry_${_goodsCtgry.CTGRYCODE}">
                            <td>[${_goodsCtgry.CTGRYCLNM }]</td>
                            <td>${_goodsCtgry.CTGRYPATH}</td>
                            <td>
                                <input type="button" id="goodsCtgry_${_goodsCtgry.CTGRYCODE}" value="X" onclick="jsCategoryDelete(this);"/>
                                <input type="hidden" name="ctgryCds" class="getCtgryCodes" value="${_goodsCtgry.CTGRYCODE}"/>
                            </td>
                         </tr>
                     </c:forEach>
                     </table>
                </td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>이미지 등록<br/>사이즈 (400X300)<input type="hidden" name="goodsImageFileSeq" value="${dataVo.goodsImageFileSeq}" /></th>
                <td>
                   <table>
                   <tr>
                   <td>
                   <c:forEach var="i" begin="1" end="5" step="1" varStatus="status">
                       <span id="imageFile${i}Div" style="vertical-align: sub;">
                       <input type="file" name="imageFile${i}" id="imageFile${i}" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange='jsPreview("imageFile${i}", 0, 0, 400, 300, 10240, "jpg,jpeg,gif,png",${i},"Img", ${dataVo.goodsImageFileSeq}, 5);'/>
                        </span>
                        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile${i}');"/>
                       <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""></input>
                       <c:if test="${not status.last}"><br/></c:if>
                   </c:forEach>
                   </td>
                   <td>
                       <c:set var="image" value="" />
                       <c:forEach items="${dataVo.imageFile}" var="fileVo" varStatus="status">
                       <div class="imgFileDiv mar_b5">
                           <a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                           <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
                           <c:if test="${not status.last}"><br/></c:if>
                       </div>
                       <c:set var="image"><c:if test="${!status.first}">${image},</c:if>${fileVo.fileUrl}</c:set>
                       </c:forEach>
                       <input type="hidden" name="image" value="${image}" />
                   </td>
                   </tr>
                   </table>
<%--                    <input type="hidden" id="uploadFileCnt" value="${dataVo.fileCnt}" />            --%>
                </td>
            </tr>
        </tbody>
    </table>

    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="" />
            <col width="150" />
            <col width="100" />
            <col width="150" />
            <col width="100" />
        </colgroup>
        <tbody>
            <tr><td colspan="6"><h4>기본정보</h4></td></tr>
            <tr>
                <th><span class="tx_red_s">*</span>서비스명</th>
                <td colspan="5"><input name="goodsNm" id="goodsNm" class="w_92p" type="text" value="${dataVo.goodsNm}"></input></td>
            </tr>
            <tr>
                <th>회사명</th>
                <td id="sellerInfo1">${dataVo.goodsStore[0].LANGSTORENM}</td>
                <th>판매자 구분</th>
                <td id="sellerInfo2">${dataVo.nationGrp}</td>
                <th>판매자 유형</th>
                <td id="sellerInfo3">${dataVo.userTyGrp}</td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자</th>
                <td colspan="5"><input name="goodsChargerNm" id="goodsChargerNm" class="w_92p" type="text" value="${dataVo.goodsChargerNm}"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자 이메일</th>
                <td colspan="5"><input name="goodsChargerEmail" id="goodsChargerEmail" class="w_92p" type="text" value="${dataVo.goodsChargerEmail}"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자 전화번호</th>
                <td colspan="5"><input name="goodsChargerCttpc" id="goodsChargerCttpc" class="w_92p" type="text" value="${dataVo.goodsChargerCttpc}"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자 휴대전화번호</th>
                <td colspan="5"><input name="goodsChargerMbtlnum" id="goodsChargerMbtlnum" class="w_92p" type="text" value="${dataVo.goodsChargerMbtlnum}"></input></td>
            </tr>
            <tr>
                <th>홈페이지URL</th>
                <td colspan="5"><input name="goodsHmpgUrl" id="goodsHmpgUrl" class="w_92p" type="text" value="${dataVo.goodsHmpgUrl}"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span><label for="contents">태그</label></th>
                <td colspan="5">
                    <div>(태그선택 또는 직접 입력으로 총 10개의 태그를 입력할 수 있습니다.)</div>
                    <table class="w_100p">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                    <tbody>
                        <tr>
                            <td>
                                <input id="metaTAGsBtn" type="button" value="태그선택" class="blue w80"  onclick="jsMetaPop(this, 1023, '', '');"></input>
                            </td>
                            <td>
			                    <input name="metaTAGs" id="metaTAGs" type="hidden" value="<c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">${_goodsMetaTAG.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
			                    <ul id="metaTAGhtml">
			                     <c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">
			                     <li><a id="metaTAG${_goodsMetaTAG.INDVDLZ_CD}" onclick="jsMetaTagDelete(this);" href="javascript:;">${_goodsMetaTAG.INDVDLZ_CD_NM} X</a></li>
			                     </c:forEach>
			                    </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                            <td>
                                <input type="text" name="goodsTags" id="goodsTags" class="w_92p" value="<c:forEach items="${dataVo.goodsTag}" var="_goodsTag" varStatus="status">${_goodsTag.GOODSTAGNM}${!status.last?', ':''}</c:forEach>" title="태그" />
                                <p class="tx_blue_s">- 쉼표로 구분하여 태그를 입력해 주세요.</p>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>

    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="200" />
            <col width="150" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr><td colspan="4"><h4>상세 정보</h4></td></tr>
            <tr>
                <th>가격(\)</th>
                <td colspan="3"><input name="goodsPc" id="goodsPc" class="w_50p" type="text" value="${dataVo.goodsPc}"></input><div>가격을 입력해 주세요. 숫자만 기입 가능합니다. 미 입력 시 "문의요망"으로 표시됩니다.</div></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>A/S방침</th>
                <td colspan="3">
                    <input id="metaASsBtn" type="button" value="선택" class="blue w80" onclick="jsMetaPop(this, 1021, '2000', '2999');"></input>
                    <span id="metaASnm" class="mar_l10"><c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaASs" id="metaASs" type="hidden"
                     value="<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaAS.INDVDLZ_CD == 2005}"><c:set var="metaASetc" value="${_goodsMetaAS.META_ETC_CN}"/></c:if></c:forEach>"/>
                    <input name="metaASetc" id="metaASetc" type="hidden" value="${metaASetc}"/>
                    <input name="metaASnms" id="metaASnms" type="hidden" value=""/>
                </td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>전문분야</th>
                <td colspan="3"><input name="spcltyRealm" id="spcltyRealm" type="text" value="${dataVo.spcltyRealm}" class="w_92p"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>전문 컨설턴트 수</th>
                <td colspan="3"><input name="cnstntCo" id="cnstntCo" type="text" value="${dataVo.cnstntCo}" class="w_92p"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>보유기술 및 자격증</th>
                <td colspan="3">
                    <input id="metaTECHsBtn" type="button" value="선택" class="blue w80" onclick="jsMetaPop(this, 1022, '', '');"></input>
                    <span id="metaTECHnm" class="mar_l10"><c:forEach items="${dataVo.goodsMetaTECH}" var="_goodsMetaTECH" varStatus="status">${_goodsMetaTECH.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaTECHs" id="metaTECHs" type="hidden"
                     value="<c:forEach items="${dataVo.goodsMetaTECH}" var="_goodsMetaTECH" varStatus="status">${_goodsMetaTECH.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaTECH.INDVDLZ_CD == 1002}"><c:set var="metaTECHetc" value="${_goodsMetaTECH.META_ETC_CN}"/></c:if></c:forEach>"/>
                    <input name="metaTECHetc" id="metaTECHetc" type="hidden" value="${metaTECHetc}"/>
                    <input name="metaTECHnms" id="metaTECHnms" type="hidden" value=""/>
                </td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>개요</th>
                <td colspan="3"><textarea name="goodsSumry" id="goodsSumry" rows="5" class="w_92p" >${dataVo.goodsSumry}</textarea></td>
            </tr>
            <tr>
                <th colspan="4"><span class="tx_red_s">*</span>주요특징</th>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="contentsErrorDiv1"></div>

                        <textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" class="w99_p" title="주요특징을 입력해주세요"><c:out value="${dataVo.goodsMainFnct}" escapeXml="false"/></textarea>
                        <!-- <textarea name="goodsMainFnct" id="goodsMainFnct" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.goodsMainFnct}</textarea> -->
                            <script type="text/javascript">
                            //<![CDATA[
                            CKEDITOR.replace('goodsMainFnct', {
                                height : 200,
//                                 htmlEncodeOutput : true,
                                enterMode : "2",
                                skin : "moono",
                                toolbar : toolbar_config.default_toolbar,
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
                            });
                            //]]>
                            </script>
                    <valid:msg name="goodsMainFnct" />
                </td>
            </tr>
            <tr>
                <th colspan="4"><span class="tx_red_s">*</span>기대효과</th>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="contentsErrorDiv3"></div>

                        <textarea name="cnslExpcEffect" id="cnslExpcEffect" rows="15" class="w99_p" title="기대효과를 입력해주세요"><c:out value="${dataVo.cnslExpcEffect}" escapeXml="false"/></textarea>
                        <!-- <textarea name="cnslExpcEffect" id="cnslExpcEffect" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.cnslExpcEffect}</textarea> -->
                            <script type="text/javascript">
                            //<![CDATA[
                            CKEDITOR.replace('cnslExpcEffect', {
                                height : 200,
//                                 htmlEncodeOutput : true,
                                enterMode : "2",
                                skin : "moono",
                                toolbar : toolbar_config.default_toolbar,
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
                            });
                            //]]>
                            </script>
                    <valid:msg name="cnslExpcEffect" />
                </td>
            </tr>
            <tr>
                <th colspan="4"><span class="tx_red_s">*</span>레퍼런스</th>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="contentsErrorDiv2"></div>

                        <textarea name="goodsRefer" id="goodsRefer" rows="15" class="w99_p" title="레퍼런스를 입력해주세요"><c:out value="${dataVo.goodsRefer}" escapeXml="false"/></textarea>
                        <!-- <textarea name="goodsRefer" id="goodsRefer" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.goodsRefer}</textarea> -->
                            <script type="text/javascript">
                            //<![CDATA[
                            CKEDITOR.replace('goodsRefer', {
                                height : 200,
//                                 htmlEncodeOutput : true,
                                enterMode : "2",
                                skin : "moono",
                                toolbar : toolbar_config.default_toolbar,
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
                            });
                            //]]>
                            </script>
                    <valid:msg name="goodsRefer" />
                </td>
            </tr>
            <tr>
                <th colspan="4">문서<input type="hidden" name="goodsMnlFileSeq" value="${dataVo.goodsMnlFileSeq}"></input></th>
            </tr>
            <c:forEach var="i" begin="1" end="5" step="1" varStatus="status">
            <tr>
                <th>파일설명</th>
                <td>
                <input class="w160" name="fileDesc" id="mnlFile${i}Desc" type="text"  value="${dataVo.mnlFile[i-1].fileDesc}" <c:if test="${not empty dataVo.mnlFile[i-1]}">disabled</c:if>></input>
                </td>
                <th>파일 업로드</th>
                <td>
                <span id="mnlFile${i}Div"  style="vertical-align: sub;">
                <input type="file" name="mnlFile${i}" id="mnlFile${i}" class="mnlFile w_92p" <c:if test="${not empty dataVo.mnlFile[i-1]}">disabled</c:if> onchange="jsFileChk('mnlFile${i}', 10240, '1', '${dataVo.goodsMnlFileSeq}', 5);"></input>
                </span>
                <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('mnlFile${i}');"/>
                <c:if test="${not empty dataVo.mnlFile[i-1]}">
                       <div class="mnlFileDiv${i} mar_b5">
                           <a href="javascript:;" onclick="jsFileDelete(this, ${dataVo.mnlFile[i-1].fileSeq}, '${dataVo.mnlFile[i-1].fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                           <a href="/component/file/ND_fileDownload.do?id=${dataVo.mnlFile[i-1].fileId }" title="${dataVo.mnlFile[i-1].localNm}">${dataVo.mnlFile[i-1].localNm} <span class="tx_gray">(download ${dataVo.mnlFile[i-1].downCnt}, ${dataVo.mnlFile[i-1].fileSize}, ${dataVo.mnlFile[i-1].fileType})</span></a>
                       </div>
                </c:if>
                </td>
            </tr>
            </c:forEach>
            <tr>
            	<td>
            		<input type="hidden" id="mnlFilesFileDesc" name="mnlFilesFileDesc" value="" />
            	</td>
            </tr>
        </tbody>
    </table>
    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
            <th>서비스검토관리자</th>
            <td><c:if test="${not empty dataVo.exmntMgr.MNGR_ID}">${dataVo.exmntMgr.MNGR_NM}(${dataVo.exmntMgr.MNGR_ID})</c:if></td>
            </tr>
        </tbody>
    </table>
    <!-- 버튼 -->
    <div class="mar_t20 mar_b50">
        <div class="float_l">
            <input type="button" value="목록" class="blue" onclick="jsList('BD_cnslConfnList.do');" />
            <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm();' />
            <input type="button" value="미리보기" class="blue" onclick="jsGoodsPreview('PD_cnsltPreview.do');" />
        </div>
        <div class="float_r">
            <input type="button" value="승인반려" class="blue" onclick="jsRegistBack(this, 1005);" />
            <input type="button" value="승인완료" class="blue" onclick="jsGoodsUpdateAction('1007','ND_cnsltConfnUpdate.do');" />
        </div>
    </div>
    <!-- //버튼 -->
    </form>
</body>
</html>