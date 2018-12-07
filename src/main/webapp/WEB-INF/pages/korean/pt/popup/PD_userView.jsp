<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>회원정보</title>
<op:jsTag type="openworks" items="web-core"/>

<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
<script type="text/javascript">

  $( window ).load(function() {
    var height = $("#pop_wrap").height() + 70;
    parent.$.fn.colorbox.resize({height:height+"px"})  
    
  });

  var jsClose = function(){
    parent.$.fn.colorbox.close();
  };
  
</script>


</head>
<body>
    <!-- 컨텐츠영역 -->
    <div id="pop_wrap">
        <div class="pop_container">
        
            <!-- popup header -->
            <div class="header">
                <h1>
                  <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">
                    개인
                  </c:if>
                  <c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">
                    기업
                  </c:if> 
                  회원정보
                </h1>
            </div>
            <!-- //header -->
            
            
            <!-- popup content -->
            <div class="section">
              <table class="tbl_pop">
              <colgroup>
                <col style="width:25%;">
                <col>
              </colgroup>
              <tbody>
              <!-- 일반 -->
              <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '3001'}">
              <tr>
                <td class="tit">이름</td>
                <td>${dataVo.userNm}</td>
              </tr>
              <tr>
                <td class="tit">아이디</td>
                <td >${dataVo.userId}</td>
              </tr>
              <%--
              <tr>
                <td class="tit">연락처</td>
                <td >${dataVo.mbtlnum}</td>
              </tr>
              --%>
              <tr>
                <td class="tit">이메일</td>
                <td >${dataVo.email}</td> 
              </tr>
              </c:if> 
              
              <!-- 기업 -->
              <c:if test="${dataVo.userTyCd eq '1002' || dataVo.userTyCd eq '2002' || dataVo.userTyCd eq '3002'}">
              <tr>
                <td class="tit">회사명</td>
                <td>${dataVo.entrprsCmpnyNm}</td>
              </tr>
              <tr>
                <td class="tit">아이디</td>
                <td >${dataVo.userId}</td>
              </tr>
              <tr>
                <td class="tit">회사대표번호</td>
                <td >${dataVo.entrprsCmpnyTelno}</td>
              </tr>
              <%-- 
              <tr>
                <td class="tit">담당자 명</td>
                <td >${dataVo.entrprsCmpnyRprsntvNm}</td>
              </tr>
               --%>
              <%--
              <tr>
                <td class="tit">담당자 연락처</td>
                <td >${dataVo.entrprsCmpnyTelno}</td>
              </tr>
              --%>
              <%-- 
              <tr>
                <td class="tit">담당자 이메일</td>
                <td >${dataVo.entrprsCmpnyEmail}</td> 
              </tr>
               --%>
              </c:if>
              
              </tbody>
              </table>
            <!-- //popup content -->      
          
            <div class="btn_area">
                <div class="btn_pop_c">
                  <div class="btn_navi">
                    <a href="#reg" onclick="jsClose();"><span class="gt">확인</span></a>
                  </div>
                </div>
              </div>
            </div>
            
            <a class="w_close" href="#close" onclick="jsClose();">
              <span>닫기</span>
            </a>
           
        </div>
            
            
            
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>

