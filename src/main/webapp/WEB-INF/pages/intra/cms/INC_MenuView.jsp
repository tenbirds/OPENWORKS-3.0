<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<c:if test="${not empty dataVo }">

    <script type="text/javascript">

        /* 응용컨텐츠 선택시 서브 기능 상세 목록을 표시(URL 포함) */
        var jsChangeControl = function() {

            $("#methodNm").removeOption(/./);
            
            var selectValue = $("#controlNm").val();

            if (!selectValue || selectValue == "") {
                return false;
            }

            var arrSelectValue = selectValue.split("|");
            var param = {
                beanNm    : arrSelectValue[0],
                methodNm  : arrSelectValue[1]
            };

            // 선택대상 기능의 서브 기능 목록을 가져와 select box에 셋팅한다.
            $.post("<c:url value="/intra/cms/getCmsRefernce.do"/>", param , function(result) {

                if (result != "") {
                    var dataList = result.split("\n");

                    for (var i = 0; i < dataList.length; i++) {
                        var data = dataList[i].split(",");
/*
                        var domainNm = $("#domainNm").val();
                        var prefix = "/" + domainNm;

                        if(domainNm.indexOf(".") > 0) {
                            var arrDomain = domainNm.split(".");
                            prefix = "/" + arrDomain[0];
                        }
                        data[1] = prefix + data[1];
*/

						var domainCd = "domainCd="+$("#domainCd").val();
						
						if(data[1].indexOf(domainCd) != -1 ){//언어별 게시판 나열
						    $("#methodNm").addOption(data[1], data[0], false);
						}
                    }

                    var methodValue = "${dataVo.userMenuUrl}||${dataVo.adminMenuUrl}";
                    $("#methodNm option").each(
                        function() {
                            if($(this).val() == methodValue) {
                                $(this).attr("selected", "selected");
                                return;
                            }
                        }
                    );
                }
            }, 'text');
        };

        /*
         * 서브메뉴를 선택 시 해당 URL을 관리자와 사용자 URL에 설정한다.
         * 선택값이 없다면 "" 으로 설정한다.
         */
        var jsChangeMethod = function(selectObj) {

            var selectValue = selectObj.value;
            $("#userMenuUrl, #adminMenuUrl").removeAttr("disabled");
            if(selectValue == "") {
                $("#userMenuUrl").val("");
                $("#adminMenuUrl").val("");
            } else {
                var arrSelectValue = selectValue.split("||");
                var userUrl = arrSelectValue[0];
                var adminUrl = arrSelectValue[1];

                $("#userMenuUrl").val(userUrl);
                $("#adminMenuUrl").val(adminUrl);
            }

            $("#userMenuUrl, #adminMenuUrl").attr("disabled","disabled");
        };

        /* 메뉴 유형선택 시 해당 유형에 따른 폼 설정 */
        var jsMenuTypeCtl = function(checkObj) {
            var checkValue = checkObj.val();

            if(checkValue == "url") {
                // URL 직접입력
                $(".controlCls, .contentCls").hide();
                $(".urlCls").show();
                $("#userMenuUrl, #adminMenuUrl").removeClass("hideColor");
                $("#userMenuUrl, #adminMenuUrl").removeAttr("disabled");
            } else if(checkValue == "content") {
                // 컨텐츠(정적, 동적)
                $(".controlCls").hide();
                $(".contentCls").show();
                $("#userMenuUrl, #adminMenuUrl").addClass("hideColor");
                $("#userMenuUrl, #adminMenuUrl").attr("disabled","disabled");
            } else if(checkValue == "reference") {
                // 응용프로그램
                $(".controlCls").show();
                $(".contentCls").hide();
                $("#userMenuUrl, #adminMenuUrl").addClass("hideColor");
                $("#userMenuUrl, #adminMenuUrl").attr("disabled","disabled");
            }
        };

        /** 컨텐츠유형 선택시 */
        var jsContentTypeCtl = function(checkObj) {

            return false;
        };

        /** 상단 컨텐츠 (응용프로그램 설정시 사용) */
        var jsGetHeadContents = function() {

            return $("#headContents").val();
        };
        
        /** 하단 컨텐츠 (응용프로그램 설정시 사용) */
        var jsGetFootContents = function() {

            return $("#footContents").val();
        };

        /** 담당자정보 삭제 */
        var jsClearChargeInfo = function() {
            $("#chargeDeptNm").val("");
            $("#chargerNm").val("");
            $("#chargerId").val("");
            $("#chargeDeptCode").val("");
        };

        // 하위 URL 폼 생성
        var addSubMenuUrl = function() {
            $("#subMenuUrls").append($("#subMenuDummy").html());
        };

        // 하위 URL 폼 삭제
        var delSubMenuUrl = function(obj) {
            $(obj).parent().remove();
            // 하위 URL 폼이 하나도 없는경우 기본값 생성
            if ($.trim($("#subMenuUrls").html()) == "") {
                addSubMenuUrl();
            }
        };

        // 이미지 삭제
        var deleteImg = function(obj, id) {
            $("#"+id).val("");
            $(obj).parent().remove();
        };

        // 선택된 권한설정 유형에 따른 입력폼 조정
         var jsToggleAuthTr = function() {
            var authType = $("input[name=authType]:checked").val();
            if(authType == "MGR") {
                $("#authDeptTr").hide();
                $("#authMgrTr").show();
            } else if((authType == "INC_DEPT") || (authType == "EQ_DEPT")) {
                $("#authDeptTr").show();
                $("#authMgrTr").hide();
            } else {
                $("#authDeptTr").hide();
                $("#authMgrTr").hide();
            }
        };

        // 표시담당자 표시 여부에 따른 담당자 정보 조정
        var jsChargerShowTr = function() {
            var chargerShow = $("input[name=chargerShowYn]:checked").val();
            if(chargerShow == "Y") {
                $("#chargerShowTr").show();
            } else {
                $("#chargerShowTr").hide();
            }
        };

        $().ready(function() {
            
            $(".authType").click(function() {jsToggleAuthTr();});
            
            // 메뉴유형이 프로그램인경우 컨트롤 활성화
            jsChangeControl();
            // 선택된 권한설정 유형에 따른 입력폼 조정
            jsToggleAuthTr();
            // 표시담당자 표시 여부에 따른 담당자 정보 조정
            jsChargerShowTr();
            /** 표시담당자 설정 Autocomplete */
            $("input[name=chargerNm]").autocomplete({
                minLength: ($.browser.mozilla ? 1: 2),
                delay: ($.browser.mozilla ? 800: 10),
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/mgr/ND_mgrSearchList.do" />",
                        type: "POST",
                        dataType: "json",
                        data: {
                            q_rowPerPage: 20,
                            useYn: "Y",
                            mgrNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function( event, ui ) {
                    $("#chargeDeptNm").val(ui.item.deptNm);
                    $("#chargerNm").val(ui.item.mgrNm);

                    $("#chargerId").val(ui.item.mgrId);
                    $("#chargeDeptCode").val(ui.item.deptCd);
                }
            });

            /** 권한담당자 설정 Autocomplete */
            $("input[name=authMgrNm]").autocomplete({
                minLength: ($.browser.mozilla ? 1: 2),
                delay: ($.browser.mozilla ? 800: 10),
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/mgr/ND_mgrSearchList.do" />",
                        type: "POST",
                        dataType: "json",
                        data: {
                            q_rowPerPage: 20,
                            useYn: "Y",
                            mgrNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function( event, ui ) {
                    $("#authMgrId").addOption(ui.item.mgrId, ui.item.label);
                },
                close: function(event, ui) {
                    $("#authMgrNm").val("");
                }
            });

            /** 권한부서 설정 Autocomplete */
            $("input[name=authDeptNm]").autocomplete({
                minLength: ($.browser.mozilla ? 1: 2),
                delay: ($.browser.mozilla ? 800: 10),
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/dept/INC_deptSearchList.do" />",
                        type: "post",
                        dataType: "json",
                        data: {
                            useYn: "Y",
                            deptNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function( event, ui ) {
                    $("#authDeptCd").val(ui.item.deptCd);
                    $("#authDeptNm").val(ui.item.label);
                },
                close: function(event, ui) {
                    $("#authMgrNm").val("");
                }
            });

            /** 메뉴유형에 변경에 따른 이벤트 설정 */
            $("input[name=menuType]").click(function() {
                jsMenuTypeCtl($(this));
            });
            /** 메뉴유형에 따른 기본 설정 항목 표시/미표시 */
            if($("input[name=menuType]:checked").val()) {
                jsMenuTypeCtl($("input[name=menuType]:checked"));
            } else {
                $("input[name=menuType]").each(function() {
                    if($(this).val() == "url") {
                        $(this).attr("checked","checked");
                        return false;
                    }
                });
                $("#menuType_1").click();
            }

            // 하위메뉴 URL 폼 생성
            addSubMenuUrl();

            // 업로드 파일 폼 설정
            jsSetMultiFile();

        });

    </script>

    <form name="dataForm" id="dataForm" action="ND_UpdateAction.do" method="post" enctype="multipart/form-data">
        <input type="hidden" id="domainCd" name="domainCd" value="${dataVo.domainCd}" />
        <input type="hidden" id="domainNm" name="domainNm" value="${dataVo.domainNm}" />
        <input type="hidden" id="portNo" value="${dataVo.portNo}" />

        <input type="hidden" id="topMenuCode" name="topMenuCode" value="${dataVo.topMenuCode}" />
        <input type="hidden" id="parentMenuCode" name="parentMenuCode" value="${dataVo.parentMenuCode}" />
        <input type="hidden" id="menuCode" name="menuCode" value="${dataVo.menuCode}" />
        <input type="hidden" id="menuDepth" name="menuDepth" value="${dataVo.menuDepth}" />
        <input type="hidden" id="sortOrder" name="sortOrder" value="${dataVo.sortOrder}" />
        <input type="hidden" id="contentSeqNo" name="contentSeqNo" value="${dataVo.contentSeqNo}" />

        <input type="hidden" id="q_domainCd" name="q_domainCd" value="${dataVo.domainCd}" />
        <input type="hidden" id="q_menuCode" name="q_menuCode" value="${dataVo.menuCode}" />
        <input type="hidden" id="q_contentSeqNo" name="q_contentSeqNo" value="${dataVo.contentSeqNo}" />

        <input type="hidden" id="layoutPreviewUrl" value="<c:url value="/intra/cms/layout/PD_LayoutPreView.do"/>" />

        <h4 class="tx_13">메뉴 정보</h4>

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
                <th>메뉴 명<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="text" name="menuNm" id="menuNm" value="${dataVo.menuNm}" maxlength="50" />
                    <span class="tx_blue_s">(최대 <b>50</b>자)</span>
                </td>
                <th>제목</th>
                <td>
                    <input type="text" name="title" id="title" value="${dataVo.title}" maxlength="50" />
                    <p class="tx_blue_s">개별 제목 사용시(기본은 메뉴명이 사용됨)</p>
                </td>
            </tr>

            <tr>
                <th>사용 여부<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="useYn" id="useYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.useYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="useYn_Y">사용</label>
                    <input type="radio" name="useYn" id="useYn_N" value="N" class="radio"
                        <c:if test="${dataVo.useYn eq 'N'}">checked="checked"</c:if> />
                        <label for="useYn_N">미사용</label>
                    <p class="tx_blue_s">메뉴 사용 여부 지정(서비스 이용불가)</p>
                </td>

                <th>메뉴표시 여부<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="showYn" id="showYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.showYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="showYn_Y">메뉴표시</label>
                    <input type="radio" name="showYn" id="showYn_N" value="N" class="radio"
                        <c:if test="${dataVo.showYn eq 'N'}">checked="checked"</c:if> />
                        <label for="showYn_N">일반페이지</label>
                    <p class="tx_blue_s">일반페이지는 메뉴로 표시되지 않습니다.</p>
                </td>
            </tr>

            </tbody>
        </table>

        <br class="blank"/>

        <h4 class="tx_13">기본 정보 설정</h4>

        <table class="boardWrite" summary="기본 정보 설정" >
            <caption class="title">기본 정보 설정</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>

           <tr>
                <th>메뉴유형<span class="tx_red tx_b">*</span></th>
                <td>
                    <c:forEach items="${MENU_TYPE_LIST}" var="menuTypes" varStatus="vst">
                        <input type="radio" name="menuType" id="menuType_${vst.count}"
                            <c:if test="${dataVo.menuType eq menuTypes.TYPE_CODE}">checked='checked'</c:if>
                                value="${menuTypes.TYPE_CODE}" class="menuType" />
                        <label for="menuType_${vst.count}">${menuTypes.TYPE_NAME}</label>
                        &nbsp;
                    </c:forEach>
                </td>
            </tr>

            <tr class="contentCls">
                <th>컨텐츠편집<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="hidden" id="contentType" name="contentType" value="static" />
                    <c:choose>
                        <c:when test="${empty dataVo.contentType}">
                            <p class="tx_blue_s">컨텐츠를 생성하시려면 컨텐츠 유형을 선택후 수정버튼을 클릭하세요.</p>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="s_blue" onclick="jsContentForm();">컨텐츠편집</button>
                        </c:otherwise>
                    </c:choose>

                </td>
            </tr>

            <tr class="contentCls">
                <th>승인여부<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="radio" name="approvalYn" id="approvalYn_${vst.count}"
                        <c:if test="${dataVo.approvalYn eq 'Y'}">checked='checked'</c:if> 
                            value="Y" class="approvalYn" /> 
                    <label for="approvalYn_${vst.count}">승인필요</label>
                    <input type="radio" name="approvalYn" id="approvalYn_${vst.count}"
                        <c:if test="${empty dataVo.approvalYn or dataVo.approvalYn eq 'N'}">checked='checked'</c:if> 
                            value="N" class="approvalYn" /> 
                    <label for="approvalYn_${vst.count}">자동승인</label>
                </td>
            </tr>

            <tr class="controlCls">
                <th>응용컨텐츠선택</th>
                <td>
                    <select id="controlNm" name="controlNm" onchange="jsChangeControl();">
                        <option value="">-- 선택하세요 --</option>
                        <c:forEach items="${CONTROL_LIST}" var="control">
                        <option value="${control.controlNm}" 
                            <c:if test="${dataVo.controlNm eq control.controlNm}">selected='selected'</c:if>>
                            ${control.name}</option>
                        </c:forEach>
                    </select>
                    <select id="methodNm" name="methodm" onchange="jsChangeMethod(this)">
                        <option value="">-- 선택하세요 --</option>
                        <c:forEach items="${methodList}" var="method">
                        <option value="${dataVo.userMenuUrl}||${dataVo.adminMenuUrl}" 
                            <c:if test="${dataVo.userMenuUrl eq method.userMenuUrl}">selected='selected'</c:if>>
                            ${method.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr class="userUrlSection">
                <th>사용자메뉴URL<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="text" id="userMenuUrl" name="userMenuUrl" value="${dataVo.userMenuUrl}" maxlength="200" style="width:50%" />
                    <c:if test="${not empty dataVo.userMenuUrl}" >
                        <button type="button" class="s_blue" onclick="jsUserPreview();">미리보기</button>
                    </c:if>

                    <table style="margin-top:5px;width:100%;">
                        <tr class="controlCls urlCls">
                            <th style="width:80px;padding:2px;">하위 URL</th>
                            <td style="padding:2px;">
                                <div id="subMenuDummy" style="display:none">
                                    <div style="margin-bottom:2px;">
                                        <input type="text" name="subMenuUrl" id="subMenuUrl" value="" maxlength="200" style="width:70%" />

                                        <button type="button" class="s_blue" onclick="addSubMenuUrl();">추가</button>
                                        <button type="button" class="s_blue" onclick="delSubMenuUrl(this);">삭제</button>
                                    </div>
                                </div>
                                <div id="subMenuUrls">
                                    <c:forEach items="${dataVo.subMenuUrl}" var="subMenuUrl">
                                        <div style="margin-bottom:2px;">
                                            <input type="text" name="subMenuUrl" id="subMenuUrl" value="${subMenuUrl}" maxlength="200" style="width:70%" />
                                            <button type="button" class="s_blue" onclick="addSubMenuUrl();">추가</button>
                                            <button type="button" class="s_blue" onclick="delSubMenuUrl(this);">삭제</button>
                                        </div>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                     </table>
                </td>
            </tr>

            <tr>
                <th>링크유형</th>
                <td>
                    <c:forEach items="${LINK_TYPE_LIST}" var="linkTypes" varStatus="vst">
                        <input type="radio" name="linkType" id="linkType_${vst.count}"
                            <c:if test="${dataVo.linkType eq linkTypes.TYPE_CODE}">checked='checked'</c:if> 
                                value="${linkTypes.TYPE_CODE}" class="linkType" /> 
                        <label for="linkType_${vst.count}">${linkTypes.TYPE_NAME}</label>
                        &nbsp;
                    </c:forEach>
                </td>
            </tr>

            <tr>
                <th>레이아웃선택</th>
                <td>
                    <input type="hidden" id="preLayoutCode" name="preLayoutCode" value="${dataVo.layoutCode}" />
                    <select name="layoutCode" id="layoutCode" class="select">
                        <option value="">-- 별도사용안함 --</option>
                        <c:forEach items="${layoutList}" var="layoutBean">
                            <option value="${layoutBean.layoutCode}"
                                <c:if test="${dataVo.layoutCode eq layoutBean.layoutCode}"> selected="selected" </c:if>>${layoutBean.layoutDesc}
                            </option>
                        </c:forEach>
                    </select>&nbsp;&nbsp;

                    <c:if test="${not empty dataVo.layoutCode}">
                        <button type="button" class="s_blue" onclick="jsLayoutPreview();">미리보기</button>&nbsp;&nbsp;
                    </c:if>

                    <input type="checkbox" id="parentLayoutUseYn" name="parentLayoutUseYn"
                        <c:if test="${dataVo.parentLayoutUseYn eq 'Y'}">checked='checked'</c:if>
                            value="Y" />
                    <span class="tx_blue_s">상위메뉴 레이아웃 설정을 사용</span>
                </td>
            </tr>

            <tr class="adminUrlsection">
                <th>관리자메뉴URL</th>
                <td>
                    <input type="text" id="adminMenuUrl" name="adminMenuUrl" value="${dataVo.adminMenuUrl}" maxlength="200" style="width:50%" />
                    <c:choose>
                        <c:when test="${not empty dataVo.adminMenuUrl and dataVo.menuType eq 'content'}">
                            <button type="button" class="s_blue" onclick="jsMoveTab(1);">컨텐츠이력</button>
                        </c:when>
                        <c:when test="${not empty dataVo.adminMenuUrl and dataVo.menuType eq 'reference'}">
                            <button type="button" class="s_blue" onclick="jsOpenTabPanel('${dataVo.menuNm} 관리', '${dataVo.adminMenuUrl}', '${dataVo.menuCode}', 'ADD');">컨텐츠관리</button>
                        </c:when>
                    </c:choose>
                </td>
            </tr>

            <%-- <tr>
                <th>만족도사용여부<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="satisfyShowYn" id="satisfyShowYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.satisfyShowYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="satisfyShowYn_Y">사용</label>
                    <input type="radio" name="satisfyShowYn" id="satisfyShowYn_N" value="N" class="radio"
                        <c:if test="${empty dataVo.satisfyShowYn or dataVo.satisfyShowYn eq 'N'}">checked="checked"</c:if> />
                        <label for="satisfyShowYn_N">미사용</label>
                    <p class="tx_blue_s">사용자 만족도 평가 사용여부</p>
                </td>
            </tr> --%>
			<input type="hidden" name="snsUseYn" value="N" />
            <%-- <tr>
                <th>SNS사용여부<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="snsUseYn" id="snsUseYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.snsUseYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="snsUseYn_Y">사용</label>
                    <input type="radio" name="snsUseYn" id="snsUseYn_N" value="N" class="radio"
                        <c:if test="${empty dataVo.snsUseYn or dataVo.snsUseYn eq 'N'}">checked="checked"</c:if> />
                        <label for="snsUseYn_N">미사용</label>
                </td>
            </tr> --%>

            <%-- <tr>
                <th>메뉴담당자표시<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="chargerShowYn" id="chargerShowYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.chargerShowYn eq 'Y'}">checked="checked"</c:if> onclick="jsChargerShowTr();"/>
                        <label for="chargerShowYn_Y">표시</label>
                    <input type="radio" name="chargerShowYn" id="chargerShowYn_N" value="N" class="radio"
                        <c:if test="${dataVo.chargerShowYn eq 'N'}">checked="checked"</c:if> onclick="jsChargerShowTr();"/>
                        <label for="chargerShowYn_N">미표시</label>
                        
                    <p class="tx_blue_s">사용자화면에 담당자 정보 표시 여부를 지정합니다.</p>
                </td>
            </tr>

            <tr id="chargerShowTr" style="display:none;">
                <th>메뉴담당자<span class="tx_red tx_b">*</span></th>
                <td>
                    [담당자명] <input type="text" name="chargerNm" id="chargerNm" value="${dataVo.chargerNm}" class="text-input w-100"/>&nbsp;&nbsp;&nbsp;
                    [담당부서] <input type="text" name="chargeDeptNm" id="chargeDeptNm" value="${dataVo.chargeDeptNm}" readonly="readonly"/>

                               <button type="button" class="s_blue" onclick="jsClearChargeInfo();">삭제</button>

                    <input type="hidden" name="chargerId" id="chargerId" value="${dataVo.chargerId}"/>
                    <input type="hidden" name="chargeDeptCode" id="chargeDeptCode" value="${dataVo.chargeDeptCode}"/>
                    <p class="tx_blue_s">메뉴 담당자 이름을 입력한 후 선택하세요.</p>
                </td>
            </tr>

            <tr>
                <th>관리담당유형</th>
                <td>
                    <c:forEach items="${AUTH_TYPE_LIST}" var="authTypes" varStatus="vst">
                        <input type="radio" name="authType" id="authType_${vst.count}"
                            <c:if test="${dataVo.authType eq authTypes.TYPE_CODE}">checked='checked'</c:if> 
                                value="${authTypes.TYPE_CODE}" class="authType"/> 
                        <label for="authType_${vst.count}">${authTypes.TYPE_NAME}</label>
                        &nbsp;
                    </c:forEach>
                </td>
            </tr>

            <tr id="authDeptTr">
                <th>관리부서</th>
                <td>
                    [부서명] : <input type="text" name="authDeptNm" id="authDeptNm" value="${dataVo.authDeptNm}" />
                    [부서코드] : <input type="text" name="authDeptCd" id="authDeptCd" value="${dataVo.authDeptCd}" readonly="readonly"/>
                    <p class="tx_blue_s">부서명을 입력하세요.</p>
                </td>
            </tr>

            <tr id="authMgrTr">
                <th>관리담당자</th>
                <td>
                    <div>
                        <select name="authMgrId" id="authMgrId" size="4" multiple="multiple" style="width: 300px; background-color: #E1E1E1; height: 65px;">
                            <c:if test="${fn:length(dataVo.authMgrIdList) != 0}">
                                <c:forEach items="${dataVo.authMgrIdList}" var="menuAuthVO">
                                    <option value="${menuAuthVO.authMgrId}">${menuAuthVO.highDeptNm}
                                        ${menuAuthVO.deptNm}/${menuAuthVO.authMgrNm}</option>
                                </c:forEach>
                            </c:if>
                        </select>

                        <button type="button" class="s_blue" onclick="$('#authMgrId').removeOption(/./, true);">선택삭제</button>

                    </div>
                    <div class="mar_t10">
                        [담당자명] : <input type="text" name="authMgrNm" id="authMgrNm" value="" class="text"/>
                        <p class="tx_blue_s">권한 담당자 이름을 입력하세요.</p>
                    </div>
                </td>
            </tr> --%>

            <tr>
                <th>사용자권한</th>
                <td>
                    <c:forEach items="${USER_GRADE_LIST}" var="userGrade" varStatus="vst">
                        <input type="checkbox" name="userGradeCds" id="userGradeCds_${vst.count}" value="${userGrade.userGradCode}"
                            <c:forEach items="${dataVo.userGradeCd}" var="cmsUserGradeCd">
                                <c:if test="${cmsUserGradeCd.userGradeCd eq userGrade.userGradCode}">checked='checked'</c:if>
                            </c:forEach>
                        />
                        <label for="userGradeCd_${vst.count}">${userGrade.userGradNm}</label>
                        &nbsp;
                    </c:forEach>
                    <p class="tx_blue_s">특정회원 유형만 공개를 원하는 경우 선택하세요.</p>
                </td>
            </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="button" value="수정" class="w_blue" onclick="jsMenuUpdate();" style="cursor: pointer;"/></li>
                <c:if test="${dataVo.topMenuCode ne 'DOMAIN'}">
                    <li><input type="button" value="삭제" class="w_blue" onclick="jsMenuDelete();" style="cursor: pointer;"/></li>
                </c:if>
            </ul>
        </div>
        <!-- //버튼 -->

        <h4 class="tx_13">부가 정보 설정</h4>

        <table class="boardWrite" summary="부가 정보 설정" >
            <caption class="title">부가 정보 설정</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>

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

            <c:if test="${dataVo.menuDepth eq 1}">
                <tr>
                    <th>메뉴제목이미지</th>
                    <td>
                        <input type="file" name="menuTitleImgFile" id="menuTitleImgFile" class="w470 multi" />
                        <p class="tx_blue_s">메뉴목록 상단 표시되는 이미지 입니다.(최상위메뉴그룹 사용)</p>

                        <c:if test="${not empty dataVo.menuTitleImg}">
                            <div>
                                <button type="button" class="w_blue mar_l5 mar_b5" onclick="deleteImg(this, 'menuTitleImg');">삭제</button>
                                <img src="${dataVo.menuTitleImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                            </div>
                            <input type="hidden" id="menuTitleImg" name="menuTitleImg" value="${dataVo.menuTitleImg}" />
                        </c:if>
                    </td>
                </tr>
            </c:if>
            
            <tr>
                <th>본문제목이미지</th>
                <td>
                    <input type="file" name="titleImgFile" id="titleImgFile" class="w470 multi" />
                    <p class="tx_blue_s">제목에 해당되는 영역에 표시되는 이미지 입니다.</p>

                    <c:if test="${not empty dataVo.titleImg}">
                        <div>
                            <button type="button" class="w_blue mar_l5 mar_b5" onclick="deleteImg(this, 'titleImg');">삭제</button>
                            <img src="${dataVo.titleImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </div>
                        <input type="hidden" id="titleImg" name="titleImg" value="${dataVo.titleImg}" />
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>메뉴ON이미지</th>
                <td>
                    <input type="file" name="menuOnImgFile" id="menuOnImgFile" class="w470 multi" />
                    <p class="tx_blue_s">선택된 메뉴 또는 마우스 오버시 이미지.</p>
                    <c:if test="${not empty dataVo.menuOnImg}">
                        <div>
                            <button type="button" class="w_blue mar_l5 mar_b5" onclick="deleteImg(this, 'menuOnImg');">삭제</button>
                            <img src="${dataVo.menuOnImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </div>
                        <input type="hidden" id="menuOnImg" name="menuOnImg" value="${dataVo.menuOnImg}" />
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>메뉴OFF이미지</th>
                <td>
                    <input type="file" name="menuOffImgFile" id="menuOfImgFile" class="w470 multi" />
                    <p class="tx_blue_s">선택되지 않은 메뉴의 경우 이미지</p>
                    <c:if test="${not empty dataVo.menuOffImg}">
                        <div>
                            <button type="button" class="w_blue mar_l5 mar_b5" onclick="deleteImg(this, 'menuOffImg');">삭제</button>
                            <img src="${dataVo.menuOffImg}" alt="${dataVo.menuNm}" style="border: 1px solid #333333;"/>
                        </div>
                        <input type="hidden" id="menuOffImg" name="menuOffImg" value="${dataVo.menuOffImg}" />
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
                <li><input type="button" value="수정" class="w_blue" onclick="jsMenuUpdate();" style="cursor: pointer;"/></li>
                <c:if test="${dataVo.topMenuCode ne 'DOMAIN'}">
                    <li><input type="button" value="삭제" class="w_blue" onclick="jsMenuDelete();" style="cursor: pointer;"/></li>
                </c:if>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>

</c:if>

        <h4 class="tx_13">메뉴 추가</h4>

        <table class="boardWrite" summary="메뉴 추가" >
            <caption class="title">메뉴 추가</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
            <tr>
                <th>메뉴코드<span class="tx_red tx_b">*</span></th>
                <td><input type="text" name="newMenuCode" id="newMenuCode" maxlength="45"
                    class="text-input w-200 eng" /> <span class="tx_blue_s">(영문 <b>45</b>자 이내)</span>
                </td>
            </tr>
            <tr>
                <th>메뉴명<span class="tx_red tx_b">*</span></th>
                <td><input type="text" name="newMenuNm" id="newMenuNm" maxlength="50"
                    class="text-input w-200" /> <span class="tx_blue_s">(최대 <b>50</b>자)</span>
                </td>
            </tr>
            <tr>
                <th>추가 옵션</th>
                <td>
                    <div><input type="radio" name="appendOption" id="isSame" value="isSame" class="radio" 
                        <c:if test="${dataVo.topMenuCode eq 'DOMAIN'}">disabled="disabled"</c:if> /> 
                        <label for="isSame">선택한 메뉴 동일 레벨에 추가</label></div>
        
                    <div><input type="radio" name="appendOption" id="isChild" value="isChild" class="radio" />
                        <label for="isChild">선택한 메뉴 하위 레벨에 추가</label></div>
                    <!-- 
                    <div><input type="radio" name="appendOption" id="isRoot" value="isRoot"
                        class="radio" checked="checked" /> <label for="isRoot">루트 메뉴에 추가</label></div>
                    -->
                </td>
            </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="button" value="추가" class="w_blue" onclick="jsMenuInsert();" style="cursor: pointer;"/></li>
            </ul>
        </div>
        <!-- //버튼 -->

<%--
            <tr>
                <th>통계사용여부<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="statisticsUseYn" id="statisticsUseYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.statisticsUseYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="statisticsUseYn_Y">사용</label>
                    <input type="radio" name="statisticsUseYn" id="statisticsUseYn_N" value="N" class="radio"
                        <c:if test="${empty dataVo.statisticsUseYn or dataVo.statisticsUseYn eq 'N'}">checked="checked"</c:if> />
                        <label for="statisticsUseYn_N">미사용</label>
                    <span class="tx_blue_s">통계로 사용할 메뉴인지 지정</span>
                </td>
            </tr>

            <tr>
                <th>SNS사용여부<span class="tx_red tx_b">*</span></th>
                <td><input type="radio" name="snsUseYn" id="snsUseYn_Y" value="Y" class="radio"
                        <c:if test="${dataVo.snsUseYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="snsUseYn_Y">사용</label>
                    <input type="radio" name="snsUseYn" id="snsUseYn_N" value="N" class="radio"
                        <c:if test="${empty dataVo.snsUseYn or dataVo.snsUseYn eq 'N'}">checked="checked"</c:if> />
                        <label for="snsUseYn_N">미사용</label>
                    <span class="tx_blue_s">SNS를 사용할 메뉴인지 지정</span>
                </td>
            </tr>
--%>