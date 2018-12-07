<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>사용자 화면에 나타낼 통계 데이터 등록</title>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/form/jquery.form.js"></script>
    
    <script type="text/javascript">
    
    // 숫자만 입력하도록 체크
    function jsOnlyNumber(event){
         var keyID = (event.which) ? event.which : event.keyCode;
          if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
        else return false;
    }
     
    // 숫자만 입력하도록 체크2
    function removeChar(event) {
        event = event || window.event;
         var keyID = (event.which) ? event.which : event.keyCode;
          if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) return;
        else event.target.value = event.target.value.replace(/[^0-9]/g, "");
    }
    
    var changing = function()
    {    
        $("#dataForm").ajaxSubmit({
            url      : "popUpdateFrontInfo.do",
            type     : "POST",
            async    : false,
            dataType : "json",
            success  : function (response) {                
            
                alert("협약기업수 :"+response.agreement
                     +"\n이용건수 :"+response.use_cnt    
                     +"\n이용금액 :"+response.use_amt    
                     );
                
                parent.$.fn.colorbox.close();
            }
            ,
            error: function(e) {
                
               alert(e.responseText);
            }
        });
    };
    
    </script>
</head>

<body>
    <div id="contents">
        <form id="dataForm" name="dataForm"> 
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다." style="margin-top: 30px;margin-bottom: 30px;">
                <caption class="hidden"> 사용자 화면에 나타낼 통계 데이터 등록 </caption>
                <colgroup>
                    <col width="20%" />
                    <col width="20%" />
                    <col width="60%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th style="text-align:  center;" colspan="2"><label for="popupTitle">협약기업</label></th>
                        <td><input type="text" id="agreement" style="text-align:  right;" class="w85_p" name="agreement" title="협약기업수를 입력하세요" value="${frontInfo.agreement}"   onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/></td>
                    </tr>
                    <tr>
                        <th style="text-align:  center;"  rowspan="2"><label for="popupTitle">이용</label></th>
                        <th style="text-align:  center;" ><label for="popupTitle">건수</label></th>
                        <td><input type="text" id="use_cnt" style="text-align:  right;" class="w85_p" name="use_cnt" title="이용건수를 입력하세요" value="${frontInfo.use_cnt}"   onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/></td>
                    </tr>
                    <tr>
                        <th style="text-align:  center;" ><label for="popupTitle">금액</label></th>
                        <td><input type="text" id="use_amt" style="text-align:  right;" class="w85_p" name="use_amt" title="이용금액을 입력하세요" value="${frontInfo.use_amt}"   onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/></td>
                    </tr>
                </tbody>
            </table>        
        </form>
        
        <p class="tx_c"><button href="#" class="blue" onclick="changing();">변경하기</button></p>                
    </div>
</body>
</html>