<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

<html>
<head>
<title>휴일 관리</title>

    <op:jsTag type="spi" items="ui, validate" />
    <op:jsTag type="openworks" items="form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <script type="text/javascript">
    //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // radio 값 설정
            jsChecked("useYn", "${dataVo.useYn}");
            jsChecked("holidayType", "${dataVo.holidayType}");

            //검색 날짜 입력
            $.datepicker.setDefaults({
                dateFormat:"yymmdd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            $('#holidayYmd').datepicker();

            $("#dataForm").validate({
                rules: {
                    holidayYmd : { required: true, minlength: 8, maxlength : 8 },
                    holidayNm       : { required: true},
                    holidayType       : { required: true},
                    useYn    : { required: true }
                },
                submitHandler : function(form) {
                    form.submit();
                }
            }); 
        });

        var jsHolidayDelete = function() {
            if(!confirm("정말 삭제 하시겠습니까?"))
                return false;

            $("#dataForm").attr("action", "ND_DeleteHoliday.do");
            document.dataForm.submit();
        };

        //
    </script>

</head>
<body>

<form id="dataForm" name="dataForm" method="post" action="ND_InsertHoliday.do">

    <c:choose>
        <c:when test="${not empty dataVo.holidayYmd}">
            <input type="hidden" name="pageType" value="UPDATE" />
        </c:when>
        <c:otherwise>
            <input type="hidden" name="pageType" value="INSERT" />
        </c:otherwise>
    </c:choose>

    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
    <op:pagerParam view="view" />

    <!-- 휴일 등록 폼 시작-->
    <table class="boardWrite" width="100%" border="0" cellspacing="0" summary="휴일 등록">
        <caption>휴일 등록</caption>
        <colgroup>
            <col width="15%" />
            <col width="" />
        </colgroup>
        <tbody>

            <tr>
                <th>휴일날짜</th>
                <td>
                    <input type="text" id="holidayYmd" name="holidayYmd" value="${dataVo.holidayYmd}" maxlength="8" readonly="readonly" class="w80" />
                </td>
            </tr> 

            <tr>
                <th>휴일명</th>
                <td><input type="text" name="holidayNm" value="${dataVo.holidayNm}" class="w120" maxlength="50" /></td>
            </tr>

            <tr>
                <th>휴일유형</th>
                <td>
                    <input type="radio" name="holidayType" id="holidayType1" value="1" class="radio" /><label for="holidayType1">국경일</label>&nbsp;
                    <input type="radio" name="holidayType" id="holidayType2" value="2" class="radio" /><label for="holidayType2">공휴일</label>&nbsp;
                    <input type="radio" name="holidayType" id="holidayType9" value="9" class="radio" /><label for="holidayType9">기타</label> 
                </td>
            </tr> 

            <tr>
                <th>휴일설명</th>
                <td>
                    <textarea name="holidayDesc" id="holidayDesc" rows="3" cols="30" class="textarea"  style="width:100%;" >${dataVo.holidayDesc}</textarea>
                </td>
            </tr>

            <tr class="no-btm">
                <th>사용여부</th>
                <td>
                    <input type="radio" name="useYn" id="useYnY" value="Y" class="radio" /><label for="useYnY">사용</label>&nbsp;
                    <input type="radio" name="useYn" id="useYnN" value="N" class="radio" /><label for="useYnN">사용 안함</label> 
                </td>
            </tr>
        </tbody>
    </table>
    <!-- 휴일 등록 폼 끝 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t20">
        <button type="submit"><img src="/resources/monitor/images/btn/btn_save.gif" alt="저장"/></button>
        <c:if test="${not empty dataVo}">
            <button type="button" onclick="jsHolidayDelete();"><img src="/resources/monitor/images/btn/btn_del01.gif" alt="삭제"/></button>
        </c:if>
        <button type="button" onclick="jsList('BD_HolidayList.do');"><img src="/resources/monitor/images/btn/btn_list.gif" alt="목록"/></button>
    </div>
    <!-- //버튼 -->

</form>

</body>
</html>