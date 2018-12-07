<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<script type="text/javascript">
//<CDATA[[
    $().ready(function() {
        $("#domainNm").focus();
        $("#dataForm").validate({
            <valid:script type="jquery" />,
            submitHandler: function(form) {
                $.post("ND_CheckGradeCd.do", {
                    userGradCode : $("#userGradCode").val()
                    }, function(response) {
                        if (response.result) {
                            $(form).ajaxSubmit({
                                url      : "ND_InsertAction.do",
                                type     : "POST",
                                dataType : "json",
                                success  : function(response) {
                                    if (response.result) {
                                        jsSuccessBox(response.message);
                                        document.location.reload();
                                    } else { 
                                        jsErrorBox(response.message);
                                    }
                                }
                            });
                        } else {
                            jsWarningBox("중복된 코드값이 있습니다.");
                            return false;
                        }
                    }
                );
            }
        });
    });
//]]>
</script>

<form id="dataForm">

    <h4 class="tx_13">신규 등록</h4>

    <table class="boardWrite" summary="회원 등급 등록" >
        <caption class="title">신규 등록</caption>
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tbody>

        <tr>
            <th>회원등급코드<span class="tx_red tx_b">*</span></th>
            <td>
                <input type="text" id="userGradCode" name="userGradCode" value="" maxlength="20" style="width:30%;" />
                <button type="button" class="blue mar_l5 mar_b5" onclick="jsCheckCode();">중복확인</button>
                <p class="tx_blue_s">영문, 숫자 20자이하</p>
            </td>
        </tr>

        <tr>
            <th>회원등급명<span class="tx_red tx_b">*</span></th>
            <td>
                <input type="text" id="userGradNm" name="userGradNm" value="" maxlength="25" style="width:80%;"/>
                <p class="tx_blue_s">한글 25자 이하</p>
            </td>
        </tr>

        <tr>
            <th>회원등급설명</th>
            <td>
                <textarea id="userGradeDesc" name="userGradeDesc" rows="3" cols="25" style="width:80%;"></textarea>
                <p class="tx_blue_s">한글 50자 이하</p>
            </td>
        </tr>

        <tr>
            <th>사용 여부<span class="tx_red tx_b">*</span></th>
            <td>
                <input type="radio" id="useYn_Y" name="useYn" value="Y" class="radio" checked="checked" />
                <label for="useYn_Y">사용</label>
                
                <input type="radio" id="useYn_N" name="useYn" value="N" class="radio" />
                <label for="useYn_N">미사용</label>

                <p class="tx_blue_s">미사용 선택 시 해당 회원등급의 접근이 제한됩니다.</p>
            </td>
        </tr>
        </tbody>
    </table>


    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button class="w_blue mar_l5 mar_b5">등록</button></li>
        </ul>
    </div>

</form>
