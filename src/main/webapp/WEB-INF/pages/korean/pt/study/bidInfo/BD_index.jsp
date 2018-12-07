<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<op:jsTag type="spi" items="datepicker" />
<op:jsTag type="openworks" items="ui" />
<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
<script type="text/javascript">
  
  
  var dateFormat = /^(\d{4})\-(\d{2})\-(\d{2}).*$/;
  var dateOrder = "$1-$2-$3"

  $().ready(function () {

    if("${baseVo.sDate}" == ""){
      var nowDt = new Date();
      var endDt = new Date();
      endDt.setDate(endDt.getDate() - 7);
      $('#eDate').val(nowDt.toJSON().replace(dateFormat,dateOrder));
      $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
    }
    
    // 기간,발표일 달력 생성
    $("span#dibPeriod  span a").click(function(){
        var sType = $(this).attr('id');
        var nowDt = new Date();
        var endDt = new Date();
          
        $('#eDate').val(nowDt.toJSON().replace(dateFormat,dateOrder));
        switch(sType){
            case 'd_7D':
                endDt.setDate(endDt.getDate() - 7);
                $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
                break;
            case 'd_15D':
              endDt.setDate(endDt.getDate() - 15);
              $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
                break;
            default:
                break;
        }
    });//ready end
    
    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
    $('#sDate').datepicker({
      dateFormat: 'yy-mm-dd',
      showOn : 'button'
    });
    $('#eDate').datepicker({
      dateFormat: 'yy-mm-dd',
      showOn : 'button'
    });
    
    $("#wait").css("display","block");

    
  });

  //페이지 이동
  var jsMovePage = function(page) {
      var p = 1;
      if(page == 'page') {
          p = $('input[name=page]').val();
      } else {
          p = page;
      }
      $("#dataForm #q_currPage").val(p);
      $("#dataForm").submit();

  };
  
  var jsLoading = function(){
    
    if(!confirm("입찰정보 검색은 상당한 시간이 소요됩니다. 검색하시겠습니까?")){
      return false;
    }
    $(".searchBtn").hide();
    $("#loading-container").show();
    
    return true;
  };
  
  var jsSearch = function(){
    
    var sDate = new $("#sDate").val().split("-");
    var eDate = $("#eDate").val().split("-");
    var sDateObj = new Date(sDate[0], Number(sDate[1])-1, sDate[2]);
    var eDateObj = new Date(eDate[0], Number(eDate[1])-1, eDate[2]);
    var betweenDay = (eDateObj.getTime() - sDateObj.getTime())/1000/60/60/24;
    
    if(betweenDay > 7){
      alert("검색기간은 최대 1주일 까지만 검색 가능합니다.");
      return false;
    }
    
    var path = "ND_search.do" ;
    var searchKey = $(":input:radio[name=searchKey]:checked").val();    
    var params = "params = {";
    
    if(searchKey != undefined && searchKey != '' ){
      <c:if test="${empty baseVo.flag || baseVo.flag eq '1001'}">
        params += "'" + searchKey + "' : '"+ $("#searchVal").val() +"',";
      </c:if>
      <c:if test="${baseVo.flag eq '1002'}">
        params += "'" + searchKey + "' : '"+ $("#searchVal").val() +"',";
      </c:if>
    }
    
    params += "'flag'     :'" + $("#flag").val() + "'," ;
    params += "'dateType' :'" + $("#dateType").val() + "'," ;
    params += "'sDate'    :'" + $("#sDate").val() + "'," ;
    params += "'eDate'    :'" + $("#eDate").val() + "'," ;
    params += "'pblancNm'  :'" + $("#pblancNm").val() + "'" ;
    params += "}" ;
        
    
    post_to_url(path,eval(params),"GET");
    
  };

  var jsClean = function(){
    var params = {
        flag : $("#flag").val()
    }
    post_to_url("BD_index.do",params,"GET");
  };
  
  //Submit 전속 전송  (주소,파라메터,메소드)
  function post_to_url(path, params, method) {
      method = method || "post"; // Post:Get 전송 기본설정은 Post
      
      var form = document.createElement("form");
      form.setAttribute("method", method);
      form.setAttribute("action", path);


      // 예  {"userId":"abcd","mgrId":"abcd"}
      for(var key in params) {
          var hiddenField = document.createElement("input");
          hiddenField.setAttribute("type", "hidden");
          hiddenField.setAttribute("name", key);
          hiddenField.setAttribute("value", params[key]);
   
          form.appendChild(hiddenField);
      }
   
      document.body.appendChild(form);
      form.submit();
  }
  
</script>

<form name="dataForm" id="dataForm" method="get" action="ND_paging.do">
  
  <input type="hidden" id="flag" name="flag" value="${baseVo.flag}" />  
  <input type="hidden" id="orderCode" name="orderCode" value="${baseVo.orderCode}" />
  <input type="hidden" id="demandCode" name="demandCode" value="${baseVo.demandCode}" />
  <input type="hidden" id="contractNum" name="contractNum" value="${baseVo.contractNum}" />
  <input type="hidden" id="demandNum" name="demandNum" value="${baseVo.demandNum}" />
  
      <div class="tab_style mgb">
        <ul>
          <li><a href="BD_index.do?flag=1001" <c:if test="${empty baseVo.flag || baseVo.flag eq '1001'}">class="on"</c:if>>용역입찰정보 검색</a></li>
          <li><a href="BD_index.do?flag=1002" <c:if test="${baseVo.flag eq '1002'}">class="on"</c:if>>계약현황  검색</a></li>
        </ul>
      </div>
      
      
      <!-- 용역 입찰 정보 -->
      <c:if test="${empty baseVo.flag || baseVo.flag eq '1001'}">
        
        <table class="tbl_list_input">
        <caption>
          <strong>용역입찰정보 검색</strong>
          <details>
            <summary>검색유형, 공고명, 공고/개찰일, 기관명 정보를 제공합니다.</summary>
          </details>
        </caption>
        <colgroup>
          <col style="width:18%">
          <col>
        </colgroup>
        <tbody>
        <!--
          <tr>
            <th scope="row">검색유형</th>
            <td>
              <input type="radio" id="sech_type01" name="sech_type"><label for="sech_type01" class="space">입찰공고</label>
              <input type="radio" id="sech_type02" name="sech_type"><label for="sech_type02" class="space">개찰결과</label>
              <input type="radio" id="sech_type03" name="sech_type"><label for="sech_type03">최종낙찰자</label>
            </td>
          </tr>
          -->
          <tr>
            <th scope="row">공고명</th>
            <td>
              <input type="text" id="pblancNm" name="pblancNm" title="공고명 입력" value="${baseVo.pblancNm}" style="width:595px;">
            </td>
          </tr>
          <tr class="pad">
            <th scope="row">공고/개찰일</th>
            <td>
              <div class="sech_txt">검색기간은 공고일자 최대 1주일, 개찰일자 최대 1주일까지 가능</div>
              <div class="select_wr">
                <select id="dateType" name="dateType" title="기간 선택" style="width:100px;">
                  <option value="0" <c:if test="${empty baseVo.dateType || baseVo.dateType eq '0' }"> selected="selected" </c:if>>공고일</option>
                  <option value="1" <c:if test="${baseVo.dateType eq '1' }"> selected="selected" </c:if>>개찰일</option>
                </select>
              </div>              
              <div class="calendar_input">
                  <input type="text" class="input" name="sDate" id="sDate" readonly="readonly" title="시작일 레이어 달력 열림" style="width:118px;"
                  value="${baseVo.sDate}" />
              </div>
              <span class="divide"> ~ </span>
              <div class="calendar_input end">
                  <input type="text" class="input" name="eDate" id="eDate" readonly="readonly" title="종료일 레이어 달력 열림" style="width:118px;"
                  value="${baseVo.eDate}" />
              </div>
              <span id="dibPeriod">
                  <span class="btn_light_gray02"><a href="javascript:" id="d_7D">1주일</a></span>
              </span>
            </td>
          </tr>
          <tr>
            <th scope="row">기관명</th>
            <td>
              <div class="ck">
                <input type="radio" value="orderCode" id="searchKey01" name="searchKey" <c:if test="${empty baseVo.orderCode ||not empty baseVo.orderCode}">checked="checked"</c:if>><label for="searchKey01" class="space">공고기관</label>
                <input type="radio" value="demandCode" id="searchKey02" name="searchKey" <c:if test="${not empty baseVo.demandCode}">checked="checked"</c:if>><label for="searchKey02" class="space">수요기관</label>
              </div>
              <div class="search">
                <input type="text" value="<c:out value='${baseVo.orderCode}' /><c:out value='${baseVo.demandCode}' />" 
                title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal" class="input">
                <!--
                <input type="image" src="/resources/web/theme/default/images/btn/btn_search_03.gif" id="sech" class="btn" name="sech" alt="검색">
                -->
              </div>
              <!--
              <div class="fl_space">
                <input type="checkbox" id="finck" name="finck" value=""><label for="finck">특정 기관만 검색</label>
              </div>
              -->
            </td>
          </tr>
        </tbody>
      </table>
      
      <div class="btn_area">
        <div class="btn_r">
          <div class="btn_navi searchBtn"><a href="javascript:" onclick="if (jsLoading()==true){jsSearch();}; "><span class="find">검색</span></a></div>
          <div class="btn_navi_g"><a href="javascript:" onclick="jsClean();"><span class="init">초기화</span></a></div>
        </div>
      </div>
      
      <!-- 
      
      <table class="tbl_list_input margin">
        <caption>
          <strong>입찰공고번호로 검색</strong>
          <details>
            <summary>입찰공고 정보를 제공합니다.</summary>
          </details>
        </caption>
        <colgroup>
          <col style="width:18%">
          <col>
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">입찰공고번호로 검색</th>
            <td>
              <select id="selected02" name="selected02" title="입찰공고 선택" style="width:100px;">
                <option selected="selected">입찰공고</option>
                <option>개찰결과</option>
                <option>최종낙찰자</option>
              </select>
              <input type="text" id="noti" name="noti" title="입찰공고번호 입력" value="" style="width:185px;">
              <span class="btn_light_gray02 vm"><a href="#">검색</a></span>
            </td>
          </tr>
        </tbody>
      </table>
      
      -->
      
      <div class="sTitle">입찰공고 목록</div>
      <span class="totalcount">
          <op:pagerParam page="param/webListPagerParam.jsp" />
      </span>
      <table class="tbl_list type_A" style="border-top:2px solid #e4e4e4;">
        <caption>
          <strong>자유 게시판</strong>
          <details>
            <summary>업무,공고번호-차수,분류,공고명,공고기간,수요기관,계약방법,입력일시,입찰마감일시 정보를 제공합니다.</summary>
          </details>
        </caption>
        <colgroup>
          <col style="width:7%">
          <col style="width:17%">
          <col style="width:7%">
          <col style="width:*">
          <col style="width:10%">
          <col style="width:10%">
          <col style="width:10%">
          <col style="width:17%">
        </colgroup>
        <thead>
          <tr>
            <th scope="col">업무</th>
            <th scope="col">공고번호-차수</th>
            <th scope="col">분류</th>
            <th scope="col">공고명</th>
            <th scope="col">공고기관</th>
            <th scope="col">수요기관</th>
            <th scope="col">계약방법</th>
            <th scope="col">입력일시<br /><span class="fc_gray">입찰마감일시</span></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${pager.list}" var="baseVo" varStatus="status"> 
            <tr>
              <td><c:out value="${baseVo.obj73}" /></td>
              <td><c:out value="${baseVo.obj49}" />-<c:out value="${baseVo.obj50}" /></td>
              <td><c:out value="${baseVo.obj12}" /></td>
              <td class="t_al">
                <a href='<c:out value="${baseVo.obj10}" />' target="_blank"><c:out value="${baseVo.obj09}" /> </a>
              </td>              
              <td><c:out value="${baseVo.obj37}" /></td>
              <td><c:out value="${baseVo.obj44}" /></td>
              <td><c:out value="${baseVo.obj04}" /></td>
              <td>
                <fmt:parseDate value='${baseVo.obj53}' var='obj53' pattern="yyyyMMddHHmm" scope="page"/>
                <fmt:parseDate value='${baseVo.obj54}' var='obj54' pattern="yyyyMMddHHmm" scope="page"/>
                <fmt:formatDate value="${obj53}" pattern="yyyy-MM-dd HH:mm"/><br />
                <span class="fc_gray"><fmt:formatDate value="${obj54}" pattern="yyyy-MM-dd HH:mm"/></span>
              </td>
            </tr>
          </c:forEach>
          <op:no-data obj="${pager}" colspan="8" />
        </tbody>
      </table>      
      <!-- paging -->
        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
      <!-- //paging -->
      
      
      </c:if>
      <!-- 계약현황 검색 -->
      <c:if test="${baseVo.flag eq '1002'}">
        <table class="tbl_list_input">
        <caption>
          <strong>계약현황 검색</strong>
          <details>
            <summary>계약기관,기관별검색,용역명,계약방법,계약일자,계약구분 제공합니다.</summary>
          </details>
        </caption>
        <colgroup>
          <col style="width:18%">
          <col>
          <col style="width:18%">
          <col style="width:20%">
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">계약건명</th>
            <td colspan="3">
              <input type="text" id="pblancNm" name="pblancNm" title="계약건명 입력" value="${baseVo.pblancNm}" style="width:595px;">
            </td>
          </tr>
          <tr class="pad">
            <th scope="row">계약일자</th>
            <td colspan="3">
              <div class="sech_txt">검색기간은 공고일자 최대 1주일, 개찰일자 최대 1주일까지 가능</div>
              <div class="select_wr">
                <select id="dateType" name="dateType" title="기간 선택" style="width:100px;">
                  <option value="0" <c:if test="${empty baseVo.dateType || baseVo.dateType eq '0' }"> selected="selected" </c:if>>공고일</option>
                  <option value="1" <c:if test="${baseVo.dateType eq '1' }"> selected="selected" </c:if>>개찰일</option>
                </select>
              </div>              
              <div class="calendar_input">
                  <input type="text" class="input" name="sDate" id="sDate" readonly="readonly" title="시작일 레이어 달력 열림" style="width:118px;"
                  value="${baseVo.sDate}" />
              </div>
              <span class="divide"> ~ </span>
              <div class="calendar_input end">
                  <input type="text" class="input" name="eDate" id="eDate" readonly="readonly" title="종료일 레이어 달력 열림" style="width:118px;"
                  value="${baseVo.eDate}" />
              </div>
              <span id="dibPeriod">
                  <span class="btn_light_gray02"><a href="javascript:" id="d_7D">1주일</a></span>                  
              </span>
            </td>
          </tr>
         <!--
          <tr>
            <th scope="row">계약기관</th>
            <td colspan="3">
              <select id="selected" name="selected" title="계약기간 선택" style="width:100px;">
                <option selected="selected">전체</option>
                <option>국가기관</option>
                <option>지방자치단체</option>
                <option>교육기관</option>
                <option>정부투자기관</option>
                <option>임의기관</option>
                <option>공기업</option>
                <option>준정부기관</option>
                <option>기타공공기관</option>
                <option>지방공기업</option>
                <option>기타기관</option>
              </select>
            </td>
          </tr>          
          -->
          <tr>
            <th scope="row">기관별검색</th>
            <td colspan="3">
              <div class="ck">
                <input type="radio" value="contractNum" id="searchKey01" name="searchKey" <c:if test="${empty baseVo.contractNum ||not empty baseVo.contractNum}">checked="checked"</c:if>><label for="searchKey01" class="space">공고기관</label>
                <input type="radio" value="demandNum" id="searchKey02" name="searchKey" <c:if test="${not empty baseVo.demandNum}">checked="checked"</c:if>><label for="searchKey02" class="space">수요기관</label>
              </div>
              <div class="search">
                <input type="text" value="<c:out value='${baseVo.contractNum}' /><c:out value='${baseVo.demandNum}' />" 
                title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal" class="input">  
                <!--
                <input type="image" src="/resources/web/theme/default/images/btn/btn_search_03.gif" id="sech" class="btn" name="sech" alt="검색">
                -->
              </div>
            </td>
          </tr>
          <!--
          <tr>
            <th scope="row">용역명</th>
            <td><input type="text" id="notice" name="notice" title="용역명 입력" value="" style="width:300px;"></td>
            <th scope="row">계약방법</th>
            <td>
              <select id="contract" name="contract" title="계약방법 선택" style="width:100px;">
                <option selected="selected">전체</option>
                <option>일반경쟁</option>
                <option>제한경쟁</option>
                <option>지명경쟁</option>
                <option>수의계약</option>
              </select>
            </td>
          </tr>
          -->
          <!--
          <tr>
            <th scope="row">계약구분</th>
            <td colspan="3">
              <select id="contract_class" name="contract_class" title="계약구분 선택"  style="width:100px;">
                <option selected="selected">전체</option>
                <option>자체계약</option>
                <option>중앙조달계약</option>
              </select>
            </td>
          </tr>
          -->
        </tbody>
      </table>
      
      <div class="btn_area">
        <div class="btn_r">
          <div class="btn_navi searchBtn"><a href="javascript:" onclick="if (jsLoading()==true){jsSearch();}; "><span class="find">검색</span></a></div>
          <div class="btn_navi_g"><a href="javascript:" onclick="jsClean();"><span class="init">초기화</span></a></div>
        </div>
      </div>
      <!--
      <table class="tbl_list_input margin">
        <caption>
          <strong>계약번호 검색, 요청번호 검색, 공고번호 검색</strong>
          <details>
            <summary>계약번호 검색, 요청번호 검색, 공고번호 검색 정보를 제공합니다.</summary>
          </details>
        </caption>
        <colgroup>
          <col style="width:18%">
          <col>
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">계약번호 검색</th>
            <td>
              <input type="text" id="contract01" name="contract01" title="계약번호 입력" value="" style="width:300px;">
              <span class="btn_light_gray02 vm"><a href="#">검색</a></span>
            </td>
          </tr>
          <tr>
            <th scope="row">요청번호 검색</th>
            <td>
              <input type="text" id="contract02" name="contract02" title="요청번호 입력" value="" style="width:300px;">
              <span class="btn_light_gray02 vm"><a href="#">검색</a></span>
            </td>
          </tr>
          <tr>
            <th scope="row">공고번호 검색</th>
            <td>
              <input type="text" id="contract03" name="contract03" title="공고번호 입력" value="" style="width:300px;">
              <span class="btn_light_gray02 vm"><a href="#">검색</a></span>
            </td>
          </tr>
        </tbody>
      </table>
      -->
      
      <div class="sTitle">용역계약 목록</div>
      <span class="totalcount">
        <op:pagerParam page="param/webListPagerParam.jsp" />
      </span>
      <table class="tbl_list type_A" style="border-top:2px solid #e4e4e4;">
        <caption>
          <strong>자유 게시판</strong>
          <details>
            <summary>계약번호,용역명,계약금액,계약일자,계약기간,계약기관,수요기관 정보를 제공합니다.</summary>
          </details>
        </caption>
        <colgroup>
          <col style="width:12%">
          <col style="width:18%">
          <col style="width:14%">
          <col style="width:12%">
          <col style="width:*">
          <col style="width:11%">
          <col style="width:11%">
        </colgroup>
        <thead>
          <tr>
            <th scope="col">계약번호</th>
            <th scope="col">계약건명</th>
            <th scope="col">계약금액</th>
            <th scope="col">계약일자</th>
            <th scope="col">계약기간</th>
            <th scope="col">계약기관</th>
            <th scope="col">수요기관</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${pager.list}" var="baseVo" varStatus="status"> 
            <tr>
              <td><c:out value="${baseVo.obj108}" /></td>
              <td class="t_al">
                <a href='<c:out value="${baseVo.obj98}" />' target="_blank"><c:out value="${baseVo.obj78}" /> </a>
              </td>
              <td><fmt:formatNumber value="${baseVo.obj107}" groupingUsed="true"/></td>
                <fmt:parseDate value='${baseVo.obj89}' var='obj89' pattern="yyyyMMdd" scope="page"/>
              <td><fmt:formatDate value="${obj89}" pattern="yyyy-MM-dd"/><br /></td>
              <td><fmt:formatDate value="${obj89}" pattern="yyyy-MM-dd"/><br /> ~ <c:out value="${baseVo.obj80}" /></td>
              <td><c:out value="${baseVo.obj85}" /></td>
              <td><c:out value="${baseVo.obj44}" /></td>
            </tr>
          </c:forEach>
          <op:no-data obj="${pager}" colspan="7" />
        </tbody>
      </table>
      <!-- paging -->
      <div class="paging">
        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
      </div>
      
      </c:if>
      
      <div id="loading-container" class="loading-container">
        <img src="/resources/openworks/theme/default/images/loading/loading34.gif" alt="로딩중"/>
      </div>

      
            
</form>
