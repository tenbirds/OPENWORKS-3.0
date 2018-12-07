<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한 추가 요청(신청자)</title>
    <script type="text/javascript">

    var jsIndex = function(){
        self.location.href = "BD_index.do";
    };

    var jsViewPop = function (el, vl) {

        $(el).colorbox({
               title : "지정 권한 메뉴",
               href  : "PD_assignment.do?authCd="+vl ,
               width : "600",
               height: "550",
               iframe: true
              });
    };

    $().ready(function () {
        var cnt = 0;
        $("input[name=menuCheck]:checked").each(function(){
            cnt += 1;
        });
        $("#assignCnt").text(cnt);
        var menuCount2= 0;
        // 이벤트 생성
        $("#authGroupList").find('input[name="authCdCheck"]').click(function () {
            jsAddAuthMgrAssignTbl($(this).get(0));
        });
    });


    // 사용 권한 체크 셀렉트 박스 토글
    var jsViewAuthType = function (el) {
        var $imgEl = $(el).find('img');
        var isClosed = $(el).find('img').attr('src').indexOf('btn_layer_open') > 0 ? true : false;
        if (isClosed) {
            $imgEl.attr('src', ($imgEl.attr('src')).replace('btn_layer_open', 'btn_layer_close'));
        } else {
            $imgEl.attr('src', ($imgEl.attr('src')).replace('btn_layer_close', 'btn_layer_open'));
        }

        $('div.select_layer').css('z-index','1');
        $(el).parents('div.po_rel').find('div.select_layer').css('z-index','99').toggle();
    };


    //사용 권한 체크 셀렉트 박스 설정
    var jsAuthTypeStrAdd = function(el){
        var isChecked = $(el).is(':checked');
        var $span = $(el).parents('div.po_rel').find('p > span');
        var val = $(el).val();

        var writeAuthTypeStr = function(val){
            var returnVal = '';
            switch(val){
                case 'R' : {returnVal = '조회 '; break;}
                case 'A' : {returnVal = '기본 '; break;}
                case 'G' : {returnVal = '총괄 '; break;}
            }
            return returnVal;
        };

        if(isChecked){
            $span.text(writeAuthTypeStr(val) + '권한');
        }else{
            if($(el).parent().parent().find('input:checked').length == 0){
                $span.text('선택하세요.');
            }else{
                $span.text(writeAuthTypeStr(val) + '권한');
            }
        }
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
            if ($baseTableTr.find('td').eq(0).text().indexOf('권한을 선택하세요.') > -1) {
                $baseTableTr.parent().html('<tr><td></td><td></td></tr>');
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
                $baseTableTr.parent().append('<tr><td>'+spanHtml+'</td><td></td></tr>');
            }

        } else {
            if ($baseSpan.length > 0) {
                $baseSpan.remove();
                jsReFreshSelectedAuthTable();
            }
        }
    };

    var jsAddMenuTbl = function (el) {
        var authText = $(el).parent().find('.tx_b').text();
        var authCd   = $(el).val();

        var $baseTableTr = $('#selectedAuthList > tbody > tr');
        var $baseSpan = $baseTableTr.find('span[authCd="'+authCd+'"]');

        if ($(el).is(':checked')) {
            if ($baseTableTr.find('td').eq(0).text().indexOf('권한을 선택하세요.') > -1) {
                $baseTableTr.parent().html('<tr><td></td><td></td></tr>');
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
                $baseTableTr.parent().append('<tr><td>'+spanHtml+'</td><td></td></tr>');
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
        for (var i = maxIndex; i < $baseTableTr.length; i++) {
            if(maxIndex == 0){
            $baseTableTr.eq(i).html('<td colspan="2">권한을 선택하세요.</td>');
            }else{
            $baseTableTr.eq(i).remove();
            }
        }
    };


    var jsAddMenuMgrAssignTbl = function (el) {

        var assignTypeCd = $(el).val();
        var menuCd = $(el).parents('tr:first').find('input[name=menuCheck]').val();

        // 선택한 이외의 권한을 제거
        $(el).parent().parent().find('input:checkbox').each(function(){
            var val = $(this).val();
            if(assignTypeCd != val){
                $(this).attr('checked', false);
            }
        });

        var $baseTableTr = $('#selectedAuthList > tbody > tr');
        var $baseSpan = $baseTableTr.find('span[menuCd="'+menuCd+'"]');

        if ($(el).is(':checked')) {
            if ($baseSpan.length > 0) {
                var addedAssingTypeCd = assignTypeCd;
                $baseSpan.parent().html(jsMakeMenuSpanHtml(el, menuCd, addedAssingTypeCd));
            } else {

                if ($baseTableTr.find('td').eq(0).text().indexOf('권한을 선택하세요.') > -1) {
                    $baseTableTr.parent().html('<tr><td></td><td></td></tr>');
                    $baseTableTr = $('#selectedAuthList > tbody > tr');
                }

                var spanHtml = jsMakeMenuSpanHtml(el, menuCd, assignTypeCd);

                var notAddedSpanHtml = true;
                $baseTableTr.each(function () {
                    if (notAddedSpanHtml && $(this).find('td:eq(1) span').length == 0) {
                        $(this).find('td:eq(1)').html(spanHtml);
                        notAddedSpanHtml = false;
                    }
                });

                if (notAddedSpanHtml) {
                    $baseTableTr.parent().append('<tr><td></td><td>'+spanHtml+'</td></tr>');
                }
            }

        } else {
            if ($baseSpan.length > 0) {
                if ($baseSpan.attr('assignTypeCd').indexOf(assignTypeCd) > -1) {
                    var deletedAssingTypeCd = $baseSpan.attr('assignTypeCd').replace(assignTypeCd,'');
                    if (deletedAssingTypeCd == '') {
                        $baseSpan.remove();
                        jsReFreshSelectedAuthTable();
                    } else {
                        $baseSpan.parent().html(jsMakeMenuSpanHtml(el, menuCd, deletedAssingTypeCd));
                    }
                }
            }
        }

        $('div.select_layer').css('z-index','1');
        $(el).parent().parent().parent().parent().find('div.select_layer').css('z-index','99').toggle();
    };

    var jsMakeMenuSpanHtml = function (el, menuCd, assignTypeCd) {
        var spanHtml = '';
        spanHtml += '<span ';
        spanHtml += '      menuCd="' + menuCd + '"';
        spanHtml += '      assignTypeCd="' + assignTypeCd + '"';
        spanHtml += '>';
        spanHtml += jsMakeMenuStr(el, menuCd);
        spanHtml += ' [ '+ jsMakeAuthStr(assignTypeCd) + ' ]';
        spanHtml += '</span>';

        return spanHtml;
    };

    var jsMakeAuthStr = function (assignTypeCd) {
        var authStr = '';
        if (assignTypeCd.indexOf('R') > -1) {
            authStr = '조회 ';
        }
        if (assignTypeCd.indexOf('A') > -1) {
            authStr = '기본 ';
        }
        if (assignTypeCd.indexOf('G') > -1) {
            authStr = '총괄 ';
        }
        return authStr + '권한';

    };

    var jsMakeMenuStr = function (el, menuCd) {
        var menuStr = $('#menuList').find('#menu'+menuCd).find('.menuName').text();
        return menuStr;

    };

    var jsInsertAction = function(){
        var authCds = '';
        var menuCds = '';
        var assignTypeCds = '';
        if($('#reqconts').val() == '' || $('#reqconts').val() == null){
            jsWarningBox("신청사유를 작성해주세요");
            $('#reqconts').focus();
            return;
        }

        $('#selectedAuthList span[authCd]').each(function () {
            authCds += ',' + $(this).attr('authCd');
        });
        $('#selectedAuthList span[menuCd]').each(function () {
            menuCds       += ',' + $(this).attr('menuCd');
            assignTypeCds += ',' + $(this).attr('assignTypeCd');
        });
        if(authCds == "" && (menuCds == "" && assignTypeCds == "")){
            jsWarningBox("지정할 권한을 선택해주세요");
            return;
        }

        $.ajax({
            url      : "ND_insertAction.do",
            type     : "POST",
            data     : {authCds       : authCds.substring(1),
                        menuCds       : menuCds.substring(1),
                        assignTypeCds : assignTypeCds.substring(1),
                        reqconts	  : $('#reqconts').val()
            },
            async    : false,
            success  : function (response) {
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.insertOk);
                        jsIndex();
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }
            }
        });

    };

    </script>

</head>

<body>
    <!-- //타이틀 및 상단아이콘 -->
    <form id="form" name="form">
    </form>

    <div class="buser" style="height:490px;">
        <!-- 현재 내 지정 권한 목록목록 -->
        <div class="b_list">
            <h4>현재 내 지정 권한 목록</h4>
            <div class="b_list_w float_l">
                <div class="tree_tit">
                    권한목록
                    <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침"/>
                </div>
                <div class="panel" style="overflow: auto; height:330px;">
                    <ul class="panList">
                    <c:forEach items="${dataList}" var="_bean" varStatus="status">
                        <li>
                            <span id="tbListText_${status.count }" <c:if test="${_bean.authTypeCd eq 'G'}">class="tx_b"</c:if><c:if test="${_bean.authTypeCd eq 'P'}">class="tx_red rl"</c:if>>${_bean.authNm }</span>
                            <a href="#" title="권한상세목록" onclick="jsViewPop(this,'${_bean.authCd }'); return false;"><span id="tbListView_${status.count }" class="tx_blue_l">[메뉴]</span></a>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
                <p  class="tree_num">지정된 권한수 : <span class="tx_b">${fn:length(dataList)}</span></p>
            </div>
        </div>
        <!-- //현재 내 지정 권한 목록목록  -->

        <!-- 권한그룹별 지정권한 -->
        <div class="b_list2">
            <h4>권한그룹별 지정권한</h4>
            <div class="b_list_w float_l">
                <div class="tree_tit">
                    권한목록
                    <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침"/>
                </div>
                <div class="panel" id="authGroupList" style="overflow: auto; height:330px;">
                    <ul class="panList">
                    <c:forEach items="${dataVo}" var="_bean" varStatus="status">
                        <li>
                            <input type="checkbox" name="authCdCheck" value="${_bean.authCd }" <c:if test="${_bean.checkYn eq 'Y'}">checked="checked" disabled="disabled"</c:if>/>
                            <span id="tbListText_${status.count}" class="tx_b">${_bean.authNm }</span>
                            <a href="#" title="권한상세목록" onclick="jsViewPop(this,'${_bean.authCd }'); return false;"><span id="tbListView_${status.count}" class="tx_blue_l">[메뉴]</span></a>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
                <p  class="tree_num">권한수 : <span class="tx_b">${fn:length(dataVo)} </span></p>
            </div>
        </div>
        <!-- //권한그룹별 지정권한 -->

        <!-- 메뉴별 지정권한 -->
        <div class="b_write2">
        <form id="assignMenuDataForm">
            <h4>메뉴별 지정권한</h4>

            <p class="tx_b tx_r mar_b20">메뉴목록 (전체 ${fn:length(baseVo)}개 / 지정 <span id="assignCnt" class="tx_red_b"></span>개)</p>
            <div style="overflow:auto;height:400px;">
                <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
                    <caption class="hidden"> 목록 </caption>
                    <colgroup>
                        <col width="8%" />
                        <col width="25%" />
                        <col width="25%" />
                        <col width="25%" />
                        <col width="" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">선택</th>
                            <th rowspan="1" colspan="3">메뉴명</th>
                            <th rowspan="2" class="lr_none">사용권한</th>
                        </tr>
                        <tr>
                            <th colspan="1">1DEPTH</th>
                            <th colspan="1">2DEPTH</th>
                            <th colspan="1">3DEPTH</th>
                        </tr>
                    </thead>
                    <tbody id="menuList">
                    <c:forEach items="${baseVo}" var="_bean" varStatus="status">
                        <tr id="menu${_bean.menuCd }">
                            <td><input type="checkbox" value="${_bean.menuCd }" name="menuCheck" <c:if test="${_bean.mgrAssign eq 'Y' }">checked="checked" disabled="disabled"</c:if>/></td>
                            <c:if test="${_bean.menuLevel eq 1}"><td colspan="1" class="menuName">${_bean.menuNm }</td><td colspan="1"></td><td colspan="1"></td></c:if>
                            <c:if test="${_bean.menuLevel eq 2}"><td colspan="1"></td><td colspan="1" class="menuName">${_bean.menuNm }</td><td colspan="1"></td></c:if>
                            <c:if test="${_bean.menuLevel eq 3}"><td colspan="1"></td><td colspan="1"></td><td colspan="1" class="menuName">${_bean.menuNm }</td></c:if>

                            <td class="lr_none">
                                <input type="text" name="authTypeCd" />
                                <input type="text" name="oldAuthTypeCd" value="${_bean.assignMenu}" />
                                <div class="po_rel">
                                    <p class="select_layer_tit" onclick="jsViewAuthType(this);">
                                        <span> 선택하세요.</span>
                                        <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_layer_open.gif" />" alt="목록보기" class="click" />
                                    </p>
                                    <div class="select_layer" style="width:90%;padding:3px; display: none;">
                                        <ul style="text-align: left;">
                                            <li> <input type="checkbox" name="authTypeR" value="R" onclick="jsAuthTypeStrAdd(this);jsAddMenuMgrAssignTbl(this);" />조회권한</li>
                                            <li> <input type="checkbox" name="authTypeA" value="A" onclick="jsAuthTypeStrAdd(this);jsAddMenuMgrAssignTbl(this);" />기본권한</li>
                                            <li> <input type="checkbox" name="authTypeC" value="G" onclick="jsAuthTypeStrAdd(this);jsAddMenuMgrAssignTbl(this);" />총괄권한</li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
        </div>
        <!-- //메뉴별 지정권한 -->
    </div>

    <div class="buser">
        <h4>추가 신청 권한 목록</h4>
         <table id="selectedAuthList" class="boardList" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="50%"/>
                <col width="50%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>권한그룹별 지정권한</th>
                    <th class="lr_none">메뉴별 지정권한</th>
                </tr>
            </thead>
            <tbody>
                <tr><td colspan="2">권한을 선택하세요.</td></tr>
            </tbody>
        </table>

        <p class="tx_blue mar_b10 mar_t30">[신청사유]</p>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 추가정보 등록하기 </caption>
            <colgroup>
                <col width="10%" />
                <col width="90%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="reqconts">신청사유</label></th>
                    <td><textarea id="reqconts" name="reqconts"  rows="8" class="w99_p"></textarea></td>
                </tr>
            </tbody>
        </table>

        <p class="mar_t10 tx_r"><a href="#" onclick="jsInsertAction();"><button class="blue">신청</button></a> <a href="#" onclick="jsIndex();"><button class="blue">목록</button></a></p>
    </div>
<!-- //컨텐츠영역 -->
</body>
</html>