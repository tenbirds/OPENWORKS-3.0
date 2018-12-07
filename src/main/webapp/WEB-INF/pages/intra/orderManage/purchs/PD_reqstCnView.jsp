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
        <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">
          개인
        </c:if>
        <c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">
          기업
        </c:if> 
        신청내용
        </h1>
    </div>
    <!-- //header -->
    
     <!-- 리스트 -->
     <table class="boardList" summary="게시판 리스트입니다.">
         <caption class="hidden"> 목록 </caption>
         <colgroup>
             <col width="30%" />
             <col width="" />
         </colgroup>
         <thead>
             <tr>
                 <th>이름</th>
                 <th class="lr_none">내용</th>
             </tr>
         </thead>
         <tbody>
         <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">
         <tr>
         <td class="tit">이름</td>
           <td>${dataVo.userNm}</td>
         </tr>
         <tr>
           <td class="tit">연락처</td>
           <td>${dataVo.orderMbtlnum}</td>
         </tr>
         <tr>
           <td class="tit">이메일</td>
           <td>${dataVo.orderEmail}</td>
         </tr>
         </c:if>
         <c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">
         <tr>
           <td class="tit">회사명</td>
           <td>${dataVo.entrprsCmpnyNm}</td>
         </tr>
         <tr>
           <td class="tit">회사 대표번호</td>
           <td>${dataVo.orderCmpnyReprsntTelno}</td>
         </tr>
         <tr>
           <td class="tit">담당자 명</td>
           <td>${dataVo.orderChargerNm}</td>
         </tr>
         <tr>
           <td class="tit">담당자 연락처</td>
           <td>${dataVo.orderChargerCttpc}</td>
         </tr>
         <tr>
           <td class="tit">담당자 이메일</td>
           <td>${dataVo.orderChargerEmail}</td>
         </tr>
         </c:if>
         <tr>
           <td class="tit">이용자가<br/>전달한 메시지</td>
           <td>${dataVo.orderDlivMssage}</td>
         </tr>
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

