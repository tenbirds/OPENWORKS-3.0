<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>권한 지정 관리</title>
<op:jsTag type="spi" items="form,validate,extjs" />
<op:jsTag type="openworks" items="tree" />

<script type="text/javascript">
<!--
    var AssignConfig = {
        AUTH_LIST_URL : "ND_groupAuthList.do", /* 권한 목록*/
        DEPT_LIST_URL : "ND_deptList.do", /* 부서 목록 */
        MRG_LIST_URL  : "ND_mgrList.do",  /* 담당자 목록 ?q_rowPerPage=5 */
        AUTH_LIST_EL  : "AuthList",
        DEPT_LIST_EL  : "DeptList",
        MRG_LIST_EL   : "MrgList"
    };

    var authListLoad = function (config) {
        var doAjax = function (nodeEls) {

            var $authCds = $("#" + config.AUTH_LIST_EL + " li.check_on > input:checked");
            $("#" + config.AUTH_LIST_EL + " .panList").html('');

            var htmlStr = '';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li>';
                htmlStr += '    <input type="checkbox" name="authCdCheck" value="'+nodeEls[i].authCd+'">';
                htmlStr += '    <span class="tx_b">'+nodeEls[i].authNm+'</span>';
                htmlStr += '    <span class="tx_blue_l cs_pointer">[메뉴]</span>';
                htmlStr += '</li>';
            }
            $(htmlStr).appendTo("#" + config.AUTH_LIST_EL + " .panList");
            $authCds.each(function () {
                $("#" + config.AUTH_LIST_EL + " input[value='"+$(this).val()+"']").attr('checked', true);
            });
            var elLength = nodeEls.length ? nodeEls.length : 0;
            $("#" + config.AUTH_LIST_EL).next('p').html('권한수 : <span class="tx_b">'+elLength+'개</span>');


            // 이벤트 생성
            $("#" + config.AUTH_LIST_EL + " > ul > li").hover(
                function () {
                    if (!$(this).hasClass('check_on')) {
                        $(this).addClass('check_click');
                    }
                },
                function () {
                    $(this).removeClass('check_click');
                }
            );
            $("#" + config.AUTH_LIST_EL).find('input[name="authCdCheck"]').click(function () {
                var authText = $(this).parent().find('.tx_b').text();
                var authCd   = $(this).val();

                if ($(this).is(':checked')) {
                    $(this).parent().addClass('check_on');

                    var liHtml   = '<span class="tx_b">' + authText + '</span>';

                    $('#selectedAuthList').append('<li authCd="'+authCd+'">' + liHtml + '</li>');
                } else {
                    $(this).parent().removeClass('check_on');
                    $('#selectedAuthList').find('li[authCd="'+authCd+'"]').remove();
                }
                $('#selectedAuthList').parent().parent().find('.tx_yellow').text($('#selectedAuthList li').length);

            });

            $("#" + config.AUTH_LIST_EL + " > ul > li").find('span.tx_blue_l').hover(
                function () {
                    $(this).addClass('tx_b');
                },
                function () {
                    $(this).removeClass('tx_b');
                }
            );
            $("#" + config.AUTH_LIST_EL + " > ul > li").find('span.tx_blue_l').click(function () {
                $(this).colorbox({
                     title : "지정 권한 목록"
                    ,href  : "<c:url value='/intra/authComm/PD_authMenuList.do'/>?authCd=" + $(this).parent().find('input[name="authCdCheck"]').val()
                    ,width : "550", height : "600"
                    ,iframe: true
                });
            });
        };

        $.ajax({
            type:        "POST",
            url:         config.AUTH_LIST_URL,
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       false,
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });
    };

    var jsAddMgr2AssignTable = function (json) {
        var html = "";

        for (var i = 0; i < json.length; i++) {
            var data = json[i];

            if ($('input[value="' + data.mgrId + '"]').length !== 0) {
                continue;
            }

            html +='<tr id="tr_'+data.mgrId+'">';
            html +='    <td><input type="checkbox" name="mgrId" value="' + data.mgrId + '" checked="checked" /></td>';
            html +="    <td>" + data.mgrId + "</td>";
            html +="    <td>" + data.deptNm + "</td>";
            html +="    <td>" + data.gradeNm + "</td>";
            html +="    <td>" + data.mgrNm + "</td>";
            if (data.authListString == null || data.authListString == '') {
                html +="    <td class='lr_none'>지정된 권한 없음</td>";
            } else {
                html +="    <td class='lr_none'>[" + data.authListString + "]</td>";
            }
            html += "</tr>";
        }

        $('#selectedMgrList > tbody').append(html);
        $('#selectedMgrListTr').remove();

        $('h4.tx_13').find('.tx_red_b').text($('#selectedMgrList > tbody tr').length);
    };

    var jsChangeCheckbox = function() {
        if($("#checkAll").is(":checked")){
            $("input[name=searchCheckMgr]").attr("checked", true);
            $("input[name=searchCheckMgr]").parent().parent().addClass("bg_blue");
        }else{
            $("input[name=searchCheckMgr]").attr("checked", false);
            $("input[name=searchCheckMgr]").parent().parent().removeClass("bg_blue");
        }
    };

    $().ready(function () {
        authListLoad(AssignConfig);

        $("div.tree_tit > img").bind("click", AssignConfig, function (e) {
            authListLoad(e.data);
        });

        $('button:contains("권한별")').click(function () {
            $(this).colorbox({
                title : '권한별 담당자 검색',
                href  : 'PD_searchAssignList.do?q_rowPerPage=5',
                width : '700', height : '480',
                iframe: true
           });
        });
    });
//-->
</script>

<!-- ExtJS Tree Setting -->
<script type="text/javascript">
<!--
    var ROOT_VISIBLE   = true;
    var ENABLE_DND     = false;
    var ROOT_TREE_ID   = '<%=zes.openworks.common.GlobalConfig.HIGH_DEPT_CD%>';
    var ROOT_TREE_TEXT = "부서 목록";

    var IS_APPEND_LEAF     = false;
    var PARENT_NODE_ID_VAR = "highDeptCd";
    var NODE_ID_VAR        = "deptCd";
    var NODE_NM_VAR        = "deptNm";
    var NODE_ORDER_VAR     = "orderNo";

    var TREE_JSON_URL = AssignConfig.DEPT_LIST_URL;
    var VIEW_URL      = AssignConfig.MRG_LIST_URL;
//-->
</script>
</head>

<body>

    <div class="buser">
        <p class="mar_t10 tx_r">
            <a href="#"><button type="button" class="blue">권한별 담당자 검색</button></a>
        </p>

        <!-- 권한목록 -->
        <div class="b_list">
            <div class="tree_tit">권한목록
                <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침" style="cursor: pointer;" />
            </div>
            <div class="panel" id="AuthList" style="height:370px;"><ul class="panList"></ul></div>
            <p  class="tree_num">권한수 : <span class="tx_b">0개</span></p>
<%--             <p class="tx_c"><img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_under.gif" />" class="mar_t20" alt=""/></p> --%>
        </div>
        <!-- //권한목록 -->
<%--         <p class="arrow_step"><img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow.gif" />" class="mar_t20" alt=""/></p> --%>

        <!-- 부서목록 -->
        <div id="treeDiv" class="b_list2"></div>

        <!-- 담당자목록 -->
        <div id="treeDetailDiv" class="b_write2" style="height:500px;">
            <h4 class="tx_13">담당자 목록</h4>
            <p>부서를 선택하세요</p>
        </div>
        <!-- //담당자목록 -->
    </div>


    <div class="buser" id="assignMgrHidden" style="display: none;">
        <!-- 지정권한목록 -->
        <div class="b_list">
            <div class="tree_tit">지정 권한 목록(<span class="tx_yellow">0</span> 개)</div>
            <div class="panel" style="height:300px;"><ul id="selectedAuthList" class="panList"></ul></div>
        </div>
        <!-- //지정권한목록-->

        <div class="b_write">
            <h4 class="tx_13">지정 권한 담당자 목록 (<span class="tx_red_b">0</span> 명)</h4>

            <form id="assignMgrForm">
            <input type="hidden" name="authCds" />

            <table class="boardList" id="selectedMgrList" summary="리스트입니다.">
                <caption class="hidden">목록</caption>
                <colgroup>
                    <col width="10%"/>
                    <col width="15%"/>
                    <col width="15%"/>
                    <col width="15%"/>
                    <col width="15%"/>
                    <col width="*"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>선택 <input type="checkbox" name="checkAll" id="checkAll" onclick="jsChangeCheckbox();" checked="checked" /></th>
                        <th>ID</th>
                        <th>부서명</th>
                        <th>직위</th>
                        <th>담당자명</th>
                        <th class="lr_none">현재지정권한</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <tr id="selectedMgrListTr"><td colspan="6" class="lr_none">담당자를 선택하십시요.</td></tr>
                </tbody>
            </table>
            </form>

            <p class="mar_t10 mar_b20 tx_r" id="btn">
<!--                 <button type="button" class="blue" onclick="jsAssignMgrSaveAction();">저장</button>  -->
<!--                 <button type="button" class="blue" onclick="parent.$.fn.colorbox.close();">담당자 추가</button>  -->
<!--                 <button type="button" class="blue" onclick="jsDeleteMngToList();">선택한 담당자 제거</button> -->
            </p>
        </div>
    </div>

</body>
</html>
