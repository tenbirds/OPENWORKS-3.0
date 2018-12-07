<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="zes.openworks.web.store.StoreincVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>문의하기 답변 등록/수정</title>

<op:jsTag type="openworks" items="store-core" />
<op:jsTag type="spi" items="form,validate" />

<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
<script type="text/javascript">
     
    $().ready(function () {
        
        $("#dataForm").validate({
            rules: {
                inqryAnswerCn               :        { required:true,maxByte:2000}
            },
            messages : {
              inqryAnswerCn : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")}
            },
            submitHandler : function(form) {
                var dataForm = parent.$("#dataForm");
                 $(form).ajaxSubmit({
                        url : "ND_commentUpdateAction.do",
                        type : "POST",
                        dataType : "text",
                        //data : {},
                        success : function(response){
                        try {
                          if(eval(response)) {
                                
                              <c:if test="${dataVo.answerSttusCd eq '1001'}">
                                alert(Message.msg.insertOk);
                              </c:if>
                              
                              <c:if test="${dataVo.answerSttusCd eq '1002'}">
                                alert(Message.msg.updateOk);
                              </c:if>

                                parent.location.reload();
                                
                              } else {
                                alert(Message.msg.processFail);
                              }
                        } catch(e) {
                            alert(e);
                            return;
                        }
                    }
                });
            }
        });

    }); //ready end
    
    var jsClose = function(){
      parent.$.fn.colorbox.close();
    };

    var jsAccuseView = function(el,seq){
      
      var url = "/korean/pt/store/inc/PD_accuseInsertForm.do";
      var para = "?goodsInqryNo=" + seq + "&accuseAtCd=1002";
      location.href = url + para;
    };
    
</script>
</head>
<body>
  
<form id="dataForm" name="dataForm" method="post">
  <input type="hidden" id="goodsInqryNo" name="goodsInqryNo" value="${dataVo.goodsInqryNo}" />
  <input type="hidden" id="answerSttusCd" name="answerSttusCd" value="${dataVo.answerSttusCd}" />
  <!-- 팝업 윈도우 크기 width:778px -->
  <div id="pop_wrap">
    <div class="pop_container">
      <!-- popup header -->
      <div class="header">
        <h1>
          <c:if test="${dataVo.answerSttusCd eq '1001'}">
          답변등록
          </c:if>
          
          <c:if test="${dataVo.answerSttusCd eq '1002'}">
          답변수정
          </c:if>
        </h1>
      </div>
      <!-- //header -->

      <!-- popup content -->
      <div class="section">
        <p class="question">${dataVo.inqrySj}</p>

        <table class="tbl_pop">
        <colgroup>
          <col style="width:14%;">
          <col style="width:11%;">
          <col style="width:14%;">
          <col>
          <col style="width:14%;">
          <col style="width:16%;">
        </colgroup>
        <tbody>
          <tr>
            <td class="tit">작성자</td>
            <td>${dataVo.inqrNm}</td>
            <td class="tit">이메일</td>
            <td>${dataVo.answerRecptnEmail}</td>
            <td class="tit">작성일자</td>
            <td class="date">${dataVo.inqryDt}</td>
          </tr>
          <tr>
            <td class="tit">내용</td>
            <td colspan="4">${dataVo.inqryCn}</td>
            <td>
              <a href="javascript:" onclick="jsAccuseView(this,'<c:out value="${dataVo.goodsInqryNo}" />')">
              <span class="cancel">신고하기</span></a>
            </td>
          </tr>
          <tr>
            <td class="tit"><label for="repl"></label>답변내용</td>
            <td colspan="5"><textarea name="inqryAnswerCn" id="inqryAnswerCn" style="width:98%;height:60px;">${dataVo.inqryAnswerCn}</textarea></td> 
          </tr>
        </tbody>
        </table>

        <div class="btn_area">
          <div class="btn_pop_c">           
            <div class="btn_navi">
              <c:if test="${dataVo.answerSttusCd eq '1001'}">
                <a href="#reg" onclick="javascript:$('#dataForm').submit();"><span class="gt">등록</span></a>
              </c:if>              
              <c:if test="${dataVo.answerSttusCd eq '1002'}">
                <a href="#reg" onclick="javascript:$('#dataForm').submit();"><span class="gt">답변수정</span></a>
              </c:if>  
            </div>
            <div class="btn_navi_g">
              <a href="#close" onclick="jsClose()"><span class="cancel">취소</span></a>
            </div>
          </div>
        </div>
      </div>
      <!-- //popup content -->      
      

      <a class="w_close" href="#close" onclick="jsClose();">
        <span>닫기</span>
      </a>
      
    </div>
  </div>
  </form>
</body>
</html>
