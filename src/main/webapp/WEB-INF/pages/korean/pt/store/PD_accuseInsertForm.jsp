<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="zes.openworks.web.store.StoreincVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>신고하기</title>

<op:jsTag type="openworks" items="store-core" />
<op:jsTag type="spi" items="form,validate" />

<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
<script type="text/javascript">
     
var lastCnt = '<c:out  value="${fn:length(codeList)}" />' ;


  $( window ).load(function() {
    var height = $("#pop_wrap").height() + 90;
    parent.$.fn.colorbox.resize({height:height+"px"})  
    
  });

    $().ready(function () {
        
      $("input[name='accuseResnCd']" ).change(function() {
        
        if((this.name + "_" + lastCnt) == this.id){
          $("#textarea").show();
        }else{
          $("#textarea").hide();
        }
        
        var height = $("#pop_wrap").height() + 90;
        parent.$.fn.colorbox.resize({height:height+"px"})
        
      });
      
      if($('input:radio[name=accuseResnCd]:checked').attr("id") == "accuseResnCd_"+lastCnt){
        $("input[name='accuseResnCd']").trigger("change");
      }
      
      
      $("#dataForm").validate({
        rules: {
          accuseResnCd               :        { required:true},
          accuseResnEtcCn            :        { required:true,maxByte:300 }
        },
        messages : {
          accuseResnEtcCn : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")}
        },
        submitHandler : function(form) {
          $(form).ajaxSubmit({
            url : "ND_accuseInsertAction.do",
            type : "POST",
            dataType : "text",
            //data : {},
            success : function(response){
            
              try {
                if(eval(response)){
                  alert(Message.msg.insertOk);
                  parent.location.reload();
                }else{
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
    
  //글자수체크
    var displayBytes  = function (event, nm, id){
        var obj  = document.getElementById( id );
        var sRad = "<span class='orange'>";
        var eRad = "</span>";
        var text = "";
        
            if (obj.value.bytes() > nm){
                    text = sRad + eval('dataForm.'+id).value.bytes() + eRad;                
            }else{
                text = eval('dataForm.'+id).value.bytes();
            }
            eval('document.all.'+id+'_bytes').innerHTML = text;
    };
    
    //글자수체크 bytes 계산 속성 추가
    String.prototype.bytes = function(){
        var str = this;
        var size = 0;
        for (var i=0; i<str.length; i++){
            size += (str.charCodeAt(i) > 128) ? 2 : 1;
        }
        return size;
    };

    
</script>
</head>
<body>
  <form id="dataForm" name="dataForm" method="post">
    <input type="hidden" id="goodsInqryNo" name="goodsInqryNo" value="${baseVo.goodsInqryNo}" />
    <input type="hidden" id="accuseAtCd" name="accuseAtCd" value="${baseVo.accuseAtCd}" />
    <input type="hidden" id="inqryAplcntId"  name="inqryAplcntId"  value="${userSession}" />
    <input type="hidden" id="answerAplcntId"  name="answerAplcntId"  value="${userSession}" />
    <input type="hidden" id="accuseDt" name="accuseDt" value="1984-08-18" /> <!-- 내생일 -->
    
  
    <!-- 컨텐츠영역 -->
    <div id="pop_wrap">
      <div class="pop_container">
        <!-- popup header -->
        <div class="header">
          <h1>신고하기</h1>
        </div>
        <!-- //header -->
          <div>
            <c:forEach items="${codeList}" var="_bean" varStatus="status">
            <label style="width: 200px; display: inline-block;">
              <input type="radio" name="accuseResnCd" id="accuseResnCd_${status.index+1}" title="신고사유를 선택하세요."
                  <c:if test="${validateResult eq true}">disabled="disabled"</c:if>
              <c:if test="${baseVo.inqryAccuseResnCd eq _bean.prvCd}">checked="checked"</c:if>
              <c:if test="${baseVo.answerAccuseResnCd eq _bean.prvCd}">checked="checked"</c:if>
              <c:if test="${_bean.prvCd eq '1001'}">checked="checked"</c:if> value="${_bean.prvCd}" />
              ${_bean.prvNm}</label>
              <c:if test="${(status.index+1) % 3 == 0}">
                <br/>
              </c:if>
            </c:forEach>
           </div>
           <div id="textarea" style="overflow:hidden; margin:20px 20px; display:none; ">
            <label> 
              <textarea id="accuseResnEtcCn" name="accuseResnEtcCn" title="기타 사유를 입력해주세요"
                  <c:if test="${validateResult eq true}">readonly="readonly"</c:if>
                onkeyup="javascript:displayBytes(event,300,'accuseResnEtcCn');" 
                onblur="javascript:displayBytes(event,300,'accuseResnEtcCn');"
                style="padding:10px 15px; width:590px; height:37px;"><c:if test="${not empty baseVo.inqryAccuseEtcCn}"><c:out value="${baseVo.inqryAccuseEtcCn}" /></c:if><c:if test="${not empty baseVo.answerAccuseEtcCn}"><c:out value="${baseVo.answerAccuseEtcCn}" /></c:if></textarea>
              <div class="byte">
                <span id="accuseResnEtcCn_bytes">0</span> / 300 Byte
              </div>
             </label>
            </div>
          
      </div>
      <div class="btn_area">
        <div class="btn_r">
          <div class="btn_navi">
            <c:if test="${not empty baseVo.inqryAccuseResnCd || not empty baseVo.answerAccuseResnCd }">
              <a href="javascript:" onclick="jsClose();"><span class="inp_info">확인</span></a>
          </c:if> 
            <button id="submitClick">
              <c:if test="${empty baseVo.inqryAccuseResnCd && empty baseVo.answerAccuseResnCd }">
                <a href="javascript:"><span class="inp_info">신고</span></a>
              </c:if>
              
            </button>
          </div>
        </div>
      </div>
  </form>
</body>
</html>
