<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<op:jsTag type="spi" items="jquery, extjs, form, validate" />
<script type="text/javascript">

    $().ready(function() {

        $("#ctgCd").focus();

        $("#dataForm").validate({
            rules: {
                ctgCd: {required: true, alphaupper: true, minlength: 1, maxlength: 10}
            },
            submitHandler: function(form) {
                $(form).ajaxSubmit({
                    url      : "INC_ctgInsertAction.do",
                    type     : "POST",
                    success  : function(response) {
                        if (response == "DUPLE") {
                            jsWarningBox("입력하신 실렉트코드가 이미 존재합니다.");
                            $("#ctgCd").select();
                        } else {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.insertOk);
                                    ctgListLoad(BoxListConfig, $("#langCode").val(), $("#grpCd").val());
                                    cdListLoad(BoxListConfig, $("#langCode").val(), $("#grpCd").val(), $("#ctgCd").val());
                                    $('#DetailView').load( "INC_ctgUpdateForm.do", {
                                        langCode : $("#langCode").val(),
                                        grpCd : $("#grpCd").val(),
                                        ctgCd : $("#ctgCd").val()
                                    });
                                    $("#ctgIns").show();
                                } else {
                                    jsErrorBox(Message.msg.processFail);
                                }
                            } catch (e) {
                                jsSysErrorBox(response, e);
                                return;
                            }
                        }
                    }
                });
            }
        });
    });

    var jsList = function() {
        $('#DetailView').html("&nbsp;&nbsp;<span class='ico-pnt'>좌측의 코드 실렉터명을 선택하세요.</span>");
    };
</script>

<form id="dataForm">
    <input type="hidden" id="langCode" name="langCode" value="${param.langCode}" />
    <input type="hidden" id="grpCd" name="grpCd" value="${param.grpCd}" />

    <!-- 코드 실렉터 등록-->
    <div class="regi_sel">
        <h2>코드 실렉터 등록</h2>
        <fieldset>
        <legend>등록하기</legend>
        <table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 등록하기 </caption>
            <colgroup>
                <col width="30%" />
                <col width="70%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="bu_name">실렉트코드 <span class="tx_red_s">*</span></label></th>
                    <td><input type="text" name="ctgCd" id="ctgCd" size="10" class="w60_p" value="" />
                    <p class="mar_t5">(영문 대문자 최대  10자)</p></td>
                </tr>
                <tr>
                    <th>대상 개별코드</th>
                    <td>
                        <c:forEach items="${dataVo.prvList}" var="prvVo">
                                        <input type="checkbox" name="prvCds" id="_${prvVo.prvCd}" value="${prvVo.prvCd}" class="checkbox" />
                            <label for="_${prvVo.prvCd}">${prvVo.prvNm}</label><br/>
                        </c:forEach>
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>
        <p class="tx_r mar_t10 mar_b20">
            <a href="#"><button type="submit" class="blue">등록</button></a>
            <a href="#"><button type="button" onclick="jsList();" class="blue">취소</button></a>
        </p>
    </div>
    <!-- //코드 실렉터 등록-->
</form>
