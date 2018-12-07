<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>메시지 관리</title>

    <op:jsTag type="spi" items="validate, multifile" />
    <op:jsTag type="openworks" items="form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            $("#logoFile").MultiFile({ max: 1 });
            $("#attechFile").MultiFile({ max: 1 });

            $("#dataForm").validate({
                rules: {
                    title : { required: true, minlength: 5, maxlength : 200 }
                },
                submitHandler : function(form) {
                    form.submit();
                }
            });
        });

        var jsPreView = function(q_messageSeqNo) {
            window.open("ND_MessagePreView.do?q_messageSeqNo="+q_messageSeqNo, "MessagePreView", "");
        };
        //]]>
    </script>
</head>
<body>
    <c:set var="action" value="ND_InsertMessage.do" />
    <c:if test="${not empty dataVo}">
        <c:set var="action" value="ND_UpdateMessage.do" />
    </c:if>

    <form id="dataForm" name="dataForm" method="post" enctype="multipart/form-data" action="${action}">

        <input type="hidden" id="messageSeqNo" name="messageSeqNo" value="${dataVo.messageSeqNo}" />

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />

        <div id="message">
            <fieldset>
            <legend>메시지 입력</legend>
                <div class="mes_top m_w940">
                    <label for="title" class="tx_white">제목</label> <input type="text" id="title" name="title" class="w880" title="제목을 입력해주세요" value="${dataVo.title}" />
                </div>
                <div class="mes_body m_h660">
                    <div class="wid_center m_w940">
                        <div class="phone">
                            <label for="smsContent" class="skip">문자메시지</label>
                            <textarea id="smsContent" name="smsContent"  rows="5" class="w175" title="메시지입력">${dataVo.smsContent}</textarea>
                        </div>
                        <div class="letter">
                            <div class="l_top">
                                <p class="mar_b10">
                                    <label for="sub" class="tx_b_gray">제목</label>
                                    <input type="text" id="mailTitle" name="mailTitle" class="w430" title="메일 제목을 입력해주세요" value="${dataVo.mailTitle}" />
                                </p>
                                <p>
                                    <label for="logoFile" class="tx_b_gray">로고</label>

                                    <input type="hidden" name="logoFileSeq" id="logoFileSeq" value="${dataVo.logoFileSeq}" />
                                    <span class="file_btn">
                                        <input type="file" id="logoFile" name="logoFile"  value="찾아보기" class="file multi" />
                                    </span>
            
                                    <c:if test="${fn:length(dataVo.logoFileList) > 0}">
                                        <p class="mar_t5 tx_blue_s">
                                            - 신규로 로고파일을 등록하는 경우 기존 파일은 <span class="tx_red">자동삭제</span>됩니다.
                                        </p>
                                        <ul>
                                            <c:forEach items="${dataVo.logoFileList}" var="logoFileVo">
                                                <li class="mar_b5">
                                                    <a href="/component/file/ND_fileDownload.do?id=${logoFileVo.fileId}" title="${logoFileVo.fileDesc}">${logoFileVo.localNm}</a>
                                                    <span class="tx_gray">(download ${logoFileVo.downCnt}, ${logoFileVo.fileSize}, ${logoFileVo.fileType})</span>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </p>
                            </div>
                            <div class="l_center">
                                <label for="mailContent" class="skip">내용</label>
                                <textarea id="mailContent" name="mailContent"  rows="5" class="w460" title="메일내용을 입력해주세요.">${dataVo.mailContent}</textarea>
                            </div>
                            <div class="l_footer">
                                <p class="mar_b10">
                                    <label for="mailAddr" class="tx_b_gray">주소</label>
                                    <textarea id="mailAddr" name="mailAddr"  rows="2" class="w430" style="width: 430px;" title="주소를 입력해주세요.">${dataVo.mailAddr}</textarea>
                                </p>
                                <p>
                                    <label for="attechFile" class="tx_b_gray">첨부</label>

                                    <input type="hidden" name="attechFileSeq" id="attechFileSeq" value="${dataVo.attechFileSeq}" />
                                    <span class="file_btn">
                                        <input type="file" id="attechFile" name="attechFile"  value="찾아보기" class="file multi" />
                                    </span>

                                    <c:if test="${fn:length(dataVo.attechFileList) > 0}">
                                        <p class="mar_t5 tx_blue_s">
                                            - 신규로 첨부파일을 등록하는 경우 기존 파일은 <span class="tx_red">자동삭제</span>됩니다.
                                        </p>
                                        <ul>
                                            <c:forEach items="${dataVo.attechFileList}" var="attechFileVo">
                                                <li class="mar_b5">
                                                    <a href="/component/file/ND_fileDownload.do?id=${attechFileVo.fileId}" title="${attechFileVo.fileDesc}">${attechFileVo.localNm}</a>
                                                    <span class="tx_gray">(download ${attechFileVo.downCnt}, ${attechFileVo.fileSize}, ${attechFileVo.fileType})</span>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </p>
                            </div>
                            <p class="btn">
                                <span class="mar_b5 tx_blue_s"> 미리보기 기능은 저장 후 확인이 가능합니다.</span><br />
                                <c:if test="${not empty dataVo.messageSeqNo}">
                                    <button type="button" onclick="jsPreView('${dataVo.messageSeqNo}');"><img src="/resources/monitor/images/message/btn_message_view.gif" alt="미리보기"/></button>
                                </c:if>
                                <button type="submit"><img src="/resources/monitor/images/message/btn_message_save.gif" alt="저장하기"/></button>
                                <button type="button" onclick="jsList('BD_MessageList.do');"><img src="/resources/monitor/images/message/btn_message_list.gif" alt="목록"/></button>
                            </p>

                        </div>
                    </div>
                </div>
            </fieldset>
        </div>

    </form>
</body>
</html>