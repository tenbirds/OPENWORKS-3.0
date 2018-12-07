<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<script type="text/javascript">
//<CDATA[[
    $().ready(function() {
        $("#userGradNm").focus();
        $("#dataForm").validate({
            <valid:script type="jquery" />,
            submitHandler: function(form) {
//                $.post("ND_CheckGradeCd.do", {
//                    userGradCode : $("#userGradCode").val()
//                    }, function(response) {
//                        if (!response.result) {
//                            jsWarningBox("중복된 코드값이 있습니다.");
//                            return false;
//                        }
//                    }
//                );
                $(form).ajaxSubmit({
                    url      : "ND_UpdateAction.do",
                    type     : "post",
                    dataType : "json",
                    success  : function(response) {
                        if (response.result) {
                            jsSuccessBox(response.message);
                        } else { 
                            jsWarningBox(response.message);
                        }
                    }
                });
            }
        });
    });
//]]>
</script>

<form id="dataForm" method="post" action="ND_UpdateAction.do">

    <input type="hidden" name="prevUserGradCd" value="${dataVo.userGradCode}" />

    <h4 class="tx_13">${dataVo.userGradNm}</h4>

    <table class="boardWrite" summary="${dataVo.userGradNm} - 회원 등급 수정" >
        <caption class="title">${dataVo.userGradNm} - 회원 등급 수정</caption>
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>   
        <tr>
            <th style="width:80px">회원등급코드<span class="tx_red tx_b">*</span></th>
            <td colspan="3">
                ${dataVo.userGradCode}
                <input type="hidden" id="userGradCode" name="userGradCode" value="${dataVo.userGradCode}" maxlength="20" style="width:30%;"/>
<!--                 <button type="button" class="blue mar_l5 mar_b5" onclick="jsCheckCode();">중복확인</button> -->
<!--                 <p class="tx_blue_s">영문, 숫자 20자이하</p> -->
            </td>
        </tr>

        <tr>
            <th style="width:80px">회원등급명<span class="tx_red tx_b">*</span></th>
            <td colspan="3">
                <input type="text" id="userGradNm" name="userGradNm" value="${dataVo.userGradNm}" maxlength="25" style="width:80%;"/> 
                <p class="tx_blue_s">한글 25자 이하</p>
            </td>
        </tr>

        <tr>
            <th>회원 등급 설명</th>
            <td colspan="3">
                <textarea id="userGradDc" name="userGradDc" rows="3" cols="25" style="width:80%;">${dataVo.userGradDc}</textarea>
                <p class="tx_blue_s">한글 50자 이하</p>
            </td>
        </tr>

        <tr>
            <th>사용 여부<span class="tx_red tx_b">*</span></th>
            <td colspan="3"><input type="radio" name="useYn" id="useYn_Y" value="Y" class="radio"
                    <c:if test="${dataVo.useYn eq 'Y'}">checked="checked"</c:if> />
                    <label for="useYn_Y">사용</label>
                <input type="radio" name="useYn" id="useYn_N" value="N" class="radio"
                    <c:if test="${dataVo.useYn eq 'N'}">checked="checked"</c:if> />
                    <label for="useYn_N">미사용</label>
                <div class="tx_blue_s">미사용 선택 시 해당 회원등급의 접근이 제한됩니다.</div>
            </td>
        </tr>

        <tr>
            <th>등록자</th>
            <td>${dataVo.registNm}</td>
            <th>등록일시</th>
            <td>${dataVo.registDt}</td>
        </tr>

        <tr>
            <th>수정자</th>
            <td>${dataVo.updtNm}</td>
            <th>수정일시</th>
            <td>${dataVo.updtDt}</td>
        </tr>

        </tbody>
    </table>


    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button class="w_blue mar_l5 mar_b5">수정</button></li>
        </ul>
    </div>

</form>
