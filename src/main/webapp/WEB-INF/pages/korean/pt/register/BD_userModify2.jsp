<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원정보 변경</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />

<c:if test="${fn:startsWith(loginData.userTyCd,'30')}">
	<script type="text/javascript">
		var emailChk = "N"; <%-- 이메일 중복확인 체크용 --%>
		$().ready(function() {
			<c:if test="${param.pwdChg eq 'Y'}">
				$("#pwdChg").trigger("click");
			</c:if>
			
			$("#dataForm").validate({
				ignore: "",
            	rules: {
              				pblinsttTelnolinsttTelno1    : { required: true, number: true}
                			,pblinsttTelno2    : { required: true, number: true}
                			,pblinsttTelno3    : { required: true, number: true}
// 				            ,intrlTelno        : { required: true, maxlength: 6}
//              		    ,lxtnTelno         : { number: true}
//                 			,nationCode        : { required: true}
			                ,mbtlnum1          : { number: true, required: true}
			                ,mbtlnum2          : { number: true, required: true}
			                ,mbtlnum3          : { number: true, required: true}
			                ,email             : { email2: true, required: true}
			                ,email1            : { required: true}
			                ,email2            : { required: true}

/*              			,pblinsttNm          : { required: true}
                			,pblinsttCd          : { required: true}
               	 			,bizrno2             : { number: true, required: true}
                			,bizrno3           	 : { number: true, required: true}
                			,pblinsttUrl         : { url: true, required: true}
                			,pblinsttZip         : { number: true, required: true}
                			,pblinsttBassAdres   : { required: true}  
                			,pblinsttDetailAdres : { required: true}	*/
						},
            	messages : {
            				email         : { email2: "이메일 형식으로 입력해주세요."}
            				},
            	submitHandler : function(form) {

					if($("#pblinsttTelno1").val() != '' && $("#pblinsttTelno2").val() != '' && $("#pblinsttTelno3").val() != ''){
						$("#pblinsttTelno").val($("#pblinsttTelno1").val()+"-"+$("#pblinsttTelno2").val()+"-"+$("#pblinsttTelno3").val());
					}
              
            		if($("#mbtlnum1").val() != '' && $("#mbtlnum2").val() != '' && $("#mbtlnum3").val() != ''){
                    	$("#mbtlnum").val($("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val());
              		}
              
            		if($("#email1").val() != '' && $("#email2").val() != ''){
	                    $("#email").val($("#email1").val()+"@"+$("#email2").val());
              		}
							
					if($.trim($("#email").val()) != ''){
			        	var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			            if(!emailExp.test($('#email').val())){
			            	alert(Message.msg.validEmail);
			                $('#email1').focus();
			                return;
						}
            		}

                	$(form).ajaxSubmit({
                    	url      : "ND_updateAction.do",		//회원 정보 수정 하는 곳 
                    	type     : "POST",
                    	dataType : "text",
                    	success  : function(response) {
	                        try {
	                    			if (eval(response)) {
	                        		alert(Message.msg.memberModify);
	                            	// 성공하면 메인으로 가기   
	                            	<%-- //  window.location.replace("/<%=request.getServerName().substring(0, request.getServerName().indexOf("."))%>/pt/index.do"); --%>
	                            	window.location.replace("/korean/pt/index.do");
	                        	}else{
		                        	alert(Message.msg.processFail);
	                       		}
                        	} catch (e) {
	                            alert(response, e);
                            	return;
                        	}
                		}
					});
				}
			});

			<c:if test="${not empty loginData}">
        		settingValue(updateSettingOptionDate);//기본정보 조회자료 세팅
        	</c:if>

         
       		<c:if test="${loginData.nationCode ne '410'}">
        		userNation();
        	</c:if>

        	categoryLangChange('00');
        	$(".intrlTelno").change(function(){
            	$(".intrlTelno").val($(this).val());
        	});
    	});//ready end

        //저장액션
        var jsSubmit = function() {
            
        	if($("#email1").val() != '' || $("#email2").val() != ''){
                $("#email").val($("#email1").val()+"@"+$("#email2").val());
            }
            
            if($("#email1").val()+"@"+$("#email2").val() != "${loginData.email}" && emailChk == "N"){
                alert(Message.msg.checkDupEmail);
                $("#emailChk").focus();
                return false;
            } else{
                $("#dataForm").submit();
            }
        };
    	
		updateSettingOptionDate = [	{column:'pblinsttTelno', values:'${loginData.pblinsttTelno}', separation:'-', lang:''}
    					      		,{column:'email', values:'${loginData.email}', separation:'@', lang:''}
                              		,{column:'mbtlnum', values:'${loginData.mbtlnum}', separation:'-', lang:''}];

    	var settingValue = function(setData) {
        	$.each(setData, function (i, item) {
            	if(item.separation != ''){
                	value = item.values.split(item.separation);
                	$.each(value, function (j, item2) {
	                    if(item.lang != ''){
                        	$("#"+item.column+(j+1)+item.lang).val(item2);
                    	} else {
	                        $("#"+item.column+(j+1)).val(item2);
                    	}
                	});
            	}
            	$("#"+item.column+item.lang).val(item.values);
        	});
    	};
    
    	var jsPblinsttCdPop = function (el) {    <%-- 기관명 검색 컬러박스 호출 --%>
    		$(el).colorbox({
		        title : false,
	        	href : "PD_dmandExaminPblinstt.do",
	        	width : "745",
	        	height : "580",
	        	overlayClose : false,
	        	escKey : false,
	        	iframe : true,
	        	closeButton : false,
	        	scrolling : false,
	        	returnFocus : false,
	        	trapFocus : false
	    	});
		};


     var jsZipcodePop = function (el, zcId, adr1, adr2) {    <%-- 주소찾기 팝업 호출 --%>
		$("#zipCodeId").val(zcId);
	    $("#baseAddrId").val(adr1);
	    $("#detailAddrId").val(adr2);
	    var pop = window.open("PD_jusoSearch.do","pop","top="+ (screen.height/2 - 230) +",left=" + (screen.width/2 - 285) + ",width=570,height=460, scrollbars=no");
	};
	
    var passwordUpdete = function(el){
        $(el).colorbox({
            title  : "비밀번호 변경하기",
            href   : "PD_passwordUpdate.do",
            width  : "680",
            height : "420",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
    };
    


    var jsCategoryPop = function(el) {
        $(el).colorbox({
            title  : "관심 카테고리 선택하기",
            href   : "PD_categoryPop.do?PID=UM01",
            width  : "900",
            height : "600",
            overlayClose : false,
            iframe : true
        });
    };
 	
    // 숫자만 입력하도록 체크
	function jsOnlyNumber(event){
		var keyID = (event.which) ? event.which : event.keyCode;
		if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
		else return false;
	}
	
	// 숫자만 입력하도록 체크2
	function removeChar(event) {
		event = event || window.event;
		 var keyID = (event.which) ? event.which : event.keyCode;
		  if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9) return;
		else event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
    var jsCtgrySel = function() {
        var ctgryCodes = $("#setCtgryCodes").val();
        ctgryCodes = ctgryCodes.split(",");
        var ctgryCodeUrl = "";
        for (var i = 0; i < ctgryCodes.length; i++) {
            if (i > 0) {
                ctgryCodeUrl += "&";
            }
            ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
        }
        var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
        $.post(url,
        function(response){
            $(".langCategory00").remove();
            if(response.length > 0){
                var htmlVal1 = "";
                var htmlVal2 = "";
                var htmlVal3 = "";
                for (var i = 0; i < response.length; i++) {
                    if(response[i].ctgryClNm == 'SaaS') {
                        htmlVal2 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal2 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal2 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal2 += '<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_' + response[i].ctgryCode + '" onclick="jsCategoryDelete(this);" />';
                        htmlVal2 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    } else if(response[i].ctgryClNm == 'PaaS') {
                        htmlVal1 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal1 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal1 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal1 += '<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_' + response[i].ctgryCode + '" onclick="jsCategoryDelete(this);" />';
                        htmlVal1 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    } else {
                        htmlVal3 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal3 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal3 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal3 += '<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_' + response[i].ctgryCode + '" onclick="jsCategoryDelete(this);" />';
                        htmlVal3 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    }
                }
                categoryLangChange('00');
                $(".cate2").append(htmlVal2);
                $(".cate1").append(htmlVal1);
                $(".cate3").append(htmlVal3);
            }
        });
    };

    var jsCategoryDelete = function(el) {
//         event.preventDefault(el);
        $('.' + el.id).remove();
    };

    var jsEmailList = function(status) {
        if($("select[name='"+status+"List'] option:selected").val() != ''){
             $("#"+status+"2").val($("select[name='"+status+"List'] option:selected").text());
             $("#"+status+"2").attr("readonly", true);
         } else {
             $("#"+status+"2").attr("readonly", false);
         }
    };

    var jsEmailList2 = function(status) {
        if($("select[id='"+status+"List'] option:selected").val() != ''){
             $("#reprsntEmails2"+status).val($("select[id='"+status+"List'] option:selected").text());
             $("#reprsntEmails2"+status).attr("readonly", true);
         } else {
             $("#reprsntEmails2"+status).attr("readonly", false);
         }
    };

    var jsEmailReset = function() {
        emailChk = "N";
    };
    var emailCheck = function(){    <%-- 이메일 중복검사 --%>
        if($("#email1").val() == ''){
            alert(Message.msg.emptyEmail);
            $("#email1").focus();
            return false;
        } else if($("#email2").val() == '') {
            alert(Message.msg.emptyEmail);
            $("#email2").focus();
            return false;
        }
        $("#email").val($("#email1").val()+"@"+$("#email2").val());
        $("#dataForm").ajaxSubmit({
            url      : "ND_emailDupleCheck.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if(response == 'true'){
                    emailChk = "Y";
                    $("#zip1").focus();
                    alert(Message.msg.availableEmail);
                }else if(response == 'duple'){
                    alert(Message.msg.dupEmail);
                    $('#email1').focus();
                }else{
                    alert(Message.msg.email);
                    $('#email1').focus();
                }
            }
        });
    };

    var categoryLangChange = function(langCd) {
        $("#categoryLangCode").val(langCd);
        $(".first span").html("<strong>"+$("select[id='categoryLangCode'] option:selected").text()+"</strong>");
        $("ul[class^=langCategory]").hide();
        $(".langCategory"+langCd).show();
    };
    
    /* 기관명 검색 팝업 호출 */
    var organSearchPop = function(el, val) {
    	$(el).colorbox({
            title        : "기관명 검색",
            href         : "PD_organSearchPop.do",
            width        : "900",
            height       : "700",
            overlayClose : false,
            iframe       : true,
            scrolling    : false
      });
    };

    var fnDmandExaminChargerAt = function (el) {
    	//var checked = $('input:checkbox[name="dmandExaminChargerAt"]').is(":checked");
    	var checkFlag = $('#dmandExaminChargerAt').is(":checked");
    	
    	if(checkFlag) {
			if (confirm("\n수요예보조사 기관담당자 지정을 위해서는 소속기관정보를\n업데이트 해야 합니다. \n\n정보를 업데이트 하시겠습니까?")) {
				var winl = (screen.width - 900) / 2;
				var wint = (screen.height - 700) / 2;
				var url = "PD_organSearchPop.do?flag=A";
				var winprops = "height=700, width=900, top="+wint+", left="+winl+", menubar=no, status=no, toolbar=no, resizable=no";
				
				window.open(url, "dataForm", winprops);
	 			
		  }else{
		  	$('input:checkbox[name="dmandExaminChargerAt"]').prop("checked", false);
		  	return false;
		  }
		}else{
			return false;
		}
    }
</script>
</c:if>
<style type="text/css">
#multiFiles_wrap_list {
	margin-left: 70px;
}
</style>
</head>
<body>
	<c:set var="userTyNm1">
		<c:choose>
			<c:when test="${fn:startsWith(loginData.userTyCd,'10')}">일반 및 사업자</c:when>
			<c:when test="${fn:startsWith(loginData.userTyCd,'20')}">일반기업</c:when>
			<c:otherwise>공공기관</c:otherwise>
		</c:choose>
	</c:set>
	<c:set var="userTyNm2">${fn:endsWith(loginData.userTyCd, '02') ? '제공자' : '이용자'}</c:set>
		
		<div class="join_info">
		<form id="dataForm" name="dataForm" onsubmit="return false;">
			<!-- 우편번호 코드 ID -->
			<input type="hidden" id="zipCodeId" value="" />
			<!-- 기본주소 코드 ID -->
			<input type="hidden" id="baseAddrId" value="" />
			<!-- 상세주소 코드 ID -->
			<input type="hidden" id="detailAddrId" value="" />
			<!-- 전화번호 -->
			<input type="hidden" id="pblinsttTelno"	name="pblinsttTelno" value="" />
			<!-- 휴대폰번호 -->
			<input type="hidden" id="mbtlnum"	name="mbtlnum" value="" />
			<!-- 우편번호 -->
			<input type="hidden" id="zip"	name="zip" value="" />
			<!-- 사업자등록번호 -->
			<input type="hidden" id="bizrno" name="bizrno" value="" />
			

			<!-- 회사INFO -->
			<input type="hidden" id="cmpnyTelno" name="cmpnyTelno" value="" />
			<input type="hidden" id="cmpnyReprsntTelno" name="cmpnyReprsntTelno" value="" />
			<input type="hidden" id="cmpnyFaxnum" name="cmpnyFaxnum" value="" />
			<input type="hidden" id="cmpnyZip" name="cmpnyZip" value="" />
			
			<input type="hidden" id="pblinsttCd" name="pblinsttCd" value="${loginData.pblinsttCd }" />
			
			
			<!-- 사용자 유형 코드 -->
			<input type="hidden" id="userTyCd" name="userTyCd" value="<c:out value='${loginData.userTyCd}' />" />
			<!-- 언어코드 -->
			<input type="hidden" id="langCode" name="langCode" value="<c:out value='${loginData.langCode}' />" />
			<input type="hidden" id="setCtgryCodes" value="
				<c:forEach items="${loginData.ctgryList}" var="category" varStatus="status">
					<c:if test="${category.LANGCODE eq '00'}">${category.CTGRYCODE}${!status.last? ',' : ''}</c:if>
				</c:forEach>" />
			<!-- 국제전화번호 -->
			<input type="hidden" id="intrlTelno" name="intrlTelno" value=""	class="intrlTelno" />
			<!-- 국가코드 -->
			<input type="hidden" id="nationCode" name="nationCode" value="<c:out value='${loginData.nationCode}'/>" />						

			<p><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>

			<h4>필수정보</h4>
			<table class="tbl_st4">
				<tr>
					<th class="requ">회원 구분</th>
					<td>
						<c:choose>
							<c:when test="${fn:startsWith(loginData.userTyCd,'10')}">일반 및 사업자</c:when>
							<c:when test="${fn:startsWith(loginData.userTyCd,'20')}">일반기업</c:when>
							<c:otherwise>공공기관</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<%-- 
				<tr>
					<th class="requ">기업명</th>
					<td>${loginData.cmpnyNm}</td>

				</tr>
				--%>
				<tr>
					<th class="requ">아이디</th>
					<td>${loginData.userId}
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="dmandExaminChargerAt" name="dmandExaminChargerAt" value="Y" 
						<c:if test="${loginData.dmandExaminChargerAt eq 'Y'}">checked</c:if> 
						<c:if test="${loginData.dmandExaminSaveCnt > 0}">disabled</c:if>  onclick="fnDmandExaminChargerAt(this); return;"/> 
					<label for="dmandExaminChargerAt">수요예보조사 담당자(기관당 1명만 선택)</label>
					<c:if test="${loginData.dmandExaminSaveCnt > 0}"><input type="hidden" name="dmandExaminChargerAt" value="${loginData.dmandExaminChargerAt}" /></c:if>
					<%-- <input type="hidden" id="dmandExaminChargerAt" name="dmandExaminChargerAt" value="${loginData.dmandExaminChargerAt}" /> --%>
					</td>
				</tr>
				<tr>
					<th class="requ">비밀번호</th>
					<td><a href="#" id="pwdChg"
						onclick="passwordUpdete(this);" title="팝업 창 열림"
						class="btns st3">비밀번호 변경</a> ※ 비밀번호는 3개월에 한번 씩 변경하시는 것이 안전합니다.
					</td>
				</tr>
				<tr>
					<th class="requ">이름</th>
					<td>${loginData.userNm}</td>
				</tr>
				<tr>
					<th class="requ">휴대전화</th>
					<td class="inputTel">
						<input type="text" value="82" readonly="readonly" />	
<!-- 									<input type="text" id="mbtlnum1" name="mbtlnum1" title="휴대전화번호 앞자리를 입력해주세요." />														 -->														
						<span class="sel_box">
						<select id="mbtlnum1" name="mbtlnum1" >
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						</span> -
						<input type="text" id="mbtlnum2" name="mbtlnum2" title="휴대전화번호 가운데자리를 입력해주세요." maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event);"/> - 
						<input type="text" id="mbtlnum3" name="mbtlnum3" title="휴대전화번호 뒷자리를 입력해주세요." maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event);"/>
						<%-- 
							<c:if test="${fn:startsWith(loginData.userTyCd, '10')}">
								<span class="caption ml20">이벤트/정보 SMS</span>
								<span class="agree"><op:code id="smsRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002" /></span>
							</c:if>
							<p class="caption mt10">※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과 관련된 내용은 수신동의 여부와 관계없이 SMS가 발송됩니다.</p></td>
						--%>
				</tr>
				<tr>
					<th  class="requ">이메일 주소</th>
					<td colspan="3" class="inputEmail">
						<!--  이메일 수정불가 --> 
						<input type="text" id="email1" name="email1" title="이메일 주소를 입력해 주세요."onchange="jsEmailReset();" readonly="readonly" /> @ 
						<input type="text" id="email2" name="email2" title="도메인을 입력해 주세요." onchange="jsEmailReset();" readonly="readonly" /> 
						<input type="hidden" id="email" name="email" value="" />
						<%--
					<op:code id="emailList" langCode="00" grpCd="80" onchange="jsEmailList('email');" defaultLabel="직접입력" /> --%>
<!-- 					<a href="#email1" id="emailChk" onclick="emailCheck();" title="팝업 창 열림" class="btns st3">중복확인</a>	 -->
					</td>
				</tr>

				<tr>
					<th class="requ">이메일 수신동의</th>
					<td colspan="3" class="emailAgree">
						<dl>
							<dt>광고홍보 이메일</dt>
							<dd>
								<op:code id="emailRecptnAgreCd" grpCd="77" type="radio" defaultValues="${empty loginData.emailRecptnAgreCd ? '1002' : loginData.emailRecptnAgreCd}" />
							</dd>
							<%-- 공공기관은 선택제외항목
							<dt>뉴스레터/세미나</dt> 								
							<dd>
								<op:code id="nsletRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002" />
							</dd> 
							<input type="hidden" id="nsletRecptnAgreCd" name="nsletRecptnAgreCd" value="1002" />								
							--%>
							<dt>뉴스레터/세미나</dt>
								<dd>
									<op:code id="nsletRecptnAgreCd" grpCd="77" type="radio" defaultValues="${empty loginData.nsletRecptnAgreCd ? '1002' : loginData.nsletRecptnAgreCd}" />
								</dd>
							
							<dt>입찰공고 이메일</dt>
							<dd>
								<op:code id="bidRecptnAgreCd" grpCd="77" type="radio" defaultValues="${empty loginData.bidRecptnAgreCd ? '1002' : loginData.bidRecptnAgreCd}" />
							</dd>
						</dl>
						<p>※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과 관련된 내용은 수신동의 여부와 관계없이
							이메일이 발송됩니다.</p>
					</td>
				</tr>
			</table>

			<h4>소속기관정보(필수)</h4>
			<table class="tbl_st4">
				<tr>
					<th class="requ">기관명</th>
					<td>
						<input type="hidden" name="orgnCode" id="orgnCode" value="${loginData.orgnCode}" />
						<input type="hidden" name="buseoCode" id="buseoCode" value="${loginData.buseoCode}" />
						<input type="text" name="orgn_nm" id="orgn_nm" value="${loginData.orgnNm}" readonly style="width:530px;" />
						<c:if test="${loginData.dmandExaminSaveCnt == 0}">
							<a href="#none" class="btns st3" onclick="organSearchPop(this, 'B');" title="기관검색">기관검색</a>
						</c:if>
					</td>
					
				</tr>
				<%-- 
				<tr>
					<th class="requ">부서명</th>
					<td>
						<input type="hidden" name="buseoCode" id="buseoCode" value="${loginData.buseoCode}" />
						<input type="text" name="orgn_nm_st" id="orgn_nm_st" value="${loginData.cmpnyBuseo}" readonly /></td>
				</tr>
				 --%>
				<tr>
					<th class="requ">유선전화</th>
					<td class="inputTel">
						<input type="text" name="pblinsttTelno1" id="pblinsttTelno1" maxlength="3" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
						<input type="text" name="pblinsttTelno2" id="pblinsttTelno2" maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
						<input type="text" name="pblinsttTelno3" id="pblinsttTelno3" maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" />
					</td>
				</tr>
				<%-- 2017-09-07 : 기관정보를 수정할 수 있도록 위로 변경
				<tr>
					<th class="requ">기관명</th>
					<td>${loginData.orgnNm}</td>						
				</tr>
				<tr>
					<th class="requ">부서명</th>
					<td>${loginData.cmpnyBuseo}</td>
				</tr>
				<tr>                                                                                                                               
					<th class="requ">유선전화</th>
					<td class="inputTel">
						<input type="text" name="pblinsttTelno1" id="pblinsttTelno1" maxlength="3" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
						<input type="text" name="pblinsttTelno2" id="pblinsttTelno2" maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
						<input type="text" name="pblinsttTelno3" id="pblinsttTelno3" maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" />
						<!-- <input type="text" id="telno1" name="telno1" title="전화 지역번호를 입력해주세요." maxlength="3" /> -
						<input type="text" id="telno2" name="telno2" title="전화 국번을 입력해주세요." maxlength="4"/> -
						<input type="text" id="telno3" name="telno3" title="전화번호 뒷자리를 입력해주세요." maxlength="4"/> -->
					</td>
				</tr>
				 --%>
			</table>
		    <%-- 
			<h4>관심분야(다중선택 가능)<a href="" id="categorySelect" title="팝업창 열림" onclick="jsCategoryPop(this);" class="btns st3">선택</a></h4>
			<table class="tbl_st4">
				<tr>
					<th>SaaS</th>
					<td class="goodsCtgry cate2">
					<c:forEach items="${loginData.ctgryList}" var="category">
						<c:if test="${category.CTGRYCLCD == '1002'}">
							<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
								<li><span>${category.CTGRYCLNM}</span><span>${category.CTGRYPATH}</span>
									<span class="txt-point">${category.CTGRYNM}</span>
									<c:if test="${category.CATEGORY_LANGCD eq '00'}">
										<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_${category.CTGRYCODE}" 
											onclick="jsCategoryDelete(this);" />
										<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
									</c:if>
								</li>
							</ul>
						</c:if>
					</c:forEach></td>
					</tr>
					<tr>
						<th>Paas</th>
						<td class="goodsCtgry cate1">
						<c:forEach items="${loginData.ctgryList}" var="category">
							<c:if test="${category.CTGRYCLCD == '1001'}">
								<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
									<li><span>${category.CTGRYCLNM}</span><span>${category.CTGRYPATH}</span>
										<span class="txt-point">${category.CTGRYNM}</span>
										<c:if test="${category.CATEGORY_LANGCD eq '00'}">
											<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_${category.CTGRYCODE}" 
													onclick="jsCategoryDelete(this);" />
											<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
										</c:if>
									</li>
								</ul>
							</c:if>
						</c:forEach></td>
					</tr>
					<tr>
						<th>IaaS</th>
						<td class="goodsCtgry cate3">
						<c:forEach items="${loginData.ctgryList}" var="category">
							<c:if test="${category.CTGRYCLCD == '1003'}">
								<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
									<li><span>${category.CTGRYCLNM}</span><span>${category.CTGRYPATH}</span>
										<span class="txt-point">${category.CTGRYNM}</span>
										<c:if test="${category.CATEGORY_LANGCD eq '00'}">
											<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_${category.CTGRYCODE}" 
												onclick="jsCategoryDelete(this);" />
											<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
										</c:if>
									</li>
								</ul>
							</c:if>
						</c:forEach></td>
					</tr>								
			</table>	 --%>					
			<div class="btnArea rig">
				<a href="BD_outForm.do" class="f_l btns st1 icn icnPs">회원탈퇴 신청</a>
				<a href="/korean/pt/index.do" class="btns st2">취소</a> 
				<a href="#none" onclick="jsSubmit();" class="btns st1">저장</a>
			</div>
	</form>
</div>
</body>
</html>