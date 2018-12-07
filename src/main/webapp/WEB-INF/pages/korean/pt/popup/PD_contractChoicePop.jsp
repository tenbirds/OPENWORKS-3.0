<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>POPUP - 계약대상 선정</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
 
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <script type="text/javascript">
        var date = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        var nowDate = "" + year + month + day;
    
        // 닫기
        var jsClose = function(){
            parent.$.fn.colorbox.close();
        };
        
        // 서비스 콤보 선택 이벤트
        function jsApplyCd(applyCd){
            var strAry = applyCd.split("|");
            $('#langStoreId').val(strAry[0]);
            $('#askApplyCd').val(strAry[1]);
        }
        
		// 첨부파일 반영
		var jsFileChk = function(inputId, inputIdFake){
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
		};

		// 첨부파일 삭제
		var jsFileDelete = function(inputId, inputIdFake){
		    document.getElementById(inputIdFake).value="";
		    $("input[name="+inputId+"]").val("");
		}

	    // 선정버튼 클릭
	    var jsChoice = function(){
	        if(checkEditor()){
	            if(confirm("해당 서비스를 선정 하시겠습니까?")) {
                    // 첨부파일
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });

                    $("#dataForm").attr("action", "ND_contractChoice.do");
                    $("#dataForm").submit();
	            }
	        }
	    };
	    
	    // 선정 vaildation 체크
	    function checkEditor(){
	        if($('#langStoreId').val() == ''){
	            alert("서비스를 선택하세요.");
	            $('#langStoreId').focus();
	            return false;
	        }
            // 선택한 서비스의 답변이 등록되어 있는지 체크
            var askApplyCd = $("#askApplyCd").val();
            if(askApplyCd != '1003'){
                alert("해당 서비스의 답변이 등록되지 않았습니다.");
                $("#p_langStoreId").focus();
                return false;
            }
	        if($('#bidSussDt').val() == ''){
	            alert("선정날짜를 입력하세요.");
	            $('#bidSussDt').focus();
	            return false;
	        }
	        if($('#evalSheetFileInput').val() == ''){
	            alert("평가서를 첨부하세요.");
	            return false;
	        }
            // 응답 만료일이 현재일 이전일 경우 return
            var bidSussDt = $("#bidSussDt").val().replace(/-/gi,"");
            if(nowDate > bidSussDt){
                alert("선정일자는 현재일 이전일수 없습니다.");
                $("#bidSussDt").focus();
                return false;
            }

	        return true;
	    }

    </script>
</head>

<body class="winPopup">

    <h2>계약대상 선정 <a href="#" onclick="jsClose();">닫기</a></h2>
    <div id="divSave">
        <form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
            <input type="hidden" name="notifyNum"   id="notifyNum"  value="${baseList.notifyNum}" /> <!-- 공고번호 -->
            <input type="hidden" name="notifySeq"   id="notifySeq"  value="${baseList.notifySeq}" /> <!-- 공고차수 -->
            <input type="hidden" name="langStoreId" id="langStoreId" value="" /> <!-- 서비스 id -->
            <input type="hidden" name="askApplyCd"  id="askApplyCd" value="" />  <!-- 답변상태 -->

	    <table class="tbl_st4 e2">
		    <tr>
			    <th class="requ">사업명</th>
			    <td>${baseList.auditlogNm}</td>
		    </tr>					
		    <tr>
			    <th class="requ">서비스</th>
			    <td>
				    <span class="sel_box">
                        <select name="p_langStoreId" id="p_langStoreId" onchange="javascript:jsApplyCd(this.value); return false;">
					        <option value="">선택</option>
					        <c:forEach items="${dataList}" var="dataList" varStatus="status">
					            <option value="${dataList.langStoreId}|${dataList.askApplyCd}">${dataList.langStoreNm}</option>
					        </c:forEach>
					    </select>
				    </span>
			    </td>
		    </tr>					
		    <tr>
			    <th class="requ">선정일자</th>
			    <td class="term">
				    <input type="text" name="bidSussDt" id="bidSussDt" />
			    </td>
		    </tr>			
			<tr>
				<th class="requ">평가서첨부</th>
				<td colspan="3">
					<div class="uploadFile">
						<input type="text" readonly="readonly" name="evalSheetFileInput" id="evalSheetFileInput" title="파일명"/>
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('evalSheetFile', 'evalSheetFileInput');" alt="삭제" />							
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="evalSheetFile" id="evalSheetFile" class="evalSheetFile" title="파일찾기" onchange="jsFileChk('evalSheetFile', 'evalSheetFileInput');"/>
			            	</span>
		            	</div>
		            </div>
				</td>
			</tr>
		</table>
	    <div class="btnArea">
		    <a href="#" onclick="jsChoice(); return false;" class="btns st1">선정</a>		
	    </div>
	    </form>
	</div>
	<div id="divView" style="display:none;">
		<div>
			<p>선택한 사업에 대한 서비스를 <strong id="viewAuditlogNm"></strong>로 선정하였습니다.</p>
		</div>
		<div class="btnArea">
			<a href="/korean/pt/myCeart/BD_buyingRequestList.do" class="btns st1" target="_parent">확인</a>	
		</div>
	</div>	
    <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
<script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
<!-- datepicker -->
<link rel="stylesheet" href="/resources/openworks/spi/jquery/datepicker/jquery.datepicker.css" />
<script src="/resources/openworks/spi/jquery/datepicker/jquery.ui.core.js"></script>
<script src="/resources/openworks/spi/jquery/datepicker/jquery.script.min.js"></script>
<script src="/resources/openworks/spi/jquery/datepicker/jquery.script-addon.js"></script>
<script src="/resources/openworks/spi/openworks/openworks.ui.js"></script>
<script>
$(document).ready(function() {
  $("#bidSussDt").datepicker({
          showOn: "both", 
          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
          buttonImageOnly: false,
          buttonText: "달력"
    });
});
 </script>
<!--// datepicker -->
<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  

</body>
</html>