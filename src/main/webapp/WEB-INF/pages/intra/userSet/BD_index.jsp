<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<op:jsTag type="spi" items="form, ui" />
<op:jsTag type="openworks" items="ui" />
<title>회원가입정보설정관리</title>

<script type="text/javascript">
    $().ready(function(){
        //사용여부 필수항목지정 CheckBox 클릭시.
        $('.chkItem').click(function(){
            var checked = $(this).attr('checked');
            var code = $(this).attr('name').substr(2, 4);

            if(checked){
                $('#itemLabel' + code).html('<span class="tx_red_s">* </span>');
            }else{
                $('#itemLabel' + code).html('<span class="tx_red_s"></span>');
            }
        });

        $('#chkYnPer').click(function(){
            var checked = $(this).attr('checked');

            if(checked){ $('#chkYnPer').val('Y'); }
            else{ $('#chkYnPer').val('N'); }
        });

        $('#chkYnCom').click(function(){
            var checked = $(this).attr('checked');

            if(checked){ $('#chkYnCom').val('Y'); }
            else{ $('#chkYnCom').val('N'); }
        });
        /* 2016.12.01 추가 */
        $('#chkYnPbl').click(function(){
            var checked = $(this).attr('checked');

            if(checked){ $('#chkYnPbl').val('Y'); }
            else{ $('#chkYnPbl').val('N'); }
        });
    });

    //수정
    var updateAction = function(){
        if(confirm("회원가입정보 설정 변경 시 사용중인 시스템에 심각한 문제를 발생시킬 수 있습니다. 신중히 고려하여 변경하시길 바랍니다.")){
            jsInsert();
            dataString = $("#form").serialize();
            $.ajax({
                type: "POST",
                url: "/intra/userSet/ND_updateAction.do",
                data: dataString,
                success: function(response){
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.updateOk);
                            document.location.href = "BD_index.do";
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
        return false;
    };

    //저장 버튼 클릭 후 사용여부 코드 저장
    var jsInsert = function(){
        var code;

        $('input[name^=r_]:checked').each(function(i){
            code = $(this).attr('name').substr(2, 4);
            if($(this).val() == '1002'){
                $('#paramUseYnCodes' + code).val($(this).val());
            }else{
                if($('#cYN_' + code).attr('checked')){
                    $('#paramUseYnCodes' + code).val($('#cYN_' + code).val());
                }else{
                    $('#paramUseYnCodes' + code).val($(this).val());
                }
            }
        });
    };

    //사용여부 Radio버튼 클릭시 Event
    var clickUse = function(code, use){
        if(code == 1010 || code == 2007 || code == 4010){
            //사용여부 사용 클릭시
            if(use == 'Y'){
                $('#cYN_' + code).attr('disabled', false);
                $('#cYN_' + code).attr('checked', true);
            }
            //사용여부 미사용 클릭
            if(use == 'N'){
                $('#cYN_' + code).attr('disabled', 'disabled');
                $('#cYN_' + code).attr('checked', false);
                $('#itemLabel' + code).html('<span class="tx_red_s"></span>');
            }
        }else{
            //사용여부 사용 클릭시
            if(use == 'Y'){
                $('#cYN_' + code).attr('disabled', false);
            }
            //사용여부 미사용 클릭시
            if(use == 'N'){
                $('#cYN_' + code).attr('disabled', 'disabled');
                $('#cYN_' + code).attr('checked', false);
                $('#itemLabel' + code).html('<span class="tx_red_s"></span>');
            }
        }
    };

    //회원 선택 여부 저장
    var jsUserSelectSave = function(){
        var selectVal = new Array();

        selectVal[0] = $('#chkYnPer').val();
        selectVal[1] = $('#chkYnCom').val();
        selectVal[2] = $('#chkYnPbl').val();

        if(confirm("저장하시겠습니까?")){
            $.ajax({
                type: "POST",
                url: "/intra/userSet/ND_userSelectUpdate.do",
                data: { selectVal : selectVal },
                success: function(response){
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.processOk);
                            document.location.href = "BD_index.do";
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
    };
</script>
</head>

<body>
<ul class="blet">
    <li>회원가입정보설정관리는 시스템 구축시 회원가입정보 설정을 위해 설계된 관리시스템입니다.</li>
    <li><span class="tx_blue_n">구축 후 또는 운영 중 회원가입정보 설정을 변경</span>할 경우 가입정보 중 다른 시스템 또는 다른 기능에서 가입정보를 사용하고 있는 경우 <span class="tx_blue_n">심각한 문제가 발생</span>할 수 있습니다.</li>
    <li>회원가입정보 설정을 변경할 때에는 다른 <span class="tx_blue_n">프로그램과의 연관관계를 고려</span>하여 신중히 <span class="tx_blue_n">사용</span>하시기 바랍니다.</li>
</ul>

<!-- 탭 -->
<ul class="tab">
    <li><a href="BD_index.do" class="on">기본항목설정</a></li>
    <li><a href="BD_userInfoInterest.do" >스토어항목설정</a></li>
    <li><a href="BD_userInfoLog.do" >가입정보변경이력</a></li>
</ul>
<!-- //탭 -->

<form name="userSelectForm" id="userSelectForm">
<div class="blue_box_tx">
    <fieldset>
        <legend>회원선택을 해주세요.</legend>
        <span class="tx_b">회원선택 : </span>
        <input type="checkbox" name="chkYnPer" id="chkYnPer" value="${userSelect.P}"<c:if test="${userSelect.P eq 'Y'}"> checked="checked"</c:if> />
        <label for="per">개인회원</label>
        <input type="checkbox" name="chkYnCom" id="chkYnCom" value="${userSelect.C}"<c:if test="${userSelect.C eq 'Y'}"> checked="checked"</c:if> />
        <label for="busi">사업자회원</label>
        <!-- 2016.11.30 공공기관 정보설정관리 추가 -->
        <input type="checkbox" name="chkYnPbl" id="chkYnPbl" value="${userSelect.L}"<c:if test="${userSelect.L eq 'Y'}"> checked="checked"</c:if> />
        <label for="pbl">공공기관</label>
        &nbsp;&nbsp;<button type="button" onclick="jsUserSelectSave();" class="s_blue">저장</button>
    </fieldset>
</div>
</form>

<form name="form" id="form" method="post">
    <input type="hidden" name="iemTy" id="iemTy" value="${param.iemTy}" />
    <!-- 변경된 항목 이력을 남기기 위한... -->
    <c:forEach var="useNm" items="${listUseNm}" varStatus="status">
        <input type="hidden" name="useYnCodes" value="${useNm.useYnCode}" />
        <input type="hidden" name="useYnNms" value="${useNm.useYnNm}" />
        <c:if test="${status.first}">
        <input type="hidden" name="langCode" value="${useNm.langCode}" />
        </c:if>
    </c:forEach>

    <div class="po_rel">
        <!-- 내용 -->
        <fieldset>
        <legend>사용여부설정하기</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="사용여부를 체크하실 수 있습니다.">
            <caption class="hidden"> 사용여부설정 </caption>
            <colgroup>
                <col width="4%" />
                <col width="18%" />
                <col width="" />
            </colgroup>
            <thead>
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;">설정항목</th>
                    <th style="text-align:center;font-weight:bold;">사용여부</th>
                </tr>
            </thead>
            <c:if test="${userSelect.P eq 'Y'}">
                <tbody>
                <c:set var="index" value="${listCount.userCount}" />
                    <c:forEach var="item" items="${list}" varStatus="status">
                        <c:if test="${item.userTy eq 'P'}">
                            <tr>
                                <!--  개인회원용 th rowspan 설정 -->
                                <c:if test="${status.first}">
                                    <th rowspan="${listCount.userCount}" style="text-align:center;font-weight:bold;" class="line_r"><label for="sub">개인<br />회원용</label></th>
                                </c:if>
                                <th><span id="itemLabel${item.iemCd}" class="tx_red_s"><c:if test="${item.useYnCode eq '1003'}" >* </c:if></span>${item.itemNm}</th>
                                <td<c:if test="${(index-status.index) % 2 eq 0}"> style="background-color:#fcfadd;"</c:if>>
                                    <!--사용여부코드 1001:사용  1002:미사용  1003:필수항목지정  -->
                                    <input type="radio" name="r_${item.iemCd}" value="1001"
                                        <c:if test="${'1001' eq item.useYnCode or '1003' eq item.useYnCode}"> checked="checked"</c:if>
                                        onclick="clickUse(${item.iemCd},'Y');" />
                                    <label for="use">사용</label>&nbsp;&nbsp;
                                    <input type="radio" name="r_${item.iemCd}" value="1002"
                                        <c:if test="${'1002' eq item.useYnCode}"> checked="checked"</c:if>
                                        onclick="clickUse(${item.iemCd},'N');"/>
                                    <label for="unuse">미사용</label>&nbsp;&nbsp;
                                    <c:if test="${item.useItemCd eq 'ALL'}">
                                        <input type="checkbox" name="c_${item.iemCd}" id="cYN_${item.iemCd}" value="1003" class="checkbox chkItem"
                                            <c:if test="${item.useYnCode eq '1003'}"> checked="checked"</c:if><c:if test="${item.useYnCode eq '1002'}"> disabled="disabled"</c:if> />
                                        <label for="just">필수항목 지정</label>
                                    </c:if>

                                    <!-- 변경된 항목 이력을 남기기 위한 항목 -->
                                    <input type="hidden" name="paramItemCodes" value="${item.iemCd}" />
                                    <input type="hidden" name="itemNms" value="${item.itemNm}" />
                                    <input type="hidden" name="paramUseYnCodes" id="paramUseYnCodes${item.iemCd}" />
                                    <input type="hidden" name="beforeYnCodes" value="${item.useYnCode}" />
                                    <input type="hidden" name="userTys" value="${item.userTy}" />
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </c:if>

            <c:if test="${userSelect.C eq 'Y'}">
                <tbody>
                    <c:forEach var="item" items="${list}" varStatus="status">
                        <c:if test="${item.userTy eq 'C'}">
                            <tr>
                                <!-- 사업자회원용 th rowspan 설정 -->
                                <c:if test="${status.index eq listCount.userCount}">
                                    <th rowspan="${listCount.companyCount}" style="text-align:center; font-weight:bold;" class="line_r"><label for="sub">사업자<br />회원용</label></th>
                                </c:if>
                                <th><span id="itemLabel${item.iemCd}" class="tx_red_s"><c:if test="${item.useYnCode eq '1003'}" >* </c:if></span>${item.itemNm}</th>
                                <td<c:if test="${(index-status.index)%2 eq 0}"> style="background-color:#fcfadd;"</c:if>>
                                    <!--사용여부코드 1001:사용  1002:미사용  1003:필수항목지정  -->
                                    <input type="radio" name="r_${item.iemCd}" value="1001"
                                        <c:if test="${'1001' eq item.useYnCode or '1003' eq item.useYnCode}"> checked="checked"</c:if>
                                        onclick="clickUse(${item.iemCd},'Y');" />
                                    <label for="use">사용</label>&nbsp;&nbsp;
                                    <input type="radio" name="r_${item.iemCd}" value="1002"
                                        <c:if test="${'1002' eq item.useYnCode}"> checked="checked"</c:if>
                                        onclick="clickUse(${item.iemCd},'N');"/>
                                    <label for="unuse">미사용</label>&nbsp;&nbsp;
                                    <c:if test="${item.useItemCd eq 'ALL'}">
                                        <input type="checkbox" name="c_${item.iemCd}" id="cYN_${item.iemCd}" value="1003" class="checkbox chkItem"
                                            <c:if test="${item.useYnCode eq '1003'}"> checked="checked"</c:if><c:if test="${item.useYnCode eq '1002'}"> disabled="disabled"</c:if> />
                                        <label for="just">필수항목 지정</label>
                                    </c:if>

                                    <!-- 변경된 항목 이력을 남기기 위한 항목 -->
                                    <input type="hidden" name="paramItemCodes" value="${item.iemCd}" />
                                    <input type="hidden" name="itemNms" value="${item.itemNm}" />
                                    <input type="hidden" name="paramUseYnCodes" id="paramUseYnCodes${item.iemCd}" />
                                    <input type="hidden" name="beforeYnCodes" value="${item.useYnCode}" />
                                    <input type="hidden" name="userTys" value="${item.userTy}" />
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </c:if>
            <!-- 2016.11.30 공공기관 추가 -->
            <c:if test="${userSelect.L eq 'Y'}">
                <tbody>
                    <c:forEach var="item" items="${list}" varStatus="status">
                        <c:if test="${item.userTy eq 'L'}">
                            <tr>
                            		<!-- 왜 18 차이가 나는건지?? -->
                            		<c:if test="${status.index eq listCount.publicCount + '18'}">
                                    <th rowspan="${listCount.publicCount}" style="text-align:center; font-weight:bold;" class="line_r"><label for="sub">공공<br />기관용</label></th>
                                </c:if>
                                <th><span id="itemLabel${item.iemCd}" class="tx_red_s"><c:if test="${item.useYnCode eq '1003'}" >* </c:if></span>${item.itemNm}</th>
                                <td<c:if test="${(index-status.index)%2 eq 0}"> style="background-color:#fcfadd;"</c:if>>
                                    <!--사용여부코드 1001:사용  1002:미사용  1003:필수항목지정  -->
                                    <input type="radio" name="r_${item.iemCd}" value="1001"
                                        <c:if test="${'1001' eq item.useYnCode or '1003' eq item.useYnCode}"> checked="checked"</c:if>
                                        onclick="clickUse(${item.iemCd},'Y');" />
                                    <label for="use">사용</label>&nbsp;&nbsp;
                                    <input type="radio" name="r_${item.iemCd}" value="1002"
                                        <c:if test="${'1002' eq item.useYnCode}"> checked="checked"</c:if>
                                        onclick="clickUse(${item.iemCd},'N');"/>
                                    <label for="unuse">미사용</label>&nbsp;&nbsp;
                                    <c:if test="${item.useItemCd eq 'ALL'}">
                                        <input type="checkbox" name="c_${item.iemCd}" id="cYN_${item.iemCd}" value="1003" class="checkbox chkItem"
                                            <c:if test="${item.useYnCode eq '1003'}"> checked="checked"</c:if><c:if test="${item.useYnCode eq '1002'}"> disabled="disabled"</c:if> />
                                        <label for="just">필수항목 지정</label>
                                    </c:if>

                                    <!-- 변경된 항목 이력을 남기기 위한 항목 -->
                                    <input type="hidden" name="paramItemCodes" value="${item.iemCd}" />
                                    <input type="hidden" name="itemNms" value="${item.itemNm}" />
                                    <input type="hidden" name="paramUseYnCodes" id="paramUseYnCodes${item.iemCd}" />
                                    <input type="hidden" name="beforeYnCodes" value="${item.useYnCode}" />
                                    <input type="hidden" name="userTys" value="${item.userTy}" />
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </c:if>            
        </table>
        </fieldset>
        <!-- //내용 -->
        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><a href="#" onclick="updateAction();"><button type="button" class="blue">저장</button></a></li>
                <li><button type="reset" class="blue">취소</button></li>
            </ul>
        </div>
        <!-- //버튼 -->
    </div>
</form>
</body>
</html>