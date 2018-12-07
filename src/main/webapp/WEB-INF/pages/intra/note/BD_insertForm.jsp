<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>쪽지 관리</title>
    <op:jsTag type="openworks" items="validate, ckeditor" />
    <op:jsTag type="spi" items="extjs, form, selectbox, autocomplete, validate, multifile, ui"/>

    <script type="text/javascript">
        var _DEPT_USER_DRAG_TARGET_EL_NM = "mgrNms";
        var _DEPT_USER_TREE_TITLE = "위의 상자로 사용자를 드래그하세요.";
        var _DEPT_USER_ITEM_MULTI_SELECT = true;
    </script>

    <script type="text/javascript" src="<c:url value="/resources/intra/note/note.mgrList.js" />"></script>
    <script type="text/javascript">

        $(document).ready(function() {
              //설정값들을 초기화 합니다.
            if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }

            OpenWorks.pageType        = "${pageType}";
            OpenWorks.fileYn        = "${dataVo.fileYn}";
            OpenWorks.uploadType    = "${dataVo.uploadType}";
            OpenWorks.maxFileCnt    = "${dataVo.maxFileCnt}";
            OpenWorks.maxFileSize    = "${dataVo.maxFileSize}";
            OpenWorks.totalFileSize    = "${dataVo.totalFileSize}";
            OpenWorks.fileExts        = "${dataVo.fileExts}";
            OpenWorks.closeFileIcon    = "<c:url value='/resources/openworks/theme/default/images/btn/btn_r_close.gif' />";

            $("#dataForm").submit(function() {
                return doAjaxInsert();
            });

            $("input[name=mgrNm]").autocomplete({
                minLength: 2,
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/mgr/ND_mgrSearchList.do" />",
                        type: "post",
                        dataType: "json",
                        data: {
                            q_rowPerPage: 20,
                            useYn: "Y",
                            mgrNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function(event, ui) {
                    _DEPT_USER_ADD_OPTION(ui.item.mgrId,ui.item.label);
                },
                close: function(event, ui) {
                    $("#mgrNm").val("");
                }
            });

        });


        var doAjaxInsert = function(){
            var v = [];
            $("#mgrNms option").each(
                function() {
                    v[v.length] = this.value;
                }
            );

            if ( v == "" ) {
                jsWarningBox("수신자를 1명 이상 지정하세요.");
                $("#mgrNm").focus();
                return false;
            }

            var contentsLen=$("#contents").val();
            if (contentsLen.length < 1) {
                jsWarningBox("보낼쪽지 내용을 입력하세요");
                $("#contents").focus();
                return false;
            }
            if (contentsLen.length > 200) {
                jsWarningBox("200글자를 초과할 수 없습니다.");
                $("#contents").focus();
                return false;
            }

            $("#receivers").val(v);

            dataString = $("#dataForm").serialize();
            $("#dataForm").ajaxSubmit({
                url: "INC_insertAction.do",
                type: "POST",
                data: dataString,
                success: function(response) {
                    if(response) {
                        jsSuccessBox("쪽지를 " + v.length + "명에게 전송 했습니다.");
                        jsRppReset(2);
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                }
            });

            return false;
        };

        var jsDeleteSeletedAdmin = function(selectedOnly) {
            $("#mgrNms").removeOption(/./, selectedOnly);
        };

        var jsRppReset = function(flag) {
            document.listForm.action = "BD_index.do";
            document.listForm.elements["flag"].value = flag;
            document.listForm.elements["currentPage"].value = "0";
            document.listForm.submit();
        };
        var jsMenuClick = function(flag) {
            document.listForm.action = "BD_index.do";
            document.listForm.elements["flag"].value = flag;
            document.listForm.elements["currentPage"].value = "0";
            document.listForm.submit();
        };
        var jsList = function() {
            document.listForm.action = "BD_index.do";
            document.listForm.submit();
        };
    </script>
</head>

<body>

<form name="listForm" method="get">
    <input type="hidden" name="flag" value="${param.flag}" />
    <input type="hidden" name="currentPage" value="" />
</form>
<!-- 탭 영역 시작 -->
<ul class="tab">
    <li>
        <a href="javaScript:jsMenuClick(1);"><span>받은 쪽지함</span></a>
    </li>
    <li>
        <a href="javaScript:jsMenuClick(2);"><span>보낸 쪽지함</span></a>
    </li>
    <li>
        <a href="BD_insertForm.do?flag=${flag}" class="on"><span>쪽지 보내기</span></a>
    </li>
</ul>
<!-- //타이틀 및 상단아이콘 -->
<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
<%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
<op:pagerParam view="view" />

<input type="hidden" name="flag" value="${param.flag}" />
<input type="hidden" name="receivers" id="receivers" />
<input type="hidden" name="summary" id="summary" />

<!-- 목록 및 입력-->
<div class="buser">

    <!-- 목록 -->
    <div class="b_list">
        <input type="text" name="mgrNm" id="mgrNm" class="mar_b5" style="width:242px;" />
        <span class="tx_blue_s">
            수신대상 담당자 이름을 입력하세요.<br />
        </span>

        <select name="mgrNms" id="mgrNms" class="t-area mar_b10" style="width:248px;" size="4">
            <c:if test="${not empty param.mgrId}">
                <option value="${val}">${txt}</option>
            </c:if>
        </select>
        <div class="write-note mar_b10">
            <!-- <button class="s_blue" type="button" onclick="_DEPT_USER_ADDED_NODE();">선택추가</button> -->
            <button class="s_blue" type="button" onclick="jsDeleteSeletedAdmin(true);">삭제</button>
            <button class="s_blue" type="button" onclick="jsDeleteSeletedAdmin(false);">전체삭제</button>
        </div>
        <div id="myMenuDiv" style="background-color:red;"></div>

        <div id="_DEPT_USER_TREE" class="mar_t10"></div>
    </div>
    <!-- //목록 -->

    <div class="b_write" style="padding-left: 30px;">
        <textarea name="contents" id="contents" rows="30" class="w99_p mar_b10"></textarea>
        <div>
            <div>
                <label for="file">[첨부파일] </label>
                <div class="mar_t5 mar_b5">
                    <input type="hidden" name="fileSeq" id="fileSeq" value="${dataVo.fileSeq}" />
                    <input type="file" name="multiFiles" id="multiFiles" class="multi max-${dataVo.maxFileCnt} w470" accept="${dataVo.fileExts}"<c:if test="${dataVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기" />
                    <div id="multiFilesListDiv" class="regist-file"></div>
                </div>
    
                <p class="tx_blue_s">
                    - <c:if test="${fn:length(dataVo.fileExts) >= 3 }"><script type="text/javascript">document.write("${dataVo.fileExts}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if>
                    최대 ${dataVo.maxFileCnt}개까지 업로드 할 수 있습니다.
                    <c:if test="${dataVo.maxFileSize > 0}">파일당 ${dataVo.maxFileSize}MB</c:if>
                    <c:if test="${(dataVo.maxFileSize > 0) && (dataVo.totalFileSize > 0)}">, </c:if>
                    <c:if test="${dataVo.totalFileSize > 0}">전체 ${dataVo.totalFileSize}MB</c:if>
                    <c:if test="${(dataVo.maxFileSize > 0) || (dataVo.totalFileSize > 0)}"> 업로드 할 수 있습니다.</c:if>
                </p>
                <input type="hidden" id="uploadFileCnt" value="${dataVo.fileCnt}" />
            </div>
        </div>       
        <input type="checkbox" id="senderDelYn" name="senderDelYn" value="Y" checked="checked" class="checkbox" />
        <label for="senderDelYn">보낸 쪽지함에 저장</label>

        <div class="mar_t10 tx_r">
            <button class="blue" type="submit">보내기</button>
            <button class="blue" type="button" onclick="jsList();">취소</button>
        </div>
    </div>

</div>
</form>
</body>
</html>