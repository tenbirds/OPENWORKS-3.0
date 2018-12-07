<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title>설문 등록</title>

    <op:jsTag type="spi" items="validate, datepicker" />

    <script type="text/javascript" src="<c:url value="/resources/intra/poll/poll.manage.js" />"></script>

    <script type="text/javascript">
    $().ready( function() {

        jsPollInsert();
        jsDupCheck();
        
        // 검색 날짜 입력
        $('#startTime').datepicker({dateFormat:"yymmdd"});
        $('#endTime').datepicker({dateFormat:"yymmdd"});
    });

    </script>

</head>

<body>

    <form name="dataForm" id="dataForm" action="<c:url value="ND_pollInsertAction.do" />" method="post">

        <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
        <op:pagerParam view="view" />

        <h4 class="tx_13">기본 정보</h4>
        <table class="boardWrite" width="100%" border="0" cellspacing="0" cellpadding="0" summary="기본 정보">
            <caption class="title">기본 정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>설문상태<span class="tx_red tx_b">*</span></th>
                    <td>
                        <select name="state" id="state"  title="선택">
                            <option value="N" >정상</option>
                            <option value="S" >중지</option>
                        </select>
                    </td>
                    <th>적용도메인<span class="tx_red tx_b">*</span></th>
                    <td>
                        <select id="domainCd" name="domainCd"  title="선택">
                            <option value="">-- 도메인 선택 --</option>
                            <c:forEach items="${domainList}" var="domain">
                            <option value="${domain.domainCd}" >${domain.domainNm}</option>
                            </c:forEach> 
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>제목<span class="tx_red tx_b">*</span></th>
                    <td colspan="3">
                        <input type="text" id="title" name="title" value="" maxlength="100" class="w85_p" />
                    </td>
                </tr>

                <tr>
                    <th>목적<span class="tx_red tx_b">*</span></th>
                    <td colspan="3">
                        <textarea name="purpose" id="textContent" rows="5" cols="30" class="w99_p" ></textarea>
                     </td>
                </tr>

                <tr>
                    <th>설문조사일<span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="text" name="startTime" id="startTime" value="" class="w80" /> ~ 
                        <input type="text" name="endTime" id="endTime" value="" class="w80" />
                    </td>
                    <th>설문참여제한</th>
                    <td>
                         <input type="text" id="limitCnt" name="limitCnt" class="w15" value="1" maxlength="3" />
                        <span class="tx_blue_s">'0' 설정시 제한이 없습니다.</span>
                    </td>
                </tr>

                <tr>
                    <th>중복차단여부<span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" class="radio" name="dupYn" id="dupYnY" value="Y" checked="checked"/>&nbsp;<label for="dupYnY">차단</label>
                        <input type="radio" class="radio" name="dupYn" id="dupYnN" value="N" />&nbsp;<label for="dupYnN">허용</label>
                    </td>
                    <th>중복차단 방법</th>
                    <td>
                        <input type="radio" class="radio" name="dupCheck" id="dupCheckU" value="U" checked="checked"/>&nbsp;<label for="dupCheckU">회원전용</label>
                        <input type="radio" class="radio" name="dupCheck" id="dupCheckI" value="I" />&nbsp;<label for="dupCheckI">IP 확인</label>
                        <input type="radio" class="radio" name="dupCheck" id="dupCheckC" value="C" />&nbsp;<label for="dupCheckC">Cookie 확인</label>
                    </td>
                </tr>

                <tr>
                    <th>공개여부<span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" class="radio" name="openYn" id="openYnY" value="Y" />&nbsp;<label for="openYnY">공개</label>
                        <input type="radio" class="radio" name="openYn" id="openYnN" value="N" checked="checked"/>&nbsp;<label for="openYnN">미공개</label>
                        <p class="tx_blue_s">설문 작성이 완료된 후 공개로 변경.</p>
                    </td>
                <th>용도선택</th>
                <td>
                    <input type="radio" class="radio" name="bannerYn" id="bannerYnN" value="N" checked="checked" />&nbsp;<label for="bannerYnN">설문</label>
                    <input type="radio" class="radio" name="bannerYn" id="bannerYnY" value="Y" />&nbsp;<label for="bannerYnY">설문 + 베너</label>
                    <p class="tx_blue_s">(메인 페이지 베너 기능이 있을 시)</p>
                </td>
                </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><button type="submit" class="w_blue">저장</button></li>
                <li><button type="button" class="blue" onclick="jsPollList();">목록</button></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>
