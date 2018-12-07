<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>권한 관리</title>
<op:jsTag type="spi" items="form, validate" />

<script type="text/javascript">
    var BoxListConfig = {
        LIST_URL   : "ND_groupAuthList.do",
        DETAIL_URL : "ND_authMenuList.do", /* 메뉴 관한 설정 */
        FORM_URL   : "ND_authForm.do",     /* 권한그룹 수정 */
        LIST_EL    : "BoxList",
        DETAIL_EL  : "BoxDetail"
    };

    var jsDetailView = function (loadElId, loadUrl, params) {
        $("#" + loadElId).load(loadUrl, params, function(result) {

        });
    };

    var boxListLoad = function (config) {
        var doAjax = function (nodeEls) {
            var $authCd = $("#" + config.LIST_EL + " li.check_on > span:first").attr('authCode');
            $("#" + config.LIST_EL + " .panList").html('');

            var htmlStr = '';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li>';
                htmlStr += '    <span class="tx_b cs_pointer" authCode="' + nodeEls[i].authCode + '">' + nodeEls[i].authNm + '</span>';
                htmlStr += '    <span class="tx_orange cs_pointer">(' + nodeEls[i].authPCnt + '명)</span>';
                htmlStr += '    <span class="tx_blue_l cs_pointer">[메뉴]</span>';
                htmlStr += '</li>';
            }
            $(htmlStr).appendTo("#" + config.LIST_EL + " .panList");
            $('span[authCode="'+$authCd+'"]').parent().addClass('check_on');
            var elLength = nodeEls.length ? nodeEls.length : 0;
            $("#" + config.LIST_EL).next('p').html('권한수 : <span class="tx_b">'+elLength+'개</span>');


            // 이벤트 생성
            $("#" + config.LIST_EL + " > ul > li").hover(
                   function () {
                    if (!$(this).hasClass('check_on')) {
                        $(this).addClass('check_click');
                    }
                },
                function () {
                    $(this).removeClass('check_click');
                }
            );
            $("#" + config.LIST_EL + " > ul > li").find('span.tx_b').click(function () {
                $(this).parent().parent().find('li').removeClass('check_on');
                $(this).parent().addClass('check_on');
                jsDetailView(config.DETAIL_EL, config.FORM_URL, {authCode: $(this).attr('authCode')});
            });

            $("#" + config.LIST_EL + " > ul > li").find('span.tx_blue_l').hover(
                function () {
                 $(this).addClass('tx_b');
                },
                function () {
                    $(this).removeClass('tx_b');
                }
            );
            $("#" + config.LIST_EL + " > ul > li").find('span.tx_blue_l').click(function () {
                $(this).parent().parent().find('li').removeClass('check_on');
                $(this).parent().addClass('check_on');
                jsDetailView(config.DETAIL_EL, config.DETAIL_URL, {authCode: $(this).parent().find("span:first").attr('authCode')});
            });

            $("#" + config.LIST_EL + " > ul > li").find('span.tx_orange').hover(
                function () {
                    $(this).addClass('tx_b');
                },
                function () {
                    $(this).removeClass('tx_b');
                }
            );
            $("#" + config.LIST_EL + " > ul > li").find('span.tx_orange').click(function () {
                $(this).colorbox({
                     title : "담당자 목록"
                    ,href  : "PD_mgrList.do?q_rowPerPage=5&authCode=" + $(this).parent().find("span:first").attr('authCode')
                    ,width : "800" ,height:"550"
                    ,iframe: true
                });
            });
        };


        $.ajax({
            type:        "POST",
            url:         config.LIST_URL,
            data:        {aa: '', bb: ''},
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       false,
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });
    };

    $().ready(function () {
        boxListLoad(BoxListConfig);
        $("button:contains('권한등록')").bind("click", BoxListConfig, function (e) {
            jsDetailView(e.data.DETAIL_EL, e.data.FORM_URL, {});
        });
        $("div.tree_tit > img").bind("click", BoxListConfig, function (e) {
            boxListLoad(e.data);
        });
    });
</script>
</head>

<body>
    <div class="buser">
        <!-- 권한그룹 목록 -->
        <div class="b_list">
            <div class="tree_tit">권한그룹 목록
                <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침" style="cursor: pointer;" />
            </div>
            <div class="panel" id="BoxList" style="height:350px;"><ul class="panList"></ul></div>
            <p class="tree_num"></p>
            <p class="mar_t10 tx_r"><a href="#"><button class="blue">권한등록</button></a></p>
        </div>
        <!-- //권한그룹 목록 -->

        <div id="BoxDetail" class="b_write">
            <h4 class="tx_13">관리자권한</h4>
            <p>권한그룹을 선택하세요</p>
        </div>
    </div>

</body>
</html>
