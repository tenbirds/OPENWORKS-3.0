<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>신청내용</title>
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
  <!-- 팝업 윈도우 크기 width:405px -->
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
          신청내용
       </h1>
      </div>
      <!-- //header -->
      <!-- popup content -->
      <div class="section" style="width: 365px; float: left;">
        <p class="tit">신청회원 정보 
            <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">
            (개인)
          </c:if>
          <c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">
            (기업)
          </c:if>
        </p>
        <table class="tbl_pop">
        <colgroup>
          <col style="width:35%;">
          <col>
        </colgroup>
        <tbody>
        <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">
        <tr>
        <td class="tit">이름</td>
          <td>${dataVo.userNm}</td>
        </tr>
        <tr>
          <td class="tit">회사명</td>
          <td>${dataVo.indvdlCmpnyNm}</td>
        </tr>
        <%--
        <tr>
          <td class="tit">연락처</td>
          <td>${dataVo.orderMbtlnum}</td>
        </tr>
        --%>
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
        <%--
        <tr>
          <td class="tit">담당자 연락처</td>
          <td>${dataVo.orderChargerCttpc}</td>
        </tr>
        --%>
        <tr>
          <td class="tit">담당자 이메일</td>
          <td>${dataVo.orderChargerEmail}</td>
        </tr>
        </c:if>
        </tbody>
        </table>
      </div>
    <div class="section" style="width: 365px; float: right;">
        <p class="tit">판매자 정보</p>
          <table class="tbl_pop">
              <colgroup>
                  <col style="width:35%;">
                  <col>
              </colgroup>
              <tbody>
                  <c:if test="${dataVo2.userTyCd eq '1001' || dataVo2.userTyCd eq '1002'}">
                      <tr>
                          <td class="tit">이름</td>
                          <td>${dataVo2.userNm}</td>
                      </tr>
                      <tr>
                        <td class="tit">회사명</td>
                        <td>${dataVo.indvdlCmpnyNm}</td>
                      </tr>
                      <%--
                      <tr>
                          <td class="tit">연락처</td>
                          <td>${dataVo2.orderMbtlnum}</td>
                      </tr>
                      --%>
                      <tr>
                          <td class="tit">이메일</td>
                          <td>${dataVo2.orderEmail}</td>
                      </tr>
                  </c:if>
                  <c:if test="${dataVo2.userTyCd eq '2001' || dataVo2.userTyCd eq '2002'}">
                      <tr>
                          <td class="tit">회사명</td>
                          <td>${dataVo2.entrprsCmpnyNm}</td>
                      </tr>
                      <tr>
                          <td class="tit">회사 대표번호</td>
                          <td>${dataVo2.entrprsCmpnyReprsntTelno}</td>
                      </tr>
                      <tr>
                          <td class="tit">담당자 명</td>
                          <td>${dataVo2.entrprsCmpnyTelno}</td>
                      </tr>
                      <%--
                      <tr>
                          <td class="tit">담당자 연락처</td>
                          <td>${dataVo2.entrprsCmpnyFxnum}</td>
                      </tr>
                      --%>
                      <tr>
                          <td class="tit">담당자 이메일</td>
                          <td>${dataVo2.entrprsCmpnyEmail}</td>
                      </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <div class="section" style="float: left; width: 94%; margin-top: 0;">
	    <p class="message">이용자가 전달한 메시지</p>
	    <div class="cont_box"><op:nrToBr content="${dataVo.orderDlivMssage}" /></div>
    </div>
    <div class="btn_area">
        <div class="btn_pop_c">
            <div class="btn_navi">
                <a href="#reg" onclick="jsClose();"><span class="gt">확인</span></a>
            </div>
        </div>
    </div>
      <!-- //popup content -->
      <a class="w_close" href="#close" onclick="jsClose();">
        <span>닫기</span>
      </a>
    </div>
  </div>
</body>
</html>