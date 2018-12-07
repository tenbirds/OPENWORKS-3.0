<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

<html>
<head>
<title>휴일 관리</title>

    <op:jsTag type="spi" items="multifile, validate" />
    <op:jsTag type="openworks" items="form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <script type="text/javascript">
    //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            $("#dataForm").validate({
                rules: {
                    excelFile : { required: true}
                },
                submitHandler : function(form) {
                    form.submit();
                }
            }); 
        });

    //]]>
    </script>

</head>
<body>

<form id="dataForm" name="dataForm" method="post" enctype="multipart/form-data" action="<c:url value="ND_InsertHolidayExcel.do" />">

    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
    <op:pagerParam view="view" />

    <!-- 휴일 Excel 등록 폼 시작-->
    <table class="boardWrite" width="100%" border="0" cellspacing="0" summary="휴일 Excel 등록">
        <caption>휴일 Excel 등록</caption>
        <colgroup>
            <col width="15%" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th>파일등록</th>
                <td>
                    <input type="file" id="excelFile" name="excelFile" value="" class="w470 multi" />

                    <div class="tx_blue_s mar_t10">
                        - 아래와 같이 첫 시트의 첫라인부터 입력하며, 휴일 유형은 3개의 유형 숫자중에 선택하세요.<br />
                        - 휴일날짜 예) 20121215<br />
                        - 휴일명 : 예) 추석<br />
                        - 휴일유형(1 : 국경일, 2 : 공휴일, 9 : 기타 중 선택) : 예) 1<br />
                        - 휴일설명 : 예) 추석연휴<br />
                        - 사용여부(Y 또는 N) : 예) Y<br /><br />
                        * 셈플<br />
                        <table class="boardWrite" border="1">
                            <tr>
                                <td>20121215</td>
                                <td>추석</td>
                                <td>1</td>
                                <td>추석연휴</td>
                                <td>Y</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr> 
        </tbody>
    </table>
    <!-- 휴일 Excel 등록 폼 끝 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t20">
        <button type="submit"><img src="/resources/monitor/images/btn/btn_save.gif" alt="저장"/></button>
        <button type="button" onclick="jsList('BD_HolidayList.do');"><img src="/resources/monitor/images/btn/btn_list.gif" alt="목록"/></button>
    </div>
    <!-- //버튼 -->

</form>

</body>
</html>