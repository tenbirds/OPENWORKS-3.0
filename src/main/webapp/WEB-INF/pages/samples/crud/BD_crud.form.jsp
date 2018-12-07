<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>게시물 등록</title>

    <op:jsTag type="spi" items="form, validate, multifile"/>
    <op:jsTag type="openworks" items="form, validate, ckeditor" />

    <!-- 유효성 검증 BEAN Annotation 기반 자동 설정 -->
    <valid:script type="alert" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/samples/crud/samples.crud.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /* 공통 초기화 */
        $(document).ready(function() {

            $("#dataForm").submit(function() {
                return validate();
            });

            $("#crudFile").MultiFile({ max: 3 });

            // Ckeditor
            $("[name='contents']").ckeditor(function() { }, {
                height : 200,
                enterMode : "2",
                skin : "moono",
                toolbar : toolbar_config.default_toolbar,
                filebrowserUploadUrl : "/resources/spi/ckeditor/upload/upload.jsp"
            });

/* 
            $("#dataForm").validate({
                // 유효성 검증 BEAN Annotation 기반 자동 설정 
                <valid:script type="jquery" />,
                submitHandler : function(form) {
                    $(form).ajaxSubmit({
                        type : "POST",
                        success : function(response) {
                            jsSuccessBox(response);
                        },
                        error :  function(response) {
                            jsSysErrorBox(response.responseText);
                            return;
                        }
                    });
                }
            });
 */

        });

        /*
         * validate() 호출시 사용자 정의 검증을 자동으로 호출함
         * 따라서 필요시 추가 로직을 아래 함수 명으로 작성하면 됨
         * 물론 필요 없을 시 없어도 됨.(셈플이기 때문에 작성한 것임)
         */

         var customValidate = function() {
            return true;
        };

        /**
         * 파일정보 수정(파일명, 정렬순서, 파일설명)
         */
        var jsFileUpdate = function(fileSeq) {
            $().colorbox({
                title : "파일정보 수정",
                href : "/component/file/PD_fileUpdateForm.do?fileSeq="+fileSeq,
                width : "650",
                height : "450",
                iframe : true
            });
        }

        //]]>
    </script>
</head>
<body>


    <c:choose>
        <c:when test="${empty dataVo.seq}">
            <c:set var="action" value="ND_crud.insert.do" />
            <c:set var="title" value="신규등록" />
        </c:when>
        <c:otherwise>
            <c:set var="action" value="ND_crud.update.do" />
            <c:set var="title" value="글 수정" />
        </c:otherwise>
    </c:choose>

    <div class="po_rel">
        <h4>${title}</h4>
        <div class="h4_r">
            <span class="tx_red tx_b">*</span> 표시는 필수입력사항입니다.
        </div>
    </div>

    <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}">

    <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
    <op:pagerParam view="view" />

    <input type="hidden" name="seq" id="seq" value="${dataVo.seq}" />

    <!-- 내용쓰기 -->
    <fieldset>
        <legend>글입력</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="게시판 내용 작성페이지입니다.">
            <caption class="hidden">게시판 글입력 페이지</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="regPwd">비밀번호</label></th>
                    <td>
                        <input type="text" name="regPwd" id="regPwd" value="${dataVo.regPwd}" />

                        <valid:msg name="regPwd" />
                    </td>
                </tr>
                <tr>
                    <th><label for="title">제목<span class="tx_red tx_b">*</span></label></th>
                    <td>
                        <input type="text" name="title" id="title" class="w85_p" title="제목을 입력해주세요" value="${dataVo.title}" />

                        <valid:msg name="title" />
                    </td>
                </tr>
                <tr>
                    <th><label for="ctgCd">분류<span class="tx_red tx_b">*</span></label></th>
                    <td>
                        <select name="ctgCd" id="ctgCd" title="분류선택해주세요">
                            <option value="">선택해 주세요</option>
                            <option value="1001" <c:if test="${dataVo.ctgCd eq '1001'}">selected="selected"</c:if>>분류1</option>
                            <option value="1002" <c:if test="${dataVo.ctgCd eq '1002'}">selected="selected"</c:if>>분류2</option>
                        </select>

                        <valid:msg name="ctgCd" />
                    </td>
                </tr>
                <tr>
                    <th><label for="noticeYn">공지여부</label></th>
                    <td>
                        <input type="checkbox" name="noticeYn" id="noticeYn" value="Y"
                            <c:if test="${dataVo.noticeYn eq 'Y'}">checked="checked"</c:if>/>

                        <valid:msg name="noticeYn" />
                    </td>
                </tr>
                <tr>
                    <th><label for="contents">내용</label></th>
                    <td>
                        <textarea id="contents" name="contents" rows="15" class="w99_p" title="내용입력">${dataVo.contents}</textarea>

                        <valid:msg name="contents" />
                    </td>
                </tr>
                <tr>
                    <th>공개여부</th>
                    <td>
                        <input type="radio" name="openYn" id="openYnN" value="N"
                            <c:if test="${dataVo.openYn eq 'N'}">checked="checked"</c:if> />
                        <label for="openYnN">비공개</label>

                        <input type="radio" name="openYn" id="openYnY" value="Y"
                            <c:if test="${dataVo.openYn eq 'Y'}">checked="checked"</c:if> />
                        <label for="openYnY">공개</label>

                        <valid:msg name="openYn" />
                    </td>
                </tr>
                <tr>
                    <th><label for="file">첨부파일</label></th>
                    <td>
                        <c:if test="${fn:length(dataVo.fileList) > 0}">
                            <p class="tx_blue_s">
                                - 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">체크박스를 선택</span>하세요.
                                <button type="button" class="gray_s mar_l10" onclick="jsFileUpdate('${dataVo.fileSeq}');">파일정보 보기/수정</button>
                            </p>
                            <ul>
                                <c:forEach items="${dataVo.fileList}" var="fileVo">
                                    <li class="mar_b5">
                                        <input type="checkbox" name="fileIds" id="${fileVo.fileId}" value="${fileVo.fileId }" />
                                        <label for="${fileVo.fileId}">${fileVo.localNm} 삭제</label>
                                        <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>

                                        <!--
                                        <a href="<c:url value="/component/file/ND_fileDownload.do"/>?id=${fileVo.fileId}">${fileVo.localNm}</a>
                                        -->
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>

                        <p class="tx_blue_s">- 최대 3개까지 업로드 할 수 있습니다. 파일당 100MB, 전체 100MB 업로드 할 수 있습니다.</p>
                        <p class="mar_t5 mar_b5">
                            <input type="hidden" name="fileSeq" id="fileSeq" value="${dataVo.fileSeq}" />
                            <input type="file" name="crudFile" id="crudFile" class="w470 multi" accept="gif|jpg|zip" value="찾아보기" />
                        </p>

                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!-- //내용쓰기 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="submit" value="등록" class="w_blue" /></li>
            <li><input type="reset" value="취소" class="w_blue" /></li>
            <li><input type="button" value="목록" class="blue" onclick="jsList();" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

    </form>

</body>
</html>