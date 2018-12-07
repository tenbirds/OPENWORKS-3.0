<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
    var confTabz;

    $().ready(function(){
        $("input[name=fileYn]").bind("click", {}, function(){
            if($(this).val() == "Y") $("#uploaderTypeDiv").show();
            else if($(this).val() == "N") $("#uploaderTypeDiv").hide();
        });

        $("#formConfigForm").validate({
            /*rules : {
                maxFileCnt : { required : true, maxlength : 2, number : true },
                maxFileSize : { required : true, maxlength : 4, number : true },
                totalFileSize : { required : true, maxlength : 4, number : true }
            },*/
            submitHandler: function(form){
                if($("input[name=fileYn]:checked").val() == "Y"){
                    if($.trim($("#maxFileCnt").val()) == "" || $.trim($("#maxFileCnt").val()) == 0){
                        //$("#resultMaxFileCnt").text("업로드 파일 최대 갯수는 필수입력 항목입니다.");
                        jsWarningBox("업로드 파일 최대 갯수는 필수입력 항목입니다.(1 이상)");
                        $("#maxFileCnt").focus();
                        return;
                    }
                    if($.trim($("#maxFileSize").val()) == ""){
                        //$("#resultMaxFileSize").text("파일당 최대 용량은 필수입력 항목입니다.");
                        jsWarningBox("파일당 최대 용량은 필수입력 항목입니다.");
                        $("#maxFileSize").focus();
                        return;
                    }
                    if($.trim($("#totalFileSize").val()) == ""){
                        //$("#resultTotalFileSize").text("업로드 전체 파일 용량은 필수입력 항목입니다.");
                        jsWarningBox("업로드 전체 파일 용량은 필수입력 항목입니다.");
                        $("#totalFileSize").focus();
                        return;
                    }
                }
                if($("input[name=bannedWordYn]:checked").val() == "Y"){
                    if($.trim($("#bannedWordCn").val()) == ""){
                        jsWarningBox("금칙어 목록은 필수입력 항목입니다.");
                        $("#bannedWordCn").focus();
                        return;
                    }
                }

                $(form).ajaxSubmit({
                    url     : "ND_boardconf.update2.do",
                    type    : "POST",
                    success : function(response){
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.processOk);
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        } catch (e) {
                            // 시스템 오류 발생시 처리 구간
                            jsSysErrorBox(response, e);
                            return;
                        }
                        changeFlag = false;
                        jsReloadTab();
                    }
                });
            }
        });
    });
</script>

<!-- 캡션 영역 시작 -->
<div class="bbs-caption">
    <div class="caption-right"> 
        <span id="formResult" class="result"></span>
    </div>
</div>
<!-- 캡션 영역 끝 -->

<form id="formConfigForm">

    <input type="hidden" name="domainCd" value="${param.domainCd}" />
    <input type="hidden" name="bbsCd" value="${param.bbsCd}" />
    <input type="hidden" name="gubunCd" value="<%= BoardConfConstant.GUBUN_CD_FORM %>" />
    <input type="hidden" name="uploadTy" value="${dataVo.uploadTy}" />

    <!-- 게시판 목록 상세보기 시작 -->
    <fieldset>
        <legend>입력표 설정</legend>
        <table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="입력표 설정 부가정보를 표시" >
            <caption>입력표 설정</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="2"><label for="mngrEditorYn">웹에디터 사용 여부</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <label for="mngrEditor">관리자단 : </label> 
                        <input type="radio" name="mngrEditorYn" id="mngrEditorYn_Y" value="Y" class="radio"<c:if test="${dataVo.mngrEditorYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'mngrEditorYn', '${dataVo.mngrEditorYn}');" /> 
                        <label for="mngrEditorYn_Y">사용</label> 
                        <input type="radio" name="mngrEditorYn" id="mngrEditorYn_N" value="N" class="radio"<c:if test="${dataVo.mngrEditorYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'mngrEditorYn', '${dataVo.mngrEditorYn}');" /> 
                        <label for="mngrEditorYn_N">미사용</label>
                        <span class="tx_blue_s">- 관리자 화면에서 글 등록/수정 시 웹에디터를 이용하고자 한다면 사용으로 설정하세요.</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="usrEditor">사용자단 : </label>
                        <input type="radio" name="userEditorYn" id="usrEditorYn_Y" value="Y" class="radio"<c:if test="${dataVo.userEditorYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'userEditorYn', '${dataVo.userEditorYn}');" /> 
                        <label for="usrEditorYn_Y">사용</label> 
                        <input type="radio" name="userEditorYn" id="usrEditorYn_N" value="N" class="radio"<c:if test="${dataVo.userEditorYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'userEditorYn', '${dataVo.userEditorYn}');" /> 
                        <label for="usrEditorYn_N">미사용</label>
                        <span class="tx_blue_s">- 사용자 화면에서 글 등록/수정 시 웹에디터를 이용하고자 한다면 사용으로 설정하세요.</span>
                    </td>
                </tr>
                <tr>
                    <th><label for="fileYn">첨부파일 사용 여부</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" name="fileYn" id="fileYn_Y" value="Y" class="radio"<c:if test="${dataVo.fileYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'fileYn', '${dataVo.fileYn}');" />
                        <label for="fileYn_Y">사용</label> 
                        <input type="radio" name="fileYn" id="fileYn_N" value="N" class="radio"<c:if test="${dataVo.fileYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'fileYn', '${dataVo.fileYn}');" /> 
                        <label for="fileYn_N">미사용</label>
                        <span class="tx_blue_s">- 글 등록/수정 시 첨부파일을 이용하고자 한다면 사용으로 설정하세요.</span>

                        <div id="uploaderTypeDiv"<c:if test="${dataVo.fileYn eq 'N'}"> class="none"</c:if>>
                            <table class="inner-table" summary="파일 업로드 관련 내부 상세표 ">
                                <colgroup>
                                    <col width="170px" />
                                    <col />
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th>- 업로드 파일 최대 갯수</th>
                                    <td>
                                        <input type="text" id="maxFileCnt" name="maxFileCnt" value="${dataVo.maxFileCnt}" class="w55" maxlength="2" onchange="jsChkValueChange('text', 'maxFileCnt', '${dataVo.maxFileCnt}');" />
                                        <span class="tx_blue_s">- 한 게시물당 첨부할 수 있는 최대 파일 갯수</span>
                                        <p id="resultMaxFileCnt" class="tx_orange_b"></p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>- 파일당 최대 용량</th>
                                    <td>
                                        <input type="text" id="maxFileSize" name="maxFileSize" value="${dataVo.maxFileSize}" class="w55" maxlength="4" onchange="jsChkValueChange('text', 'maxFileSize', '${dataVo.maxFileSize}');" />
                                        <span class="tx_blue_s">단위 : Mb(메가바이트)</span>
                                        <p id="resultMaxFileSize" class="tx_orange_b"></p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>- 업로드 전체 파일 용량</th>
                                    <td>
                                        <input type="text" id="totalFileSize" name="totalFileSize" value="${dataVo.totalFileSize}" class="w55" maxlength="4" onchange="jsChkValueChange('text', 'totalFileSize', '${dataVo.totalFileSize}');" />
                                        <span class="tx_blue_s">단위 : Mb(메가바이트)</span>
                                        <p id="resultTotalFileSize" class="tx_orange_b"></p>
                                    </td>
                                </tr>
                                <tr class="no-btm">
                                    <th>- 첨부파일 허용 확장자</th>
                                    <td>
                                        <input type="text" name="filePermExtsn" id="filePermExtsn" value="${dataVo.filePermExtsn}" maxlength="90" class="w215" onchange="jsChkValueChange('text', 'filePermExtsn', '${dataVo.filePermExtsn}');" />
                                        <span class="tx_blue_s">최대 90자</span>
                                        <p class="tx_blue_s">- 허용할 첨부파일 확장자를 파이프 문자('|')로 구분하여 등록하세요.(ex : exe|bat|com)</p>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
                <%-- <tr>
                    <th><label for="bannedWordYn">금칙어 사용 여부</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" name="bannedWordYn" id="bannedWordYn_Y" value="Y" class="radio" onclick="jsChkValueChange('radio', 'bannedWordYn', '${dataVo.bannedWordYn}'); $('#trbannedWordCn').show();"<c:if test="${dataVo.bannedWordYn eq 'Y'}"> checked="checked"</c:if> />
                        <label for="bannedWordYn_Y">사용</label> 
                        <input type="radio" name="bannedWordYn" id="bannedWordYn_N" value="N" class="radio" onclick="jsChkValueChange('radio', 'bannedWordYn', '${dataVo.bannedWordYn}'); $('#trbannedWordCn').hide();"<c:if test="${dataVo.bannedWordYn eq 'N'}"> checked="checked"</c:if> /> 
                        <label for="bannedWordYn_N">미사용</label>
                        <span class="tx_blue_s">- 글 등록/수정 시 제한할 금칙어를 체크해야 한다면 사용으로 설정하세요.</span>
                    </td>
                </tr>
                <tr id="trbannedWordCn"<c:if test="${dataVo.bannedWordYn eq 'N'}"> class="none"</c:if>>
                    <th><label for="bannedWordCn">금칙어 목록</label></th>
                    <td>
                        <textarea name="bannedWordCn" id="bannedWordCn" rows="4" cols="60" class="w99_p" onchange="jsChkValueChange('textarea', 'bannedWordCn', '${dataVo.bannedWordCn}');">${dataVo.bannedWordCn}</textarea>
                        <span class="tx_blue_s">- 금칙어를 , (쉼표)로 구분하여 등록하세요.</span>
                    </td>
                </tr> 
                <tr>
                    <th><label for="captchaYn">스팸방지 사용 여부</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" name="captchaYn" id="captchaYn_Y" value="Y" class="radio"<c:if test="${dataVo.captchaYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'captchaYn', '${dataVo.captchaYn}');" />
                        <label for="captchaYn_Y">사용</label> 
                        <input type="radio" name="captchaYn" id="captchaYn_N" value="N" class="radio"<c:if test="${dataVo.captchaYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'captchaYn', '${dataVo.captchaYn}');" /> 
                        <label for="captchaYn_N">미사용</label>
                        <span class="tx_blue_s">- 글 등록/수정 시 스팸방지를 위한 CAPTCHA 기능을 이용하고자 한다면 사용으로 설정하세요.</span>
                    </td>
                </tr>--%>
                <tr>
                    <th><label for="othbcYn">비공개글 사용 여부</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" name="othbcYn" id="othbcYn_Y" value="Y" class="radio"<c:if test="${dataVo.othbcYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'othbcYn', '${dataVo.othbcYn}');" />
                        <label for="othbcYn_Y">사용</label> 
                        <input type="radio" name="othbcYn" id="othbcYn_N" value="N" class="radio"<c:if test="${dataVo.othbcYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'othbcYn', '${dataVo.othbcYn}');" /> 
                        <label for="othbcYn_N">미사용</label>
                        <span class="tx_blue_s">- 비공개글 설정을 사용하려면 사용으로 설정하세요.</span>
                    </td>
                </tr>   
            </tbody>
        </table>
    </fieldset>
    <!-- 게시판 목록 상세보기 끝 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="submit" id="btnSubmit" value="저장" class="w_blue mar_r5" /></li>
            <li><input type="reset" id="btnCancel" value="취소" class="w_blue mar_r5" /></li>
            <li><input type="button" id="btnList" value="목록" class="blue" onclick="jsList();" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

</form>