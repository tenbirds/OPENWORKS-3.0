<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한추가요청관리</title>
    <op:jsTag type="openworks" items="ui" />
    <script type="text/javascript">
    $().ready(function() {

    });


    var jsViewPop = function (el, vl) {

        $(el).colorbox({
               title : "지정 권한 메뉴",
               href  : "<c:url value='/intra/authComm/PD_authMenuList.do'/>?authCd="+vl ,
               width : "600",
               height: "550",
               iframe: true
              });
    };
    var jsViewPop2 = function (el, vl) {

        $(el).colorbox({
               title : "지정 권한 메뉴",
               href  : "PD_assignment.do?seqNo="+vl ,
               width : "600",
               height: "550",
               iframe: true
              });
    };
    //리스트로 이동
    var jsList = function(){
        self.location.href = "BD_index.do";
    };
    //반려
    var jsRetrocession = function( seqNo ) {
        if ( $("#resConts").val() == '' ) {
            jsWarningBox("반려사유를 적어주세요.");
            $("#resConts").focus();
            return;
         }
           if ( confirm("반려하시겠습니까?") ) {
            $.post("ND_retrocession.do", {
                seqNo : seqNo,
                resConts : $("#resConts").val()

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
    var jsApprove = function( seqNo,mgrId ) {
           var authCds = '';
           var menuCds = '';
           var assignTypeCds = '';
           <c:forEach items="${viewObject}" var="_bean" varStatus="status">
            authCds += ',' + '${_bean.authCd }';
           </c:forEach>
           <c:forEach items="${pager}" var="_bean" varStatus="status">
            menuCds += ',' + '${_bean.menuCd }';
            assignTypeCds += ',' + '${_bean.assignTypeCd }';

           </c:forEach>

           if ( confirm("승인하시겠습니까?") ) {
            $.post("ND_approveAction.do", {
                seqNo : seqNo,
                mgrId : mgrId,
                authCds : authCds.substring(1),
                menuCds : menuCds.substring(1),
                assignTypeCds : assignTypeCds.substring(1)

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
    </script>
</head>
<body>
    <form name="dataForm" id="dataForm" method="post" >
        <input type="hidden" name="seqNo" id="seqNo" value="${dataVo.seqNo}"/>
    </form>

    <!-- 권한추가요청관리 -->
    <h4>권한추가 요청 신청자정보</h4>
    <div class="mar_b30">
        <table class="boardWrite" cellspacing="0" border="0">
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

    <h4>현재지정 권한정보</h4>
    <div class="float_l mar_b30" style="width:100%;">
        <table class="boardList" cellspacing="0" border="0">
            <colgroup>
                <col width="35%" />
                <col width="" />
            </colgroup>
            <tbody id="odd-color">
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;" class="lr_none">관리자 권한</th>
                </tr>
                <c:forEach items="${dataList}" var="_bean" varStatus="status">
                <tr>
                    <c:if test="${_bean.authTypeCd eq 'G'}"><td>권한그룹</td></c:if>
                    <c:if test="${_bean.authTypeCd eq 'P'}"><td class="tx_red">개별권한</td></c:if>
                    <td class="lr_none">${_bean.authNm} &nbsp;&nbsp;<button class="s_blue" onclick="jsViewPop(this, '${_bean.authCd}');">메뉴</button></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h4 class="clear">추가요청 권한 정보</h4>
    <div class="float_l mar_b30" style="width:100%;">
        <table class="boardList" cellspacing="0" border="0">
            <colgroup>
                <col width="35%" />
                <col width="" />
            </colgroup>
            <tbody id="odd-color">
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;" class="lr_none">관리자 권한</th>
                </tr>
                <c:forEach items="${baseVo}" var="_bean" varStatus="status">
                <tr>
                    <c:if test="${_bean.authTypeCd eq 'G'}"><td>권한그룹</td></c:if>
                    <c:if test="${_bean.authTypeCd eq 'P'}"><td class="tx_red rl">개별권한</td></c:if>
                    <c:if test="${_bean.authTypeCd eq 'G'}"><td class="lr_none">${_bean.authNm} &nbsp;&nbsp;<button class="s_blue" onclick="jsViewPop(this, '${_bean.authCd}');">메뉴</button></td></c:if>
                    <c:if test="${_bean.authTypeCd eq 'P'}"><td class="lr_none">추가요청한 개별권한 &nbsp;&nbsp;<button class="s_blue" onclick="jsViewPop2(this, '${dataVo.seqNo}');">메뉴</button></td></c:if>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h4 class="clear">신청 사유</h4>
    <div class="mar_b30">
        <fieldset>
        <legend>글입력</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 글입력하기 </caption>
            <colgroup>
                <col width="15%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="con">사유 (100자 내외)</label></th>
                    <td>${dataVo.reqConts }</td>
                </tr>
            </tbody>
        </table>
        </fieldset>
    </div>

    <h4>반려 사유 <span class="tx_red_s">*</span></h4>
    <div class="mar_b30">
        <fieldset>
        <legend>글입력</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 글입력하기 </caption>
            <colgroup>
                <col width="15%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="con">사유 (100자 내외)</label></th>
                    <td>
                        <c:if test="${not empty dataVo.resTypeCd}">
                           ${dataVo.resConts }
                        </c:if>
                        <c:if test="${empty dataVo.resTypeCd}">
                           <textarea  name="resConts" id="resConts" rows="4" class="w99_p"></textarea>
                        </c:if>
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>
    </div>
    <div class="tx_r">
        <c:if test="${empty dataVo.resTypeCd }">
            <a href="#" class="btn" onclick="jsApprove('${dataVo.seqNo}','${dataVo.mgrId}');"><button class="blue">승인</button></a>
            <a href="#" class="btn" onclick="jsRetrocession('${dataVo.seqNo}');"><button class="blue">반려</button></a>
        </c:if>
        <a href="#" class="btn" onclick="jsList();"><button class="blue">목록</button></a>
    </div>
    <!-- //권한추가요청관리 -->
    <!-- //컨텐츠영역 -->
</body>
</html>