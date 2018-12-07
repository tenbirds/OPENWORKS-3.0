<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">
<!--
    var jsFoldingToggleImg = function ($El, isFolding) {
        if ($El.length == 0) {
            return;
        }
        if (isFolding) {
            $El.attr('src', ($El.attr('src')).replace('arrow_tab', 'arrow_down'));
        } else {
            $El.attr('src', ($El.attr('src')).replace('arrow_down', 'arrow_tab'));
        }
    };

    var jsFolding = function (el) {
        var isFolding = $(el).parent().find('img._folding').attr('src').indexOf('arrow_tab') > 0 ? true : false;

        jsFoldingToggleImg($(el).parent().find('img._folding'), isFolding);

        var $baseTR = $(el).parent().parent();
        if ($baseTR.find('td').length == 5) {
            return;
        }


        var $baseTable = $baseTR.parent();
        var $baseTableInTr = $baseTable.find('tr');

        for (var i = 1; i < $baseTableInTr.length; i++) {
            if (i > $baseTableInTr.index($baseTR)) {
                if ($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3) {
                    break;
                }

                if ($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4) {
                    break;
                }

                // 폴딩...!!
                if (isFolding) {
                    $baseTableInTr.eq(i).show();
                } else {
                    $baseTableInTr.eq(i).hide();
                }
                jsFoldingToggleImg($baseTableInTr.eq(i).find('img._folding'), isFolding);


                if ($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3) {
                    break;
                }

                if ($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4) {
                    break;
                }
            }
        }
    };

    var jsAllFolding = function () {
        var $baseEl = $('h4 button.s_blue');
        var isAllFolding = $baseEl.text().indexOf('펼치기') > 0 ? true : false;
        if (isAllFolding) {
            $('.boardList').find('tr').show();
            jsFoldingToggleImg($('.boardList').find('tr img._folding'), isAllFolding);
            $baseEl.text(($baseEl.text()).replace('펼치기', '접기'));
        } else {
            $('.boardList').find('tr').each(function (index) {
                if (index > 1 && $(this).find('td').length > 3) {
                    $(this).hide();
                }
            });
            jsFoldingToggleImg($('.boardList').find('tr img._folding'), isAllFolding);
            $baseEl.text(($baseEl.text()).replace('접기', '펼치기'));
        }
    };


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



    /**
     * 폴딩된 상태에서만 하위 메뉴 선택 하게 한다.
     */
    var jsSelectSubdepth = function (el) {
        var $baseTR = $(el).parent().parent();
        if ($baseTR.find('td').length == 5) {
            return;
        }

        var isFolding = $(el).parent().parent().find('img._folding').attr('src').indexOf('arrow_tab') > 0 ? true : false;

        var $baseTable = $baseTR.parent();
        var $baseTableInTr = $baseTable.find('tr');

        for (var i = 1; i < $baseTableInTr.length; i++) {
            if (i > $baseTableInTr.index($baseTR)) {
                if ($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3) {
                    break;
                }

                if ($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4) {
                    break;
                }

                // 폴딩...!!
                if (!isFolding) {
                    $baseTableInTr.eq(i).find('input[name=menuCdCk]:not(:disabled)').attr('checked' ,$(el).attr('checked'));
                } else {
                    // $baseTableInTr.eq(i).find('input[name=menuCdCk]').attr('checked',$(el).attr('checked'));
                }


                if ($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3) {
                    break;
                }

                if ($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4) {
                    break;
                }
            }
        }
    };


    // 사용 권한 체크 셀렉트 박스 설정
    var jsAuthTypeStrAdd = function (el) {
        var isChecked = $(el).is(':checked');
        var val = $(el).val();

        var $span = $(el).parents('div.po_rel').find('p > span');
        var $checkBoxGp = $(el).parent().parent().find('input:checkbox');

        var writeAuthTypeStr = function (val) {
            var returnVal = '';
            switch(val) {
            case 'R' : {returnVal = '조회 '; break;}
            case 'A' : {returnVal = '기본 '; break;}
            case 'G' : {returnVal = '총괄 '; break;}
            }
            return returnVal;
        };


        if (isChecked) {
            if (val == 'A') {
                $checkBoxGp.filter(':not(:first)').filter('[ock=N]').attr('checked', false);
                $checkBoxGp.filter(':not(:first)').filter('[ock=N]').attr('disabled', true);
                $span.text(writeAuthTypeStr(val) + '권한');
                return;
            }
        } else {
            if (val == 'A') {
                $checkBoxGp.filter(':not(:first)').filter('[ock=N]').attr('disabled', false);
            }
        }


        if ($(el).parent().parent().find('input:checked').length == 0) {
            $span.text('선택하세요.');
        } else {
            $(el).parent().parent().find('input:checkbox').each(function () {
                if ($(this).is(':checked')) {
                    if ($span.text().indexOf('선택') > -1) {
                        $span.text(writeAuthTypeStr(val) + '권한');
                    } else if ($span.text().indexOf(writeAuthTypeStr($(this).val())) == -1) {
                        $span.text($span.text().replace('권한', writeAuthTypeStr($(this).val()) + '권한'));
                    }
                } else {
                    $span.text($span.text().replace(writeAuthTypeStr($(this).val()), ''));
                }
            });

        }

        var isSubAllChecked = true;
        $checkBoxGp.filter(':not(:first)').each(function () {
            if ($(this).is(':not(:checked)'))  isSubAllChecked = false;
        });

        if (isSubAllChecked) {
            $checkBoxGp.filter(':first').attr('disabled', true);
        } else {
            $checkBoxGp.filter(':first').attr('disabled', false);
        }

    };

    var jsAddMenuMgrAssignTbl = function (el) {
        var assignTypeCd = $(el).val();

        var menuCd = $(el).parents('tr:first').find('input[name=menuCdCk]').val();
        $(el).parents('tr:first').find('input[name=menuCdCk]').attr('checked', true);


        var $baseTableTr = $('#selectedAuthList > tbody > tr');
        var $baseSpan = $baseTableTr.find('span[menuCd="'+menuCd+'"]');

        if ($(el).is(':checked')) {
            if ($baseSpan.length > 0) {
                var addedAssingTypeCd = $baseSpan.attr('assignTypeCd') + assignTypeCd;
                $baseSpan.parent().html(jsMakeMenuSpanHtml(el, menuCd, addedAssingTypeCd));
            } else {

                if ($baseTableTr.find('td').eq(0).text().indexOf('담당자를 선택하십시요.') > -1) {
                    $baseTableTr.parent().html('<tr><td></td><td class="lr_none"></td></tr>');
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
                    $baseTableTr.parent().append('<tr><td></td><td class="lr_none">'+spanHtml+'</td></tr>');
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

    };

    var jsMakeMenuSpanHtml = function (el, menuCd, assignTypeCd) {
        var spanHtml = '';
        spanHtml += '<span ';
        spanHtml += '      menuCd="' + menuCd + '"';
        spanHtml += '      assignTypeCd="' + assignTypeCd + '"';
        spanHtml += '>';
        spanHtml += jsMakeMenuStr(el);
        spanHtml += ' [ '+ jsMakeAuthStr(assignTypeCd) + ' ]';
        spanHtml += '</span>';

        return spanHtml;
    };

    var jsMakeAuthStr = function (assignTypeCd) {
        var authStr = '';
        if (assignTypeCd.indexOf('R') > -1) {
            authStr += '조회 ';
        }
        if (assignTypeCd.indexOf('A') > -1) {
            authStr += '기본 ';
        }
        if (assignTypeCd.indexOf('G') > -1) {
            authStr += '총괄 ';
        }
        return authStr + '권한';

    };

    var jsMakeMenuStr = function (el) {
        var $baseTableTr = $('#MenuList table > tbody > tr');
        var index = $baseTableTr.index($(el).parents('tr:first'));

        var menuStr = "";
        var added2ndMenu = false;
        var added3thMenu = false;
        for (var i = index; i >= 0; i--) {
            if ($baseTableTr.eq(i).find('td').length == 3) {
                menuStr = $baseTableTr.eq(i).find('td').eq(1).text() + menuStr;
                break;
            }
            if (!added2ndMenu && $baseTableTr.eq(i).find('td').length == 4) {
                menuStr = ' > ' + $baseTableTr.eq(i).find('td').eq(2).text() + menuStr;
                added2ndMenu = true;
            }
            if (!added3thMenu && $baseTableTr.eq(i).find('td').length == 5) {
                menuStr = ' > ' + $baseTableTr.eq(i).find('td').eq(3).text() + menuStr;
                added3thMenu = true;
            }
        }

        return menuStr;
    };

    $().ready(function () {
        $('#assignMenuDataForm input[name=oldAuthTypeCd]').each(function (index) {
            if ($(this).val().indexOf('R') > -1) {
                $('#assignMenuDataForm input[name=authTypeR]').eq(index).attr('checked', true);
                $('#assignMenuDataForm input[name=authTypeR]').eq(index).attr('disabled', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeR]').get(index));
                $('#assignMenuDataForm input[name=authTypeR]').eq(index).attr('ock', 'Y');
            }
            if ($(this).val().indexOf('A') > -1) {
                $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('checked', true);
                $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('disabled', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeA]').get(index));
                $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('ock', 'Y');
                return;
            }
            if ($(this).val().indexOf('G') > -1) {
                $('#assignMenuDataForm input[name=authTypeG]').eq(index).attr('checked', true);
                $('#assignMenuDataForm input[name=authTypeG]').eq(index).attr('disabled', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeG]').get(index));
                $('#assignMenuDataForm input[name=authTypeG]').eq(index).attr('ock', 'Y');
            }
            if ($(this).val().indexOf('D') > -1) {
                $('#assignMenuDataForm input[name=authTypeD]').eq(index).attr('checked', true);
                $('#assignMenuDataForm input[name=authTypeD]').eq(index).attr('disabled', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeD]').get(index));
                $('#assignMenuDataForm input[name=authTypeD]').eq(index).attr('ock', 'Y');
            }
        });

        $('table.boardList span.tx_red').click(function () {
            $(this).colorbox({
                title : "담당자 목록"
               ,href  : "PD_mgrList.do?menuCd=" + $(this).parent().parent().children(":first").find('input[name=menuCdCk]').val()
               ,width : "800" ,height:"550"
               ,iframe: true
           });
        });

        $('#menuLength').text($('#MenuList table.boardList > tbody > tr').length);
        $('#menuAssignLength').text($('#MenuList table.boardList > tbody > tr input[name=menuCdCk]:checked').length);

        // 사용 권한 체크 셀렉트 박스 토글
        $('div.po_rel').click(function (e) {
            var $target = $(e.target);
            if ($target.is('input') || $target.is('label')) {
                return;
            }

            var $imgEl = $(this).find('img');
            var isClosed = $imgEl.attr('src').indexOf('btn_layer_open') > 0 ? true : false;
            if (isClosed) {
                $imgEl.attr('src', ($imgEl.attr('src')).replace('btn_layer_open', 'btn_layer_close'));
            } else {
                $imgEl.attr('src', ($imgEl.attr('src')).replace('btn_layer_close', 'btn_layer_open'));
            }

            $('div.select_layer').css('z-index','1');
            $(this).find('div.select_layer').css('z-index','99').toggle();
        });
    });
//-->
</script>


<h4 class="float_l">메뉴별 지정권한 &nbsp;&nbsp;&nbsp;<button class="s_blue" type="button" onclick="jsAllFolding();">전체메뉴 펼치기</button></h4>
<p class="tx_b float_r">메뉴목록 (전체 <span id="menuLength">50</span>개 / 지정 <span id="menuAssignLength" class="tx_red_b">5</span>개)</p>


<!-- 리스트 -->
<form id="assignMenuDataForm">
<div style="overflow:auto;height:353px;border: 1px solid #cccccc;" class="clear">
<input type="hidden" name="authCd" />
<table class="boardList" summary="리스트입니다.">
    <caption class="hidden"> 목록 </caption>
    <colgroup>
        <col width="5%" />
        <col width="28%" />
        <col width="28%" />
        <col width="28%" />
        <col width="*" />
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">선택</th>
            <th colspan="3">하위메뉴명</th>
            <th rowspan="2" class="lr_none">사용권한</th>
        </tr>
        <tr>
            <th>1DEPTH</th>
            <th>2DEPTH</th>
            <th>3DEPTH</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${dataList}" var="_bean">
            <tr <c:if test="${_bean.menuLevel ne 1}">style="display: none;"</c:if> <c:if test="${not empty _bean.assignMenu or _bean.mgrAssign eq 'Y'}">class="bg_yellow"</c:if>>
                <td>
                    <input type="hidden" name="menuCd" />
                    <input type="checkbox" name="menuCdCk" value="${_bean.menuCd}" <c:if test="${not empty _bean.assignMenu or _bean.mgrAssign eq 'Y'}">checked="checked" disabled="disabled"</c:if>
                           onclick="jsSelectSubdepth(this);" />
                </td>
                <c:choose>
                    <c:when test="${_bean.menuLevel eq 1}">
                        <td colspan="3" class="tx_l">
                            <img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_tab.gif" />"
                                 alt="열기" class="_folding" />
                            <span onclick="jsFolding(this);" class="_menuTitle cs_pointer"><c:out value="${_bean.menuNm}" /></span>
                            <span class="tx_red">(<c:out value="${_bean.assignPCnt}" />명)</span>
                        </td>
                    </c:when>
                    <c:when test="${_bean.menuLevel eq 2}">
                        <td>&nbsp;</td>
                        <td colspan="2" class="tx_l">
                            <img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_tab.gif" />"
                                 alt="열기" class="_folding" />
                            <span onclick="jsFolding(this);" class="_menuTitle cs_pointer"><c:out value="${_bean.menuNm}" /></span>
                            <span class="tx_red">(<c:out value="${_bean.assignPCnt}" />명)</span>
                        </td>
                    </c:when>
                    <c:when test="${_bean.menuLevel eq 3}">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td class="tx_l">
                            <span onclick="jsFolding(this);" class="_menuTitle"><c:out value="${_bean.menuNm}" /></span>
                            <span class="tx_red">(<c:out value="${_bean.assignPCnt}" />명)</span>
                        </td>
                    </c:when>
                </c:choose>
                <td class="lr_none">
                    <div class="po_rel" style="width:130px;">
                        <input type="hidden" name="authTypeCd" />
                        <input type="hidden" name="oldAuthTypeCd" value="${_bean.assignMenu}" />
                        <p class="select_layer_tit">
                            <span> 선택하세요.</span>
                            <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_layer_open.gif" />" alt="목록보기" class="click" />
                        </p>
                        <div class="select_layer" style="width:114px;padding:3px; display: none;">
                            <ul style="text-align: left;">
                                <li> <input type="checkbox" name="authTypeR" value="R" ock="N" onclick="jsAuthTypeStrAdd(this);jsAddMenuMgrAssignTbl(this);" /> <label for="authTypeR">조회권한</label></li>
                                <li> <input type="checkbox" name="authTypeA" value="A" ock="N" onclick="jsAuthTypeStrAdd(this);jsAddMenuMgrAssignTbl(this);" /> <label for="authTypeA">기본권한</label></li>
                                <li> <input type="checkbox" name="authTypeG" value="G" ock="N" onclick="jsAuthTypeStrAdd(this);jsAddMenuMgrAssignTbl(this);" /> <label for="authTypeG">총괄권한</label></li>
                            </ul>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</div>
<p class="mar_t10 mar_b20 tx_r">
    <a href="#" onclick="jsAssign4MgrSaveAction();"><button type="button" class="blue">수정</button></a>
    <button type="reset" class="blue">취소</button></a>
</p>
</form>
<!-- //리스트 -->
