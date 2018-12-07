<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">

        /* 응용컨텐츠 선택시 서브 기능 상세 목록을 표시(URL 포함) */
        var jsChangeControl = function() {

            var selectValue = $("#controlNm").val();

            if (!selectValue || selectValue == "") {
                return false;
            }

            var arrSelectValue = selectValue.split("|");
            var param = {
                beanNm    : arrSelectValue[0],
                methodNm  : arrSelectValue[1]
            };

            // 선택대상 기능의 서브 기능 목록을 가져와 명칭을 표시한다.
            $.post("<c:url value="/intra/cms/getCmsRefernce.do"/>", param , function(result) {

                if (result != "") {
                    var dataList = result.split("\n");

                    for (var i = 0; i < dataList.length; i++) {
                        var data = dataList[i].split(",");

                        var domainNm = $("#domainNm").val();
                        var prefix = "/" + domainNm;

                        if(domainNm.indexOf(".") > 0) {
                            var arrDomain = domainNm.split(".");
                            prefix = "/" + arrDomain[0];
                        }
                        data[1]= prefix + data[1];

                        
                        var methodUrl = $("#methodUrl").val();
                        
                        if(data[1] == methodUrl) {
                            $("#methodNm").text(data[0]);
                            break;
                        }
                    }

                }
            }, 'text');
        };

        /** 상단 컨텐츠 (응용프로그램 설정시 사용) */
        var jsGetHeadContents = function() {
            return $("#headContents").val();
        };

        /** 하단 컨텐츠 (응용프로그램 설정시 사용) */
        var jsGetFootContents = function() {
            return $("#footContents").val();
        };

        $().ready(function() {

            <c:if test="${dataVo.menuType eq 'reference'}">
                // 메뉴유형이 프로그램인경우 컨트롤 명칭 활성화
                jsChangeControl();
            </c:if>

        });

    </script>

    <form name="dataForm" id="dataForm" action="ND_ChargerUpdateAction.do"
        method="post" enctype="multipart/form-data">
        <input type="hidden" id="domainCd" name="domainCd" value="${dataVo.domainCd}" />
        <input type="hidden" id="domainNm" value="${dataVo.domainNm}" />
        <input type="hidden" id="portNo" value="${dataVo.portNo}" />

        <input type="hidden" id="topMenuCode" name="topMenuCode" value="${dataVo.topMenuCode}" />
        <input type="hidden" id="parentMenuCode" name="parentMenuCode" value="${dataVo.parentMenuCode}" />
        <input type="hidden" id="menuCode" name="menuCode" value="${dataVo.menuCode}" />
        <input type="hidden" id="menuDepth" name="menuDepth" value="${dataVo.menuDepth}" />
        <input type="hidden" id="sortOrder" name="sortOrder" value="${dataVo.sortOrder}" />

        <input type="hidden" id="q_domainCd" name="q_domainCd" value="${dataVo.domainCd}" />
        <input type="hidden" id="q_menuCode" name="q_menuCode" value="${dataVo.menuCode}" />
        <input type="hidden" id="q_contentSeqNo" name="q_contentSeqNo" value="${dataVo.contentSeqNo}" />

        <input type="hidden" id="adminMenuUrl" name="adminMenuUrl" value="${dataVo.adminMenuUrl}" readonly="readonly"/>
        <input type="hidden" id="userMenuUrl" name="userMenuUrl" value="${dataVo.userMenuUrl}" readonly="readonly" />
        <input type="hidden" id="layoutPreviewUrl" value="<c:url value="/intra/cms/layout/PD_LayoutPreView.do"/>" />

        <h4>메뉴 정보</h4>
        <table class="boardWrite" summary="메뉴 정보">
            <caption class="title">메뉴 정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>

            <tr>
                <th>메뉴 경로</th>
                <td colspan="3">
                    <span id="nodePath">${dataVo.menuPath}(${dataVo.menuCode})</span>
                </td>
            </tr>

            <tr>
                <th>메뉴 명</th>
                <td>
                    ${dataVo.menuNm}
                    <input type="hidden" name="menuNm" id="menuNm" value="${dataVo.menuNm}" />
                </td>
                <th>제목</th>
                <td><input type="text" name="title" id="title" value="${dataVo.title}" maxlength="50" /></td>
            </tr>

            <tr>
                <th>사용 여부</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.useYn eq 'Y'}">사용</c:when>
                        <c:otherwise>미사용</c:otherwise>
                    </c:choose>
                </td>

                <th>메뉴표시 여부</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.showYn eq 'Y'}">메뉴표시</c:when>
                        <c:otherwise>일반페이지</c:otherwise>
                    </c:choose>
                </td>

            </tr>

            </tbody>
        </table>

        <br class="blank"/>

        <h4>기본 정보</h4>

        <table class="boardWrite" summary="기본 정보" >
            <caption class="title">기본 정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>

           <tr>
                <th>메뉴유형</th>
                <td>
                    <c:forEach items="${MENU_TYPE_LIST}" var="menuTypes" varStatus="vst">
                        <c:if test="${dataVo.menuType eq menuTypes.TYPE_CODE}">${menuTypes.TYPE_NAME}</c:if>
                    </c:forEach>
                </td>
            </tr>

            <c:if test="${dataVo.menuType eq 'content'}">
                <tr class="contentCls">
                    <th>컨텐츠유형</th>
                    <td>
                        <input type="hidden" id="contentSeqNo" name="contentSeqNo" value="${dataVo.contentSeqNo}" />

                        <c:if test="${not empty dataVo.contentType}">
                            <input type="hidden" name="contentType" value="${dataVo.contentType}" />
                            <button type="button" class="s_blue" onclick="jsContentForm();">컨텐츠편집</button>
                        </c:if>
                    </td>
                </tr>

                <tr class="contentCls">
                    <th>승인여부</th>
                    <td>
                        <c:choose>
                            <c:when test="${dataVo.approvalYn eq 'Y'}">승인필요</c:when>
                            <c:otherwise>자동승인</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:if>

            <c:if test="${dataVo.menuType eq 'reference'}">
                <tr class="controlCls">
                    <th>응용컨텐츠</th>
                    <td>
                        <c:forEach items="${CONTROL_LIST}" var="control">
                            <c:if test="${dataVo.controlNm eq control.controlNm}">
                                [<font style="font-weight: bold;"> ${control.name}</font> ]
                                <input type="hidden" name="controlNm" id="controlNm" value="${control.controlNm}" />
                            </c:if>
                        </c:forEach>
                        <span id="methodNm" ></span>
                        <input type="hidden" name="methodUrl" id="methodUrl" value="${dataVo.userMenuUrl}||${dataVo.adminMenuUrl}" />
                    </td>
                </tr>
            </c:if>

            <tr>
                <th>링크유형</th>
                <td>
                    <c:forEach items="${LINK_TYPE_LIST}" var="linkTypes" varStatus="vst">
                        <c:if test="${dataVo.linkType eq linkTypes.TYPE_CODE}">${linkTypes.TYPE_NAME}</c:if> 
                    </c:forEach>
                </td>
            </tr>

            <tr>
                <th>레이아웃선택</th>
                <td>
                    <input type="hidden" id="layoutCode" name="layoutCode" value="${dataVo.layoutCode}" />
                    <c:choose>
                        <c:when test="${empty dataVo.layoutCode}">
                            <font color="red">별도사용안함</font>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${layoutList}" var="layoutBean">
                                    <c:if test="${dataVo.layoutCode eq layoutBean.layoutCode}">
                                        <button type="button" class="s_blue" onclick="jsLayoutPreview();">미리보기</button>&nbsp;&nbsp;
                                        ${layoutBean.layoutDesc}
                                    </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <th>사용자메뉴URL</th>
                <td>
                    <c:if test="${not empty dataVo.userMenuUrl}" >
                        <button type="button" class="s_blue" onclick="jsUserPreview();">미리보기</button>
                        ${dataVo.userMenuUrl}
                    </c:if>
                    <c:if test="${not empty dataVo.subMenuUrl}">
                        <table style="margin-top:5px;">
                            <tr class="controlCls urlCls">
                                <th style="width:80px;padding:2px;">하위 URL</th>
                                <td style="padding:2px;">
                                    <div id="subMenuUrls">
                                        <c:forEach items="${dataVo.subMenuUrl}" var="subMenuUrl">
                                            <div style="margin-bottom:2px;">
                                                ${subMenuUrl}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                         </table>
                     </c:if>
                </td>
            </tr>

            <tr>
                <th>관리자메뉴URL</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty dataVo.adminMenuUrl and dataVo.menuType eq 'content'}">
                            <button type="button" class="s_blue" onclick="jsMoveTab(1);">컨텐츠이력</button>
                        </c:when>
                        <c:when test="${not empty dataVo.adminMenuUrl and dataVo.menuType eq 'reference'}">
                            <button type="button" class="s_blue" onclick="jsOpenTabPanel('${dataVo.menuNm} 관리', '${dataVo.adminMenuUrl}', '${dataVo.menuCode}', 'ADD');">컨텐츠관리</button>
                        </c:when>
                    </c:choose>
                    ${dataVo.adminMenuUrl}
                </td>
            </tr>

            <tr>
                <th>만족도사용여부</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.satisfyShowYn eq 'Y'}">사용</c:when>
                        <c:otherwise><font color="red">미사용</font></c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <th>SNS사용여부</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.snsUseYn eq 'Y'}">사용</c:when>
                        <c:otherwise><font color="red">미사용</font></c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <th>메뉴담당자표시</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.chargerShowYn eq 'Y'}">표시</c:when>
                        <c:otherwise><font color="red">미표시</font></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            
            <c:if test="${dataVo.chargerShowYn eq 'Y'}">
            <tr>
                <th>표시 담당자</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty dataVo.chargeDeptCode}">
                            ${dataVo.chargeDeptNm}(${dataVo.chargeDeptCode})
                            ${dataVo.chargerNm} (${dataVo.chargerId})
                        </c:when>
                        <c:otherwise><font color="red">미등록</font></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </c:if>

            <tr>
                <th>권한설정</th>
                <td>
                    <c:forEach items="${AUTH_TYPE_LIST}" var="authTypes" varStatus="vst">
                        <c:if test="${dataVo.authType eq authTypes.TYPE_CODE}">
                            [권한유형] : ${authTypes.TYPE_NAME} &nbsp;&nbsp;&nbsp;&nbsp;

                            <c:choose>
                                <c:when test="${dataVo.authType eq 'INC_DEPT'}">
                                    [권한부서] : ${dataVo.authDeptNm} 하위부서 포함 (${dataVo.authDeptCd})
                                </c:when>
                                <c:when test="${dataVo.authType eq 'EQ_DEPT' }">
                                    [권한부서] : ${dataVo.authDeptNm}  (${dataVo.authDeptCd})
                                </c:when>
                                <c:when test="${dataVo.authType eq 'MGR'}">
                                    [권한담당자] :
                                    <c:choose>
                                        <c:when test="${fn:length(dataVo.authMgrIdList) != 0}}">
                                            <div>
                                                <c:forEach items="${dataVo.authMgrIdList}" var="menuAuthVO">
                                                    <option value="${menuAuthVO.authMgrId}">${menuAuthVO.highDeptNm} ${menuAuthVO.deptNm}/${menuAuthVO.authMgrNm}</option>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>총괄운영자</c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>

            </tbody>
        </table>

        <br class="blank"/>

        <h4>부가 정보</h4>

        <table class="boardWrite" summary="부가 정보" >
            <caption class="title">부가 정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>

            <c:if test="${dataVo.menuType eq 'reference'}">
                <tr class="controlCls">
                    <th>상단컨텐츠</th>
                    <td>
                        <p class="tx_blue_s">응용컨텐츠 상단에 내용을 표시합니다.</p>
                        <textarea name="headContents" id="headContents" rows="5" cols="30" class="textarea" style="width:100%;" >${dataVo.headContents}</textarea>
                    </td>
                </tr>

                <tr class="controlCls">
                    <th>하단컨텐츠</th>
                    <td>
                        <p class="tx_blue_s">응용컨텐츠 하단에 내용을 표시합니다.</p>
                        <textarea name="footContents" id="footContents" rows="5" cols="30" class="textarea" style="width:100%;" >${dataVo.footContents}</textarea>
                    </td>
                </tr>
            </c:if>

            <c:if test="${dataVo.menuDepth eq 1}">
                <tr>
                    <th>메뉴제목이미지</th>
                    <td>
                        <c:if test="${not empty dataVo.menuTitleImg}">
                            <img src="${dataVo.menuTitleImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </c:if>
                    </td>
                </tr>
            </c:if>
            
            <tr>
                <th>본문제목이미지</th>
                <td>
                    <c:if test="${not empty dataVo.titleImg}">
                        <div>
                            <img src="${dataVo.titleImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </div>
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>메뉴ON이미지</th>
                <td>
                    <c:if test="${not empty dataVo.menuOnImg}">
                        <div>
                            <img src="${dataVo.menuOnImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </div>
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>메뉴OFF이미지</th>
                <td>
                    <c:if test="${not empty dataVo.menuOffImg}">
                        <div>
                            <img src="${dataVo.menuOffImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </div>
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>등록일</th>
                <td>${dataVo.regDt} ${dataVo.regNm}</td>
            </tr>
            <c:if test="${!empty dataVo.modDt}">
            <tr>
                <th>수정일</th>
                <td>${dataVo.modDt} ${dataVo.modNm}</td>
            </tr>
            </c:if> 
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="button" value="수정" class="w_blue" onclick="jsMenuUpdate();" /></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>

