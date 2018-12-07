<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>컨텐츠 관리</title>

    <op:jsTag type="spi" items="form" />
    <op:jsTag type="openworks" items="ckeditor" />

    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.content.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.common.js" />"></script>

    <script type="text/javascript">

        var PRE_VIEW_URL = "<c:url value="/intra/cms/layout/PD_LayoutPreView.do" />";
        var INSERT_URL = "<c:url value="/intra/cms/content/ND_InsertAction.do" />";
        var UPDATE_URL = "<c:url value="/intra/cms/content/ND_UpdateAction.do" />";
        var DELETE_URL = "<c:url value="/intra/cms/content/ND_DeleteAction.do" />";

        $(document).ready(function(){

            $("#bodyContent").ckeditor({toolbar : toolbar_config.default_toolbar});

            // 창을 닫으면 부모창의 텝 정보를 리로드 한다.
            $(window).unload(function() {
                var openWin = opener;
                if (!opener && window.showModalDialog) {
                    openWin = window.dialogArguments;
                }
                if(openWin && openWin.jsReloadTab)
                    openWin.jsReloadTab();
            });
        });

    </script>
</head>

<body style="padding:20px;">

    <form name="dataForm" id="dataForm" action="<c:url value="/intra/cms/content/ND_InsertAction.do" />" method="post">

        <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
        <op:pagerParam view="view" />

        <input type="hidden" name="domainCd" id="domainCd" value="${param.q_domainCd}" />
        <input type="hidden" name="menuCode" id="menuCode" value="${param.q_menuCode}" />

        <input type="hidden" name="domainNm" id="domainNm" value="${dataVo.domainNm}" />
        <input type="hidden" name="contentSeqNo" id="contentSeqNo" value="${dataVo.contentSeqNo}" />
        <input type="hidden" name="userMenuUrl" id="userMenuUrl" value="<c:url value="${dataVo.userMenuUrl}" />" />
        <input type="hidden" name="approvalSt" id="approvalSt" value="" />

        <table class="boardWrite" width="100%" border="0" cellspacing="0" cellpadding="0" summary="선택한 컨텐츠 정보">
            <caption class="title">선택한 컨텐츠 정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="" />
            </colgroup>
            <tbody>
            <c:if test="${not empty dataVo.applyYn}">
            <tr>
                <th>승인정보</th>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" summary="선택한 컨텐츠 정보">
                        <caption class="title">선택한 컨텐츠 정보</caption>
                        <colgroup>
                            <col width="15%" />
                            <col width="35%" />
                            <col width="15%" />
                            <col width="35%" />
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>승인상태</th>
                            <td>${dataVo.approvalStNm}</td>
                            <th>적용여부</th>
                            <td>${dataVo.applyYn}</td>
                        </tr>
                        <tr>
                            <th>승인일시</th>
                            <td>${dataVo.approvalDt}</td>
                            <th>승인자</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty dataVo.approvalNm}">${dataVo.approvalNm}</c:when>
                                    <c:otherwise>자동승인</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>발행사유</th>
                            <td>${dataVo.publishReason}</td>
                            <th>승인내용</th>
                            <td>
                                <c:choose>
                                    <c:when test="${empty dataVo.approvalReason}">자동승인</c:when>
                                    <c:otherwise>${dataVo.approvalReason}</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            </c:if>
            <tr>
                <th>HEAD 컨텐츠</th>
                <td>
                    <p class="tx_blue_s">&lt;head&gt; &lt;head&gt; 태그 사이에 위치할 내용을 입력하세요.</p>
                    <textarea name="headContent" id="headContent"  rows="8" cols="30" class="textarea" style="width:100%;"><c:out value="${dataVo.headContent}" escapeXml="true"/></textarea>
                </td>
            </tr>
            <tr>
                <th>BODY 컨텐츠</th>
                <td>
                    <p class="tx_blue_s">&lt;body&gt; &lt;body&gt; 태그 사이에 위치할 내용을 입력하세요.</p>
                    <textarea name="bodyContent" id="bodyContent"  rows="30" cols="60" class="textarea" style="width:100%;"><c:out value="${dataVo.bodyContent}" escapeXml="true"/></textarea>
                    <textarea name="previewContent" id="previewContent" style="display:none;"></textarea>
                </td>
            </tr>

            <c:choose>
                <c:when test="${dataVo.approvalSt eq '1030'}">
                    <tr>
                        <th>반려 사유</th>
                        <td>${dataVo.approvalReason}</td>
                    </tr>
                </c:when>
                <c:when test="${dataVo.approvalSt eq '1010'}">
                    <tr>
                        <th>발행 사유</th>
                        <td>
                            <textarea id=publishReason name="publishReason" rows="4" style="width:100%;">초판발행</textarea>
                            <span class="tx_blue_s">(최대 한글 <strong>200</strong>자)</span>
                        </td>
                    </tr>
                </c:when>
            </c:choose>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div>
            <div class="btn_r">
                <ul>
                    <c:choose>
                        <c:when test="${baseVo.approvalYn eq 'N' and not empty dataVo.approvalSt and dataVo.approvalSt ne '1040'}">
                            <li><button type="button" class="w_blue" onclick="jsDeploy();" >발  행</button></li>
                        </c:when>
                        <c:when test="${dataVo.approvalSt eq '1010'}">
                            <li><button type="button" class="w_blue" onclick="jsDeployRequest();" >발행요청</button></li>
                        </c:when>
                        <c:when test="${dataVo.approvalSt eq '1020'}">
                            <li><button type="button" class="w_blue" onclick="jsDeployCancel();" >발행취소</button></li>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${dataVo.approvalSt eq '1010' or dataVo.approvalSt eq '1020'}">
                            <li><button type="button" class="w_blue" onclick="jsContentUpdate();" >수정</button></li>
                            <li><button type="button" class="w_blue" onclick="jsContentDelete();" >삭제</button></li>
                            <li><button type="button" class="blue" onclick="jsLayoutPreview('${dataVo.domainCd}', '${dataVo.layoutCode}', '${dataVo.menuCode}', ${dataVo.contentSeqNo});" >미리보기</button></li>
                        </c:when>
                        <c:otherwise>
                            <li><button type="button" class="w_blue" onclick="jsContentInsert();" >현재컨텐츠로 신규생성</button></li>
                        </c:otherwise>
                    </c:choose>

                    <li><button type="button" class="blue" onclick="jsClose();" >닫기</button></li>
                </ul>
            </div>
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>
