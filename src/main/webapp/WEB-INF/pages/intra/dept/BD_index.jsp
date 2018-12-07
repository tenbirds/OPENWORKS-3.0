<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="zes.openworks.common.GlobalConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>부서 관리</title>

    <op:jsTag type="spi" items="form,validate,extjs" />
    <op:jsTag type="openworks" items="tree" />

    <script type="text/javascript">
        var treePanel;

        var ROOT_VISIBLE = true;
        var ENABLE_DND = true;
        var ROOT_TREE_ID = '<%= GlobalConfig.HIGH_DEPT_CD %>';
        var ROOT_TREE_TEXT = "부서 목록";

        var IS_APPEND_LEAF = true;
        var PARENT_NODE_ID_VAR = "upperDeptCode";
        var NODE_ID_VAR = "deptCode";
        var NODE_NM_VAR = "deptNm";
        var NODE_ORDER_VAR = "deptOrdrNo";


        var TREE_JSON_URL = "INC_deptList.do";
        var VIEW_URL = "INC_deptView.do";
        var INSERT_URL = "ND_insertAction.do";
        var UPDATE_URL = "ND_updateAction.do";
        var DELETE_URL = "ND_deleteAction.do";

        var PANEL_SIZE_HEIGHT = 400;
        var PANEL_SIZE_WIDTH = 200;

        var jsBeforeInsert = function(formName) {
            return $(formName).valid();
        };
        var jsBeforeUpdate = function(formName) {
            return $(formName).valid();
        };

        var jsCreateUpdateParams = function() {

            return {
                oldDeptCd : $("#oldDeptCd").val(),
                deptCode : $("#nodeId").val(),
                deptNm : $("#nodeText").val(),
                useYn  : $("input[name=useYn]:checked").val(),
                telno : $("#telno").val(),
                fxnum : $("#fxnum").val(),
                mainDuty : $("#mainDuty").val()
            };
        };

        var jsAfterUpdate = function() {
        };

        var jsAfterDelete = function() {
        };

        //최종 클릭(선택)되었던 노드 객체
        var currentNode;
        var jsView = function(node) {

            currentNode = node;
            var params = {};
            if (typeof(ADDED_VAR) != "undefined") {
                if (ADDED_VALUE == "") return;
                params[ADDED_VAR] = ADDED_VALUE;
            }
            params[NODE_ID_VAR] = node.id;

            params[PARENT_NODE_ID_VAR] = node.parentNode ? node.parentNode.id : ROOT_TREE_ID;

            $("#treeDetailDiv").load( VIEW_URL, params, function(result) {
                if ( node.id != ROOT_TREE_ID )
                    $("#nodePath").html( jsNodePath(node.parentNode) );
                    if (node.id != ROOT_TREE_ID)    {
                        if($("#telno").val()) {

                            var t_data = $("#telno").val();
                            var tel_data = t_data.split("-");
                            document.getElementById("telNum1").value = tel_data[0];
                            document.getElementById("telNum2").value = tel_data[1];
                            document.getElementById("telNum3").value = tel_data[2];

                        } else {

                            document.getElementById("telNum1").value = "";
                            document.getElementById("telNum2").value = "";
                            document.getElementById("telNum3").value = "";

                        }

                        if($("#fxnum").val()) {

                            var f_data = $("#fxnum").val();
                            var fax_data = f_data.split("-");
                            document.getElementById("faxNum1").value = fax_data[0];
                            document.getElementById("faxNum2").value = fax_data[1];
                            document.getElementById("faxNum3").value = fax_data[2];

                        } else {

                            document.getElementById("faxNum1").value = "";
                            document.getElementById("faxNum2").value = "";
                            document.getElementById("faxNum3").value = "";

                        }
                    }
                    $('#selectNodeId').val(node.id);
            });
        };

        var jsInsertAction = function(formName) {

            checkInsert();

            if ($('input[name=isDupChecked]').val() == 'R') {
                if ($("button:contains('중복확인')").parent().find('label.error').length == 0) {
                    $("button:contains('중복확인')").parent().append('<label for="isDupChecked" class="error">중복확인을 해 주십시요.</label>');
                }
                return;
            }

            if ( typeof(INSERT_URL) == "undefined" ) {
                alert("INSERT_URL 값이 정의되지 않았습니다.");
                return;
            }

            var insertParams;
            if ( typeof(window.jsCreateUpdateParams) == "function" ) {
                insertParams = eval( jsCreateUpdateParams(treePanel) );
            } else {
                alert( "jsCreateUpdateParams() 함수를 정의하세요." );
                return;
            }

            if ( typeof(window.jsBeforeInsert) == "function" ) {
                var isValid = eval( jsBeforeInsert(formName) );
                if ( !isValid ) return;
            }

            var targetNode;
            if ( $("#isSame").attr("checked") )
                targetNode = treePanel.getNodeById( $("#selectNodeId").val() ).parentNode;
            else if ( $("#isChild").attr("checked") )
                targetNode = treePanel.getNodeById( $("#selectNodeId").val() );
            else
                targetNode = treePanel.getRootNode();


            if (typeof(ADDED_VAR) != "undefined") {
                if (ADDED_VALUE == "") return;
                insertParams[ADDED_VAR] = ADDED_VALUE;
            }
            insertParams[PARENT_NODE_ID_VAR] = targetNode.id;
            insertParams[NODE_NM_VAR] = $("#nodeText").val();
            if (typeof(TOP_NODE_VAR) != "undefined")
                insertParams[TOP_NODE_VAR] = jsGetTopNode(targetNode);


            $.post(INSERT_URL, insertParams, function(response) {

                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.insertOk);

                        var newNode = new Ext.tree.TreeNode({
                           text      : $("#nodeText").val(),
                            id        : $("#nodeId").val(),
                            draggable : ENABLE_DND ? true : false
                        });

                        targetNode.appendChild(newNode);
                        if ( $("#isChild").attr("checked") ) {
                            targetNode.leaf = false;
                        }
                        targetNode.expand();
                        newNode.select();

                        $("#oldDeptCd").val($("#nodeId").val());  // 기존 부서 코드를  변경한 부서코드로 바꿔주는 기능.

                        $("#a").text("부서정보 및 수정");
                        $("#nodePath").parent().parent().show();
                        $("#nodePath").html( jsNodePath(newNode) );
                        $("th:contains('등록')").parent().show();
                        $("th:contains('수정')").parent().show();

                        $("th:contains('등록')").parent().find('td').text(jsDateFormateStr(new Date()));
                        $("th:contains('수정')").parent().find('td').text(jsDateFormateStr(new Date()));
                        $("th:contains('레벨')").parent().hide();

                        $("#d").html('<a href="#" onclick="jsUpdateAction(\'#deptAddForm\');"><button    class="blue" id="b">수정</button></a> <a href="#" onclick="jsDeleteAction();"><button    class="blue" id="c">삭제</button></a> ');

                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }

            });
        };


        var jsUpdateAction = function(formName) {

            checkInsert();

            if ($('input[name=isDupChecked]').val() == 'R') {
                if ($("button:contains('중복확인')").parent().find('label.error').length == 0) {
                    $("button:contains('중복확인')").parent().append('<label for="isDupChecked" class="error"> 중복확인을 해 주십시요.</label>');
                }
                return;
            }

            //선처리 시작
            if ( typeof(UPDATE_URL) == "undefined" ) {
                alert("UPDATE_URL 값이 정의되지 않았습니다.");
                return;
            }

            var updateParams;
            if ( typeof(window.jsCreateUpdateParams) == "function" ) {
                updateParams = eval( jsCreateUpdateParams(treePanel) );
            } else {
                alert( "jsCreateUpdateParams() 함수를 정의하세요." );
                return;
            }

            if ( typeof(window.jsBeforeUpdate) == "function" ) {
                var isValid = eval( jsBeforeUpdate(formName) );
                if ( !isValid ) return;
            }

            var targetNode = treePanel.getNodeById( $("#oldDeptCd").val() );

            $.post(UPDATE_URL, updateParams, function(response) {

                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.updateOk);

                        targetNode.setText( $("#nodeText").val() );
                        targetNode.setId( $("#nodeId").val() );

                        $("#oldDeptCd").val($("#nodeId").val());  // 기존 부서 코드를  변경한 부서코드로 바꿔주는 기능.

                        var useYn = $("input[name=useYn]:checked").val();
                        if (useYn == 'N') targetNode.setCls("no-use");
                        else targetNode.setCls("");

                        $("#nodePath").html( jsNodePath(targetNode.parentNode) );
                        $("th:contains('수정')").parent().show();
                        $("th:contains('수정')").parent().find('td').text(jsDateFormateStr(new Date()));

                        if ( typeof(window.jsAfterUpdate) == "function" ) {
                            eval( jsAfterUpdate() );
                        };
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }
            });//받는곳끝
        };

        var jsNewForm = function () {
            var node = treePanel.getSelectionModel().getSelectedNode();
            if( node == null) {
                node = treePanel.getRootNode();
            }

            $("#treeDetailDiv").load( VIEW_URL, {}, function(result) {
                $('#selectNodeId').val(node.id);
                if( node == treePanel.getRootNode()) {
                    document.getElementById("isSame").disabled=true;
                    document.getElementById("isChild").disabled=true;
                }
                else {
                    document.getElementById("isSame").disabled=false;
                    document.getElementById("isChild").disabled=false;
                }
            });
        };

        var jsDateFormateStr = function (date) {
            var zf = function (vl) {
                return Number(vl) < 10 ? '0' + vl : '' + vl;
            };

            return '' + date.getFullYear() + '-' + zf(date.getMonth()+1) + '-' + zf(date.getDate()) + ' ' + zf(date.getHours()+1)+ ':' + zf(date.getMinutes()+1);
        };

        var deptListExcel = function() {
            parent.location.href = "INC_deptListExcel.do";
        };

        var jsView2 = function() {
            if($('#selectNodeId').val() == 0) {
                jsList();
            } else if($('#selectNodeId').val() != 0) {
                jsView1();
            }
        };

       var jsList = function() {
           var htmlStr = "";
           htmlStr += '<h4 class="tx_13 float_l">부서등록</h4>';
           htmlStr += '<div class="tx_r mar_b10">';
           htmlStr += '    <a href="#"><button class="w_blue" onclick="jsNewForm();">부서등록</button></a>';
           htmlStr += '    <a href="#"><button class="w_blue" id="excelEnBloc" onclick="jsRegisterExcelEnBloc();">엑셀일괄등록</button></a>';
           htmlStr += '    <a href="#"><button class="w_blue" onclick="deptListExcel();">엑셀출력</button></a>';
           //htmlStr += '    <a href="#"><button class="w_blue" onclick="alert(\'준비 중..\');">내부연계</button></a>';
           htmlStr += '</div>';
           htmlStr += '<p class="clear">부서를 선택하세요</p>';

            $('#treeDetailDiv').html(htmlStr);
       };


       //취소
        var jsView1 = function() {

            jsView(currentNode);

        };

        function checkInsert() {

            var frm = document.deptAddForm;
            if(frm.telNum1.value != "" && frm.telNum2.value != "" && frm.telNum3.value != "") {
                frm.telno.value = frm.telNum1.value + "-" + frm.telNum2.value + "-" + frm.telNum3.value;
            }

            if(frm.faxNum1.value != "" && frm.faxNum2.value != "" && frm.faxNum3.value != "") {
                frm.fxnum.value = frm.faxNum1.value + "-" + frm.faxNum2.value + "-" + frm.faxNum3.value;
            }
        }

        var jsRegisterExcelEnBloc = function(){
            $("#excelEnBloc").colorbox({
                title  : "엑셀일괄등록",
                href   : "PD_registerExcelEnBloc.do",
                width  : "700" ,
                height : "400" ,
                iframe : true
            });
        };

    </script>
</head>

<body>

    <div class="buser">
        <!-- 상단버튼 -->
        <!-- //상단버튼 -->
        <div id="treeDiv" class="b_list"></div>
        <!-- //부서 목록 -->

        <div  id="treeDetailDiv" class="b_write">
            <h4 class="tx_13 float_l">부서등록</h4>

            <p class="clear">부서를 선택하세요</p>
            <div class="tx_r mar_b10">
                <a href="#"><button class="w_blue" onclick="jsNewForm();">부서등록</button></a>
                <a href="#"><button class="w_blue" id="excelEnBloc" onclick="jsRegisterExcelEnBloc();">엑셀일괄등록</button></a>
                <a href="#"><button class="w_blue" onclick="deptListExcel();">엑셀출력</button></a>
                <!-- <a href="#"><button class="w_blue" onclick="alert('준비 중..');">내부연계</button></a> -->
            </div>
        </div>
    </div>

</body>
</html>
