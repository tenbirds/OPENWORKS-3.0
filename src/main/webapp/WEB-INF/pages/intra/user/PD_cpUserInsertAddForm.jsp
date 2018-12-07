<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>

    <title>추가정보등록 - 사업자</title>
    <op:jsTag type="spi" items="validate,form" />
    
    <script type="text/javascript">

    $().ready(function() {

        $("#dataForm").validate({
            rules : {
                userId			: { required: true }
//                 <c:if test="${dataVo.cpMgrNmYN == 1001 || dataVo.cpMgrNmYN == 1003 }">
                ,cpMgrNm : {
//                     <c:if test="${dataVo.cpMgrNmYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 2, maxlength : 20
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpDeptNmYN == 1001 || dataVo.cpDeptNmYN == 1003 }">
                ,cpDeptNm : {
//                     <c:if test="${dataVo.cpDeptNmYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 2, maxlength : 20
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpGradeNmYN == 1001 || dataVo.cpGradeNmYN == 1003 }">
                ,cpGradeNm : {
//                     <c:if test="${dataVo.cpGradeNmYN == 1003 }">
                    required : true,
//                     </c:if> 
                    minlength : 2, maxlength : 33
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpEmailYN == 1001 || dataVo.cpEmailYN == 1003 }">
                ,email1 : {
//                     <c:if test="${dataVo.cpEmailYN == 1003 }">
                    required : true, 
//                     </c:if>
                    email : false, minlength : 1, maxlength : 30
                }
                ,email2 : {
//                     <c:if test="${dataVo.cpEmailYN == 1003 }">
                    required : true, 
//                     </c:if> 
                    email : false, minlength : 8, maxlength : 19
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpMobileYN == 1001 || dataVo.cpMobileYN == 1003 }">
                ,cpMobile2 : {
//                     <c:if test="${dataVo.cpMobileYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                },
                cpMobile3 : {
//                     <c:if test="${dataVo.cpMobileYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 4, maxlength : 4
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpDeptTelNumYN == 1001 || dataVo.cpDeptTelNumYN == 1003 }">
                ,cpDeptTelNum1 : {
//                     <c:if test="${dataVo.cpDeptTelNumYN == 1003 }">
                    required : true, 
//                     </c:if>
                    number : true, minlength : 2, maxlength : 3
                },                
                cpDeptTelNum2 : {
//                     <c:if test="${dataVo.cpDeptTelNumYN == 1003 }">
                    required : true, 
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                }
                ,cpDeptTelNum3 : {
//                     <c:if test="${dataVo.cpDeptTelNumYN == 1003 }">
                    required : true, 
//                     </c:if> 
                    number : true, minlength : 4, maxlength : 4
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpFaxNumYN == 1001 || dataVo.cpFaxNumYN == 1003 }">
                ,cpFaxNum1 : {
//                     <c:if test="${dataVo.cpFaxNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 2, maxlength : 3
                },                
                cpFaxNum2 : {
//                     <c:if test="${dataVo.cpFaxNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 3, maxlength : 4
                },
                cpFaxNum3 : {
//                     <c:if test="${dataVo.cpFaxNumYN == 1003 }">
                    required : true,
//                     </c:if> 
                    number : true, minlength : 4, maxlength : 4
                }
//                 </c:if>
            },
            submitHandler : function(form) {
                checkSubmit();
                
                var interestItem = '';
                var selectedItem = jsCheckedArray();
                
                interestItem = $.makeArray(selectedItem);
                $("#interestItem").val(interestItem);
                
                $(form).ajaxSubmit({
                    url : "ND_cpUserUpdateAddAction.do",
                    type : "POST",
                    success : function(response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
                                parent.$.colorbox.resize({width : 900, height : 850});

                                self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
                                self.location.href = "PD_cpUserUpdateAddForm.do?userId=" + $("#userId").val();
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

 	var jsCheckedArray = function() {
  	   var selectedItem = new Array();
  	  $("body input.checkbox:checked").each(function (i) {
  	      selectedItem[i] = $(this).val();
  	  });
  	  return selectedItem;
  	};
  	
    //이메일, 휴대전화, 부서전화, 부서팩스, 관심항목 합치기 기능    
    function checkSubmit() {

        var frm = document.dataForm;

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
    
    //사업자회원 추가 정보 등록 후 리스트 화면
	var userList = function(){
        
	    parent.$.fn.colorbox.close();
	    parent.location.href = "BD_index.do?pwdYn="+"Y";		

	};
	
	var topDataToggle = function(id){
		if(id == "base"){
	    	if(confirm("등록하신 회원의 상세정보 페이지로 이동됩니다.\n 이동하시겠습니까?")){
	    	    parent.$.colorbox.resize({width : 950, height : 720});
		 	    self.location.href = "PD_cpUserUpdateForm.do?userId=" + $("#userId").val();
	    	}
	 	 }else if(id == "add"){
	 	    self.location.href = "PD_cpUserUpdateAddForm.do?userId=" + $("#userId").val();
	 	 }else if(id == "mileage"){
	 		alert("등록하신 회원의 마일리지등록 페이지로 이동됩니다.");
	 		parent.$.colorbox.resize({width : 900, height : 850});
	 	    self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
	 	 }
	};
	
	//사업자회원 기본정보 상세 및 수정 화면
	var cpUserUpdateForm = function(){
		
	    self.location.href = "PD_cpUserUpdateForm.do?userId="+$("#userId").val();		

	};	

 	var mail_ok = function(values){
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

    
    </script>
    
</head>
 
<body>
	<!-- 컨텐츠영역 -->
	<form id="dataForm" name="dataForm">
		<input type="hidden" id="userId" name="userId" value="${param.userId}" />
		<input type="hidden" id="email" name="email" value="" />
		<input type="hidden" id="cpMobile" name="cpMobile" value="" />
		<input type="hidden" id="cpDeptTelNum" name="cpDeptTelNum" value="" />
		<input type="hidden" id="cpFaxNum" name="cpFaxNum" value="" />
		<input type="hidden" id="interestItem" name="interestItem" value="" />
	<div id="popup">
				
		<!-- 탭 -->
		<ul class="tab">
			<li><a href="#" id="base" onclick="topDataToggle('base');" >기본정보</a></li>
			<li><a href="#" id="add" onclick="topDataToggle('add');" class="on">추가정보</a></li>
			<c:if test="${dataVo.cpMileageYN == 1001}">	
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
				<c:if test="${dataVo.cpMgrNmYN == 1001 || dataVo.cpMgrNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpMgrNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpMgrNm">담당자명</label>
					</th>
					<td><input type="text" id="cpMgrNm" class="w120" name="cpMgrNm" title="담당자명을 입력해주세요" value="" maxlength="20"/></td>
				</tr>
				</c:if>
				<c:if test="${dataVo.cpDeptNmYN == 1001 || dataVo.cpDeptNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpDeptNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpDeptNm">부서명</label>
					</th>
					<td><input type="text" id="cpDeptNm" class="w120" name="cpDeptNm" title="부서명을 입력해주세요" value="" maxlength="20"/></td>
				</tr>
				</c:if>
				<c:if test="${dataVo.cpGradeNmYN == 1001 || dataVo.cpGradeNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpGradeNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpGradeNm">직책</label>
					</th>
					<td><input type="text" id="cpGradeNm" class="w120" name="cpGradeNm" title="직책을 입력해주세요" value="" maxlength="33"/></td>
				</tr>
				</c:if>
				<c:if test="${dataVo.cpEmailYN == 1001 || dataVo.cpEmailYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpEmailYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="email1">이메일</label>
					</th>
					<td colspan="3">
						<input type="text" id="email1" class="w80" name="email1" title="이메일을 입력해주세요" value="" maxlength="30"/> @ 
						<input type="text" id="email2" class="w120" name="email2" title="도메인을 입력해주세요" value="" maxlength="19"/>
						<op:code id="email2_add" grpCd="80" onchange="mail_ok(this.value)" /> 
					</td>
				</tr>
				</c:if>
				<c:if test="${dataVo.cpMobileYN == 1001 || dataVo.cpMobileYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpMobileYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpMobile1">휴대전화</label>
					</th>
					<td colspan="3">
						<op:code id="cpMobile1" grpCd="66" defaultLabel="선택" />
						-
						<input type="text" id="cpMobile2" class="w80" name="cpMobile2" title="앞자리를 입력해주세요" value="" maxlength="4"/> - 
						<input type="text" id="cpMobile3" class="w80" name="cpMobile3" title="전화번호를 입력해주세요" value="" maxlength="4"/>
					</td>
				</tr>
				</c:if>
				<c:if test="${dataVo.cpDeptTelNumYN == 1001 || dataVo.cpDeptTelNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpDeptTelNumYN == 1003 }">
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
				<c:if test="${dataVo.cpFaxNumYN == 1001 || dataVo.cpFaxNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpFaxNumYN == 1003 }">
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
				<c:if test="${dataVo.cpInterestItemYN == 1001 || dataVo.cpInterestItemYN == 1003 }">
				<tr>
					<th>관심항목</th>
					<td>
						<ul class="mem_item">
							<c:forEach var="item" items="${list}" varStatus="status">
								<c:if test="${item.userGubun eq 'C' }">
								<li>
									<input type="checkbox" name="useYn${item.seq}" id="useYn${item.seq}" value="${item.seq}" class="checkbox"/> <label for="useYn${item.seq}">${item.itemNm}</label>
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
			<a href="#"><button type="submit" class="blue">등록</button></a> 
			<a href="#"><button type="button" onclick="userList();" class="blue">취소</button></a>
		</p>
		
	</div>
	</form>
	<!-- //컨텐츠영역 -->
</body>
</html>