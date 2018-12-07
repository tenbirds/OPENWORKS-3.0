<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>부서이동</title>
<op:jsTag type="spi" items="extjs" />
<op:jsTag type="openworks" items="tree" />

<script type="text/javascript">

    //Extjs 트리의 설정값 설정하는 부분
    var ROOT_TREE_ID      = '<%=zes.openworks.common.GlobalConfig.HIGH_DEPT_CD%>';
    var TREE_EL_ID        = "treeCombo";
    var ROOT_TREE_TEXT    = "부서목록";
    var PANEL_SIZE_HEIGHT = 100;

    var IS_USE             = true;
    var IS_APPEND_LEAF     = true;
    var PARENT_NODE_ID_VAR = "upperDeptCode";
    var NODE_ID_VAR        = "deptCode";
    var NODE_NM_VAR        = "deptNm";
    var NODE_ORDER_VAR     = "deptOrdrNo";
    var PARENT_NODE_ID_VAR = "upperDeptCode";
    var TREE_JSON_URL      = '<c:url value="/intra/dept/INC_deptListAll.do" />';
    var VIEW_URL           = "ND_mgrListWithPermission.do";
    var DELETE_URL         = "ND_deleteAction.do";

    var jsView = function(node) {
        $("#deptCode").val(node.id);
    };

    $().ready(function() {
        var oldNode = parent.treePanel.getSelectionModel().getSelectedNode();
        $('#nodePath').text(parent.jsNodePath(oldNode));
        $('#oldDeptCd').val(oldNode.id);
    });

    var deptTransferAction = function() {
        if ($('#oldDeptCd').val() == $("#deptCode").val()) {
            jsWarningBox('동일한 부서입니다.');
            return false;
        }

        if ( confirm("수정하시겠습니까?") ) {
            $.ajax({
                url		: "INC_deptTransferAction.do",
                type    : "POST",
                data    : { mgrIds : $('#mgrIds').val() ,
                            deptCode : $('#deptCode').val() },
                async   : false,
                success : function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.updateOk);
                            parent.$.fn.colorbox.close();
                            parent.$("#treeDetailDiv").load( VIEW_URL, parent.$('#dataForm').serialize());
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


    </script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <form name="dataForm" id="dataForm">
    <input type="hidden" name="mgrIds" id="mgrIds" value="${param.mgrIds}" />


    <h2>이동할 부서를 선택한 후 저장하세요.</h2>
    <p class="mar_b10 tx_red">※ 부서 이동 시 기존 권한은 삭제되오니 신규로 권한을 부여하시기 바랍니다.</p>

    <!-- 내용입력 -->
    <fieldset>
        <legend>정보수정</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="정보를 수정하실 수 있습니다.">
            <caption class="hidden">정보 수정하기</caption>
            <colgroup>
                <col width="25%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th>직원명(직위)</th>
                    <td>${dataVo.mngrNm}</td>
                </tr>
                <tr>
                    <th>현재 부서명</th>
                    <td><span id="nodePath"></span>
                        <input type="hidden" name="oldDeptCd" id="oldDeptCd" />
                    </td>
                </tr>
                <tr>
                    <th><label for="deptCode">이동부서명</label></th>
                    <td>
                        <div id="treeCombo"></div>
                        <input type="hidden" name="deptCode" id="deptCode" />
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!-- //내용입력 -->

    <p class="tx_r mar_t20">
        <a href="#"><button type="button" onclick="deptTransferAction();" class="blue">저장</button></a>
<!--         <a href="#" ><button onclick="parent.$.fn.colorbox.close();" type="button" class="blue">취소</button></a> -->
    </p>
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>