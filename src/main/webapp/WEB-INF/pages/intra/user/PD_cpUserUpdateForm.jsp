<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>회원등록-사업자</title>
    <op:jsTag type="spi" items="form,validate,colorbox" />

    <script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>

    <script type="text/javascript">

    $().ready(function() {

        $("#userSecurityBtn").colorbox({
            title : "보안등급정책",
            href : "PD_userSecurity.do",
            width : "815",
            height : "740",
            iframe : true
        });

        //이메일 분기
        if ($("#corpNum").val()) {

            var corp_data = $("#corpNum").val();
            var corpNum_data = corp_data.split("-");
            document.getElementById("corpNum1").value = corpNum_data[0];
            document.getElementById("corpNum1_modItem").value = corpNum_data[0];
            document.getElementById("corpNum2").value = corpNum_data[1];
            document.getElementById("corpNum2_modItem").value = corpNum_data[1];

        }

      //사업자 등록번호 분기
        if ($("#cpNum").val()) {

            var cp_data = $("#cpNum").val();
            var cpNum_data = cp_data.split("-");
            document.getElementById("cpNum1").value = cpNum_data[0];
            document.getElementById("cpNum1_modItem").value = cpNum_data[0];
            document.getElementById("cpNum2").value = cpNum_data[1];
            document.getElementById("cpNum2_modItem").value = cpNum_data[1];
            document.getElementById("cpNum3").value = cpNum_data[2];
            document.getElementById("cpNum3_modItem").value = cpNum_data[2];

        }

        //사업자 전화번호 분기
        if ($("#telNum").val()) {

            var tel_data = $("#telNum").val();
            var telNum_data = tel_data.split("-");
            document.getElementById("telNum1").value = telNum_data[0];
            document.getElementById("telNum1_modItem").value = telNum_data[0];
            document.getElementById("telNum2").value = telNum_data[1];
            document.getElementById("telNum2_modItem").value = telNum_data[1];
            document.getElementById("telNum3").value = telNum_data[2];
            document.getElementById("telNum3_modItem").value = telNum_data[2];

        }

        //사업자 우편번호 분기
        if ($("#zipCode").val()) {

            var zip_data = $("#zipCode").val();
            var zipCode_data = zip_data.split("-");
            document.getElementById("zipCode1").value = zipCode_data[0];
            document.getElementById("zipCode1_modItem").value = zipCode_data[0];
            document.getElementById("zipCode2").value = zipCode_data[1];
            document.getElementById("zipCode2_modItem").value = zipCode_data[1];

        }

        $("#Form").validate({
            rules : {
                 userId		: { required: true }
                ,userNm : {
                    required : true,
                    minlength : 2, maxlength : 20
                }
//                 <c:if test="${baseVo.cpLeaderNmYN == 1001 || baseVo.cpLeaderNmYN == 1003 }">
                ,cpLeaderNm : {
//                     <c:if test="${baseVo.cpLeaderNmYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 2, maxlength : 20
                }
//                 </c:if>
//                 <c:if test="${baseVo.corpNumYN == 1001 || baseVo.corpNumYN == 1003 }">
                ,corpNum1 : {
//                     <c:if test="${baseVo.corpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 6, maxlength : 6
                },
                corpNum2 : {
//                     <c:if test="${baseVo.corpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 7, maxlength : 7
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpNumYN == 1001 || baseVo.cpNumYN == 1003 }">
                ,cpNum1 : {
//                     <c:if test="${baseVo.cpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 3
                },
                cpNum2 : {
//                     <c:if test="${baseVo.cpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 2, maxlength : 2
                },
                cpNum3 : {
//                     <c:if test="${baseVo.cpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 5, maxlength : 5
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpTelNumYN == 1001 || baseVo.cpTelNumYN == 1003 }">
                ,telNum1 : {
//                     <c:if test="${baseVo.cpTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 2, maxlength : 3
                },
                telNum2 : {
//                     <c:if test="${baseVo.cpTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 4
                },
                telNum3 : {
//                     <c:if test="${baseVo.cpTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 4
                }
//                 </c:if>
//                 <c:if test="${baseVo.cpAddrYN == 1001 || baseVo.cpAddrYN == 1003 }">
               ,zipCode1 : {
//                    <c:if test="${baseVo.cpAddrYN == 1003 }">
                   required : true,
//                    </c:if>
                   number : true, minlength : 3, maxlength : 3
                },
                zipCode2 : {
//                     <c:if test="${baseVo.cpAddrYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 3
                },
                baseAddr : {
//                     <c:if test="${baseVo.cpAddrYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 3, maxlength : 33
                },
                detailAddr : {
//                     <c:if test="${baseVo.cpAddrYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 3, maxlength : 33
                }
//                 </c:if>
            },
            submitHandler : function(form) {

                checkSubmit();
                $(form).ajaxSubmit({
                    url : "ND_cpUserUpdateAction.do",
                    type : "POST",
                    dataType : "json",
                    success : function(response) {
                        if(response.result) {
                            jsSuccessBox(response.message);
                        } else {
                            jsErrorBox(response.message);
                        }
                    },
                    error :  function(response) {
                        jsSysErrorBox(response.responseText);
                        return;
                    }
                });
            }
        });
    });

	//사업자 기본정보 수정 후 추가정보 수정 여부 confirm 하기
	var cpUserUpdateAdd_confirm = function() {
	    if (confirm("추가정보 수정 하시겠습니까?")) {
	        self.location.href = "PD_cpUserUpdateAddForm.do?userId="+$("#userId").val();
	    }
	    else {
	        parent.location.reload();
	    }
	};

    //법인등록번호,사업자등록번호,전화번호,우편번호 합치기
    function checkSubmit() {

        var frm = document.Form;

        if( frm.corpNum1.value != "" && frm.corpNum2.value != "" ) {

            frm.corpNum.value = frm.corpNum1.value + "-" + frm.corpNum2.value;
        }

        if(frm.cpNum1.value != "" && frm.cpNum2.value != "" && frm.cpNum3.value != "") {

            frm.cpNum.value = frm.cpNum1.value + "-" + frm.cpNum2.value + "-" + frm.cpNum3.value;
        }

        if(frm.telNum1.value != "" && frm.telNum2.value != "" && frm.telNum3.value != "") {

            frm.telNum.value = frm.telNum1.value + "-" + frm.telNum2.value + "-" + frm.telNum3.value;
        }

        if(frm.zipCode1.value != "" && frm.zipCode2.value != "") {

            frm.zipCode.value = frm.zipCode1.value + "-" + frm.zipCode2.value;
        }

    }

    var passwordUpdete = function(el, vl) {
        $(el).colorbox({
            title  : "비밀번호 변경하기",
            href   : "PD_passwordUpdate.do?userId=" + vl,
            width  : "800",
            height : "600",
            iframe : true
        });
    };

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


 		var userStateCon = document.getElementsByName('userState');

        for ( i=0; i < userStateCon.length; i++) {

            if( userStateCon[i].checked){
                $("#userStateCon").val(userStateCon[i].value);
            }
        }


		var modConts = new Array();

        if ($("#userNm").val() != $("#userNm_modItem").val()) {

           modConts[0] = "[회사명]";
        }

        if ($("#corpNum").val() != $("#corpNum_modItem").val()) {

           modConts[1] = "[법인등록번호]";
        }

        if ($("#cpNum").val() != $("#cpNum_modItem").val()) {

            modConts[2] = "[사업자등록번호]";
         }

        if ($("#telNum").val() != $("#telNum_modItem").val()) {

            modConts[3] = "[전화번호]";
         }

        if ($("#zipCode").val() != $("#zipCode_modItem").val()) {

            modConts[4] = "[우편번호]";
         }

        if ($("#baseAddr").val() != $("#baseAddr_modItem").val() || $("#detailAddr").val() != $("#detailAddr_modItem").val()) {

            modConts[5] = "[주소]";
         }

        if ($("#userStateCon").val() != $("#userState_modItem").val()) {

            modConts[6] = "[회원상태]";
         }

	       modConts = modConts.join(' ');

	       modConts = modConts.replace(/\s+|\s+$/g,"");
	       modConts = modConts.split("][").join("],[");

        $("#modConts").val(modConts);

	    pwdConfirm(el, '사업자회원 정보 수정', 'U', 'ND_cpUserUpdateAction.do', '800', '850', $("#userId").val(),'','',$("#modConts").val() );
	};

	var userList = function() {

 	   parent.$.fn.colorbox.close();
 	   parent.location.href = "BD_index.do?pwdYn="+"Y";
 	};

 	var jsZipcodePop = function (el) {

        $(el).colorbox({
            title : "우편번호 검색",
            href : "/intra/zipcode/PD_searchList.do",
            width : "700",
            height : "800",
            iframe : true
        });
    };

    </script>

</head>

<body>

	<!-- 컨텐츠영역 -->
	<form id="Form" name="Form">
		<input type="hidden" id="userId" name="userId" value="${dataVo.userId}" />
		<input type="hidden" id="corpNum" name="corpNum" value="${dataVo.corpNum}" />
		<input type="hidden" id="cpNum" name="cpNum" value="${dataVo.cpNum}" />
		<input type="hidden" id="telNum" name="telNum" value="${dataVo.telNum}" />
		<input type="hidden" id="zipCode" name="zipCode" value="${dataVo.zipCode}" />
		<input type="hidden" id="userType" name="userType" value=1002 />

		<input type="hidden" id="modConts" name="modConts" value=""/>
		<input type="hidden" id="userStateCon" name="userStateCon" value=""/>

		<input type="hidden" id="userNm_modItem" name="userNm_modItem" value="${dataVo.userNm}" />
		<input type="hidden" id="corpNum1_modItem" name="corpNum1_modItem" value="" />
		<input type="hidden" id="corpNum2_modItem" name="corpNum2_modItem" value="" />
		<input type="hidden" id="cpNum1_modItem" name="cpNum1_modItem" value="" />
		<input type="hidden" id="cpNum2_modItem" name="cpNum2_modItem" value="" />
		<input type="hidden" id="cpNum3_modItem" name="cpNum3_modItem" value="" />
		<input type="hidden" id="telNum1_modItem" name="telNum1_modItem" value="" />
		<input type="hidden" id="telNum2_modItem" name="telNum2_modItem" value="" />
		<input type="hidden" id="telNum3_modItem" name="telNum3_modItem" value="" />
		<input type="hidden" id="zipCode1_modItem" name="zipCode1_modItem" value="" />
		<input type="hidden" id="zipCode2_modItem" name="zipCode2_modItem" value="" />
		<input type="hidden" id="baseAddr_modItem" name="baseAddr_modItem" value="${dataVo.baseAddr}" />
		<input type="hidden" id="detailAddr_modItem" name="detailAddr_modItem" value="${dataVo.detailAddr}" />
		<input type="hidden" id="userState_modItem" name="userState_modItem" value="${dataVo.userState}" />

	<div id="popup">

		<!-- 탭 -->
		<ul class="tab">
			<li><a href="#" id="base" onclick="topDataToggle('base');" class="on">기본정보</a></li>
			<li><a href="#" id="add" onclick="topDataToggle('add');">추가정보</a></li>
			<c:if test="${baseVo.cpMileageYN == 1001}">
			<li><a href="#" id="mileage" onclick="topDataToggle('mileage');">마일리지정보</a></li>
			</c:if>
		</ul>
		<!-- //탭 -->

		<!-- 기본정보 -->
		<h2 class="mar_t20">기본정보</h2>

		<fieldset>
		<legend>사업자 회원 상세 정보</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="사업자 회원 상세 정보입니다.">
			<caption class="hidden"> 사업자 회원 상세 정보 </caption>
			<colgroup>
				<col width="15%" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="tx_red_s">*</span><label for="userId">아이디</label></th>
					<td class="tx_blue_s">
						${dataVo.userId}
					</td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span><label for="userNm">회사명</label></th>
					<td><input type="text" id="userNm" class="w80" name="userNm" value="${dataVo.userNm}" maxlength="30"/></td>
				</tr>
				<c:if test="${baseVo.cpLeaderNmYN == 1001 || baseVo.cpLeaderNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpLeaderNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpLeaderNm">대표자명</label>
					</th>
					<td><input type="text" id="cpLeaderNm" class="w80" name="cpLeaderNm" value="${dataVo.cpLeaderNm}" maxlength="15"/></td>
				</tr>
				</c:if>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="userPwd">비밀번호</label></th>
					<td>
						<button onclick="passwordUpdete(this,'${dataVo.userId}');" class="gray_s">비밀번호변경</button>
					</td>
				</tr>
				<c:if test="${baseVo.corpNumYN == 1001 || baseVo.corpNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.corpNumYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="corpNum1">법인등록번호</label>
					</th>
					<td>
						<input type="text" id="corpNum1" class="w80" name="corpNum1" title="법인등록번호를 입력해주세요" value="" maxlength="6"/> -
						<input type="text" id="corpNum2" class="w80" name="corpNum2" title="법인등록번호를 입력해주세요" value="" maxlength="7"/>
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpNumYN == 1001 || baseVo.cpNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpNumYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpNum1">사업자등록번호</label>
					</th>
					<td>
						<input type="text" id="cpNum1" class="w80" name="cpNum1" title="앞자리를 입력해주세요" value="" maxlength="3"/> -
						<input type="text" id="cpNum2" class="w80" name="cpNum2" title="중간자리를 입력해주세요" value="" maxlength="2"/> -
						<input type="text" id="cpNum3" class="w80" name="cpNum3" title="마지막번호를 입력해주세요" value="" maxlength="5"/>
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpTelNumYN == 1001 || baseVo.cpTelNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${baseVo.cpTelNumYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="telNum1">전화번호</label>
					</th>
					<td>
						<input type="text" id="telNum1" class="w80" name="telNum1" title="국번을 선택해주세요" value="" maxlength="3" /> -
						<input type="text" id="telNum2" class="w80" name="telNum2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
						<input type="text" id="telNum3" class="w80" name="telNum3" title="전화번호를 입력해주세요" value="" maxlength="4" />
					</td>
				</tr>
				</c:if>
				<c:if test="${baseVo.cpAddrYN == 1001 || baseVo.cpAddrYN == 1003 }">
				<tr>
					<th rowspan="3">
						<c:if test="${baseVo.cpAddrYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="baseAddr">주소</label>
					</th>
					<td>우편번호 :
						<input type="text" id="zipCode1" class="w80" name="zipCode1" value="" maxlength="3" /> -
						<input type="text" id="zipCode2" class="w80" name="zipCode2" value="" maxlength="3" />
						&nbsp;&nbsp;<button type="button" onclick="jsZipcodePop();" class="gray_s">우편번호찾기</button><br/>
					</td>
				</tr>
				<tr>
					<td>기본주소 : <input type="text" id="baseAddr" class="w85_p" name="baseAddr" value="${dataVo.baseAddr}" maxlength="33" /></td>
				</tr>
				<tr>
					<td>상세주소 : <input type="text" id="detailAddr" class="w85_p" name="detailAddr" value="${dataVo.detailAddr}" maxlength="33" /></td>
				</tr>
				</c:if>
				<tr>
					<th>
						<label for="userState">회원상태</label>
					</th>
					<td colspan="3">
						<input type="radio" name="userState" id="userState1" value="1001" <c:if test="${dataVo.userState == 1001}">checked="checked"</c:if> />
						<label for="userState1">가입</label>
						<input type="radio" name="userState" id="userState2" value="1002" <c:if test="${dataVo.userState == 1002}">checked="checked"</c:if> />
						<label for="userState2">탈퇴</label>
					</td>
				</tr>
				<tr>
					<th>
						<label for="regDtm">가입일시</label>
					</th>
					<td>
						${dataVo.regDtm}
					</td>
				</tr>
				<tr>
					<th>
						<label for="regDtm">최근로그인일시</label>
					</th>
					<td>
						${dataVo.latestLoginDtm}
					</td>
				</tr>
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