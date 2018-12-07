<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>지정권한 수정</title>
<op:jsTag type="spi" items=",validate,colorbox" />
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
                   width : "450",
                   height: "300",
                   iframe: true
                  });
        };

           //저장
        var jsInsertAction = function() {
            var authCds = '';

            var selectedAuthCd = jsCheckedArray1();
            authCds = $.makeArray(selectedAuthCd);

            $('#authCds').val(authCds);

            if($('#authCds').val() == ''){
                alert("권한을 체크해 주세요");
                return;
            }

            if ( confirm("저장하시겠습니까?") ) {
                $.ajax({
                    url		: "ND_insertListAction.do",
                    type    : "POST",
                    data    : {authCds 	  : $('#authCds').val(),
                                  mngrId 		  : $('#mngrId').val(),
                                  mgrIds 		  : $('#mgrIds').val()
                    },
                    async    : false,
                    success  : function (response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
                                parent.$.fn.colorbox.close();
                                parent.$("#treeDetailDiv").load( VIEW_URL, $('#dataForm').serialize());
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

        <input type="hidden" name="authCds" id="authCds" value="" />
        <input type="hidden" name="mgrIds" id="mgrIds" value="${param.mgrIds}" />
        <input type="hidden" name="deptCode"  id="deptCode" value="${param.deptCode}"/>
        <input type="hidden" name="q_currPage" id="q_currPage" value="${param.q_currPage}"/>
        <input type="hidden" name="q_searckKey" id="q_searckKey" value="${param.q_searckKey}"/>
        <input type="hidden" name="q_searckValue" id="q_searckValue" value="${param.q_searckValue}"/>
        <input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${param.q_rowPerPage}"/>

        <div class="mar_t5">
            <span class="tx_11">목록 클릭시 지정된 권한 목록을 보실 수 있습니다.</span>
        </div>

        <!-- 리스트 -->
        <ul class="p_list">
            <c:forEach items="${dataList}" var="loop">
                <li><input type="checkbox" name="authCode" id="_${loop.authCode}" value="${loop.authCode}" class="checkbox"
                    <c:forEach  items="${dataVo}" var="loop1">
                        <c:if test="${loop1.authCode == loop.authCode}">checked="checked"</c:if>
                    </c:forEach> />
                    <label for="_${loop.authCode}">${loop.authNm} </label>
                    <a href="#" onclick="assignUpdateList(this,'${param.mngrId}', '${loop.authCode}', '${loop.authNm}');">${authCode}[목록]</a>
                </li>
            </c:forEach>
        </ul>
        <p class="mar_b20 tx_11" style="margin-left: 10px;">
            ※ 개인별로 표시된 권한 외에 추가로 지정하고자 할때는 개인별권한 지정관리를 이용하세요.
        </p>
        <p class="mar_l10">
            <input type="checkbox" name="checkAll" id="checkAll" />
            <label for="checkAll"><span class="tx_b">전체선택</span></label>
        </p>

        <p class="tx_r mar_t20">
            <a href="#"><button type="button" class="blue" onclick="jsInsertAction();">저장</button></a>
        </p>
        <!-- //리스트 -->
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>