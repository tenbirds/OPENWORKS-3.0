<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ page import="zes.core.lang.*" %>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
    var confTabz;

    $().ready(function(){
        $("#authConfigForm").validate({
            submitHandler: function(form) {
                $(form).ajaxSubmit({
                    url   : "JR_updateAction.do",
                    type     : "POST",
                    dataType : "json",
                    success  : function(result) {
                        jsMsgBox("요청하신 정보를 성공적으로 수정했습니다.");
                        $("#authResult").html("최종수정: " + result.value);
                    }
                });
            }
        });
    });

    var jsUpdateAction = function(){
        $.post("ND_boardconf.update2.do", {
            bbsCd : $("input[name=bbsCd]").val(),
            gubunCd : <%=BoardConfConstant.GUBUN_CD_AUTH%>,
            authCdList : $("#authCdList").val(),
            authCdView : $("#authCdView").val(),
            authCdWrite : $("#authCdWrite").val(),
            authCdReply : $("#authCdReply").val(),
            authCdCmt : $("#authCdCmt").val()
        }, function(response){
            if(isNaN(response)){
                alert(response);
            }else{
                alert("요청정보를 성공적으로 수정했습니다.");
            }
            jsReloadTab();
        });
    };
</script>

<!-- 캡션 영역 시작 -->
<div class="bbs-caption">
    <div class="caption-right"> 
        <span id="authResult" class="result"></span>
    </div>
</div>
<!-- 캡션 영역 끝 -->

<form id="authConfigForm">
    <input type="hidden" name="domainCd" value="${param.domainCd}" />
    <input type="hidden" name="bbsCd" value="${param.bbsCd}" />
    <input type="hidden" name="gubunCd" value="<%= BoardConfConstant.GUBUN_CD_AUTH %>" />
    <input type="hidden" name="authIds" id="authIds" value="" />

    <fieldset>
        <legend>권한설정</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="권한설정 정보를 표시" >
            <caption>권한설정</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody> 
                <tr>
                    <th><label for="authCdList">목록조회 권한</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <op:code id="authCdList" grpCd="55" defaultLabel="==제한없음==" option="" defaultValues="${dataVo.authCdList}" />
                    </td>
                </tr>
                <tr>
                    <th><label for="authCdView">상세조회 권한</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <op:code id="authCdView" grpCd="55" defaultLabel="==제한없음==" defaultValues="${dataVo.authCdView}" />
                    </td>
                </tr>
                <tr>
                    <th><label for="authCdWrite">글 작성 권한</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <op:code id="authCdWrite" grpCd="55" defaultLabel="==제한없음==" defaultValues="${dataVo.authCdWrite}" />
                    </td>
                </tr>
                <tr>
                    <th><label for="authCdReply">댓글 작성 권한</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <op:code id="authCdReply" grpCd="55" defaultLabel="==제한없음==" defaultValues="${dataVo.authCdReply}" />
                    </td>
                </tr>
                <tr>
                    <th><label for="authCdCmt">의견글사용 권한</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <op:code id="authCdCmt" grpCd="55" defaultLabel="==제한없음==" defaultValues="${dataVo.authCdCmt}" />
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="button" id="btnSubmit" value="저장" class="w_blue mar_r5" onclick="jsUpdateAction()" /></li>
            <li><input type="reset" id="btnCancel" value="취소" class="w_blue mar_r5" /></li>
            <li><input type="button" id="btnList" value="목록" class="blue" onclick="jsList();" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

</form>