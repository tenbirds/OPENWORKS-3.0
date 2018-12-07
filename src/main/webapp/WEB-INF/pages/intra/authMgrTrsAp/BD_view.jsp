<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한 이양 신청</title>

    <script type="text/javascript">
    $().ready(function() {

    });

    //권한별 상세페이지
    var assignment = function(el, authCd){
        $(el).colorbox({
               title : "지정 권한 메뉴",
               href  : "PD_assignment.do?authCd="+authCd,
               width : "640",
               height: "550",
               iframe: true
              });
    };

    var directorSerch = function (el) {
        $(el).colorbox({
               title : "담당자 목록",
               href  : "PD_directorSerch.do",
               width : "600",
               height: "550",
               iframe: true
              });
    };
    //리스트로 이동
    var jsList = function(){
        self.location.href = "BD_index.do";
    };

       //수정
    var jsUpdateAction = function() {

        var authCds = '';
        var menuCds = '';
        var assignTypeCds = '';
        var authTypeCds = '';

        if($('#reqConts').val() == '' || $('#reqConts').val() == null){
            $("#reqConts").append('<label for="reqConts"> 신청사유를 작성해 주세요.</label>');
            return;
        }else{
        	if($('#reqConts').val().length > 105){
        		alert("신청사유는 100자 내외로 작성 가능합니다.");
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
            jsWarningBox("이양할 권한을 체크해주세요");
            return;
        }
        if ( confirm("수정하시겠습니까?") ) {
            $.ajax({
                url		: "ND_updateAction.do",
                type    : "POST",
                data    : {authCds 			: $('#authCds').val(),
                            menuCds 			: $('#menuCds').val().substring(1),
                           assignTypeCds 	: $('#assignTypeCds').val().substring(1),
                           authTypeCds	 	: $('#authTypeCds').val().substring(1),
                           reqConts 		: $('#reqConts').val(),
                           targetMgrId 		: $('#targetMgrId').val(),
                           seqNo			: $('#seqNo').val()
                },
                async    : false,
                success  : function (response) {
                    if ( jsSuccessBox(response) ) {
                        jsList();
                    }
                },
                error :  function(response) {
                    jsSysErrorBox(response.responseText);
                    return;
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
        $('label[for="reqConts"]').remove();
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

<!-- 컨텐츠영역 -->
    <!-- 권한 이양 신청 -->
    <h4>내 정보</h4>
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

    <h4 class="clear">권한이양 정보</h4>
    <div class="float_l mar_b30" style="width:100%;">
        <table class="boardList">
            <colgroup>
                <col width="35%" />
<%--                 <col width="30%" /> --%>
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;" class="lr_none">권한 그룹명</th>
                </tr>
                <c:forEach items="${dataList}" var="_bean">
                    <tr>
                        <td>
                            <input type="checkbox" name="authCds" value="${_bean.authCd }"
                                <c:forEach items="${sendDataList}" var="_beanSendData">
                                    <c:if test="${_bean.authCd eq _beanSendData.authCd}">
                                        checked="checked"
                                    </c:if>
                                </c:forEach>
                            class="checkbox" <c:if test="${!empty resTypeCd}">disabled="disabled"</c:if>/>
                        </td>
<!--                         <td> -->
<%--                             <c:if test="${_bean.authTypeCd eq 'G'}">그룹권한</c:if> --%>
<%--                             <c:if test="${_bean.authTypeCd eq 'P'}">개별권한</c:if> --%>
<!--                         </td> -->
                        <td class="lr_none">
                            <input type="hidden" name="authTypeCd" value="${_bean.authTypeCd}" />
                            ${_bean.authNm}&nbsp;&nbsp;
                            <a href="#" class="btn" onclick="assignment(this, '${_bean.authCd }');">
                                <button type="button" class="s_blue">메뉴</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h4 class="clear">권한이양 대상자 정보
    	<c:if test="${empty resTypeCd}">&nbsp;&nbsp;<a href="#" class="btn"><button type="button" class="s_blue" onclick="directorSerch(this)">담당자 검색</button></a></c:if>
    </h4>
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
                    <td><input type="hidden" id="targetDeptNm" value="" /><label for="targetDeptNm">${dataVo.targetDeptNm}</label></td>
                    <th>직책</th>
                    <td><input type="hidden" id="targetGradeNm" value="" /><label for="targetGradeNm">${dataVo.targetGradeNm}</label></td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td><input type="hidden" id="targetMgrId" name="targetMgrId" value="${dataVo.targetMgrId}" /><label for="targetMgrId">${dataVo.targetMgrId}</label></td>
                    <th>성명</th>
                    <td><input type="hidden" id="targetMgrNm" value="" /><label for="targetMgrNm">${dataVo.targetMgrNm}</label></td>
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
                    <th>
                    	<label for="con">사유<c:if test="${empty resTypeCd}"> (100자 내외)</c:if></label>
                    </th>
                    <td><textarea id="reqConts" rows="2" class="w99_p" onclick="labelRemove();" <c:if test="${not empty resTypeCd}">readonly="readonly"</c:if>>${dataVo.reqConts}</textarea></td>
                    <%-- <td><textarea id="con" name=""  rows="4" class="w99_p">${dataVo.reqConts }</textarea></td> --%>
                </tr>
            </tbody>
        </table>
        </fieldset>
        <div class="tx_r mar_t10">
            <c:if test="${empty resTypeCd}">
                <a href="#" class="btn" onclick="jsUpdateAction();"><button type="button" class="blue">수정</button></a>
            </c:if>
            <a href="#" class="btn" onclick="jsList();"><button type="button" class="blue">목록</button></a>
        </div>
    </div>
    <!-- //권한 이양 신청 -->
<!-- //컨텐츠영역 -->
</form>
</body>
</html>