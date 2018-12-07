<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
	<title>나의 정보변경</title>
	<op:jsTag type="spi" items="form,validate" />
	<op:jsTag type="openworks" />

	<script type="text/javascript">
	    $().ready(function() {
	        if ($("#telno").val()) {	
	            var t_data = $("#telno").val();
	            var tel_data = t_data.split("-");
	            document.getElementById("telno1").value = tel_data[0];
	            document.getElementById("telno2").value = tel_data[1];
	            document.getElementById("telno3").value = tel_data[2];
	        }

	        if ($("#fxnum").val()) {	
	            var f_data = $("#fxnum").val();
	            var fax_data = f_data.split("-");
	            document.getElementById("fxnum1").value = fax_data[0];
	            document.getElementById("fxnum2").value = fax_data[1];
	            document.getElementById("fxnum3").value = fax_data[2];
	        }

	        if ($("#mbtlnum").val()) {	
	            var m_data = $("#mbtlnum").val();
	            var mbtlnum_data = m_data.split("-");
	            document.getElementById("mbtlnum1").value = mbtlnum_data[0];
	            document.getElementById("mbtlnum2").value = mbtlnum_data[1];
	            document.getElementById("mbtlnum3").value = mbtlnum_data[2];
	        }
	    });

	    var jsupdateAction = function() {
	        $("#dataForm").validate({
	            rules : {
	                telno1 : {
	                    number : true,
	                    minlength : 2,
	                    maxlength : 3
	                },
	                telno2 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 4
	                },
	                telno3 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 4
	                },
	                fxnum1 : {
	                    number : true,
	                    minlength : 2,
	                    maxlength : 3
	                },
	                fxnum2 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 4
	                },
	                fxnum3 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 4
	                },
	                mbtlnum1 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 3
	                },
	                mbtlnum2 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 4
	                },
	                mbtlnum3 : {
	                    number : true,
	                    minlength : 3,
	                    maxlength : 4
	                },
	                gradeCd : {
	                    required : true
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
	                                self.location.reload();
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
	
	        if(frm.telno1.value != "" && frm.telno2.value != "" && frm.telno3.value != "") {
	            frm.telno.value = frm.telno1.value + "-" + frm.telno2.value + "-" + frm.telno3.value;
	        }else if(frm.telno1.value == "" || frm.telno2.value == "" || frm.telno3.value == ""){
	            frm.telno.value = "";
	        }
	
	        if(frm.fxnum1.value != "" && frm.fxnum2.value != "" && frm.fxnum3.value != "") {
	            frm.fxnum.value = frm.fxnum1.value + "-" + frm.fxnum2.value + "-" + frm.fxnum3.value;
	        }else if(frm.fxnum1.value == "" || frm.fxnum2.value == "" || frm.fxnum3.value == ""){
	            frm.fxnum.value = "";
	        }
	
	        if(frm.mbtlnum1.value != "" && frm.mbtlnum2.value != "" && frm.mbtlnum3.value != "") {
	            frm.mbtlnum.value = frm.mbtlnum1.value + "-" + frm.mbtlnum2.value + "-" + frm.mbtlnum3.value;
	        }else if(frm.mbtlnum1.value == "" || frm.mbtlnum2.value == "" || frm.mbtlnum3.value == "") {
	            frm.mbtlnum.value = "";
	        }
	    }
	
	    var passwordUpdete = function(el, vl) {
	        $(el).colorbox({
	            title  : vl+"님 비밀번호 변경하기",
	            href   : "PD_changeMyPwd.do?mngrId=" + vl,
	            width  : "950",
	            height : "750",
	            iframe : true
	        });
	    };
	
	    var targetAssignListPop = function(el, vl, authCode) {
	        $(el).colorbox({
	            title  : "지정 권한 목록",
	            href   : "/intra/mgr/PD_targetAssign.do?mngrId=" + vl + "&authCode=" + authCode,
	            width  : "530",
	            height : "550",
	            iframe : true
	        });
	    };
	</script>
</head>

<body>    
    <form id="dataForm" name="dataForm">
    <input type="hidden" id="telno" name="telno" value="${dataVo.telno}" />
    <input type="hidden" id="fxnum" name="fxnum" value="${dataVo.fxnum}"/>
    <input type="hidden" id="mbtlnum" name="s" value="${dataVo.mbtlnum}"/>

	<!-- 컨텐츠영역 -->
    <div id="contents">
	    <div style="width: 100%;">
	        <h2 class="float_l">▷ 기본정보</h2>
	    </div>
	    <div class="clear"></div>
	
	    <!-- 나의정보 변경하기 -->
	    <fieldset>
	        <legend>기본정보 변경하기</legend>
	
	        <table class="boardWrite" cellspacing="0" border="0" summary="정보를 수정하실 수 있습니다.">
	            <caption class="hidden">기본정보 변경하기</caption>
	
	            <colgroup>
	                <col width="15%" />
	                <col width="85%" />
	            </colgroup>
	            <tbody>
	                <tr>
	                    <th><label for="mngrId">아이디</label></th>
	                    <td>
	                        <c:if test="${not empty dataVo.mngrId}">
	                            <span class="tx_b tx_blue">${dataVo.mngrId}</span>
	                            <input type="hidden" name="mngrId" id="mngrId" value="${dataVo.mngrId}" />
	                        </c:if>
	                    </td>
	                </tr>
	                <tr>
	                    <th><label for="mngrNm">이름</label></th>
	                    <td>
	                        <input type="text" name="mngrNm" id="mngrNm" value="${dataVo.mngrNm}" />
	                        <span class="tx_gray tx_11">(최대 20자)</span><span class="tx_blue"> ※ 이름을 변경 할 경우 재로그인 후 상단 이름표시부분에 반영됩니다.</span>
	                    </td>
	                </tr>
	                <tr>
	                    <th><label for="gradeCd">직위</label></th>
	                    <td><op:code id="ofcpsCd" grpCd="9" defaultValues="${dataVo.ofcpsCd}" defaultLabel="--직위선택--" /></td>
	                </tr>
	                <tr>
	                    <th><label for="deptNm">부서명</label></th>
	                    <td>${dataVo.deptNm}</td>
	                </tr>
	                <tr>
	                    <th><label for="mgrPwd">비밀번호</label></th>
	                    <td>
	                    <a href="#"><button onclick="passwordUpdete(this,'${dataVo.mngrId}');" class="gray_s">비밀번호변경</button></a>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	    </fieldset>
	    <!-- //기본정보 내용 -->
	
	    <!-- 	<br class="blank"/> -->
	
	    <h2 class="mar_t20">▷ 추가정보</h2>
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
	                    <th><label for="telno1">전화번호</label></th>
	                    <td><input type="text" id="telno1" class="w55" name="telno1" title="국번을 입력해주세요"   value="" maxlength="3" /> -
	                        <input type="text" id="telno2" class="w55" name="telno2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
	                        <input type="text" id="telno3" class="w55" name="telno3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
	                    </td>
	                </tr>
	                <tr>
	                    <th><label for="fxnum1">팩스번호</label></th>
	                    <td><input type="text" id="fxnum1" class="w55" name="fxnum1" title="국번을 입력해주세요"   value="" maxlength="3" /> -
	                        <input type="text" id="fxnum2" class="w55" name="fxnum2" title="앞자리를 입력해주세요" value="" maxlength="4" /> -
	                        <input type="text" id="fxnum3" class="w55" name="fxnum3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
	                        <span class="tx_gray tx_11">(ex:02-333-3333)</span>
	                    </td>
	                </tr>
	                <tr>
	                    <th><label for="mbtlnum1">휴대폰번호</label>
	                    </th>
	                    <td>
	                        <input type="text" id="mbtlnum1" class="w55" name="mbtlnum1" title="앞자리를 입력해주세요"   value="" maxlength="3" /> -
	                        <input type="text" id="mbtlnum2" class="w55" name="mbtlnum2" title="중간자리를 입력해주세요" value="" maxlength="4" /> -
	                        <input type="text" id="mbtlnum3" class="w55" name="mbtlnum3" title="뒷자리를 입력해주세요" value="" maxlength="4" />
	                        <span class="tx_gray tx_11">(ex:010-333-3333)</span>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	    </fieldset>
	    <!-- //추가정보 내용 -->
	
	    <h2 class="mar_t20">▷ 지정권한 정보</h2>
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
	                                </span>
	                            </c:when>
	                            <c:otherwise>
	                                <span id="assignListArea" style="color: red;">
	                                    [지정된 권한이 없습니다.]
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
	        <div class="float_r mar_t20">
	            <a href="#"><button onclick="jsupdateAction();" class="blue">수정</button></a>            
	        </div>
	    </div>
	</div>
	<!-- //컨텐츠영역 -->
	</form>
</body>
</html>