<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<op:jsTag type="spi" items="jquery, extjs, form, validate" />
<script type="text/javascript">

    $().ready(function() {

        $("#dataForm").validate({
            rules: {
                ctgCd: {required: true, alphaupper: true, minlength: 1, maxlength: 10}
            },
            submitHandler: function(form) {
                $(form).ajaxSubmit({
                    url      : "INC_ctgUpdateAction.do",
                    type     : "POST",
                    success  : function(response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
                                cdListLoad(BoxListConfig, $("#langCode").val(), $("#grpCd").val(), $("#ctgCd").val());
                                $('#DetailView').load( "INC_ctgUpdateForm.do", {
                                    langCode : $("#langCode").val(),
                                    grpCd : $("#grpCd").val(),
                                    ctgCd : $("#ctgCd").val()
                                });
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

    var jsDelete = function() {

        if ( confirm("정말 삭제 하시겠습니까?") ) {
            $('#dataForm').ajaxSubmit({
                url      : "INC_ctgDeleteAction.do",
                type     : "POST",
                success  : function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            document.location.reload();
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

    var jsList = function() {
        $('#DetailView').html("&nbsp;&nbsp;<span class='ico-pnt'>좌측의 코드 실렉터명을 선택하세요.</span>");
    };
</script>

<form id="dataForm">
    <input type="hidden" id="langCode" name="langCode" value="${param.langCode}" />
    <input type="hidden" id="grpCd" name="grpCd" value="${param.grpCd}" />

    <!-- 코드 실렉터 수정-->
    <div class="regi_sel">
        <h2>코드 실렉터 수정</h2>
        <fieldset>
        <legend>수정하기</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 수정하기 </caption>
            <colgroup>
                <col width="30%" />
                <col width="70%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="bu_name">실렉트코드 <span class="tx_red_s">*</span></label></th>
                    <td><input type="text" name="ctgCd" id="ctgCd" value="${param.ctgCd}" readonly="readonly" size="10" class="w60_p"/>
                    <p class="mar_t5">(최대 영문 대문자 10)</p></td>
                </tr>
                <tr>
                    <th>대상 개별코드</th>
                    <td>
                        <c:forEach items="${dataVo.prvList}" var="prvVo">
                            <input type="checkbox" name="prvCds" id="_${prvVo.prvCd}" value="${prvVo.prvCd}" class="checkbox"
                                <c:forEach items="${dataVo.prvCds}" var="prvCd">
                                    <c:if test="${prvCd == prvVo.prvCd}">checked="checked"</c:if>
                                </c:forEach> />
                            <label for="_${prvVo.prvCd}">${prvVo.prvNm}</label><br/>
                        </c:forEach>
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>
        <p class="tx_r mar_t10 mar_b20">
            <a href="#"><button type="submit" class="blue">수정</button></a>
            <a href="#"><button type="button" onclick="jsDelete();" class="blue">삭제</button></a>
            <a href="#"><button type="button" onclick="jsList();" class="blue">취소</button></a>
        </p>
    </div>
    <!-- //코드 실렉터 수정-->
</form>
