<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>견적 요청서</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <style type="text/css">
     
        input[type=text].width50p { width : 50%; }
        
    </style>

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
	    
        $(document).ready(function() 
        {
            // 제공가 및 수량 컬럼 선택시 전체선택 되도록(초기값이 0이므로)
            $("#splyAmt").focus(function() { $(this).select(); } );            
        });

        //  목록보기 버튼
        function returnList()
        {
            document.dataForm.action = "/korean/pt/suplerCeart/BD_beforeRequestList.do";                                                               
            document.dataForm.method = "POST";
            document.dataForm.submit();        
        }
    
        /* 
         * 첨부파일 반영
         */
        function jsFileChk(inputId, inputIdFake, fileId){
            // 기등록 첨부파일의 ID 제거
            $("input[name="+fileId+"]").val("0");
            
            document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
            
            var inputFile = document.getElementById(inputId);
            var filePath = inputFile.value;
            
            if(filePath == ""){
                return false;
            }
            document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
        }
    
        /* 
         * 첨부파일 삭제
         */
        function jsFileDelete(inputId, inputIdFake, fileId){

            // 기등록 첨부파일의 ID 제거
            $("input[name="+fileId+"]").val("0");
    
            document.getElementById(inputIdFake).value="";
            $("input[name="+inputId+"]").val("");
            
            $('#uploadedFile').hide();
            
        }
        
        // 숫자만 입력하도록 체크
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
        var jsOnlyNumber = function(event){
            var key = window.event ? event.keyCode : event.which;    
    
            if ((event.shiftKey == false) && ((key  > 47 && key  < 58) || (key  > 95 && key  < 106)
            || key  == 35 || key  == 36 || key  == 37 || key  == 39  // 방향키 좌우,home,end  
            || key  == 8  || key  == 46 || key  == 9)
            ) {
                return true;
            }else {
                return false;
            }
        };
        
        /* 크롬- 숫자만 입력하도록 체크*/
		function removeChar(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
    
        // 발송처리
        var sendRequest = function()
        {
            if  ($('#splyAmt').val()=='')
            {
                alert("제공금액을 입력하세요.");
                $('#splyAmt').focus();
                return false;
            }
            
            //if  (confirm("발송 하시겠습니까?"))
            //{
                // 첨부파일
                $("input[type=file]").each(function(){
                    if(this.value == ''){
                        $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                        $("#"+this.id).attr("disabled","disabled");
                    }
                });
                
                /* Pass - goods/BD_Before_Paas2.view.jsp */
                	
                	// 체크박스 데이터 전환 Pass
                    var scaling     = [];     
                    var runtimes    = [];  
                    var middlewares  = [];  
                    var frameworks  = [];  
                    var services    = [];  
                    var addons      = [];                      

                    $('.scaling').each(function()     {    if ($(this).is(':checked')) scaling.push( $(this).val() );     });
                    $('.runtimes').each(function()    {    if ($(this).is(':checked')) runtimes.push( $(this).val() );    });
                    $('.middlewares').each(function() {    if ($(this).is(':checked')) middlewares.push( $(this).val() );  });
                    $('.frameworks').each(function()  {    if ($(this).is(':checked')) frameworks.push( $(this).val() );  });
                    $('.services').each(function()    {    if ($(this).is(':checked')) services.push( $(this).val() );    });
                    $('.addons').each(function()      {    if ($(this).is(':checked')) addons.push( $(this).val() );      });
                    
                    $('#scaling').val( scaling.join(',') );
                    $('#runtimes').val( runtimes.join(',') );
                    $('#middlewares').val( middlewares.join(',') );
                    $('#frameworks').val( frameworks.join(',') );
                    $('#services').val( services.join(',') );
                    $('#addons').val( addons.join(',') );
                
                
                /* Sass - goods/BD_Before_Saas2.view.jsp */
                
                	// 체크박스 데이터 전환 Saas
                    var serviceSupplyMethod=[]; // 서비스제공방식 체크박스를 합친다.
                    var encryption=[];          // 암호화 체크박스를 합친다.
                    
					$('.serviceSupplyMethod').each(function() { if ($(this).is(':checked')) serviceSupplyMethod.push( $(this).val() ); });
                    $('.encryption').each(function()          { if ($(this).is(':checked')) encryption.push( $(this).val() );          });
                    
                    $('#serviceSupplyMethod').val(serviceSupplyMethod.join(','));
                    $('#encryption').val(encryption.join(','));
                
                	// n개의 필요기능을 순회...
                    // n개의각각의 option의 값들을 묶어서 hidenOptions1의 값으로 설정한다.
                	$(".clsMain").each(function()
                	{
						var arrOption = [] ;
                        
                        $(this).find('tbody').each(function()
                        {
                            var functionName2 = $(this).find('input[name=functionName2]').val();
                            var amount2       = $(this).find('input[name=amount2]').val();
                            var unitCode2     = $(this).find('select[name=unitCode2]').val();
                            
                            functionName2 = functionName2.replace('|', ' ');
                            functionName2 = functionName2.replace('^', ' ');
                            
                            arrOption.push( functionName2 + '|' + amount2 + '|' + unitCode2 );
                        });
                        
                        $(this).find('input[name=hidenOptions1]').val( arrOption.join('^') );
                	});
                    

                /* Iass - goods/BD_Before_Iaas2.view.jsp */
                
                
                
                /* Scs - goods/BD_Before_Scs2.view.jsp */
                var cnslRelm  = [];     
	        	var cnslScope = [];     
	        	var excArea   = [];     
	
	            $('.cnslRelm').each(function()   { if ($(this).is(':checked')) cnslRelm.push( $(this).val() );   });
	            $('.cnslScope').each(function()  { if ($(this).is(':checked')) cnslScope.push( $(this).val() );  });
	            $('.excArea').each(function()    { if ($(this).is(':checked')) excArea.push( $(this).val() );    });
	            
	            $('#cnslRelm').val( cnslRelm.join(',') );
	            $('#cnslScope').val( cnslScope.join(',') );
	            $('#excArea').val( excArea.join(',') );	                
    
                // 실제 저장 처리
                $("#dataForm").attr("action", "ND_suplerSendBeforeRequestAction.do");
                $("#dataForm").submit();
            //}
            
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
    </script>

</head>
<body>
<!-- <div class="conWrap"> -->
	<div class="supAdm answAdm detail">
	  <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>        <!--  목록 페이지 조회조건1 -->
			<input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>        <!--  목록 페이지 조회조건2 -->
			<input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>      <!--  목록 페이지 검색어 -->
			<input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>           <!--  현재 페이지 -->
			<input type="hidden" name="notifyNum"     id="notifyNum"     value="${dataList.notifyNum}"/> <!--  공고번호 -->
			<input type="hidden" name="notifySeq"     id="notifySeq"     value="${dataList.notifySeq}"/> <!--  공고차수 -->
			<input type="hidden" name="goodKndCd"     id="goodKndCd"     value="${baseList.goodKndCd}"/> <!--  서비스구분 -->
                
      <p class="viewTit">${dataList.goodsName}&nbsp;[${dataList.suplerNm}]</p>
      <h3>요청자 정보</h3>
      <table class="tbl_st4 e4" summary="요청자 정보">
      	<caption>요청자 정보</caption>
      	<colgroup>
      		<col width="80px"/>
      		<col width="*"/>
      		<col width="80px"/>
      		<col width="*"/>
      	</colgroup>
      	<thead hidden="hidden">
      		<tr>
      			<th scope="col" colspan="4">작성자|휴대전화|기업/기관명|이메일|직책|대표전화</th>
      		</tr>
      	</thead>
      	<tfoot hidden="hidden">
      		<tr>
      			<th scope="row" colspan="4">작성자|휴대전화|기업/기관명|이메일|직책|대표전화</th>
      		</tr>
      	</tfoot>
      	<tbody>      	
		      <tr>
		         <th scope="col">작성자</th>
		         <td>${baseList.endsUserNm}</td>
		         <th scope="col">휴대전화</th>
		         <td>${baseList.endsMbtlnum}</td>
		     	</tr>
		     	<tr>
		         <th scope="col">기업/기관명</th>
		         <td>${baseList.realDmndOrgn}</td>
		         <th scope="col">이메일</th>
		         <td>${baseList.endsEmail}</td>
		     	</tr>
		     	<tr>
		         <th scope="col">직책</th>
		         <td>${baseList.userPosition}</td>
		         <th scope="col">대표전화</th>
		         <td>${baseList.goodsChargerCttpc}</td>
		     	</tr>
		    </tbody>
      </table>
      
      <!-- tbl_write -->
      <c:choose>
	      <c:when test="${baseList.goodKndCd eq 1001}"><%@include file="goods/BD_Before_Paas2.view.jsp" %></c:when>
	      <c:when test="${baseList.goodKndCd eq 1002}"><%@include file="goods/BD_Before_Saas2.view.jsp" %></c:when>
	      <c:when test="${baseList.goodKndCd eq 1003}"><%@include file="goods/BD_Before_Iaas2.view.jsp" %></c:when>
	      <c:when test="${baseList.goodKndCd eq 1004}"><%@include file="goods/BD_Before_Scs2.view.jsp" %></c:when>
      </c:choose>
      <!-- //tbl_write -->
      
      <h3>납품 요구조건</h3>
      <table class="tbl_st4" summary="납품 요구조건">
      	<caption>납품 요구조건</caption>
      	<colgroup>
      		<col width="150px"/>
      		<col width="*"/>
      	</colgroup>
      	<thead hidden="hidden">
      		<tr>
      			<th scope="row" colspan="2">희망 구매가|답변 만료일|첨부파일</th>
      		</tr>
      	</thead>
      	<tfoot hidden="hidden">
      		<tr>
      			<th scope="row" colspan="2">희망 구매가|답변 만료일|첨부파일</th>
      		</tr>
      	</tfoot>
      	<tbody>
          <tr>
          	<td>희망 구매가</td>
          	<td>
          		<fmt:formatNumber value="${baseList.hopePuchAmt}" groupingUsed="true"/> 원 / 
               <c:choose>
               	<c:when test="${baseList.vatGbn eq 'Y'}">VAT 포함</c:when>
                <c:when test="${baseList.vatGbn eq 'N'}">VAT 미포함</c:when>
               </c:choose>
            </td>
          </tr>
          <tr>
            <!--<th>납품 기한</th>
            <td>
                <c:choose>
                    <c:when test="${baseList.talkGbn eq 'Y'}">합의후 결정</c:when>
                    <c:when test="${baseList.talkGbn eq 'N'}">${baseList.delyDt} (${baseList.delyTime} 시)</c:when>
                </c:choose>
            </td> 
            -->
            <td>답변 만료일</td>
          	<td>${baseList.rplyDt}</td>
          </tr>
          <!--<tr>
              <th>납품 장소</th>
              <td colspan="3">${baseList.delyPlac}</td>
          </tr>-->
          <tr>
          	<td>첨부파일</td>
          	<td>
            	<c:if test="${baseList.delyFileId != null}">
              	<a href="/component/file/ND_fileDownload.do?id=${baseList.delyFileId}" title="${baseList.delyFileOrgNm}" class="aDeisable">${baseList.delyFileOrgNm} <span class="tx_gray">(${baseList.delyFileSize}, ${baseList.delyFileTy})</span></a>
              </c:if>
            </td>
          </tr>
          <tr>
            <td>추가문의</td>
            <td colspan="3">${baseList.addCont}</td>
          </tr>
        </tbody>
      </table>
      
      <div class="replyWrap">
      <table class="tbl_st4" summary="제공금액">
      	<caption>제공금액</caption>
      	<colgroup>
      		<col width="80px"/>
      		<col width="*"/>
      	</colgroup>
      	<thead hidden="hidden">
      		<tr>
      			<th scope="row" colspan="2">희망 구매가|답변 만료일|첨부파일</th>
      		</tr>
      	</thead>
      	<tfoot hidden="hidden">
      		<tr>
      			<th scope="row" colspan="2">희망 구매가|답변 만료일|첨부파일</th>
      		</tr>
      	</tfoot>
      	<tbody>
      		<tr>
      			<td>제공금액</td>
            <td class="vat">
            	<div class="unit">
			        	<!-- input type="text" name="splyAmt" id="splyAmt" style="ime-mode:disabled" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  value="<fmt:formatNumber value="${dataList.splyAmt}" groupingUsed="true"/>"  -->
		            <input type="text" name="splyAmt" id="splyAmt" style="ime-mode:disabled" maxlength="13" onchange="getNumber(this);" onkeyup="getNumber(this);" value="<fmt:formatNumber value="${dataList.splyAmt}" groupingUsed="true"/>">
              </div>
              <label for="splyAmt">원 VAT포함</label>
            </td>
          </tr>
          <tr>
          	<td>추가답변</td>
            <td>
            	<textarea name="addAnswer" id="addAnswer" >${dataList.addAnswer}</textarea>
            	<label for="addAnswer" hidden="hidden">추가답변</label>
            </td>
          </tr>
          <tr>
	          <td>비고</td>
	          <td>
	          	<textarea name="splyNote" id="splyNote">${dataList.splyNote}</textarea>
	          	<label for="splyNote" hidden="hidden">비고</label>
	          </td>
          </tr>
          <tr>
	          <td>첨부파일</td>
	          <td>
	            <div class="uploadFile">
	            	<input type="text" readonly="readonly" name="splyFileInput" id="splyFileInput" title="파일명"/>
	              <label for="splyFileInput" hidden="hidden">파일명</label>
	              <div>
	                <span class="btns st3"> 파일선택
	                <input type="file" name="splyFileVal" id="splyFileVal" class="splyFileVal" title="파일찾기" onchange="javascript:jsFileChk('splyFileVal', 'splyFileInput', 'splyFile');"/>
	                <label for="splyFileVal" hidden="hidden">파일찾기</label>
	                <c:choose>
                    <c:when test="${dataList.splyFile == null or dataList.splyFile eq '0'}">
                    <input type="hidden" name="splyFile" id="splyFile" value="0"/>
                    </c:when>
                    <c:when test="${dataList.splyFile != null and dataList.splyFile ne '0'}">
                    <input type="hidden" name="splyFile" id="splyFile" value="${dataList.splyFile}"/>
                    </c:when>
	                </c:choose>
	              	</span>
	              </div>
	                <c:if test="${dataList.splyFile != null and dataList.splyFile ne '0'}">
	                <p id="uploadedFile" class="uploaded">
	                    <span>
	                        <a href="/component/file/ND_fileDownload.do?id=${dataList.splyFileId}" title="${dataList.splyFileOrgNm}" class="aDeisable">${dataList.splyFileOrgNm} <span class="tx_gray">(${dataList.splyFileSize}, ${dataList.splyFileTy})</span></a>
	                        <span onclick="jsFileDelete('splyFileVal', 'splyFileInput', 'splyFile'); return false;" style="cursor: pointer;" >삭제</span>
	                    </span>
	                </p>
	                </c:if>
	            </div>
	          </td>
          </tr>
        </tbody>
      </table>

      <h3>제공자 정보</h3>
      <table class="tbl_st4 e4" summary="제공자 정보">
	      <caption>제공자 정보</caption>
	      <colgroup>
		      <col width="80px"/>
		      <col width="*"/>
	      </colgroup>
	      <thead hidden="hidden">
	      	<tr><th colspan="4" scope="row">제공자 정보</th></tr>
	      </thead>
	      <tfoot hidden="hidden">
	      	<tr><th colspan="4" scope="row">제공자 정보</th></tr>
	      </tfoot>
	      <tbody>
		      <tr>
		        <td>회사명</td>
		        <td colspan="3">${dataList.cmpnyNm}</td>
		      </tr>
		      <tr>
		        <td>담당자</td>
		        <td>${dataList.storeChargerNm}</td>
		        <td>대표전화</td>
		        <td>${dataList.reprsntTelno}</td>
		      </tr>
		      <tr>
		        <!-- <th>직책</th>
		        <td></td> -->
		        <td>이메일</td>
		        <td>${dataList.reprsntEmail}</td>
		        <td>휴대전화</td>
		        <td>${dataList.mbtlnum}</td>
		      </tr>
	      </tbody>
      </table>
  	</div>
                
    <div class="btnArea rig">
	    <c:choose>  
	        <%--
	        --재발송처리
	        UPDATE TCN_BEFORE_ESTE_SPLY
	            SET ask_apply_cd = 1005
	          WHERE user_id    = 'ncloud24'
	            AND notify_num = '20180329'
	         --%>                    
	        <c:when test="${dataList.askApplyCd eq '1005'}">
	           <a href="#" onclick="javascript:sendRequest(); return false;" class="btns st4 icn icnSend">발송</a>
	        </c:when>
	        
	    </c:choose>
	    <a href="#" onclick="javascript:returnList(); return false;" class="btns st4 icn icnList">목록보기</a>
    </div>
  </form>
</div>
    <!-- </div> -->
    <!--// content -->
 </body>
</html>