<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>회원등록-사업자</title>
    <op:jsTag type="spi" items="form,validate,colorbox" />

    <script type="text/javascript">

    $().ready(function() {

 	   	$(".tx_red").show();
	    $(".tx_green").hide();

        $("#userSecurityBtn").colorbox({
            title : "보안등급정책",
            href : "PD_userSecurity.do",
            width : "815",
            height : "740",
            iframe : true
        });

        $("#dataForm").validate({
            rules : {
                userId : {
                    required : true, alphanumeric : true,
                    minlength : 3, maxlength : 20,
                    remote : "ND_checkDupleId.do"
                }
                ,userNm : {
                    required : true,
                    minlength : 2, maxlength : 20
                }
//         		<c:if test="${dataVo.cpLeaderNmYN == 1001 || dataVo.cpLeaderNmYN == 1003 }">
                ,leaderNm : {
//                     <c:if test="${dataVo.cpLeaderNmYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 2, maxlength : 15
                }
//         		</c:if>
                ,userPwd : {
                    required : true, alphanumeric : true,
                    minlength : 9, maxlength : 32
                }
                ,userPwd_confirm : {
                    required : true, alphanumeric : true,
                    minlength : 9, maxlength : 32, equalTo : "#userPwd"
                }
//                 <c:if test="${dataVo.corpNumYN == 1001 || dataVo.corpNumYN == 1003 }">
                ,corpNum1 : {
//                     <c:if test="${dataVo.corpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 6, maxlength : 6
                }
                ,corpNum2 : {
//                     <c:if test="${dataVo.corpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 7, maxlength : 7
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpNumYN == 1001 || dataVo.cpNumYN == 1003 }">
                ,cpNum1 : {
//                     <c:if test="${dataVo.cpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 3
                }
                ,cpNum2 : {
//                     <c:if test="${dataVo.cpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 2, maxlength : 2
                }
                ,cpNum3 : {
//                     <c:if test="${dataVo.cpNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 5, maxlength : 5
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpTelNumYN == 1001 || dataVo.cpTelNumYN == 1003 }">
                ,telNum1 : {
//                     <c:if test="${dataVo.cpTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 2, maxlength : 3
                }
                ,telNum2 : {
//                     <c:if test="${dataVo.cpTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 4
                }
                ,telNum3 : {
//                     <c:if test="${dataVo.cpTelNumYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 4
                }
//                 </c:if>
//                 <c:if test="${dataVo.cpAddrYN == 1001 || dataVo.cpAddrYN == 1003 }">
               ,zipCode1 : {
//                    <c:if test="${dataVo.cpAddrYN == 1003 }">
                   required : true,
//                    </c:if>
                   number : true, minlength : 3, maxlength : 3
                }
                ,zipCode2 : {
//                     <c:if test="${dataVo.cpAddrYN == 1003 }">
                    required : true,
//                     </c:if>
                    number : true, minlength : 3, maxlength : 3
                }
                ,baseAddr : {
//                     <c:if test="${dataVo.cpAddrYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 3, maxlength : 33
                }
                ,detailAddr : {
//                     <c:if test="${dataVo.cpAddrYN == 1003 }">
                    required : true,
//                     </c:if>
                    minlength : 3, maxlength : 33
                }
//                 </c:if>
//         		<c:if test="${dataVo.cpCapchaYN == 1001 || dataVo.cpCapchaYN == 1003 }">
                ,answer : {
//                     <c:if test="${dataVo.cpCapchaYN == 1003 }">
                    required : true,
//                     </c:if>
                }
//         		</c:if>
            },
            messages : {
                userId : {
                    remote : $.validator.format("이미 존재하는 ID 입니다.")
                }
            },
            submitHandler : function(form) {

                checkSubmit();
                $(form).ajaxSubmit({
                    url : "ND_cpUserInsertAction.do",
                    type : "POST",
                    dataType : "json",
                    success : function(response) {
                        if (response.result) {
                            jsSuccessBox(response.message);
	                        parent.$.colorbox.resize({width : 900, height : 550});
	                        self.location.href = "PD_cpUserInsertAddForm.do?userId="+$("#userId").val();
                        }else {
                            jsErrorBox(response.message);
                        }
                    }
                });
            }
        });
    });

    //법인등록번호,사업자등록번호,전화번호,우편번호 합치기
    var checkSubmit = function() {

        var frm = document.dataForm;

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

    };

    var topDataToggle = function(id){

	 	 if(id == "base"){

	 	     self.location.href = "PD_cpUserInsertForm.do";
	 	 } else if(id == "add"){

	 	    jsWarningBox("사업자회원을 등록한 후 추가정보를 입력하실 수 있습니다.<br />이미 등록된 아이디는 회원상세정보 페이지에서 추가하실 수 있습니다.");
	 	   return;
	 	 } else if(id == "mileage"){

	 	    jsWarningBox("사업자회원을 등록한 후 마일리지정보를 입력하실 수 있습니다.<br />이미 등록된 아이디는 회원상세정보 페이지에서 추가하실 수 있습니다.");
	 	    return;
	 	 }
	};

 	var pwdUseYn = function(){

		var pwdUseYn = 'Y';
		if($("#userPwd").val().length < 9){
		   pwdUseYn = 'N';
		}

		if(pwdUseYn == 'Y'){
		    $(".tx_red").hide();
		    $(".tx_green").show();
		}else{
		    $(".tx_red").show();
		    $(".tx_green").hide();
		}
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
	<form id="dataForm" name="dataForm">
		<input type="hidden" id="corpNum" name="corpNum" value="" />
		<input type="hidden" id="cpNum" name="cpNum" value="" />
		<input type="hidden" id="telNum" name="telNum" value="" />
		<input type="hidden" id="zipCode" name="zipCode" value="" />
		<input type="hidden" id="userType" name="userType" value=1002 />
	<div id="popup">

		<!-- 탭 -->
		<ul class="tab">
			<li><a href="#" id="base" onclick="topDataToggle('base');" class="on">기본정보</a></li>
			<li><a href="#" id="add" onclick="topDataToggle('add');">추가정보</a></li>
			<c:if test="${dataVo.cpMileageYN == 1001}">
			<li><a href="#" id="mileage" onclick="topDataToggle('mileage');">마일리지정보</a></li>
			</c:if>
		</ul>
		<!-- //탭 -->

		<!-- 기본정보 -->
		<h2 class="mar_t20">기본정보</h2>

		<fieldset>
		<legend>사업자회원등록</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="사업자회원등록을 하실 수 있습니다.">
			<caption class="hidden"> 사업회원등록 </caption>
			<colgroup>
				<col width="15%" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="tx_red_s">*</span><label for="userId">아이디</label></th>
					<td class="tx_blue_s">
						<input type="text" id="userId" class="w80" name="userId" value="" maxlength="30" /> (영문/숫자조합 최대20자)
					</td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span><label for="userNm">회사명</label></th>
					<td><input type="text" id="userNm" class="w80" name="userNm" value="" maxlength="30"/></td>
				</tr>
				<c:if test="${dataVo.cpLeaderNmYN == 1001 || dataVo.cpLeaderNmYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpLeaderNmYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="cpLeaderNm">대표자명</label></th>
					<td><input type="text" id="cpLeaderNm" class="w80" name="cpLeaderNm" value="" maxlength="15"/></td>
				</tr>
				</c:if>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="userPwd">비밀번호</label></th>
					<td><input type="password" id="userPwd" class="w80" name="userPwd" title="비밀번호를 입력해주세요" value="" maxlength="32" onblur="pwdUseYn()"/>
					<p class="tx_blue_s">- 보안등급 :
						<span class="tx_red" >불가</span><span style="color: green;" class="tx_green">사용</span>
						 (최소 9자, 최대 32자/ 영문(대/소문자), 숫자, 특수문자 조합)&nbsp;&nbsp;
					<button type="button" id="userSecurityBtn" class="gray_s">보안등급정책</button><br />
					- 비밀번호 등록 또는 변경시 보안등급을 확인하여 안전하게 변경하시기 바랍니다.
					</p>
					</td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="userPwd_confirm">비밀번호 확인</label></th>
					<td><input type="password" id="userPwd_confirm" class="w80" name="userPwd_confirm" title="비밀번호를 입력해주세요" value="" maxlength="32"/></td>
				</tr>
				<c:if test="${dataVo.corpNumYN == 1001 || dataVo.corpNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.corpNumYN == 1003 }">
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
				<c:if test="${dataVo.cpNumYN == 1001 || dataVo.cpNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpNumYN == 1003 }">
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
				<c:if test="${dataVo.cpTelNumYN == 1001 || dataVo.cpTelNumYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpTelNumYN == 1003 }">
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
				<c:if test="${dataVo.cpAddrYN == 1001 || dataVo.cpAddrYN == 1003 }">
				<tr>
					<th rowspan="3">
						<c:if test="${dataVo.cpAddrYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="baseAddr">주소</label>
					</th>
					<td>우편번호 :
						<input type="text" id="zipCode1" class="w80" name="zipCode1" value="" maxlength="3" /> -
						<input type="text" id="zipCode2" class="w80" name="zipCode2" value="" maxlength="3" />
						&nbsp;&nbsp;<button type="button" class="gray_s" onclick="jsZipcodePop();">우편번호찾기</button><br/>
					</td>
				</tr>
				<tr>
					<td>기본주소 : <input type="text" id="baseAddr" class="w85_p" name="baseAddr" value="" maxlength="33" /></td>
				</tr>
				<tr>
					<td>상세주소 : <input type="text" id="detailAddr" class="w85_p" name="detailAddr" value="" maxlength="33" /></td>
				</tr>
				</c:if>
				<c:if test="${dataVo.cpCapchaYN == 1001 || dataVo.cpCapchaYN == 1003 }">
				<tr>
					<th>
						<c:if test="${dataVo.cpCapchaYN == 1003 }">
						<span class="tx_red_s">*</span>
						</c:if>
						<label for="state">자동가입방지</label>
					</th>
					<td colspan="3" class="tx_blue_s">
						<p><img src="<c:url value="/simpleCaptcha.do" />" alt="자동가입방지" /></p><br/>
						<input type="text" id="answer" class="w120" name="answer" value="" /> 위에 있는 문자와 동일하게 입력하세요.
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