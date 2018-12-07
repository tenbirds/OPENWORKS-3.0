<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<title>회원관리 | 회원관리 | 회원등록-개인</title>
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript">

     $().ready(function() {

            $(".tx_red").show();
        $(".tx_green").hide();

         $("#Form").validate({
             rules: {
                  userId        : { required: true, alphanumeric: true, nowhitespace: true, minlength: 3, maxlength: 30, remote: "ND_checkDupleId.do" }
                 ,userNm        : { required: true, nowhitespace: true,  maxlength: 30}
//                  <c:if test="${pUserSetYn.juminNumUS != 1002 }">
                     ,jumin1    : {
//                          <c:if test="${pUserSetYn.juminNumUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true, minlength: 6 }
                     ,jumin2    : {
//                          <c:if test="${pUserSetYn.juminNumUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true, minlength: 7 }
//                  </c:if>
//                  <c:if test="${pUserSetYn.emailUS != 1002 }">
                     ,email1    : {
//                          <c:if test="${pUserSetYn.emailUS == 1003 }">
                             required: true,
//                          </c:if>
                         maxlength: 70 }
                     ,email2     : {
//                          <c:if test="${pUserSetYn.emailUS == 1003 }">
                             required: true,
//                          </c:if>
                         maxlength: 30 }
//                  </c:if>
//                  <c:if test="${pUserSetYn.telNumUS != 1002 }">
                     ,telNum1    : {
//                          <c:if test="${pUserSetYn.telNumUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
                     ,telNum2    : {
//                          <c:if test="${pUserSetYn.telNumUS == 1003 }">
                             required: true,
//                          </c:if>
                            number: true }
                     ,telNum3    : {
//                          <c:if test="${pUserSetYn.telNumUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
//                  </c:if>
//                  <c:if test="${pUserSetYn.mobileUS != 1002 }">
                     ,mobile1    : {
//                          <c:if test="${pUserSetYn.mobileUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
                     ,mobile2    : {
//                          <c:if test="${pUserSetYn.mobileUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
                     ,mobile3    : {
//                          <c:if test="${pUserSetYn.mobileUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
//                  </c:if>
//                  <c:if test="${pUserSetYn.addrUS != 1002 }">
                     ,zipCode1    : {
//                          <c:if test="${pUserSetYn.addrUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
                     ,zipCode2    : {
//                          <c:if test="${pUserSetYn.addrUS == 1003 }">
                             required: true,
//                          </c:if>
                         number: true }
                     ,baseAddr    : {
//                          <c:if test="${pUserSetYn.addrUS == 1003 }">
                             required: true,
//                          </c:if>
                         maxlength: 100 }
                     ,detailAddr    : {
//                          <c:if test="${pUserSetYn.addrUS == 1003 }">
                             required: true,
//                          </c:if>
                         maxlength: 100 }
//                  </c:if>
//                  <c:if test="${pUserSetYn.birthdayUS != 1002 }">
                     ,birthday        : {
//                          <c:if test="${pUserSetYn.birthdayUS == 1003 }">
                             required: true,
//                          </c:if>
                         minlength: 8,  number: true }
//                  </c:if>
             },
            messages : {
               userId : {
                   remote : $.validator.format("이미 존재하는 ID 입니다.")
               }
            },
            submitHandler : function(form) {

                 if($("#birthday").val() != ''){
                     var birthday = $("#birthday").val();
                     var birthYear = birthday.substr(0, 4);
                     var birthMonth = birthday.substr(4, 2)-1;
                     var birthDate = birthday.substr(6, 2);
                     var birth = new Date(birthYear, birthMonth, birthDate);

                     if ( birth.getFullYear() != birthYear || birth.getMonth() != birthMonth || birth.getDate() != birthDate) {
                         alert("생년월일을 확인해 주세요.");
                         return;
                     }
                 }

                 if(${pUserSetYn.juminNumUS != 1002 }){
                     if($("#jumin1").val() != '' && $("#jumin2").val() != ''){
                         var juminNum     = $("#jumin1").val() + "-" + $("#jumin2").val() ;
                        $("#juminNum").val(juminNum);
                     }
                 }
                 if(${pUserSetYn.emailUS != 1002 }){
                     if($("#email1").val() != '' && $("#email2").val() != ''){
                         var email         = $("#email1").val() + "@" + $("#email2").val() ;
                        $("#email").val(email);
                     }
                 }
                 if(${pUserSetYn.telNumUS != 1002 }){
                     if($("#telNum1").val() != '' && $("#telNum2").val() != '' && $("#telNum3").val() != ''){
                         var telNum        = $("#telNum1").val() + "-" + $("#telNum2").val() + "-" + $("#telNum3").val() ;
                        $("#telNum").val(telNum);
                     }
                 }
                 if(${pUserSetYn.mobileUS != 1002 }){
                     if($("#mobile1").val() != '' && $("#mobile2").val() != '' && $("#mobile3").val() != ''){
                         var mobile         = $("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val() ;
                        $("#mobile").val(mobile);
                     }
                 }
                 if(${pUserSetYn.addrUS != 1002 }){
                     if($("#zipCode1").val() != '' && $("#zipCode2").val() != ''){
                         var zipCode     = $("#zipCode1").val() + "-" + $("#zipCode2").val() ;
                        $("#zipCode").val(zipCode);
                     }
                 }

                 $(form).ajaxSubmit({
                    url            : "ND_pInsertAction.do",
                    type        : "POST",
                    dataType : "json",
                    success    : function(response) {
                         if (response.result) {
                             jsSuccessBox(response.message);
                             self.location.href = "PD_pOptionInsertForm.do?userId=" + $("#userId").val();
                         }else{
                             jsErrorBox(response.message);
                         }
                    }
                 });
              }
         });
     });

     var topDataToggle = function(id){

          if(id == "base"){
              self.location.href = "PD_pInsertForm.do";
          } else if(id == "add"){
             jsWarningBox("개인회원을 등록한 후 추가정보를 입력하실 수 있습니다.<br />이미 등록된 아이디는 회원상세정보 페이지에서 추가하실 수 있습니다.")
              return;
          } else if(id == "mileage"){
             jsWarningBox("개인회원을 등록한 후 마일리지정보를 입력하실 수 있습니다.<br />이미 등록된 아이디는 회원상세정보 페이지에서 추가하실 수 있습니다.")
              return;
          }
     };

     var birDateTypes = function(value){
        var checkedYn = $("#checkedYn").val();
         if(value == "1001" || value == "1002"){
            $("#birDateType3").attr("checked", false);
            $("#birDateType").val(value);
            checkedYn = 'N';
         }else{
             if(checkedYn == 'N'){
                $("#birDateType2").selected();
                $("#birDateType").val(value);
                checkedYn = 'Y';
             }else{
                $("#birDateType").val("1002");
                checkedYn = 'N';
             }
         }
     };

     var emailSelected = function(){
         var emailCd = $("#emailList").val();
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

     var userSecurity = function (el) {

        $(el).colorbox({
            title : "보안등급정책",
            href : "PD_userSecurity.do",
            width : "800",
            height : "550",
            iframe : true
        });
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

    var userList = function(){

        parent.$.fn.colorbox.close();
        parent.location.href = "BD_index.do?pwdYn="+"Y";

    };


    var jsZipcodePop = function (el, zcId, adr1, adr2) {
  	  	$("#zipCodeId").val(zcId);
        $("#baseAddrId").val(adr1);
        $("#detailAddrId").val(adr2);
        
        $(el).colorbox({
            title : "우편번호 검색",
            href : "/intra/zipcode/PD_searchList.do",
            width : "1000",
            height : "800",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
    };

     </script>
</head>
<body>
    <!-- 컨텐츠영역 -->
    <form id="Form">

        <input type="hidden" id="juminNum" name="juminNum" value="" />
        <input type="hidden" id="email" name="email" value="" />
        <input type="hidden" id="telNum" name="telNum" value="" />
        <input type="hidden" id="mobile" name="mobile" value="" />
        <input type="hidden" id="zipCode" name="zipCode" value="" />
        <input type="hidden" id="birDateType" name="birDateType" value="" />
        <input type="hidden" id="checkedYn" value="N" />
        <!--         <input type="hidden" id="insertOk" name="insertOk" value=""/> -->
        <div id="popup">

            <!-- 탭 -->
            <ul class="tab">
                <li><a href="#" id="base" onclick="topDataToggle('base');" class="on">기본정보</a></li>
                <li><a href="#" id="add" onclick="topDataToggle('add');">추가정보</a></li>
                <c:if test="${pUserSetYn.mileageUS != 1002 }">
                <li><a href="#" id="mileage" onclick="topDataToggle('mileage');">마일리지정보</a></li>
                </c:if>
            </ul>
            <!-- //탭 -->

            <!-- 기본정보 -->
            <h2 class="mar_t20">기본정보</h2>

            <fieldset>
                <legend>개인회원등록</legend>
                <table class="boardWrite" cellspacing="0" border="0"
                    summary="개인회원등록을 하실 수 있습니다.">
                    <caption class="hidden">개인회원등록</caption>
                    <colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><span class="tx_red_s">*</span> <label for="userId">아이디</label>
                            </th>
                            <td colspan="3" class="tx_blue_s"><input type="text"
                                id="userId" class="w80" name="userId" value="" /> (영문/숫자조합
                                최대20자)</td>
                        </tr>
                        <tr>
                            <th><span class="tx_red_s">*</span> <label for="userNm">성명</label>
                            </th>
                            <td colspan="3"><input type="text" id="userNm" class="w80"
                                name="userNm" value="" /></td>
                        </tr>
                        <tr>
                            <th><span class="tx_red_s">*</span> <label for="userPwd">비밀번호</label>
                            </th>
                            <td colspan="3"><input type="password" id="userPwd"
                                class="w80" name="userPwd" title="비밀번호를 입력해주세요" value=""
                                onblur="pwdUseYn()" />
                                <p class="tx_blue_s">
                                    - 보안등급 : <span class="tx_red"><b>사용불가</b></span><span
                                        style="color: green;" class="tx_green"><b>사용가능</b></span> (최소
                                    9자, 최대 32자/ 영문(대/소문자), 숫자, 특수문자 조합)&nbsp;&nbsp;
                                    <button type="button" onclick="userSecurity(this);"
                                        class="gray_s">보안등급정책</button>
                                    <br /> - 비밀번호 등록 또는 변경시 보안등급을 확인하여 안전하게 변경하시기 바랍니다.
                                </p></td>
                        </tr>
                        <tr>
                            <th><span class="tx_red_s">*</span> <label for="userPwd1">비밀번호
                                    확인</label></th>
                            <td colspan="3"><input type="password" id="userPwd1"
                                class="w80" name="userPwd1" title="비밀번호를 입력해주세요" value="" /></td>
                        </tr>
                        <c:if test="${pUserSetYn.juminNumUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.juminNumUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="jumin1">주민등록번호</label></th>
                                <td colspan="3"><input type="text" id="jumin1" class="w80"
                                    name="jumin1" title="주민번호를 입력해주세요" maxlength="6" value="" /> -
                                    <input type="text" id="jumin2" class="w80" name="jumin2"
                                    title="주민번호를 입력해주세요" maxlength="7" value="" /></td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.emailUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.emailUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="email">이메일</label></th>
                                <td colspan="3"><input type="text" id="email1" class="w80"
                                    name="email1" title="이메일을 입력해주세요" value="" /> @ <input
                                    type="text" id="email2" class="w120" name="email2"
                                    title="도메인을 입력해주세요" value="" /> <op:code id="emailList"
                                        grpCd="80" onchange="emailSelected();" /></td>
                            </tr>
                        </c:if>
                        <tr>
                            <th><label for="userGrade">회원등급</label></th>
                            <td>
                                <select name="userGradeCd" id="userGradeCd">
                                    <option value="">--선택하세요--</option>
                                <c:forEach items="${dataList}" var="_bean">
                                    <option value="${_bean.userGradeCd}">${_bean.userGradeNm}</option>
                                </c:forEach>
                                </select>
                            </td>
                            <th>가입유형</th>
                            <td><op:code id="regType" grpCd="71" /></td>
                        </tr>
                        <c:if test="${pUserSetYn.telNumUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.telNumUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="telNum1">일반전화</label></th>
                                <td colspan="3"><input type="text" id="telNum1" class="w80"
                                    name="telNum1" title="국번을 입력해주세요" maxlength="5" value="" /> -
                                    <input type="text" id="telNum2" class="w80" name="telNum2"
                                    title="앞자리를 입력해주세요" maxlength="4" value="" /> - <input
                                    type="text" id="telNum3" class="w80" name="telNum3"
                                    title="전화번호를 입력해주세요" maxlength="4" value="" /></td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.mobileUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.mobileUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="mobile1">휴대전화</label></th>
                                <td colspan="3"><op:code id="mobile1" grpCd="66" /> - <input
                                    type="text" id="mobile2" class="w80" name="mobile2"
                                    title="앞자리를 입력해주세요" maxlength="4" value="" /> - <input
                                    type="text" id="mobile3" class="w80" name="mobile3"
                                    title="전화번호를 입력해주세요" maxlength="4" value="" /></td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.addrUS != 1002 }">
                            <tr>
                                <th rowspan="3"><c:if test="${pUserSetYn.addrUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> 주소</th>
                                <td colspan="3">우편번호 : <input type="text" id="zipCode1"
                                    class="w80" name="zipCode1" value="" /> - <input type="text"
                                    id="zipCode2" class="w80" name="zipCode2" value="" />
                                    &nbsp;&nbsp;
                                    <button type="button" class="gray_s" onclick="jsZipcodePop(this,'zipCode','baseAddr','detailAddr');">우편번호찾기</button> <br />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">기본주소 : <input type="text" id="baseAddr"
                                    class="w85_p" name="baseAddr" value="" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">상세주소 : <input type="text" id="detailAddr"
                                    class="w85_p" name="detailAddr" value="" />
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.birthdayUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.birthdayUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="birthday">생년월일</label></th>
                                <td colspan="3"><input type="text" id="birthday"
                                    class="w120" name="birthday" value="" maxlength="8" /> <span
                                    class="tx_blue_s">예) 20111115</span> &nbsp;&nbsp;&nbsp; <input
                                    type="radio" name="birDateType1" id="birDateType1"
                                    onclick="birDateTypes('1001')" /> <label for="birDateType1">양력</label>
                                    <input type="radio" name="birDateType1" id="birDateType2"
                                    onclick="birDateTypes('1002')" /> <label for="birDateType2">음력</label>
                                    <input type="checkbox" name="birDateType3" id="birDateType3"
                                    onclick="birDateTypes('1003')" /> <label for="birDateType3">윤달</label>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.sexUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.sexUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="people">성별</label></th>
                                <td colspan="3"><op:code id="sex" grpCd="75" type="radio" />
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.mailingUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.mailingUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="mailingYn">메일링서비스</label></th>
                                <td colspan="3"><op:code id="mailingYn" grpCd="76"
                                        type="radio" /></td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.smsCallUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.smsCallUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="smsCallYn">sms수신</label></th>
                                <td colspan="3"><op:code id="smsCallYn" grpCd="77"
                                        type="radio" /></td>
                            </tr>
                        </c:if>
                        <c:if test="${pUserSetYn.captchaUS != 1002 }">
                            <tr>
                                <th><c:if test="${pUserSetYn.captchaUS == 1003 }">
                                        <span class="tx_red_s">*</span>
                                    </c:if> <label for="state">자동가입방지</label></th>
                                <td colspan="3" class="tx_blue_s">
                                    <p>
                                        <img src="<c:url value="/simpleCaptcha.do" />" alt="자동가입방지" />
                                    </p><br/> <input type="text" id="answer" class="w120" name="answer"
                                    value="" /> 위에 있는 문자와 동일하게 입력하세요.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </fieldset>
            <!-- //기본정보 -->

            <p class="tx_c mar_t20">
                <a href="#">
                    <button type="submit" class="blue">등록</button>
                </a> <a href="#">
                    <button type="button" onclick="userList();" class="blue">취소</button>
                </a>
            </p>

        </div>
    </form>
    <!-- //컨텐츠영역 -->

</body>
</html>