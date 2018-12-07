<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>사전견적서 Scs</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
        
    <script type="text/javascript">
        
        var date = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        var nowDate = "" + year + month + day;
    
        function nr_num(this_s,type)
        {
            /*
            type
            -> 'int' : 양의 정수
            -> 'float' : 양의 실수
            -> '-int' : 음의 정수 포함
            -> '-float' : 음의 실수 포함
            */
            temp_value = this_s.value.toString();
            regexp = /[^-\.0-9]/g;
            repexp = '';
            temp_value = temp_value.replace(regexp,repexp);
            regexp = '';
            repexp = '';
            
            switch(type)
            {
                case 'int':    regexp = /[^0-9]/g; break;
                case 'float':  regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/; break;                
                case '-int':   regexp = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;break;
                case '-float': regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/; break;
                default : regexp = /[^0-9]/g; break;
            }
            
            switch(type)
            {
                case 'int':    repexp = '';break;
                case 'float':  repexp = '$2$3$5';break;
                case '-int':   repexp = '$1$2$4';break;
                case '-float': repexp = '$1$2$3$5'; break;
                default : regexp = /[^0-9]/g; break;
            }
            
            temp_value = temp_value.replace(regexp,repexp);
            this_s.value = temp_value;
        }

        // 숫자만 입력하도록 체크
        function jsOnlyNumber(event)
         {
             var keyID = (event.which) ? event.which : event.keyCode;
              if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
            else return false;
        }
         
        // 숫자만 입력하도록 체크2
        function removeChar(event) 
        {
            event = event || window.event;
             var keyID = (event.which) ? event.which : event.keyCode;
              if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) return;
            else event.target.value = event.target.value.replace(/[^0-9]/g, "");
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

        // 견적요청서 취소
        var jsCommentCancel = function()
        {
            history.back();    
        }
     
        // 견적요청서 발송
        var jsRequestSend = function()
        {           
            // 입력 필수값 체크
            if(checkEditor())
            {
                //if (confirm("견적요청서를 발송 하시겠습니까?")) 
                //{
                    // VAT여부
                    if($('input:radio[name=vatGbnRadio]:checked').attr("id") == "vatGbnY"){
                        $("#vatGbn").val("Y");
                    }else{
                        $("#vatGbn").val("N");
                    }
                    
                    // 합의후 결정 여부
                    if($('#talkGbnChkbox').is(":checked") == true){
                        $("#talkGbn").val("Y");
                    }else{
                        $("#talkGbn").val("N");
                    }
                    
                    // 첨부파일
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });

                    $("#dataForm").attr("action", "ND_beforeRequestScs2Action.do");
                    $("#dataForm").submit();
                //}
            }
        };

        // 견적요청서 필수 입력값 체크
        var checkEditor = function()
        {
        	var cnslRelm  = [];     
        	var cnslScope = [];     
        	var excArea   = [];     

            $('.cnslRelm').each(function()   { if ($(this).is(':checked')) cnslRelm.push( $(this).val() );   });
            $('.cnslScope').each(function()  { if ($(this).is(':checked')) cnslScope.push( $(this).val() );  });
            $('.excArea').each(function()    { if ($(this).is(':checked')) excArea.push( $(this).val() );    });
            
            $('#cnslRelm').val( cnslRelm.join(',') );
            $('#cnslScope').val( cnslScope.join(',') );
            $('#excArea').val( excArea.join(',') );

           // 답변 만료일
           if($("#rplyDt").val() == null || $("#rplyDt").val() == ""){
               alert("답변 만료일을 입력해주세요.");
               $("#rplyDt").focus();
               return false;
           }else{
               // 응답 만료일이 현재일 이전일 경우 return
               var rplyDt = $("#rplyDt").val().replace(/-/gi,"");
               if(nowDate > rplyDt){
                   alert("답변 만료일은 현재일 이전일수 없습니다.");
                   $("#rplyDt").focus();
                   return false;
               }
           }
           
           var useFromDt = $("#useFromDt").val().replace(/-/gi,"");
           var useToDt   = $("#useToDt").val().replace(/-/gi,"");
           
           if  ((useToDt == "" && useFromDt == "") || (useToDt == "" && useFromDt != "") || (useToDt != "" && useFromDt == ""))
           {
               alert("컨설팅기간은 둘다 있어야 합니다.");
               return false;
           }
           
           if  ((useToDt != "" && useFromDt != "") && (useToDt < useFromDt))
           {
               alert("컨설팅기간은 '부터'가 '까지'보다 먼저 나와야 합니다.");
               return false;
           }
           
           var hopePuchAmt = $("#hopePuchAmt").val();
           if  (hopePuchAmt == "")
       	   {
        	   alert("컨설팅예산을 입력해 주세요.");
               return false;
       	   }

           // 기관명
           if($("#realDmndOrgn").val() == null || $("#realDmndOrgn").val() == ""){
               alert("기업/기관명을 입력해주세요.");
               $("#realDmndOrgn").focus();
               return false;
           }


            return true;
        };
        
        var jsChkCnslRelm = function(el)
        {
        	if  ($(el).val() == '1004')
       		{
        		if  ($(el).prop("checked")) $("#cnslRelmEtc").attr("disabled", false); 
        		else
       			{
        			$("#cnslRelmEtc").val("");
        			$("#cnslRelmEtc").attr("disabled", true); 
       			}
       		}
        }
        
        var jsChkExcArea = function(el) 
        {
        	if  ($(el).val() == '1099')
			{
        		<!-- 2036 -->
                <c:forEach items="${excAreaList}" var="_excArea" varStatus="status">                
                <c:if test="${_excArea.PRVCD ne 1099}"> $("#excArea_${_excArea.PRVCD}").prop("checked",false) ; </c:if> 
                </c:forEach>
			}        		
        	if  ($(el).val() != '1099')
			{
        		$("#excArea_1099").prop("checked",false) ; 
			}        		
        }
        
         
      	//[] <--문자 범위 [^] <--부정 [0-9] <-- 숫자  
      	//[0-9] => \d , [^0-9] => \D
      	// 세자리 3자리 콤머 자동등록
      	var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
      	var rgx2 = /(\d+)(\d{3})/; 

      	function getNumber(obj)
      	{        
			var num01;
           	var num02;
           	num01 = obj.value;
           	num02 = num01.replace(rgx1,"");
           	num01 = setComma(num02);
           	obj.value =  num01;
		}

      	function setComma(inNum)
      	{           
        	var outNum;
           	outNum = inNum; 
           	while (rgx2.test(outNum)) 
           	{
                outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
            }
           	return outNum;
      	}
    </script>
    
    <style type="text/css">
     
        input[type=text].width50p { width : 50%; }
        
    </style>

</head>
<body>
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <input type="hidden" name="bidGbnCd"  id="bidGbnCd"  value="1004" /> <!-- 입찰종류 (1004 : 사전견적) -->
    <input type="hidden" name="userId"    id="userId"    value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="grpSeq"    id="grpSeq"    value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd" id="goodsTyCd" value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="goodsCd"   id="goodsCd"   value="<c:out value="${p_chkGoodsCode}" />" /> <!-- goodsCd -->
    <input type="hidden" name="goodArray" id="goodArray" value="" />
    <input type="hidden" name="vatGbn"    id="vatGbn"    value="" />
    <input type="hidden" name="talkGbn"   id="talkGbn"   value="" />
    <input type="hidden" name="userNm"    id="userNm"    value="${sessionScope['__usk'].userNm}" />
    
    <input type="hidden" name="cnslRelm"  id="cnslRelm"  value="" /> <!-- 컨설팅 영역 -->
    <input type="hidden" name="cnslScope" id="cnslScope" value="" /> <!-- 컨설팅 범위 -->
    <input type="hidden" name="excArea"   id="excArea"   value="" /> <!-- 컨설팅 수행가능지역 -->    

    <!-- content -->
    <section class="pageTit">
        <!-- 타이틀 영역 -->
        <div class="conWrap">
            <h2>견적요청</h2>
        </div>
        <!--// 타이틀 영역 -->
    </section>
    
    <div class="conWrap detailRequ iaas">
        
        <%-- 
        <h3>문의대상 서비스</h3>
        <table class="tbl_st1 qSer">
            <thead>
                <tr>
                    <th>공급사</th>
                    <th>서비스</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${pager.list}" var="myWishList" varStatus="status">
                <tr>
                    <td>${myWishList.langStoreNm}</td>
                    <td>${myWishList.goodsNm}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table> 
        --%>
        
        
        <!-- 
        
        컨설팅 요구사항 
        
        -->
        
        <h3>컨설팅 요구사항</h3>
        
        <table id="serverTable01" class="tbl_st4" summary="컨설팅 요구사항">
	        <caption>컨설팅 요구사항</caption>
	        <colgroup>
	            <col width="10%" />
	            <col width="*" />
	        </colgroup>
	        <tbody>
        		<tr>
            	<th scope="col" class="requ">컨설팅 영역</th>
              <td>
                	<!-- 2082 -->
	                <c:forEach items="${cnslRelmList}" var="_cnslRelm" varStatus="status">
	                    <label>
	                    	<input type="checkbox" class="cnslRelm" id="cnslRelm_${_cnslRelm.PRVCD}" name="cnslRelm_${_cnslRelm.PRVCD}" value="${_cnslRelm.PRVCD}" onclick="jsChkCnslRelm(this);" />${_cnslRelm.PRVNM}
	                    </label>
	                </c:forEach>
	                <input type="text" class="width50p"  id="cnslRelmEtc" name="cnslRelmEtc" disabled="disabled" value=""><label for="cnslRelmEtc"></label>
							</td>
            </tr>
            <tr>
	            <th scope="col" class="requ">컨설팅 범위</th>
	            <td>
	            	<!-- 2083 -->
	             <c:forEach items="${cnslScopeList}" var="_cnslScope" varStatus="status">
	                 <label>
	                 	<input type="checkbox" class="cnslScope" id="cnslScope_${_cnslScope.PRVCD}" name="cnslScope_${_cnslScope.PRVCD}" value="${_cnslScope.PRVCD}" />${_cnslScope.PRVNM}
	                 </label>
	             </c:forEach>
							</td>
            </tr>
            <tr>
	            <th scope="col" class="requ">컨설팅 수행가능지역</th>
	            <td>
	            	<!-- 2036 -->
	             <c:forEach items="${excAreaList}" var="_excArea" varStatus="status">
	                 <label>
	                 	<input type="checkbox" class="excArea" id="excArea_${_excArea.PRVCD}" name="excArea_${_excArea.PRVCD}" value="${_excArea.PRVCD}" onclick="jsChkExcArea(this);" />${_excArea.PRVNM}
	                 </label>
	             </c:forEach>
							</td>
            </tr>
        </tbody>
        </table>
        
                
        <h3>컨설팅 의뢰내용</h3>
        
        <table id="serverTable01" class="tbl_st4" summary="컨설팅 의뢰내용">
        <caption>컨설팅 의뢰내용</caption>
        <colgroup>
            <col width="10%" />
            <col width="*" />
        </colgroup>
        <tbody>
            <tr>
            	<th scope="col">도입전반</th>
	            <td><input type="text" id="indcWhole" name="indcWhole" value=""><label for="indcWhole"></label></td>
            </tr>
            <tr>
            	<th scope="col">Setup &amp; Migration</th>
            	<td><input type="text" id="setupMgr" name="setupMgr" value=""><label for="setupMgr"></label></td>
            </tr>
            <tr>
            	<th scope="col">운영</th>
            	<td><input type="text" id="oper" name="oper" value=""><label for="oper"></label></td>
            </tr>
            <tr>
            	<th scope="col">품질보증/테스트</th>
            	<td><input type="text" id="qlityTest" name=qlityTest value=""><label for="qlityTest"></label></td>
            </tr>
            <tr>
            	<th scope="col">보안</th>
            	<td><input type="text" id="scrty" name="scrty" value=""><label for="scrty"></label></td>
            </tr>
            <tr>
            	<th scope="col">교육</th>
            	<td><input type="text" id="education" name="education" value=""><label for="education"></label></td>
            </tr>
        </tbody>
        </table>
        
        <div class="conWrap detailRequ iaas">
        <h3>납품 요구조건</h3>
        <table class="tbl_st4" summary="납품 요구조건">
	        <caption>납품 요구조건</caption>
	        <colgroup>
	            <col width="10%" />
	            <col width="*" />
	            <col width="10%" />
	            <col width="*" />
	        </colgroup>
        	<tbody>
            <tr>
                <th scope="col" class="requ">컨설팅 기간</th>
                <td class="term" colspan="3">                    
                    <input type="text" id="useFromDt" name="useFromDt" readonly="readonly"/><label for="useFromDt"></label>
                    ~ 
                    <input type="text" id="useToDt" name="useToDt" readonly="readonly"/><label for="useToDt"></label>
                    <span id="useTerm"> <%-- (12개월 00일) --%></span>
                    
                    <input type="hidden" id="puchBudgetAmt" name="puchBudgetAmt">
                </td>
                <!-- th>구매예산(원)</th>
                <td class="vat">
                    <div class="unit">
                        <i>원</i>                
                        <div><input type="text" id="puchBudgetAmt" name="puchBudgetAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></div>
                    </div>
                </td -->
            </tr>
            <tr>
                <th scope="col" class="requ">컨설팅 예산</th>
                <td class="vat">
                    <div class="unit">
                        <i>원</i>                
                        <div>
                        <!-- input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  -->
                        <input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="13" style="ime-mode:disabled" onchange="getNumber(this);" onkeyup="getNumber(this);">
                        <label for="hopePuchAmt"></label>
                        </div>
                    </div>
                    <label><input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked"/> VAT포함</label>
                    <label><input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"/> VAT미포함</label>
                </td>
                <th scope="col" class="requ">답변 만료일</th>
                <td class="term"><input type="text" id="rplyDt" name="rplyDt" /><label for="rplyDt"></label></td>
            </tr>
            <tr>
                <th scope="col">관련문서</th>
                <td colspan="3">
                    <div class="uploadFile">
                        <input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/><label for="delyFileInput"></label>
                        <div>
                            <img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('delyFile', 'delyFileInput');" alt="삭제" />                            
                            <span class="btns st3">파일선택
                                <input type="file" name="delyFile" id="delyFile" class="delyFile" title="파일찾기" onchange="jsFileChk('delyFile', 'delyFileInput');"/>
                            </span><label for="delyFile"></label>
                        </div>
                    </div>
                </td>
            </tr>            
            <tr>
                <th scope="col">추가문의</th>
                <td colspan="3"><textarea id="notifyCont" name="notifyCont" ></textarea><label for="notifyCont"></label></td>
            </tr>
        	</tbody>
        </table>
            
        <h3>요청자 정보</h3>
        <table class="tbl_st4" summary="요청자 정보">
        	<caption>요청자 정보</caption>
        	<colgroup>
        		<col width="10%"/>
        		<col width="*"/>
        		<col width="10%"/>
        		<col width="*"/>
        	</colgroup>
            <tr>
                <th scope="col" class="requ">작성자</th>
                <td>
                	${sessionScope['__usk'].userNm}
                	<input type="hidden" id="goodsChargerNm" name="goodsChargerNm" value="${sessionScope['__usk'].userNm}" />
                </td>
                <th scope="col" class="requ">휴대전화</th>
                <td>${sessionScope['__usk'].mbtlnum}</td>
            </tr>
            <tr>
                <th scope="col" class="requ">기업/기관명</th>
                <td>
<!-- 
3001	공공 구매회원	
2002	기업 판매회원	
2001	기업 구매회원	
1002	개인 판매회원	
1001	개인 구매회원
-->
        <c:if test="${sessionScope['__usk'].userTyCd eq '3001' or sessionScope['__usk'].userTyCd eq '3002'}">
        	<c:set var="realDmndOrgn" value="${sessionScope['__usk'].pblinsttUpdtAt}"/>
        	<c:set var="realDmndBuseoCd" value="${sessionScope['__usk'].buseoCode}"/>
        </c:if>
        <c:if test="${sessionScope['__usk'].userTyCd eq '2001' or sessionScope['__usk'].userTyCd eq '1001'}">
        	<c:set var="realDmndOrgn" value="${sessionScope['__usk'].cmpnyNm}"/>
        	<c:set var="realDmndBuseoCd" value=""/>
        </c:if>
        	<input type="text" 		id="realDmndOrgn"			name="realDmndOrgn" value="${realDmndOrgn}" style="width:450px" readonly="readonly"/><label for="realDmndOrgn"></label>
          <input type="hidden"	id="realDmndOrgnCd"		name="realDmndOrgnCd" value=""/>
          <input type="hidden"	id="realDmndBuseoCd"	name="realDmndBuseoCd" value="${realDmndBuseoCd }"/>
                </td>
                <th scope="col" class="requ">이메일</th>
                <td><a href="mailto:">${sessionScope['__usk'].email}</a></td>
            </tr>
            <tr>
                <th scope="col">직책</th>
                <td>
                	<input type="text" id="userPosition" name="userPosition"/><label for="userPosition"></label>
                </td>
                <th scope="col">대표전화</th>
                <td class="tel">
                    <input type="text" id="goodsChargerCttpc1" name="goodsChargerCttpc1"/><label for="goodsChargerCttpc1"></label>
                     - 
                    <input type="text" id="goodsChargerCttpc2" name="goodsChargerCttpc2"/><label for="goodsChargerCttpc2"></label>
                     -
                    <input type="text" id="goodsChargerCttpc3" name="goodsChargerCttpc3"/><label for="goodsChargerCttpc3"></label>
                </td>
            </tr>                    
        </table>
            
        <div class="btnArea rig">
        	<a href='#' onclick="jsCommentCancel();" class="btns st1 icn icnDel"> 취 소 </a>
            <a href="#" onclick="jsRequestSend();"   class="btns st1 icn icnSend"> 발 송 </a>
        </div>
    </div>
    <!--// content -->
	</div>
</form>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
  <script type="text/javascript" src="/resources/cmmnty/common/js/fakeselect.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/notice/jquery.notice.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/printPreview/jquery.print-preview.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/cookie/jquery.cookie.js"></script>
  <script type="text/javascript" src="/resources/web/analyze/tracking/js/detector.js"></script>
 <!-- datepicker -->
  <link rel="stylesheet" href="/resources/openworks/spi/jquery/datepicker/jquery.datepicker.css" />
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.ui.core.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script.min.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script-addon.js"></script>
  <script src="/resources/openworks/spi/openworks/openworks.ui.js"></script>
  <script>
  
    function explode()
    {
        $('#divDB').hide();
        $('#divStorage').hide();
        $('#divCDN').hide();
        $('#divWebFirewall').hide();
        $('#divMonitoring').hide();
        $('#divBackup').hide();
        $('#divAddedService').hide();
    }
    
    $(document).ready(function() 
    {
        $( "#useFromDt, #useToDt, #rplyDt" ).datepicker({
              showOn: "both", 
              buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
              buttonImageOnly: false,
              buttonText: "달력"
        });
        
        setTimeout(explode, 1000);        
    });
  </script>
  <!--// datepicker -->
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>

</body>
</html>