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
    <!-- 컨텐츠영역 -->
    <div id="popup">
    
    <!-- popup header -->
    <div class="header">
        <h1>
          <%-- <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">
            개인
          </c:if>
          <c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">
            기업
          </c:if> 
          <c:if test="${dataVo.userTyCd eq '3001' || dataVo.userTyCd eq '3002'}">
            공공기업
          </c:if>  --%>
            ${dataVo.userTyNm}&nbsp;정보
        </h1>
    </div>
    <!-- //header -->
    
     <!-- 리스트 -->
     <table class="boardWrite" summary="게시판 리스트입니다.">
         <caption class="hidden"> 목록 </caption>
         <colgroup>
             <col width="30%" />
             <col width="" />
         </colgroup>         
         <tbody>
         <!-- 일반 -->
         <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '3001'}">
         <tr>
           <th class="tx_c">이름</th>
           <td class="line_r">${dataVo.userNm}</td>
         </tr>
         <tr>
           <th class="tx_c">아이디</th>
           <td class="line_r">${dataVo.userId}</td>
         </tr>
         <tr>
           <th class="tx_c">연락처</th>
           <td class="line_r">${dataVo.mbtlnum}</td>
         </tr>
         <tr>
           <th class="tx_c">이메일</th>
           <td class="line_r">${dataVo.email}</td> 
         </tr>
         </c:if> 
         
         <!-- 기업 -->
         <c:if test="${dataVo.userTyCd eq '1002' || dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002' || dataVo.userTyCd eq '3002'}">
         <tr>
           <th class="tx_c">회사명</th>
           <td class="line_r">${dataVo.entrprsCmpnyNm}</td>
         </tr>
         <tr>
           <th class="tx_c">아이디</th>
           <td class="line_r">${dataVo.userId}</td>
         </tr>
         <%-- <tr>
           <th class="tx_c">회사대표번호</th>
           <td class="line_r">${dataVo.entrprsCmpnyReprsntTelno}</td>
         </tr --%>
         <tr>
           <th class="tx_c">담당자 명</th>
           <td class="line_r">${dataVo.userNm}</td>
         </tr>
         <tr>
           <th class="tx_c">담당자 연락처</th>
           <td class="line_r">${dataVo.mbtlnum}</td>
         </tr>
         <tr>
           <th class="tx_c">담당자 이메일</th>
           <td class="line_r">${dataVo.email}</td> 
         </tr>
         
         </c:if>
         </tbody>
     </table>
     <!-- //리스트 -->
     <p class="tx_c mar_t20">
         <a href="#"><button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button></a>
     </p>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>

