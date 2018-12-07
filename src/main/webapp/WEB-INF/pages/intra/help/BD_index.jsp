<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>도움말 관리</title>
    <op:jsTag type="spi" items="form,validate" />
    <script type="text/javascript">
        var jsViewDetail = function (vl) {
            var $detailEl = $('#_help' + vl);
            if ($detailEl.is(':visible')) {
                $detailEl.find('#_helpDiv' + vl).slideUp(250, function () {$detailEl.hide();});
                $detailEl.prev().find('button:contains("닫기")').text('보기');
            } else {
                $detailEl.show();
                $detailEl.find('#_helpDiv' + vl).hide().slideDown(250);
                $detailEl.prev().find('button:contains("보기")').text('닫기');
            }
        };

        var jsSaveHelp = function (vl) {
            var $detailEl = $('#_help' + vl);
            $("#hForm").find('input[name=helpId]').val($detailEl.find('input[name=helpId]').val());
            $("#hForm").find('input[name=menuCd]').val($detailEl.find('select[name=menuCd]').val());
            $("#hForm").find('input[name=helpNm]').val($detailEl.find('input[name=helpNm]').val());
            $("#hForm").find('input[name=contents]').val($detailEl.find('textarea[name=contents]').val());

            if ($("#hForm").valid() == false) return;

            $("#hForm").ajaxSubmit({
                url      : "INC_saveHelpAction.do",
                type     : "POST",
                async    : false,
                success  : function (response) {

                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.updateOk);
                            $('#sForm').submit();
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

        var jsDeleteHelp = function (vl) {
            var $detailEl = $('#_help' + vl);
            $("#hForm").find('input[name=helpId]').val($detailEl.find('input[name=helpId]').val());

            if( confirm("정말 삭제 하시겠습니까?")) {                
                $("#hForm").ajaxSubmit({
                    url      : "INC_deleteHelpAction.do",
                    type     : "POST",
                    async    : false,
                    success  : function (response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.deleteOk);
                                $('#sForm').submit();
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

        var jsMovePage = function (page) {
            var p = 1;
            if (page == 'page') {
                p = $('input[name=page]').val();
            } else {
                p = page;
            }
            $("#q_currPage").val(p);
            $('#sForm').submit();
        };

        $().ready(function () {

            var doAjax = function (nodeEls) {

                var emptStr = '>>>>>';
                var htmlStr = '<option value="">선택</option>';
                for (var i = 0; i < nodeEls.length; i++) {
                    htmlStr += '<option value="'+nodeEls[i].menuCd+'">'+emptStr.substring(1, nodeEls[i].menuLevel)+' '+nodeEls[i].menuNm+'</option>';
                }
                $('select[name=menuCd]').each(function () {
                    $(this).append(htmlStr);
                    $(this).val($(this).siblings('input[name=menuCdH]').val());
                });
            };

            $.ajax({
                type:        "POST",
                url:         "INC_menuList.do",
                dataType:    "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                async:       false,
                success:     function(data) { doAjax(data); },
                error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
            });

            $("button:contains('등록')").click(function () {
                $(this).colorbox({
                     title : "도움말 등록"
                    ,href  : "PD_helpAddForm.do"
                    ,width : "700" ,height:"500"
                    ,iframe: true
                });
            });

            $("#hForm").validate({
                rules: {
                    helpId:   { required:true, number: true},
                    helpNm:   { minlength:2, maxlength:66 },
                    contents: { required:true, minlength:5, maxlength:100 }
                }
            });
        });

        var CheckStrLen = function(maxlen, field) {
            var temp; //들어오는 문자값...
            var msglen = maxlen * 2;
            var value = field.value;
            var l = field.value.length;
            var tmpstr = "";

            if(l == 0) {
                value = maxlen * 2;
            } else {
                for(var k = 0; k < l; k++) {
                    temp = value.charAt(k);

                    if(escape(temp).length > 4)
                        msglen -= 2;
                    else
                        msglen--;

                    if(msglen < 0) {
                        alert("총 영문 " + (maxlen * 3 / 2) + "자 한글 " + maxlen + "자 까지 입력 하실 수 있습니다.");
                        field.value = tmpstr;
                        break;
                    } else {
                        tmpstr += temp;
                    }
                }
            }
        };

        var jsSearchAction = function() {

            if($("#q_searchType").val() != "") {
                if($("#q_searchText").val() == "") {

                    jsWarningBox("검색어를 입력하세요.");
                    $("#q_searchText").focus();
                    return false;
                }
            }

            if($("#q_searchType").val() == "") {
                if($("#q_searchText").val() != "") {

                    jsWarningBox("검색조건을 선택하세요.");
                    $("#q_searchType").focus();
                    return false;
                }
            }

            $('#q_currPage').val("1");
            $('#sForm').submit();
        };
    </script>
</head>

<body>

    <!-- 검색 -->
    <form id="sForm">

    <div class="search">
        <fieldset>
            <legend>검색하세요</legend>
            <select name="q_searchType" id="q_searchType" class="over">
                <option value="">선택</option>
                <option value="ALL"          <c:if test="${param.q_searchType eq 'ALL'}">selected="selected"</c:if>>전체</option>
                <option value="helpId"       <c:if test="${param.q_searchType eq 'helpId'}">selected="selected"</c:if>>도움말ID</option>
                <option value="helpNm"       <c:if test="${param.q_searchType eq 'helpNm'}">selected="selected"</c:if>>도움말명</option>
                <option value="helpContents" <c:if test="${param.q_searchType eq 'helpContents'}">selected="selected"</c:if>>내용</option>
            </select>
            <input type="text" name="q_searchText" id="q_searchText" class="w215"
                   value="${param.q_searchText}"  />
            <button type="button" class="gray mar_l5" onclick="jsSearchAction();">검색</button>
        </fieldset>
    </div>

    <op:pagerParam title="도움말목록" />
    <!-- //검색 -->
    </form>

    <!-- 도움말 수정 폼 -->
    <form id="hForm">
    <input type="hidden" name="helpId" />
    <input type="hidden" name="menuCd" />
    <input type="hidden" name="helpNm" />
    <input type="hidden" name="contents" />
    </form>

    <!-- 리스트 -->
    <table class="boardList"summary="게시판 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="5%"/>
            <col width="7%"/>
            <col width="18%"/>
            <col width=""/>
            <col width="12%"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>ID</th>
                <th>메뉴</th>
                <th>내용</th>
                <th class="lr_none">수정/삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pager.list}" var="_bean" varStatus="status">
            <tr <c:if test="${(pager.indexNo - status.index)%2 == 0}">class="bg_yellow""</c:if>>
                <td>${pager.indexNo - status.index}</td>
                <td>${_bean.helpId}</td>
                <td class="tx_l">${_bean.menuNm}</td>
                <td class="tx_l"><c:out value="${_bean.contents}" /></td>
                <td class="lr_none">
                    <a href="#" onclick="jsViewDetail('${_bean.helpId}');"><button type="button" class="s_blue">보기</button></a>
                    <a href="#" onclick="jsDeleteHelp('${_bean.helpId}');"><button type="button" class="s_blue">삭제</button></a>
                </td>
            </tr>
            <tr id="_help${_bean.helpId}" style="display: none;">
                <td colspan="5" class="lr_none"  style="padding: 5px 20px;">
                    <div id="_helpDiv${_bean.helpId}">
                        <table class="table_dark_red">
                            <colgroup>
                                <col width="120px" />
                                <col width="" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>ID</th>
                                    <td class="lr_none"><input type="text" name="helpId" size="93" value="${_bean.helpId}" readonly="readonly" /></td>
                                </tr>
                                <tr>
                                    <th>메 뉴</th>
                                    <td class="lr_none">
                                        <input type="hidden" name="menuCdH" value="${_bean.menuCd}" />
                                        <select name="menuCd" style="width: 300px"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>도움말 명</th>
                                    <td class="lr_none"><input type="text" name="helpNm" size="93" value="${_bean.helpNm}" /></td>
                                </tr>
                                <tr>
                                    <th>도움말 내용</th>
                                    <td class="lr_none"><textarea name="contents" rows="20" cols="70" onchange="CheckStrLen('666',this);" onkeyup="CheckStrLen('666',this);">${_bean.contents}</textarea></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="tx_r mar_t5 mar_b5">
                            <a href="#" onclick="jsSaveHelp('${_bean.helpId}');"><button type="button" class="blue">수정</button></a>
                        </div>
                    </div>
                </td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="5" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t10 mar_b20">
        <button type="button" class="blue">등록</button>
    </div>

</body>
</html>
