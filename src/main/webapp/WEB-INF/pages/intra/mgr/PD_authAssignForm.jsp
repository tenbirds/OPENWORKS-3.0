<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>지정권한 수정</title>
    <op:jsTag type="spi" items="validate,colorbox" />
    <script type="text/javascript">

        var VIEW_URL = "ND_mgrListWithPermission.do";

        $().ready(function() {
            $("#checkAll").click(function() {
                var checkedStatus = this.checked;
                $(".checkbox").each(function() {
                    this.checked = checkedStatus;
                });
            });
        });

        var isProcess = function() {
            var checked = new Array();
            $(".checkbox:checked").each(function (i) {
                checked[i] = $(this).val();
            });

            if ( checked.length < 1 ) {
                if ( confirm("선택된 메뉴그룹이 없습니다.\n\n계속 진행하시겠습니까?") ) {
                    return true;
                }
                else {
                    return false;
                }
            }
            return true;
        };

        var assignUpdateList = function (el, vl, authCode, authNm) {
            $(el).colorbox({
                   title : "["+authNm +"] 지정 권한 목록",
                   href  : "PD_targetAssignByAuthCd.do?authCode=" + authCode,
                   width : "530",
                   height: "450",
                   iframe: true
                  });
        };

        //저장
        var jsInsertAction = function(saveMode) {
            var authCd = $.makeArray(jsCheckedArray1());

            $('#authCds').val(authCd);

            if(saveMode == 'Insert' && $('#authCds').val() == ''){
                alert("권한을 체크해 주세요");
                return;
            }

            var actionUrl = "ND_insertAssignAction.do";
            if(saveMode == 'Update') actionUrl = "ND_assignUpdateAction.do";

            if ( confirm("저장하시겠습니까?") ) {
                $.ajax({
                    url		: actionUrl,
                    type    : "POST",
                    data    : {authCds : $('#authCds').val(),
                               mngrId   : $('#mngrId').val()
                    },
                    async    : false,
                    success  : function (response) {

                        try {
                            if(eval(response)) {
                                var resultMsg = Message.msg.insertOk;
                                if(saveMode == "Update") {
                                    resultMsg = Message.msg.updateOk;
                                }

                                jsSuccessBox(resultMsg);

                                parent.$.fn.colorbox.close();
                                if( '${param.mode}' == "form") {
                                    var authNm = '';
                                    $("input[name=authCode]:checked").each(function(index){
                                        if (index > 0){
                                            authNm += ", "+ $(this).next("label").html();
                                        }else{
                                            authNm += $(this).next("label").html();
                                        }
                                        if(index == 0) authCd = $(this).val();
                                    });
                                    parent.jsSetAssignListArea(authNm, authCd);
                                }
                                else {
                                    parent.$("#treeDetailDiv").load( VIEW_URL, $('#dataForm').serialize());
                                }
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        } catch (e) {
                            jsSysErrorBox(response, e);
                            return;
                        }
                    }
                });
            }
           };

        //체크된 글 목록
        var jsCheckedArray1 = function() {
            var selectedAuthCd = new Array();
            $("body input.checkbox:checked").each(function (i) {
                 selectedAuthCd[i] = $(this).val();
            });
            return selectedAuthCd;
        };
    </script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <h2>지정하고자 하는 권한을 선택한 후 저장버튼을 클릭하세요.</h2>
    <form id="dataForm">
    <input type="hidden" name="q_currPage" id="q_currPage" value="${param.q_currPage}"/>
    <input type="hidden" name="q_searckKey" id="q_searckKey" value="${param.q_searckKey}"/>
    <input type="hidden" name="q_searckValue" id="q_searckValue" value="${param.q_searckValue}"/>
    <input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${param.q_rowPerPage}"/>

    <input type="hidden" name="authCds" id="authCds" value="" />

    <input type="hidden" name="mngrId" id="mngrId" value="${param.mngrId}" />
    <input type="hidden" name="deptCode" id="deptCode" value="${param.deptCode}"/>
    <input type="hidden" name="pageDiv" id="pageDiv" value="${param.pageDiv}" />


    <div class=" mar_t5"><span class="tx_11">목록 클릭시 지정된 권한 목록을 보실 수 있습니다.</span></div>
    <!-- 리스트 -->
    <ul class="p_list">
    <c:choose>
        <c:when test="${fn:length(dataList) != 0}">
            <c:forEach items="${dataList}" var="loop">
                <li><input type="checkbox" name="authCode" id="_${loop.authCode}" value="${loop.authCode}" class="checkbox"
                    <c:forEach  items="${currentlyListByMgrId}" var="loop1">
                        <c:if test="${loop1.authCode == loop.authCode}">checked="checked"</c:if>
                    </c:forEach> />
                    <label for="_${loop.authCode}">${loop.authNm}</label>
                    <a href="#" onclick="assignUpdateList(this,'${param.mngrId}', '${loop.authCode}', '${loop.authNm}');" >${authCode}[목록]</a>
                </li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <span class="emphasis">등록된 권한그룹이 존재하지 않습니다.</span>
        </c:otherwise>
    </c:choose>
    </ul>
    <p class="clear mar_b20" style="margin-left:10px;font-size:11px;">
        ※ 개인별로 표시된 권한 외에 추가로 지정하고자 할때는 개인별권한 지정관리를 이용하세요.
    </p>
    <p class="mar_l10">
        <input type="checkbox" name="checkAll" id="checkAll" /> <label for="checkAll"><span class="tx_b">전체선택</span></label>
    </p>

    <p class="tx_r mar_t20">
        <a href="#">
            <c:choose>
                <c:when test="${fn:length(currentlyListByMgrId) eq 0}">
                    <button class="blue" type="button" onclick="jsInsertAction('Insert');">등록</button>
                </c:when>
                <c:otherwise>
                    <button class="blue" type="button" onclick="jsInsertAction('Update');">수정</button>
                </c:otherwise>
            </c:choose>
        </a>
        <a href="#" ><button onclick="parent.$.fn.colorbox.close();" class="blue">취소</button></a>
    </p>
    <!-- //리스트 -->
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>