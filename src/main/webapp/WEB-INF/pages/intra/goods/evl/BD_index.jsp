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
<title>서비스평관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">

//<![CDATA[

var ctgryCd1 = "<c:out value='${searchMap.q_ctgryCd1}' />";
var ctgryCd2 = "<c:out value='${searchMap.q_ctgryCd2}' />";
var ctgryCd3 = "<c:out value='${searchMap.q_ctgryCd3}' />";

    $().ready(function () {
        

        
        //최초에 값이 존재 하는지 찾는다.. 없으면 패스!!
        <c:if test="${not empty searchMap.q_goodsTyCd}">
            jsCtgryList(1,null);
        </c:if> 
        
        $("#chk-all").click(function(){
          var isChecked = this.checked;
          $("input[name=goodsEvlSeqs]").each(function() {
              this.checked = isChecked;
          });
        });$('input[name="goodsEvlSeqs"]').click(function() {
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
            
            if ($("#q_endDate").val()==''){
                $('#q_endDate').val(getDateStr(new Date()));                     
            }
            if (! $("#q_endDate").dateValidator()) {
                alert("종료날짜가 형식에 맞지 않습니다.");
                return false;
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
            document.dataForm.elements["q_init"].value = "0"; 
            
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
        
        /* 2016.07.26 수정 */
        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            $("#q_beginDate").val("");
            $("#q_endDate").val("");
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
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDate").val("2000-01-01");
        $("#q_endDate").val("2100-12-31");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");

        $("#q_ctgryCd1").val("");
        $("#q_ctgryCd2").val("");
        $("#q_ctgryCd3").val("");

        $('input[name="q_langCodes"]:checked').each(function (i) {
            $(this).attr("checked",false);
        });
        document.dataForm.elements["q_init"].value = ""; /* 2016.07.26 수정 */
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
   
    var jsUserView = function(el,id){
      $(el).colorbox({
          title : "사용자 정보",
          href  : "/intra/orderManage/purchs/PD_userView.do?userId=" + id,
          width : "500",
          height: "450",
          iframe: true
      });
    };
  
  
  /**
   * 목록 삭제
   */
  var jsDeleteList = function(){
      var url = "ND_deleteAction.do?";
      var goodsEvlSeqs = new Array();
      $("input[name=goodsEvlSeqs]:checked").each(function (i) {

          var strObj = $(this).val().split(',');
          goodsEvlSeqs[i] = strObj[0];
          
          url += "goodsEvlSeqs=" + strObj[0]  + "&" ;
      });
      
      if(goodsEvlSeqs.length == 0){
          jsWarningBox("삭제 대상 문의를 1개 이상 선택하세요.");
          return false;
      }else{
          if(confirm("선택한 " + goodsEvlSeqs.length + "개의 문의를 정말 삭제하시겠습니까?")){
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
  
  var jsSourceDwon = function(filePath){
    location.href = "/component/file/ND_directDownload.do?fn=BD_index.jsp&fp=" + filePath;
  };
  

//]]>
</script>
</head>
<boyd>
    <div id="contents">
        
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
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
                                <tr>
                                    <th>카테고리</th>
                                    <td colspan="3">
                                        <op:code id="q_goodsTyCd" grpCd="1005" defaultValues="${searchMap.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                        <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1"disabled="disabled" onchange="jsCtgryList(2,this.value)" class="over">
                                            <option value="">선택</option>
                                        </select>
                                        <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" disabled="disabled" onchange="jsCtgryList(3,this.value)" class="over">
                                            <option value="">선택</option>
                                        </select>
                                        <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" disabled="disabled" class="over">
                                            <option value="">선택</option>
                                        </select>
                                    </td>
                                </tr>
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
                                    <th>등록일</th>
                                    <td colspan="3">
                                        <input class="w120" type="text" name="q_beginDate" id="q_beginDate" readonly="readonly" title="시작날짜선택" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if>/> ~
                                        <input class="w120" type="text" name="q_endDate" id="q_endDate" readonly="readonly" title="종료날짜선택"<c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if>/>
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
                                        <option value="1001" <c:if test="${searchMap.q_searchKey == '1001'}">selected="selected"</c:if> >서비스명</option>
                                        <option value="1002" <c:if test="${searchMap.q_searchKey == '1002'}">selected="selected"</c:if> >작성자</option>
                                        <option value="1003" <c:if test="${searchMap.q_searchKey == '1003'}">selected="selected"</c:if> >평가글</option>
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
            
            <op:pagerParam title="구매/신청 목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
         <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
           <caption class="hidden"> 목록 </caption> 
            <colgroup>
                <col width="5%"/>
                <col width="5%"/>
                <col width="12%"/>
                <col width="20%"/>
                <col width="8%"/>
                <col width="6%"/>
                <col width=""/>
                <col width="10%"/>
                <col width="12%"/>
            </colgroup>
            <thead>
                <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                <th>번호</th>
                <th>구분</th>
                <th>서비스명</th>
                <th>언어</th>
                <th>평점</th>
                <th>평가글</th>
                <th>작성자</th>
                <th class="lr_none">작성일자</th>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                   <tr>
                     <td><input type="checkbox" name="goodsEvlSeqs" value="${baseVo.goodsEvlSeq}"/></td>
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
                     <td>
                       <span><c:out value="${baseVo.evlScore}" />.0</span>
                     </td>
                     <td>
                       <div class="tx_l">
                         <a href="#" onclick="jsGoodsView('<c:out value="${baseVo.goodsCode}" />','C','<c:out value="${baseVo.langCode}" />');"><span><c:out value="${baseVo.evlSntnc}" /></span></a>                         
                       </div>
                     </td>
                     <td>
                       <a href="#" onclick="jsUserView(this,'<c:out value="${baseVo.registId}" />');"><span><c:out value="${baseVo.registNm}" /></span></a><br/>
                       <span>(<c:out value="${baseVo.registId}" />)</span><br/>
                     </td>
                     <td>
                       <span><c:out value="${baseVo.registDt}" /></span>
                     </td>
                   </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        
        
        <!-- //페이징 -->
        <div class="tx_r">
            <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
        </div>
        
    </div>
</boyd>

</html>