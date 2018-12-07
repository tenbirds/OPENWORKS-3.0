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
  
  var jsDeleteInqryCn = function(seq){
    
    if(confirm(Message.msg.chkMsDelete)){
      $.post("ND_qnADeleteAction.do?goodsInqryNo=" + seq, 
          function(response){
            try {
              if(eval(response)) {
                  jsSuccessBox(Message.msg.deleteOk);
                  parent.$.fn.colorbox.close();
              } else {
                  jsErrorBox(Message.msg.processFail);
              }
          } catch (e) {
              jsSysErrorBox(response, e);
              return;
          }
      });
    }
    
  };
  
  
  var jsDeleteAnswerCn = function(seq){
    
    if(confirm(Message.msg.chkMsDelete)){
      $.post("ND_qnACommentDeleteAction.do?goodsInqryNo=" + seq, 
          function(response){
            try {
              if(eval(response)) {
                  jsSuccessBox(Message.msg.deleteOk);
                  parent.$.fn.colorbox.close();
              } else {
                  jsErrorBox(Message.msg.processFail);
              }
          } catch (e) {
              jsSysErrorBox(response, e);
              return;
          }
      });
    }
    
  };
  
</script>


</head>
<body>
    <!-- 컨텐츠영역 -->
    <div id="popup">
    
    <!-- popup header -->
    <div class="header">
        <h1>문의내역</h1>
    </div>
    <!-- //header -->
    
     <!-- 리스트 -->
     <table class="boardWrite" cellspacing="0" border="0" summary="리스트입니다.">
         <caption class="hidden"> 목록 </caption>
         <colgroup>
             <col width="100px" />
             <col width="" />
             <col width="100px" />
             <col width="" />
             <col width="100px" />
             <col width="" />
         </colgroup>
         <thead>
         <tr>
           <th class="tx_c">작성자</th>
           <td>
             <div class="tx_l">
               ${dataVo.inqrNm}
             </div> 
           </td>
           <th class="tx_c">이메일</th>
           <td>
             <div class="tx_l">
               ${dataVo.answerRecptnEmail}
             </div>
           </td>
           <th class="tx_c">작성일자</th>
           <td class="line_r">
             <div>
               ${dataVo.inqryDt}
             </div>
           </td>
         </tr>
         <tr>
           <th class="tx_c">내용</th>
           <td colspan="5" class="line_r">
             <div class="tx_l">
               ${dataVo.inqryCn}
             </div>
             <div class="tx_r">
               <button class="blue" type="button" onclick="jsDeleteInqryCn(${dataVo.goodsInqryNo});">삭제</button>
             </div>
          </td>
         </tr>
         <tr>
           <th class="tx_c">답변내용</th>
           <td colspan="5" class="line_r">
             <div class="tx_l">
               ${dataVo.inqryAnswerCn}
             </div>
             <div class="tx_r">
               <button class="blue" type="button" onclick="jsDeleteAnswerCn(${dataVo.goodsInqryNo});">삭제</button>
             </div>
          </td>
         </tr>
         </thead>
     </table>
     
     <!-- //리스트 -->
     <p class="tx_c mar_t20">
         <a href="#"><button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button></a>
     </p>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>

