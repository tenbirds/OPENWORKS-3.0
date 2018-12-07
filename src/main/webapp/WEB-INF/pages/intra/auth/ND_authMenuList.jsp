<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">
<!--
    var jsFoldingToggleImg = function($El, isFolding){
        if($El.length == 0){
            return;
        }
        if(isFolding){
            $El.attr('src', ($El.attr('src')).replace('arrow_tab', 'arrow_down'));
        }else{
            $El.attr('src', ($El.attr('src')).replace('arrow_down', 'arrow_tab'));
        }
    };

    var jsFolding = function(el){
        var isFolding = $(el).parent().find('img._folding').attr('src').indexOf('arrow_tab') > 0 ? true : false;

        jsFoldingToggleImg($(el).parent().find('img._folding'), isFolding);

        var $baseTR = $(el).parent().parent();
        if($baseTR.find('td').length == 5){
            return;
        }

        var $baseTable = $baseTR.parent();
        var $baseTableInTr = $baseTable.find('tr');

        for(var i=1; i<$baseTableInTr.length; i++){
            if(i > $baseTableInTr.index($baseTR)){
                if($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3){
                    break;
                }

                if($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4){
                    break;
                }

                //폴딩...!!
                if(isFolding){
                    $baseTableInTr.eq(i).show();
                }else{
                    $baseTableInTr.eq(i).hide();
                }
                jsFoldingToggleImg($baseTableInTr.eq(i).find('img._folding'), isFolding);

                if($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3){
                    break;
                }

                if($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4){
                    break;
                }
            }
        }
    };

    var jsAllFolding = function(){
        var $baseEl = $('h4 button.s_blue');
        var isAllFolding = $baseEl.text().indexOf('펼치기') > 0 ? true : false;
        if(isAllFolding){
            $('.boardList').find('tr').show();
            jsFoldingToggleImg($('.boardList').find('tr img._folding'), isAllFolding);
            $baseEl.text(($baseEl.text()).replace('펼치기', '접기'));
        }else{
            $('.boardList').find('tr').each(function(index){
                if(index > 1 && $(this).find('td').length > 3){
                    $(this).hide();
                }
            });
            jsFoldingToggleImg($('.boardList').find('tr img._folding'), isAllFolding);
            $baseEl.text(($baseEl.text()).replace('접기', '펼치기'));
        }
    };

    var jsAssignMenuSaveAction = function(){
        var $authCd = $('#BoxList li.check_on > span:first').attr('authCode');
        $('#assignMenuDataForm input[name=authCode]').val($authCd);

        if($('#assignMenuDataForm input[name=menuCdCk]:checked').length == 0){
            jsWarningBox('메뉴를 선택하십시요.');
            return;
        }

        var isNotChecked = false;
        var $lastAuthTypeEl;
        $('#assignMenuDataForm input[name=menuCdCk]').each(function(index){
            if($(this).is(':checked') && $('#assignMenuDataForm select[name=authTyCode]').eq(index).val() == ''){
                isNotChecked = true;
                lastAuthTypeEl = $('#assignMenuDataForm select[name=authTyCode]').eq(index);
                return;
            }
        });

        if(isNotChecked){
            jsWarningBox('사용권한을 선택하십시요.');
            $lastAuthTypeEl.select();
            return;
        }

        //데이터 초기화
        if(!isNotChecked){
            $('#assignMenuDataForm input[name=menuCdCk]').each(function(index){
                var authTypeCheckedVal = '';
                if($('#assignMenuDataForm input[name=authTypeA]').eq(index).is(':checked')){
                    authTypeCheckedVal += 'A';
                }
                if($('#assignMenuDataForm input[name=authTypeR]').eq(index).is(':checked')){
                    authTypeCheckedVal += 'R';
                }
                if($('#assignMenuDataForm input[name=authTypeC]').eq(index).is(':checked')){
                    authTypeCheckedVal += 'C';
                }
                if($('#assignMenuDataForm input[name=authTypeD]').eq(index).is(':checked')){
                    authTypeCheckedVal += 'D';
                }
                if($('#assignMenuDataForm input[name=authTypeG]').eq(index).is(':checked')){
                    authTypeCheckedVal += 'G';
                }

                if($(this).is(':checked')){
                    $('#assignMenuDataForm input[name=menuCd]').eq(index).val($(this).val());
                    $('#assignMenuDataForm input[name=authTyCode]').eq(index).val(authTypeCheckedVal);
                }
            });
        }

        $('#assignMenuDataForm').ajaxSubmit({
            url      : 'ND_assignMenuSaveAction.do',
            type     : 'POST',
            async    : false,
            success  : function(response){
                jsSuccessBox(response);
                $('#assignMenuDataForm input[name=menuCdCk]:checked').parent().parent().addClass('bg_yellow');
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
    };

    /**
     * 폴딩된 상태에서만 하위 메뉴 선택 하게 한다.
     */
    var jsSelectSubdepth = function(el){
        var $baseTR = $(el).parent().parent();
        if($baseTR.find('td').length == 5){
            return;
        }

        var isFolding = $(el).parent().parent().find('img._folding').attr('src').indexOf('arrow_tab') > 0 ? true : false;

        var $baseTable = $baseTR.parent();
        var $baseTableInTr = $baseTable.find('tr');

        for(var i=1; i<$baseTableInTr.length; i++){
            if(i > $baseTableInTr.index($baseTR)){
                if($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3){
                    break;
                }

                if($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4){
                    break;
                }

                //폴딩...!!
                if(!isFolding){
                    $baseTableInTr.eq(i).find('input[name=menuCdCk]').attr('checked', $(el).attr('checked'));
                }else{
                    //$baseTableInTr.eq(i).find('input[name=menuCdCk]').attr('checked', $(el).attr('checked'));
                }

                if($baseTR.find('td').length == 3 && $baseTableInTr.eq(i).find('td').length == 3){
                    break;
                }

                if($baseTR.find('td').length == 4 && $baseTableInTr.eq(i).find('td').length <= 4){
                    break;
                }
            }
        }
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

    var jsAuthTypeClick = function(row, val, targetObj){
	    $('#assignMenuDataForm input[name=oldAuthTypeCd]').each(function(index){
	        if(index == row - 1){
		        if(val == 'R'){
		            $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('checked', false);
		            $('#assignMenuDataForm input[name=authTypeG]').eq(index).attr('checked', false);
		        }else if(val == 'A'){
		            $('#assignMenuDataForm input[name=authTypeR]').eq(index).attr('checked', false);
		            $('#assignMenuDataForm input[name=authTypeG]').eq(index).attr('checked', false);
		        }else if(val == 'G'){
		            $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('checked', false);
		            $('#assignMenuDataForm input[name=authTypeR]').eq(index).attr('checked', false);
		        }
	        }
	    });
        $('div.select_layer').css('z-index','1');
        $(targetObj).parent().parent().parent().parent().find('div.select_layer').css('z-index','99').toggle();
    };

    $().ready(function(){
        $('#assignMenuDataForm input[name=oldAuthTypeCd]').each(function(index){
            if($(this).val().indexOf('G') > -1){
                $('#assignMenuDataForm input[name=authTypeG]').eq(index).attr('checked', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeG]').get(index));
            }
            else if($(this).val().indexOf('A') > -1){
                $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('checked', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeA]').get(index));
            }
            else if($(this).val().indexOf('R') > -1){
                $('#assignMenuDataForm input[name=authTypeR]').eq(index).attr('checked', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeR]').get(index));
            }
            if($(this).val() == ''){
                $('#assignMenuDataForm input[name=authTypeA]').eq(index).attr('checked', true);
                jsAuthTypeStrAdd($('#assignMenuDataForm input[name=authTypeA]').get(index));
            }
        });

        $('table.boardList span.tx_red').click(function(){
            $(this).colorbox({
                title : "담당자 목록",
            	href  : "PD_mgrList.do?menuCd=" + $(this).parent().parent().children(":first").find('input[name=menuCdCk]').val(),
               	width : "800",
               	height:"550",
               	iframe: true
           });
        });

        $('h4 span.tx_red').text($('table.boardList > tbody > tr').length);

        //사용 권한 체크 셀렉트 박스 토글
        $('div.po_rel').click(function(e){
            var $target = $(e.target);
            if($target.is('input') || $target.is('label')){
                return;
            }

            var $imgEl = $(this).find('img');
            var isClosed = $imgEl.attr('src').indexOf('btn_layer_open') > 0 ? true : false;
            if(isClosed){
                $imgEl.attr('src', ($imgEl.attr('src')).replace('btn_layer_open', 'btn_layer_close'));
            }else{
                $imgEl.attr('src', ($imgEl.attr('src')).replace('btn_layer_close', 'btn_layer_open'));
            }

            $('div.select_layer').css('z-index','1');
            $(this).find('div.select_layer').css('z-index','99').toggle();
        });
    });
//-->
</script>

<h4 class="tx_13">전체메뉴 (<span class="tx_red">00</span>개)
	<button type="button" class="s_blue" onclick="jsAllFolding();">전체메뉴 펼치기</button>
</h4>

<!-- 리스트 -->
<form id="assignMenuDataForm">
<input type="hidden" name="authCode" />
<table class="boardList" summary="리스트입니다.">
    <caption class="hidden"> 목록 </caption>
    <colgroup>
        <col width="5%" />
        <col width="20%" />
        <col width="26%" />
        <col width="26%" />
        <col width="*%" />
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
        <c:forEach items="${dataList}" var="_bean" varStatus="status">
            <tr <c:if test="${_bean.menuLevel ne 1}">style="display: none;"</c:if> <c:if test="${not empty _bean.assignMenu}">class="bg_yellow"</c:if>>
                <td>
                    <input type="hidden" name="menuCd" />
                    <input type="checkbox" name="menuCdCk" value="${_bean.menuCd}" <c:if test="${not empty _bean.assignMenu}">checked="checked"</c:if>
                           onclick="jsSelectSubdepth(this);" />
                </td>
                <c:choose>
                    <c:when test="${_bean.menuLevel eq 1}">
                        <td colspan="3" class="tx_l">
                            <img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_tab.gif" />"
                                 alt="열기" class="_folding" />
                            <span onclick="jsFolding(this);" class="cs_pointer"><c:out value="${_bean.menuNm}" /></span>
                            <span class="tx_red">(<c:out value="${_bean.assignPCnt}" />명)</span>
                        </td>
                    </c:when>
                    <c:when test="${_bean.menuLevel eq 2}">
                        <td>&nbsp;</td>
                        <td colspan="2" class="tx_l">
                            <img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_tab.gif" />"
                                 alt="열기" class="_folding" />
                            <span onclick="jsFolding(this);" class="cs_pointer"><c:out value="${_bean.menuNm}" /></span>
                            <span class="tx_red">(<c:out value="${_bean.assignPCnt}" />명)</span>
                        </td>
                    </c:when>
                    <c:when test="${_bean.menuLevel eq 3}">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td class="tx_l">
                            <span><c:out value="${_bean.menuNm}" /></span>
                            <span class="tx_red">(<c:out value="${_bean.assignPCnt}" />명)</span>
                        </td>
                    </c:when>
                </c:choose>
                <td class="lr_none">
                    <input type="hidden" name="authTyCode" value="" />
                    <input type="hidden" name="oldAuthTypeCd" value="${_bean.assignMenu}" />
                    <div class="po_rel">
                        <div>
                            <p class="select_layer_tit">
                                <span> 선택하세요.</span>
                                <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_layer_open.gif" />" alt="목록보기" class="click" />
                            </p>
                            <div class="select_layer" style="width:90%;padding:3px; display: none;">
                                <ul style="text-align: left;">
                                	<li>
                                		<input type="checkbox" name="authTypeR" value="R" onclick="jsAuthTypeStrAdd(this); jsAuthTypeClick(${status.count}, 'R', this);" />
                                		<label for="authTypeR">조회권한</label>
                                	</li>
                                    <li>
                                    	<input type="checkbox" name="authTypeA" value="A" onclick="jsAuthTypeStrAdd(this); jsAuthTypeClick(${status.count}, 'A', this);" />
                                    	<label for="authTypeA">기본권한</label>
                                    </li>
                                    <li>
                                    	<input type="checkbox" name="authTypeG" value="G" onclick="jsAuthTypeStrAdd(this); jsAuthTypeClick(${status.count}, 'G', this);" />
                                    	<label for="authTypeG">총괄권한</label>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<!-- //리스트 -->

<p class="mar_t10 tx_r">
    <a href="#" onclick="jsAssignMenuSaveAction();"><button type="button" class="blue">저장</button></a>
    <button type="reset" class="blue">취소</button>
</p>
</form>