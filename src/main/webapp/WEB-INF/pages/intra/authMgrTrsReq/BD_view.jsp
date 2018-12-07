<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한 이양 관리</title>

    <script type="text/javascript">
    $().ready(function() {
        $("#checkOk").hide();
    });

    //권한별 상세페이지
    var assignment = function(el, authCd, authNm){
        $(el).colorbox({
               title : "지정 권한 메뉴",
               href  : "PD_assignment.do?authCd="+authCd+ "&authNm="+authNm,
               width : "640",
               height: "550",
               iframe: true
              });
    };

    var targetAuthPop = function (el, vl) {

        $(el).colorbox({
               title : "지정 권한 목록",
               href  : "PD_targetAssignMenu.do?targetMgrId="+vl ,
               width : "620",
               height: "550",
               iframe: true
              });
    };

    //리스트로 이동
    var jsList = function(){
        self.location.href = "BD_index.do";
    };

    var updateCheck = function(){
        $("#oneShotOk").hide();
        $("#checkOk").show();
    };

    //반려
    var jsRetrocedeAction = function( seqNo, resTypeCd ) {
        if ( $("#resConts").val() == '' || $('#resConts').val() == null ) {
            $("#resConts").append('<label for="resConts"> 반려사유를 작성해 주세요.</label>');
            return;
         }else{
        	if($('#resConts').val().length > 105){
        		alert("반려사유는 100자 내외로 작성 가능합니다.");
        		return;
        	}
        }
        if ( confirm("반려하시겠습니까?") ) {
            $.post("ND_retrocedeAction.do", {
                seqNo 	  : seqNo,
                resConts  : $("#resConts").val(),
                resTypeCd : resTypeCd

                }, function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.processOk);
                            jsList();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }
            );
        }
    };

       //승인
    var jsApprove = function( seqNo, resTypeCd ) {

        var authCds = '';
        var menuCds = '';
        var assignTypeCds = '';
        var authTypeCds = '';

        if($('#resConts').val() == '' || $('#resConts').val() == null){
            $("#resConts").append('<label for="resConts"> 수정승인 사유를 작성해 주세요.</label>');
            return;
        }else{
        	if($('#resConts').val().length > 105){
        		alert("수정승인 사유는 100자 내외로 작성 가능합니다.");
        		return;
        	}
        }

        var selectedAuthCds = jsCheckedArray1();
        authCds = $.makeArray(selectedAuthCds);
        var selectedAuthTypeCds = jsCheckedArray2();
        authTypeCds = $.makeArray(selectedAuthTypeCds);
        for ( var i = 0; i < authTypeCds.length; i++) {
            if(authTypeCds[i] == 'P'){
                <c:forEach items="${prvDataList}" var="_bean" varStatus="status">
                      menuCds += ',' + '${_bean.menuCd }';
                      assignTypeCds += ',' + '${_bean.assignTypeCd }';
                  </c:forEach>
            }
        }

        $('#authCds').val(authCds);
        $('#menuCds').val(menuCds);
        $('#assignTypeCds').val(assignTypeCds);
        $('#authTypeCds').val(authTypeCds);

        if(authCds == '' && menuCds == ''){
            alert("이양할 권한을 체크해주세요");
            return;
        }

           if ( confirm("승인하시겠습니까?") ) {
               $.ajax({
                url		: "ND_approveAction.do",
                type    : "POST",
                data    : {authCds 			: $('#authCds').val(),
                            menuCds 			: $('#menuCds').val().substring(1),
                           assignTypeCds 	: $('#assignTypeCds').val().substring(1),
                           authTypeCds	 	: $('#authTypeCds').val(),
                           resConts 		: $('#resConts').val(),
                           targetMgrId 		: $('#targetMgrId').val(),
                           mgrId 			: $('#mgrId').val(),
                           seqNo			: seqNo,
                           resTypeCd		: resTypeCd
                },
                async    : false,
                success  : function (response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.insertOk);
                            jsList();
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

  //체크된 글 목록을 가져온다.
    var jsCheckedArray1 = function() {
        var selectedAuthCds = new Array();
        $("tbody input.checkbox:checked").each(function (i) {
             selectedAuthCds[i] = $(this).val();
        });
        return selectedAuthCds;
    };
    var jsCheckedArray2 = function() {
        var selectedAuthTypeCds = new Array();
        $("tbody input.checkbox:checked").each(function (i) {
            selectedAuthTypeCds[i] = $(this).parent().parent().find('input[name=authTypeCd]').val();
        });
        return selectedAuthTypeCds;
    };

    var labelRemove = function(){
        $('label[for="resConts"]').remove();
    };

    </script>
</head>
<body>
<form name="dataForm" method="post" >
    <input type="hidden" name="seqNo" id="seqNo" value="${dataVo.seqNo }"/>
    <input type="hidden" name="authCds" id="authCds" value=""/>
    <input type="hidden" name="menuCds" id="menuCds" value=""/>
    <input type="hidden" name="assignTypeCds" id="assignTypeCds" value=""/>
    <input type="hidden" name="authTypeCds" id="authTypeCds" value=""/>
    <input type="hidden" name="targetMgrId" id="targetMgrId" value="${dataVo.targetMgrId}"/>
    <input type="hidden" name="mgrId" id="mgrId" value="${dataVo.mgrId}"/>
</form>

        <!-- 권한 이양 관리 -->
        <h4>권한이양 신청자 정보</h4>
        <div class="mar_b30">
            <table class="boardWrite">
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>부서명</th>
                        <td>${dataVo.deptNm}</td>
                        <th>직책</th>
                        <td>${dataVo.gradeNm}</td>
                    </tr>
                    <tr>
                        <th>아이디</th>
                        <td>${dataVo.mgrId}</td>
                        <th>성명</th>
                        <td>${dataVo.mgrNm}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <h4>권한이양 정보</h4>
        <div class="float_l mar_b30" style="width:100%;">
            <table class="boardList">
                <colgroup>
                    <col width="35%" />
<%--                     <col width="30%" /> --%>
                    <col width="" />
                </colgroup>
                <tbody>
                    <tr>
                        <th colspan="2" style="text-align:center;font-weight:bold;" class="lr_none">권한 그룹명</th>
                    </tr>
                    <c:forEach items="${sendDataList}" var="_bean">
                    <tr>
                        <td>
                            <input type="checkbox" name="authCds" value="${_bean.authCd }" onclick="updateCheck();" checked="checked" class="checkbox"
                            	<c:if test="${!empty resTypeCd}">disabled="disabled"</c:if>/>
                        </td>
<!--                         <td> -->
<%--                             <c:if test="${_bean.authTypeCd eq 'G'}">그룹권한</c:if> --%>
<%--                             <c:if test="${_bean.authTypeCd eq 'P'}">개별권한</c:if> --%>
<!--                         </td> -->
                        <td class="lr_none">
                            <input type="hidden" name="authTypeCd" value="${_bean.authTypeCd}" />
                            ${_bean.authNm}&nbsp;&nbsp;
                            <a href="#" class="btn" onclick="assignment(this, '${_bean.authCd }', '${_bean.authNm }');">
                                <button type="button" class="s_blue">메뉴</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <h4 class="clear">권한이양 대상자 정보</h4>
        <div class="mar_b30">
            <table class="boardWrite">
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>부서명</th>
                        <td>${dataVo.targetDeptNm}</td>
                        <th>직책</th>
                        <td>${dataVo.targetGradeNm}</td>
                    </tr>
                    <tr>
                        <th>아이디</th>
                        <td>${dataVo.targetMgrId}</td>
                        <th>성명</th>
                        <td>${dataVo.targetMgrNm}&nbsp;&nbsp;
                            <a href="#" class="btn">
                                <button class="s_blue" onclick="targetAuthPop(this, '${dataVo.targetMgrId}')">현재지정 권한 보기</button>
                            </a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <h4 class="clear">권한이양 신청 사유</h4>
        <div class="mar_b30">
            <fieldset>
            <legend>글입력</legend>
            <table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 글입력하기 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="con">사유</label></th>
                        <td>${dataVo.reqConts }</td>
                        <%-- <td><textarea id="con" name=""  rows="4" class="w99_p">${dataVo.reqConts }</textarea></td> --%>
                    </tr>
                </tbody>
            </table>
            </fieldset>
        </div>
        <h4>수정승인 및 반려 사유 <span class="tx_red_s">*</span></h4>
        <div class="mar_b30">
            <fieldset>
            <legend>글입력</legend>
            <table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 글입력하기 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="con">사유<c:if test="${empty resTypeCd}"> (100자 내외)</c:if></label></th>
                        <td><textarea id="resConts" rows="4" class="w99_p" onclick="labelRemove();" <c:if test="${not empty resTypeCd}">readonly="readonly"</c:if>>${dataVo.resConts }</textarea></td>
                    </tr>
                </tbody>
            </table>
            </fieldset>
            <div class="tx_r mar_t10">
	            <c:if test="${empty resTypeCd}">
	                <a href="#" class="btn" id="oneShotOk" onclick="jsApprove('${dataVo.seqNo }', 'P');"><button class="blue">승인</button></a>
	                <a href="#" class="btn" id="checkOk" onclick="jsApprove('${dataVo.seqNo }', 'T');"><button class="blue">수정승인</button></a>
	                <a href="#" class="btn" onclick="jsRetrocedeAction('${dataVo.seqNo }', 'C');"><button class="blue">반려</button></a>
	            </c:if>
	            <a href="#" class="btn" onclick="jsList();"><button class="blue">목록</button></a>
            </div>
        </div>
        <!-- //권한 이양 관리 -->
<!-- //컨텐츠영역 -->
</body>
</html>