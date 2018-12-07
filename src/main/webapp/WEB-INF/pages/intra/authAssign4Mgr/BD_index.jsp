<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>개인별 권한지정 관리</title>
<op:jsTag type="spi" items="form,validate" />

<script type="text/javascript">
<!--
    var MgrAssignConfig = {
        MGR_LIST_URL  : "ND_mgrAuthList.do",   /* 개인별 권한 목록*/
        AUTH_LIST_URL : "ND_groupAuthList.do", /* 권한 그룹 목록 */
        MENU_LIST_URL : "ND_authMenuList.do",  /* 메뉴 목록 */
        MGR_LIST_EL   : "MgrAuthList",
        AUTH_LIST_EL  : "GroupAuthList",
        MENU_LIST_EL  : "MenuList"
    };

    var menuListLoad = function (mgrId) {
        $("#" + MgrAssignConfig.MENU_LIST_EL).load(MgrAssignConfig.MENU_LIST_URL, {mgrId: mgrId}, function(result) {

        });
    };

    var authListLoad = function (mgrId) {
        var doAjax = function (nodeEls) {
            var $authCds = $("#" + MgrAssignConfig.AUTH_LIST_EL + " li.check_on > input:checked");
            $("#" + MgrAssignConfig.AUTH_LIST_EL + " .panList").html('');

            var htmlStr = '';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li>';
                htmlStr += '    <input type="checkbox" name="authCdCheck" value="'+nodeEls[i].authCd+'"';
                if (nodeEls[i].mgrAssigned == 'Y') {
                    htmlStr += ' checked="checked" disabled="disabled"';
                }
                htmlStr += '>';
                htmlStr += '    <span class="tx_b">'+nodeEls[i].authNm+'</span>';
                htmlStr += '    <span class="tx_blue_l cs_pointer">[보기]</span>';
                htmlStr += '</li>';
            }
            $(htmlStr).appendTo("#" + MgrAssignConfig.AUTH_LIST_EL + " .panList");
            $authCds.each(function () {
                $("#" + MgrAssignConfig.AUTH_LIST_EL + " input[value='"+$(this).val()+"']").attr('checked', true);
            });
            var elLength = nodeEls.length ? nodeEls.length : 0;
            $("#" + MgrAssignConfig.AUTH_LIST_EL).next('p').html('권한수 : <span class="tx_b">'+elLength+'개</span>');


            // 이벤트 생성
            $("#" + MgrAssignConfig.AUTH_LIST_EL + " > ul > li").hover(
                function () {
                    if (!$(this).hasClass('check_on')) {
                        $(this).addClass('check_click');
                    }
                },
                function () {
                    $(this).removeClass('check_click');
                }
            );

            $("#" + MgrAssignConfig.AUTH_LIST_EL).find('input[name="authCdCheck"]').click(function () {
                jsAddAuthMgrAssignTbl($(this).get(0));

            });

            $("#" + MgrAssignConfig.AUTH_LIST_EL + " > ul > li").find('span.tx_blue_l').hover(
                function () {
                    $(this).addClass('tx_b');
                },
                function () {
                    $(this).removeClass('tx_b');
                }
            );
            $("#" + MgrAssignConfig.AUTH_LIST_EL + " > ul > li").find('span.tx_blue_l').click(function () {
                $(this).colorbox({
                     title : "지정권한 목록"
                    ,href  : "<c:url value='/intra/authComm/PD_authMenuList.do'/>?authCd=" + $(this).parent().find('input[name="authCdCheck"]').val()
                    ,width : "550", height : "600"
                    ,iframe: true
                });
            });
        };

        $.ajax({
            type:        "POST",
            url:         MgrAssignConfig.AUTH_LIST_URL,
            data:        {mgrId: mgrId},
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       true,
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });
    };


    var jsMakeAuthSpanHtml = function (authCd, authText) {
        var spanHtml = '';
        spanHtml += '<span ';
        spanHtml += '      authCd="' + authCd + '"';
        spanHtml += '>';
        spanHtml += authText;
        spanHtml += '</span>';

        return spanHtml;
    };


    var jsAddAuthMgrAssignTbl = function (el) {
        var authText = $(el).parent().find('.tx_b').text();
        var authCd   = $(el).val();

        var $baseTableTr = $('#selectedAuthList > tbody > tr');
        var $baseSpan = $baseTableTr.find('span[authCd="'+authCd+'"]');

        if ($(el).is(':checked')) {
            if ($baseTableTr.find('td').eq(0).text().indexOf('담당자를 선택하십시요.') > -1) {
                $baseTableTr.parent().html('<tr><td></td><td class="lr_none"></td></tr>');
                $baseTableTr = $('#selectedAuthList > tbody > tr');
            }

            var spanHtml = jsMakeAuthSpanHtml(authCd, authText);

            var notAddedSpanHtml = true;
            $baseTableTr.each(function () {
                if (notAddedSpanHtml && $(this).find('td:eq(0) span').length == 0) {
                    $(this).find('td:eq(0)').html(spanHtml);
                    notAddedSpanHtml = false;
                }
            });

            if (notAddedSpanHtml) {
                $baseTableTr.parent().append('<tr><td>'+spanHtml+'</td><td class="lr_none"></td></tr>');
            }

        } else {
            if ($baseSpan.length > 0) {
                $baseSpan.remove();
                jsReFreshSelectedAuthTable();
            }
        }
    };

    var jsReFreshSelectedAuthTable = function () {
        var authCdList = [];
        var menuCdList = [];
        var $baseTableTr = $('#selectedAuthList > tbody > tr');


        var authIndex = 0;
        var menuIndex = 0;
        $baseTableTr.each(function () {
            if ($(this).find('td:eq(0) span').length > 0) {
                authCdList[authIndex++] = $(this).find('td:eq(0)').html();
            }
            if ($(this).find('td:eq(1) span').length > 0) {
                menuCdList[menuIndex++] = $(this).find('td:eq(1)').html();
            }
        });

        $baseTableTr.each(function (index) {
            $(this).find('td:eq(0)').html(authCdList[index]);
            if (authCdList[index] == null) {
                $(this).find('td:eq(0)').html('');
            }
            $(this).find('td:eq(1)').html(menuCdList[index]);
            if (menuCdList[index] == null) {
                $(this).find('td:eq(1)').html('');
            }
        });

        // 빈ROW 지우기
        var maxIndex = Math.max(authIndex,menuIndex);
        for (var i = maxIndex; i > 0 && i < $baseTableTr.length; i++) {
            $baseTableTr.eq(i).remove();
        }
    };


    var jsMakeMgrListClick = function () {
        $("#" + MgrAssignConfig.MGR_LIST_EL + " > ul > li").hover(
            function () {
                if (!$(this).hasClass('check_on')) {
                    $(this).addClass('check_click');
                }
            },
            function () {
                $(this).removeClass('check_click');
            }
        );

        $("#" + MgrAssignConfig.MGR_LIST_EL + " > ul > li").find('span.tx_blue_l').hover(
            function () {
                $(this).addClass('tx_b');
            },
            function () {
                $(this).removeClass('tx_b');
            }
        );
        $("#" + MgrAssignConfig.MGR_LIST_EL + " > ul > li").find('span.tx_blue_l').click(function () {
            if ($(this).parent().hasClass('check_on')) {
                return;
            }
            $(this).parent().parent().find('li').removeClass('check_on');
            $(this).parent().addClass('check_on');
            authListLoad($(this).parent().find('span.tx_b').attr('mgrId'));
            menuListLoad($(this).parent().find('span.tx_b').attr('mgrId'));

            $('#selectedAuthList > tbody').html('<tr><td></td><td class="lr_none"></td></tr>');
        });
    };

    var mgrListLoad = function () {
        var doAjax = function (nodeEls) {
            var $mgrId = $("#" + MgrAssignConfig.MGR_LIST_EL + " li.check_on > span:first").attr('mgrId');
            $("#" + MgrAssignConfig.MGR_LIST_EL + " .panList").html('');

            var htmlStr = '';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li>';
                htmlStr += '    <span class="tx_b" mgrId="'+nodeEls[i].mgrId+'">'+nodeEls[i].mgrNm+'</span>';
                htmlStr += '    <span class="tx_blue_l cs_pointer">[보기]</span>';
                htmlStr += '</li>';
            }
            $(htmlStr).appendTo("#" + MgrAssignConfig.MGR_LIST_EL + " .panList");
            $("#" + MgrAssignConfig.MGR_LIST_EL + ' span[mgrId="'+$mgrId+'"]').parent().addClass('check_on');
            var elLength = nodeEls.length ? nodeEls.length : 0;
            $("#" + MgrAssignConfig.MGR_LIST_EL).next('p').html('개인별 권한수 : <span class="tx_b">'+elLength+'개</span>');

            // 이벤트 생성
            jsMakeMgrListClick();

        };

        $.ajax({
            type:        "POST",
            url:         MgrAssignConfig.MGR_LIST_URL,
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       true,
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });
    };

    var jsAssign4MgrSaveAction = function () {
        if($("#selectedAuthList").find("span[authcd]").length == 0 && $("#selectedAuthList").find("span[menucd]").length == 0){
            jsWarningBox("저장할 지정권한 목록이 없습니다.");
            return;
        }
        var mgrId = $('#MgrAuthList > ul > li.check_on').find('span.tx_b').attr('mgrId');
        var authCds = '';
        var menuCds = '';
        var assignTypeCds = '';

        $('#selectedAuthList span[authCd]').each(function () {
            authCds += ',' + $(this).attr('authCd');
        });
        $('#selectedAuthList span[menuCd]').each(function () {
            menuCds       += ',' + $(this).attr('menuCd');
            assignTypeCds += ',' + $(this).attr('assignTypeCd');
        });


        $.ajax({
            url      : "ND_assign4MgrSaveAction.do",
            type     : "POST",
            data     : {mgrId         : mgrId,
                        authCds       : authCds.substring(1),
                        menuCds       : menuCds.substring(1),
                        assignTypeCds : assignTypeCds.substring(1)},
            async    : false,
            success  : function (response) {
                jsSuccessBox(response)
                document.location.reload();
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
    };

    var jsAssign4MgrCancleAction = function () {

    };

    $().ready(function () {
        mgrListLoad();
        //authListLoad(config, '');
        //menuListLoad(config, '');

        $('button:contains("신규등록")').click(function () {
            $(this).colorbox({
                title : '개인별 권한지정 등록'
               ,href  : 'PD_mgrAddFrom.do?q_rowPerPage=5'
               ,width : '600', height : '460'
               ,iframe: true
            });
        });

        $(".b_list > div.tree_tit > img").click(function () {
            mgrListLoad();
        });

        $(".b_list_w > div.tree_tit > img").click(function () {
            authListLoad();
        });
    });
//-->
</script>
</head>

<body>

    <div class="buser h_400">
        <!-- 개인별권한목록 -->
        <div class="b_list">
        <div>
            <h4 class="float_l">개인별 권한</h4>
            <span class="tx_r float_r" style="right: 0;">
                <a href="#"><button type="button" class="w_blue">신규등록</button></a>
            </span>
        </div>
            <div class="tree_tit clear">개인별 권한 목록
                <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침"
                     style="cursor: pointer;" />
            </div>
            <div class="panel" id="MgrAuthList" style="height:290px;"><ul class="panList"></ul></div>
            <p  class="tree_num">개인별 권한수 : <span class="tx_b">0개</span></p>

            <p class="tx_c"><img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_under.gif" />" class="mar_t20" alt=""/></p>
        </div>
        <!-- //개인별권한목록 -->

        <!-- 권한그룹별 지정권한 -->
        <div class="b_list2">
            <h4>권한그룹별 지정권한</h4>
            <div class="b_list_w float_l" >
                <div class="tree_tit">권한목록
                    <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침"
                         style="cursor: pointer;" />
                </div>
                <div class="panel" id="GroupAuthList" style="height:290px;"><ul class="panList"></ul></div>
                <p  class="tree_num">권한수 : <span class="tx_b">0개</span></p>
            </div>
        </div>
        <!-- //권한그룹별 지정권한 -->
        <p class="arrow_step2"><img src="<c:url value="/resources/openworks/theme/default/images/icon/plus.gif" />" class="mar_t20" alt=""/></p>

        <!-- 담당자목록 -->
        <div class="b_write2" id="MenuList" style="height:390px;">
            <h4 class="tx_13">개인별 권한 상세정보</h4>
            <p>개인별 권한 목록을 선택하세요</p>
        </div>
        <!-- //담당자목록 -->
    </div>


    <div class="buser">
        <h4 class="tx_13">지정권한 목록</h4>
        <!-- 리스트 -->
        <table id="selectedAuthList" class="boardList" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="50%" />
                <col width="50%" />
            </colgroup>
            <thead>
                <tr>
                    <th>권한그룹별 지정권한</th>
                    <th class="lr_none">메뉴별 지정권한</th>
                </tr>
            </thead>
            <tbody>
                <tr><td colspan="2" class="lr_none">담당자를 선택하십시요.</td></tr>
            </tbody>
        </table>
        <!-- //리스트 -->
    </div>

</body>
</html>
