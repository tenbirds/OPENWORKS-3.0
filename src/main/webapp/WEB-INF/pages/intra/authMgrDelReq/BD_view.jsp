<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한삭제요청관리</title>
    <op:jsTag type="openworks" items="ui" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/openworks_all.css" />

    <script type="text/javascript">
    var jsIndex = function(){
        self.location.href = "BD_index.do";
    };
    $().ready(function () {
        $('table.boardList > tbody > tr > td > span').each(function () {
            $(this).text(jsMakeAuthTypeStr($(this).text()));
        });

    });
     var jsMakeAuthTypeStr = function (assignTypeCd) {

            var returnVal = '';
            if (assignTypeCd.indexOf('R') > -1) {
                returnVal += '조회 ';
            }
            if (assignTypeCd.indexOf('A') > -1) {
                returnVal += '기본 ';
            }
            if (assignTypeCd.indexOf('G') > -1) {
                returnVal += '총괄 ';
            }

            return returnVal + '권한';
        };
        var jsApprove = function(){
            var authCds = '';
            var menuCds = '';
          //체크된 값을 가져온다.
            $("tbody input.checkbox:checked").each(function(i) {
                authCds += ','+ $(this).val();
            });
            $("tbody input.checkbox2:checked").each(function(i) {
                menuCds += ','+ $(this).val();
            });

            $.ajax({
                url      : "ND_DeleteAction.do",
                type     : "POST",
                data     : {
                    seqNo         : '${dataVo.seqNo }',
                    authCds       : authCds.substring(1),
                    menuCds       : menuCds.substring(1),
                    mgrId         : '${dataVo.mgrId}',
                    resConts      : $('#resConts').val()
                },
                async    : false,
                success  : function (response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.processOk);
                            jsIndex();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }
            });
        };

        var jsViewPop = function (el, vl) {

            $(el).colorbox({
                   title : "지정 권한 메뉴",
                   href  : "PD_assignment.do?authCd="+vl ,
                   width : "600",
                   height: "550",
                   iframe: true
                  });
        };

        var jsRetrocession = function() {
            if ( $("#resConts").val() == '' ) {
                jsWarningBox("반려사유를 적어주세요");
                $("#resConts").focus();
                return;
             }
               if ( confirm("반려하시겠습니까?") ) {
                $.post("ND_retrocession.do", {
                    seqNo : '${dataVo.seqNo }',
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

           var jsList = function(){
               self.location.href = "BD_index.do";
           };
    </script>
</head>

<body>
    <div class="buser">
        <!-- 권한삭제요청관리 -->
        <h4>권한삭제  신청자정보</h4>
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

        <h4>삭제요청권한</h4>
        <div class="mar_b30">
            <table class="boardList" id="boardList" cellspacing="0" border="0">
                <colgroup>
                    <col width="20%" />
                    <col width="35%" />
                    <col width="" />
                </colgroup>
                <tbody id="odd-color">
                    <tr>
                        <th colspan="3" style="text-align:center;font-weight:bold;" class="lr_none">관리자 권한</th>
                    </tr>
                <c:forEach items="${dataList}" var="_bean" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="authCd" id="authCds${staus.count }" value="${_bean.authCd}" disabled="disabled" <c:if test="${_bean.checkYn eq 'Y'}">checked="checked" disabled="disabled"</c:if> class="checkbox" /></td>
                        <td>권한그룹</td>
                        <td class="lr_none">${_bean.authNm }<a href="#" title="권한상세목록" onclick="jsViewPop(this,'${_bean.authCd }');"><span id="tbListView_${status.count }" class="tx_blue_l">  [메뉴]</span></a></td>
                    </tr>
                </c:forEach>
                <c:forEach items="${baseVo}" var="_bean" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="menuCd" id="menuCds${staus.count }" value="${_bean.menuCd}" disabled="disabled" <c:if test="${_bean.checkYn eq 'Y'}">checked="checked"</c:if> class="checkbox2"/></td>
                        <td>개별권한</td>
                        <td class="lr_none">${_bean.menuNm}  [<span assignTypeCd="${_bean.assignTypeCd }">${_bean.assignTypeCd }</span>]</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <h4>권한삭제 요청사유</h4>
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
                        <th><label for="reqconts">사유 (100자 내외)</label></th>
                        <td>${dataVo.reqConts}</td>
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
                        <c:if test="${not empty dataVo.resTypeCd }">
                        ${dataVo.resConts }
                        </c:if>
                        <c:if test="${empty dataVo.resTypeCd }">
                        <textarea  name="resConts" id="resConts" rows="4" class="w99_p"></textarea>
                        </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
            </fieldset>
        </div>

        <div class="tx_r mar_t10">
            <c:if test="${empty dataVo.resTypeCd }">
                <button type="button" onclick="jsApprove();" class="blue">승인</button>
                <button type="button" onclick="jsRetrocession();" class="blue">반려</button>
            </c:if>
                <button type="button" onclick="jsIndex();" class="blue">목록</button>
            </div>
        <!-- //권한삭제요청관리 -->
    </div>
</body>
</html>