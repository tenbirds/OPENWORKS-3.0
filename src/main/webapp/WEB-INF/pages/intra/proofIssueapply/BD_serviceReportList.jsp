<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    
    <title>이용실적증명서 신청승인</title>
    
    <op:jsTag type="openworks" items="ui, validate, form" />
    <op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
    
    <script type="text/javascript">
    
    $().ready(function () {

        // 크기조정 (팝업일때..)
        //$("#contents_area").css("width","890px");
        //$(".loc_m").css("left","750px");    
    });//ready end
    
    
    //var jsAcmsltCrtfReport = function()
    //{        
        //var open = "/report/reporting.jsp?reportSection=4001";
        //window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
    //};
    
    
	// 선택항목 증명서 출력 1003
	//var jsAcmsltCrtfReport = function(el,certResultCode)	
/* 	var jsAcmsltCrtfReport = function(el) 
	{		
		var items = []; 
	    var checkCnt = 0;
	    
	    checkCnt = items.length;

		$(el).colorbox({
			title  : "이용실적증명서 신청내역",
			//href   : "BD_serviceReportList.do?item="+items+"&certResultCode="+certResultCode,
			href   : "BD_serviceReportWrite.do",					
			width  : "600",
			height : "900",
            overlayClose : true,
            escKey : true,
            iframe : true
		});

	    //$('input:checkbox[name=indexs]:checked').attr("checked", false);
	}; */
	

    // 커뮤니티  회원정보 팝업 view  <c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>
	var jsAcmsltCrtfReport = function(el, rousn) {
     
		var features ="width=1100, height=900, scrollbars=yes, toolbar=no, status=no, resizable=no";
		var popupUrl = "BD_serviceReportWrite2.do?rousn="+rousn;
		window.open( popupUrl , "이용실적 증명서 출력", features);
	};	
	
	
    
    
    // '승인' 클릭!!
    var jsAllow = function (el)
    {
        $(el).colorbox({
			title  : "이용실적증명서 신청내역",
			href   : "BD_popIssuApplyAllow.do?rouSn=${proofIssueapply.rouSn}",
			width  : "490",
			height : "390",
            overlayClose : true,
            escKey : true,
            iframe : true
		});
    }
    
    // '반려' 클릭!!
    var jsRefund = function() 
    {
        if  (confirm("반려하시겠습니까?"))
        {
             /* var items = []; 
             var checkCnt = 0;
             
             $('input:checkbox[name=indexs]:checked').each(function () 
             { 
                 items.push($(this).val());
             });
             
             checkCnt = items.length;
             if (checkCnt == 0 ) 
             {
                 alert('1개 이상 선택 하셔야 합니다.');
                 return false;
             }
             else
             {
                 $.ajax({
                     type  : "POST",
                     url   : "BD_setIssuSttus1002.do",
                     cache : false,
                     data  : {item : items.join(",") }
                 });
            } */
             
             
             $.ajax({
                type  : "POST",
                url   : "BD_setIssuSttus1002.do",
                cache : false,
                data  : {item : <c:out value="${proofIssueapply.rouSn}"/> },
                success : function(data) {                      
                   if  (data == 1)
                   {
                       alert("반려되었습니다.");
                   }
                 }
            });
        }
    }
    
   // '파일선택'버튼
   var jsFileChk = function(fileId, inputId, s, fileSeq, maxCnt) {
	    
      	var inputFile = document.getElementById(fileId);
      	var filePath = inputFile.value;
      			
      	if (filePath == "") {
          	return false;
      	}
      	
      	var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt);
    	if (fileCountResult) {
            var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
            var fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai,zip";
            var htmlVal = "";

            if (fileExtPermit.indexOf(fileExt) <= 0) {
                alert(fileExt + Message.msg.fileCannotUplaod);
                jsInputFileReset('','',inputId,inputIdFake);
                return false;
            }
            
    		if (inputFile.files[0].size > (s * 1024) && s != 0) {
                alert(Message.msg.fileSizeOver);
                jsInputFileReset('','',inputId,inputIdFake);
            	return false;
            }
    		
    		$("#"+inputId).val(filePath);
    	}
  	};

    </script>

</head>
<body>

    <div id="contents">
        <div class="search">
            <fieldset>
                <legend>조건을 선택하여 검색하세요.</legend>
                <table class="boardWrite" summary="검색 조건">
                    <colgroup>
                        <col width="10%" />
                        <col width="*" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>신청기관</th>
                            <td>${proofIssueapply.organNm}</td>
                        </tr>
                        <tr>
                            <th>발급사유</th>
                            <td>${proofIssueapply.issuResn}</td>
                        </tr>
                        <tr>
                            <th>발급방법</th>
                            <td>${proofIssueapply.issuMthNm}</td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td></td>
                        </tr>
                        <tr>
                            <th>이메일주소</th>
                            <td></td>
                        </tr>
                    </thead>
                </table>
            </fieldset>
        </div>
        
        <c:set var="tot" value="0"/>
        <c:forEach items="${proofIssueReportList}" var="baseVo" varStatus="status">
            <c:set var="tot" value="${tot + baseVo.cntrctAmount}"/>
        </c:forEach>
        <div>총 ${fn:length(proofIssueReportList)}건 (금액 : <fmt:formatNumber value="${tot}" type="NUMBER" groupingUsed="true"/>원) </div>
         <!-- 리스트 -->
         
        <table class="boardList" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="*"/>
                <col width="*"/>
                <col width="10%"/>
                <col width="25%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>사업명</th>
                    <th>서비스명</th>
                    <th>구분</th>
                    <th>이용기간</th>
                    <th>총 계약금액</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:forEach items="${proofIssueReportList}" var="baseVo" varStatus="status">
                    <tr>
                        <td>${fn:length(proofIssueReportList)-status.index}</td>
                        <td class="tx_l">${baseVo.svcNm}</td>
                        <td class="tx_l">${baseVo.goodsNm}</td>
                        <td>${baseVo.goodsKndCd}</td>
                        <td>${baseVo.cntrctBeginDe} ~ ${baseVo.cntrctEnd}</td>
                        <td class="tx_R"><fmt:formatNumber value="${baseVo.cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
            
		<div style="height:10px;margin:10px 0 10px 0;"></div>

		<div>
	        <div style="position:relative;float:left;">            
	            <span class="txt_L"><button class="blue" type="button" name="submits" id="submits" onclick="jsAcmsltCrtfReport(this,${proofIssueapply.rouSn});">증명서 출력</button></span>        
	        </div>
	        
	        <div style="position:relative;float:right;">
	            <button class="blue" type="button" name="submits" id="submits" onclick="jsAllow(this);">승인</button>
	            <button class="blue" type="button" name="submits" id="submits" onclick="jsRefund();">반려</button>
	        </div>
        
        </div>
    
       
        
    </div>
</body>

</html>