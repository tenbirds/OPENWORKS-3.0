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
                 telno1            : { /*required: true,*/ number: true}
                ,telno2            : { /*required: true,*/ number: true}
                ,telno3            : { /*required: true,*/ number: true}
                ,intrlTelno        : { /*required: true,*/ maxlength: 6}
                ,lxtnTelno         : { number: true}
                ,nationCode        : { required: true}
                ,mbtlnum1          : { number: true, required: true}
                ,mbtlnum2          : { number: true, required: true}
                ,mbtlnum3          : { number: true, required: true}
                ,email             : { email2: true, required: true}
                ,email1            : { required: true}
                ,email2            : { required: true, remote: "ND_emailDupleCheck.do"}
                ,zip1              : { number: true/*, required: true*/}
                ,zip2              : { number: true/*, required: true*/}
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
                 <c:if test="${(loginData.userTyCd eq '1002') || (loginData.userTyCd == '2002')}">
                 if(${loginData.userTyCd} == '1002' || ${loginData.userTyCd} == '2002' || ${not empty userTyCd2}){
                     if($("input[name='storeLangCodes']:checked").length > 0){
                         affected = 'Y';
                         //모든테이블을 비활성
                         $("#storeInfo *").attr("disabled",true);
                         $("input[name=storeLangCodes]:checked").each(function(i) {
                             //선택된 테이블만 활성
                             $(".store"+$(this).val()+" *").attr("disabled",false);
                             <c:if test="${storeSetYn.langStoreNm == 1003}">
                             if($("#langStoreNms"+$(this).val()).val() == ''){
                                 alert(Message.msg.storeNmEmpty);
                                 $("#langStoreNms"+$(this).val()).focus();
                                 affected = 'N';
                                 return;
                             }
                             </c:if>
                             <c:if test="${storeSetYn.langStoreIntrcn == 1003}">
                             if($("#langStoreIntrcns"+$(this).val()).val() == ''){
                                 alert(Message.msg.sotreIntrcnEmpty);
                                 $("#langStoreIntrcns"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             <c:if test="${storeSetYn.storeChargerNm == 1003}">
                             if($("#storeChargerNms"+$(this).val()).val() == ''){
                                 alert(Message.msg.storeChargeNmEmpty);
                                 $("#storeChargerNms"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             <c:if test="${storeSetYn.reprsntTelno == 1003}">
                             if($("#reprsntTelnos1"+$(this).val()).val() == '' || $("#reprsntTelnos2"+$(this).val()).val() == '' || $("#reprsntTelnos3"+$(this).val()).val() == ''){
                                 alert(Message.msg.telnoEmpty);
                                 $("#reprsntTelnos1"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             <c:if test="${storeSetYn.reprsntEmail == 1003}">
                             if($("#reprsntEmails1"+$(this).val()).val() == '' || $("#reprsntEmails2"+$(this).val()).val() == ''){
                                 alert(Message.msg.emptyEmail);
                                 $("#reprsntEmails1"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             }else{
                                 //if($("#reprsntEmails1"+$(this).val()).val() != '' && $("#reprsntEmails2"+$(this).val()).val() != ''){
                                     $("#reprsntEmails"+$(this).val()).val($("#reprsntEmails1"+$(this).val()).val()+"@"+$("#reprsntEmails2"+$(this).val()).val());
                                 //}
                                 if($.trim($("#reprsntEmails"+$(this).val()).val()) != ''){
                                     var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                                     if(!emailExp.test($("#reprsntEmails"+$(this).val()).val())){
                                         alert(Message.msg.validEmail);
                                         $("#reprsntEmails1"+$(this).val()).focus();
                                         affected = 'N';
                                         return false;
                                     }
                                 }
                             }
                             </c:if>
                             <c:if test="${storeSetYn.storeUrl == 1003}">
                             if($("#storeUrls"+$(this).val()).val() == ''){
                                 alert(Message.msg.storeUrlEmpty);
                                 $("#storeUrls"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             if($("input[name='storeChk"+$(this).val()+"']").val() == 'N') {
                                 $("#storeChk"+$(this).val()).focus();
                                 alert(Message.msg.storeNmDupChk);
                                 affected = 'N';
                                 return false;
                             }
                             if($("#reprsntTelnos1"+$(this).val()).val() != '' && $("#reprsntTelnos2"+$(this).val()).val() != '' && $("#reprsntTelnos3"+$(this).val()).val() != ''){
                                 $("#reprsntTelnos"+$(this).val()).val($("#reprsntTelnos1"+$(this).val()).val()+"-"+$("#reprsntTelnos2"+$(this).val()).val()+"-"+$("#reprsntTelnos3"+$(this).val()).val());
                             }
                             if($("#reprsntEmails1"+$(this).val()).val() != '' && $("#reprsntEmails2"+$(this).val()).val() != ''){
                                 $("#reprsntEmails"+$(this).val()).val($("#reprsntEmails1"+$(this).val()).val()+"@"+$("#reprsntEmails2"+$(this).val()).val());
                             }
                         });
                         if(affected == 'N'){
                             //검증 실패시 모든테이블을 활성
                             $("#storeInfo *").attr("disabled",false);
                             return;
                         }
                     } else {
                         $("#00").focus();
                         alert(Message.msg.storeChoice);
                         return;
                     }
                 }
                 </c:if>
                 if($("#telno1").val() != '' && $("#telno2").val() != '' && $("#telno3").val() != ''){
                     $("#telno").val($("#telno1").val()+"-"+$("#telno2").val()+"-"+$("#telno3").val());
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
                 if($("#zip1").val() != '' && $("#zip2").val() != ''){
                     $("#zip").val($("#zip1").val()+"-"+$("#zip2").val());
                 }
                 if($("#bizrno1").val() != '' && $("#bizrno2").val() != '' && $("#bizrno3").val() != ''){
                     $("#bizrno").val($("#bizrno1").val()+"-"+$("#bizrno2").val()+"-"+$("#bizrno3").val());
                 }
                 if($("#cmpnyTelno1").val() != '' && $("#cmpnyTelno2").val() != '' && $("#cmpnyTelno3").val() != ''){
                     $("#cmpnyTelno").val($("#cmpnyTelno1").val()+"-"+$("#cmpnyTelno2").val()+"-"+$("#cmpnyTelno3").val());
                 }
                 if($("#cmpnyReprsntTelno1").val() != '' && $("#cmpnyReprsntTelno2").val() != '' && $("#cmpnyReprsntTelno3").val() != ''){
                     $("#cmpnyReprsntTelno").val($("#cmpnyReprsntTelno1").val()+"-"+$("#cmpnyReprsntTelno2").val()+"-"+$("#cmpnyReprsntTelno3").val());
                 }
                 if($("#cmpnyFaxnum1").val() != '' && $("#cmpnyFaxnum2").val() != '' && $("#cmpnyFaxnum3").val() != ''){
                     $("#cmpnyFaxnum").val($("#cmpnyFaxnum1").val()+"-"+$("#cmpnyFaxnum2").val()+"-"+$("#cmpnyFaxnum3").val());
                 }
                 if($("#cmpnyEmail1").val() != '' && $("#cmpnyEmail2").val() != ''){
                     $("#cmpnyEmail").val($("#cmpnyEmail1").val()+"@"+$("#cmpnyEmail2").val());
                 }
                 if($.trim($("#cmpnyEmail").val()) != ''){
                      var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                      if(!emailExp.test($('#cmpnyEmail').val())){
                           alert(Message.msg.validEmail);
                           $('#cmpnyEmail1').focus();
                           return;
                      }
                 }
                 if($("#cmpnyZip1").val() != '' && $("#cmpnyZip2").val() != ''){
                     $("#cmpnyZip").val($("#cmpnyZip1").val()+"-"+$("#cmpnyZip2").val());
                 } else if($("#cmpnyZip1").val() != '' && $("#cmpnyZip2").val() == ''){
                     $("#cmpnyZip").val($("#cmpnyZip1").val());
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
         userNation();
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
            width  : "907",
            height : "750",
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
            height : "720",
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
                        htmlVal2 += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />';
                        htmlVal2 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    } else if(response[i].ctgryClNm == 'PaaS') {
                        htmlVal1 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal1 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal1 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal1 += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />';
                        htmlVal1 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    } else {
                        htmlVal3 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal3 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal3 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal3 += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />';
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
        event.preventDefault(el);
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
            	 telno1            : { /*required: true,*/ number: true}
                ,telno2            : { /*required: true,*/ number: true}
                ,telno3            : { /*required: true,*/ number: true}
                ,intrlTelno        : { /*required: true,*/ maxlength: 6}
                ,lxtnTelno         : { number: true}
                ,nationCode        : { required: true}
                ,mbtlnum1          : { number: true, required: true}
                ,mbtlnum2          : { number: true, required: true}
                ,mbtlnum3          : { number: true, required: true}
                ,email             : { email2: true, required: true}
                ,email1            : { required: true}
                ,email2            : { required: true, remote: "ND_emailDupleCheck.do"}
                
                ,pblinsttNm          : { required: true}
                //,pblinsttCd          : { required: true}
                //,bizrno2             : { number: true, required: true}
                //,bizrno3           	 : { number: true, required: true}
                //,pblinsttUrl         : { url: true, required: true}
                //,pblinsttZip         : { number: true, required: true}
                //,pblinsttBassAdres   : { required: true}
                //,pblinsttDetailAdres : { required: true}
			},
            messages : {
            	email         : { email2: "이메일 형식으로 입력해주세요."}
            },
            submitHandler : function(form) {
                 
            	if($("#telno1").val() != '' && $("#telno2").val() != '' && $("#telno3").val() != ''){
                	$("#telno").val($("#telno1").val()+"-"+$("#telno2").val()+"-"+$("#telno3").val());
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
				/* 
                if($("#bizrno1").val() != '' && $("#bizrno2").val() != '' && $("#bizrno3").val() != ''){
                    $("#bizrno").val($("#bizrno1").val()+"-"+$("#bizrno2").val()+"-"+$("#bizrno3").val());
                } else {
                    $("#bizrno").val('');
                }
                 */
                 
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

	updateSettingOptionDate = [{column:'telno', values:'${loginData.telno}', separation:'-', lang:''}
                              ,{column:'mbtlnum', values:'${loginData.mbtlnum}', separation:'-', lang:''}
                              ,{column:'email', values:'${loginData.email}', separation:'@', lang:''}];

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
/* 
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
            iframe : true,
            returnFocus : false,
	        trapFocus : false
        });
    };
     */
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
            width  : "907",
            height : "750",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
    };
    
    var jsSubmit = function() { <%-- 저장액션 --%>
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

    var jsCategoryPop = function(el) {
        $(el).colorbox({
            title  : "관심 카테고리 선택하기",
            href   : "PD_categoryPop.do?PID=UM01",
            width  : "900",
            height : "720",
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
                        htmlVal2 += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />';
                        htmlVal2 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    } else if(response[i].ctgryClNm == 'PaaS') {
                        htmlVal1 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal1 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal1 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal1 += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />';
                        htmlVal1 += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" /></li></ul>';
                    } else {
                        htmlVal3 += '<ul class="langCategory00 goodsCtgry_'+response[i].ctgryCode+'"><li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal3 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal3 += '<span class="tx_orange">'+response[i].ctgryNm+'</span>';
                        htmlVal3 += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />';
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
        event.preventDefault(el);
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
	<!-- container -->
	<div id="container" class="join-wrap">
		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
			<form id="dataForm" onsubmit="return false;">
				<!-- 우편번호 코드 ID -->
				<input type="hidden" id="zipCodeId" value="" />
				<!-- 기본주소 코드 ID -->
				<input type="hidden" id="baseAddrId" value="" />
				<!-- 상세주소 코드 ID -->
				<input type="hidden" id="detailAddrId" value="" />
				<!-- 전화번호 -->
				<input type="hidden" id="telno"	name="telno" value="" />
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

				<div class="title-area">
					<h2>회원정보 변경</h2>
				</div>
				<!-- //title-area -->

				<!-- section : 개인정보 -->
				<div class="section">
					<div class="txt-info">
						<h4>
							개인 정보<span class="txt-sub">${userTyNm1}회원(${userTyNm2})</span>
						</h4>
						<!-- 구매회원으로 테스트해보기 -->
						<%-- <c:if test="${fn:endsWith(loginData.userTyCd, '01')}">
									 <div class="mt10">     
										<c:if test="${loginData.nationCode == 410}">
		                                    <a href="BD_userCrtfc.do?userTyCd=&amp;nationCode=${loginData.nationCode}" title="판매회원 전환하기" class="b-btn gift type3"><strong><span>판매회원 전환하기 </span></strong></a>
		                                </c:if>
		                                <c:if test="${loginData.nationCode != 410}">
		                                    <a href="BD_index.do?userTyCd=&amp;nationCode=${loginData.nationCode}" title="판매회원 전환하기" class="b-btn gift type3"><span>판매회원 전환하기 </span></a>
		                                </c:if>
		                                <span class="ml10 caption">판매회원</span>
		                                <span class="tooltip">
											<a href="#" class="s-btn w20 tooltip type1"><strong><label>?</label></strong></a>
											<div class="tooltip-box">
												<strong>판매 전환신청</strong>
	                                 					<p>판매자로써의 권한을 신청할 수 있습니다.</p>
											</div>
										</span>
		                            </div>
		                    </c:if> --%>
						<!-- 구매회원으로 테스트해보기 끝 -->
					</div>
					<div class="join-area">
						<div class="type-write">
							<fieldset>
								<legend>
									<span>회원 정보 변경 서식</span>
								</legend>
								<table>
									<colgroup>
										<col style="width: 150px;" />
										<col style="width: 365px;" />
										<col style="width: 150px;" />
										<col style="width:;" />
									</colgroup>
									<tbody>
										<tr>
											<th id="m_id"><span>아이디</span></th>
											<td headers="m_id">${loginData.userId}</td>
											<th id="m_type"><span>
													<!-- 회원유형 -->
											</span></th>
											<th><c:if
													test="${fn:startsWith(loginData.userTyCd,'30')}">
													<input type="checkbox" id="dmandExaminChargerAt"
														name="dmandExaminChargerAt" value="Y"
														<c:if test="${loginData.dmandExaminChargerAt eq 'Y'}">checked="checked"</c:if> />
													<span><label for="dmandExaminChargerAt">수요조사
															담당자</label></span>
												</c:if> <%-- ${fn:startsWith(loginData.userTyCd, '10')?'개인':'기업'}회원 (${fn:endsWith(loginData.userTyCd, '01')?'구매':'판매'}) --%>
											</th>
										</tr>
										<tr>
											<th><span>비밀번호 변경</span></th>
											<td colspan="3">
												<a href="" id="pwdChg" onclick="passwordUpdete(this);" title="팝업 창 열림"	class="b-btn type1">
												<strong><span>비밀번호 변경</span></strong></a>
												<span class="caption ml10">※ 비밀번호는 3개월에 한번 씩 변경하시는 것이 안전합니다.</span>
											</td>
										</tr>
										<tr>
											<th><span>이름</span></th>
											<td>${loginData.userNm}</td>
											<th id="m_nation"><c:if
													test="${loginData.nationCode != 410}">
													<span class="point">국가</span>
												</c:if></th>
											<td headers="m_nation"><c:if
													test="${loginData.nationCode != 410}">
												<span class="sel_box">	
													<select id="nationName" onchange="userNation();">
														<option value="">--- 선택 ---</option>
														<c:forEach items="${nation}" var="list">
															<option value="${list.NATIONCODE}"
																${loginData.nationCode == list.NATIONCODE ? 'selected="selected"' : ''}><c:out
																	value="${list.LANGNATIONNM}" />(
																<c:out value="${list.INTRLTELNL}" />)
															</option>
														</c:forEach>
													</select>
													</span>
												</c:if> <input type="hidden" id="nationCode" name="nationCode"
												value="${loginData.nationCode == 410 ? 410 : ''}" /> <c:if
													test="${loginData.nationCode == 410}">
													<input type="hidden"
														value="<c:out value='${loginData.nationNm}' />"
														readonly="readonly" title="국가명 입력" class="w304">
												</c:if></td>
										</tr>
										<!-- 2016.11.28 성별,생년월일, 전화번호 선택 없음 -->
										<%-- <tr>
											<th><span>성별</span></th>
											<td colspan="3"><c:choose>
													<c:when test="${loginData.sexdstnCd == 1001}">남성</c:when>
													<c:when test="${loginData.sexdstnCd == 1002}">여성</c:when>
													<c:otherwise>기타</c:otherwise>
												</c:choose></td>
										</tr>
										<tr>
											<th><span>생년월일</span></th>
											<td colspan="3">${loginData.brthdy}</td>
										</tr>
										<tr>
											<th><span>전화번호</span></th>
											<td colspan="3"><input type="text"
												value="<c:out value='${loginData.intrlTelno}' />"
												readonly="readonly" title="국가번호 입력"
												class="w124 bg intrlTelno" /><input type="text"
												title="전화번호 지역번호를 입력해주세요." id="telno1" name="telno1"
												maxlength="3" class="w124 ml10" /><span class="space">-</span><input
												type="text" title="전화 국번을 입력해주세요." value="" id="telno2"
												name="telno2" maxlength="4" class="w124" /><span
												class="space">-</span><input type="text"
												title="전화번호 뒷자리를 입력해주세요." value="" id="telno3" name="telno3"
												maxlength="4" class="w124" /> <span class="caption ml20">내선</span><input
												type="text" title="내선번호 입력해주세요." name="lxtnTelno"
												value="<c:out value='${loginData.lxtnTelno}' />"
												maxlength="4" class="w124 ml10" /></td>
										</tr> --%>
										<tr>
											<th><span class="point">휴대전화</span></th>
											<td colspan="3"><input type="text"
												value="<c:out value='${loginData.intrlTelno}' />"
												readonly="readonly" title="국가번호 입력"
												class="w124 bg intrlTelno" /><input type="text"
												id="mbtlnum1" name="mbtlnum1" title="휴대전화번호 앞자리를 입력해주세요."
												maxlength="3" class="w124 ml10" /><span class="space">-</span><input
												type="text" id="mbtlnum2" name="mbtlnum2"
												title="휴대전화번호 가운데자리를 입력해주세요." maxlength="4" class="w124" /><span
												class="space">-</span><input type="text" id="mbtlnum3"
												name="mbtlnum3" title="휴대전화번호 뒷자리를 입력해주세요." maxlength="4"
												class="w124" /> <c:if
													test="${fn:startsWith(loginData.userTyCd, '10')}">
													<span class="caption ml20">이벤트/정보 SMS</span>
													<span class="agree"><op:code id="smsRecptnAgreCd"
															grpCd="77" type="radio" defaultValues="1002" /></span>
												</c:if>
												<p class="caption mt10">※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과
													관련된 내용은 수신동의 여부와 관계없이 SMS가 발송됩니다.</p></td>
										</tr>
										<tr>
											<th><span class="point">이메일 주소</span></th>
											<td colspan="3">
											<input type="text" id="email1" name="email1" title="이메일 주소를 입력해 주세요."
												onchange="jsEmailReset();" maxlength="24" class="w194" />
											<span class="space">@</span>
											<input type="text" id="email2" name="email2" title="도메인을 입력해 주세요."
												onchange="jsEmailReset();" maxlength="24" class="w194" />
											<input type="hidden" id="email" name="email" value="" />
												<div class="select-area" id="emailList1">
													<div class="sech_form">
														<span class="selected" style="margin-left: 2px;">
														<op:code id="emailList" grpCd="80" onchange="jsEmailList('email');" defaultLabel="직접입력" /></span>
													</div>
												</div>
											<a href="#email1" id="emailChk" onclick="emailCheck();"
												title="팝업 창 열림" class="b-btn ml10 type1">
												<strong><span>중복 확인</span></strong></a>
											</td>
										</tr>
										<tr>
											<th><span class="point">이메일 수신동의</span></th>
											<td colspan="3">
												<ul class="check-list">
													<li><strong>광고홍보 이메일</strong> <span> <span
															class="agree"><op:code id="emailRecptnAgreCd"
																	grpCd="77" type="radio"
																	defaultValues="${empty loginData.emailRecptnAgreCd ? '1002' : loginData.emailRecptnAgreCd}" /></span>
													</span></li>
													<c:if
														test="${fn:startsWith(loginData.userTyCd,'10') || fn:startsWith(loginData.userTyCd,'20')}">
														<li><strong>뉴스레터/세미나 이메일</strong> <span> <span
																class="agree"><op:code id="nsletRecptnAgreCd"
																		grpCd="77" type="radio"
																		defaultValues="${empty loginData.nsletRecptnAgreCd ? '1002' : loginData.nsletRecptnAgreCd}" /></span>
														</span></li>
													</c:if>
													<c:if test="${fn:startsWith(loginData.userTyCd,'30')}">
														<input type="hidden" id="nsletRecptnAgreCd"
															name="nsletRecptnAgreCd" value="1002" />
													</c:if>
													<li>
													<strong>입찰공고 이메일</strong> 
														<span>
															<span class="agree">
																<op:code id="bidRecptnAgreCd"	grpCd="77" type="radio"
																		defaultValues="${empty loginData.bidRecptnAgreCd ? '1002' : loginData.bidRecptnAgreCd}" /></span>
														</span>
													</li>
												</ul>
												<p class="mt20 caption">※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과
													관련된 내용은 수신동의 여부와 관계없이 이메일이 발송됩니다.</p>
											</td>
										</tr>
										<%-- 
							<tr>
								<th><span>주소</span></th>
								<td colspan="3"><input type="text" id="zip1" name="zip1" title="우편번호 앞자리를 입력해주세요." readonly="readonly" maxlength="4" class="w124" /><span class="space">-</span><input type="text" id="zip2" name="zip2" title="우편번호 뒷자리를 입력해주세요." readonly="readonly" maxlength="4" class="w124" /><a href="#baseAddr1" onclick="jsZipcodePop(this,'zip','bassAdres','detailAdres');" title="팝업 창 열림" class="b-btn ml10 type1"><strong><span>우편번호</span></strong></a><br /><input type="text" id="bassAdres" name="bassAdres" value="<c:out value='${loginData.bassAdres}' />"title="주소를 입력해주세요." maxlength="100" class="w404 mt10" /><input type="text" id="detailAdres" name="detailAdres" value="<c:out value='${loginData.detailAdres}' />" title="주소를 입력해주세요."  maxlength="100" class="w404 mt10 ml10" /></td>
							</tr>
							 --%>
									</tbody>
								</table>

							</fieldset>
						</div>
					</div>
				</div>
				<!-- //section : 개인 정보 -->
				<!-- section 회사 정보 -->
				<div class="section">
					<c:if
						test="${fn:startsWith(loginData.userTyCd,'10') || fn:startsWith(loginData.userTyCd,'20')}">
						<div class="txt-info">
							<h4>기업 정보</h4>
						</div>
						<div class="join-area">
							<div class="type-write">
								<table>
									<colgroup>
										<col style="width: 150px;" />
										<col style="width:;" />
									</colgroup>
									<tbody>
										<!-- 회사명 -->
										<c:if test="${userSetYn.cmpnyNm != 1002}">
											<tr>
												<th scope="row">
													<c:choose>
														<c:when test="${userSetYn.cmpnyNm == 1003}">
															<span class="point">회사명</span>
														</c:when>
														<c:otherwise>
															<span>회사명</span>
														</c:otherwise>
													</c:choose>
												</th>
												<td><input type="text" id="cmpnyNm" name="cmpnyNm"
													value="<c:out value='${loginData.cmpnyNm}' />"
													maxlength="100"
													${loginData.sbscrbTyCd == 1004 ? 'readonly="readonly"' : ''}
													class="w304" /></td>
											</tr>
										</c:if>
										<!-- 2016.11.28 기업정보 변경 -->
										<%-- <!-- 회사 대표자 이름 -->
										<c:if test="${userSetYn.cmpnyRprsntvNm != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.cmpnyRprsntvNm == 1003}">
															<span class="point">회사 대표자 이름</span>
														</c:when>
														<c:otherwise>
															<span>회사 대표자 이름</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text" id="cmpnyRprsntvNm"
													name="cmpnyRprsntvNm"
													value="<c:out value='${loginData.cmpnyRprsntvNm}' />"
													maxlength="100" title="회사 대표자이름을 입력해주세요." class="w304" />
												</td>
											</tr>
										</c:if>
										<!-- 사업자 등록번호 -->
										<c:if test="${userSetYn.bizrno != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.bizrno == 1003}">
															<span class="point">사업자 등록번호</span>
														</c:when>
														<c:otherwise>
															<span>사업자 등록번호</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text" id="bizrno1" name="bizrno1"
													title="사업자등록번호 앞자리를 입력해주세요."
													${loginData.sbscrbTyCd == 1004 ? 'readonly="readonly"' : ''}
													maxlength="3" class="w124" /><span class="space">-</span><input
													type="text" id="bizrno2" name="bizrno2"
													title="사업자등록번호 가운데 자리를 입력해주세요."
													${loginData.sbscrbTyCd == 1004 ? 'readonly="readonly"' : ''}
													maxlength="2" class="w124" /><span class="space">-</span><input
													type="text" id="bizrno3" name="bizrno3"
													title="사업자등록번호 뒷자리를 입력해주세요."
													${not empty param.bizrno ? 'readonly="readonly"' : ''}
													maxlength="5" class="w124" /></td>
											</tr>
										</c:if>
										<!-- 회사 대표번호 -->
										<c:if test="${userSetYn.cmpnyReprsntTelno != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.cmpnyReprsntTelno == 1003}">
															<span class="point">회사 대표번호</span>
														</c:when>
														<c:otherwise>
															<span>회사 대표번호</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text"
													value="<c:out value='${loginData.intrlTelno}' />"
													readonly="readonly" title="국가번호 입력"
													class="w124 bg intrlTelno" /><input type="text"
													id="cmpnyReprsntTelno1" name="cmpnyReprsntTelno1"
													title="전화 지역번호를 입력해주세요." maxlength="3" class="w124 ml10" /><span
													class="space">-</span><input type="text"
													id="cmpnyReprsntTelno2" name="cmpnyReprsntTelno2"
													title="전화 국번을 입력해주세요." maxlength="4" class="w124" /><span
													class="space">-</span><input type="text"
													id="cmpnyReprsntTelno3" name="cmpnyReprsntTelno3"
													title="전화번호 뒷자리를 입력해주세요." maxlength="4" class="w124" /> <span
													class="caption ml20">내선</span><input type="text"
													id="cmpnyLxtnTelno" name="cmpnyLxtnTelno"
													value="<c:out value='${loginData.cmpnyLxtnTelno}' />"
													title="내선번호 입력" maxlength="4" class="w124 ml10" /></td>
											</tr>
										</c:if>
										<!-- 회사 전화번호 -->
										<c:if test="${userSetYn.cmpnyTelno != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.cmpnyTelno == 1003}">
															<span class="point">회사 전화번호</span>
														</c:when>
														<c:otherwise>
															<span>회사 전화번호</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text"
													value="<c:out value='${loginData.intrlTelno}' />"
													readonly="readonly" title="국가번호 입력"
													class="w124 bg intrlTelno" /><input type="text"
													id="cmpnyTelno1" name="cmpnyTelno1"
													title="전화 지역번호를 입력해주세요." maxlength="3" class="w124 ml10" /><span
													class="space">-</span><input type="text" id="cmpnyTelno2"
													name="cmpnyTelno2" title="전화 국번을 입력해주세요." maxlength="4"
													class="w124" /><span class="space">-</span><input
													type="text" id="cmpnyTelno3" name="cmpnyTelno3"
													title="전화번호 뒷자리를 입력해주세요." maxlength="4" class="w124" /></td>
											</tr>
										</c:if>
										<!-- 회사 팩스 -->
										<c:if test="${userSetYn.cmpnyFaxnum != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.cmpnyFaxnum == 1003}">
															<span class="point">회사 팩스</span>
														</c:when>
														<c:otherwise>
															<span>회사 팩스</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text"
													value="<c:out value='${loginData.intrlTelno}' />"
													readonly="readonly" title="국가번호 입력"
													class="w124 bg intrlTelno" /><input type="text"
													id="cmpnyFaxnum1" name="cmpnyFaxnum1"
													title="팩스 지역번호를 입력해주세요." maxlength="3" class="w124 ml10" /><span
													class="space">-</span><input type="text" id="cmpnyFaxnum2"
													name="cmpnyFaxnum2" title="팩스 국번을 입력해주세요." maxlength="4"
													class="w124" /><span class="space">-</span><input
													type="text" id="cmpnyFaxnum3" name="cmpnyFaxnum3"
													title="팩스 뒷자리를 입력해주세요." maxlength="4" class="w124" /> <c:if
														test="${fn:startsWith(loginData.userTyCd, '20')}">
														<span class="caption ml20">이벤트/정보 SMS</span>
														<span class="agree"><op:code id="faxRecptnAgreCd"
																grpCd="77" type="radio" defaultValues="1002" /></span>
														</span>
													</c:if></td>
											</tr>
										</c:if>
										<c:if test="${userSetYn.cmpnyEmail != 1002}">
											<!-- 회사 이메일 주소 -->
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.cmpnyEmail == 1003}">
															<span class="point">회사 이메일 주소</span>
														</c:when>
														<c:otherwise>
															<span>회사 이메일 주소</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text" id="cmpnyEmail1"
													name="cmpnyEmail1" title="이메일을 입력해주세요." maxlength="24"
													class="w194" /><span class="space">@</span><input
													type="text" id="cmpnyEmail2" name="cmpnyEmail2"
													title="도메인을 입력해 주세요." maxlength="24" class="w194" /> <input
													type="hidden" id="cmpnyEmail" name="cmpnyEmail" value="" />
													<div class="select-area">
														<!-- select box -->
														<div class="sech_form">
															<div class="cont_wrap">
																<div class="selected"></div>
																<div class="selected">
																	<op:code id="cmpnyEmailList" grpCd="80"
																		onchange="jsEmailList('cmpnyEmail');"
																		defaultLabel="직접입력" />
																</div>
															</div>
														</div>
														<!-- //select box -->
														<span class="align" style=""> <label
															for="cmpnyEmailRecptnAgreCd">이벤트/정보 이메일</label> <op:code
																id="cmpnyEmailRecptnAgreCd" grpCd="77" type="radio"
																defaultValues="1002" />
														</span>
													</div></td>
											</tr>
										</c:if>
										<!-- 회사 URL -->
										<c:if test="${userSetYn.cmpnyUrl != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when test="${userSetYn.cmpnyUrl == 1003}">
															<span class="point">회사 URL</span>
														</c:when>
														<c:otherwise>
															<span>회사 URL</span>
														</c:otherwise>
													</c:choose></th>
												<td><input type="text" id="cmpnyUrl" name="cmpnyUrl"
													value="<c:out value='${loginData.cmpnyUrl}' />"
													class="w304"></td>
											</tr>
										</c:if>
										<!-- 회사 주소 -->
										<c:if
											test="${userSetYn.cmpnyZip != 1002 || userSetYn.cmpnyBassAdres != 1002 || userSetYn.cmpnyDetailAdres != 1002}">
											<tr>
												<th scope="row"><c:choose>
														<c:when
															test="${userSetYn.cmpnyZip == 1003 || userSetYn.cmpnyBassAdres == 1003 || userSetYn.cmpnyDetailAdres == 1003}">
															<span>회사 주소</span>
														</c:when>
														<c:otherwise>
															<span>회사 주소</span>
														</c:otherwise>
													</c:choose></th>
												<td class="addr"
													style="padding-top: 10px; padding-bottom: 10px;"><c:if
														test="${userSetYn.cmpnyZip != 1002}">
														<input type="text" id="cmpnyZip1" name="cmpnyZip1"
															title="우편번호를 입력해주세요." readonly="readonly" maxlength="5"
															class="w124" />
														<span class="space">-</span>
														<input type="text" id="cmpnyZip2" name="cmpnyZip2"
															title="우편번호 뒷자리를 입력해주세요." readonly="readonly"
															maxlength="4" class="w124" />
														<a href="#baseAddr2"
															onclick="jsZipcodePop(this,'cmpnyZip','cmpnyBassAdres','cmpnyDetailAdres');"
															title="팝업 창 열림" class="b-btn ml10 post type1"><strong><span>우편번호</span></strong></a>
														<br />
													</c:if> <c:if test="${userSetYn.cmpnyBassAdres != 1002}">
														<input type="text" id="cmpnyBassAdres"
															name="cmpnyBassAdres"
															value="<c:out value='${loginData.cmpnyBassAdres}' />"
															title="회사 주소 자동 입력" maxlength="100" class="w404 mt10" />
													</c:if> <c:if test="${userSetYn.cmpnyDetailAdres != 1002}">
														<input type="text" id="cmpnyDetailAdres"
															name="cmpnyDetailAdres"
															value="<c:out value='${loginData.cmpnyDetailAdres}' />"
															title="회사 상세 주소 입력" class="w404 mt10 ml10" />
													</c:if></td>
											</tr>
										</c:if> --%>
									</tbody>
								</table>
							</div>
						</div>
					</c:if>
					
					<c:if test="${fn:startsWith(loginData.userTyCd,'30')}">
						<div class="txt-info">
							<h4>기관 정보</h4>
						</div>
						<div class="join-area">
							<div class="type-write">
								<table>
									<colgroup>
										<col style="width: 150px;" />
										<col style="width:;" />
									</colgroup>
									<tbody>
										<!-- 기관명 -->
										<!-- LDAP 인증으로 변형 -->
										<tr>
											<th scope="row"><span class="point">기관명</span></th>
											<td>
											<input type="text" id="pblinsttNm" name="pblinsttNm"
												value="<c:out value='${loginData.pblinsttNm}' />"
												maxlength="100"
												${loginData.pblinsttCd == 1000 ? '' : 'readonly="readonly"'}
												class="w304" />
											<input type="hidden" id="pblinsttCd"
												name="pblinsttCd" maxlength="100"
												value="<c:out value='${loginData.pblinsttCd}' />" />
											<a href="javascript:;"
												onclick="jsPblinsttCdPop(this,'pblinsttCd','pblinsttNm');"
												title="팝업 창 열림" class="b-btn ml10 post type1"><strong><span>검색</span></strong></a>
											</td>
										</tr>
										<tr>
											<th scope="row"><span class="point">부서명</span></th>
											<td>
												<input type="text" id="cmpnyNm" name="cmpnyNm" value="" maxlength="100"
												${loginData.sbscrbTyCd == 1004 ? 'readonly="readonly"' : ''} class="w304" />
											</td>
										</tr>
										<tr>
											<th scope="row"><span class="point">담당자 전화</span></th>
											<td><input type="text"
													value="<c:out value='${loginData.intrlTelno}' />"
													readonly="readonly" title="국가번호 입력"
													class="w124 bg intrlTelno" /><input type="text"
													id="cmpnyTelno1" name="cmpnyTelno1"
													title="전화 지역번호를 입력해주세요." maxlength="3" class="w124 ml10" /><span
													class="space">-</span><input type="text" id="cmpnyTelno2"
													name="cmpnyTelno2" title="전화 국번을 입력해주세요." maxlength="4"
													class="w124" /><span class="space">-</span><input
													type="text" id="cmpnyTelno3" name="cmpnyTelno3"
										  		title="전화번호 뒷자리를 입력해주세요." maxlength="4" class="w124" />
										  </td>
										</tr>
										
										<!-- 사업자 등록번호 -->
										<%-- 
				          	<tr>
                            	<th scope="row">
                                	<span>사업자 등록번호<br/>　(선택)</span>
                                </th>
                                <td>
                                	<input type="text" id="bizrno1" name="bizrno1" title="사업자등록번호 앞자리를 입력해주세요." ${loginData.sbscrbTyCd == 1004 ? 'readonly="readonly"' : ''} maxlength="3" class="w124"/><span class="space">-</span><input type="text" id="bizrno2" name="bizrno2" title="사업자등록번호 가운데 자리를 입력해주세요." ${loginData.sbscrbTyCd == 1004 ? 'readonly="readonly"' : ''} maxlength="2" class="w124" /><span class="space">-</span><input type="text" id="bizrno3" name="bizrno3" title="사업자등록번호 뒷자리를 입력해주세요." ${not empty param.bizrno ? 'readonly="readonly"' : ''} maxlength="5" class="w124" />
                                </td>
                           	</tr>
                           	 --%>
										<!-- 기관홈페이지 URL -->
										<%-- 
                            <tr>
                            	<th scope="row">
                                	<span class="point">홈페이지 URL</span>
                                </th>
                                <td><input type="text" id="pblinsttUrl" name="pblinsttUrl"  value="<c:out value='${loginData.pblinsttUrl}' />" class="w304"></td>
                            </tr>
                             --%>
										<!-- 기관 주소 -->
										<%-- 
                            <tr>
                            	<th scope="row">
                                	<span class="point">주소</span>
                                </th>
                                <td class="addr" style="padding-top: 10px; padding-bottom: 10px;">
                                	<input type="text" id="pblinsttZip" name="pblinsttZip" value="<c:out value='${loginData.pblinsttZip}' />" title="우편번호를 입력해주세요." readonly="readonly" maxlength="7" class="w124" />
                                	<a href="javascript:;" onclick="jsZipcodePop(this,'pblinsttZip','pblinsttBassAdres','pblinsttDetailAdres');" title="팝업 창 열림" class="b-btn ml10 post type1"><strong><span>우편번호</span></strong></a><br />
                                    <input  type="text" id="pblinsttBassAdres" name="pblinsttBassAdres" value="<c:out value='${loginData.pblinsttBassAdres}' />" title="기관 기본 주소 입력" readonly="readonly" maxlength="100" class="w404 mt10" />
                                    <input type="text" id="pblinsttDetailAdres" name="pblinsttDetailAdres" value="<c:out value='${loginData.pblinsttDetailAdres}' />" title="기관 상세 주소 입력" maxlength="100" class="w404 mt10 ml10" />
                                </td>
                            </tr>
                             --%>
									</tbody>
								</table>
							</div>
						</div>
					</c:if>
				</div>
				<!-- //section 회사 정보 -->
				
				<!-- section 다국어 판매정보 -->
				<c:if test="${fn:endsWith(loginData.userTyCd, '02')}">
					<div class="section">
						<div class="txt-info">
							<h4>다국어 판매정보</h4>
						</div>

						<div class="join-area">
							<div class="type-write">
								<table>
									<colgroup>
										<col style="width: 150px;" />
										<col style="width:;" />
									</colgroup>
									<tbody>
										<tr>
											<th><span class="point">언어선택</span></th>
											<td><c:forEach items="${langList}" var="list"
													varStatus="status">
													<input type="radio" name="storeLangCodes"
														id="${list.LANGCD}" value="${list.LANGCD}"
														class="${list.LANGCD}">
													<span class="pad_l"><label for="${list.LANGCD}"><c:out
																value="${list.LANGNM}" /></label></span>
												</c:forEach></td>
										</tr>
										<tr>
											<th><span>회사 로고</span></th>
											<td>
												<div class="company-logo">
													<span class="no-img"> <!-- 이미지 미리보기 --> <c:if
															test="${fn:length(loginData.fileList) > 0}">
															<c:forEach items="${loginData.fileList}" var="fileVo"
																varStatus="status">
																<%-- 이미지 미리보기영역 --%>
																<img src="${fileVo.fileUrl}" alt="회사 이미지 미리보기" />
																<c:set var="fileCnt" value="${status.count}" />
																<c:set var="localNm" value="${fileVo.localNm}" />
																<c:set var="downCnt" value="${fileVo.downCnt}" />
																<c:set var="fileSize" value="${fileVo.fileSize}" />
																<c:set var="fileType" value="${fileVo.fileType}" />
																<c:set var="storeImageFileSeq" value="${fileVo.fileSeq}" />
															</c:forEach>
															<input type="hidden" id="uploadFileCnt"
																value="<c:out value='${fileCnt}' />">
															<input type="hidden" id="storeImageFileSeq"
																name="storeImageFileSeq"
																value="<c:out value='${storeImageFileSeq}' />">
														</c:if> <c:if test="${fn:length(loginData.fileList) <= 0}">
															<img src='/new_cloud/images/sub/img-logo-noimg.jpg'
																alt='회사 로고 이미지' />
														</c:if>
													</span>
													<div class="desc ml10">
														<div class="file-area">
															<!-- file upload -->
															<span class="file_del"><img
																src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제"
																id="delete"></span>
															<div class="fake_input">
																<a href="#" class="b-btn type1"><strong><span>파일선택</span></strong></a>
																<span id="mnlFile1Span"> <input type="file"
																	name="multiFiles" id="multiFiles" class="mnlFile"
																	value="파일 찾기" accept=".gif,.jpg,.jpeg,.png"
																	onchange="readURL(this);return false;" />
																</span>
															</div>
															<!-- //file upload -->
														</div>

														<div class="section mt10">
															<p class="caption mt10">※ JPG , GIF 형식의 10MB 미만 파일만
																업로드 가능합니다.</p>
															<p class="caption">※ 이미지 사이즈는 200 x 100를 권장합니다.</p>
															<p class="caption">※ 이미지 미등록시 기본이미지가 노출됩니다.</p>
														</div>
														<%-- 
										    <a href="#" onclick="return false;" id="delete" class="s-btn w20 type1"><strong><span>X</span></strong></a>
											<a href="#" class="b-btn ml10 type1"><strong><span>파일선택</span></strong></a>
											<div style="margin: 3px 70px;" id="storeImgNm">업로드 파일명</div>
												<input type="file" name="multiFiles" id="multiFiles" class="w470 multi max-1" value="파일 찾기" accept=".gif,.jpg,.jpeg,.png" style="left:0;" onchange="readURL(this);"/>
                                             <div style="margin: 3px 70px;" id="storeImgNm"><c:out value='${localNm}' /></div>
                                                  <p class="caption mt10">※ JPG , GIF 형식의 10MB 미만 파일만 업로드 가능합니다.</p>
											<p class="caption">※ 이미지 사이즈는 200 x 100를 권장합니다.</p>
											<p class="caption">※ 이미지 미등록시 기본이미지가 노출됩니다.</p>
											 --%>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- //section 다국어 판매정보 -->
					<!-- section 한국어 -->
					<div class="section language-list">
						<c:forEach items="${langList}" var="list" varStatus="status">
							<div class="txt-info">
								<h4 class="${list.LANGCD}" id="store${list.LANGCD}">
									<a href="#language" onclick="return false;"><c:out
											value="${list.LANGNM}" /></a>
								</h4>
								<button class="btn-toggle close">닫기</button>
							</div>
							<div class="join-area korean">
								<div class="type-write">
									<table>
										<%-- <caption>
                                    <strong><c:out value="${list.LANGNM}" />회사 정보 입력</strong>
                                    <details>
                                        <summary>회사명, 회사 소개 정보를 입력하는 서식입니다.</summary>
                                    </details>
                               </caption>	 --%>
										<colgroup>
											<col style="width: 150px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<c:if test="${storeSetYn.langStoreNm != 1002}">
												<tr>
													<th scope="row"><c:if
															test="${storeSetYn.langStoreNm == 1003}">
															<span class="point">회사명(<c:out
																	value="${list.LANGNM}" />)
															</span>
														</c:if> <c:if test="${storeSetYn.langStoreNm != 1003}">
															<span>회사명(<c:out value="${list.LANGNM}" />)
															</span>
														</c:if></th>
													<td><input type="text" name="langStoreNms"
														id="langStoreNms<c:out value="${list.LANGCD}"/>"
														maxlength="60"
														onchange="jsStoreNmReset('${list.LANGCD}');" class="w304" /><a
														href="#langStoreNms<c:out value="${list.LANGCD}" />"
														id="storeChk${list.LANGCD}"
														onclick="jsCheckDupleStoreNm('<c:out value="${list.LANGCD}" />');"
														title="팝업 창 열림" class="b-btn ml10 type1"><strong><span>중복
																	확인</span></strong></a> <input type="hidden" name="storeChk${list.LANGCD}"
														value="N" /> <!-- tooltip --> <span class="tooltip">
															<a href="#" class="s-btn ml10 w20 tooltip type1"><strong><span>?</span></strong></a>
															<div class="tooltip-box">
																<strong>${list.LANGNM} 회사명</strong>
																<p>2자 이상 ~ 60자 이내</p>
															</div>
													</span> <!-- //tooltip --></td>
												</tr>
											</c:if>
											<c:if test="${storeSetYn.langStoreIntrcn != 1002}">
												<tr>
													<th scope="row"><c:if
															test="${storeSetYn.langStoreIntrcn == 1003}">
															<span class="point">회사소개</span>
														</c:if> <c:if test="${storeSetYn.langStoreIntrcn != 1003}">
															<span>회사소개</span>
														</c:if></th>
													<td><textarea name="langStoreIntrcns"
															id="langStoreIntrcns<c:out value="${list.LANGCD}"/>"
															maxlength="2000"><c:forEach
																items="${loginData.userList}" var="store">
																<c:if test="${store.langCode == list.LANGCD}">${store.langStoreIntrcn}</c:if>
															</c:forEach></textarea></td>
												</tr>
											</c:if>
											<c:if test="${storeSetYn.storeChargerNm != 1002}">
												<tr>
													<th scope="row"><c:if
															test="${storeSetYn.storeChargerNm == 1003}">
															<span class="point">담당자</span>
														</c:if> <c:if test="${storeSetYn.storeChargerNm != 1003}">
															<span>담당자</span>
														</c:if></th>
													<td><input type="text" name="storeChargerNms"
														id="storeChargerNms${list.LANGCD}" maxlength="100"
														class="w404" /></td>
												</tr>
											</c:if>
											<c:if test="${storeSetYn.reprsntTelno != 1002}">
												<tr>
													<th scope="row"><c:if test="${storeSetYn.reprsntTelno == 1003}">
															<span class="point">전화번호</span>
														</c:if> <c:if test="${storeSetYn.reprsntTelno != 1003}">
															<span>전화번호</span>
														</c:if></th>
													<td>
														<input type="text" readonly="readonly" title="국가번호 입력" class="w124 bg intrlTelno" />
														<input type="text" id="reprsntTelnos1${list.LANGCD}" name="reprsntTelnos1" title="지역번호를 입력해주세요." maxlength="3" class="w124 ml10" />
														<span class="space">-</span>
														<input type="text" id="reprsntTelnos2${list.LANGCD}" name="reprsntTelnos2" title="전화 국번을 입력해주세요." maxlength="4" class="w124" />
														<span class="space">-</span>
														<input type="text" id="reprsntTelnos3${list.LANGCD}" name="reprsntTelnos3" title="전화번호 뒷자리를 입력해주세요." maxlength="4" class="w124" /> 
														<input type="hidden" name="reprsntTelnos" id="reprsntTelnos${list.LANGCD}" value="" />
													</td>
												</tr>
											</c:if>
											<c:if test="${storeSetYn.reprsntEmail != 1002}">
												<tr>
													<th scope="row"><c:if test="${storeSetYn.reprsntEmail == 1003}">
															<span class="point">이메일 주소</span>
														</c:if> <c:if test="${storeSetYn.reprsntEmail != 1003}">
															<span>이메일 주소</span>
														</c:if></th>
													<td><input type="text" id="reprsntEmails1${list.LANGCD}" maxlength="24" class="w194" />
														<span class="space">@</span>
														<input type="text" id="reprsntEmails2${list.LANGCD}" maxlength="24" class="w194" />
														<input type="hidden" name="reprsntEmails" id="reprsntEmails${list.LANGCD}" value="" />
														<div class="select-area">
															<!-- select box -->
															<div class="sech_form">
																<div class="cont_wrap">
																	<div class="selected">
																	<span class="sel_box">
																		<select id="${list.LANGCD}List" onchange="jsEmailList2('${list.LANGCD}');" style="width: 115px; vertical-align: middle; display: inline-block; cursor: pointer;">
																			<option value="">직접입력</option>
																			<c:forEach items="${emailList}" var="email">
																				<option value="${email.PRVCD}">${email.PRVNM}</option>
																			</c:forEach>
																		</select>
																		</span>
																	</div>
																</div>
															</div>
															<!-- //select box -->
														</div></td>
												</tr>
											</c:if>
											<c:if test="${storeSetYn.storeUrl != 1002}">
												<tr>
													<th scope="row"><c:choose>
															<c:when test="${userSetYn.storeUrl == 1003}">
																<span class="point">URL(홈/블로그)</span>
															</c:when>
															<c:otherwise>
																<span>URL(홈/블로그)</span>
															</c:otherwise>
														</c:choose></th>
													<td><input type="text" name="storeUrls" id="storeUrls${list.LANGCD}" maxlength="100" class="w404" />
													</td>
												</tr>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
				<!-- //section 한국어 -->
				<!-- section 관심분야 -->
				<div class="section">
					<div class="txt-info">
						<h4>관심분야(다중선택 가능)</h4>
						<a href="" id="categorySelect" title="팝업창 열림" onclick="jsCategoryPop(this);" class="b-btn ml10 type1"><strong><span>선택</span></strong></a>
					</div>
					<div class="join-area">
						<div class="type-write multi-select">
							<table>
								<colgroup>
									<col style="width: 140px;" />
									<col style="width:;" />
								</colgroup>
								<tbody id="categorys">
									<tr>
										<th><span>· SaaS</span></th>
										<td class="goodsCtgry cate2"><c:forEach items="${loginData.ctgryList}" var="category">
												<c:if test="${category.CTGRYCLCD == '1002'}">
													<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
														<li>
															<span>${category.CTGRYCLNM}</span>
															<span>${category.CTGRYPATH}</span>
															<span class="txt-point">${category.CTGRYNM}</span> 
															<c:if test="${category.CATEGORY_LANGCD eq '00'}">
																<input type="image" id="goodsCtgry_${category.CTGRYCODE}" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />
																<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
															</c:if></li>
													</ul>
												</c:if>
											</c:forEach></td>
									</tr>
									<tr>
										<th><span>· PaaS</span></th>
										<td class="goodsCtgry cate1"><c:forEach items="${loginData.ctgryList}" var="category">
												<c:if test="${category.CTGRYCLCD == '1001'}">
													<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
														<li>
															<span>${category.CTGRYCLNM}</span>
															<span>${category.CTGRYPATH}</span>
															<span class="txt-point">${category.CTGRYNM}</span>
															<c:if test="${category.CATEGORY_LANGCD eq '00'}">
																<input type="image" id="goodsCtgry_${category.CTGRYCODE}" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />
																<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
															</c:if></li>
													</ul>
												</c:if>
											</c:forEach></td>
									</tr>
									<tr>
										<th><span>· IaaS</span></th>
										<td class="goodsCtgry cate3"><c:forEach items="${loginData.ctgryList}" var="category">
												<c:if test="${category.CTGRYCLCD == '1003'}">
													<ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
														<li>
															<span>${category.CTGRYCLNM}</span>
															<span>${category.CTGRYPATH}</span>
															<span class="txt-point">${category.CTGRYNM}</span> 
															<c:if test="${category.CATEGORY_LANGCD eq '00'}">
																<input type="image" id="goodsCtgry_${category.CTGRYCODE}" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);" />
																<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="<c:out value='${category.CTGRYCODE}' />" />
															</c:if></li>
													</ul>
												</c:if>
											</c:forEach></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<!-- btn -->
				<div class="btn-area">
					<div class="btn_l">
						<a href="BD_outForm.do" class="b-btn confirm type1"><strong><span>회원탈퇴 신청</span></strong></a>
						<a href="/korean/pt/index.do" class="b-btn cancel type1"><strong><span>취 소</span></strong></a>
						<a href="#none" onclick="jsSubmit();" class="b-btn write fr type2"><strong><span>정보 입력하기</span></strong></a>
					</div>
				</div>
				<!-- //btn -->
			</form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</body>
</html>