<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>

<head>
    <title>담당자관리</title>
    <op:jsTag type="spi" items="extjs" />
    <op:jsTag type="openworks" items="tree" />

    <!-- tree -->
    <script type="text/javascript">
        var ROOT_VISIBLE   = true;
        var ROOT_TREE_ID   = '<%=zes.openworks.common.GlobalConfig.HIGH_DEPT_CD%>';
        var ROOT_TREE_TEXT = "부서 목록";

        var IS_USE = true;
        var PARENT_NODE_ID_VAR = "upperDeptCode";
        var NODE_ID_VAR        = "deptCode";
        var NODE_NM_VAR        = "deptNm";

        var TREE_JSON_URL  = '<c:url value="/intra/dept/INC_deptList.do" />';
        var VIEW_URL       = "ND_mgrListWithPermission.do";
        var DELETE_URL     = "ND_deleteAction.do";
        var NODE_ORDER_VAR = "deptOrdrNo";
        var ENABLE_DND     = false;
        var IS_APPEND_LEAF = false;

        var jsCreateUpdateParams = function() {
            return {
                deptNm : $("#nodeText").val()
            };
        };

        /* 리뷰후 임시 스크립트(원천적인 원인 찾아서 수정) */
        var jsView3 = function(node) {
            var params = {};
            if (typeof(ADDED_VAR) != "undefined") {
                if (ADDED_VALUE == "") return;
                params[ADDED_VAR] = ADDED_VALUE;
            }
            params[NODE_ID_VAR] = node.id;
            params[PARENT_NODE_ID_VAR] = node.parentNode ? node.parentNode.id : ROOT_TREE_ID;

            $("#treeDetailDiv").load( VIEW_URL, params, function(result) {
                if ( node.id != ROOT_TREE_ID )
                    $("input[name=nodePath]").val( jsNodePath(node) );
            });
        };

        var jsRegisterExcelEnBloc = function(){
            $("#excelEnBloc").colorbox({
                title  : "엑셀일괄등록",
                href   : "PD_registerExcelEnBloc.do",
                width  : "700" ,
                height : "400" ,
                iframe : true
            });
        };

        var jsUseYn = function(el,mngrId) {
            var elementz = $('#UseYn_' + mngrId);
            var checkBox = $('#ck_' + mngrId);
            var useYnVal = elementz.html() == '사용' ? 'N' : 'Y';
            $.post("ND_mgrUseYnUpdateAction.do", {
                mngrId : mngrId,
                useYn : useYnVal
            },
            function(response) {

                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.processOk);
                        elementz.removeClass();

                        if ( useYnVal == 'Y' ) {
                            elementz.addClass("ico-chk");
                            elementz.attr("title", "클릭 시 미사용으로 변경");
                            elementz.text("사용");
                            elementz.next("img").attr("src","/resources/intra/mgr/icon_chk_blue.png");
                            checkBox.removeAttr('disabled');
                        } else {
                            elementz.addClass("tx_red");
                            elementz.attr("title", "클릭 시 사용으로 변경");
                            elementz.text("미사용");
                            elementz.next("img").attr("src","/resources/intra/mgr/icon_cancel_red.png");
                            checkBox.attr('checked', false);
                            checkBox.attr('disabled', true);
                        }
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }

            });
        };

        var insertPop = function(deptCd) {
            $("#insertBtn").colorbox({
                title  : "담당자 정보",
                href   : "PD_insertForm.do?deptCode="+deptCd,
                width  : "900" ,
                height : "850" ,
                iframe : true
            });
        };

    </script>
</head>

<body>
    <div class="buser">
        <!-- 부서 목록 -->
        <div id="treeDiv" class="b_list"></div>

        <div id="treeDetailDiv" class="b_write">
            <h4 class="tx_13 float_l">담당자 목록</h4>
            <p class="clear">부서를 선택하세요.</p>
            <div class="float_r mar_b10">
                <a href="#"><button class="w_blue" id="insertBtn" onclick="insertPop();">담당자등록</button></a>
                <a href="#"><button class="w_blue" id="excelEnBloc" onclick="jsRegisterExcelEnBloc();">엑셀일괄등록</button></a>
                <a href="#"><button class="w_blue" onclick="alert('부서를 선택해주십시오.');">엑셀출력</button></a>
                <!-- <a href="#"><button class="w_blue" onclick="alert('준비 중..');">내부연계</button></a> -->
            </div>
        </div>
    </div>
</body>

</html>