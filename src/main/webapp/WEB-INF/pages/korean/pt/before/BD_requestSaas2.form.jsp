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
    <title>사전견적서 SaaS</title>
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
        
        // 사전견적 요청서 발송
        var jsRequestSend = function()
        {
            if ( checkEditor() ) // 입력 필수값 체크
            {
                //if ( confirm("견적요청서를 발송 하시겠습니까?") ) 
                //{
                    // 체크박스 데이터 전환 Saas
                    var serviceSupplyMethod=[]; // 서비스제공방식 체크박스를 합친다.
                    var encryption=[];          // 암호화 체크박스를 합친다.
                    
                    $('.serviceSupplyMethod').each(function() { if ($(this).is(':checked')) serviceSupplyMethod.push( $(this).val() ); });
                    $('.encryption').each(function()          { if ($(this).is(':checked')) encryption.push( $(this).val() );          });
                    
                    $('#serviceSupplyMethod').val(serviceSupplyMethod.join(','));
                    $('#encryption').val(encryption.join(','));
                    
                    
                    // n개의 필요기능을 순회...
                    // n개의각각의 option의 값들을 묶어서 hidenOptions1의 값으로 설정한다.
                    $('.clsMain').each(function()
                    {
                        var arrOption = [] ;
                        
                        $(this).find("tbody[type=option]").each(function()
                        {                            
                            
                            var functionName2 = $(this).find('input[name=functionName2]').val();
                            var amount2       = $(this).find('input[name=amount2]').val();
                            var unitCode2     = $(this).find('select[name=unitCode2]').val();
                            
                            functionName2 = functionName2.replace('|', ' ');
                            functionName2 = functionName2.replace('^', ' ');
                            
                            if ((functionName2 != "") || (amount2 != "") || (unitCode2!=""))
                            {
                                arrOption.push( functionName2 + '|' + amount2 + '|' + unitCode2 );
                            }
                            
                        });                           
                        
                        $(this).find('input[name=hidenOptions1]').val( arrOption.join('^') );
                    });

                    // VAT여부
                    if($('input:radio[name=vatGbnRadio]:checked').attr("id") == "vatGbnY"){
                        $("#vatGbn").val("Y");
                    }else{
                        $("#vatGbn").val("N");
                    }
                    
                    // 첨부파일
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });
                    
                    $("#dataForm").attr("action", "ND_beforeRequestSaas2Action.do");
                    $("#dataForm").submit();
                //}
            }
        };
        
        // 견적요청서 필수 입력값 체크
        var checkEditor = function()
        {   
            // 답변 만료일
            if ($("#rplyDt").val() == null || $("#rplyDt").val() == "")
            {
                alert("답변 만료일을 입력해주세요.");
                
                $("#rplyDt").focus();
                return false;
            }
            else
            {
                // 응답 만료일이 현재일 이전일 경우 return
                var rplyDt = $("#rplyDt").val().replace(/-/gi,"");
                
                if (nowDate > rplyDt)
                {
                    
                    alert("답변 만료일은 현재일 이전일수 없습니다.");
                    $("#rplyDt").focus();
                    return false;
                }
            }
            
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
            
            
            // 기관명
            if($("#realDmndOrgn").val() == null || $("#realDmndOrgn").val() == "")
            {
                alert("기업/기관명을 입력해주세요.");
                
                $("#realDmndOrgn").focus();
                return false;
            }

            return true;
        };
        
        
        
        
        
        
        
        
        
        
        //////////////////////////////////////////////////////////////////////
        
        // 마스터 번호 초기화 = 0
        var mastNo = 0 ;
        
        
        // 테이블사항 추가
        var funAddMastTbl = function()
        {         
            mastNo ++ ; // 마스터 번호 추가           
            
            // 마스터 테이블 템플릿트 추가
            $("#divMain").append($("#tmpMastTextarea").val()); 
            
            // 내부테이블ID를 'tabMain_ + [마스터 번호]' 로 변경
            $("#divMain").find("#tabMain_").attr("id","tabMain_"+mastNo);  
            
            // 'tabMain_ + [마스터 번호]' 의 부모DIV의 attrMstNo(마스터 번호) 속성(attr)을 셋팅한다.
            $("#tabMain_"+mastNo).parent().attr("attrMstNo",mastNo) ;
            
            $('.sel_box').jqTransform();
        }
        
        // 테이블사항 삭제
        var funDeleteMastTbl = function(obj)
        {
            $(obj).parent().parent().remove();
        };        
        
        
        // 란사항 추가
        var funAddDetailRow = function(obj)
        {       
            // 'tabMain_ + [마스터 번호]' 의 부모DIV의 attrMstNo(마스터 번호) 속성(attr)을 읽어온다 
            var attrMstNo = $(obj).parent().parent().parent().parent().parent().attr("attrMstNo") ; 
                
            // 해당 'tabMain_ + [마스터 번호]' ID를 가진 테이블에 란 템플릿을 추가한다. 
            $("#tabMain_"+attrMstNo).append($("#tmpDetailRow").val());
           
            $('.sel_box').jqTransform();  
        };
        
        // 란사항 삭제
        var funDeleteDetailRow = function(obj)
        {
            $(obj).parent().parent().parent().remove();
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
	
	<input type="hidden" name="serviceSupplyMethod" id="serviceSupplyMethod"  value="" />
	<input type="hidden" name="encryption"          id="encryption"           value="" />
  <section class="pageTit">
	  <!-- 타이틀 영역 -->
	  <div class="conWrap"><h2>견적요청</h2></div>
	  <!--// 타이틀 영역 -->
  </section>
  
  <div class="conWrap detailRequ saas">
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
	<!-- 시스템 요구사항 --> 
  <h3>시스템 요구사항</h3>
  <table class="tbl_st4" summary="시스템 요구사항">
	  <caption>시스템 요구사항</caption>
	  <colgroup>
	  	<col width="20" />
	  	<col width="*" />
	  	<col width="20" />
	  	<col width="*" />
	  </colgroup>
	  <thead hidden="hidden">
	  	<tr>
	  		<th scope="col" colspan="4">제공방법</th>
	  	</tr>
	  </thead>
	  <tfoot hidden="hidden">
	  	<tr>
	  		<th scope="col" colspan="4">제공방법</th>
	  	</tr>
	  </tfoot>
	  <tbody>
	  	<tr>
	    	<th scope="col">제공방법</th>
	      <td scope="col">
	      	<span class="sel_box">
	        <select id="supportMethod" name="supportMethod" title="제공방법">
	        	<option value="">선택</option>
	          <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
	          <option value="${supplyMethodCode.PRVCD}">${supplyMethodCode.PRVNM}</option>    
	          </c:forEach>
	        </select><label for="supportMethod" title="제공방법" hidden="hidden">제공방법</label>
	        </span>
	      </td>
	      <th scope="col">사용자/관리자 분리</th>
	      <td scope="col">
		      <span class="sel_box">
		        <select id="userManagerSeparate" name="userManagerSeparate"  title="사용자/관리자 분리">
		          <option value="">선택</option>
		          <c:forEach items="${userManagerSeparateList}" var="userManagerSeparate" varStatus="status">
		          <option value="${userManagerSeparate.PRVCD}">${userManagerSeparate.PRVNM}</option>    
		          </c:forEach>    
		        </select><label for="userManagerSeparate" title="사용자/관리자 분리" hidden="hidden">사용자/관리자 분리</label>
		      </span>
	      </td>
	  	</tr>
		  <tr>
	      <th scope="col">서비스제공방식</th>
	      <td colspan="3" scope="col">
	      	<c:forEach items="${serviceSupplyMethodList}" var="serviceSupplyMethod" varStatus="status">
	        <input type="checkbox" class="serviceSupplyMethod" id="serviceSupplyMethod_${serviceSupplyMethod.PRVCD}" name="serviceSupplyMethod_${serviceSupplyMethod.PRVCD}" value="${serviceSupplyMethod.PRVCD}" />
	        <label for="serviceSupplyMethod_${serviceSupplyMethod.PRVCD}" title="${serviceSupplyMethod.PRVNM}" >${serviceSupplyMethod.PRVNM}</label>
	        </c:forEach>
	      </td>
	  	</tr>
	  	<tr>
	      <th scope="col">암호화</th>
	      <td colspan="3" scope="col">                                
	      	<c:forEach items="${encryptionList}" var="encryption" varStatus="status">                                
	        	<input type="checkbox" class="encryption" id="encryption_${encryption.PRVCD}" name="encryption_${encryption.PRVCD}" value="${encryption.PRVCD}" />
	        	<label for="encryption_${encryption.PRVCD}" title="${encryption.PRVNM}" >${encryption.PRVNM}</label>                            
	        </c:forEach>                
	      </td>
	  	</tr>
	  	<tr>
	      <th scope="col">다중플랫폼지원</th>
	      <td colspan="3" scope="col">
	          <span class="sel_box">
	              <select id="multiPlatform" name="multiPlatform" title="다중플랫폼지원">
	                  <option value="">선택</option>
	                  <option value="Y">예</option>
	                  <option value="N">아니오</option>
	              </select><label for="multiPlatform" title="다중플랫폼지원" hidden="hidden">다중플랫폼지원</label>
	          </span>
	      </td>
	  	</tr>
	  </tbody>
	</table>
	
	<!--필요기능-->
	<div id="divMain">
		<div class="clsMain" attrMstNo="0">
			<input type="hidden" name="hidenOptions1" value="" />
			<div style="margin-top: 15px;">
	    	<div style="border:1px solid white; line-height:20px; float:left;padding-right: 10px;">
	      	<h3 style="margin-top: 5px;">필요기능</h3>
	      </div>        
	      <!-- a href="#" onclick="funAddMastTbl(); return false;" class="btns st3">추가</a --> 
	    </div>        
	             
	    <table id="tabMain_0" class="tbl_st4" summary="필요기능">
	    	<caption>필요기능</caption>
	    	<colgroup>
	    		<col width="20px"/>
	    		<col width="*"/>
	    		<col width="20px"/>
	    		<col width="*"/>
	    	</colgroup>
	    	<thead hidden="hidden">
	    		<tr>
	    			<th scope="col" colspan="4">필요기능</th>
	    		</tr>
	    	</thead>
	    	<tfoot hidden="hidden">
	    		<tr>
	    			<th scope="col" colspan="4">필요기능</th>
	    		</tr>
	    	</tfoot>
	      <tbody>
	      	<tr>
	        	<th scope="col">기능명</th>
	          <td class="vat" colspan="4" scope="col">
	          	<input type="text" id="functionName1" name="functionName1" title="기능명"/>
	          	<label for="functionName1" title="기능명" hidden="hidden">기능명</label>
	          </td>
	        </tr>
	        <tr>
	        	<th scope="col">수량</th>
	          <td class="vat" scope="col" colspan="2">
	          	<div class="unit">
	            	<input type="text" id="amount1" name="amount1"  maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="수량"/>
	            	<label for="amount1" title="수량" hidden="hidden">수량</label>
	            </div>    
	          </td>
	          <th scope="col">단위</th>
	          <td class="vat" scope="col" colspan="2">
	          	<span class="sel_box">
	            <select id="unitCode1" name="unitCode1" title="단위">
	            	<option value="">선택</option>
	              <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
	              <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
	              </c:forEach>
	            </select><label for="unitCode1" title="단위" hidden="hidden">단위</label>
	            </span>
	          </td>
	        </tr>
	      	<tr>
	      		<th rowspan="3" scope="col">옵션</th>
	      		<td colspan="4"><!-- a href="#" onclick="funAddDetailRow(this); return false;" class="btns st3">추가</a --></td>
	        </tr>
	        <tr>
	        	<th scope="col">기능명</th>
	          <td class="vat" colspan="4" scope="col">
	          	<input type="text" id="functionName2" name="functionName2" value="" title="기능명"/>
	          	<label for="functionName2" title="기능명" hidden="hidden">기능명</label>
	          </td>
	        </tr>
	        <tr>
	        	<th scope="col">수량</th>
	          <td class="vat" scope="col">
	          	<div class="unit">
	            	<input type="text" id="amount2" name="amount2"  maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="수량" />
	            	<label for="amount2" title="수량" hidden="hidden">수량</label>
	            </div>
	          </td>
	          <th scope="col">단위</th>
	          <td class="vat" scope="col">
	          	<span class="sel_box">
	            <select id="unitCode2" name="unitCode2" title="단위">
	            	<option value="">선택</option>
	              <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
	              <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
	              </c:forEach>
	            </select><label for="unitCode2" title="단위" hidden="hidden">단위</label>
	            </span>
	          </td>
	        </tr>
	      </tbody>
	    </table>
    </div>        
  </div>
		<!-- '필요기능' > '옵션' 추가 템플릿 --------------------------------------------------------------------------------------------------- --> 
		<textarea id="tmpMastTextarea" name="tmpMastTextarea" style="display:none"  title="옵션">
			<div class="clsMain" attrMstNo="">
				<input type="hidden" name="hidenOptions1" value="" />
				<div style="margin-top: 15px;">
		      <div style="border:1px solid white; line-height:20px; float:left;padding-right: 10px;">
		      	<h3 style="margin-top: 5px;">필요기능</h3>
		      </div>        
		    	<span onclick="funDeleteMastTbl(this); return false;" class="btns st2" style="cursor: pointer;">삭제</span>
		    </div>
		    <table id="tabMain_" id="tblMain" name="tblMain" class="tbl_st4" summary="필요기능">
		    	<caption>필요기능</caption>
		    	<colgroup>
		    		<col width="20"/>
		    		<col width="*"/>
		    	</colgroup>
		    	<thead hidden="hidden">
		    		<tr>
		    			<th scope="col" colspan="4">필요기능 옵션</th>
		    		</tr>
		    	</thead>
		    	<tfoot hidden="hidden">
		    		<tr>
		    			<th scope="col" colspan="4">필요기능 옵션</th>
		    		</tr>
		    	</tfoot>
		      <tbody>
		      	<tr>
		        	<th scope="col">기능명</th>
		          <td class="vat" colspan="3" scope="col">
		          	<input type="text" name="functionName1" />
		          </td>
		        </tr>
		        <tr>
		        	<th scope="col">수량</th>
		        	<td class="vat" scope="col">
		          	<div class="unit">
		            	<input type="text" id="amount1" name="amount1"  maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="수량"/>
		            	<label for="amount1" title="수량" hidden="hidden">수량</label>
		            </div>
		          </td>
		          <th scope="col">단위</th>
		          <td class="vat" scope="col">
		          	<span class="sel_box">
		            <select id="unitCode1" name="unitCode1" title="단위">
		            	<option value="">선택</option>
		              <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
		              <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
		              </c:forEach>
		            </select><label for="unitCode1" title="단위" hidden="hidden">단위</label>
		            </span>
		          </td>
		        </tr>
		      	<tr>
		      		<th colspan="3">옵션</th>
		      		<th scope="col"><!-- a href="#" onclick="funAddDetailRow(this); return false;" class="btns st3">추가</a --></th>
		        </tr>
		        <tr>
		        	<th scope="col">기능명</th>
		        	<td class="vat" colspan="3" scope="col">
		        		<input type="text" id="functionName2" name="functionName2" title="기능명"/>
		        		<label for="functionName2" title="기능명" hidden="hidden">기능명</label>
		        	</td>
		        </tr>
		        <tr>
		        	<th scope="col">수량</th>
		          <td class="vat" scope="col">
		          	<div class="unit">
		            	<input type="text" id="amount2" name="amount2"  maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="수량"/>
		            	<label for="amount2" title="수량" hidden="hidden">수량</label>
		            </div>
		          </td>
		          <th scope="col">단위</th>
		          <td class="vat" scope="col">
		          	<span class="sel_box">
		            <select id="unitCode2" name="unitCode2" title="단위">
		            	<option value="">선택</option>
		              <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
		              <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
		              </c:forEach>
		            </select><label for="unitCode2" title="단위" hidden="hidden">단위</label>
		          	</span>
		        	</td>
		      	</tr>
		    	</tbody>
		  	</table>
	  	</div>
	  </textarea><label for="tmpMastTextarea" title="옵션" hidden="hidden">옵션</label>
	  
	  <!-- '옵션' 추가 템플릿 ----------------------------------------------------------------------------------------------------------------- --> 
	  <textarea id="tmpDetailRow" name="tmpDetailRow" style="display:none" title="옵션">
		  <tbody type="option">
		  	<tr>
		  		<th colspan="3" scope="col">옵션</th>
		  		<th scope="col">
		  			<span onclick="funDeleteDetailRow(this); return false;" class="btns st2" style="cursor: pointer;">삭제</span>
		  		</th>
		    </tr>
		    <tr>
		    	<th scope="col">기능명</th>
		      <td class="vat" colspan="3" scope="col">
		      	<input type="text" id="functionName2" name="functionName2" title="기능명"/>
		      	<label for="functionName2" title="기능명" hidden="hidden">기능명</label>
		      </td>
		    </tr>
		    <tr>
		    	<th scope="col">수량</th>
		      <td class="vat" scope="col">
		      	<div class="unit">
		        	<input type="text" name="amount2"  maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="수량"/>
		        	<label for="amount2" title="수량" hidden="hidden">수량</label>
		        </div>    
		      </td>
		      <th scope="col">단위</th>
		      <td class="vat" scope="col">
		      	<span class="sel_box">
		        <select name="unitCode2">
		        	<option value="">선택</option>
		          <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
		          <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
		          </c:forEach>
		        </select><label for="unitCode2" title="단위" hidden="hidden">단위</label>
		        </span>
		      </td>
		    </tr>    
		  </tbody>
	  </textarea><label for="tmpDetailRow" title="옵션" hidden="hidden">옵션</label>
	</div>
    
  <!--납품 요구조건-->
  <div class="conWrap detailRequ iaas">
  <h3>납품 요구조건</h3>
  	<table class="tbl_st4" summary="납품 요구조건">
  	<caption>납품 요구조건</caption>
  	<colgroup>
  		<col width="20px" />
  		<col width="*" />
  		<col width="20px" />
  		<col width="*" />
  	</colgroup>
  	<thead hidden="hidden">
  		<tr>
  			<th colspan="4" scope="col">납품 요구조건</th>
  		</tr>
  	</thead>
  	<tfoot hidden="hidden">
  		<tr>
  			<th colspan="4" scope="col">납품 요구조건</th>
  		</tr>
  	</tfoot>
  	<tbody>
  		<tr>
  			<th scope="col">사용기간</th>
        <td class="term" colspan="3" scope="col">                    
        	<input type="text" id="useFromDt" name="useFromDt" readonly="readonly" title="시작년월일"/> <label for="useFromDt" title="사용기간" hidden="hidden">사용기간</label>
          ~ 
          <input type="text" id="useToDt" name="useToDt" readonly="readonly" title="종료년월일"/> <label for="useToDt" title="사용기간" hidden="hidden">사용기간</label>
          <span id="useTerm" title="사용기간"></span> <%-- (12개월 00일) --%>
          <input type="hidden" id="puchBudgetAmt" name="puchBudgetAmt" />
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
        <td class="vat" scope="col">
        	<div class="unit">
          	<i>원</i>
            <div>
            	<!-- input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  -->
              <input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onchange="getNumber(this);" onkeyup="getNumber(this);" title="희망 구매가"/>
              <label for="hopePuchAmt" title="희망 구매가" hidden="hidden">희망 구매가</label>
            </div>
          </div>
          <input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked"/> <label for="vatGbnY" title="VAT포함">VAT포함</label>
          <input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"/> <label for="vatGbnN" title="VAT미포함">VAT미포함</label>
        </td>
        <th class="requ" scope="col">답변 만료일</th>
        <td class="term" scope="col">
        	<input type="text" id="rplyDt" name="rplyDt" readonly="readonly" title="답변 만료일"/><label for="rplyDt" title="답변 만료일" hidden="hidden">답변 만료일</label>
        </td>
      </tr>             
      <tr>
      	<th scope="col">관련문서</th>
      	<td colspan="3" scope="col">
      		<div class="uploadFile">
          	<input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/><label for="delyFileInput" title="파일명" hidden="hidden">파일명</label>
            <div>
            	<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('delyFile', 'delyFileInput');" alt="삭제" />
            	<span class="btns st3">
            		파일선택
            		<input type="file" id="delyFile"  name="delyFile" class="delyFile" title="파일찾기" onchange="jsFileChk('delyFile', 'delyFileInput');" />
            		<label for="delyFile" title="파일찾기" hidden="hidden">파일찾기</label>
              </span>
            </div>
          </div>
        </td>
      </tr>            
    	<tr>
    		<th scope="col">추가문의</th>
    		<td colspan="3" scope="col">
    			<textarea id="addCont" name="addCont" title="추가문의"></textarea><label for="addCont"></label>
    			<label for="addCont" title="추가문의" hidden="hidden">추가문의</label>
    		</td>
      </tr>
    </tbody>
  </table>
  
  <!--요청자 정보-->
  <h3>요청자 정보</h3>
  <input type="hidden" name="goodsChargerNm" value="${sessionScope['__usk'].userNm}" />
  <table class="tbl_st4" summary="요청자 정보">
  <caption>요청자 정보</caption>
  	<colgroup>
  		<col width="20px" />
  		<col width="*" />
  		<col width="20px" />
  		<col width="*" />
  	</colgroup>
  	<thead hidden="hidden">
  		<tr>
  			<th colspan="4" scope="col">요청자 정보</th>
  		</tr>
  	</thead>
  	<tfoot hidden="hidden">
  		<tr>
  			<th colspan="4" scope="col">요청자 정보</th>
  		</tr>
  	</tfoot>
  	<tbody>
  		<tr>
  			<th class="requ" scope="col">작성자</th>
        <td scope="col">${sessionScope['__usk'].userNm}</td>
        <th class="requ" scope="col">휴대전화</th>
        <td scope="col">${sessionScope['__usk'].mbtlnum}</td>
      </tr>
      <tr>
      	<th class="requ" scope="col">기업/기관명</th>
        <td scope="col">
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
          <!-- <input type="button"	id="dmndOrgnSearch"		name="dmndOrgnSearch" alt="기관명 조회" value="기관명 조회" class="btns st3" onclick="fnDmandSearch(this)"/> -->
        </td>
        <th class="requ" scope="col">이메일</th>
        <td scope="col"><a href="mailto:">${sessionScope['__usk'].email}</a></td>
      </tr>
      <tr>
      	<th scope="col">직책</th>
        <td scope="col">
        	<input type="text" id="userPosition" name="userPosition" title="직책"/>
        	<label for="userPosition" title="직책" hidden="hidden">직책</label>
        </td>
        <th scope="col">대표전화</th>
        <td class="tel" scope="col">
        	<input type="text" id="goodsChargerCttpc1" maxlength="3" name="goodsChargerCttpc1" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="지역번호"/>
        	<label for="goodsChargerCttpc1" title="지역번호" hidden="hidden">지역번호</label>
        	 - 
          <input type="text" id="goodsChargerCttpc2" maxlength="4" name="goodsChargerCttpc2" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="국번"/>
          <label for="goodsChargerCttpc2" title="국번" hidden="hidden">국번</label>
           -
          <input type="text" id="goodsChargerCttpc3" maxlength="4" name="goodsChargerCttpc3" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" title="뒷번호"/>
          <label for="goodsChargerCttpc3" title="뒷번호" hidden="hidden">뒷번호</label>
        </td>
      </tr> 
    </tbody>                   
  </table>

  <div class="btnArea rig">
  	<a href='#none' onclick="jsCommentCancel();" class="btns st1 icn icnDel" 	title="취소"> 취 소 </a>
    <a href="#none" onclick="jsRequestSend();"   class="btns st1 icn icnSend" title="발송"> 발 송 </a>
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