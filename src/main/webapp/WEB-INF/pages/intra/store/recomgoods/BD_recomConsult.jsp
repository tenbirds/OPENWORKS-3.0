<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>추천서비스 관리</title>
<op:jsTag type="openworks" items="ui, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
	var ctgryCd1 = "${param.q_ctgryCd1}";
	var ctgryCd2 = "${param.q_ctgryCd2}";
	var ctgryCd3 = "${param.q_ctgryCd3}";

    $().ready(function () {
        var option = {
                tabContainer : "tabContainer"
        };

        tabs = $("#tabDiv").jsTabUi(option);

        $("#infoTab4 a").trigger("click");

        if ($("#q_sortName").val() == '') {
            $("#sort1").css("font-weight", "bold");
        } else {
            $("#sort" + $("#q_sortName").val()).css("font-weight", "bold");
        }

        jsCtgryList(1,null);

        //최초에 값이 존재 하는지 찾는다.. 없으면 패스!!
        <c:if test="${not empty param.q_goodsTyCd}">
            jsCtgryList(1,null);
        </c:if>

        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
	        // 기간,발표일 달력 생성
	        if($('#q_beginDate').val() == ''){
	            var beginDate = new Date();
	            beginDate.setMonth(beginDate.getMonth() - 1);
	            $('#q_beginDate').val(getDateStr(getCalDate(new Date(),-1,0)));
	        }
	        if($('#q_endDate').val() == ''){
	            $('#q_endDate').val(getDateStr(new Date()));
	        }
        }

        $("span#registPeriod  a  button.gray").click(function(){
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;

            if ($("#q_endDate").val()==''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
            switch(sType){
                case '0' :
                    q_beginDate = new Date();
                    $('#q_beginDate').val(getDateStr(q_beginDate));
                    q_endDate = new Date();
                    $('#q_endDate').val(getDateStr(q_endDate));
                    break;
                case '7D':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),0,-7);
                    break;
                case '1M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-1,0);
                    break;
                case '3M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-3,0);
                    break;
                default:
                    $("#q_beginDate").val("2000-01-01");
                    $("#q_endDate").val("2100-12-31");
                    break;
            }

            $('#q_beginDate').val(getDateStr(q_beginDate));

            if($('#q_endDate').val() == ''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

        // select 박스 선택 값 설정
//         jsSelected("q_searchKey", "${param.q_searchKey}");

    });//ready end
    <!-- 기능별 스크립트 정의 -->

    var getCalDate = function(date, months, days){
	    var newDate = date;
	    if(typeof(date.getDate) != 'function'){
	        newDate = new Date();
	    }

	    newDate.setMonth(newDate.getMonth() + months);
	    newDate.setDate(newDate.getDate() + days);

	    return newDate;

	};

	var getDateStr = function(date){
	    return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
	};

    var set2Str = function(vl){
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };

    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };

    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "BD_goodsDetail.do";
        document.dataForm.submit();
    };

    var jsSearch = function(){
        document.dataForm.action = "BD_recomConsult.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
        document.dataForm.submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");

        $("#q_ctgryCd1").val("");
        $("#q_ctgryCd2").val("");
        $("#q_ctgryCd3").val("");

        $('input[name="q_langCodes"]:checked').each(function (i) {
            $(this).attr("checked",false);
        });

    };

    var jsCtgryList = function(el ,vl){


	    var url = "ND_ctgryList.do?";
	    url+= "goodsTyCd=" + $("#q_goodsTyCd").val();
	    url+= "&ctgryCd=" + vl;
	    url+= "&ctgryDp=" + el;

	    //선택값초기화
	    var innerHtml = '<option value="">선택</option>';
	    switch(el){
	        case 1 : $("#q_ctgryCd1,#q_ctgryCd2,#q_ctgryCd3").html("").append(innerHtml).attr("disabled",true);
	        case 2 : $("#q_ctgryCd2,#q_ctgryCd3").html("").append(innerHtml).attr("disabled",true);
	        default : break;
	    }

	    if(vl == ""){return;}


	    $.post(url ,
	    function(response){
	        if(response.length > 0){
	            var innerHtml2 = '';
	            $("#q_ctgryCd"+el).attr("disabled",false);
	            for (var i = 0; i < response.length; i++) {
	                innerHtml2 += '<option value="'+response[i].ctgryCd+'">'+response[i].ctgryNm+'</option>';
	            }
	            $("#q_ctgryCd"+el).append(innerHtml2);
	        }

	        switch(el){
	        case 1 :
	            if($("#q_ctgryCd1 option").length > 1){
	                $("#q_ctgryCd1").attr("disabled",false).val(ctgryCd1).attr("selected", "selected").trigger("change"); ctgryCd1 = "";
	            }
	        case 2 :
	            if($("#q_ctgryCd2 option").length > 1){
	                $("#q_ctgryCd2").attr("disabled",false).val(ctgryCd2).attr("selected", "selected").trigger("change"); ctgryCd2 = "";
	            }
	        case 3 :
	            if($("#q_ctgryCd3 option").length > 1){
	                $("#q_ctgryCd3").attr("disabled",false).val(ctgryCd3).attr("selected", "selected"); ctgryCd3 = "";
	            }
	        default : break;
	        }

	    });

	};

    var jsRecom = function(lc, ty, inputNm) {
//         var url = "ND_recomInsertAction.do";
        var goodsCodes = new Array();
        var recomGoodsCodes1 = new Array();
        var tyMsg;
        var lang = $("#q_langCodes").val();

        $("input[name=goodsCodes]:checked").each(function (i) {
            goodsCodes[i] = $(this).val();
        });

        $("input[name=recomGoodsCodes1]").each(function (i) {
            recomGoodsCodes1[i] = $(this).val();
        });

        if(goodsCodes.length == 0) {
            jsWarningBox("대상 항목을 1개 이상 선택하세요.");
            return false;
        } else {
            switch(ty){
            case 1001 :
                tyMsg = "표준프레임워크호환 서비스";
                break;
               case 1002 :
                   tyMsg = "추천 솔루션/서비스";
                   break;
               case 1003 :
                   tyMsg = "추천 IT전문가서비스";
                   break;
            }

            if(confirm("선택한 " + goodsCodes.length + "개의 항목을 [ " + tyMsg + " ] 하시겠습니까?")){
                jQuery.ajaxSettings.traditional = true;
                if (inputNm == "recomGoodsCodes1") {
	                $.ajax({
	                    url     : "ND_recomInsertAction.do",
	                    type    : "POST",
	                    data : { goodsCodes : goodsCodes, recomendLcSeCd : lc, recomendSeCd : ty, langCode : lang, recomGoodsCodes1 : recomGoodsCodes1 },
	                    dataType: "json",
	                    success : function(result) {
	                        if (result.result) {
	                            jsSuccessBox(result.message);
	                            $("input[name=goodsCodes]:checked").each(function (i) {
                                    $("#"+inputNm).append("<input type=\"hidden\" name=\"" + inputNm + "\" value=\"" + this.value + "\"/>");
                                });
                                $("#dataForm").submit();
	                        } else {
	                            jsWarningBox(result.message);
	                        }
// 	                        self.location.reload();
	                    }
	               });
                }
            }
        }
    };

    var jsRecomDelete = function(inputNm) {
        $("input[name=goodsCodes1]:checked").each(function (i) {
            $("input[name=" + inputNm + "][value=" + this.value + "]").remove();
        });
        $("#dataForm").submit();
     };

     var jsApply = function(lc, ty, inputNm) {
         //  var url = "ND_recomInsertAction.do";
             var recomGoodsCodes1 = new Array();
             var priort1 = new Array();
             var appnDt1 = new Array();
             var lang = $("#q_langCodes").val();

             $("input[name=recomGoodsCodes1][value!=NONE]").each(function (i) {
                 recomGoodsCodes1[i] = $(this).val();
             });

             $("select[name=priort1]").each(function (i) {
             	priort1[i] = $(this).val();
             });

             $("input[name=appnDt1]").each(function (i) {
                 appnDt1[i] = $(this).val();
             });

             if(confirm("추천 IT전문가 서비스를 적용 하시겠습니까?")){
                jQuery.ajaxSettings.traditional = true;
                if (inputNm == "recomGoodsCodes1") {
                    $.ajax({
                        url     : "ND_recomInsertApply.do",
                        type    : "POST",
                        data : { goodsCodes : recomGoodsCodes1, recomendLcSeCd : lc, recomendSeCd : ty, langCode : lang, priorts : priort1, appnDts : appnDt1 },
                        dataType: "json",
                        success : function(result) {
                            if (result.result) {
                                jsSuccessBox(result.message);
                            } else {
                                jsWarningBox(result.message);
                            }
                            self.location.reload();
                        }
                   });
                }
             }
     };

     var jsLangChange = function (langCode) {
         $("#q_init").val("0");
         self.location.href = "BD_recomConsult.do?q_langCodes="+langCode;
     };

     var jsSelectSort = function(num)  {
         $("#q_currPage").val("1");
         $("#q_init").val("0");
         $("#q_sortName").val(num);
         $("#dataForm").submit();
     };

     var jsTab = function (url) {
         //$("#q_init").val("0");
         self.location.href = url;
     };

     var jsStoreView = function(el,id){
         $(el).colorbox({
             title : "판매자 정보",
             href  : "/intra/orderManage/purchs/PD_storeView.do?userId=" + id,
             width : "700",
             height: "600",
             iframe: true
         });
      };

      var jsStoreView = function(el,id){
          $(el).colorbox({
              title : "판매자 정보",
              href  : "/intra/orderManage/purchs/PD_storeView.do?userId=" + id,
              width : "700",
              height: "600",
              iframe: true
          });
       };
</script>


</script>
</head>
<body>
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm">
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}" />
            <input type="hidden" name="goodsCode" id="goodsCode" value="" />

            <span id="recomGoodsCodes1">
                <input type="hidden" name="recomGoodsCodes1" value="NONE"/>
            </span>

            <div id="tabDiv">
            <ul style="margin-bottom: 0px;">
                <li id="infoTab1" style="width:200px;"><a href="javascript:;" onclick="jsTab('BD_index.do');"><span>메인 추천서비스</span></a></li>
                <li id="infoTab2" style="width:200px;"><a href="javascript:;" onclick="jsTab('BD_recomPremium.do');"><span>표준프레임워크호환 추천서비스</span></a></li>
                <li id="infoTab3" style="width:200px;"><a href="javascript:;" onclick="jsTab('BD_recomSolution.do');"><span>솔루션/서비스 추천서비스</span></a></li>
                <li id="infoTab4" style="width:200px;"><a href="javascript:;"><span>IT전문가서비스 추천서비스</span></a></li>
            </ul>
            </div>

            <div class="mar_t10">
                <h4>언어선택</h4>
                <span>
                <select name="q_langCodes" id="q_langCodes" onchange="jsLangChange(this.value);">
                <c:forEach items="${codeList}" var="_code" varStatus="status">
                <option value="${_code.langCode}" ${param.q_langCodes eq _code.langCode ? 'selected' : ''}>${_code.langNm}</option>
                </c:forEach>
                </select>
                </span>
            </div>
            <div class="mar_t20">
            <h4>IT전문가 서비스 추천서비스 (최대 10개)</h4>
            <table class="boardList" cellspacing="0" border="0" summary="IT전문가 서비스 추천서비스">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="3%"/>
                <col width="6%"/>
                <col width="10%"/>
                <col width=""/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="10%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="10%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>선택</th>
                    <th>순서</th>
                    <th>서비스코드</th>
                    <th>서비스명</th>
                    <th>조회수</th>
                    <th>문의건수</th>
                    <th>신청 수<br />(다운로드 수)</th>
                    <th>평점</th>
                    <th>리뷰 수</th>
                    <th>상점명<br />(판매자ID)</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="index" value="${recomSubC.indexNo}"/>
                <c:forEach items="${recomSubC.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="goodsCodes1" value="${baseVo.goodsCode}"/>
                        <input type="hidden" name="recomGoodsCodes1" value="${baseVo.goodsCode}"/>
                        </td>
                        <td>
	                        <select name="priort1">
	                            <option value="1" <c:if test="${baseVo.priort eq 1}" >selected</c:if>>1</option>
	                            <option value="2" <c:if test="${baseVo.priort eq 2}" >selected</c:if>>2</option>
	                            <option value="3" <c:if test="${baseVo.priort eq 3}" >selected</c:if>>3</option>
	                            <option value="4" <c:if test="${baseVo.priort eq 4}" >selected</c:if>>4</option>
	                            <option value="5" <c:if test="${baseVo.priort eq 5}" >selected</c:if>>5</option>
	                            <option value="6" <c:if test="${baseVo.priort eq 6}" >selected</c:if>>6</option>
	                            <option value="7" <c:if test="${baseVo.priort eq 7}" >selected</c:if>>7</option>
	                            <option value="8" <c:if test="${baseVo.priort eq 8}" >selected</c:if>>8</option>
	                            <option value="9" <c:if test="${baseVo.priort eq 9}" >selected</c:if>>9</option>
	                            <option value="10" <c:if test="${baseVo.priort eq 10}" >selected</c:if>>10</option>
                        	</select>
                       	</td>
                        <td>
                            ${baseVo.goodsCode}
                        </td>
                        <td>
                            <div class="tx_l">
                                <a href='http://<%=GlobalConfig.DOMAIN_SUBNM %>/${baseVo.subDomain}/pt/store/inc/BD_storeView.do?goodsCode=${baseVo.goodsCode}' target="_blank" >${baseVo.goodsNm}</a>
                            </div>
                        </td>
                        <td>
                            ${baseVo.goodsRdcnt }
                        </td>
                        <td>
                            ${baseVo.inqrCnt }
                        </td>
                        <td>
                            ${baseVo.sellCnt }
                        </td>
                        <td>
                            ${baseVo.evlScore }
                        </td>
                        <td>
                            ${baseVo.reviewCnt }
                        </td>
                        <td><a href="javascript:;" onclick="jsStoreView(this,'${baseVo.userId}');">${baseVo.langStoreNm}<br />(${baseVo.userId})</a></td>
                        <td><input type="hidden" name="appnDt1" value="${baseVo.appnDt}"/>${baseVo.appnDt}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${recomSubC}" colspan="10" />
            </tbody>
            </table>
            <div><button type="button" class="blue mar_t5" onclick="jsRecomDelete('recomGoodsCodes1');">IT전문가 서비스 추천서비스 해제</button>
                 <button type="button" class="blue mar_t5 float_r" onclick="jsApply(1002, 1003, 'recomGoodsCodes1');">추천 IT전문가 서비스 적용</button>
            </div>
            </div>

            <div class="mar_t20"><h4>서비스검색</h4></div>
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="400" />
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>카테고리</th>
                                <td colspan="3">
                                    <op:code id="q_goodsTyCd" grpCd="1005" ctgCd="CNSLTCD" defaultValues="1003" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                    <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" disabled="disabled" onchange="jsCtgryList(2,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                    <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" disabled="disabled" onchange="jsCtgryList(3,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                    <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" disabled="disabled">
                                        <option value="">선택</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td colspan="3">
                                    <input class="w120" type="text" name="q_beginDate" id="q_beginDate" title="시작날짜선택" <c:if test="${not empty param.q_beginDate}"> value="${param.q_beginDate}"</c:if>/> ~
                                    <input class="w120" type="text" name="q_endDate" id="q_endDate" title="종료날짜선택"<c:if test="${not empty param.q_endDate}"> value="${param.q_endDate}"</c:if>/>
                                    <span class="mar_l10" id="registPeriod">
                                        <a href="javascript:;"><button type="button" id="0"   class="gray">오늘</button></a>
                                        <a href="javascript:;"><button type="button" id="7D"   class="gray">일주일</button></a>
                                        <a href="javascript:;"><button type="button" id="1M"   class="gray">1개월</button></a>
                                        <a href="javascript:;"><button type="button" id="3M"   class="gray">3개월</button></a>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>상세검색</th>
                                <td colspan="3">
                                    <select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요">
                                        <option value="1001">  서비스명</option>
                                        <option value="1002">스토어명</option>
                                        <option value="1003">판매자ID</option>
                                        <option value="1004">서비스코드</option>
                                    </select>
                                    <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
                                </td>
                            </tr>
                        </tbody>
                    </table>
	                <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;

	                <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>

                </fieldset>
            </div>

        <!-- //검색 -->

        <div class="mar_t10">
            정렬 : <a href="javascript:;" id="sort1" onclick="jsSelectSort('1');">조회수</a> |
                   <a href="javascript:;" id="sort2" onclick="jsSelectSort('2');">문의건수</a> |
                   <a href="javascript:;" id="sort3" onclick="jsSelectSort('3');">다운로드 수</a> |
                   <a href="javascript:;" id="sort4" onclick="jsSelectSort('4');">평점</a> |
                   <a href="javascript:;" id="sort5" onclick="jsSelectSort('5');">리뷰</a>
        </div>
            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="" />

        <!-- 리스트 -->
<!--         <form name="dataForm2" id="dataForm2" method="post"> -->
            <table class="boardList" cellspacing="0" border="0" summary="IT전문가 서비스">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="3%"/>
                <col width="10%"/>
                <col width="7%"/>
                <col width=""/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="10%"/>
                <col width="5%"/>
                <col width="10%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>선택</th>
                    <th>구분</th>
                    <th>서비스코드</th>
                    <th>서비스명</th>
                    <th>조회수</th>
                    <th>문의건수</th>
                    <th>신청 수<br />(다운로드 수)</th>
                    <th>평점</th>
                    <th>리뷰 수</th>
                    <th>상점명<br />(판매자ID)</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td><input type="checkbox" name="goodsCodes" value="${baseVo.goodsCode}"/></td>
                        <td>
                            <p>
                                <c:forEach items="${baseVo.goodsType}" var="_goodsType" varStatus="status">
                                    ${_goodsType.GOODSTYNM}
                                    <c:if test="${ not status.last }"><br /></c:if>
                                </c:forEach>
                            </p>
                        </td>
                        <td>
                            ${baseVo.goodsCode}
                        </td>

                        <td>
                            <div class="tx_l">
                                <a href='http://<%=GlobalConfig.DOMAIN_SUBNM %>/${baseVo.subDomain}/pt/store/inc/BD_storeView.do?goodsCode=${baseVo.goodsCode}' target="_blank">${baseVo.goodsNm}</a>
                            </div>
                        </td>
                        <td>
                            ${baseVo.goodsRdcnt }
                        </td>
                        <td>
                            ${baseVo.inqrCnt }
                        </td>
                        <td>
                            ${baseVo.sellCnt }
                        </td>
                        <td>
                            ${baseVo.evlScore }
                        </td>
                        <td>
                            ${baseVo.reviewCnt }
                        </td>
                        <td><a href="javascript:;" onclick="jsStoreView(this,'${baseVo.userId}');">${baseVo.langStoreNm}<br />(${baseVo.userId})</a></td>
                        <td>${baseVo.registDt}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="12" />
            </tbody>
            </table>
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

        <!-- 버튼 -->
        <div>
	        <div class="tx_c">
	             <a href="javascript:;" onclick="jsRecom(1002, 1003, 'recomGoodsCodes1');"><button class="w_blue mar_l10" type="button">선택항목 추천 IT전문가 서비스</button></a>
	        </div>
        </div>
        <!--  //버튼 -->
    </form>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>