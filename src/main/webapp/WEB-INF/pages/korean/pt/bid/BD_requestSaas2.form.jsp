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
    <title>상세정보(견적)요청서 Saas</title>
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

        $(document).ready(function() {

        }); //ready
        
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
		
		
		
		
		
		
		
		
        // 견적요청서 발송
        var jsRequestSend = function()
        {
            if ( checkEditor() ) // 입력 필수값 체크
            {
                //if(confirm("견적요청서를 발송 하시겠습니까?"))  
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
                        
                        $(this).find('tbody').each(function()
                        {                            
                            var functionName2 = $(this).find('input[name=functionName2]').val();
                            var amount2       = $(this).find('input[name=amount2]').val();
                            var unitCode2     = $(this).find('select[name=unitCode2]').val();
                            
                            functionName2 = functionName2.replace('|', ' ');
                            functionName2 = functionName2.replace('^', ' ');
                            
                            var option = functionName2 + '|' + amount2 + '|' + unitCode2 ;
                            
                            arrOption.push( option );
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
                    
                    $("#dataForm").attr("action", "ND_requestSaas2Action.do");
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
        
    </script>

</head>
<body>

<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <input type="hidden" name="bidGbnCd"  id="bidGbnCd"  value="1002" /> <!-- 입찰종류 (그룹코드 :2037 중 1002:견적요청, 사전견적 : 1004) --> 
    <input type="hidden" name="userId"    id="userId"    value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="grpSeq"    id="grpSeq"    value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd" id="goodsTyCd" value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="goodsCd"   id="goodsCd"   value="<c:out value="${p_goodsCd}" />" /> <!-- goodsCd -->
    <input type="hidden" name="goodArray" id="goodArray" value="" />
    <input type="hidden" name="vatGbn"    id="vatGbn"    value="" />
    <input type="hidden" name="talkGbn"   id="talkGbn"   value="" />
    <input type="hidden" name="userNm"    id="userNm"    value="${sessionScope['__usk'].userNm}" />
    
    <input type="hidden" name="serviceSupplyMethod" id="serviceSupplyMethod"  value="" />
    <input type="hidden" name="encryption"          id="encryption"           value="" />
    
    
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>상세정보(견적) 요청서</h2>
		</div>
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
		 
		<!-- 
		
		시스템 요구사항
		
		 --> 
		<h3>시스템 요구사항</h3>
		<table class="tbl_st4">
		<tr>
			<th>제공방법</th>
			<td>
				<span class="sel_box">
					<select id="splyMothSys" name="supportMethod">
					    <option value="">선택</option>
					    <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
					        <option value="${supplyMethodCode.PRVCD}">${supplyMethodCode.PRVNM}</option>    
					    </c:forEach>
					</select>
				</span>
			</td>
			<th>사용자/관리자 분리</th>
			<td>
				<span class="sel_box">
					<select id="splyMothSys" name="userManagerSeparate">
					    <option value="">선택</option>
					    <c:forEach items="${userManagerSeparateList}" var="userManagerSeparate" varStatus="status">
					        <option value="${userManagerSeparate.PRVCD}">${userManagerSeparate.PRVNM}</option>    
					    </c:forEach>    
					</select>
				</span>
			</td>
		</tr>
		<tr>
			<th>서비스제공방식</th>
			<td colspan="3">
			    <c:forEach items="${serviceSupplyMethodList}" var="serviceSupplyMethod" varStatus="status">
			        <label><input type="checkbox" id="serviceSupplyMethod_${serviceSupplyMethod.PRVCD}" name="serviceSupplyMethod_${serviceSupplyMethod.PRVCD}" value="${serviceSupplyMethod.PRVCD}">${serviceSupplyMethod.PRVNM}</label>
			    </c:forEach>
			</td>
		</tr>
		<tr>
			<th>암호화</th>
			<td colspan="3">								
			    <c:forEach items="${encryptionList}" var="encryption" varStatus="status">					            
			        <label><input type="checkbox" id="encryption_${encryption.PRVCD}" name="encryption_${encryption.PRVCD}" value="${encryption.PRVCD}">${encryption.PRVNM}</label> 					       
			    </c:forEach>				
			</td>
		</tr>
		<tr>
			<th>다중플랫폼지원</th>
			<td colspan="3">
				<span class="sel_box">
					<select id="splyMothSys" name="multiPlatform">
					    <option value="">선택</option>
					    <option value="Y">예</option>
					    <option value="N">아니오</option>
					</select>
				</span>
			</td>
		</tr>
		</table>
		
		<!-- 
		
		필요기능
		
		 -->		
		<div id="divMain" class="clsMain" attrMstNo="0">				
			
			<input type="hidden" name="hidenOptions1" value="" />
			
			<div style="margin-top: 15px;">
				<div style="border:1px solid white; line-height:20px; float:left;padding-right: 10px;">
					<h3 style="margin-top: 5px;">필요기능</h3>
				</div>		
				<a href="#" onclick="funAddMastTbl(); return false;" class="btns st3">추가</a> 
			</div>		
			 
			<table id="tabMain_0" class="tbl_st4">
			<caption></caption>
			<tbody>
			<tr>
				<th>기능명</th>
				<td class="vat" colspan="3">
					<input type="text" name="functionName1" />
				</td>
			</tr>
			<tr>
				<th>수량</th>
				<td class="vat">
					<input type="text" name="amount1" />
				</td>
				<th>단위</th>
				<td class="vat">
					<span class="sel_box">
						<select id="splyMothSys" name="unitCode1">
						    <option value="">선택</option>
						    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
						        <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
						    </c:forEach>
						</select>
					</span>
				</td>
			</tr>
			<tr>
				<th colspan="3">옵션</th>
				<th>
					<a href="#" onclick="funAddDetailRow(this); return false;" class="btns st3">추가</a>						 
				</th>
			</tr>
			<tr>
				<th>기능명</th>
				<td class="vat" colspan="3">
					<input type="text" name="functionName2" />
				</td>
			</tr>
			<tr>
				<th>수량</th>
				<td class="vat">
					<input type="text" name="amount2" />
				</td>
				<th>단위</th>
				<td class="vat">
					<span class="sel_box">
						<select name="unitCode2">
						    <option value="">선택</option>
						    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
						        <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
						    </c:forEach>
						</select>
					</span>
				</td>
			</tr>
			</tbody>
			</table>		
		</div>
		
		<%-- 
		
		'필요기능' > '옵션' 추가 템플릿 --------------------------------------------------------------------------------------------------- 
		
		--%>
		<textarea id="tmpMastTextarea" style="display:none">
			
		<div class="clsMain" attrMstNo="">
		
			<input type="hidden" name="hidenOptions1" value="" />
		
			<div style="margin-top: 15px;">
				<div style="border:1px solid white; line-height:20px; float:left;padding-right: 10px;">
					<h3 style="margin-top: 5px;">필요기능</h3>
				</div>		
				<a href="#" onclick="funDeleteMastTbl(this); return false;" class="btns st2">삭제</a>
			</div>		
			 
			<table id="tabMain_" name="tblMain" class="tbl_st4">
			<caption></caption>
			<tbody>
			<tr>
				<th>기능명</th>
				<td class="vat" colspan="3">
					<input type="text" name="functionName1" />
				</td>
			</tr>
			<tr>
				<th>수량</th>
				<td class="vat">
					<input type="text" name="amount1" />
				</td>
				<th>단위</th>
				<td class="vat">
					<span class="sel_box">
						<select id="splyMothSys" name="unitCode1">
						    <option value="">선택</option>
						</select>
					</span>
				</td>
			</tr>
			<tr>
				<th colspan="3">옵션</th>
				<th>
					<a href="#" onclick="funAddDetailRow(this); return false;" class="btns st3">추가</a>						 
				</th>
			</tr>
			<tr>
				<th>기능명</th>
				<td class="vat" colspan="3">
					<input type="text" name="functionName2" />
				</td>
			</tr>
			<tr>
				<th>수량</th>
				<td class="vat">
					<input type="text" name="amount2" />
				</td>
				<th>단위</th>
				<td class="vat">
					<span class="sel_box">
						<select name="unitCode2">
						    <option value="">선택</option>
						    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
						        <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
						    </c:forEach>
						</select>
					</span>
				</td>
			</tr>
			</tbody>
			</table>
		</div>
		
		</textarea>
		
		<%-- 
		
		'옵션' 추가 템플릿 ----------------------------------------------------------------------------------------------------------------- 
		
		--%>
		<textarea id="tmpDetailRow" style="display:none">
	    <tbody>
			<tr>
				<th colspan="3">옵션</th>
				<th>
					<a href="#" onclick="funDeleteDetailRow(this); return false;" class="btns st2">삭제</a>						 
				</th>
			</tr>
			<tr>
				<th>기능명</th>
				<td class="vat" colspan="3">
					<input type="text" name="functionName2" />
				</td>
			</tr>
			<tr>
				<th>수량</th>
				<td class="vat">
					<input type="text" name="amount2" />
				</td>
				<th>단위</th>
				<td class="vat">
					<span class="sel_box">
						<select name="unitCode2">
						    <option value="">선택</option>
						    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
						        <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
						    </c:forEach>
						</select>
					</span>
				</td>
			</tr>	
		</tbody>
		</textarea>		
	</div>
	
	
	<!-- 
	
	납품 요구조건
	
	 -->
	<div class="conWrap detailRequ iaas">
		<h3>납품 요구조건</h3>
		<table class="tbl_st4">
			<tr>
				<th>사용기간</th>
				<td class="term" colspan="3">					
					  <input type="text" id="useFromDt" name="useFromDt" readonly="readonly"/>
					~ <input type="text" id="useToDt" name="useToDt" readonly="readonly"/>
					<span id="useTerm"/> <%-- (12개월 00일) --%>
					
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
				<th>희망 구매가</th>
				<td class="vat">
					<div class="unit">
						<i>원</i>				
						<div><input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></div>
					</div>
					<label><input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked"/> VAT포함</label>
					<label><input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"/> VAT미포함</label>
				</td>
				<th class="requ">답변 만료일</th>
				<td class="term"><input type="text" id="rplyDt" name="rplyDt" readonly="readonly"/></td>
			</tr>			 
			<tr>
				<th>관련문서</th>
				<td colspan="3">
					<div class="uploadFile">
						<input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/>
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('delyFile', 'delyFileInput');" alt="삭제" />							
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="delyFile" id="delyFile" class="delyFile" title="파일찾기" onchange="jsFileChk('delyFile', 'delyFileInput');"/>
			            	</span>
		            	</div>
		            </div>
				</td>
			</tr>			
			<tr>
				<th>추가문의</th>
				<td colspan="3"><textarea id="addCont" name="addCont" ></textarea></td>
			</tr>
		</table>
			
		<!-- 
		
		요청자 정보
		
		 -->		
		<h3>요청자 정보</h3>
		<table class="tbl_st4">
			<tr>
				<th class="requ">작성자</th>
				<td>${sessionScope['__usk'].userNm}</td>
				<input type="hidden" name="goodsChargerNm" value="${sessionScope['__usk'].userNm}" />
				<th class="requ">휴대전화</th>
				<td>${sessionScope['__usk'].mbtlnum}</td>
			</tr>
			<tr>
				<th class="requ">기업/기관명</th>
				<td><input type="text" id="realDmndOrgn" name="realDmndOrgn" value="${sessionScope['__usk'].cmpnyNm}"/></td>
				<th class="requ">이메일</th>
				<td><a href="mailto:">${sessionScope['__usk'].email}</a></td>
			</tr>
			<tr>
				<th>직책</th>
				<td><input type="text" id="userPosition" name="userPosition"/></td>
				<th>대표전화</th>
				<td class="tel">
					<input type="text" id="goodsChargerCttpc1" maxlength="3" name="goodsChargerCttpc1" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> - 
					<input type="text" id="goodsChargerCttpc2" maxlength="4" name="goodsChargerCttpc2" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
					<input type="text" id="goodsChargerCttpc3" maxlength="4" name="goodsChargerCttpc3" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" />
				</td>
			</tr>					
		</table>

		<div class="btnArea rig">
			<a href="#" onclick="jsRequestSend(); return false;" class="btns st1 icn icnSend"> 발 송 </a>
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