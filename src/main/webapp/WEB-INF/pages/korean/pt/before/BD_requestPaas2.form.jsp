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
    
    <title>사전견적서 PaaS</title>
    
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
        
    <script type="text/javascript">
	    
		//
		// select 박스에 초기값을 설정한다. (#selectbox)
		//
		function settingSelect(idSpan, idSelect, value)
		{
		    var span   = "#"+idSpan ;
		    var select = "#"+idSelect+" option[value='"+value+"']";
		    
		    $( select ).attr("selected", true);
		    $( span ).find('span').text( $( select ).text() );
		}
	    
	    
	    function paas_explode()
	    {
			// select 디폴트값 설정
	        <c:forEach items="${pass2_h}" var="pass2" varStatus="status">
	         
	            settingSelect('spanHostingMethod', 'hostingMethod', '${pass2.hostingMethod}');
	            settingSelect('spanPlatform', 'platform', '${pass2.platform}');
	            settingSelect('spanGeolocations', 'geolocations', '${pass2.geolocations}');
	            
	            
	            var str = "${pass2.scaling}" ;
	            var jbSplit = str.split(',');
	            for ( var i in jbSplit ) 
	            {
	            	$('#scaling_'+jbSplit[i]).attr("checked", true);                      
	            }
	            
	            str = "${pass2.runtimes}" ;
	            jbSplit = str.split(',');
	            for ( var i in jbSplit ) 
	            {
	                $('#runtimes_'+jbSplit[i]).attr("checked", true);                      
	            }
	            
	            str = "${pass2.middlewares}" ;
	            jbSplit = str.split(',');
	            for ( var i in jbSplit ) 
	            {
	                $('#middlewares_'+jbSplit[i]).attr("checked", true);                      
	            }
	            
	            str = "${pass2.frameworks}" ;
	            jbSplit = str.split(',');
	            for ( var i in jbSplit ) 
	            {
	                $('#frameworks_'+jbSplit[i]).attr("checked", true);                      
	            }
	            
	            str = "${pass2.services}" ;
	            jbSplit = str.split(',');
	            for ( var i in jbSplit ) 
	            {
	                $('#services_'+jbSplit[i]).attr("checked", true);                      
	            }
	            
	            str = "${pass2.addons}" ;
	            jbSplit = str.split(',');
	            for ( var i in jbSplit ) 
	            {
	                $('#addons_'+jbSplit[i]).attr("checked", true);                      
	            }
	            
	            if  ("${pass2.extendFunction}" == "Y") 
	            {
	                $('#extendFunction').attr("checked", true);                      
	            }
	            
	                    
			</c:forEach>
	         
	    }
	
		setTimeout(paas_explode, 1000);    
	    
	    
    
    
        var date = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        var nowDate = "" + year + month + day;
    
        // 납품 요구조건의 납품기한 합의후 결정 체크박스 체크 이벤트
        var jsTalkGbnChk = function(){
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                //$("#delyDt").attr("readonly",false);
                $("#delyTime").prop("disabled", false);
            }else{
                //$("#delyDt").val('');
                //$("#delyDt").attr("readonly",true);
                $("#delyTime").val("");
                $("#delyTime").parents('span').find("span").html($("#delyTime option:selected").text());
                $("#delyTime").prop("disabled", true);
            }
        };

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
                //if(confirm("견적요청서를 발송 하시겠습니까?")) 
                //{
                    // 체크박스 데이터 전환 Paas
                    var scaling     = [];     
                    //var runtimes    = [];  
                    //var middlewares  = [];  
                    //var frameworks  = [];  
                    //var services    = [];  
                    //var addons      = [];                      

                    $('.scaling').each(function()    {    if ($(this).is(':checked')) scaling.push( $(this).val() );     });
                    //$('.runtimes').each(function()   {    if ($(this).is(':checked')) runtimes.push( $(this).val() );    });
                    //$('.middlewares').each(function() {   if ($(this).is(':checked')) middlewares.push( $(this).val() );  });
                    //$('.frameworks').each(function() {    if ($(this).is(':checked')) frameworks.push( $(this).val() );  });
                    //$('.services').each(function()   {    if ($(this).is(':checked')) services.push( $(this).val() );    });
                    //$('.addons').each(function()     {    if ($(this).is(':checked')) addons.push( $(this).val() );      });
                    
                    $('#scaling').val( scaling.join(',') );
                    //$('#runtimes').val( runtimes.join(',') );
                    //$('#middlewares').val( middlewares.join(',') );
                    //$('#frameworks').val( frameworks.join(',') );
                    //$('#services').val( services.join(',') );
                    //$('#addons').val( addons.join(',') );
                    
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

                    $("#dataForm").attr("action", "ND_beforeRequestPaas2Action.do");
                    $("#dataForm").submit();
                //}
            }
        };

         // 견적요청서 필수 입력값 체크
        var checkEditor = function()
        {
            // 납품요구조건 - 납품기한
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                // 납품기한 일자
/*                 
                if($("#delyDt").val() == null || $("#delyDt").val() == ""){
                    alert("납품기한을 입력해주세요.");
                    $("#delyDt").focus();
                    return false;
                }else{
                    // 납품기한 일자가 현재일 이전일 경우 return
                    var delyDt = $("#delyDt").val().replace(/-/gi,"");
                    if(nowDate > delyDt){
                        alert("납품기한은 현재일 이전일수 없습니다.");
                        $("#delyDt").focus();
                        return false;                    
                    }
                }
 */                
                var useFromDt = $("#useFromDt").val().replace(/-/gi,"");
                var useToDt   = $("#useToDt").val().replace(/-/gi,"");
                
                if  ((useToDt == "" && useFromDt != "") || (useToDt != "" && useFromDt == ""))
                {
                    alert("사용기간은 둘다 없거나, 둘다 있어야 합니다.");
                    return false;
                }
                
                if  ((useToDt != "" && useFromDt != "") && (useToDt < useFromDt))
                {
                    alert("사용기간은 '부터'가 '까지'보다 먼저 나와야 합니다.");
                    return false;
                }

                // 납품기한 일자
/*                 
                if($("#delyTime").val() == null || $("#delyTime").val() == ""){
                    alert("납품기한을 입력해주세요.");
                    $("#delyTime").focus();
                    return false;
                }
 */                
            }
            
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

            // 납품기한/응답만료일 구간 체크
            /*if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                var delyDt = $("#delyDt").val().replace(/-/gi,"");
                var rplyDt = $("#rplyDt").val().replace(/-/gi,"");

                if(rplyDt > delyDt){
                    alert("응답 만료일은 납품기한을 초과할 수 없습니다.");
                    $("#delyDt").focus();
                    return false;                    
                }
            }*/

            // 기관명
            if($("#realDmndOrgn").val() == null || $("#realDmndOrgn").val() == ""){
                alert("기업/기관명을 입력해주세요.");
                $("#realDmndOrgn").focus();
                return false;
            }

            return true;
        };
        
        var jsMetaPop = function(el, codeGroupCd, cdStart, cdEnd)
        {
            var codeLangCode = $("input[name=langCode]").val();
            $(el).colorbox({
                title 		: "",
                href         : "/korean/pt/popup/PD_metaPop.do?codeLangCode=" + codeLangCode + "&codeGroupCd=" + codeGroupCd + "&cdStart=" + cdStart + "&cdEnd=" + cdEnd,
                width        : "880",
                height       : "500",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
        };
        
        
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

      	
        /* 기관명 검색 팝업 호출 */
        var fnDmandSearch = function(el, val) {
        	$(el).colorbox({
                title        : "기관명 검색",
                href         : "/korean/pt/register/PD_organSearchPop.do?flag=F",
                width        : "900",
                height       : "700",
                overlayClose : false,
                iframe       : true,
                scrolling    : false
          });
        };
      	
    </script>

</head>
<body>
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <input type="hidden" name="bidGbnCd"  id="bidGbnCd"  value="1004" /> <!-- 입찰종류 (그룹코드 :2037 중 1002:견적요청, 사전견적 : 1004) -->
    <input type="hidden" name="userId"    id="userId"    value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="grpSeq"    id="grpSeq"    value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd" id="goodsTyCd" value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="goodsCd"   id="goodsCd"   value="<c:out value="${p_chkGoodsCode}" />" /> <!-- goodsCd -->
    <input type="hidden" name="goodArray" id="goodArray" value="" />
    <input type="hidden" name="vatGbn"    id="vatGbn"    value="" />
    <input type="hidden" name="talkGbn"   id="talkGbn"   value="" />
    <input type="hidden" name="userNm"    id="userNm"    value="${sessionScope['__usk'].userNm}" />
    
    <input type="hidden" name="scaling"     id="scaling"     value="" />
    <input type="hidden" name="runtimes"    id="runtimes"    value="" />
    <input type="hidden" name="middlewares" id="middlewares" value="" />
    <input type="hidden" name="frameworks"  id="frameworks"  value="" />
    <input type="hidden" name="services"    id="services"    value="" />
    <input type="hidden" name="addons"      id="addons"      value="" />
    
    <input type="hidden" name="langCode"    id="langCode"    value="00"/>

    <!-- content -->
    <section class="pageTit">
        <!-- 타이틀 영역 -->
        <div class="conWrap">
            <h2>견적요청</h2>
        </div>
        <!--// 타이틀 영역 -->
    </section>
    
    <div class="conWrap detailRequ paas">
        <!--
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
        -->
         
        <h3>시스템 요구사항</h3>
        <table class="tbl_st4" summary="시스템 요구사항">
	        <caption>시스템 요구사항</caption>
	        <colgroup>
	        	<col width="15%"/>
	        	<col width="*"/>
	        </colgroup>
        	<tbody>
        		<tr>
            	<th scope="col">호스팅방식</th>
            	<td><!-- 2064 -->
            		<span id="spanHostingMethod" class="sel_box">
                <select id="hostingMethod" name="hostingMethod">
                	<option value="">선택</option>
                  <!-- 2064 -->
                  <c:forEach items="${hostingMethodList}" var="hostingMethod" varStatus="status">
                  	<option value="${hostingMethod.PRVCD}">${hostingMethod.PRVNM}</option>    
                  </c:forEach>
                </select><label for="hostingMethod"></label>
                </span>
              </td>
            </tr>
            <tr>
            	<th scope="col">스케일링</th>
            	<td><!-- 2066 -->
            		<c:forEach items="${scalingList}" var="scaling" varStatus="status">
                	<label><input type="checkbox" class="scaling" id="scaling_${scaling.PRVCD}" name="scaling_${scaling.PRVCD}" value="${scaling.PRVCD}">${scaling.PRVNM}</label>
                </c:forEach>
              </td>
            </tr>
            <tr>
            	<th scope="col">플랫폼</th>
            	<td>
            		<span id="spanPlatform" class="sel_box">
                	<select id="platform" name="platform">
                  	<option value="">선택</option>
                    <!-- 2064 -->
                    <c:forEach items="${platformList}" var="platform" varStatus="status">
                    	<option value="${platform.PRVCD}">${platform.PRVNM}</option>    
                    </c:forEach>
                  </select><label for="platform"></label>
                </span>
              </td>
            </tr>
            <tr>
            	<th scope="col">런타임</th>
              <td>
              	<a id="metaSvcBtn" onclick="jsMetaPop(this, 2068, '', '');" href="javascript:;" class="btns st3">선택</a>
              	<span id="runtimesNm"></span>
              	<!-- 2068 -->
              	<%-- 
                <c:forEach items="${runtimesList}" var="runtimes" varStatus="status">
                	<label><input type="checkbox" class="runtimes" id="runtimes_${runtimes.PRVCD}" name="runtimes_${runtimes.PRVCD}" value="${runtimes.PRVCD}">${runtimes.PRVNM}</label>
                </c:forEach> --%>
              </td>
            </tr>
            <tr>
            	<th scope="col">미들웨어</th>
            	<td>
            		<a id="metaSvcBtn" onclick="jsMetaPop(this, 2069, '', '');" href="javascript:;" class="btns st3">선택</a>
                <span id="middlewaresNm"></span>
                <!-- 2069 -->
                <%-- 
                	<c:forEach items="${middlewaresList}" var="middlewares" varStatus="status">
                  	<label><input type="checkbox" class="middlewares" id="middlewares_${middlewares.PRVCD}" name="middlewares_${middlewares.PRVCD}" value="${middlewares.PRVCD}">${middlewares.PRVNM}</label>
                  </c:forEach> 
                --%>
              </td>
            </tr>
            <tr>
            	<th scope="col">프레임워크</th>
            	<td>
            		<a id="metaSvcBtn" onclick="jsMetaPop(this, 2070, '', '');" href="javascript:;" class="btns st3">선택</a>
                <span id="frameworksNm"></span>
                  <!-- 2070 -->
                  <%-- 
                  <c:forEach items="${frameworksList}" var="frameworks" varStatus="status">
                      <label><input type="checkbox" class="frameworks" id="frameworks_${frameworks.PRVCD}" name="frameworks_${frameworks.PRVCD}" value="${frameworks.PRVCD}">${frameworks.PRVNM}</label>
                  </c:forEach> --%>
              </td>
            </tr>
            <tr>
            	<th scope="col">서비스</th>
            	<td>
            		<a id="metaSvcBtn" onclick="jsMetaPop(this, 2071, '', '');" href="javascript:;" class="btns st3">선택</a>
               	<span id="servicesNm"></span>
               	
                   <!-- 2071 -->
                   <%-- 
                   <c:forEach items="${servicesList}" var="services" varStatus="status">
                       <label><input type="checkbox" class="services" id="services_${services.PRVCD}" name="services_${services.PRVCD}" value="${services.PRVCD}">${services.PRVNM}</label>
                   </c:forEach> --%>
            	</td>
            </tr>
            <tr>
             	<th scope="col">애드온</th>
             	<td>
             		<a id="metaSvcBtn" onclick="jsMetaPop(this, 2072, '', '');" href="javascript:;" class="btns st3">선택</a>
               	<span id="addonsNm"></span>
               	
                   <!-- 2072 -->
                   <%-- 
                   <c:forEach items="${addonsList}" var="addons" varStatus="status">
                       <label><input type="checkbox" class="addons" id="addons_${addons.PRVCD}" name="addons_${addons.PRVCD}" value="${addons.PRVCD}">${addons.PRVNM}</label>
                   </c:forEach> --%>
               </td>
           	</tr>
           	<tr>
               <th scope="col">확장기능여부</th>
               <td>
                   <label><input type="checkbox" name="extendFunction" id="vatGbnY" value="Y"/> 확장기능</label>
               </td>
           	</tr>
           	<tr>
           		<th scope="col">위치</th>
           		<td><!-- 2073 -->
	              <span id="spanGeolocations" class="sel_box">
	                  <select id="geolocations" name="geolocations">
	                      <option value="">선택</option>
	                      <!-- 2064 -->
	                      <c:forEach items="${geolocationsList}" var="geolocations" varStatus="status">
	                          <option value="${geolocations.PRVCD}">${geolocations.PRVNM}</option>    
	                      </c:forEach>
	                  </select><label for="geolocations"></label>
	              </span>
              </td>
            </tr>
          </tbody>
        </table>
    </div>
    <!--// content -->
    
    <div class="conWrap detailRequ iaas">
    <h3>납품 요구조건</h3>
    	<table class="tbl_st4" summary="납품 요구조건">
    	<caption>납품 요구조건</caption>
    	<colgroup>
    		<col width="15%"/>
    		<col width="*"/>
    		<col width="15%"/>
    		<col width="*"/>
    	</colgroup>
    	<tbody>
      	<tr>
      		<th scope="col">사용기간</th>
      		<td class="term" colspan="3">                    
          	<input type="text" id="useFromDt" name="useFromDt" readonly="readonly" title="시작일"/> <label for="useFromDt"></label>
            ~ 
            <input type="text" id="useToDt" name="useToDt" readonly="readonly" title="종료일"/> <label for="useToDt"></label>
            <span id="useTerm" > <%-- (12개월 00일) --%></span>
            <input type="hidden" name="puchBudgetAmt">
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
	        <th scope="col">희망 구매가</th>
	        <td class="vat">
	            <div class="unit">
	                <i>원</i>                
	                <div>
	                <!-- input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  -->
	                <input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onchange="getNumber(this);" onkeyup="getNumber(this);"><label for="hopePuchAmt"></label>
	                </div>
	            </div>
	            <input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked" title="VAT포함"/> <label for="vatGbnY">VAT포함</label>
	            <input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"  title="VAT미포함"/> <label for="vatGbnN">VAT미포함</label>
	        </td>
	        <th scope="col" class="requ">답변 만료일    </th>
	        <td class="term">
	        	<input type="text" id="rplyDt" name="rplyDt" title="답변 만료일"/><label for="rplyDt"></label>
	        </td>
        </tr>
        <tr>
        	<th scope="col">관련문서</th>
          <td colspan="3">
          	<div class="uploadFile">
            	<input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/> <label for="delyFileInput"></label>
            	<div>
            		<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('delyFile', 'delyFileInput');" alt="삭제" />                            
                <span class="btns st3">파일선택 <input type="file" name="delyFile" id="delyFile" class="delyFile" title="파일찾기" onchange="jsFileChk('delyFile', 'delyFileInput');"/></span>
              </div>
            </div>
          </td>
        </tr>            
        <tr>
        	<th scope="col">추가문의</th>
          <td colspan="3"><textarea id="notifyCont" name="notifyCont" title="추가문의"></textarea><label for="notifyCont"></label></td>
        </tr>
      </tbody>
    </table>
    
    <h3>요청자 정보</h3>
    <table class="tbl_st4" summary="요청자 정보">
    <caption>요청자 정보</caption>
    <colgroup>
    	<col width="15%"/>
    	<col width="*"/>
    	<col width="15%"/>
    	<col width="*"/>
    </colgroup>
    <tbody>
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
        	<input type="text" 		id="realDmndOrgn"			name="realDmndOrgn" value="${realDmndOrgn}" style="width:450px;" readonly="readonly"/><label for="realDmndOrgn"></label>
          <input type="hidden"	id="realDmndOrgnCd"		name="realDmndOrgnCd" value=""/>
          <input type="hidden"	id="realDmndBuseoCd"	name="realDmndBuseoCd" value="${realDmndBuseoCd }"/>
<%--                 
                	<input type="text" 		id="realDmndOrgn"			name="realDmndOrgn" value="${sessionScope['__usk'].cmpnyNm}" style="width:450px" readonly="readonly"/>
                	<input type="hidden"	id="realDmndOrgnCd"		name="realDmndOrgnCd" value=""/>
                	<input type="hidden"	id="realDmndBuseoCd"	name="realDmndBuseoCd" value=""/>
                	<input type="button"	id="dmndOrgnSearch"		name="dmndOrgnSearch" alt="기관명 조회" value="기관명 조회" class="btns st3" onclick="fnDmandSearch(this)"/>
 --%>                	               
        </td>
        <th scope="col" class="requ">이메일</th>
        <td><a href="mailto:${sessionScope['__usk'].email}">${sessionScope['__usk'].email}</a></td>
      </tr>
      <tr>
      	<th scope="col">직책</th>
        <td><input type="text" id="userPosition" name="userPosition" title="직책"/><label for="userPosition"></label></td>
        <th scope="col">대표전화</th>
        <td class="tel">
        	<input type="text" id="goodsChargerCttpc1" name="goodsChargerCttpc1" maxlength="3"/><label for="goodsChargerCttpc1"></label>
        	 - 
          <input type="text" id="goodsChargerCttpc2" name="goodsChargerCttpc2" maxlength="4"/><label for="goodsChargerCttpc2"></label>
           -
          <input type="text" id="goodsChargerCttpc3" name="goodsChargerCttpc3" maxlength="4"/><label for="goodsChargerCttpc3"></label>
        </td>
      </tr>
    </tbody>
  </table>

  <div class="btnArea rig">
  	<a href='#none' onclick="jsCommentCancel();" class="btns st1 icn icnDel"  title="취 소"> 취 소 </a>
  	<a href="#none" onclick="jsRequestSend();"   class="btns st1 icn icnSend" title="발 송"> 발 송 </a>
  </div>
</div>
    <!--// content -->
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
    $(document).ready(function() {
        $( "#useFromDt, #useToDt, #rplyDt" ).datepicker({
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