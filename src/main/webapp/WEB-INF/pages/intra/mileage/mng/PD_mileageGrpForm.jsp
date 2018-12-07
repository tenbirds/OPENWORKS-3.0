<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>마일리지 그룹 등록</title>
    <op:jsTag type="spi" items="ui,validate,form"/>
    
    <script type="text/javascript">
    <!--
    
    $().ready(function () {
        url = "ND_insertMileageGrpAction.do";
        <c:if test="${actionUrl eq 'updateMileageGrpAction'}">
            trNum = '<c:out value="${fn:length(mileageGrpItemInfo)}" />';
            url = "ND_updateMileageGrpAction.do";
        </c:if>
        $("#dataForm").validate({
            rules: {
                mileageGrpNm : { required:true, maxlength:50}
              , mileagePoint : { required:true, number:true, maxlength:6 }
              , mileageItemNm : { required:true, maxlength:50 }
            },
            submitHandler : function(form) {
                var accuType = "";
                $("input[name^=accuType_]:checked").each(function(index){
                    if(accuType != "") accuType += ",";
                    accuType += $(this).val();
                });
                $("input[name=accuType]").val(accuType);
                $(form).ajaxSubmit({
                    url : url,
                    type : "POST",
                    dataType : "json",
                    success  : function(response) {
                        if(response.result) {
                            jsSuccessBox(response.message);
                            location.href="PD_setMileageGroupPop.do";
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    },
                    error :  function(response) {
                        jsSysErrorBox(response.responseText);
                        return;
                    }
                });
            }
        });
    });
    var trNum = 1;
    var jsAddItemTr = function() {
        var $baseTableTr = $('#itemList > tbody');
        $baseTableTr.append(jsMakeItemHtml(++trNum, $baseTableTr.length/3+1));
    };
    
    var jsDeleteItem = function(indexNum, type) {
        if(confirm("정말 삭제하시겠습니까?")){
            if(type == "U"){
                $.post("ND_deleteMileageItemCd.do", {
                        mileageGrpCd : $("#mileageGrpCd").val(),
                        mileageItemCd : indexNum
                    },
                    function(response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.deleteOk);
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        } catch (e) {
                            jsSysErrorBox(response, e);
                            return;
                        }
                    }
                );
            }
            $('.tr'+indexNum).remove();
        }
    };
    
    var jsDelete = function(grpCd) {
        if(confirm("정말 삭제하시겠습니까?")){
            $.post("ND_deleteMileageGroupAction.do", {
                    mileageGrpCd : grpCd,
                },
                function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                        } else {
                            jsErrorBox("해당 마일리지를 삭제후 그룹을 삭제하세요.");
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                    location.href="PD_setMileageGroupPop.do";
                }
            );
        }
    };
    
    var jsMakeItemHtml = function(indexNum, trLength) {//trLength 음...
        var itemHtml = '';
        itemHtml += '<tr class="tr'+indexNum+'">';
        itemHtml += '    <th rowspan="3" class="line_r">';
        itemHtml +=          indexNum+'. 그룹 항목 <button class="gray_s" type="button" onclick="jsDeleteItem('+indexNum+');">삭제</button>';
        itemHtml += '        <input type="hidden" id="mileageItemCd'+indexNum+'" name="mileageItemCd" value="'+indexNum+'" />';
        itemHtml += '    </th>';
        itemHtml += '    <th><label for="type">구분</label></th>';
        itemHtml += '    <td><input type="text" class="w180" id="mileageItemNm_'+indexNum+'" name="mileageItemNm" />';
        itemHtml += '    <input type="hidden" id="registerMode_'+indexNum+'" name="registerMode" value="I" />';
        itemHtml += '    </td>';
        itemHtml += '</tr>';
        itemHtml += '<tr class="tr'+indexNum+'">';
        itemHtml += '    <th>타입</th>';
        itemHtml += '    <td>';
        itemHtml += '        <input type="radio" id="accuType_A_'+indexNum+'" name="accuType_'+indexNum+'" checked="checked" value="A" /> <label for="accuType_A_'+indexNum+'">적립</label>';
        itemHtml += '        <input type="radio" id="accuType_S_'+indexNum+'" name="accuType_'+indexNum+'" value="S" /> <label for="accuType_S_'+indexNum+'">차감</label>';
        itemHtml += '    </td>';
        itemHtml += '</tr>';
        itemHtml += '<tr class="tr'+indexNum+'">';
        itemHtml += '    <th><label for="mileagePoint_'+indexNum+'">Point</label></th>';
        itemHtml += '    <td><input type="text" class="w120" id="mileagePoint_'+indexNum+'" name="mileagePoint" maxlength="6" /> 점';
        itemHtml += '    </td>';
        itemHtml += '</tr>';
        
        return itemHtml;
    };
    
    var jsList = function(){
        $("#listForm").submit();
    };
    //-->
    </script>
</head>

<body>

<h2>마일리지 그룹 설정</h2>
<div id="popup">
<form id="listForm" action="PD_setMileageGroupPop.do"></form>
<form id="dataForm">
<input id="mileageGrpCd" name="mileageGrpCd" type="hidden" value="${param.mileageGrpCd}"/>
<input name="accuType" type="hidden" />
    <fieldset>
    <legend>마일리지 그룹 설정</legend>
    <table class="boardWrite" cellspacing="0" border="0">
        <caption class="hidden"> 마일리지 그룹명 </caption>
        <colgroup>
            <col width="30%" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th>마일리지 그룹명</th>
                <td><input type="text" class="w_92p" id="mileageGrpNm" name="mileageGrpNm" value="${mileageGrpInfo.mileageGrpNm}" />
                </td>
            </tr>
        </tbody>
    </table>
    
    <p class="tx_r mar_b10 mar_t10 mar_r10">
        <span><button class="blue" type="button" onclick="jsAddItemTr();">추가</button></span>
    </p>
    
    <table class="boardWrite" cellspacing="0" border="0" id="itemList">
        <caption class="hidden"> 마일리지 그룹 설정 </caption>
        <colgroup>
            <col width="20%" />
            <col width="10%" />
            <col width="" />
        </colgroup>
        <tbody>
        <c:choose>
            <c:when test="${actionUrl eq 'insertMileageGrpAction' or empty mileageGrpItemInfo}">
            <tr>
                <th rowspan="3" class="line_r">1. 그룹 항목</th>
                <th><label for="type">구분</label></th>
                <td><input type="text" class="w180" id="mileageItemNm_1" name="mileageItemNm" /> 예) 게시글 등록, 삭제 등
                </td>
            </tr>
            <tr>
                <th>타입</th>
                <td>
                    <input type="radio" id="accuType_A_1" name="accuType_1" checked="checked" value="A" /> <label for="accuType_A_1">적립</label>
                    <input type="radio" id="accuType_S_1" name="accuType_1" value="S" /> <label for="accuType_S_1">차감</label>
                </td>
            </tr>
            <tr>
                <th><label for="mileagePoint_1">Point</label></th>
                <td><input type="text" class="w120" id="mileagePoint_1" name="mileagePoint" value="" maxlength="6" /> 점
                </td>
            </tr>
            </c:when>
            
            <c:otherwise>
            <c:forEach items="${mileageGrpItemInfo}" var="itemInfo" varStatus="vst">
                <tr class="tr${itemInfo.mileageItemCd}">
                    <th rowspan="3" class="line_r">
                        ${itemInfo.mileageItemCd}. 그룹 항목 
                        <c:if test="${!vst.first}">
                            <button class="gray_s" type="button" onclick="jsDeleteItem('${itemInfo.mileageItemCd}','U');">삭제</button>
                        </c:if>
                        <input type="hidden" id="mileageItemCd${vst.count}" name="mileageItemCd" value="${itemInfo.mileageItemCd}" />
                    </th>
                    <th><label for="type">명칭</label></th>
                    <td><input type="text" class="w180" id="mileageItemNm_${vst.count}" name="mileageItemNm" value="${itemInfo.mileageItemNm}" /> 예) 게시글 등록, 삭제 등
                    </td>
                </tr>
                <tr class="tr${itemInfo.mileageItemCd}">
                    <th>타입</th>
                    <td>
                        <input type="radio" id="accuType_A_${vst.count}" name="accuType_${vst.count}" checked="checked" value="A" />
                        &nbsp;<label for="accuType_A_${vst.count}">적립</label>
                        <input type="radio" id="accuType_S_${vst.count}" name="accuType_${vst.count}" value="S" <c:if test="${itemInfo.accuType eq 'S'}">checked="checked"</c:if> />
                        &nbsp;<label for="accuType_S_${vst.count}">차감</label>
                    </td>
                </tr>
                <tr class="tr${itemInfo.mileageItemCd}">
                    <th><label for="mileagePoint_${vst.count}">Point</label></th>
                    <td><input type="text" class="w120" id="mileagePoint_${vst.count}" name="mileagePoint" value="${itemInfo.mileagePoint}" maxlength="6" /> 점</td>
                </tr>
            </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    </fieldset>

    <p class="tx_c mar_t20">
        <c:if test="${actionUrl ne 'updateMileageGrpAction'}">
            <button class="blue">등록</button>
        </c:if>
        <c:if test="${actionUrl eq 'updateMileageGrpAction'}">
            <button class="blue">수정</button>
            <button class="blue" type="button" onclick="jsDelete('${param.mileageGrpCd}');">삭제</button>
        </c:if>
        <button class="blue" type="button" onclick="history.back();">목록</button>
    </p>
</form> 
</div>
</body>
</html>
                    