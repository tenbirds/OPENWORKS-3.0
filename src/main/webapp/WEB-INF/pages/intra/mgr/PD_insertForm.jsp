<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>담당자등록</title>

<op:jsTag type="spi" items="extjs,colorbox,validate,form" />
<op:jsTag type="openworks" items="tree" />
<script type="text/javascript" src="<c:url value="/resources/openworks/login/js/validationOfPassword.js" />"></script>
<script type="text/javascript">
        //Extjs 트리의 설정값 설정하는 부분
    var ROOT_TREE_ID ='<%=zes.openworks.common.GlobalConfig.HIGH_DEPT_CD%>';
    var TREE_EL_ID = "treeCombo";
    var ROOT_TREE_TEXT = "부서목록";
    var PANEL_SIZE_HEIGHT = 100;

    var IS_USE = true;
    var DEFAULT_VALUE = "${param.deptCode}";
    var PARENT_NODE_ID_VAR = "upperDeptCode";
    var NODE_ID_VAR = "deptCode";
    var TREE_JSON_URL = '<c:url value="/intra/dept/INC_deptList.do"/>';
    var VIEW_URL = "ND_mgrListWithPermission.do";

    var SELECTED_NODE_ID = "deptCode";
    var IS_SELECTED_NODE = false; 
    if("${param.deptCode}" != "") {
        IS_SELECTED_NODE = true; 
    }

    $().ready(function() {

        $("#securityBtn").colorbox({
            title  :    "보안등급정책",
            href   :    "PD_security.do",
            width  :    "815" ,
            height :    "740" ,
            iframe :    true
        });

        $("#dataForm").validate({
            rules : {
                mngrId : {
                    required : true,
                    alphanumeric : true,
                    minlength : 8,
                    maxlength : 15,
                    remote : "ND_checkDupleId.do"
                },
                mngrNm : {
                    required : true,
                    minlength : 2,
                    maxlength : 20
                },
                deptCode : {
                    required : true
                },
                mngrPassword : {
                    required : true,
                    nowhitespace: true,
                    minlength : 10,
                    maxlength : 16
                },
                mngrPassword_confirm : {
                    required : true,
                    equalTo : "#mngrPassword"
                },
                telNum1 : {
                    required : false,
                    number : true,
                    minlength : 2,
                    maxlength : 3
                },
                telNum2 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                telNum3 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                faxNum1 : {
                    required : false,
                    number : true,
                    minlength : 2,
                    maxlength : 3
                },
                faxNum2 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                faxNum3 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                mobile1 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 3
                },
                mobile2 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                mobile3 : {
                    required : false,
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                emailT : {
                    required : false,
                    email : false,
                    minlength : 1,
                    maxlength : 80
                },
                email_add : {
                    required : false,
                    email : false,
                    minlength : 8,
                    maxlength : 19
                },
                chrgJob : {
                    required : false,
                    minlength : 1,
                    maxlength : 250
                }
            },
            messages : {
                mngrId : {
                    remote : $.validator.format("이미 존재하는 ID 입니다.")
                },
                mngrPassword_confirm : {
                    equalTo : "비밀번호를 동일하게 입력해주세요."
                }
            },
            submitHandler : function(form) {
                $("#deptCode").val();
                checkSubmit();
                if(pwdUseYn()){
                    $(form).ajaxSubmit({
                        url : "ND_insertAction.do",
                        type : "POST",
                        success : function(response) {
                            var success = false;
                            // 프로그램 오류 반환시 처리
                            try {
                                success = eval(response);
                            } catch(e) {
                                jsErrorBox(Message.msg.processError);
                                return;
                            }
                            // 프로그램 오류가 없는 경우. 처리 결과에 따른 메시지 출력
                            if(success) {
                                jsSuccessBox(Message.msg.insertOk);
                                parent.$.fn.colorbox.close();
                                parent.$("#treeDetailDiv").load(VIEW_URL, $('#dataForm').serialize());
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        }
                    });
                }
            }
        });
    });

    var pwdUseYn = function(){
        <%-- 비밀번호 적합성 검사 --%>
        $("#pwdGrade").removeClass().addClass("tx_red").text("사용불가");
        var pwd = $("#mngrPassword").val();
        if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
            $("#mngrPassword").focus();
            jsWarningBox(Message.msg.passwordCheck2);
            return false;
        }
        <%--개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수--%>
        vrtn = validPwd(pwd, $("#mngrId").val(), '', $("#emailT").val()+"@"+$("#email_add").val(), $("#mobile1").val()+$("#mobile2").val()+$("#mobile3").val());
        if(vrtn != ''){
            $("#mngrPassword").focus();
            jsWarningBox(vrtn);
            return false;
        } else {
            $("#pwdGrade").removeClass().addClass("tx_green").text("사용가능");
            return true;
        }
    };

    function checkSubmit() {

        var frm = document.dataForm;

        if(frm.telNum1.value != "" && frm.telNum2.value != "" && frm.telNum3.value != "") {

            frm.telno.value = frm.telNum1.value + "-" + frm.telNum2.value + "-" + frm.telNum3.value;
        }
        if(frm.faxNum1.value != "" && frm.faxNum2.value != "" && frm.faxNum3.value != "") {

            frm.fxnum.value = frm.faxNum1.value + "-" + frm.faxNum2.value + "-" + frm.faxNum3.value;
        }
        if(frm.mobile1.value != "" && frm.mobile2.value != "" && frm.mobile3.value != "") {

            frm.mbtlnum.value = frm.mobile1.value + "-" + frm.mobile2.value + "-" + frm.mobile3.value;
        }
        if(frm.emailT.value != "" && frm.email_add.value != "") {

            frm.email.value = frm.emailT.value + "@" + frm.email_add.value;
        }

    }

    var jsView = function(node) {
        $("#deptCode").val(node.id);
    };

    //선택한 메일 주소 뒷자리 input박스에 넣고 포커스 이동 기능
    function mail_ok(values) {
        frm = document.dataForm;
        frm.email_add.value = values;
        frm.email_add.focus();
    }
    
      //글자수체크
    function displayBytes( num, id ){
        var form = document.dataForm;
        var obj  = document.getElementById(id);
        if(obj.value.bytes() > num){
            //if(window.event.keyCode != '8'){
                alert(num+'바이트까지 입력이 가능합니다.');
            //}
            obj.value = obj.value.substring(0, obj.value.length-10);
        }
        eval('document.all.'+id+'_bytes').innerHTML = eval('form.'+id).value.bytes()+" byte";
    }

    String.prototype.bytes = function(){
        var str = this;
        var size = 0;
        for (var i=0; i<str.length; i++){
            size += (str.charCodeAt(i) > 128) ? 2 : 1;
        }
        return size;
    };
    
    function jsShowPwd() {
        jsWarningBox("입력하신 비밀번호 : [" + $("#mngrPassword").val() + "]");
    }
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <form id="dataForm" name="dataForm">
        <input type="hidden" id="telno" name="telno" value="${mgrVO.telno}" />
        <input type="hidden" id="fxnum" name="fxnum" value="${mgrVO.fxnum}" />
        <input type="hidden" id="mbtlnum" name="mbtlnum" value="${mgrVO.mbtlnum}" />
        <input type="hidden" id="email" name="email" value="${mgrVO.email}" />
        <!-- <div class="pop_tit">
                    <h1>담당자 정보</h1>
                    <img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_close.gif" />" alt="창닫기"/>
                </div> -->

        <div style="width: 100%;">
            <h2 class="float_l">기본정보</h2>
            <div class="float_r">
                <span class="tx_red tx_b">*</span>는 필수입력 항목입니다.
            </div>
        </div>
        <div class="clear"></div>
        <!-- 기본정보 내용 -->
        <fieldset>
            <legend>기본정보 등록하기</legend>
            <table class="boardWrite" cellspacing="0" border="0"
                summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden">기본정보 등록하기</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="mngrId">아이디<span class="tx_red_s tx_b">*</span></label></th>
                        <td><input type="text" id="mngrId" class="w120" name="mngrId" value="" maxlength="15" style="ime-mode: disabled;" />
                            <span class="tx_gray tx_11">(영문,숫자 조합 최대 15자)</span>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="mngrNm">이름<span class="tx_red_s tx_b">*</span></label></th>
                        <td><input type="text" id="mngrNm" class="w120" name="mngrNm" value="" maxlength="20" />
                            <span class="tx_gray tx_11">(최대 20자)</span>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="ofcpsCd">직위</label></th>
                        <td><op:code id="ofcpsCd" grpCd="9" defaultLabel="--직위선택--" /></td>
                    </tr>
                    <tr>
                        <th><label for="deptCode">부서명<span class="tx_red_s tx_b">*</span></label></th>
                        <td>
                            <div id="treeCombo"></div>
                            <input type="hidden" name="deptCode" id="deptCode" value="${param.deptCode}" />
                         </td>
                    </tr>
                    <tr>
                        <th><label for="mngrPassword">비밀번호<span class="tx_red_s">*</span></label></th>
                        <td><input type="password" id="mngrPassword" class="w120" name="mngrPassword" value="" maxlength="16" onchange="pwdUseYn()"/>
                            <p class="mar_t5">
                                <span class="tx_gray tx_11">[보안등급 : <span id="pwdGrade" class="tx_red">(사용불가)</span>]<br/>
                                    (최소 10자, 최대 16자/영문(대/소문자), 숫자, 특수문자 조합) <br/> 비밀번호 등록 또는 변경시 보안등급을 확인하여 안전하게 변경하시기 바랍니다.</span>
                                    <a href="#"><button class="gray_s" id="securityBtn">보안등급정책</button>
                                </a>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="mngrPassword_confirm">비밀번호 확인<span class="tx_red_s">*</span></label></th>
                        <td><input type="password" id="mngrPassword_confirm" class="w120" name="mngrPassword_confirm" value="" maxlength="16" />
                            <button class="gray_s" type="button" onclick="jsShowPwd();">비밀번호보기</button>
                            <p class="mar_t5">
                                <span class="tx_gray tx_11">재확인을 위해서 입력하신 비밀번호를 다시 한번 입력해주세요.</span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <!-- //기본정보 내용 -->


        <h2 class="mar_t20">추가정보</h2>
        <!-- 추가정보 내용 -->
        <fieldset>
            <legend>추가정보 등록하기</legend>
            <table class="boardWrite" cellspacing="0" border="0"
                summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden">추가정보 등록하기</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="telNum1">전화번호</label>
                        </th>
                        <td><input type="text" id="telNum1" class="w55" name="telNum1" title="국번을 입력해주세요"   value="" maxlength="3" /> -
                            <input type="text" id="telNum2" class="w55" name="telNum2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
                            <input type="text" id="telNum3" class="w55" name="telNum3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
                            <span class="tx_gray tx_11">(ex:02-333-3333)</span></td>
                    </tr>
                    <tr>
                        <th><label for="faxNum1">팩스번호</label>
                        </th>
                        <td><input type="text" id="faxNum1" class="w55" name="faxNum1" title="국번을 입력해주세요"   value="" maxlength="3" /> -
                            <input type="text" id="faxNum2" class="w55" name="faxNum2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
                            <input type="text" id="faxNum3" class="w55" name="faxNum3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
                            <span class="tx_gray tx_11">(ex:02-333-3333)</span></td>
                    </tr>
                    <tr>
                        <th><label for="mobile1">휴대폰번호</label>
                        </th>
                        <td><input type="text" id="mobile1" class="w55" name="mobile1" title="앞자리를 입력해주세요"   value="" maxlength="3" /> -
                            <input type="text" id="mobile2" class="w55" name="mobile2" title="중간자리를 입력해주세요" value="" maxlength="4" /> -
                            <input type="text" id="mobile3" class="w55" name="mobile3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
                            <span class="tx_gray tx_11">(ex:010-333-3333)</span></td>
                    </tr>
                    <tr>
                        <th><label for="emailT">이메일</label>
                        </th>
                        <td><input type="text" id="emailT" class="w80" name="emailT" title="이메일 아이디를 입력해주세요" value="" maxlength="80" style="ime-mode:disabled;" /> @
                            <input type="text" id="email_add" class="w120" name="email_add" title="이메일 주소를 입력해주세요" value="" maxlength="19" />
                            <select id="email_add2" name="email_add2" class="over" onchange="mail_ok(this.value)">
                                <option value="" selected="selected">선택</option>
                                <option value="naver.com">naver.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hotmail.com">hotmail.com</option>
                                <option value="nate.com">nate.com</option>
                                <option value="hanmir.com">hanmir.com</option>
                                <option value="hitel.net">hitel.net</option>
                                <option value="chol.com">chol.com</option>
                                <option value="dreamwiz.com">dreamwiz.com</option>
                                <option value="empal.com">empal.com</option>
                                <option value="freechal.com">freechal.com</option>
                                <option value="hdsmail.co.kr">hdsmail.co.kr</option>
                                <option value="korea.com">korea.com</option>
                                <option value="lycos.co.kr">lycos.co.kr</option>
                                <option value="netian.com">netian.com</option>
                                <option value="qook.co.kr">qook.co.kr</option>
                                <option value="yahoo.co.kr">yahoo.co.kr</option>
                                <option value="yahoo.com">yahoo.com</option>
                                <option value="">직접입력</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="chrgJob">담당업무<br/>(250자이내)</label>
                        <br/><b><span class="tx_blue_s"><div id="chrgJob_bytes"></div></span></b>
                        </th>
                        <td><textarea id="chrgJob" name="chrgJob" rows="8" class="w99_p" onkeydown="displayBytes(250,'chrgJob');"></textarea></td>
                    </tr>
                    <tr>
                        <th>사용여부</th>
                        <td>
                            <input type="radio" name="useYn" id="useYn_Y" value="Y" checked="checked" />
                            <label for="useYn_Y">사용</label>
                            <input type="radio" name="useYn" id="useYn_N" value="N" />
                            <label for="useYn_N">미사용 <span class="tx_gray tx_11">(미사용 선택시 시스템 접속(로그인)이 거부됩니다.)</span></label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <!-- //추가정보 내용 -->

        <p class="tx_r mar_t20">
            <a href="#"><button type="submit" class="blue">등록</button></a>
        </p>

        <!-- //컨텐츠영역 -->
    </form>
</body>
</html>