<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>

<head>
    <title>마일리지 관리</title>
    <op:jsTag type="spi" items="form,validate,highlight" />
    <op:jsTag type="openworks" items="ui" />

    <script type="text/javascript">

    $().ready( function() {

    });

    var jsSearchAction = function() {
//         $("#q_searchKey").val($("#q_searchKey option:selected").val());
        $("#q_currPage").val("1");
        $("#dataForm").submit();
    };

    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#pagingForm input[name=q_currPage]").val(p);
        $("#pagingForm").submit();
    };

    var jsInsertMileage = function(obj) {
        var doAjax = function(data){
            if(data == 0){
                jsWarningBox("마일리지 등록은 유효기간 설정 후 등록됩니다.");
                $(obj).colorbox.close();
                return;
            }else{
            }
        };

        $.ajax({
            type:        "POST",
            url:         "INC_expDateSetCount.do",
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });
    };

    var jsDownExcel = function() {
        if ($('#excelFr').length == 0) {
            $('body').append('<iframe id="excelFr" style="display: none;"/>');
        }

        var url = 'INC_mileageMngListExcel.do?q_searchKey='+$("#q_searchKey option:selected").val()+'&q_searchVal='+$("#q_searchVal").val();
        $('#excelFr').attr('src',url);
    };

    var jsSetMileageGroup = function(el) {
        $(el).colorbox({
            title : "마일리지 그룹 관리",
            href  : "PD_setMileageGroupPop.do",
            width : "770",
            height: "550",
            iframe: true
        });
    };

    var jsSetExpDate = function(el) {
        $(el).colorbox({
            title : "마일리지 유효기간 설정",
            href  : "PD_setExpDatePop.do",
            width : "770",
            height: "500",
            iframe: true
        });
    };

    var jsMileageInsert = function(el){
        $.ajax({
            type:        "POST",
            url:         "INC_expDateSetCount.do",
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });

        var doAjax = function(data){
            if(data == 0){
                jsWarningBox("마일리지 등록은 유효기간 설정 후 등록됩니다.");
                $(el).colorbox.close();
                return;
            }else{
                $(el).colorbox({
                    title  : "마일리지 등록",
                    href   : "PD_mileageInsertForm.do",
                    width  : "950",
                    height : "550",
                    iframe : true
                });
            }
        };
    };

    var jsDelValidate = function() {
        var seqChecked = false;
        $("input[name=mileageCd]:checked").each(function (i){
            seqChecked = true;
        });

        if(!seqChecked) {
            jsWarningBox("삭제할 마일리지를 선택하여 주십시오.");
            return false;
        }

        if(!confirm("정말 삭제하시겠습니까?")) {
            return false;
        }
        return true;
    };

    var jsMileageInfoForm = function(el, mileageCd) {
        $(el).colorbox({
            title : "마일리지 정보 수정",
            href  : "PD_mileageUpdateForm.do?mileageCd="+mileageCd,
            width : "950",
            height: "600",
            iframe: true
        });
    };

    // 체크된 목록을 가져온다.
    var jsCheckedArray = function() {
         var selectedSeqs = new Array();
         $("input[name=mileageCd]:checked").each(function (i){
             selectedSeqs[i] = $(this).val();
         });
         return selectedSeqs;
    };

    // 마일리지 삭제
    var jsDeleteMileage = function() {
        var selectedSeqs = jsCheckedArray();
        var seqs = $.makeArray(selectedSeqs);
        if ( selectedSeqs.length == 0 ) {
            jsWarningBox("삭제할 마일리지를 선택하여 주십시오.");
            return false;
        } else {
            if (!confirm("정말 삭제하시겠습니까?")) return false;
            $("#mileageCds").val(selectedSeqs);
            $.ajax({
                type : "POST",
                url : "ND_deleteMileageAction.do",
                data : {
                    mileageCds : $("#mileageCds").val()
                },
                dataType: "json",
                success : function(response) {
                    if(response.result) {
                        var accuExist = response.value;
                        // 삭제 제외된 항목이 있는지에 따라서 메시지 표시 구분
                        if(accuExist) {
                            var msg = "선택된 마일리지 중 이미 적립이 이루어진 마일리지가 있습니다.<br />";
                            msg += "적립이 이루어진 마일리지는 삭제대상에서 제외됩니다.<br /><br />";
                            msg += "적립된 마일리지 : " + accuExist;
                            msg += "<br /><br />위 항목을 제외한 ";

                            var options = {};
                            options["type"] = "success";
                            options["stay"] = "true";
                            sendMsg(msg + response.message, options);

                            self.location.reload();
                        } else {
                            jsSuccessBox(response.message);
                            $('#dataForm').submit();
                        }
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                }
            });
        }
    };

    </script>
</head>

<body>
<div>
    <ul class="tab">
        <li><a href="<c:url value="../mng/BD_index.do" />" class="on">마일리지 항목 설정</a></li>
        <li><a href="<c:url value="../read/BD_index.do" />">회원 마일리지 조회</a></li>
        <li><a href="<c:url value="../status/BD_index.do" />">마일리지 통계</a></li>
        <li><a href="<c:url value="../voucher/BD_index.do" />">서비스권 신청</a></li>
    </ul>
</div>

<div id="contents">
<form name="pagingForm" id="pagingForm" method="post" action="BD_index.do">
<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
<input type="hidden" name="q_currPage" value="${param.q_currPage}" />
<input type="hidden" name="q_sortName" value="" />
<input type="hidden" name="q_sortOrder" value="" />
<input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
</form>
<form name="dataForm" id="dataForm" method="post" action="BD_index.do">
    <div style="float: right;" class="mar_b10">
        <!-- 마일리지 그룹설정 버튼 -->
        <button class="s_blue mar_l5" type="button" onclick="jsSetMileageGroup(this);">마일리지 그룹설정</button>
        <!-- 유효기간설정 버튼 -->
        <button class="s_blue mar_l5" type="button" onclick="jsSetExpDate(this);">유효기간 설정</button>
        <!-- 마일리지 등록 버튼 -->
<!--         <button class="s_blue mar_l5" type="button" onclick="jsInsertMileage(this);">마일리지 등록</button> -->
        <button class="s_blue mar_l5" type="button" onclick="jsMileageInsert(this);">마일리지 등록</button>
        <!-- 엑셀출력 버튼 -->
        <button class="s_blue mar_l5" type="button" onclick="jsDownExcel();">엑셀출력</button>
    </div>

    <!-- 검색 -->
    <div class="search">
        <fieldset>
            <legend>게시글의 마일리지 명,마일리지 그룹명으로 검색하세요.</legend>
            <!-- 마일리지 타입 선택 -->
            <label for="q_searchKey" class="none">검색 구분</label>
            <select id="q_searchKey" name="q_searchKey">
                <option>-- 선택 --</option>
                <option value="mileageGrpNm" <c:if test="${param.q_searchKey eq 'mileageGrpNm'}"> selected="selected"</c:if>>마일리지 그룹명</option>
                <option value="mileageNm" <c:if test="${param.q_searchKey eq 'mileageNm'}"> selected="selected"</c:if>>마일리지 명</option>
            </select>

            <!-- 검색어 작성-->
            <input class="w215" type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" />

            <!-- 검색버튼 -->
            <button class="gray mar_l5 mar_b5" type="button" onclick="jsSearchAction();">검색</button>

        </fieldset>
    </div>

    <op:pagerParam title="마일리지항목설정" />
</form>
    <!-- //검색 -->
    <!-- 리스트 -->
<form name="listForm" id="listForm" method="post" action="BD_index.do">
    <input type="hidden" id="mileageCds" name="mileageCds" />
    <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="5%"/>
            <col width="5%"/>
            <col width=""/>
            <col width="20%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="15%"/>
        </colgroup>
        <thead>
            <tr>
                <th>선택<br /><input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('mileageCd', this);" /></th>
                <th>번호</th>
                <th>마일리지명</th>
                <th>마일리지 그룹명</th>
                <th>1일<br />적립회수</th>
                <th>1일 적립<br />최대 한도</th>
                <th>사용여부</th>
                <th class="lr_none">등록일시</th>
            </tr>
        </thead>
        <tbody id="odd-color">

            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="mileageVo" varStatus="status">
                <tr>
                    <td>
                        <input type="checkbox" onclick="jsToggleCheck(this);" id="mileageCd_${mileageVo.mileageCd}" name="mileageCd" value="${mileageVo.mileageCd}" />
                    </td>
                    <td>
                        ${index-status.index}
                    </td>
                    <td>
                        <a href="PD_mileageUpdateForm.do?mileageCd=${mileageVo.mileageCd}" onclick="jsMileageInfoForm(this, '${mileageVo.mileageCd}'); return false;">
                            ${mileageVo.mileageNm}
                        </a>
                    </td>
                    <td>
                        ${mileageVo.mileageGrpNm}
                    </td>
                    <td class="tx_r">
                        <c:if test="${mileageVo.dailyMaxAccuCnt ne 0}">
                            ${mileageVo.dailyMaxAccuCnt} 회
                        </c:if>
                        <c:if test="${mileageVo.dailyMaxAccuCnt eq 0}">
                            무제한
                        </c:if>
                    </td>
                    <td class="tx_r">
                        <c:if test="${mileageVo.dailyMaxAccuAmount ne 0}">
                            <fmt:formatNumber value="${mileageVo.dailyMaxAccuAmount}" type="number" /> 점
                        </c:if>
                        <c:if test="${mileageVo.dailyMaxAccuAmount eq 0}">
                            무제한
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${mileageVo.useYn eq 'Y'}">사용</c:if>
                        <c:if test="${mileageVo.useYn ne 'Y'}">미사용</c:if>
                    </td>
                    <td class="lr_none">
                        <fmt:formatDate value="${mileageVo.regDtm}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="8" />
        </tbody>
    </table>
    <!-- //리스트 -->
    <c:if test="${not empty pager.list}">
    <div class="tx_l mar_t10">
<!--         <button class="blue">선택 삭제</button> -->
        <button class="blue" type="button" onclick="jsDeleteMileage();">선택 삭제</button>
    </div>
    </c:if>
</form>
    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
    <!-- 버튼 -->
</div>
<!-- //컨텐츠영역 -->
</body>
</html>