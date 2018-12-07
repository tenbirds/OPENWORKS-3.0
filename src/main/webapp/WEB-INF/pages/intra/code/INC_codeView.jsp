<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
    $().ready(function(){
        $("#codeCtgBtn").colorbox({
            title : "코드 실렉터 관리",
            href  : "PD_ctgIndex.do?langCode="+$("#langCode").val()+"&grpCd=${dataVo.grpCd}"+"&grpNm="+$("#grpNm").val(),
            width : "835", height:"540",
            iframe: true
        });
    });
</script>


<c:choose>
    <c:when test="${empty dataVo}">

    <script type="text/javascript">
        $().ready(function() {

            //개별코드 등록버튼 감추기
            $("#prvCdInsBtn").hide();

            $("#grpAddForm").validate({
                rules: {
                    grpCd		: { required:true, minlength:1, maxlength:30 },
                    grpNm		: { required:true, minlength:1, maxlength:30 },
                    grpDesc		: { maxlength: 70 }
                },
				submitHandler : function(form) {
                	if($("#oldGrpCd").val() != $("#grpCd").val()){
                    	if ($('input[name=grpFlag]').val() != 'Y') {
                            $("button:contains('중복확인')").parent().append('<label for="grpFlag" class="error">중복확인을 해 주십시요.</label>');
                            $("#grpCd").focus();
                        	return;
                        }
                        if ($("#grpAddForm").valid() == false) return;
                    }

                    $('input[name=grpFlag]').val('Y');
                    $('label[for="grpFlag"]').remove();

                    $(form).ajaxSubmit({
                        url      : "INC_insertAction.do",
                        type     : "POST",
                        success  : function(response) {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.insertOk);
                                    grListLoad(BoxListConfig);
                                    cdListLoad(BoxListConfig, $("#grpCd").val());
                                    $("#" + BoxListConfig.DETAIL_EL).load( BoxListConfig.DETAIL_URL, {grpCd : $("#grpCd").val()}, function(result) {});
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

        // 그룹코드중복체크
        var overlapCheckCode = function(){
            $("#grpAddForm").ajaxSubmit({
                url      : "INC_codeCheck.do",
                type     : "POST",
                async    : false,
                success  : function (response) {
                    if (response != "0") {
                        jsWarningBox("입력하신 그룹코드가 이미 존재합니다.");
                        $('#grpCd').val($('input[name=oldGrpCd]').val());
                    } else {
                        jsSuccessBox("입력하신 그룹코드를 사용할 수 있습니다.");
                        $('#grpCd').attr('readonly', true);
                        $('input[name=grpFlag]').val('Y');
                        $('label[for="grpFlag"]').remove();
                    }
                }
            });
		};
    </script>

	<form name="codeForm" id="grpAddForm" method="post">
    	<input type="hidden" name="grpFlag" id="grpFlag" value="Y" />
    	<input type="hidden" name="oldGrpCd" id="oldGrpCd" value="<c:out value="${code}" />" />
        <div class="b_write">
            <h4 class="tx_13">그룹코드 등록</h4>
            <!-- 내용쓰기 -->
            <fieldset>
            <legend>그룹코드 등록하기</legend>
            <table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 그룹코드 등록하기 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="bu_name">그룹코드명<span class="tx_red_s">*</span></label></th>
                        <td><input type="text" name="grpNm" id="grpNm" class="w60_p" title="그룹코드명을 입력해주세요" value="" /> 최대 30자</td>
                    </tr>
                    <tr>
                        <th><label for="bu_cord">그룹코드<span class="tx_red_s">*</span></label></th>
                        <td>
                            <input type="text" name="grpCd" id="grpCd" class="w60_p" title="그룹코드를 입력해주세요" value="${code}" readonly="readonly" style="width: 255px;"/> &nbsp;
                            <button type="button" onclick="notCodeReadOnly()" class="s_blue">수정</button>&nbsp;
                            <button type="button" id="CheckCode" onclick="overlapCheckCode()" class="s_blue">중복확인</button>
                        </td>
                    </tr>
                   	<tr>
                    	<th><label for="bu_langCode">언어<span class="tx_red_s">*</span></label></th>
                        <td>
                        	<select id="langCode" name="langCode" title="분류를 선택해주세요">
								<option value="">언어선택</option>
								<c:forEach items="${langCodeList}" var="langCode" varStatus="status">
								<option value="${langCode.langCode}"<c:if test="${langCode.langCode == dataVo.langCode}" > selected="selected"</c:if>>${langCode.langNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
                    <tr>
                        <th><label for="con">그룹코드 설명<br />(최대 65자)</label></th>
                        <td><textarea id="grpDesc" name="grpDesc"  rows="15" class="w99_p"></textarea></td>
                    </tr>
                    <tr>
                        <th>사용여부</th>
                        <td>
                            <input type="radio" name="grpUseYn" id="grpUseYn_Y" value="Y" checked="checked"/>
                            <label for="grpUseYn_Y">사용</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="grpUseYn" id="grpUseYn_N" value="N" title="사용여부를 체크해주세요"/>
                            <label for="grpUseYn_N">미사용
                                <span class="tx_gray tx_11">(미사용시 서비스 화면에는 표시되지 않습니다.)</span>
                            </label>
                        </td>
                    </tr>
                </tbody>
            </table>
            </fieldset>
            <!-- //내용쓰기 -->
            <p class="mar_t10 tx_r"><button type="submit" class="blue">등록</button></p>
        </div>
	</form>
    </c:when>


    <c:when test="${dataVo.prvCd == 0}">
    <script type="text/javascript">
		$().ready(function() {

        	$("#prvCdInsBtn").show();
            $("#prvAddForm").hide();
            //$("#jsExcelInsert").hide();
			
            $("#grpModiForm").validate({
            	rules: {
                	grpCd		: { required:true, minlength:1, maxlength:30 },
                    grpNm		: { required:true, minlength:1, maxlength:30 },
                    grpDesc		: { maxlength: 70 }
                },
                submitHandler : function(form) {
                    if($("#oldGrpCd").val() != $("#grpCd").val()){
                        if ($('input[name=grpFlag]').val() != 'Y') {
                            $("#grpCheckCode").parent().append('<label for="grpFlag" class="error">중복확인을 해 주십시요.</label>');
                            $("#grpCd").focus();
                            return;
                         }
                         if ($("#grpModiForm").valid() == false) return;
                    }
                    if($("#grpModiForm #oldLangCode").val() != $("#grpModiForm #langCode").val()){
                        	$('label[for="langCodeFlag"]').remove();
                            $("#grpModiForm #langCode").parent().append('<label for="langCodeFlag" class="error">언어는 수정할 수 없습니다.</label>');
                            $("#grpModiForm #langCode").focus();
                            $("#grpModiForm #langCode").val($("#grpModiForm #oldLangCode").val());
                            return;

                         if ($("#grpModiForm").valid() == false) return;
                    }
           			$('input[name=grpFlag]').val('Y');
                    $('label[for="grpFlag"]').remove();
                    $('label[for="langCodeFlag"]').remove();
                    $(form).ajaxSubmit({
                    	url      : "INC_updateAction.do",
                        type     : "POST",
                        success  : function(response) {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.updateOk);
                                    grListLoad(BoxListConfig);
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

            $("#prvAddForm").validate({
                rules: {
                    prvCd		: { required:true, minlength:1, maxlength:30 },
                    prvNm		: { required:true, minlength:1, maxlength:100 }
                },
                submitHandler : function(form){
                    if($("#oldPrvCd").val() != $("#prvCd").val()){
                        if ($('input[name=prvFlag]').val() != 'Y') {
                            $("#prvCheckCode").parent().append('<label for="prvFlag" class="error">중복확인을 해 주십시요.</label>');
                            $("#prvCd").focus();
                            return;
                         }
                         if ($("#prvAddForm").valid() == false) return;
                    }

                    if($("#grpModiForm #oldLangCode").val() != $("#prvAddForm #langCode").val()){
                    	$('label[for="langCodeFlag"]').remove();
                        $("#prvAddForm #langCode").parent().append('<label for="langCodeFlag" class="error">그룹코드와 동일한 언어만 등록할 수 있습니다.</label>');
                        $("#prvAddForm #langCode").focus();
                        $("#prvAddForm #langCode").val($("#grpModiForm #oldLangCode").val());
                        return;

                     	if ($("#grpModiForm").valid() == false) return;
                	}
                    
                    $('input[name=prvFlag]').val('Y');
                    $('label[for="prvFlag"]').remove();
                    $('label[for="langCodeFlag"]').remove();
                    
                	$(form).ajaxSubmit({
        				url      : "INC_insertAction.do",
                        type     : "POST",
                        success  : function(response) {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.insertOk);
                                    cdListLoad(BoxListConfig, $("#grpCd").val());
                                    $("#" + BoxListConfig.DETAIL_EL).load( BoxListConfig.DETAIL_URL, {grpCd : $("#grpCd").val(), prvCd : $("#prvCd").val()}, function(result) {});
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

        var grpDeleteAction = function(){
            $("#grpModiForm").ajaxSubmit({
                url      : "INC_deleteAction.do",
                type     : "POST",
                success  : function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            self.location.href = "BD_index.do?langCode=" + $("#langCode").val() + "&grpCd="+ $("#grpCd").val();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }
            });
        };

      	//코드중복체크
        var overlapCheckCode = function(gpCodeCheck){
			if(gpCodeCheck == 'G'){
            	$("#grpModiForm").ajaxSubmit({
                	url      : "INC_codeCheck.do",
                	type     : "POST",
                	async    : false,
                	success  : function (response) {
                    	if (response != "0") {
                        	jsWarningBox("입력하신 코드가 이미 존재합니다.");
                        	$('#grpCd').val($('input[name=oldGrpCd]').val());
                    	} else {
                        	jsSuccessBox("입력하신 코드를 사용할 수 있습니다.");
                        	$('#grpCd').attr('readonly', true);
                        	$('input[name=grpFlag]').val('Y');
                        	$('label[for="grpFlag"]').remove();
                    	}
                	}
            	});
          	}else if(gpCodeCheck == 'P'){
            	$("#prvAddForm").ajaxSubmit({
                	url      : "INC_codeCheck.do",
                	type     : "POST",
                	async    : false,
                	success  : function (response) {
                    	if (response != 0) {
                        	jsWarningBox("입력하신 코드가 이미 존재합니다.");
                        	$('#prvCd').val($('input[name=oldPrvCd]').val());
                    	} else {
                        	jsSuccessBox("입력하신 코드를 사용할 수 있습니다.");
                        	$('#prvCd').attr('readonly', true);
                        	$('input[name=prvFlag]').val('Y');
                        	$('label[for="prvFlag"]').remove();
                    	}
                	}
            	});
          	}
        };

        var jsChgLogView = function(el) {
            $(el).colorbox({
                title : $('#grpNm').val() + "[" + $('#grpCd').val() + "] 그룹코드 수정 이력",
                href  : "PD_changeLog.do?q_rowPerPage=5&langCode="+$("#langCode").val()+"&grpCd=" + $('#grpCd').val(),
                width : "600", height:"450",
                iframe: true
            });
        };

    </script>

    <!-- 컨텐츠영역 -->
    <div id="contents">
	    <form name="prvAddForm" id="prvAddForm">
	        <input type="hidden" name="grpCd" id="grpCd" value="${dataVo.grpCd }"/>
	        <input type="hidden" name="prvFlag" id="prvFlag" value="Y" />
	        <input type="hidden" name="oldPrvCd" id="oldPrvCd" value="<c:out value="${code}" />" />
	        <div class="b_write">
	            <h4 class="tx_13">개별코드 정보등록</h4>
	            <!-- 개별코드 추가 -->
	            <fieldset>
	            <legend>개별코드 정보등록</legend>
	            <table class="boardWrite" summary="내용을 수정하실 수 있습니다.">
	                <caption class="hidden"> 개별코드 정보등록</caption>
	                <colgroup>
	                    <col width="15%" />
	                    <col width="85%" />
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th><label for="prvNm">코드명<span class="tx_red_s">*</span></label></th>
	                        <td><input type="text" name="prvNm" id="prvNm" class="w60_p" value="" /> 최대 100자</td>
	                    </tr>
	                    <tr>
	                        <th><label for="prvCd">코드<span class="tx_red_s">*</span></label></th>
	                        <td>
	                            <input type="text" name="prvCd" id="prvCd" class="w60_p" title="코드를 입력해주세요" value="${code}" readonly="readonly" style="width: 255px;" /> &nbsp;
	                            <button type="button" onclick="notPrvCodeInsReadOnly();" class="s_blue">수정</button>&nbsp;
	                            <button type="button" id="prvCheckCode" onclick="overlapCheckCode('P')" class="s_blue">중복확인</button>
	                        </td>
	                    </tr>
	                    <tr>
	                     <th><label for="langCode">언어<span class="tx_red_s">*</span></label></th>
	                        <td>
	                     		<select id="langCode" name="langCode" title="분류를 선택해주세요">
									<option value="">언어선택</option>
									<c:forEach items="${langCodeList}" var="langCode" varStatus="status">
									<option value="${langCode.langCode}"<c:if test="${langCode.langCode == dataVo.langCode}" > selected="selected"</c:if>>${langCode.langNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
	                </tbody>
	            </table>
	            </fieldset>
	            <!-- //개별코드 추가 -->
	            <p class="mar_t10 tx_r"><button type="submit" class="blue">등록</button></p>
	        </div>
	    </form>
	
	    <form name="codeForm" id="grpModiForm">
	    	<input type="hidden" name="grpFlag" id="grpFlag" value="N" />
	    	<input type="hidden" name="oldGrpCd" id="oldGrpCd" value="<c:out value="${dataVo.grpCd}" />" />
	    	<input type="hidden" name="oldLangCode" id="oldLangCode" value="<c:out value="${dataVo.langCode}" />" />
	        <div class="b_write">
	            <h4 class="tx_13">그룹코드 종합정보</h4>
	            <!-- 그룹코드 종합정보 내용 -->
	            <fieldset>
	            <legend>그룹코드 등록하기</legend>
	            <table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
	                <caption class="hidden"> 그룹코드 등록하기 </caption>
	                <colgroup>
	                    <col width="15%" />
	                    <col width="85%" />
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th><label for="grpNm">그룹코드명<span class="tx_red_s">*</span></label></th>
	                        <td><input type="text" name="grpNm" id="grpNm" class="w60_p" title="그룹코드명을 입력해주세요" value="${dataVo.grpNm}" /> 최대 30자</td>
	                    </tr>
	                    <tr>
	                        <th><label for="grpCd">그룹코드</label></th>
	                        <td>
	                            <input type="text" name="grpCd" id="grpCd" class="w60_p" title="그룹코드를 입력해주세요" value="${dataVo.grpCd}" readonly="readonly" /> &nbsp;
	<!-- 								<button type="button" onclick="notCodeReadOnly()" class="s_blue">수정</button>&nbsp; -->
	<!-- 								<button type="button" id="grpCheckCode" onclick="overlapCheckCode('G')" class="s_blue">중복확인</button> -->
	                        </td>
	                    </tr>
	                    <tr>
	                		<th><label for="langCode">언어<span class="tx_red_s">*</span></label></th>
	                    	<td>
		                     	<select id="langCode" name="langCode" title="분류를 선택해주세요" >
									<option value="">언어선택</option>
									<c:forEach items="${langCodeList}" var="langCode" varStatus="status">
									<option value="${langCode.langCode}"<c:if test="${langCode.langCode == dataVo.langCode}" > selected="selected"</c:if>>${langCode.langNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
	                    <tr>
	                        <th><label for="grpDesc">그룹코드 설명<br />(최대 65자)</label></th>
	                        <td><textarea name="grpDesc" id="grpDesc" rows="6" class="w99_p">${dataVo.grpDesc}</textarea></td>
	                    </tr>
	                    <tr>
	                        <th>사용여부</th>
	                        <td>
	                            <input type="radio" name="grpUseYn" id="grpUseYn_Y" value="Y" <c:if test="${dataVo.grpUseYn == 'Y'}">checked="checked"</c:if>/>
	                            <label for="grpUseYn_Y">사용</label>&nbsp;&nbsp;&nbsp;
	                            <input type="radio" name="grpUseYn" id="grpUseYn_N" value="N" <c:if test="${dataVo.grpUseYn == 'N'}">checked="checked"</c:if>/>
	                            <label for="grpUseYn_N">미사용 <span class="tx_gray tx_11">(미사용시 서비스 화면에는 표시되지 않습니다.)</span></label>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>개별코드 목록</th>
	                        <td>
	                            <p class="tx_b mar_b5">
	                                <c:if test="${!empty dataList}">[
	                                    <c:forEach items="${dataList}" var="_bean" varStatus="_stst">
	                                        <c:if test="${not _stst.first}"> ,</c:if>
	                                        <c:if test="${_bean.useYn == 'Y'}">${_bean.prvNm}(${_bean.prvCd})</c:if>
	                                        <c:if test="${_bean.useYn == 'N'}"><span class="tx_red">${_bean.prvNm}(${_bean.prvCd})</span></c:if>
	                                    </c:forEach>
	                                ]</c:if>
	                            </p>
	                            <p>하단의 ‘개별코드 추가’폼에서 현 그룹코드에 추가 등록할 수 있습니다.
	                                <span class="tx_red">붉은색 개별코드</span>는 <span class="tx_red">미사용 코드</span>입니다.
	                            </p>
	                        </td>
	                    </tr>
	                    <c:if test="${fn:length(dataVo.prvNms) != 0}">
		                    <tr>
		                        <th>코드 실렉터</th>
		                        <td>
		                        <c:if test="${fn:length(dataVo.ctgList) != 0}">
		                            <table class="ta_gray">
		                                <tbody>
		                                    <tr>
		                                        <th>실렉터</th>
		                                        <th>개별코드</th>
		                                    </tr>
		                                    <tr>
		                                        <c:forEach items="${dataVo.ctgList}" var="ctgCd">
		                                            ${ctgCd}
		                                        </c:forEach>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </c:if>
		                        <p class="mar_t10">하단의 '코드 실렉터'버튼을 클릭하시면 수정할 수 있습니다.</p>
		                        </td>
		                    </tr>
	                    </c:if>
	                </tbody>
	            </table>
	            </fieldset>
	            <!-- //그룹코드 종합정보 내용 -->
	            <p class="mar_t10 tx_r">
	                <button type="submit" class="blue">수정</button>
	                <c:if test="${fn:length(dataVo.prvNms) != 0}">
	                    <a href="#"><button type="button" id="codeCtgBtn" class="blue">코드 실렉터</button></a>
	                </c:if>
	                <a href="#"><button type="button" onclick="jsChgLogView(this);" class="blue">수정이력</button></a>
	<!--                     <a href="#"><button type="button" onclick="grpDeleteAction();" class="blue">삭제</button></a> -->
	            </p>
	            <br/><br/><br/><br/>
	        </div>
	    </form>
    </div>
    <!-- //컨텐츠영역 -->
    </c:when>

    <c:when test="${dataVo.prvCd != 0}">
    <script type="text/javascript">
        $().ready(function() {

            //개별코드 등록버튼 감추기
            $("#prvCdInsBtn").hide();
            //$("#jsExcelInsert").hide();

            $("#prvModiForm").validate({
                rules: {
                    prvCd		: { required:true, minlength:1, maxlength:30 },
                    prvNm		: { required:true, minlength:1, maxlength:100 },
                    orderNo     : { required:true, number:true} // 20150901 개별 코드 소드 수정 기능 추가
                },
                messages: {
                    orderNo : { number: "숫자만 입력해주세요(ex:1)"} // 20150901 개별 코드 소드 수정 기능 추가
                },
                submitHandler : function(form) {
                    if($("#oldPrvCd").val() != $("#prvCd").val()){
                        if ($('input[name=prvFlag]').val() != 'Y') {
                            $("button:contains('중복확인')").parent().append('<label for="prvFlag" class="error">중복확인을 해 주십시요.</label>');
                            $("#prvCd").focus();
                            return;
                         }
                         if ($("#prvModiForm").valid() == false) return;
                    }

 					if($("#prvModiForm #oldLangCode").val() != $("#prvModiForm #langCode").val()){
                    	$('label[for="langCodeFlag"]').remove();
                        $("#prvModiForm #langCode").parent().append('<label for="langCodeFlag" class="error">언어는 수정할 수 없습니다.</label>');
                        $("#prvModiForm #langCode").focus();
                        $("#prvModiForm #langCode").val($("#prvModiForm #oldLangCode").val());
                        return;

                    	if ($("#prvModiForm").valid() == false) return;
                	}
                	$('label[for="langCodeFlag"]').remove();
                	
                    $('input[name=prvFlag]').val('Y');
                    $('label[for="prvFlag"]').remove();
					
                    $(form).ajaxSubmit({
                        url      : "INC_updateAction.do",
                        type     : "POST",
                        success  : function(response) {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.updateOk);
                                    cdListLoad(BoxListConfig, $("#grpCd").val());
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


        //코드중복체크
        var overlapCheckCode = function(gpCodeCheck){
            $("#prvModiForm").ajaxSubmit({
                url      : "INC_codeCheck.do",
                type     : "POST",
                async    : false,
                success  : function (response) {
                    if (response != "0") {
                        jsWarningBox("입력하신 코드가 이미 존재합니다.");
                        $('#prvCd').val($('input[name=oldPrvCd]').val());
                        $('input[name=prvFlag]').val('N');
                    } else {
                        jsSuccessBox("입력하신 코드를 사용할 수 있습니다.");
                        $('#prvCd').attr('readonly', true);
                        $('input[name=prvFlag]').val('Y');
                        $('label[for="prvFlag"]').remove();
                    }
                }
            });
          };
    </script>

    <form name="codeForm" id="prvModiForm">
	    <input type="hidden" name="grpCd" id="grpCd" value="${dataVo.grpCd }"/>
	    <input type="hidden" name="prvFlag" id="prvFlag" value="N" />
	    <input type="hidden" name="oldPrvCd" id="oldPrvCd" value="<c:out value="${dataVo.prvCd}" />" />
	    <!-- 20150901 개별코드 소트 수정 기능 추가 시작 -->
	    <!--input type="hidden" name="orderNo" id="orderNo" value="<c:out value="${dataVo.orderNo}" />" /-->
	    <!-- 20150901 개별코드 소트 수정 기능 추가 끝 -->
	    <input type="hidden" name="regDt" id="regDt" value="<c:out value="${dataVo.regDt}" />" />
	    <input type="hidden" name="oldLangCode" id="oldLangCode" value="<c:out value="${dataVo.langCode}" />" />
	    <!-- 컨텐츠영역 -->
	    <div id="contents">
	        <div class="b_write">
	            <h4 class="tx_13">개별코드 정보</h4>
	            <!-- 개별코드 정보 내용 -->
	            <fieldset>
	            <legend>개별코드 정보 입력</legend>
	            <table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
	                <caption class="hidden"> 개별코드 정보 입력 </caption>
	                <colgroup>
	                    <col width="15%" />
	                    <col width="85%" />
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th><label for="prvNm">코드명 <span class="tx_red_s">*</span></label></th>
	                        <td><input type="text" name="prvNm" id="prvNm" class="w60_p" title="그룹코드명을 입력해주세요" value="${dataVo.prvNm}" /> 최대 30자</td>
	                    </tr>
	                    <tr>
	                        <th><label for="prvCd">코드</label></th>
	                        <td>
	                            <input type="text" name="prvCd" id="prvCd" class="w60_p" title="코드를 입력해주세요" value="${dataVo.prvCd}" readonly="readonly" /> &nbsp;
	<!-- 							<button type="button" onclick="notPrvCodeUdtReadOnly();" class="s_blue">수정</button>&nbsp; -->
	<!-- 							<button type="button" onclick="overlapCheckCode()" class="s_blue">중복확인</button> -->
	                        </td>
	                    </tr>
	               		<tr>
	                        <th><label for="langCode">언어</label></th>
	                        <td>
                        		<select id="langCode" name="langCode" title="분류를 선택해주세요">
									<option value="" <c:if test="${dataVo.langCode == null || dataVo.langCode == '' }" > selected="selected"</c:if>>언어선택</option>
									<c:forEach items="${langCodeList}" var="langCode" varStatus="status">
									<option value="${langCode.langCode}"<c:if test="${langCode.langCode == dataVo.langCode}" > selected="selected"</c:if>>${langCode.langNm}</option>
									</c:forEach>
								</select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>정렬순서</th>
	                        <td>
	                           <!-- 20150901 개별 코드 소드 수정 기능 추가 시작 -->
	                           <input type="text" name="orderNo" id="orderNo" class="w60_p" title="그룹코드명을 입력해주세요" value="${dataVo.orderNo}" />
	                           <input type="hidden" name="orderNoBefore" id="orderNoBefore" value="${dataVo.orderNo}" />
	                           <!-- 20150901 개별 코드 소드 수정 기능 추가 끝 -->
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>사용여부</th>
	                        <td>
	                            <input type="radio" name="useYn" id="useYn_Y" value="Y" <c:if test="${dataVo.useYn == 'Y'}">checked="checked"</c:if>/>
	                            <label for="useYn_Y">사용</label>&nbsp;&nbsp;&nbsp;
	                            <input type="radio" name="useYn" id="useYn_N" value="N" <c:if test="${dataVo.useYn == 'N'}">checked="checked"</c:if>/>
	                            <label for="useYn_N">미사용 <span class="tx_gray tx_11">(미사용시 서비스 화면에는 표시되지 않습니다.)</span></label>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	            </fieldset>
	            <!-- //개별코드정보내용 -->
	            <p class=" tx_r mar_t10 mar_b20">
	                <button type="submit" class="blue">수정</button>
	            </p>
	        </div>
	    </div>
	    <!-- //컨텐츠영역 -->
    </form>
    </c:when>
</c:choose>