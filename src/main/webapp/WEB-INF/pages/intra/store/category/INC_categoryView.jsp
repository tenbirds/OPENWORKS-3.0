<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">
    $().ready(function() {
        if ( $("#menuModiForm") ) {
            $("#menuModiForm").validate({
                rules: {
                    nodeText: { required:true, minlength:2, maxlength:100 }
                }
            });
        }

        $("#menuAddForm").validate({
            rules: {
                newNodeText: { required:true, minlength:2, maxlength:100 }
            }
        });
    });
    
    var jsCtgrySelPop = function(el, pid) {
        $(el).colorbox({
            title : "카테고리선택",
            href : "/intra/store/goods/PD_categoryPop.do?PID=" + pid,
            width : "580",
            height : "600",
            overlayClose : false,
            escKey : true,
            iframe : true
        });
    };
    
    var jsCtgrySel = function() {
        

        var ctgryCodes = $("#setCtgryCodes").val();
        if (ctgryCodes == "") {
            $('table#goodsCtgry tr:gt(0)').remove();
        }
        else {

            ctgryCodes = ctgryCodes.split(",");
            
            var ctgryCodeUrl = "";
            for (var i = 0; i < ctgryCodes.length; i++) {
                if (i > 0) {
                    ctgryCodeUrl += "&";
                }
                ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
            }
            
            var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
            $.post(url,
            function(response){
                if(response.length > 0){
                    $('table#goodsCtgry tr:gt(0)').remove();
                    
                    for (var i = 0; i < response.length; i++) {                            
                        var htmlVal = "";
                        htmlVal = '<tr id="goodsCtgry_' + response[i].ctgryCode + 'tr">';
                        htmlVal += '<td>' +  response[i].ctgryPath.substring(3) + '</td>';
                        htmlVal += '<td><input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this,\'setCtgryCodes\');"/>';
                        htmlVal += '</td></tr>';

                        $('table#goodsCtgry').append(htmlVal);
                    }

   
                }                
            });
        }
    };
    
    var jsCtgrySel2 = function() {
        

        var ctgryCodes = $("#setCtgryCodes2").val();
        if (ctgryCodes == "") {
            $('table#goodsCtgry2 tr:gt(0)').remove();
        }
        else {

            ctgryCodes = ctgryCodes.split(",");
            
            var ctgryCodeUrl = "";
            for (var i = 0; i < ctgryCodes.length; i++) {
                if (i > 0) {
                    ctgryCodeUrl += "&";
                }
                ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
            }
            
            var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
            $.post(url,
            function(response){
                if(response.length > 0){
                    $('table#goodsCtgry2 tr:gt(0)').remove();
                    
                    for (var i = 0; i < response.length; i++) {                            
                        var htmlVal = "";
                        htmlVal = '<tr id="goodsCtgry2_' + response[i].ctgryCode + 'tr">';
                        htmlVal += '<td>' + response[i].ctgryPath.substring(3) + '</td>';
                        htmlVal += '<td><input type="button" id="goodsCtgry2_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this,\'setCtgryCodes2\');"/>';
                        htmlVal += '</td></tr>';

                        $('table#goodsCtgry2').append(htmlVal);
                    }

   
                }                
            });
        }
    };
    
    var jsCategoryDelete = function(el, id) {
        $('tr#' + el.id+"tr").remove();
        $("#" + id).val("");
    };
</script>

<c:set var="exist" value="${!empty dataVo && dataVo.menuCd ne '0'}" />
<c:if test="${exist}">
    <h4>선택한 카테고리 정보</h4>
    <form id="menuModiForm">
    
    <table class="boardWrite">
        <colgroup>
            <col width="120px" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th>카테고리 코드</th>
                <td class="lr_none">
                    <input type="hidden" name="nodeId" id="nodeId" value="${dataVo.menuCd}" />
                    ${dataVo.menuCd}
                </td>
            </tr>
            <tr>
                <th>카테고리 명<span class="tx_red_s">*</span></th>
                <td class="lr_none">
                    <input type="text" name="nodeText" id="nodeText" value="${dataVo.menuNm}" maxlength="100" class="text" size="100" title="카테고리 명을 입력해주세요"/><br/>
                    <span class="tx_blue_s">(최대 <b>100</b>자)</span>
                </td>
            </tr>
            <c:if test="${dataVo.ctgryClCd eq 1002 && dataVo.leaf}">
            <tr>
                <th>표준프레임워크호환 카테고리</th>
                <td>
                <input type="hidden" name="mapngCtgryCode" id="setCtgryCodes2" class="getCtgryCodes2" value="${dataVo.mapngCtgryCode}"></input>
                
                <table id="goodsCtgry2">
                     <tr><td colspan="3"><div class="mar_t10 tx_b" id="test2"><input type="button" id="ctgryBtn2" value="카테고리 선택" class="blue" onclick="jsCtgrySelPop(this,'ST04');" /></div></td></tr>
                     <c:if test="${not empty dataVo.mapngCtgryCode}">
                     <tr id="goodsCtgry2_${dataVo.mapngCtgryCode}tr">                     
                            <td>${dataVo.mapngCtgryPath}</td>
                            <td>
                                <input type="button" id="goodsCtgry2_${dataVo.mapngCtgryCode}" value="X" onclick="jsCategoryDelete(this, 'setCtgryCodes2');"/>
                            </td>
                     </tr>
                     </c:if>
                </table>
                </td>
            </tr>
            </c:if>
        </tbody>
    </table>

    <br class="blank"/>

    <h4>선택한 카테고리 부가 정보</h4>

    <table class="boardWrite">
        <colgroup>
            <col width="120px" />
            <col width="" />
        </colgroup>
        <tbody>
        <tr>
            <th>카테고리 위치</th>
            <td><span id="nodePath"></span></td>
        </tr>
        <tr>
            <th>사용 여부<span class="tx_red_s">*</span></th>
            <td>
                <input type="radio" name="useYn" id="useYn_Y" value="Y" class="radio"
                    <c:if test="${dataVo.useYn == 'Y'}">checked="checked"</c:if> />
                    <label for="useYn_Y">사용</label>
                <input type="radio" name="useYn" id="useYn_N" value="N" class="radio"
                    <c:if test="${dataVo.useYn == 'N'}">checked="checked"</c:if> />
                    <label for="useYn_N">미사용</label>
                <p class="tx_blue_s">미사용 선택 시 서비스 화면에는 표시되지 않습니다.</p>
            </td>
        </tr>        
        <tr>
            <th>등록일</th>
            <td>${dataVo.regDt}</td>
        </tr>
        <c:if test="${!empty dataVo.modiDt}">
            <tr>
                <th>수정일</th>
                <td>${dataVo.modiDt}</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    </form>

    <div class="tx_r mar_t10 mar_b20">
        <button type="button" class="blue" onclick="jsUpdateAction('#menuModiForm');">수정</button>
        <button type="button" class="blue" onclick="jsDeleteAction();">삭제</button>
    </div>
</c:if>

<h4>카테고리 추가</h4>

<form id="menuAddForm">
<table class="boardWrite">
    <colgroup>
        <col width="120px" />
        <col width=""/>
    </colgroup>
    <tbody>
        <tr>
            <th>카테고리 명<span class="tx_red_s">*</span></th>
            <td><input type="text" name="newNodeText" id="newNodeText" maxlength="100" size="100" class="text"/><br/>
            <span class="tx_blue_s">(최대 <b>100</b>자)</span>
            </td>
        </tr>
            <c:if test="${baseVo eq 1002}">
            <tr>
                <th>표준프레임워크호환 카테고리</th>
                <td>
                <input type="hidden" name="mapngCtgryCode" id="setCtgryCodes" class="getCtgryCodes"></input>
                <table id="goodsCtgry">
                     <tr><td colspan="3"><div class="mar_t10 tx_b" id="test"><input type="button" id="ctgryBtn" value="카테고리 선택" class="blue" onclick="jsCtgrySelPop(this,'ST03');" /></div></td></tr>
                </table>
                </td>
            </tr>
            </c:if>
        <tr>
            <th>추가 옵션</th>
            <td>
                <div><input type="radio" name="appendOption" id="isSame" value="isSame"
                    class="radio" <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isSame">선택한 카테고리 동일 레벨에 추가</label></div>

                <div><input type="radio" name="appendOption" id="isChild" value="isChild"
                    class="radio" <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isChild">선택한 카테고리 하위 레벨에 추가</label></div>

                <div><input type="radio" name="appendOption" id="isRoot" value="isRoot"
                    class="radio" checked="checked" /> <label for="isRoot">루트 카테고리에 추가</label></div>
            </td>
        </tr>
    </tbody>
</table>
</form>

<div class="tx_r mar_t10 mar_b20">
    <button type="button" class="w_blue" onclick="jsInsertAction('#menuAddForm');">추가</button>
</div>
