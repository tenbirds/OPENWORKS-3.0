<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>

<html>
<head>
    <title>전문가정보 수정</title>
   
    <op:jsTag type="spi" items="validate,ui,form,highlight,extjs,colorbox," />
    <op:jsTag type="openworks" items="form,validate" />
    
    <!-- 기능별 스크립트 정의 -->
    
    <script type="text/javascript">
    //<CDATA[[

        $().ready(function() {
            $("#dataForm").validate({  
                rules : {
                    advrtsReqestEntrpsNm : { required : true },    //광고의뢰업체명
                    advrtsChargerNm : { required : true },    //담당자명
                    advrtsChargerTelnos : { required : false, number : true },    //담당자연락처
                    advrtsChargerMbtlnums : { required : false, number : true },    //담당자휴대전화번호
                    advrtsChargerEmail : { required : false, nowhitespace: true, email : true }    //담당자이메일주소
                },
                submitHandler: function(form) {
                    if($("#advrtsChargerTelno1").val() != '' && $("#advrtsChargerTelno2").val() != '' && $("#advrtsChargerTelno3").val() != ''){
                        $("#advrtsChargerTelno").val($("#advrtsChargerTelno1").val()+"-"+$("#advrtsChargerTelno2").val()+"-"+$("#advrtsChargerTelno3").val());
                    } else if($("#advrtsChargerTelno1").val() != '' || $("#advrtsChargerTelno2").val() != '' || $("#advrtsChargerTelno3").val() != ''){
                        if($("#advrtsChargerTelno1").val() == ''){
                            $("#advrtsChargerTelno1").focus(); 
                        } else if($("#advrtsChargerTelno2").val() == ''){
                            $("#advrtsChargerTelno2").focus();
                        } else if($("#advrtsChargerTelno3").val() == ''){
                            $("#advrtsChargerTelno3").focus();
                        }
                        jsWarningBox("전화번호를 입력해주세요.");
                        return;
                    }
                    if($("#advrtsChargerMbtlnum1").val() != '' && $("#advrtsChargerMbtlnum2").val() != '' && $("#advrtsChargerMbtlnum3").val() != ''){
                        $("#advrtsChargerMbtlnum").val($("#advrtsChargerMbtlnum1").val()+"-"+$("#advrtsChargerMbtlnum2").val()+"-"+$("#advrtsChargerMbtlnum3").val());
                    } else if($("#advrtsChargerMbtlnum1").val() != '' || $("#advrtsChargerMbtlnum2").val() != '' || $("#advrtsChargerMbtlnum3").val() != ''){
                        if($("#advrtsChargerMbtlnum1").val() == ''){
                            $("#advrtsChargerMbtlnum1").focus(); 
                        } else if($("#advrtsChargerMbtlnum2").val() == ''){
                            $("#advrtsChargerMbtlnum2").focus();
                        } else if($("#advrtsChargerMbtlnum3").val() == ''){
                            $("#advrtsChargerMbtlnum3").focus();
                        }
                        jsWarningBox("핸드폰번호를 입력해주세요.");
                        return;
                    }
                    var numCheck = /[0-9_^\\s]$/i;
                    $(form).ajaxSubmit({
                        url      : "ND_UpdateAdvrtsAction.do",
                        type     : "post",
                        dataType : "text",
                        async    : false,
                        success  : function(response) {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.updateOk);
                                    jsList("BD_index.do","dataForm");
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
            settingValue(advrtsData);
        });// end ready

        advrtsData = [{column:'advrtsChargerTelno', values:'${dataVo.advrtsChargerTelno}', separation:'-'}
                     ,{column:'advrtsChargerMbtlnum', values:'${dataVo.advrtsChargerMbtlnum}', separation:'-'}];

        var settingValue = function(setData) {
            $.each(setData, function (i, item) {
                value = item.values.split(item.separation);
                $.each(value, function (j, item2) {
                    $("#"+item.column+(j+1)).val(item2);
                });
            });
        };

        //숫자외 입력불가
        function handlerNum(obj) {
            if((event.ctrlKey) || (event.shiftKey)) { 
                alert('해당 키를 사용할 수 없습니다.'); 
                event.returnValue = false;
                this.blur();
            } 
            
            if(((event.keyCode >= 48 && event.keyCode <= 57) ||   //숫자열 0 ~ 9 : 48 ~ 57
                   (event.keyCode >= 96 && event.keyCode <= 105) ||  //키패드 0 ~ 9 : 96 ~ 105
                    event.keyCode == 8  || event.keyCode == 46 ||    //BackSpace, Delete
                    event.keyCode == 37 || event.keyCode == 39 ||    //좌 화살표, 우 화살표
                    event.keyCode == 35 || event.keyCode == 36 ||    //End 키, Home 키
                    event.keyCode == 9  || event.keyCode == 45) && event.keyCode != 16)    {    //Tab 키
                   event.returnValue = true;
               }else{
                   event.returnValue = false;
               }
        };
        
        var jsAdvrtsDel = function(el){
            <c:if test="${dataVo.deleteAt ne 'Y'}">
                if(confirm("해당 광고주를 미사용처리 하시겠습니까?")){
                    $("#del_yn").val("Y");
                }else{
                    return;
                }
            </c:if>
            <c:if test="${dataVo.deleteAt eq 'Y'}">
                if(confirm("해당 광고주를 사용처리 하시겠습니까?")){
                    $("#del_yn").val("N");
                }else{
                    return;
                }
            </c:if>

            if($("#del_yn").val() != "" || $("#del_yn") != null){
                $("#dataForm").ajaxSubmit({
                    url      : "ND_UpdateAdvrtsAction.do",
                    type     : "post",
                    dataType : "text",
                    async    : false,
                    success  : function(response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
                                jsList("BD_index.do","dataForm");
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

        var jsSubmit = function() {
            $("#dataForm").submit();
        };
    //]]>
    </script>
</head>

<body>
    <form id="dataForm" name="dataForm" method="post" action="">
        <input type="hidden" name="q_currPage" id="q_currPage" value="${param.q_currPage}" />           <!-- 페이지 유지를 위해 목록에서 넘어온값으로 세팅 -->
        <input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${param.q_rowPerPage}" />     <!-- 페이지 유지를 위해 목록에서 넘어온값으로 세팅 -->
        <input type="hidden" name="q_expert_nm" id="q_advrtsReqestEntrpsNm" value="${param.q_advrtsReqestEntrpsNm}" />
        <input type="hidden" name="q_del_yn_sel" id="q_del_yn_sel" value="${param.q_del_yn_sel}" />
        <input type="hidden" name="advrtsClientSeq" id="advrtsClientSeq" value="${dataVo.advrtsClientSeq}" />
         <input type="hidden" name="del_yn" id="del_yn" value="" />        <!-- 삭제여부 -->

        <b>▷ 광고주 정보</b>
        <table class="boardWrite" summary="광고담당자정보 수정" >
            <caption class="title">광고담당자정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="40%" />
                <col width="15%" />
                <col width="30%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>의뢰업체명<span class="tx_red_s">*</span></th>
                    <td><input type="text" size="50" id="advrtsReqestEntrpsNm" name="advrtsReqestEntrpsNm" value="${dataVo.advrtsReqestEntrpsNm}" /></td>
                    <th>담당자 성명<span class="tx_red_s">*</span></th>
                    <td><input type="text" size="20" id="advrtsChargerNm" name="advrtsChargerNm" value="${dataVo.advrtsChargerNm}" /></td>
                </tr>
                <tr>
                    <th>담당자 전화번호<br /><span class="tx_blue_s">(숫자만입력)</span></th>
                    <td>
                        <input type="text" size="9" id="advrtsChargerTelno1" name="advrtsChargerTelnos" value="" maxlength="3"/>
                        <input type="text" size="9" id="advrtsChargerTelno2" name="advrtsChargerTelnos" value="" maxlength="4"/>
                        <input type="text" size="9" id="advrtsChargerTelno3" name="advrtsChargerTelnos" value="" maxlength="4"/>
                        <input type="hidden" id="advrtsChargerTelno" name="advrtsChargerTelno" value="" />
                    </td>
                    <th>담당자 휴대폰번호<br /><span class="tx_blue_s">(숫자만입력)</span></th>
                    <td>
                        <input type="text" size="9" id="advrtsChargerMbtlnum1" name="advrtsChargerMbtlnums" value="" maxlength="3"/>
                        <input type="text" size="9" id="advrtsChargerMbtlnum2" name="advrtsChargerMbtlnums" value="" maxlength="4"/>
                        <input type="text" size="9" id="advrtsChargerMbtlnum3" name="advrtsChargerMbtlnums" value="" maxlength="4"/>
                        <input type="hidden" id="advrtsChargerMbtlnum" name="advrtsChargerMbtlnum" value="" />
                    </td>
                </tr>
                </tr>
                <tr>
                    <th>담당자 이메일주소</th>
                    <td colspan="3"><input type="text" size="50" id="advrtsChargerEmail" name="advrtsChargerEmail" value="${dataVo.advrtsChargerEmail}" /></td>
                </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <c:if test="${dataVo.deleteAt eq 'Y'}">
                    <li><button type="button" onclick="jsAdvrtsDel(this);" class="blue">사용</button></li>
                </c:if>
                <c:if test="${dataVo.deleteAt ne 'Y'}">
                    <li><button type="button" onclick="jsAdvrtsDel(this);" class="blue">미사용</button></li>
                </c:if>
                <li><button type="button" onclick="jsSubmit();" class="blue">수정</button></li>
                <li><button type="button" onclick="jsList('BD_index.do','dataForm');" class="blue">목록</button></li>
            </ul>
        </div>
        <!-- //버튼 -->
    </form>

</body>
</html>