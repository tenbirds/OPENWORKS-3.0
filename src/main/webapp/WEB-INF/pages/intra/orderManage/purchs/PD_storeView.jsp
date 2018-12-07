<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title></title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">

  $( window ).load(function() {
    var height = $("#popup").height() + 90;
    parent.$.fn.colorbox.resize({height:height+"px"})  
    
  });

  var jsClose = function(){
    parent.$.fn.colorbox.close();
  };
  
</script>


</head>
<body>
    
    <!-- popup header -->
    <div class="header">
        <h1>
          판매자 정보          
        </h1>
    </div>
    <!-- //header -->
    
    <table class="boardWrite" summary="사용자 구분 리스트 입니다.">
      <caption class="hidden"> 목록 </caption>
      <colgroup>
          <col width="20%" />
          <col width="" />
      </colgroup>
      <tbody>
          <tr>
              <th class="tx_c">구분</th>
              <td class="line_r"><c:out value="${dataVo.userTyNm}" /></td>
          </tr>
      </tbody>
    </table>
    
    <br />
    <!-- popup header -->
    <div class="header">
        <h1>
          기본 정보
        </h1>
    </div>
    <!-- //header -->
    <table class="boardWrite" summary="기본정보 리스트입니다.">
      <caption class="hidden"> 목록 </caption>
      <colgroup>
          <col width="20%" />
          <col width="" />
          <col width="20%" />
      </colgroup>
      <tbody>
        <tr>
          <th class="tx_c">아이디</th>
          <td colspan="2" class="line_r"><c:out value="${dataVo.userId}" /></td>
        </tr>
        <tr>
          <th class="tx_c">이름</th>
          <td colspan="2" class="line_r"><c:out value="${dataVo.userNm}" /></td>
        </tr>
        <%-- <tr>
          <th class="tx_c">전화번호</th>
          <td><c:out value="${dataVo.telno}" /></td>
          <th class="tx_c">휴대전화</th>
          <td class="line_r"><c:out value="${dataVo.mbtlnum}" /></td>
        </tr> --%>
        <tr>
          <th class="tx_c">이메일 주소</th>
          <td colspan="2" class="line_r"><c:out value="${dataVo.email}" /></td>
        </tr>
        <%-- <tr>
          <th class="tx_c">주소</th>
          <td colspan="2" class="line_r"><c:out value="${dataVo.bassAdres}" />&nbsp; <c:out value="${dataVo.detailAdres}" /></td>
        </tr> --%>
      </tbody>
    </table>
    
    <br />
    <!-- popup header -->
    <div class="header">
        <h1>
          회사 정보
        </h1>
    </div>
    <!-- //header -->
    <table class="boardWrite" summary="기본정보 리스트입니다.">
      <caption class="hidden"> 목록 </caption>
      <colgroup>
          <col width="20%" />
          <col width="" />
          <col width="20%" />
          <col width="30%" />
      </colgroup>
      <tbody>
        <c:if test="${fn:startsWith(dataVo.userTyCd, '10') && fn:endsWith(dataVo.userTyCd, '01')}">
          <c:set var="userTyCd" value="1000"/>
        </c:if>
        <c:if test="${fn:endsWith(dataVo.userTyCd, '02')}">
          <c:set var="userTyCd" value="2000"/>
        </c:if>
        <c:if test="${fn:startsWith(dataVo.userTyCd, '30') && fn:endsWith(dataVo.userTyCd, '01')}">
          <c:set var="userTyCd" value="3000"/>
        </c:if>
      
        <tr>
          <th class="tx_c">회사명 ${userTyCd}</th>
          <td colspan="3" class="line_r">
          	<c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyNm}" />
            </c:if>
            <c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyNm}" />
            </c:if>
            <c:if test="${userTyCd eq '3000'}">
              <c:out value="${dataVo.pblinsttNm}" />
            </c:if>
          </td>
          <%-- <th class="tx_c">회사대표자이름</th>
          <td class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyRprsntvNm}" />
            </c:if><c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyRprsntvNm}" />
            </c:if>
          </td> --%>
        </tr>
        <tr>
          <th class="tx_c">사업자등록번호</th>
          <td colspan="3" class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlBizrNo}" />
            </c:if>
            <c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsBizrNo}" />
            </c:if>
            <c:if test="${userTyCd eq '3000'}">
              <c:out value="${dataVo.pblinsttBizrNo}" />
            </c:if>
          </td>
        </tr>
        <tr>
          <th class="tx_c">회사대표번호</th>
          <td colspan="3" class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyReprsntTelno}" />
            </c:if><c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyReprsntTelno}" />
            </c:if>
            <c:if test="${userTyCd eq '3000'}">
              <c:out value="${dataVo.pblinsttTelno}" />
            </c:if>
          </td>
          <%-- <th class="tx_c">회사팩스</th>
          <td class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyFxnum}" />
            </c:if><c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyFxnum}" />
            </c:if>
          </td> --%>
        </tr>
        <%-- <tr>
          <th class="tx_c">회사이메일주소</th>
          <td colspan="3" class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyEmail}" />
            </c:if><c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyEmail}" />
            </c:if>
          </td>
        </tr>
        <tr>
          <th class="tx_c">회사URL</th>
          <td colspan="3" class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyUrl}" />
            </c:if><c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyUrl}" />
            </c:if>
          </td>
        </tr>
        <tr>
          <th class="tx_c">회사 주소</th>
          <td colspan="3" class="line_r">
            <c:if test="${userTyCd eq '1000'}">
              <c:out value="${dataVo.indvdlCmpnyBassAdres}" />&nbsp; <c:out value="${dataVo.indvdlCmpnyDetailAdres}" />
            </c:if><c:if test="${userTyCd eq '2000'}">
              <c:out value="${dataVo.entrprsCmpnyBassAdresc}" />&nbsp; <c:out value="${dataVo.entrprsCmpnyDetailAdres}" />
            </c:if>
          </td>
        </tr> --%>
      </tbody>
    </table>
    
    <br />
    <!-- popup header -->
    <div class="header">
        <h1>스토어 정보 </h1>
    </div>
    <!-- //header -->
    <table class="boardWrite" summary="기본정보 리스트입니다.">
      <caption class="hidden"> 목록 </caption>
      <colgroup>
          <col width="20%" />
          <col width="" />
      </colgroup>
      <tbody>
        <tr>
          <th class="tx_c">스토어명</th>
          <td colspan="3" class="line_r"><c:out value="${dataVo.langStoreNm}" /></td>
        </tr>
        <%-- <tr>
          <th class="tx_c">스토어 소개</th>
          <td colspan="3" class="line_r"><c:out value="${dataVo.langStoreIntrcn}" /></td> --%>
        </tr> 
        <tr>
          <th class="tx_c">담당자명</th>
          <td colspan="3" class="line_r"><c:out value="${dataVo.storeChargerNm}" /></td>
        </tr>
        <tr>
          <th class="tx_c">담당자 연락처</th>
          <td colspan="3" class="line_r"><c:out value="${dataVo.reprsntTelno}" /></td>
        </tr>
        <tr>
        <%-- <th class="tx_c">담당자 이메일</th>
        <td colspan="3" class="line_r"><c:out value="${dataVo.reprsntEmail}" /></td> --%>
      </tr>
      </tbody>
    </table>
    
     <!-- //리스트 -->
     <p class="tx_c mar_t20">
         <a href="#"><button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button></a>
     </p>
    
     
</body>
</html>

