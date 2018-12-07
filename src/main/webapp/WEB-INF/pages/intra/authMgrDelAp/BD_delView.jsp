<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한 삭제 요청(신청자)</title>
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/openworks_all.css" />

    <script type="text/javascript">
    $().ready(function () {
        $('table.boardList > tbody > tr > td > span').each(function () {
            $(this).text(jsMakeAuthTypeStr($(this).text()));
        });
    });
    var jsMakeAuthTypeStr = function (assignTypeCd) {

        var returnVal = '';
        if(assignTypeCd.indexOf('R') > -1) {
            returnVal += '조회 ';
        }
        if(assignTypeCd.indexOf('A') > -1) {
            returnVal += '기본 ';
        }
        if(assignTypeCd.indexOf('G') > -1) {
            returnVal += '총괄 ';
        }

        return returnVal + '권한';
    };

    var jsIndex = function() {
        self.location.href = "BD_index.do";
    };

    var jsInsert = function() {
        var authCds = '';
        var menuCds = '';
        var assignTypeCds = '';
        if($('#reqConts').val() == '' || $('#reqConts').val() == null) {
            jsWarningBox("삭제사유를 작성해주세요");
            $('#reqConts').focus();
            return;
        }
        //체크된 값을 가져온다.
        $("tbody input.checkbox:checked").each(function(i) {
            authCds += ','+ $(this).val();
        });
        $("tbody input.checkbox2:checked").each(function(i) {
            menuCds += ','+ $(this).val();
        });
        $("tbody input.checkbox2:checked").each(function(i) {
            assignTypeCds += ','+ $(this).parent().parent().find('.lr_none').find('span').attr('assignTypeCd');
        });

        if(authCds == '' && menuCds == '') {
            jsWarningBox("삭제할 권한을 체크해주세요");
            return;
        }
         $.ajax({
            url      : "ND_InsertAction.do",
            type     : "POST",
            data     : {authCds       : authCds.substring(1),
                        menuCds       : menuCds.substring(1),
                        assignTypeCds : assignTypeCds.substring(1),
                        reqConts      : $('#reqConts').val()
            },
            async    : false,
            success  : function (response) {
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.insertOk);
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

    var jsViewPop = function(el, vl) {
        $(el).colorbox({
            title : "지정 권한 메뉴",
            href  : "PD_assignment.do?authCd=" + vl,
            width : "600",
            height: "550",
            iframe: true
        });
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
                    <col width="5%" />
                    <col width="30%" />
                    <col width="" />
                </colgroup>
                <tbody>
                    <tr>
                        <th colspan="3" style="text-align:center;font-weight:bold;" class="lr_none">관리자 권한</th>
                    </tr>
                <c:forEach items="${dataList}" var="_bean" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="authCd" id="authCds${staus.count }" value="${_bean.authCd }" class="checkbox"/></td>
                        <td>권한그룹</td>
                        <td class="lr_none">${_bean.authNm }<a href="#" title="권한상세목록" onclick="jsViewPop(this,'${_bean.authCd }'); return false;"><span id="tbListView_${status.count }" class="tx_blue_l">[보기]</span></a></td>
                    </tr>
                </c:forEach>
                <c:forEach items="${baseVo}" var="_bean" varStatus="status">
                    <tr class="bg_yellow">
                        <td><input type="checkbox" name="menuCd" id="menuCds${staus.count }" value="${_bean.menuCd }" class="checkbox2"/></td>
                        <td>개별권한</td>
                        <td class="lr_none">${_bean.menuNm}[<span assignTypeCd="${_bean.assignTypeCd }">${_bean.assignTypeCd }</span>]</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <h4 class="clear">권한삭제 요청사유</h4>
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
                        <td><textarea id="reqConts" name="reqConts"  rows="4" class="w99_p"></textarea></td>
                    </tr>
                </tbody>
            </table>
            </fieldset>
            <div class="tx_r mar_t10">
                <a href="#" onclick="jsInsert();" class="btn"><button class="blue">신청</button></a>
                <a href="#" onclick="jsIndex();" class="btn"><button class="blue">목록</button></a>
            </div>
        </div>
        <!-- //권한삭제요청관리 -->
    </div>
</body>
</html>