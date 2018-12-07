<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

<html>
<head>
    <title>마일리지 폼</title>
    <op:jsTag type="spi" items="form, validate,colorbox" />

    <script type="text/javascript">
    <!--
    $().ready(function(){
        if('${actionUrl}' == 'updateMileageAction'){
            jsSelectGrp('${dataVo.mileageGrpCd}', '${dataVo.mileageCd}');
        }

        if($("#maxCntUnlimit:checked").val() == "Y") $("#dailyMaxAccuCnt").attr("disabled", "disabled");
        if($("#maxAmountUnlimit:checked").val() == "Y") $("#dailyMaxAccuAmount").attr("disabled", "disabled");

        $("#dataForm").validate({
            rules: {
                mileageNm : {required:true, maxlength: 100}
                //, amount    : {number:true, required:true, maxlength: 6}
                //, maxCnt    : {number:true}
                //, maxAmount : {number:true}
            },
            submitHandler : function(form) {
                if($("#maxAmountUnlimit:checked").val() != "Y"){
                    if($('#dailyMaxAccuAmount').val() < eval($('#iPoint').text())){
                        jsWarningBox("1일 최대한도가 적립 포인트보다 적습니다.");
                        return false;
                    }
                }
                var _url = "";
                if('${actionUrl}' == 'insertMileageAction') _url = 'ND_insertMileageAction.do';
                else if('${actionUrl}' == 'updateMileageAction') _url = 'ND_updateMileageAction.do';
                $(form).ajaxSubmit({
                    url : _url,
                    type : "POST",
                    success : function(response){
                        try {
                            if(eval(response)) {
                                var message = Message.msg.insertOk;
                                if(_url == "ND_updateMileageAction.do") {
                                    message = Message.msg.updateOk;
                                }

                                jsSuccessBox(message);
                                parent.$.fn.colorbox.close();
                                parent.location.reload();
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
        });
    });

    var jsSelectGrp = function(mileageGrpCd, mileageCd){
        if(mileageGrpCd == 0){
            $("#result").hide();
            $(".resultItem").remove();
        }else{
            $("#result").show();
            $("#result").load("INC_loadGrpItem.do", {
                mileageGrpCd : mileageGrpCd,
                mileageCd : mileageCd
            });
        }
    };

    var jsDelete = function(){
        if(confirm("해당 마일리지를 삭제 하시겠습니까?")){
            $.post("ND_deleteMileageAction.do", {
                mileageCds : $("#mileageCd").val(),
            }, function(response){
                if(response.result) {
                    var accuExist = response.value;
                    // 삭제 제외된 항목이 있는지에 따라서 메시지 표시 구분
                    if(accuExist) {
                        var msg = "선택된 마일리지 중 이미 적립이 이루어진 마일리지가 있습니다.<br />";
                        msg += "적립이 이루어진 마일리지는 삭제대상에서 제외됩니다.<br /><br />";
                        msg += "적립된 마일리지 : " + accuExist;
                        msg += "<br /><br />위 항목을 제외한 ";

                        var options = {};
                        options["type"] = "success";
                        options["stay"] = "true";
                        sendMsg(msg + response.message, options);
                    } else {
                        jsSuccessBox(response.message);
                    }
                    parent.location.reload();
                } else {
                    jsErrorBox(Message.msg.processFail);
                }
            });
        }
    };

    var jsMaxCntInit = function(){
        if($("#maxCntUnlimit:checked").val() == "Y"){
            $("#dailyMaxAccuCnt").val("");
            $("#dailyMaxAccuCnt").attr("disabled", "disabled");
        }else{
            $("#dailyMaxAccuCnt").removeAttr("disabled");
        }
    };

    var jsMaxAmountInit = function(){
        if($("#maxAmountUnlimit:checked").val() == "Y"){
            $("#dailyMaxAccuAmount").val("");
            $("#dailyMaxAccuAmount").attr("disabled", "disabled");
        }else{
            $("#dailyMaxAccuAmount").removeAttr("disabled");
        }
    }
    //-->
    </script>
</head>
<body>
<div id="popup">

<c:set value="등록" var="actionNm" />
<c:if test="${actionUrl eq 'updateMileageAction'}">
    <c:set value="수정" var="actionNm" />
</c:if>

<h2>마일리지 ${actionNm}</h2>

<p class="tx_r mar_b10"><span class="tx_red tx_b">* </span>표시는 필수입력사항입니다.</p>

<form id="dataForm" name="dataForm" method="post">
<input type="hidden" name="mileageCd" id="mileageCd" value="${dataVo.mileageCd}" />

    <fieldset>
        <legend>마일리지등록</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="마일리지등록을 하실 수 있습니다.">
            <caption class="hidden"> 마일리지등록 </caption>
            <colgroup>
                <col width="16%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><span class="tx_red tx_b">*</span> <label for="mileageNm">마일리지 명</label></th>
                    <td><input type="text" id="mileageNm" class="w60_p" name="mileageNm" value="${dataVo.mileageNm}" /></td>
                </tr>
                <tr>
                    <th><span class="tx_red tx_b">*</span> <label for="mileageType">마일리지 그룹명</label></th>
                    <td>
                        <p>
                            <select id="mileageGrpCd" name="mileageGrpCd" onchange="jsSelectGrp(this.value,'');">
                                <option value="0">-- 선택 --</option>
                                <c:forEach items="${grpList}" var="list" varStatus="status">
                                    <option value="${list.mileageGrpCd}"<c:if test="${list.mileageGrpCd eq dataVo.mileageGrpCd}"> selected="selected"</c:if>>${list.mileageGrpNm}</option>
                                </c:forEach>
                            </select>
                        </p>
                        <ol id="result" class="mar_t10" style="display: none;">
                        </ol>
                    </td>
                </tr>
                <tr>
                    <th><label for="maxCnt">1일 적립회수</label></th>
                    <td>
                        <input type="text" name="dailyMaxAccuCnt" id="dailyMaxAccuCnt" class="w80" value="${dataVo.dailyMaxAccuCnt}" /> 회
                        <c:if test="${not empty dataVo and empty dataVo.dailyMaxAccuCnt}"><c:set value="checked=\"checked\"" var="maxCntUnlimit_checked" /></c:if>
                        &nbsp;&nbsp;&nbsp;<input type="checkbox" name="maxCntUnlimit" id="maxCntUnlimit" value="Y" ${maxCntUnlimit_checked} onclick="jsMaxCntInit();" /> <label for="maxCntUnlimit">적립회수 제한없음</label>
                    </td>
                </tr>
                <tr>
                    <th><label for="maxAmount">1일 적립 최대한도</label></th>
                    <td>
                        <input type="text" id="dailyMaxAccuAmount" class="w80" name="dailyMaxAccuAmount" value="${dataVo.dailyMaxAccuAmount}" /> 점
                        <c:if test="${not empty dataVo and empty dataVo.dailyMaxAccuAmount}"><c:set value="checked=\"checked\"" var="maxAmountUnlimit_checked" /></c:if>
                        &nbsp;&nbsp;&nbsp;<input type="checkbox" name="maxAmountUnlimit" id="maxAmountUnlimit" value="Y" ${maxAmountUnlimit_checked} onclick="jsMaxAmountInit();" /> <label for="maxAmountUnlimit">최대한도 제한없음</label>
                    </td>
                </tr>
                <tr>
                    <th>유효기간</th>
                    <td>
                        적립일로부터 <span class="tx_red_b">${expDate.expDt}</span> 년
                        <input type="hidden" value="${expDate.expDt}" name="expDt" id="expDt" />
                        <span class="tx_blue_s mar_l20">* 유효기간은 유효기간 설정에서 일괄 적용됩니다.</span>
                    </td>
                </tr>
                <tr>
                    <th><span class="tx_red tx_b">*</span> 사용여부</th>
                    <td>
                        <c:if test="${dataVo.useYn eq 'N'}"><c:set value="checked=\"checked\"" var="useYn_N_checked" /></c:if>
                        <input type="radio" name="useYn" id="useYn_Y" value="Y" checked="checked" /> <label for="useYn_Y">사용</label>
                        <input type="radio" name="useYn" id="useYn_N" value="N" ${useYn_N_checked} /> <label for="useYn_N">미사용</label>
                    </td>
                </tr>
                <c:if test="${actionUrl eq 'updateMileageAction'}">
                    <tr>
                        <th>등록자</th>
                        <td>${dataVo.regId}</td>
                    </tr>
                    <tr>
                        <th>등록일시</th>
                        <td><fmt:formatDate value="${dataVo.regDtm}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
                    </tr>
                    <c:if test="${not empty dataVo.modDtm}">
                        <tr>
                            <th>수정자</th>
                            <td>${dataVo.modId}</td>
                        </tr>
                        <tr>
                            <th>수정일시</th>
                            <td><fmt:formatDate value="${dataVo.modDtm}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
                        </tr>
                    </c:if>
                </c:if>
            </tbody>
        </table>
    </fieldset>
    <p class="mar_t10">※ 관리자가 직접 마일리지를 부여해야 하는 경우는 회원관리에서 회원을 조회한 후 마일리지 정보에서 입력하시기 바랍니다.</p>
    <!-- //등록 -->
    <div>
        <c:if test="${actionUrl eq 'updateMileageAction'}">
            <!-- <div class="float_l mar_t20">
                <button class="blue" type="button" onclick="location.href='PD_historyPop.do?mileageCdLog=${dataVo.mileageCd}'">변경이력보기</button>
            </div> -->
        </c:if>
        <div class="float_r mar_t20">
            <button class="blue">${actionNm}</button>
            <c:if test="${actionUrl eq 'updateMileageAction'}">
                <button class="blue" type="button" onclick="jsDelete();">삭제</button>
            </c:if>
            <button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">취소</button>
        </div>
    </div>
</form>

</div>
</body>
</html>