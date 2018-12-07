<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>정보수정 - 일반 회원</title>
<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />

<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />
<c:if	test="${fn:startsWith(loginData.userTyCd,'10') || fn:startsWith(loginData.userTyCd,'20')}">
	<script type="text/javascript">
    var emailChk = "N"; <%-- 이메일 중복확인 체크용 --%>
    $().ready(function() {
         <c:if test="${param.pwdChg eq 'Y'}">
         $("#pwdChg").trigger("click");
         </c:if>
        $("#dataForm").validate({
            ignore: "",
            rules: {
//                  telno1            : { /*required: true,*/ number: true}
//                 ,telno2            : { /*required: true,*/ number: true}
//                 ,telno3            : { /*required: true,*/ number: true}
//                 ,intrlTelno        : { /*required: true,*/ maxlength: 6}
//                 ,lxtnTelno         : { number: true}
//                 ,nationCode        : { required: true}
                mbtlnum1          : { number: true, required: true}
                ,mbtlnum2          : { number: true, required: true}
                ,mbtlnum3          : { number: true, required: true}
                ,email             : { email2: true, required: true}
                ,email1            : { required: true}
//                ,email2            : { required: true, remote: "ND_emailDupleCheck.do"}
                ,email2            : { required: true}                
//                 ,zip1              : { number: true/*, required: true*/}
//                 ,zip2              : { number: true/*, required: true*/}
//                 ,bassAdres         : { required: true}
//                 ,detailAdres       : { required: true}
                 <c:if test="${userSetYn.cmpnyNm == 1003}">
                ,cmpnyNm           : { required: true}
                </c:if>
                <c:if test="${userSetYn.cmpnyRprsntvNm == 1003}">
                ,cmpnyRprsntvNm    : { required: true}
                </c:if>
            	 ,bizrno1           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
                ,bizrno2           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
                ,bizrno3           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
                ,cmpnyTelno1       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
                ,cmpnyTelno2       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
                ,cmpnyTelno3       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
                ,cmpnyLxtnTelno    : { number: true}
                ,cmpnyReprsntTelno1: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
                ,cmpnyReprsntTelno2: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
                ,cmpnyReprsntTelno3: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
                ,cmpnyFaxnum1      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
                ,cmpnyFaxnum2      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
                ,cmpnyFaxnum3      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
                ,cmpnyEmail        : { email2: true}
                   <c:if test="${userSetYn.cmpnyEmail == 1003}">
                ,cmpnyEmail1       : { required: true}
                ,cmpnyEmail2       : { required: true}
                </c:if>  
            	,cmpnyUrl          : { url: true${userSetYn.cmpnyUrl == 1003 ? ', required: true' : ''}}
                ,cmpnyZip1         : { number: true${userSetYn.cmpnyZip == 1003 ? ', required: true' : ''}}
                ,cmpnyZip2         : { number: true${userSetYn.cmpnyZip == 1003 ? ', required: true' : ''}}
                 <c:if test="${userSetYn.cmpnyBassAdres == 1003}">
                ,cmpnyBassAdres    : { required: true}
                </c:if>
                <c:if test="${userSetYn.cmpnyDetailAdres == 1003}">
                ,cmpnyDetailAdres  : { required: true}
                </c:if> 
                ,langStoreNms     : { rangelength: [2, 60]}
                ,langStoreIntrcns : { maxlength : 1000}
                ,storeChargerNms  : { maxlength : 100}
                ,reprsntTelnos1   : { number : true}
                ,reprsntTelnos2   : { number : true}
                ,reprsntTelnos3   : { number : true}
                ,reprsntEmails    : { email2: true}
                ,storeUrls        : { url : true}
             },
             messages : {
                  email         : { email2: "이메일 형식으로 입력해주세요."}
                 ,cmpnyEmail    : { email2: "회사이메일을 이메일 형식으로 입력해주세요."}
                 ,reprsntEmails : { email2: "다국어 판매정보의 이메일을 이메일 형식으로 입력해주세요."}
             },
             submitHandler : function(form) {
                 
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
                 
                 $("input[name=storeLangCodes]:checked").each(function(i) {
                     $("#langStoreNms"+$(this).val()).val($("#langStoreNms"+$(this).val()).val().replace(/, /g, "，").replace(/,/g, "，"));
                 });
                 $("input[name=storeLangCodes]:checked").each(function(i) {
                     $("#langStoreIntrcns"+$(this).val()).val($("#langStoreIntrcns"+$(this).val()).val().replace(/, /g, "，").replace(/,/g, "，"));
                 });

                 $(form).ajaxSubmit({
                     url      : "ND_checkDupleBizrno.do",
                     type     : "POST",
                     dataType : "text",
                     success  : function(response) {
                          if (response) {
                              $(form).ajaxSubmit({
                                  url      : "ND_updateAction.do",		//회원 정보 수정 하는 곳 
                                  type     : "POST",
                                  dataType : "text",
                                  success  : function(response) {
                                       if (response) {
                                           alert(Message.msg.memberModify);
                                         // 성공하면 메인으로 가기   
                                         //  window.location.replace("/<%=request.getServerName().substring(0, request.getServerName().indexOf("."))%>/pt/index.do");
                                           window.location.replace("/korean/pt/index.do");
                                       }else{
                                           alert(Message.msg.processFail);
                                       }
                                  }
                               });
                          }else{
                              $("#bizrno1").focus();
                              alert(Message.msg.bizrnoAlready);
                          }
                     }
                 });
             }
         });

        <c:forEach items="${loginData.userList}" var="store" varStatus="status">
         $("input[id='storeLang${store.langCode}']").attr("checked", true);
         $(".${store.langCode}").show();
         </c:forEach>
         <c:if test="${not empty loginData}">
         settingValue(updateSettingOptionDate);//기본정보 조회자료 세팅
         settingValue(updateSettingStoreDate);//회사정보 조회자료 세팅
         </c:if>

         <c:forEach items="${langList}" var="list">
         $(".${list.LANGCD}").click(function(){
             if($(".store${list.LANGCD}").is(":visible") == true){
                 if(confirm("선택 해제를 하면 해당 회사정보가 비활성화 됩니다.")){
                     $.ajax({
                         url      : "ND_checkStoreSales.do",
                         type     : "POST",
                         data     : {storeLangCode : '${list.LANGCD}'},
                         async    : false,
                         success  : function (response) {
                             if(response == 'true'){
                                 $(".store${list.LANGCD}").hide();
                                 $("#store${list.LANGCD}").removeClass('on');
                                 $("input[id='${list.LANGCD}']").prop("checked", false);
                             }else{
                                 if(confirm("등록하신 서비스가 있습니다. 확인을 누르시면 서비스가 비활성화 됩니다.")){
                                     $(".store${list.LANGCD}").hide();
                                     $("#store${list.LANGCD}").removeClass('on');
                                     $("input[id='${list.LANGCD}']").prop("checked", false);
                                 }
                                 $(".store${list.LANGCD}").show();
                                 $("#store${list.LANGCD}").addClass('on');
                                 $("input[id='${list.LANGCD}']").prop("checked", true);
                             }
                         }
                     });
                 } else {
                     $(".store${list.LANGCD}").show();
                     $("#store${list.LANGCD}").addClass('on');
                     $("input[id='${list.LANGCD}']").prop("checked", true);
                 }
             } else {
                 $(".store${list.LANGCD}").show();
                 $("#store${list.LANGCD}").addClass('on');
                 $("input[id='${list.LANGCD}']").prop("checked", true);
             }
         });
         </c:forEach>
         <c:forEach items="${loginData.userList}" var="store" varStatus="status">
         $("#${store.langCode}").trigger("click");
         </c:forEach>
         $("#delete").click(function(){
             jsFileDelete();
             $(".no-img").html("<img src='/new_cloud/images/sub/img-logo-noimg.jpg' alt='회사 로고 이미지' />");
             $("#multiFiles").empty();
             var control = $("#multiFiles");
             control.replaceWith( control = control.clone( true ) );
             /* $("#storeImgNm").empty(); */
         });
         <c:if test="${loginData.nationCode ne '410'}">
//          userNation();
         </c:if>

         categoryLangChange('00');
         $(".intrlTelno").change(function(){
             $(".intrlTelno").val($(this).val());
         });
     });//ready end

    updateSettingOptionDate = [{column:'telno', values:'${loginData.telno}', separation:'-', lang:''}
                              ,{column:'mbtlnum', values:'${loginData.mbtlnum}', separation:'-', lang:''}
                              ,{column:'email', values:'${loginData.email}', separation:'@', lang:''}
                              ,{column:'zip', values:'${loginData.zip}', separation:'-', lang:''}
                              ,{column:'bizrno', values:'${loginData.bizrno}', separation:'-', lang:''}
                              ,{column:'cmpnyTelno', values:'${loginData.cmpnyTelno}', separation:'-', lang:''}
                              ,{column:'cmpnyReprsntTelno', values:'${loginData.cmpnyReprsntTelno}', separation:'-', lang:''}
                              ,{column:'cmpnyFaxnum', values:'${loginData.cmpnyFaxnum}', separation:'-', lang:''}
                              ,{column:'cmpnyEmail', values:'${loginData.cmpnyEmail}', separation:'@', lang:''}
                              ,{column:'cmpnyZip', values:'${loginData.cmpnyZip}', separation:'-', lang:''}];

    updateSettingStoreDate = [
                          <c:forEach items="${loginData.userList}" var="store" varStatus="status">
                              ${!status.first ? ',' : ''}
                              {column:'langStoreNms', values:'${store.langStoreNm}', separation:'', lang:'${store.langCode}'}
                             ,{column:'storeChargerNms', values:'${store.storeChargerNm}', separation:'', lang:'${store.langCode}'}
                             ,{column:'reprsntTelnos', values:'${store.reprsntTelno}', separation:'-', lang:'${store.langCode}'}
                             ,{column:'reprsntEmails', values:'${store.reprsntEmail}', separation:'@', lang:'${store.langCode}'}
                             ,{column:'storeUrls', values:'${store.storeUrl}', separation:'', lang:'${store.langCode}'}
                         </c:forEach>
                             ];

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

    var jsZipcodePop = function (el, zcId, adr1, adr2) {
        $("#zipCodeId").val(zcId);
        $("#baseAddrId").val(adr1);
        $("#detailAddrId").val(adr2);
        $(el).colorbox({
            title : "우편번호 검색",
            href : "PD_searchList.do",
            width : "908",
            height : "800",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
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

    //파일 삭제
    var jsFileDelete = function(){
        $("#storeImg").remove();
        $("#multiFiles").attr("disabled",false);
    };

    
 	// 숫자만 입력하도록 체크
	function jsOnlyNumber(event){
		 var keyID = (event.which) ? event.which : event.keyCode;
		  if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
		else return false; alert(keyID);
	}
	
	// 숫자만 입력하도록 체크2
	function removeChar(event) {
		event = event || window.event;
		 var keyID = (event.which) ? event.which : event.keyCode;
		  if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9) return;
		else event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
    
	// 첨부파일 반영
	var jsFileChk = function(inputId, inputIdFake){
		document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
		
		var inputFile = document.getElementById(inputId);
		var filePath = inputFile.value;
		
		if(filePath == ""){
			return false;
		}
		document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
	};
	
	
    var readURL = function (input) {    <%-- 업로드 파일 미리보기 --%>
		if ( window.FileReader ) {
	        if (input.files && input.files[0]) {
	            fileName = input.files[0].name; // 파일명
	            /* $("#storeImgNm").text(fileName); */
	            ext = fileName.substring(fileName.lastIndexOf('.') + 1);//확장자
	            ext = ext.toLowerCase();
	            if(ext != 'gif' && ext != 'jpg' && ext !='jpeg' && ext !='png') {  <%-- 확장자 확인 --%>
	                $("#delete").trigger("click");
	                alert(ext+Message.msg.fileCannotUplaod);
	            } else {
	                var reader = new FileReader();
	                reader.onload = function (e) {
	                    if(e.target.result.indexOf("image/gif") > 0 || e.target.result.indexOf("image/jpg") > 0 || e.target.result.indexOf("image/jpeg") > 0 || e.target.result.indexOf("image/png") > 0){
	                        $(".no-img").html("<img src=\""+e.target.result+"\" alt=\"업로드 이미지 미리보기\" />");
	                    }
	                };
	                $("#dataForm").ajaxSubmit({
	                    url      : "ND_uploadImgChk.do",
	                    data     : { inputName    : 'multiFiles',
	                                 maxWidthSize : 0,
	                                 maxHeightSize : 0,
	                                 minWidthSize : 200,
	                                 minHeightSize : 100,
	                                 maxFileSize  : 10240,
	                                 fileExt : 'jpg,jpeg,gif,png'},
	                    type     : "POST",
	                    dataType : "text",
	                    async    : false,
	                    success  : function(response){
	                        if(response == "100") {
	                            reader.readAsDataURL(input.files[0]); <%-- 이미지 미리보기 영역에 이미지 세팅 --%>
	                        }else{
	                            $("#delete").trigger("click");
	                            alert(response);
	                            var control = $("#multiFiles");
	                            control.replaceWith(control = control.clone(true));
	                        }
	                    }
	                });
	            }
	        }
		} else {
	    	var source = $(input).val();

		    //확장자 잘라내기
		    var lastDot = source.lastIndexOf('.');
		    var ext = source.substring(lastDot + 1);
			var fileExt = "jpg,jpeg,gif,png";
		    if(fileExt.indexOf(ext.toLowerCase()) == -1){
		        $("#delete").trigger("click");
		        alert(ext+Message.msg.fileCannotUplaod);
		    } else {
			    $("#dataForm").ajaxSubmit({
			        url      : "ND_uploadImgChk.do",
			        data     : { inputName    : 'multiFiles',
			                     maxWidthSize : 0,
			                     maxHeightSize : 0,
			                     minWidthSize : 200,
			                     minHeightSize : 100,
			                     maxFileSize  : 10240,
			                     fileExt : 'jpg,jpeg,gif,png'},
			        type     : "POST",
			        dataType : "text",
			        async    : false,
			        success  : function(response){
			            if(response == "100") {
			                $(".no-img").html("<img src=\""+ "\" alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" />");
			<%--                 reader.readAsDataURL(input.files[0]); 이미지 미리보기 영역에 이미지 세팅 --%>
							alert($(input).val());
						
			            }else{
			                $("#delete").trigger("click");
			                alert(response);
			                var control = $("#multiFiles");
			                control.replaceWith(control = control.clone(true));
			            }
			        }
			    });
		    }
		}
    };

    var jsSubmit = function() { <%-- 저장액션 --%>
        if($("#email1").val() != '' || $("#email2").val() != ''){
            $("#email").val($("#email1").val()+"@"+$("#email2").val());
        }
        
        if($("#cmpnyEmail1").val() != '' || $("#cmpnyEmail2").val() != ''){
            $("#cmpnyEmail").val($("#cmpnyEmail1").val()+"@"+$("#cmpnyEmail2").val());
        }
        if($("#mbtlnum1").val() != '' && $("#mbtlnum2").val() != '' && $("#mbtlnum3").val() != ''){
            $("#mbtlnum").val($("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val());
        }
        <c:forEach items="${langList}" var="list">
        if($("#reprsntEmails1${list.LANGCD}").val() != '' || $("#reprsntEmails2${list.LANGCD}").val() != ''){
            $("#reprsntEmails${list.LANGCD}").val($("#reprsntEmails1${list.LANGCD}").val()+"@"+$("#reprsntEmails2${list.LANGCD}").val());
        }
        </c:forEach>
        if($("#email1").val()+"@"+$("#email2").val() != "${loginData.email}" && emailChk == "N"){
            alert(Message.msg.checkDupEmail);
            $("#emailChk").focus();
            return false;
        } else{
            $("#dataForm").submit();
        }
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
       // event.preventDefault(el);
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

    <c:if test="${loginData.nationCode ne '410'}">
    var userNation = function(){    <%-- 국가 코드및 국제전화번호 세팅 스크립트 --%>
        if($("select[id='nationName'] option:selected").val() != ''){
            INTRLTELNL1 = $("select[id='nationName'] option:selected").text().split("(");
            INTRLTELNL2 = INTRLTELNL1[1].split(")");
            $("#nationCode").val($("#nationName").val());
            $(".intrlTelno").val(INTRLTELNL2[0]);
            if(INTRLTELNL2[0] == ''){
                $(".intrlTelno").attr("readonly", false);
            } else {
                $(".intrlTelno").attr("readonly", true);
            }
        }
    };
    </c:if>

    var jsCheckDupleStoreNm = function(langCd) {
        if($("#langStoreNms"+langCd).val().length < 2){
            alert(Message.msg.storeNmEmpty);
            $("#langStoreNms"+langCd).focus();
            return false;
        }
        $.post("ND_checkDupleStoreNm.do", {
            userId : '${loginData.userId}',
            langCode : langCd,
            langStoreNm : $("#langStoreNms"+langCd).val()
        }, function(response) {
            if(response == 'true') {
                alert(Message.msg.storeNmAvailable);
                $("input[name='storeChk"+langCd+"']").val("Y");
                $("#langStoreIntrcns"+langCd).focus();
            } else {
                $("#langStoreNms"+langCd).focus();
                alert($("#langStoreNms"+langCd).val()+Message.msg.storeNmAlready);
                $("input[name='storeChk"+langCd+"']").val("N");
                return false;
            }
        }, 'text');
    };

    var jsStoreNmReset = function(langCd) {
        $("input[name='storeChk"+langCd+"']").val("N");
    };

    var categoryLangChange = function(langCd) {
        $("#categoryLangCode").val(langCd);
        $(".first span").html("<strong>"+$("select[id='categoryLangCode'] option:selected").text()+"</strong>");
        $("ul[class^=langCategory]").hide();
        $(".langCategory"+langCd).show();
    };

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
	<form id="dataForm" onsubmit="return false;">
		<!-- 우편번호 코드 ID -->
<!-- 		<input type="hidden" id="zipCodeId" value="" /> -->
		<!-- 기본주소 코드 ID -->
<!-- 		<input type="hidden" id="baseAddrId" value="" /> -->
		<!-- 상세주소 코드 ID -->
<!-- 		<input type="hidden" id="detailAddrId" value="" /> -->
		<!-- 전화번호 -->
<!-- 		<input type="hidden" id="telno"	name="telno" value="" /> -->
		<!-- 휴대폰번호 -->
		<input type="hidden" id="mbtlnum" name="mbtlnum" value="" />
		<!-- 이메일주소 -->
		<input type="hidden" id="email" name="email" value="" />
		<!-- 우편번호 -->
<!-- 		<input type="hidden" id="zip" name="zip" value="" /> -->
		<!-- 사업자등록번호 -->
<!-- 		<input type="hidden" id="bizrno" name="bizrno" value="" /> -->
		<!-- 회사INFO -->
<!-- 		<input type="hidden" id="cmpnyTelno" name="cmpnyTelno" value="" /> -->
<!-- 		<input type="hidden" id="cmpnyReprsntTelno" name="cmpnyReprsntTelno" value="" /> -->
<!-- 		<input type="hidden" id="cmpnyFaxnum" name="cmpnyFaxnum" value="" /> -->
<!-- 		<input type="hidden" id="cmpnyZip" name="cmpnyZip" value="" /> -->
		<!-- 사용자 유형 코드 -->
		<input type="hidden" id="userTyCd" name="userTyCd" value="<c:out value='${loginData.userTyCd}' />" />
		<!-- 언어코드 -->
		<input type="hidden" id="langCode" name="langCode" value="<c:out value='${loginData.langCode}' />" />
		<input type="hidden" id="setCtgryCodes" value="
			<c:forEach items="${loginData.ctgryList}" var="category" varStatus="status">
				<c:if test="${category.LANGCODE eq '00'}">${category.CTGRYCODE}${!status.last? ',' : ''}</c:if>
			</c:forEach>" />
		<!-- 국제전화번호 -->
<!-- 		<input type="hidden" id="intrlTelno" name="intrlTelno" value=""	class="intrlTelno" /> -->
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
			<c:if test="${loginData.userTyCd ne '1001'}">
			<tr>
				<th class="requ">기업명 </th>
				<td>${loginData.cmpnyNm}</td>
			</tr>
			</c:if>
			<tr>
				<th class="requ">아이디</th>
				<td>${loginData.userId}</td>
			</tr>
			<tr>
				<th class="requ">비밀번호</th>
				<td>
					<a href="#" id="pwdChg" onclick="passwordUpdete(this);" title="팝업 창 열림" class="btns st3">비밀번호 변경</a> 
					※ 비밀번호는 3개월에 한번 씩 변경하시는 것이 안전합니다.
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
				    <span class="sel_box">
						<select id = "mbtlnum1" name="mbtlnum1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
						</select>
					</span>
					 -
					<input type="text" id="mbtlnum2" name="mbtlnum2" title="휴대전화번호 가운데자리를 입력해주세요."  maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/> - 
					<input type="text" id="mbtlnum3" name="mbtlnum3" title="휴대전화번호 뒷자리를 입력해주세요." maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/>
					<%-- 
					<c:if test="${fn:startsWith(loginData.userTyCd, '10')}">
						<span class="caption ml20">이벤트/정보 SMS</span>
						<span class="agree"><op:code id="smsRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002" /></span>
					</c:if>
					<p class="caption mt10">※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과 관련된 내용은 수신동의 여부와 관계없이 SMS가 발송됩니다.</p>
					--%>
				</td>
			</tr>
			<tr>
				<th>이메일 주소</th>
				<td colspan="3" class="inputEmail">
					<!--  이메일 수정불가 --> 
					<input type="text" id="email1" name="email1" readonly="readonly" />
					@ 
					<input type="text" id="email2" name="email2" readonly="readonly" /> 
<!-- 					<span class="sel_box"> -->
<!-- 					<select> -->
<%-- 						<option>직접입력</option>								 --%>
<!-- 					</select> -->
<!-- 					</span> -->
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
							<op:code id="emailRecptnAgreCd" grpCd="77" type="radio"
								defaultValues="${empty loginData.emailRecptnAgreCd ? '1002' : loginData.emailRecptnAgreCd}" />
						</dd>
						<c:if test="${fn:startsWith(loginData.userTyCd,'10') || fn:startsWith(loginData.userTyCd,'20')}">
							<dt>뉴스레터/세미나</dt>
							<dd>
								<op:code id="nsletRecptnAgreCd" grpCd="77" type="radio" defaultValues="${empty loginData.nsletRecptnAgreCd ? '1002' : loginData.nsletRecptnAgreCd}" />
							</dd>
						</c:if>
						<c:if test="${fn:startsWith(loginData.userTyCd,'30')}">
							<input type="hidden" id="nsletRecptnAgreCd" name="nsletRecptnAgreCd" value="1002" />
						</c:if>
						<dt>입찰공고 이메일</dt>
						<dd>
							<op:code id="bidRecptnAgreCd" grpCd="77" type="radio" defaultValues="${empty loginData.bidRecptnAgreCd ? '1002' : loginData.bidRecptnAgreCd}" />
						</dd>
					</dl>
					<p>※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과 관련된 내용은 수신동의 여부와 관계없이 이메일이 발송됩니다.</p>
				</td>
			</tr>
		</table>
		<%-- 
		<h4>관심분야(다중선택 가능)<a href="" id="categorySelect" title="팝업창 열림" onclick="jsCategoryPop(this);" class="btns st3">선택</a></h4>
		<table class="tbl_st4">
			<tr>
				<th>SaaS</th>
				<td class="goodsCtgry cate2">
				<c:forEach items="${loginData.ctgryList}" var="category">
					<c:if test="${category.CTGRYCLCD == '1002'}">
						<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}" >
							<li><span>${category.CTGRYCLNM}</span><span>${category.CTGRYPATH}</span>
								<span class="txt-point">${category.CTGRYNM}</span>
								<c:if test="${category.CATEGORY_LANGCD eq '00'}">
									<img src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" id="goodsCtgry_${category.CTGRYCODE}"
										onclick="jsCategoryDelete(this);" />
									<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
								</c:if></li>
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
								</c:if></li>
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
								</c:if></li>
						</ul>
					</c:if>
				</c:forEach></td>
			</tr>
		</table>	
	 --%>
		<div class="btnArea rig">
			<a href="BD_outForm.do" class="f_l btns st1 icn icnPs">회원탈퇴 신청</a>
			<a href="/korean/pt/index.do" class="btns st2">취소</a>
			<a href="#none" onclick="jsSubmit();" class="btns st1">저장</a>
		</div>
		
		</form>
	</div>

</body>
</html>