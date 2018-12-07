<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
<op:jsTag type="spi" items="form,validate,extjs,colorbox" />
<op:jsTag type="openworks" items="tree" />

<script type="text/javascript">

    //Extjs 트리의 설정값 설정하는 부분
    var ROOT_TREE_ID      = '<%=zes.openworks.common.GlobalConfig.HIGH_DEPT_CD%>';
    var ROOT_TREE_TEXT    = "부서목록";
    var TREE_EL_ID        = "treeCombo";
    var PANEL_SIZE_HEIGHT = 100;

    var IS_USE = true;
    var DEFAULT_VALUE      = "${dataVo.deptCode}";
    var PARENT_NODE_ID_VAR = "upperDeptCode";
    var NODE_ID_VAR        = "deptCode";
    var TREE_JSON_URL      = '<c:url value="/intra/dept/INC_deptList.do" />';
    var VIEW_URL           = "ND_mgrListWithPermission.do";
    var DELETE_URL         = "ND_deleteAction.do";

    var IS_SELECTED_NODE = true;
    var SELECTED_NODE_ID = 'deptCode';

    $().ready(function() {
        var oldNode = parent.treePanel.getSelectionModel().getSelectedNode();
        $('#oldDeptCd').val(oldNode.id);

        $("#securityBtn").colorbox({
            title  : "보안등급정책",
            href   : "PD_security.do",
            width  : "815",
            height : "740",
            iframe : true
        });

        if ($("#telno").val()) {

            var t_data = $("#telno").val();
            var tel_data = t_data.split("-");
            document.getElementById("telNum1").value = tel_data[0];
            document.getElementById("telNum2").value = tel_data[1];
            document.getElementById("telNum3").value = tel_data[2];

        }

        if ($("#fxnum").val()) {

            var f_data = $("#fxnum").val();
            var fax_data = f_data.split("-");
            document.getElementById("faxNum1").value = fax_data[0];
            document.getElementById("faxNum2").value = fax_data[1];
            document.getElementById("faxNum3").value = fax_data[2];

        }

        if ($("#mbtlnum").val()) {

            var m_data = $("#mbtlnum").val();
            var mobile_data = m_data.split("-");
            document.getElementById("mobile1").value = mobile_data[0];
            document.getElementById("mobile2").value = mobile_data[1];
            document.getElementById("mobile3").value = mobile_data[2];

        }

        if ($("#email").val()) {

            var e_data = $("#email").val();
            var email_data = e_data.split("@");
            document.getElementById("emailT").value = email_data[0];
            document.getElementById("email_add").value = email_data[1];

        }
    });

    //         $().ready(function() {});
    var jsupdateAction = function() {
        $("#dataForm").validate({
            rules : {
                deptCode : {
                    required : true
                },
                mgrPwd : {
                    required : true,
                    minlength : 10,
                    maxlength : 16
                },
                mgrPwd_confirm : {
                    required : true,
                    minlength : 10,
                    maxlength : 16,
                    equalTo : "#mgrPwd"
                },
                telNum1 : {
                    number : true,
                    minlength : 2,
                    maxlength : 3
                },
                telNum2 : {
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                telNum3 : {
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                faxNum1 : {
                    number : true,
                    minlength : 2,
                    maxlength : 3
                },
                faxNum2 : {
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                faxNum3 : {
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                mobile1 : {
                    number : true,
                    minlength : 3,
                    maxlength : 3
                },
                mobile2 : {
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                mobile3 : {
                    number : true,
                    minlength : 3,
                    maxlength : 4
                },
                emailT : {
                    email : false,
                    minlength : 1,
                    maxlength : 80
                },
                email_add : {
                    email : false,
                    minlength : 8,
                    maxlength : 19
                },
                chrgJob : {
                    minlength : 1,
                    maxlength : 250
                }
            },
            messages : {
                mngrId : {
                    remote : $.validator.format("이미 존재하는 ID 입니다."),
                    rangelength: [8, 15]
                }
            },
            submitHandler : function(form) {
                checkSubmit();
                $(form).ajaxSubmit({
                    url : "ND_updateAction.do",
                    type : "POST",
                    success : function(response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
                                parent.$.fn.colorbox.close();
                                $('#deptCode').val($('#oldDeptCd').val()); // 원래의 부서로 리프레시 해주기.
                                parent.$("#treeDetailDiv").load(VIEW_URL, $('#dataForm').serialize());
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
    };

    function checkSubmit() {

        var frm = document.dataForm;

        if(frm.telNum1.value != "" && frm.telNum2.value != "" && frm.telNum3.value != "") {
            frm.telno.value = frm.telNum1.value + "-" + frm.telNum2.value + "-" + frm.telNum3.value;
        }else if(frm.telNum1.value == "" || frm.telNum2.value == "" || frm.telNum3.value == ""){
            frm.telno.value = "";
        }

        if(frm.faxNum1.value != "" && frm.faxNum2.value != "" && frm.faxNum3.value != "") {
            frm.fxnum.value = frm.faxNum1.value + "-" + frm.faxNum2.value + "-" + frm.faxNum3.value;
        }else if(frm.faxNum1.value == "" || frm.faxNum2.value == "" || frm.faxNum3.value == ""){
            frm.fxnum.value = "";
        }

        if(frm.mobile1.value != "" && frm.mobile2.value != "" && frm.mobile3.value != "") {
            frm.mbtlnum.value = frm.mobile1.value + "-" + frm.mobile2.value + "-" + frm.mobile3.value;
        }else if(frm.mobile1.value == "" || frm.mobile2.value == "" || frm.mobile3.value == "") {
            frm.mbtlnum.value = "";
        }

        if(frm.emailT.value != "" && frm.email_add.value != "") {
            frm.email.value = frm.emailT.value + "@" + frm.email_add.value;
        }else if(frm.emailT.value == "" || frm.email_add.value == "") {
            frm.email.value = "";
        }
    }

    var passwordUpdete = function(el, vl) {
        $(el).colorbox({
            title  : vl+"님 비밀번호 변경하기",
            href   : "PD_passwordUpdate.do?mngrId=" + vl,
            width  : "770",
            height : "500",
            iframe : true
        });
    };

    var targetAssignListPop = function(el, vl, authCode) {
        $(el).colorbox({
            title  : "지정 권한 목록",
            href   : "PD_targetAssign.do?mngrId=" + vl + "&authCode=" + authCode,
            width  : "530",
            height : "550",
            iframe : true
        });
    };

    var targetAssignPop = function(el, vl, deptCode) {
        $(el).colorbox({
            title  : "지정 권한 등록",
            href   : "PD_authAssignForm.do?mngrId=" + vl + "&mode=form",
            width  : "630",
            height : "550",
            iframe : true
        });
    };

    //트리 선택시 노드 아이디, 노드 이름 선택 기능
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

    var jsShowPwd = function() {
        jsMsgBox($("#mngrNm").val() + "님의 현재 비밀번호는[" + $("#mgrPwd").val() + "] 입니다.");
    };

    var jsInitPwd = function(mngrId) {
        if(confirm($("#mngrNm").val() + "님의 비밀번호를 초기화 하시겠습니까?")) {
            $.post("ND_mgrPwdUpdateAction.do", {
                mngrId : mngrId
            }, function(result) {
                jsMsgBox($("#mngrNm").val() + "님의 비밀번호를 초기화했습니다.");
                self.location.reload();
            }, "json");
        }
    };

    var jsDeleteAction = function() {
        if(confirm("정말 삭제 하시겠습니까?")) {
            $('#dataForm').ajaxSubmit({
                url : DELETE_URL,
                type : "POST",
                success : function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            parent.$.fn.colorbox.close();
                            $('#deptCode').val($('#oldDeptCd').val());
                            parent.$("#treeDetailDiv").load(VIEW_URL, $('#dataForm').serialize());
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
    };

    var jsWebLogView = function (el) {
        $(el).colorbox({
            title  : "접속 이력 보기",
            href   : "PD_webLog.do?q_rowPerPage=5&mngrId=" + $('#mngrId').val(),
            width  : $(window).width(),
            height : "550",
            iframe : true
        });
    };

    var jsChangeLogView = function (el) {
        $(el).colorbox({
            title  : "변경 이력 보기",
            href   : "PD_changeLog.do?q_rowPerPage=5&mngrId=" + $('#mngrId').val()+"&q_sType=ALL",
            width  : $(window).width(),
            height : "550",
            iframe : true
        });
    };

    var jsSetAssignListArea = function(obj, authCode) {
        if(obj == ""){
           obj = '[지정된 권한이 없습니다.]';
           str = '<a href="#"><button onclick="targetAssignPop(this,\'${dataVo.mngrId}\');" class="gray_s">지정권한 등록</button></a>';
        }else{
           str = '<a href="#" onclick="targetAssignListPop(this,\'${dataVo.mngrId}\', \''+authCode+'\');"> <button class="gray_s">보기</button> </a>';
           str+= '<a href="#"><button onclick="targetAssignPop(this,\'${dataVo.mngrId}\');" class="gray_s">지정권한 수정</button></a>';
        }

        $("#assignBtnArea").html(str);
        $("#assignListArea").html(obj);
    };
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <form id="dataForm" name="dataForm">
    <input type="hidden" id="telno" name="telno" value="${dataVo.telno}" />
    <input type="hidden" id="fxnum" name="fxnum" value="${dataVo.fxnum}"/>
    <input type="hidden" id="mbtlnum" name="mbtlnum" value="${dataVo.mbtlnum}"/>
    <input type="hidden" id="email" name="email" value="${dataVo.email}"/>

    <input type="hidden" name="q_currPage" id="q_currPage" value="${param.q_currPage}" />

    <div style="width: 100%;">
        <h2 class="float_l">기본정보</h2>
        <div class="float_r">
            <span class="tx_red tx_b">*</span>는 필수입력 항목입니다.
        </div>
    </div>
    <div class="clear"></div>

    <!-- 기본정보 내용 -->
    <fieldset>
        <legend>기본정보 수정하기</legend>

        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 수정하실 수 있습니다.">
            <caption class="hidden">기본정보 수정하기</caption>

            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="mngrId">아이디<span class="tx_red_s tx_b">*</span></label></th>
                    <td>
                        <c:if test="${not empty dataVo.mngrId}">
                            <span class="tx_b tx_blue">${dataVo.mngrId}</span>
                            <input type="hidden" name="mngrId" id="mngrId" value="${dataVo.mngrId}" />
                        </c:if>
                        <c:if test="${empty dataVo.mngrId}">
                            <input type="text" name="mngrId" id="mngrId" value="${dataVo.mngrId}" readonly="readonly" />
                            <span class="tx_gray tx_11">(영문,숫자 조합 8 ~ 15자) </span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th><label for="mngrNm">이름<span class="tx_red_s tx_b">*</span></label></th>
                    <td>
                        <input type="text" name="mngrNm" id="mngrNm" value="${dataVo.mngrNm}" />
                        <span class="tx_gray tx_11">(최대 20자)</span>
                    </td>
                </tr>
                <tr>
                    <th><label for="ofcpsCd">직위</label></th>
                    <td><op:code id="ofcpsCd" grpCd="9" defaultValues="${dataVo.ofcpsCd}" defaultLabel="--직위선택--" /></td>
                </tr>
                <tr>
                    <th><label for="deptCode">부서명<span class="tx_red_s tx_b">*</span></label></th>
                    <td>
                        <div id="treeCombo"></div>
                        <input type="hidden" name="deptCode" id="deptCode" value="${dataVo.deptCode}" />
                        <input type="hidden" name="oldDeptCd" id="oldDeptCd" />
                    </td>
                </tr>
                <tr>
                    <th><label for="mgrPwd">비밀번호<span class="tx_red_s tx_b">*</span></label></th>
                    <td>
                    <a href="#"><button onclick="passwordUpdete(this,'${dataVo.mngrId}');" class="gray_s">비밀번호변경</button></a>
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!-- //기본정보 내용 -->

    <!-- 	<br class="blank"/> -->

    <h2 class="mar_t20">추가정보</h2>
    <!-- 추가정보 내용 -->
    <fieldset>
        <legend>추가정보 수정하기</legend>
        <table class="boardWrite" cellspacing="0" border="0"
            summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden">추가정보 수정하기</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="telNum1">전화번호</label></th>
                    <td><input type="text" id="telNum1" class="w55" name="telNum1" title="국번을 입력해주세요"   value="" maxlength="3" /> -
                        <input type="text" id="telNum2" class="w55" name="telNum2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
                        <input type="text" id="telNum3" class="w55" name="telNum3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
                    </td>
                </tr>
                <tr>
                    <th><label for="faxNum1">팩스번호</label></th>
                    <td><input type="text" id="faxNum1" class="w55" name="faxNum1" title="국번을 입력해주세요"   value="" maxlength="3" /> -
                        <input type="text" id="faxNum2" class="w55" name="faxNum2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
                        <input type="text" id="faxNum3" class="w55" name="faxNum3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
                        <span class="tx_gray tx_11">(ex:02-333-3333)</span>
                    </td>
                </tr>
                <tr>
                    <th><label for="mobile1">휴대폰번호</label>
                    </th>
                    <td>
                        <input type="text" id="mobile1" class="w55" name="mobile1" title="앞자리를 입력해주세요"   value="" maxlength="3" /> -
                        <input type="text" id="mobile2" class="w55" name="mobile2" title="중간자리를 입력해주세요" value="" maxlength="4" /> -
                        <input type="text" id="mobile3" class="w55" name="mobile3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
                        <span class="tx_gray tx_11">(ex:010-333-3333)</span>
                    </td>
                </tr>
                <tr>
                    <th><label for="emailT">이메일</label>
                    </th>
                    <td><input type="text" id="emailT" class="w80" name="emailT"
                        title="이메일 아이디를 입력해주세요" value="" maxlength="80" /> @
                        <input type="text" id="email_add" class="w120" name="email_add"
                        title="이메일 주소를 입력해주세요" value="" maxlength="19" />
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
                    <th>
                    	<label for="chrgJob">담당업무<br/>(250자이내)</label>
                    	<br/><b><span class="tx_blue_s"><div id="chrgJob_bytes"></div></span></b>
                    </th>
                    <td><textarea id="chrgJob" name="chrgJob" rows="8" class="w99_p" onkeydown="displayBytes(250,'chrgJob');">${dataVo.chrgJob}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td><input type="radio" name="useYn" id="useYn_Y" value="Y" <c:if test="${dataVo.useYn == 'Y'}"> checked="checked"</c:if> />
                        <label for="useYn_Y">사용</label>
                        <input type="radio" name="useYn" id="useYn_N" value="N" <c:if test="${dataVo.useYn == 'N'}"> checked="checked"</c:if>/>
                        <label for="useYn_N">미사용
                            <span class="tx_gray tx_11">(미사용선택시 시스템 접속(로그인)이 거부됩니다.)</span>
                        </label>
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!-- //추가정보 내용 -->

    <h2 class="mar_t20">지정권한 정보</h2>
    <!-- 지정권한정보 -->
    <fieldset>
        <legend>지정권한</legend>
        <table class="boardWrite" cellspacing="0" border="0"
            summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden">지정권한</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>지정권한</th>
                    <td>- <span class="tx_blue">관리자</span> :
                        <c:set var="cd" target="${dataList}" />
                        <c:choose>
                            <c:when test="${fn:length(dataList) != 0}">
                                <span id="assignListArea" style="color: red;">
                                    <c:forEach items="${dataList}" var="grp" varStatus="loop">
                                        <c:if test="${loop.first}">
                                            <c:set var="authCode" value="${grp.authCode}" />
                                        </c:if>
                                        <c:if test="${loop.index ne '0'}">, </c:if>
                                        ${grp.authNm}
                                    </c:forEach>
                                </span>
                                <span id="assignBtnArea">
	                                <a href="#" onclick="targetAssignListPop(this,'${dataVo.mngrId}', '${authCode}');"> <button class="gray_s">보기</button> </a>
	                                <a href="#"><button onclick="targetAssignPop(this,'${dataVo.mngrId}');" class="gray_s">지정권한 수정</button></a>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span id="assignListArea" style="color: red;">
                                    [지정된 권한이 없습니다.]
                                </span>
                                <span id="assignBtnArea">
                                   <a href="#"><button onclick="targetAssignPop(this,'${dataVo.mngrId}');" class="gray_s">지정권한 등록</button></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!-- //지정권한정보 -->

    <div style="height: 50px;">
        <div class="float_l mar_t20">
            <a href="#"><button onclick="jsWebLogView(this);" class="blue">접속이력보기</button></a>
            <a href="#"><button onclick="jsChangeLogView(this);" class="blue">변경이력보기</button></a>
        </div>
        <div class="float_r mar_t20">
            <a href="#"><button onclick="jsupdateAction();" class="blue">수정</button></a>
            <a href="#"><button onclick="jsDeleteAction();" class="blue" type="button">삭제</button></a>
        </div>
    </div>
    </form>
</body>
</html>