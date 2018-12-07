<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>

    <title>추가정보등록 - 사업자</title>
    <op:jsTag type="spi" items="validate,form,colorbox" />
    
    <script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
    
    <script type="text/javascript">

    $().ready(function() {    

        //이메일 분기
        if ($("#email_modItem").val()) {

            var e_data = $("#email_modItem").val();
            var email_data = e_data.split("@");
            document.getElementById("email1").value = email_data[0];
            document.getElementById("email1_modItem").value = email_data[0];
            document.getElementById("email2").value = email_data[1];
            document.getElementById("email2_modItem").value = email_data[1];

        }
        
        //휴대폰 번호 분기
        if ($("#cpMobile_modItem").val()) {

            var cpM_data = $("#cpMobile_modItem").val();
            var cpMobile_data = cpM_data.split("-");
            document.getElementById("cpMobile1").value = cpMobile_data[0];
            document.getElementById("cpMobile1_modItem").value = cpMobile_data[0];
            document.getElementById("cpMobile2").value = cpMobile_data[1];
            document.getElementById("cpMobile2_modItem").value = cpMobile_data[1];
            document.getElementById("cpMobile3").value = cpMobile_data[2];
            document.getElementById("cpMobile3_modItem").value = cpMobile_data[2];

        }
        
        //부서 전화번호 분기
        if ($("#cpDeptTelNum_modItem").val()) {

            var cpDTN_data = $("#cpDeptTelNum_modItem").val();
            var cpDeptTelNum_data = cpDTN_data.split("-");
            document.getElementById("cpDeptTelNum1").value = cpDeptTelNum_data[0];
            document.getElementById("cpDeptTelNum1_modItem").value = cpDeptTelNum_data[0];
            document.getElementById("cpDeptTelNum2").value = cpDeptTelNum_data[1];
            document.getElementById("cpDeptTelNum2_modItem").value = cpDeptTelNum_data[1];
            document.getElementById("cpDeptTelNum3").value = cpDeptTelNum_data[2];
            document.getElementById("cpDeptTelNum3_modItem").value = cpDeptTelNum_data[2];

        }
        
        //팩스 전화번호 분기
        if ($("#cpFaxNum_modItem").val()) {

            var cpFN_data = $("#cpFaxNum_modItem").val();
            var cpFaxNum_data = cpFN_data.split("-");
            document.getElementById("cpFaxNum1").value = cpFaxNum_data[0];
            document.getElementById("cpFaxNum1_modItem").value = cpFaxNum_data[0];
            document.getElementById("cpFaxNum2").value = cpFaxNum_data[1];
            document.getElementById("cpFaxNum2_modItem").value = cpFaxNum_data[1];
            document.getElementById("cpFaxNum3").value = cpFaxNum_data[2];
            document.getElementById("cpFaxNum3_modItem").value = cpFaxNum_data[2];

        }        
        
        $("#Form").validate({
            rules : {
                userId		: { required: true }
//                 <c:if test="${baseVo.cpMgrNmYN == 1001 || baseVo.cpMgrNmYN == 1003 }">
                ,cpMgrNm : {
//                     <c:if test="${baseVo.cpMgrNmYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 2, maxlength : 30
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpDeptNmYN == 1001 || baseVo.cpDeptNmYN == 1003 }">
                ,cpDeptNm : {
//                     <c:if test="${baseVo.cpDeptNmYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 2, maxlength : 30
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpGradeNmYN == 1001 || baseVo.cpGradeNmYN == 1003 }">
                ,cpGradeNm : {
//                     <c:if test="${baseVo.cpGradeNmYN == 1003 }">
                    required : false,
//                     </c:if>
                    minlength : 2, maxlength : 50
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpEmailYN == 1001 || baseVo.cpEmailYN == 1003 }">
                ,email1 : {
//                     <c:if test="${baseVo.cpEmailYN == 1003 }">
                    required : true,
//                     </c:if> 
                    email : false, minlength : 1, maxlength : 30
                },
                email2 : {
//                     <c:if test="${baseVo.cpEmailYN == 1003 }">
                    required : true,
//                     </c:if> 
                    email : false, minlength : 8, maxlength : 19
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpMobileYN == 1001 || baseVo.cpMobileYN == 1003 }">
                ,cpMobile2 : {
//                     <c:if test="${baseVo.cpMobileYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                },
                cpMobile3 : {
//                     <c:if test="${baseVo.cpMobileYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpDeptTelNumYN == 1001 || baseVo.cpDeptTelNumYN == 1003 }">
                ,cpDeptTelNum1 : {
//                     <c:if test="${baseVo.cpDeptTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 2, maxlength : 3
                },                
                cpDeptTelNum2 : {
//                     <c:if test="${baseVo.cpDeptTelNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                },
                cpDeptTelNum3 : {
//                     <c:if test="${baseVo.cpDeptTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 4
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpFaxNumYN == 1001 || baseVo.cpFaxNumYN == 1003 }">
                ,cpFaxNum1 : {
//                     <c:if test="${baseVo.cpFaxNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true,
                    minlength : 2, maxlength : 3
                },                
                cpFaxNum2 : {
//                     <c:if test="${baseVo.cpFaxNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                },
                cpFaxNum3 : {
//                     <c:if test="${baseVo.cpFaxNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                }
//                 </c:if>
            },
            submitHandler : function(form) {
                checkSubmit();
                $(form).ajaxSubmit({
                    url : "ND_cpUserUpdateAddAction.do",
                    type : "POST",
                    success : function(response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
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
    
    
    //이메일, 휴대전화, 부서전화, 부서팩스, 관심항목 합치기 기능    
    function checkSubmit() {

        var frm = document.Form;

        if(frm.email1.value != "" && frm.email2.value != "") {

            frm.email.value = frm.email1.value + "@" + frm.email2.value;
        }
        if(frm.cpMobile1.value != "" && frm.cpMobile2.value != "" && frm.cpMobile3.value != "") {

            frm.cpMobile.value = frm.cpMobile1.value + "-" + frm.cpMobile2.value + "-" + frm.cpMobile3.value;
        }        
        if(frm.cpDeptTelNum1.value != "" && frm.cpDeptTelNum2.value != "" && frm.cpDeptTelNum3.value != "") {

            frm.cpDeptTelNum.value = frm.cpDeptTelNum1.value + "-" + frm.cpDeptTelNum2.value + "-" + frm.cpDeptTelNum3.value;
        }
        if(frm.cpFaxNum1.value != "" && frm.cpFaxNum2.value != "" && frm.cpFaxNum3.value != "") {

            frm.cpFaxNum.value = frm.cpFaxNum1.value + "-" + frm.cpFaxNum2.value + "-" + frm.cpFaxNum3.value;
        }
    }
    
    
 	var emailSelected = function(){
 	    var emailCd = $("#email2_add").val();
 	    if(emailCd == 1001){
 	       emailNm = "naver.com";
 	    }else if(emailCd == 1002){
 	       emailNm = "hanmail.net";
 	    }else if(emailCd == 1003){
 	       emailNm = "gmail.com";
 	    }else if(emailCd == 1004){
 	       emailNm = "hotmail.com";
 	    }else if(emailCd == 1005){
 	       emailNm = "nate.com";
 	    }else if(emailCd == 1006){
 	       emailNm = "hanmir.com";
 	    }else if(emailCd == 1007){
 	       emailNm = "hitel.net";
 	    }else if(emailCd == 1008){
 	       emailNm = "chol.com";
 	    }else if(emailCd == 1009){
 	       emailNm = "dreamwiz.com";
 	    }else if(emailCd == 1010){
 	       emailNm = "empal.com";
 	    }else if(emailCd == 1011){
 	       emailNm = "freechal.com";
 	    }else if(emailCd == 1012){
 	       emailNm = "hdsmail.co.kr";
 	    }else if(emailCd == 1013){
 	       emailNm = "korea.com";
 	    }else if(emailCd == 1014){
 	       emailNm = "lycos.co.kr";
 	    }else if(emailCd == 1015){
 	       emailNm = "netian.com";
 	    }else if(emailCd == 1016){
 	       emailNm = "qook.co.kr";
 	    }else if(emailCd == 1017){
 	       emailNm = "yahoo.co.kr";
 	    }else if(emailCd == 1018){
 	       emailNm = "yahoo.com";
 	    }
 	        
 	    $("#email2").val(emailNm);
 	};    

    //사업자회원 기본정보 탭
	var cpUserInsertForm = function(){
		
	    self.location.href = "PD_cpUserInsertForm.do";		

	};    
    
	//사업자회원 추가정보 탭
	var cpUserInsertAddForm = function(){
		
	    self.location.href = "PD_cpUserInsertAddForm.do";		

	};	

    //선택한 메일 주소 뒷자리 input박스에 넣고 포커스 이동 기능
    function mail_ok(values) {
        frm = document.Form;
        frm.email2.value = values;
        frm.email2.focus();
    }  
    
    var topDataToggle = function(id){
	 	 if(id == "base"){
	 	     parent.$.colorbox.resize({width : 950, height : 720});
	 	     self.location.href = "PD_cpUserUpdateForm.do?userId=" + $("#userId").val();
	 	 }else if(id == "add"){
	 	     parent.$.colorbox.resize({width : 900, height : 520});
	 	     self.location.href = "PD_cpUserUpdateAddForm.do?userId=" + $("#userId").val();
	 	 }else if(id == "mileage"){
	 	     parent.$.colorbox.resize({width : 900, height : 850});
	 	     self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
	 	 }
	};
    
	var pwdConfirm1 = function(el) {
	    
        var interestItem ='';
        var selectedItem = jsCheckedArray();
        interestItem = $.makeArray(selectedItem);
        $("#interestItem").val(interestItem);
	    
		var modConts = new Array();
	       
        if ($("#cpMgrNm").val() != $("#cpMgrNm_modItem").val()) {

           modConts[0] = "[담당자명]"; 		            		            
        }
        
        if ($("#cpDeptNm").val() != $("#cpDeptNm_modItem").val()) {
        	
           modConts[1] = "[부서명]"; 		            	            
        }
        
        if ($("#cpGradeNm").val() != $("#cpGradeNm_modItem").val()) {
        	
            modConts[2] = "[직책]"; 		            	            
         }

        if ($("#email1").val() != $("#email1_modItem").val() || $("#email2").val() != $("#email2_modItem").val()  ) {
        	
            modConts[3] = "[이메일]"; 		            	            
         }      
 
        if ($("#cpMobile1").val() != $("#cpMobile1_modItem").val() || $("#cpMobile2").val() != $("#cpMobile2_modItem").val() || $("#cpMobile3").val() != $("#cpMobile3_modItem").val()) {
        	
            modConts[4] = "[휴대전화]"; 		            	            
         }
        
        if ($("#cpDeptTelNum1").val() != $("#cpDeptTelNum1_modItem").val() || $("#cpDeptTelNum2").val() != $("#cpDeptTelNum2_modItem").val() || $("#cpDeptTelNum3").val() != $("#cpDeptTelNum3_modItem").val()) {
        	
            modConts[5] = "[부서전화번호]"; 		            	            
         }        

        if ($("#cpFaxNum1").val() != $("#cpFaxNum1_modItem").val() || $("#cpFaxNum2").val() != $("#cpFaxNum2_modItem").val() || $("#cpFaxNum3").val() != $("#cpFaxNum3_modItem").val()) {
        	
            modConts[6] = "[팩스번호]"; 		            	            
         } 
        
        if ($("#interestItem").val() != $("#interestItem_modItem").val()) {
        	
            modConts[7] = "[관심항목]"; 		            	            
         } 
        
	       modConts = modConts.join(' ');	       
	       
	       modConts = modConts.replace(/\s+|\s+$/g,"");
	       modConts = modConts.split("][").join("],[");
	       
        $("#modConts").val(modConts); 
	    
	    pwdConfirm(el, '회원 정보 수정', 'U', 'ND_pUpdateAction.do', '800', '850', $("#userId").val(),'','',$("#modConts").val() );	    
	};	

 	var jsCheckedArray = function() {
   	   var selectedItem = new Array();
   	  $("body input.checkbox:checked").each(function (i) {
   	      selectedItem[i] = $(this).val();
   	  });
   	  return selectedItem;
   	};	
	
	var userList = function() {
 	   
 	   parent.$.fn.colorbox.close();
 	   parent.location.href = "BD_index.do?pwdYn="+"Y";
 	};
	
    </script>
    
</head>
 
<body>
	<!-- 컨텐츠영역 -->
	<form id="Form" name="Form">
		<input type="hidden" id="userId" name="userId" value="${param.userId}" />
		<input type="hidden" id="email" name="email" value="" />
		<input type="hidden" id="cpMobile" name="cpMobile" value="" />
		<input type="hidden" id="cpDeptTelNum" name="cpDeptTelNum" value="" />
		<input type="hidden" id="cpFaxNum" name="cpFaxNum" value="" />
		<input type="hidden" id="interestItem" name="interestItem" value="" />
		
		<input type="hidden" id="modConts" name="modConts" value="" />
		
		<input type="hidden" id="cpMgrNm_modItem" name="cpMgrNm_modItem" value="${dataVo.cpMgrNm}" />
		<input type="hidden" id="cpDeptNm_modItem" name="cpDeptNm_modItem" value="${dataVo.cpDeptNm}" />
		<input type="hidden" id="cpGradeNm_modItem" name="cpGradeNm_modItem" value="${dataVo.cpGradeNm}" />
		<input type="hidden" id="email1_modItem" name="email1_modItem" value="" />
		<input type="hidden" id="email2_modItem" name="email2_modItem" value="" />
		<input type="hidden" id="email_modItem" name="email_modItem" value="${dataVo.email}" />
		<input type="hidden" id="cpMobile1_modItem" name="cpMobile1_modItem" value="" />
		<input type="hidden" id="cpMobile2_modItem" name="cpMobile2_modItem" value="" />
		<input type="hidden" id="cpMobile3_modItem" name="cpMobile3_modItem" value="" />
		<input type="hidden" id="cpMobile_modItem" name="cpMobile_modItem" value="${dataVo.cpMobile}" />
		<input type="hidden" id="cpDeptTelNum1_modItem" name="cpDeptTelNum1_modItem" value="" />
		<input type="hidden" id="cpDeptTelNum2_modItem" name="cpDeptTelNum2_modItem" value="" />
		<input type="hidden" id="cpDeptTelNum3_modItem" name="cpDeptTelNum3_modItem" value="" />
		<input type="hidden" id="cpDeptTelNum_modItem" name="cpDeptTelNum_modItem" value="${dataVo.cpDeptTelNum}" />
		<input type="hidden" id="cpFaxNum1_modItem" name="cpFaxNum1_modItem" value="" />
		<input type="hidden" id="cpFaxNum2_modItem" name="cpFaxNum2_modItem" value="" />
		<input type="hidden" id="cpFaxNum3_modItem" name="cpFaxNum3_modItem" value="" />
		<input type="hidden" id="cpFaxNum_modItem" name="cpFaxNum_modItem" value="${dataVo.cpFaxNum}" />
		<input type="hidden" id="interestItem_modItem" name="interestItem_modItem" value="${dataVo.interestItem}"/>
	<div id="popup">
				
		<!-- 탭 -->
		<ul class="tab">
			<li><a href="#" id="base" onclick="topDataToggle('base');">기본정보</a></li>
			<li><a href="#" id="add" onclick="topDataToggle('add');" class="on">추가정보</a></li>
			<c:if test="${baseVo.cpMileageYN == 1001}">
			<li><a href="#" id="mileage" onclick="topDataToggle('mileage');">마일리지정보</a></li>
			</c:if>
		</ul>
		<!-- //탭 -->
		
		<!-- 기본정보 -->
		<h2 class="mar_t20">추가정보</h2>
		
		<fieldset>
		<legend>추가정보등록</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="추가정보등록을 하실 수 있습니다.">
			<caption class="hidden"> 추가정보등록 </caption>
			<colgroup>
				<col width="15%" />
				<col width="" />
			</colgroup>
			<tbody>
				<c:if test="${baseVo.cpMgrNmYN == 1001 || baseVo.cpMgrNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpMgrNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpMgrNm">담당자명</label>
					</th>
					<td><input type="text" id="cpMgrNm" class="w120" name="cpMgrNm" title="담당자명을 입력해주세요" value="${dataVo.cpMgrNm}" maxlength="30"/></td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpDeptNmYN == 1001 || baseVo.cpDeptNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpDeptNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpDeptNm">부서명</label>
					</th>
					<td><input type="text" id="cpDeptNm" class="w120" name="cpDeptNm" title="부서명을 입력해주세요" value="${dataVo.cpDeptNm}" maxlength="30"/></td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpGradeNmYN == 1001 || baseVo.cpGradeNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpGradeNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpGradeNm">직책</label>
					</th>
					<td><input type="text" id="cpGradeNm" class="w120" name="cpGradeNm" title="직책을 입력해주세요" value="${dataVo.cpGradeNm}" maxlength="50"/></td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpEmailYN == 1001 || baseVo.cpEmailYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpEmailYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="email1">이메일</label>
					</th>
					<td colspan="3">
						<input type="text" id="email1" class="w80" name="email1" title="이메일을 입력해주세요" value="" maxlength="30"/> @ 
						<input type="text" id="email2" class="w120" name="email2" title="도메인을 입력해주세요" value="" maxlength="19"/> 
						<op:code id="email2_add" grpCd="80" onchange="emailSelected();" />
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpMobileYN == 1001 || baseVo.cpMobileYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpMobileYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpMobile1">휴대전화</label>
					</th>
					<td colspan="3">
						<op:code id="cpMobile1" grpCd="66" defaultLabel="선택" /> -
						<input type="text" id="cpMobile2" class="w80" name="cpMobile2" title="앞자리를 입력해주세요" value="" maxlength="4"/> - 
						<input type="text" id="cpMobile3" class="w80" name="cpMobile3" title="전화번호를 입력해주세요" value="" maxlength="4"/>
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpDeptTelNumYN == 1001 || baseVo.cpDeptTelNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpDeptTelNumYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpDeptTelNum1">부서 전화번호</label>
					</th>
					<td colspan="3">
						<input type="text" id="cpDeptTelNum1" class="w80" name="cpDeptTelNum1" title="국번을 선택해주세요" value="" maxlength="3" /> -
						<input type="text" id="cpDeptTelNum2" class="w80" name="cpDeptTelNum2" title="앞자리를 입력해주세요" value="" maxlength="4"/> -
						<input type="text" id="cpDeptTelNum3" class="w80" name="cpDeptTelNum3" title="전화번호를 입력해주세요" value="" maxlength="4"/>
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpFaxNumYN == 1001 || baseVo.cpFaxNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpFaxNumYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpFaxNum1">팩스번호</label>
					</th>
					<td colspan="3">
						<input type="text" id="cpFaxNum1" class="w80" name="cpFaxNum1" title="국번을 선택해주세요" value="" maxlength="3" /> -
						<input type="text" id="cpFaxNum2" class="w80" name="cpFaxNum2" title="앞자리를 입력해주세요" value="" maxlength="4"/> - 
						<input type="text" id="cpFaxNum3" class="w80" name="cpFaxNum3" title="전화번호를 입력해주세요" value="" maxlength="4"/>
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpInterestItemYN == 1001 || baseVo.cpInterestItemYN == 1003 }">
				<tr>
					<th>관심항목</th>
					<td>
						<ul class="mem_item">
						<c:set var="i" value="${fn:split(dataVo.interestItem,',')}"/>
						<c:forEach var="item" items="${list}" varStatus="status">
							<c:if test="${item.userGubun eq 'C' }">						
							<li>
								<input type="checkbox" name="useYn${item.seq}" id="useYn${item.seq}" value="${item.seq}" class="checkbox" 
								<c:forEach  items="${i}" var="loop1" varStatus="status1">
									<c:if test="${i[status1.index] == item.seq}">checked="checked"</c:if>
								</c:forEach> /> 
								<input type="hidden" name="useYn${item.seq}" id="useYn${item.seq}" value="${item.seq}"/>
								<label for="useYn${item.seq}">${item.itemNm}</label>
							</li>
							</c:if>
						</c:forEach>
						</ul>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		</fieldset>
		<!-- //기본정보 -->

		<p class="tx_c mar_t20">
			<a href="#"><button type="button" onclick="pwdConfirm1(this);" class="blue">수정</button></a> 
			<a href="#"><button type="button" onclick="userList();" class="blue">취소</button></a>
		</p>
		
	</div>
	</form>
	<!-- //컨텐츠영역 -->
</body>
</html>