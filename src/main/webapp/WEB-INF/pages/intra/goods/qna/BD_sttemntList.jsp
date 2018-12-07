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
<title>서비스문의 신고관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">
//<![CDATA[

    $().ready(function () {

        //최초에 값이 존재 하는지 찾는다.. 없으면 패스!!
        <c:if test="${not empty searchMap.q_goodsTyCd}">
            jsCtgryList(1,null);
        </c:if> 

        $("#chk-all").click(function(){
          var isChecked = this.checked;
          $("input[name=goodsInqryNos]").each(function() {
              this.checked = isChecked;
          });
        });$('input[name="goodsInqryNos"]').click(function() {
          if(!$(this).is(':checked')) {
            $("#chk-all").attr("checked",false);
          }
        });

        
        $("#langCodes").click(function(){
            if($(this).is(":checked")){
                $('input[name="q_langCodes"]:checked').each(function (i) {
                    $(this).attr("checked",false);
                });
            } 
        });$('input[name="q_langCodes"]').click(function() {
            if($(this).is(':checked')) {
                $("#langCodes").attr("checked",false);
            }
        });

        // 기간,발표일 달력 생성
        $("span#pruchsPeriod  a  button.gray").click(function(){
            /* 2016.07.26 수정 */
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;

            if ($("#q_endDateAcc").val()==''){
                $('#q_endDateAcc').val(getDateStr(new Date()));
            }
            if (! $("#q_endDateAcc").dateValidator()) {
                alert("종료날짜가 형식에 맞지 않습니다.");
                return false;
            }
            switch(sType){
                case '0' :
                    q_beginDate = new Date();
                    $('#q_beginDateAcc').val(getDateStr(q_beginDate));
                    q_endDate = new Date();
                    $('#q_endDateAcc').val(getDateStr(q_endDate));
                    break;
                case '7D':
                    q_beginDate = getCalDate(new Date($("#q_endDateAcc").val()),0,-7);
                    break;
                case '1M':
                    q_beginDate = getCalDate(new Date($("#q_endDateAcc").val()),-1,0);
                    break;
                case '3M':
                    q_beginDate = getCalDate(new Date($("#q_endDateAcc").val()),-3,0);
                    break;
                default:
                    $("#q_beginDateAcc").val("2000-01-01");
                    $("#q_endDateAcc").val("2100-12-31");
                    break;
            }
            $('#q_beginDateAcc').val(getDateStr(q_beginDate));
            document.dataForm.elements["q_init"].value = "0"; 
            
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDateAcc').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDateAcc').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        
        /* 2016.07.26 수정 */
        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            $("#q_beginDateAcc").val("");
            $("#q_endDateAcc").val("");
        }
        
    });//ready end
    
    /* 2016.07.26 수정 */
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

    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero

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
    

    var jsSearch = function(){        
        document.dataForm.action = "BD_sttemntList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDateAcc").val("2000-01-01");
        $("#q_endDateAcc").val("2100-12-31");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");

        $("#q_ctgryCd1").val("");
        $("#q_ctgryCd2").val("");
        $("#q_ctgryCd3").val("");
        $("#q_accuseResnCd").val("");

        $('input[name="q_langCodes"]:checked').each(function (i) {
            $(this).attr("checked",false);
        });
        document.dataForm.elements["q_init"].value = ""; /* 2016.07.26 수정 */
    };


    var jsGoodsView = function(seq,urlNm,lang){
      
      if(lang == "00"){lang = "korean"
      }else if(lang == "01"){lang = "english"
      }else if(lang == "06"){lang = "spanish"
      }      
      var openNewWindow = window.open("about:blank");
      //이전소스
      //openNewWindow.location.href = "http://" + lang + ".ceart.kr/" + lang + "/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm;    
      
      //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
      // 변경소스
      openNewWindow.location.href = "http://<%=GlobalConfig.DOMAIN_SUBNM %>" + "/" + lang + "/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm;   
      //}}
    };
    
    
    
    var jsOrderView = function(el,no){
      $(el).colorbox({
          title : "신청내용정보",
          href  : "PD_reqstCnView.do?purchsNo=" + no,
          width : "500",
          height: "600",
          iframe: true
      });
    };
    
    var jsUserView = function(el,id){
      $(el).colorbox({
          title : "사용자 정보",
          href  : "/intra/orderManage/purchs/PD_userView.do?userId=" + id,
          width : "500",
          height: "450",
          iframe: true
      });
    };
    
    var jsAccuseView = function(el,goodsCode,seq,type){
      
      var para = "goodsCode=" + goodsCode + "&goodsInqryNo=" + seq + "&pageUrlNm=" + "${searchMap.pageUrlNm}" + "&accuseAtCd=" + type;
      $(el).colorbox({
          title : "신고하기",
          href : "/korean/pt/store/inc/PD_accuseView.do?" + para,
          width : "700",
          height: "250",
          iframe: true
      });
    };
    
  
  var jsSourceDwon = function(filePath){
    location.href = "/component/file/ND_directDownload.do?fn=BD_index.jsp&fp=" + filePath;
  };
  
  /**
   * 목록 삭제
   */
  var jsDeleteList = function(){
      var url = "ND_deleteAction.do?";
      var goodsInqryNos = new Array();
      $("input[name=goodsInqryNos]:checked").each(function (i) {

          var strObj = $(this).val().split(',');
          goodsInqryNos[i] = strObj[0];
          
          url += "goodsInqryNos=" + strObj[0]  + "&" ;
      });
      
      if(goodsInqryNos.length == 0){
          jsWarningBox("삭제 대상 신고문의를 1개 이상 선택하세요.");
          return false;
      }else{
          if(confirm("선택한 " + goodsInqryNos.length + "개의 신고문의를 정말 삭제하시겠습니까?")){
              $.post(url,
              function(response){
                  try {
                      if(eval(response)) {
                          jsSuccessBox(Message.msg.deleteOk);
                          self.location.reload();
                      } else {
                          jsErrorBox(Message.msg.processFail);
                      }
                  } catch (e) {
                      jsSysErrorBox(response, e);
                      return;
                  }
              });
          }
      }
  };
  
//]]>
</script>
</head>
<boyd>
    <div id="contents">
        
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_sttemntList.do">
        	<input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>  <!-- 2016.07.26 수정 -->
            <input type="hidden" name="q_seq"     id="q_seq"     value="" />
            <input type="hidden" name="langCodes" id="langCodes" value="" />
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
                            	<%-- 
                                <tr>
                                    <th>서비스언어</th>
                                    <td colspan="3">
                                        <p class="mar_t5" id="langCheck">
                                            <input type="checkbox" name="langCodes" id="langCodes" value=""
                                            <c:if test="${fn:length(searchMap.q_langCodes) == 0}">checked="checked"</c:if> />전체&nbsp;
                                            <c:forEach items="${codeList}" var="_bean" varStatus="status">
                                                <input type="checkbox" name="q_langCodes" id="q_langCode_${_bean.langCode}"
                                                    <c:if test="${fn:contains(searchMap.q_langCodes,_bean.langCode)}">checked="checked"</c:if>
                                                value="${_bean.langCode}"/> ${_bean.langNm}&nbsp;
                                            </c:forEach>
                                        </p>
                                    </td>
                                </tr>
                                 --%>
                                <tr>
                                  <th>신고사유</th>
                                  <td colspan="3">
                                    <select id="q_accuseResnCd" name="q_accuseResnCd" title="신고사유를 선택하세요">
                                      <option value="" >전체</option>
                                      <c:set var="string" value="1" />
                                      <c:forEach items="${codeList_accuseResnCd}" var="_bean" varStatus="status">                                      
                                        <c:if test="${status.first }">
                                          <optgroup label="질문신고"> 
                                        </c:if>
                                        <c:if test="${!(string eq fn:substring(_bean.prvCd,'0','1'))}">
                                          </optgroup> <optgroup label="답변신고"> 
                                        </c:if>
                                        <option value="${_bean.prvCd}" <c:if test="${_bean.prvCd eq searchMap.q_accuseResnCd}">selected="selected"</c:if>>${_bean.prvNm}</option>                                        
                                        <c:if test="${status.last}">
                                          </optgroup> 
                                        </c:if>
                                        <c:set var="string" value="${fn:substring(_bean.prvCd,'0','1')}" />
                                      </c:forEach>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                    <th>신고일자</th>
                                    <td colspan="3">
                                        <input class="w120" type="text" name="q_beginDateAcc" id="q_beginDateAcc" readonly="readonly" title="시작날짜선택" <c:if test="${not empty searchMap.q_beginDateAcc}"> value="${searchMap.q_beginDateAcc}"</c:if>/> ~
                                        <input class="w120" type="text" name="q_endDateAcc" id="q_endDateAcc" readonly="readonly" title="종료날짜선택"<c:if test="${not empty searchMap.q_endDateAcc}"> value="${searchMap.q_endDateAcc}"</c:if>/>
                                        <span class="mar_l10" id="pruchsPeriod">
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
                                      <option value="1001" <c:if test="${searchMap.q_searchKey == '1001'}">selected="selected"</c:if>>서비스명</option>
                                      <option value="1003" <c:if test="${searchMap.q_searchKey == '1003'}">selected="selected"</c:if>>작성자</option>
                                    </select>
                                        <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />" class="w215" title="검색어를 입력하세요." />                                        
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                      <div>
                      <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                      <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                    </div>
                </fieldset>
               
            </div>
            
            <op:pagerParam title="서비스관리신고 목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="5%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width=""/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="12%"/>
            </colgroup>
            <thead>
                <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                <th>번호</th>
                <th>구분</th>
                <th>서비스명</th>
                <th>언어</th>
                <th>문의/답변내용</th>
                <th>작성자</th>
                <th>문의신고자<br />답변신고자</th>
                <th>신고사유</th>
                <th class="lr_none">문의신고일<br />답변신고일</th>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                  <tr>
                    <td><input type="checkbox" name="goodsInqryNos" value="${baseVo.goodsInqryNo}"/></td>
                    <td>${index-status.index}</td>
                    <td>${baseVo.ctgryClNm}</td>
                    <td>
                      <div class="tx_l">
                        <a href="#" onclick="jsGoodsView('<c:out value="${baseVo.goodsCode}" />','','<c:out value="${baseVo.langCode}" />');"><c:out value="${baseVo.goodsNm}" /></a>
                      </div>
                    </td>
                    <td>
                      <span><c:out value="${baseVo.langNm}" /></span>
                    </td>
                    <td class="tx_l"> 
                      <div class="tx_l">
                        <span>Q : <c:out value="${baseVo.inqryCn}" /></span><br/>
                        <span>A : <c:out value="${baseVo.inqryAnswerCn}" /></span>
                      </div>
                    </td>
                    <td>
                      <a href="#" onclick="jsUserView(this,'<c:out value="${baseVo.inqrId}" />');"><span><c:out value="${baseVo.inqrNm}" /></span></a><br/>
                      <span>(<c:out value="${baseVo.inqrId}" />)</span>
                    </td>
                    <td>
                      <a href="#" onclick="jsUserView(this,'<c:out value="${baseVo.inqryAplcntId}" />');"><span><c:out value="${baseVo.inqryAplcntNm}" /></span></a><br/>
                      <a href="#" onclick="jsUserView(this,'<c:out value="${baseVo.answerAplcntId}" />');"><span><c:out value="${baseVo.answerAplcntNm}" /></span></a><br/>                      
                    </td>
                    <td>
                      <c:if test="${not empty baseVo.inqryAccuseResnCd}">
                        <a href="#" onclick="jsAccuseView(this,'<c:out value="${baseVo.goodsCode}" />','<c:out value="${baseVo.goodsInqryNo}" />','1001');"><span>[문의 신고 상세]</span></a>
                      </c:if><br/>
                      <c:if test="${not empty baseVo.answerAccuseResnCd}">
                        <a href="#" onclick="jsAccuseView(this,'<c:out value="${baseVo.goodsCode}" />','<c:out value="${baseVo.goodsInqryNo}" />','1002');"><span>[답변 신고 상세]</span></a>
                      </c:if>
                    </td>
                    <td>
                      <span><c:out value="${baseVo.inqryUpdateDt}" /></span><br/>
                      <span><c:out value="${baseVo.answerUpdateDt}" /></span>
                    </td>
                  </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        
        <div class="tx_r">
          <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
        </div>
        
    </div>
</boyd>

</html>