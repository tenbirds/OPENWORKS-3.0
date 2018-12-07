<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
	<c:choose>
       	<c:when test="${baseVo.cntrctSn == null}">
       		 <title>계약결과 수기등록</title>
           </c:when>
      	 	<c:otherwise>
       		 <title>계약결과상세</title>
       	</c:otherwise>
     </c:choose>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    <script type="text/javascript" src="/resources/web/commons/js/jquery.money.js"></script>
    <script type="text/javascript">
    	var tridx = '${fn:length(baseList)}';  
    	//추가 버튼
	    $(document).on("click","#btn_tr_add",function(){
	        var addText =  '<tr><input type="hidden" name="cntrctSvcSns" value="0"> '+
	        '   <td class="lef"><a href="#"  onclick="jsServiceSearchPopup(this, '+tridx+'); return false;" class="btns st3">검색</a>'+
			'					<span id="goodsArea'+tridx+'"></span><input type="hidden" name="goodsCodes" id="goodsCode'+tridx+'" ></td>'+
			'   <td class="cen"><span class="sel_box_sp"  style="width:90px;" ><select style="width:80px;" name="splyForms" onChange="jpUnitValChange(\''+tridx+'\',this.value);"><option value="1">월</otion><option value="2">년</otion><option value="3">일</otion><option value="4">무약정</otion></select></span></td>' +
			'   <td class="cen table_input"><input name="splyFormEtcs" id="splyFormEtcs'+tridx+'" type="text" style="width:70px;" maxlength="5" onkeydown="return onlyNumber(event)"> <span id="unit'+tridx+'">개월</span></td>' +
			'   <td class="cen table_input"><input name="cntrctAmounts" class="amount" type="text" style="width:150px;text-align:right;" maxlength="18" onKeyup="removeChar(event);$(this).toPrice();" onkeydown="return onlyNumber(event)"> 원</td>'+
	        '   <td><a href="#none" class="btns st5" id="btn_tr_del">- 삭제</a></td>'+
	        '</tr>';
			var trHtml = $( "#tbl_tr_add tr:last" );
			trHtml.after(addText);
			tridx++;
	    });
  
	  //삭제 버튼
	    $(document).on("click","#btn_tr_del",function(){
	        var trHtml = $(this).parents('tr');
	        trHtml.remove();
	         
	    });
	  
		//목록보기 버튼
	    function returnList(){
	        this.location.href ="/korean/pt/suplerCeart/BD_suplySttusList.do";
	    }
    	
    	//취소버튼
        function cancleList(){
            var confirmMsg = "취소하시면 내용이 삭제됩니다. 계속하시겠습니까?";
		    if(confirm(confirmMsg)) {
		      this.location.href ="/korean/pt/suplerCeart/BD_suplySttusList.do"; 
		    }
        }

    	function jpUnitValChange(idx, val){
    	    let unitStr= ["","개월","개월","일",""];
    	    $("#unit"+idx).html(unitStr[val]);
    	    if(val == '4'){
    	        $("#splyFormEtcs"+idx).val('0');
    	    	$("#splyFormEtcs"+idx).hide();
    	    }else
    	    	$("#splyFormEtcs"+idx).show();
    	}
    	
        // 공급서비스 찾기 팝업 호출
        function jsServiceSearchPopup(el, idx){
            $(el).colorbox({
                title : "계약서비스 선택",
                href : "/korean/pt/popup/PD_myServicePop2.do?idx="+idx,
                width : "640",
                height : "730",
                overlayClose : false,
                escKey : false,
                iframe : true
            });
        }
       
	    /* 
	     * 첨부파일 반영
	     */
	    var jsFileChk = function(inputId, inputIdFake, fileId){
	        // 기등록 첨부파일의 ID 제거
			var source = $("input[name="+inputId+"]").val();
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			var lastDot = filePath.lastIndexOf('.');
	        var ext = source.substring(lastDot + 1);
	         
	         var fileExt ="pdf";
	         if(fileExt.indexOf(ext.toLowerCase()) == -1){
	             alert( "지원하지 않는 확장자 형식입니다.\n pdf 형식만 가능합니다." );
	             document.getElementById(inputId+"Desc").value="";
	             return false;
	         }
			if(filePath == ""){
				return false;
			}			
			document.getElementById(inputId+"Desc").value = $("input[name="+inputId+"]").val(); 
	    };
	
	  //첨부된 파일중 ajax를 이용하여 파일 삭제
	    var jsFileDelete = function(element, seq, id){
	        if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
	            return false;
			
	        var url = "/korean/pt/sale/goods/ND_fileDelete.do";
	        $.post(url,
	            { fileId : id, fileSeq : seq },
	            function(result){
	                if(result == 1){
	                    $(element).parent().remove();
	                  //       self.location.reload();
	                }else{
	                    alert('파일을 삭제하지 못했습니다.');
	                }
	            }, 'json');
	    };

	    
	    /*파일추가*/
	    var jsFileAdd = function (){
	        var fileidx = $("input[type=file]").length+1;
	        var appendhtml="<div class='uploadFile'><input type='text' readonly='readonly' name='ctrtcSnInput' id='ctrtcSnVal"+fileidx+"Desc' title='파일명' />";
	        appendhtml = appendhtml + "<div><span class='btns st3'>파일선택";
	        appendhtml = appendhtml + "<input type='file'  name='ctrtcSnVal"+fileidx+"' id='ctrtcSnVal"+fileidx+"' title='파일찾기'  onchange=\"javascript:jsFileChk('ctrtcSnVal"+fileidx+"', 'ctrtcSnInput"+fileidx+"', 'ctrtcSn');\" >";
	        appendhtml = appendhtml + "</span></div></div>";
	        $('#uploadArea').append(appendhtml);
	    }
	    
	 // 저장 vaildation 체크
	    function checkEditor(){
			
	        if($('#svcNm').val() == ''){
	            alert("사업명을 입력하세요.");
	            $('#svcNm').focus();
	            return false;
	        }
	        
	        //이용자 구분 
	        var usrTycd = $(":radio[name='sbscrbTyCd']:checked").val();
            if(usrTycd =='3002'){
		        if($('#orgnCode').val() == ''){
		            alert("기관명을선택하세요.");
		            $('#orgnCode').focus();
		            return false;
		        }
            }
            
             if(usrTycd =='2002'){
                if($('#cmpnyNm').val() == ''){
		            alert("회사명을 입력하세요.");
		            $('#cmpnyNm').focus();
		            return false;
		        }
            }
             
	        // 계약일 체크
	        if($('#cntrDt').val() == ''){
	            alert("계약체결일을 입력하세요.");
	            $('#cntrDt').focus();
	            return false;
	        }
	        
	        // 계약기간 체크
	        if($('#cntrctBeginDe').val() == ''){
	            alert("계약기간을 선택하세요.");
	            $('#cntrctBeginDe').focus();
	            return false;
	        }
	        
	        if($('#cntrctEndDe').val() == ''){
	            alert("계약기간을 선택하세요.");
	            $('#cntrctEndDe').focus();
	            return false;
	        }
	        // 계약종료일은 계약시작일 보다 클 수 없음.
	        var cntrctBeginDe = $('#cntrctBeginDe').val().replace(/-/gi,"");;
	        var cntrctEndDe = $('#cntrctEndDe').val().replace(/-/gi,"");;
	        if(cntrctBeginDe > cntrctEndDe){
	            alert("계약종료일은 계약시작일 보다 클 수 없습니다.");
	            $('#cntrctBeginDe').focus();
	            return false;
	        }
	       
	        // 계약서 첨부파일 체크 
	     	var fileChk=0;
            $("input[name=ctrtcSnInput]").each(function(){
                if(this.value != "") fileChk++;
            });
            if(fileChk < 1){
                alert("계약서파일 1개이상 첨부하세요.");
                return false;
            }
                        
            if($("#rlCntrctInsttAt:checked").val() =="Y"){
                var userSe = $(":radio[name='userSe']:checked").val();
                if(userSe == "3"){  //공공기관 
                    if($("#oganArea").text()==""){
                        alert("실제이용자정보의 기관명을 검색 및 등록 하세요.");
                       return false;
                    }
                }else if(userSe == "2"){ //민간기업
                    
                    if($("#realCmpny").val() ==""){
                        alert("실제이용자정보의 회사명을 입력하세요.");
                        $('#realCmpny').focus();
                    	return false;
                    }
                }
            }
                
            var serviecChk=0;
            var serviecReqChk=true;
            var i=0;
            $("input[name=goodsCodes]").each(function(){
                if(this.value != "") serviecChk++;
                if ($("input[name=splyFormEtcs]").eq(i).val() =="" ||  $("input[name=cntrctAmounts]").eq(i).val() == "" ){
                    serviecReqChk=false;
                    return false;
                }
                i++;
            });
            if(serviecChk < 1){
                 alert("계약체결된 서비스 1개이상 등록하세요.");
                 return false;
            }
            if(serviecReqChk ==false){
                alert("계약체결 서비스의 서비스,총계약기간, 계약금액은 필수 입력입니다.");
                return false;
            }
           
          
          
	        return true;
	    }
	    // 저장, 수정 버튼 클릭
	    var jsCntrctCmpl = function(type){
	        
	        if(checkEditor()){
	            var confirmMsg = "계약결과를 저장하시겠습니까?";
				    if(confirm(confirmMsg)) {
				        jsCntrctSubmit();
				}
	        }
	    };
	
	    var jsOganSameChk = function(type){
	        if($("#cntrctSn").val() == ""){
		        if($("#orgSameChk")){
			        if(!checkEditor()) {$("#rlCntrctInsttAt").prop("checked", false);} 
			        else{ 
			            $("#p_rlCntrctInsttAt").val("Y");
			            jsCntrctSubmit();
			        }
		        }
	        }else{
	           if($("#rlCntrctInsttAt:checked").val() =='Y'){
	            	$("#realuserInfo").show();
	                 	$("#realuserInfo").show();
	                 	$('#userSe03').attr("checked", true);
				    	$('#sportAt').attr("checked", false);
				    	$('#oganArea').html('');
				    	$('#realCmpny').val('');
				    	$('.useSeInfo2').hide();
				    	$('.useSeInfo3').show();
	           } else 
	            	$("#realuserInfo").hide();
	        }
		}

	    var jsCntrctSubmit = function(type){
	        if($('#commUserId').val() == ''){
	            if( $('#sbscrbTyCd30').is(':checked')){
	                $('#purchsInsttNm').val($('#orgn_nm').val());
	            }
	            if( $('#sbscrbTyCd20').is(':checked'))
		        	$('#purchsInsttNm').val($('#cmpnyNm').val());
	        }
		
           if($("#cntrctSn").val() == ''){
                $("#cntrctSn").val(0);
            } 
            // 첨부파일
            $("input[type=file]").each(function(){
                if(this.value == '')
                    $("#"+this.id).attr("disabled","disabled");
                if($("input[name=ctrtcSnInput][id="+this.id+"Desc").val() == "")
                    $("#"+this.id).attr("disabled","disabled");
            });
            
            $("input[name=cntrctAmounts]").each(function(){
                this.value = this.value.replace(/\,/gi, "");
            });
            
            // 실제 저장 처리
            $("#dataForm").attr("action", "ND_suplerCntrctManageRegistAction.do");
            $("#dataForm").submit();
	    }
	    
		// 숫자만 입력(onKeyDown)
	    var onlyNumber = function(event){
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			
			if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return ;
			else
				return false;
		};
		
		// 숫자가 아닌 문자 제거(onKeyUp)
	    var removeChar = function(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) {
				return;
			} else {
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
			}
		};
		
		
	    var organSearchPop = function(el) {
	        $(el).colorbox({
	            title  : "기관명 검색",
	            href   : "/korean/pt/register/PD_organSearchPop.do",
	            width  : "600",
	            height : "700",
	            overlayClose : false,
	            iframe : true
	        });
	    };
		
	    var userOrganInsertPop = function(el) {
	        $(el).colorbox({
	            title  : "실제이용자정보 검색 및 등록",
	            //href   : "/korean/pt/popup/PD_organSearchList.do?cntrctSn=${baseVo.cntrctSn}",
	            href   : "/korean/pt/popup/PD_organSearchList2.do?cntrctSn=${baseVo.cntrctSn}",	            		
	            width  : "1090",
	            height : "450",
	            overlayClose : false,
	            iframe : true
	        });
	    };
	    
	    var nonInforSetting = function (id){
	    	if(id == "orgnInfo"){
	    	    $('.orgnInfo').show();
	    	    $('.companyInfo').hide();
	    	    $('#cmpnyNm').val('');
	    	}else if(id == "companyInfo"){
	    	    $('.orgnInfo').hide();
	    	    $('.companyInfo').show();
	    	    $('#orgnCode').val('');
	    	    $('#buseoCode').val('');
	    	    $('#orgn_nm').val('');
	    	}else if(id == "useSeInfo3"){
	    	    if(confirm("등록된 회사명정보가 초기화됩니다. 정보이용자 구분을 변경하시겠습니까?")) {
		    		$('.useSeInfo2').hide();
			    	$('.useSeInfo3').show();
			    	$('#sportAt').attr("checked", false);
			    	$('#oganArea').html('');
			    	$('#realCmpny').val('');
	    	    }else
	    	        $("#userSe02").attr("checked", true);
	    	}else if(id == "useSeInfo2"){
	     	    if(confirm("등록된 기관정보가 초기화됩니다. 정보이용자 구분을 변경하시겠습니까?")) {
		    	    $('.useSeInfo3').hide();
		    	    $('.useSeInfo2').show();
		    	    $('#sportAt').attr("checked", false);
		    	    $('#oganArea').html('');
		    		$('#realCmpny').val('');
	    	    }else
	    	        $("#userSe03").attr("checked", true);
	    	}
	    }

	    
        // 공급서비스 찾기 팝업 호출
        //function jsServiceSearchPopup(el, idx){
		function jsImmeServiceRegist(el){        	

            $(el).colorbox({
                title : "임의 서비스 등록",
                href : "/korean/pt/popup/PD_immeServiceRegistPop.do",
                width : "740",
                height : "200",
                overlayClose : false,
                escKey : false,
                iframe : true
            });
        }
	    
	    
	    /* 기관명 검색 팝업 호출 */
/* 	    var organSearchPop = function(el, val) {
	    	$(el).colorbox({
	            title        : "기관명 검색",
	            href         : "PD_organSearchPop.do",
	            width        : "900",
	            height       : "700",
	            overlayClose : false,
	            iframe       : true,
	            scrolling    : false
	      });
	    }; */	    
    </script>

</head>
<body>
	
    <!-- content -->
	<div class="conWrap">
		<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
            <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>    		 <!--  목록 페이지 조회조건1 -->
            <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     		<!--  목록 페이지 조회조건2 -->
            <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   		<!--  목록 페이지 검색어 -->
            <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>       		 <!--  현재 페이지 -->

		    <input type="hidden" name="cntrctSn"      id="cntrctSn"      value="${baseVo.cntrctSn}"/>        <!--  계약관리정보 순번 -->
		    <%-- <input type="hidden" name="goodsCode"     id="goodsCode"     value="${baseVo.goodsCode}"/>       <!--  서비스 코드 --> --%>
		    <input type="hidden" name="suplerId"      id="suplerId"      value="${baseVo.suplerId}"/>        <!--  제공자ID -->
            <input type="hidden" name="sleInsttNm"    id="sleInsttNm"    value="${baseVo.sleInsttNm}"/>      <!--  제공자 기관명 -->
            
            <input type="hidden" name="userId"          id="userId"          value="${sessionScope['__usk'].masterId}"/><!--  이용자ID -->
            <input type="hidden" name="commUserId"      id="commUserId"      value="${baseVo.commUserId}"/>         	<!--  이용자ID -->
		    <input type="hidden" name="commUserNm"      id="commUserNm"      value="${baseVo.commUserNm}"/>        	  	<!--  이용자명 -->
		    <input type="hidden" name="purchsInsttNm"   id="purchsInsttNm"   value="${baseVo.purchsInsttNm}"/>        	<!--  구매회사 -->
            
            
            
            <input type="hidden" id="mbtlnum" name="mbtlnum" value=""/>
            <input type="hidden" id="email" name="email" value=""/>
            <input type="hidden" id="commUserType" value='none'>
            
            <input type="hidden" name="p_rlCntrctInsttAt" id="p_rlCntrctInsttAt">
            <input type="hidden" id="cntrNum" name="cntrNum" >
            <c:if test="${not empty baseVo.userSn}">
            <input type="hidden" id="userSn" name="userSn" value="${baseVo.userSn}"/>
            </c:if> 
		    <div class="myceart detail">
 		
            <h3>계약정보</h3>
<!-- 
				<c:if test="${ImmeServiceRegistYN eq 'Y'}">
		            <div class="btnArea rig">				
						<a href="#" onclick="javascript:jsImmeServiceRegist(this); return false;"><span class="btns st3"> 임의서비스 등록</span></a>				
					</div>
				</c:if>
 -->				
            <div class="btnArea rig">				
				<a href="#" onclick="javascript:jsImmeServiceRegist(this); return false;"><span class="btns st3"> 임의서비스 등록</span></a>				
			</div>

            <table class="tbl_st4 e2" border="0">
					<tr>
						<th class="requ">계약번호</th>
						<td colspan="3">  ${baseVo.cntrNum}</td>
					</tr>
					<tR>
						<th class="requ">사업명</th><td colspan="3">
							  <c:choose>
                                <c:when test="${baseVo.certResultCode == null or baseVo.certResultCode eq ''}">
                                    <input type="text" name="svcNm" id="svcNm" value="${baseVo.svcNm}" <c:if test="${baseVo.registMthdCode eq 1002}"> readonly="readonly"</c:if> maxlength="100" />
                                </c:when>
                                <c:otherwise>
                                ${baseVo.svcNm}
                                </c:otherwise>
                            </c:choose>
						</td>
					</tr>
					<tr>
					<th class="requ">계약자 구분 </th>
					<td colspan="3">
						<input type="radio" name="sbscrbTyCd"  id="sbscrbTyCd30" onClick="nonInforSetting('orgnInfo');" checked value="3002" /> 공공기관
						<input type="radio" name="sbscrbTyCd"  id="sbscrbTyCd20" onClick="nonInforSetting('companyInfo');" value="2002" /> 민간기업
					</td>
					</tr>
					<tr class="orgnInfo">
						<th class="requ">계약기관명</th>
						<td colspan="3">
							<input type="hidden" name="orgnCode" id="orgnCode" value="${baseVo.orgnCode}"  />
							<input type="text" name="orgn_nm" id="orgn_nm" readonly style="width:650px;" value="${baseVo.orgnNm}" />
							<!--  a href="#" class="btns st3" onclick="organSearchPop(this);">기관검색</a -->
							<a href="#" onclick="organSearchPop(this, 'B');"><span class="btns st3">기관검색</span></a>
							<input type="hidden" name="buseoCode" id="buseoCode" value="${baseVo.orgnCode}" />
						</td>
					</tr>
					<tr class="companyInfo" style="display:none;">
						<th class="requ">계약회사명</th>
						<td colspan="3"><input type="text" name="cmpnyNm" id="cmpnyNm" value="${baseVo.orgnNm}" /></td>
					</tr>
					<tr>
						<th class="requ">계약체결일</th>
						<td class="term" colspan="3">
                            <c:choose>
                                <c:when test="${baseVo.certResultCode == null or baseVo.certResultCode eq ''}">
                                    <input type="text" name="cntrDt" id="cntrDt" value="${baseVo.cntrDt}" readonly/>
                                </c:when>
                                <c:otherwise>
                                ${baseVo.cntrDt}
                                </c:otherwise>
                            </c:choose>
						</td>
					</tr>
					<tr>
						<th class="requ">계약기간</th>
						<td class="term" colspan="3">
                            <c:choose>
                                <c:when test="${baseVo.certResultCode == null or baseVo.certResultCode eq ''}">
                                    <input type="text" name="cntrctBeginDe" id="cntrctBeginDe" value="${baseVo.cntrctBeginDe}" readonly/> ~ <input type="text" name="cntrctEndDe" id="cntrctEndDe" value="${baseVo.cntrctEndDe}" />
                                </c:when>
                                <c:otherwise>
                                ${baseVo.cntrctBeginDe}&nbsp;~&nbsp;${baseVo.cntrctEndDe}
                                </c:otherwise>
                            </c:choose>
						</td>
					</tr>
					<tr>
						<th class="requ">계약서(PDF)</th>
						<td colspan="3">
							<a href="#" onClick='jsFileAdd()'><span class="btns st5"> + 추가</span></a>   
							
							<span id="uploadArea">
							 <c:choose>
								<c:when test="${baseVo.ctrtcSn == null or baseVo.ctrtcSn eq '0'}">
								<input type="hidden" name="ctrtcSn" id="ctrtcSn" value="-1"/>
								</c:when>
							</c:choose> 
							<c:if test="${baseVo.ctrtcSn != null and baseVo.ctrtcSn ne '0'}">
							<input type="hidden" name="ctrtcSn" id="ctrtcSn" value="${baseVo.ctrtcSn}"/>
							<c:forEach items="${baseVo.ctrtcSnList}" var="fileVo" varStatus="status1">
								<div class="uploadFile">
									<input type="hidden" name="ctrtcSnInput" id="ctrtcSnValDesc" title="파일명"  value="${fileVo.localNm}"/>
									<p id="uploadedFile" class="uploaded">
											<span><a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.localNm}" class="aDeisable">${fileVo.localNm} <span class="tx_gray">(${fileVo.fileSize}, ${fileVo.fileType})</span></a>
												<a href="#" onclick="jsFileDelete(this, '${baseVo.ctrtcSn}', '${fileVo.fileId}'); return false;" />삭제</a></span>
									</p>
								</div>
							</c:forEach>
							</c:if>
							<c:if test="${baseVo.ctrtcSn == null or baseVo.ctrtcSn eq '0'}">
							<div class="uploadFile">
										<input type="text" readonly="readonly" name="ctrtcSnInput" id="ctrtcSnValDesc" title="파일명" />
										<div>
											<span class="btns st3">
												파일선택
												<input type="file"  name="ctrtcSnVal" id="ctrtcSnVal" title="파일찾기" onchange="javascript:jsFileChk('ctrtcSnVal', 'ctrtcSnInput', 'ctrtcSn');"/>
											</span>
										</div>
								</div>
																		
							</c:if>	
							</span>
						</td>
					</tr>
				</table>

				<h3>계약체결 서비스</h3>
				<div class="btnArea rig">				
					<a href="#none" id="btn_tr_add"><span class="btns st5"> + 추가</span></a>
				</div>
				<table class="tbl_st3" id="tbl_tr_add">
					<caption></caption>
					<colgroup>
						<col width="25%" />
						<col width="18%" />
						<col width="13%" />
						<col />
						<col width="10%" />
					</colgroup>
					<tbody>
						<tr>
							<th><span class="requ"></span>서비스명</th>
							<th><span class="requ"></span>계약단위</th>
							<th><span class="requ"></span>총 계약기간</th>
							<th><span class="requ"></span>총 계약금액 (VAT포함)</th>
							<th></th>
						</tr>
						<c:forEach items="${baseList}" var="listData" varStatus="status">
						 <tr><input type="hidden" name="cntrctSvcSns" value="${listData.cntrctSvcSn}"> 
							<td class="lef"><a href="#"  onclick="jsServiceSearchPopup(this,'${status.index}'); return false;"><span class="btns st3">검색</span></a>
							<span id="goodsArea${status.index}">${listData.goodsName}</span><input type="hidden" name="goodsCodes" id="goodsCode${status.index}" value="${listData.goodsCode}">
							</td>
							<td class="cen"><span class="sel_box"><select name="splyForms" onChange="jpUnitValChange('${status.index}',this.value);">
								<option value="1" <c:if test="${listData.splyForm eq '1'}">selected</c:if>>월</option>
								<option value="2" <c:if test="${listData.splyForm eq '2'}">selected</c:if>>년</option>
								<option value="3" <c:if test="${listData.splyForm eq '3'}">selected</c:if>>일</option>
								<option value="4" <c:if test="${listData.splyForm eq '4'}">selected</c:if>>무약정</option>
								</select></span></td>
							<td><input name="splyFormEtcs" id="splyFormEtcs${status.index}" type="text" style="width:70px;" maxlength="5" value="${listData.splyFormEtc}" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)"> <span id="unit${status.index}">개월</span></td>
							<td class="cen"><input name="cntrctAmounts" type="text" style="width:150px;text-align:right;" maxlength="18" value="<fmt:formatNumber value="${listData.cntrctAmount}"/>" onKeyup="removeChar(event);$(this).toPrice();" onkeydown="return onlyNumber(event)"> 원</td>
							<td><a href="#none" id="btn_tr_del"><span class="btns st5">- 삭제</span></a></td>
						</tr><script>jpUnitValChange('${status.index}','${listData.splyForm}');</script>
						</c:forEach>
						<c:if test="${empty baseList}">
							<tr><input type="hidden" name="cntrctSvcSns" value="0"> 
							<td class="lef"><a href="#"  onclick="jsServiceSearchPopup(this,''); return false;"><span class="btns st3">검색</span></a>
							<span id="goodsArea"></span><input type="hidden" name="goodsCodes" id="goodsCode" value=""></td>
							<td class="cen"><span class="sel_box"><select name="splyForms" onChange="jpUnitValChange('',this.value);">
								<option value="1">월</option>
								<option value="2">년</option>
								<option value="3">일</option>
								<option value="4">무약정</option>
								</select></span></td>
							<td><input name="splyFormEtcs" id="splyFormEtcs" type="text" style="width:70px;" maxlength="5" value=""  onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)" > <span id="unit">개월</span></td>
							<td class="cen"><input name="cntrctAmounts" type="text"  style="width:150px;text-align:right;" maxlength="18" onKeyup="removeChar(event);$(this).toPrice();" onkeydown="return onlyNumber(event)" > 원</td>
							<td><a href="#none" id="btn_tr_del"><span class="btns st5">- 삭제</span></a></td>
						</tr>
						</c:if>
					</tbody>
				</table>
				
				<h3>실제이용자정보 <label><input name="rlCntrctInsttAt" id="rlCntrctInsttAt" type="checkbox" value="Y" onClick="jsOganSameChk('');"
				<c:if test="${rlCntrctInsttAt eq 'Y' || baseVo.rlCntrctInsttAt  eq 'Y'}">checked</c:if> /> 계약기관과 동일하지 않음</label></h3>
					<table class="tbl_st4" id="realuserInfo">
						<caption></caption>
						<colgroup>
							<col width="22%" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th class="requ">이용자 구분</th>
								<td><input name="userSe" id="userSe03" type="radio" value="3" onClick="nonInforSetting('useSeInfo3');"  <c:if test="${baseVo.userSe eq '3'}">checked</c:if>/> <label>공공기관</label> 
								    <input name="userSe" id="userSe02" type="radio" value="2" onClick="nonInforSetting('useSeInfo2');"  <c:if test="${baseVo.userSe eq '2'}">checked</c:if>/> <label>민간기업</label></td>
							</tr>
							<tr class="useSeInfo3">
								<th>지원사업 여부</th>
								<td><label><input name="sportAt" id="sportAt" type="checkbox" value="Y" <c:if test="${baseVo.sportAt eq 'Y'}">checked</c:if> /> 지원사업</label></td>
							</tr>
							<tr class="useSeInfo3">
								<th class="requ">기관명</th>
								<td><a href="#"  onclick="userOrganInsertPop(this);"><span class="btns st3">검색 및 등록</span></a> 
									<span id="oganArea"></span></td>
							</tr>
							<tr class="useSeInfo2">
								<th class="requ">회사명</th>
								<td><input name="realCmpny" id="realCmpny" type="text" placeholder="예) 씨앗기업, 씨앗컨설팅" value="${baseVo.realOrgNm}" maxlength="500"/></td>
							</tr>
						</tbody>
					</table>
					
					<script type="text/javascript">
					<c:if test="${baseVo.userSe eq '3'}">
							$(".useSeInfo3").show();
							$(".useSeInfo2").hide(); 
						<c:if test="${not empty baseVo.realOrgNm}">
							$("#oganArea").html("${baseVo.realOrgNm} 외 ${baseVo.realBuesoCnt} 건");
						</c:if>
					</c:if>
					<c:if test="${baseVo.userSe eq '2'}">$(".useSeInfo2").show();$(".useSeInfo3").hide(); $("#realCmpny").val("${baseVo.realOrgNm}");</c:if>
					</script>
				<!-- button area -->
				<div class="btnArea rig">
				
					<a href="#none" onclick="jsList('BD_cntrctManageList.do');" id="btn_tr_del"><span class="btns st5">목록</span></a>
				

					<c:if test="${baseVo.certResultCode == null or baseVo.certResultCode eq ''}">
                        <c:choose>
                        	<c:when test="${baseVo.cntrctSn == null}">
                        		<a href="#" onclick="javascript:jsCntrctCmpl('save'); return false;"><span class="btns st1 icn icnSave">저장</span></a>
                            	<a href="#" onclick="javascript:cancleList(); return false;"><span class="btns st3 icn icnBck">취소</span></a>
                            </c:when>
                       	 	<c:otherwise>
	                       		<a href="#" onclick="javascript:jsCntrctCmpl('updata'); return false;"><span class="btns st1 icn icnSave">수정</span></a>
	                       		<a href="#" onclick="javascript:returnList(); return false;"><span class="btns st3 icn icnBck">확인</span></a>
                        	</c:otherwise>
                        </c:choose>
                    </c:if>
                    

                    <c:if test="${baseVo.certResultCode != null}">
	                    <a href="#" onclick="javascript:returnList(); return false;"><span class="btns st1 icn icnList">목록보기</span></a>
                    </c:if>
                </div>
                <!--// button area -->
			</div>
		</form>
	</div>
	<!--// content -->
	
  <script>
	$(document).ready(function() {
		
	    <c:if test="${baseVo.sbscrbTyCd eq 3002 or baseVo.sbscrbTyCd == null}">
			$('#sbscrbTyCd30').attr('checked', 'checked');
			$('.orgnInfo').show();
			$('.companyInfo').hide();
		</c:if>
		<c:if test="${baseVo.sbscrbTyCd eq 2002}">
			$('#sbscrbTyCd20').attr('checked', 'checked');
			$('.orgnInfo').hide();
			$('.companyInfo').show();
		</c:if>
		/*계약일 , 계약기간, 계약금액 */
	    $( "#cntrDt, #cntrctBeginDe, #cntrctEndDe" ).datepicker({
	        showOn: "both", 
	        buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	        buttonImageOnly: false,
	        buttonText: "달력"
	    });
	    // 공급가 및 수량 컬럼 선택시 전체선택 되도록(초기값이 0이므로)
        $(".cntrctamount").focus(function() { $(this).select(); } );
        
        <c:if test="${empty baseVo.cntrctSn or baseVo.rlCntrctInsttAt  ne 'Y'}">
        	$("#realuserInfo").hide();
        </c:if>
	});
  </script>
</body>
</html>