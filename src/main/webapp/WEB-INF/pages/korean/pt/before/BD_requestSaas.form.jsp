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

        
        // 행추가
    	var funAddRow = function(){	   
    	    $("#metaFromTab").append($("#addRow").val());
    	   
    	    $('.sel_box').jqTransform();

  
    	};

    	// 행삭제
    	var funDeleteRow = function(obj){
        	$(obj).parent().parent().parent().remove();
        };

        // 시스템요구 - 단위 selectbox 변경 이벤트
        var funUnitSysChange = function(){
            if($('#unitSys').val() == '1006'){
                $('#etcUnitSys').show();
            }else{
                $('#etcUnitSys').hide();
            }
        };

        // 납품 요구조건의 납품기한 합의후 결정 체크박스 체크 이벤트
        var jsTalkGbnChk = function(){
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                $("#delyDt").attr("readonly",false);
                $("#delyTime").prop("disabled", false);
            }else{
                $("#delyDt").val('');
                $("#delyDt").attr("readonly",true);
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
		
        // 사전견적 요청서 발송
        var jsRequestSend = function(){
            // 입력 필수값 체크
            if(checkEditor()){
                if(confirm("사전견적요청서를 발송 하시겠습니까?")) {
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
                    $("#dataForm").attr("action", "ND_beforeRequestSaasAction.do");
                    $("#dataForm").submit();
                }
            }
        };
        
        // 견적요청서 필수 입력값 체크
        var checkEditor = function(){
            /* // 납품요구조건 - 납품기한
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                // 납품기한 일자
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

                // 납품기한 일자
                if($("#delyTime").val() == null || $("#delyTime").val() == ""){
                    alert("납품기한을 입력해주세요.");
                    $("#delyTime").focus();
                    return false;
                }
            }*/
            
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
    
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>사전견적서</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap detailRequ saas">
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
		
		<h3>시스템요구</h3>
		<table class="tbl_st1 e4e">
			<thead>
				<tr>
					<th>단위</th>
					<th>제공용량</th>
					<th>단가</th>
					<th>제공방법</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				    <!-- 단위 -->
					<td>
					    <span class="sel_box">
						<select id="unitSys" name="unitSys" onchange="funUnitSysChange();">
						    <option value="">선택</option>
						    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
						        <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
						    </c:forEach>
						</select>
						</span>
						<input type="text" id="etcUnitSys" name="etcUnitSys" style="display:none;"/>
					</td>
					<!-- 제공용량 -->
					<td><input type="text" id="captySys" name="captySys" /></td>
					<!-- 단가 -->
					<td><input type="text" id="amountSys" name="amountSys" style="ime-mode:disabled" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></td> <!-- 단가(숫자만 입력) -->
					<!-- 제공방법 -->
					<td>
					    <span class="sel_box">
						<select id="splyMothSys" name="splyMothSys">
						    <option value="">선택</option>
						    <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
						        <option value="${supplyMethodCode.PRVCD}">${supplyMethodCode.PRVNM}</option>    
						    </c:forEach>
						</select>
						</span>
					</td>
				</tr>
				<tr>
				</tr>
			</tbody>
		</table>
		
		<table id="metaFromTab" class="tbl_st1">
			<thead>
				<tr>
					<th>옵션명</th>
					<th>단위</th>
					<th>제공용량</th>
					<th>단가</th>
					<th colspan="2">제공방법</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="optionNm" /></td>
					<td><input type="text" name="unitItem" /></td>
					<td><input type="text" name="captyItem" /></td>
					<td><input type="text" name="amountItem" style="ime-mode:disabled" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></td>
					<td><!-- <input type="text" name="cmntItem" />-->
						<span class="sel_box">
							<select id="cmntItem" name="cmntItem">
							    <option value="">선택</option>
							    <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
							        <option value="${supplyMethodCode.PRVCD}">${supplyMethodCode.PRVNM}</option>    
							    </c:forEach>
							</select>
						</span>
					</td>
					<td><a href="#" onclick="funAddRow(); return false;" class="btns st3">행추가</a></td>
				</tr>			
			</tbody>
		</table>
		<textarea id="addRow" style="display:none">
		    <tbody>
				<tr>
					<td><input type="text" name="optionNm" /></td>
					<td><input type="text" name="unitItem" /></td>
					<td><input type="text" name="captyItem" /></td>
					<td><input type="text" name="amountItem" style="ime-mode:disabled" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></td>
					<td><!-- <input type="text" name="cmntItem" />-->
						<span class="sel_box">
							<select id="cmntItem" name="cmntItem">
							    <option value="">선택</option>
							    <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
							        <option value="${supplyMethodCode.PRVCD}">${supplyMethodCode.PRVNM}</option>    
							    </c:forEach>
							</select>
						</span>
					</td>
					<td><a href="#" onclick="funDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
				</tr>	
			</tbody>
		</textarea>
	</div>
	<div class="conWrap detailRequ iaas">
		<h3>납품 요구조건</h3>
		<table class="tbl_st4">
			<tr>
				<th>희망 구매가</th>
				<td colspan="3" class="vat">
					<div class="unit">
						<i>원</i>				
						<div><input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></div>
					</div>
					<label><input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked"/> VAT포함</label>
					<label><input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"/> VAT미포함</label>
				</td>
			</tr>
			<tr>
				<!--<th class="requ">답변 기한</th>
				<td class="term">
					<input type="text" id="delyDt" name="delyDt" readonly="readonly"/>
					<span class="sel_box">
					<select id="delyTime" name="delyTime">
						<option value="">시간선택</option>
                        <c:forEach var="i" begin="9" end="18">
                            <c:set var="timeOption" value="${0+i}" />
                            <option value="${timeOption}">${timeOption} 시</option>
                        </c:forEach>
					</select>
					</span>
					시
					<label><input type="checkbox" id="talkGbnChkbox" name="talkGbnChkbox" onclick="jsTalkGbnChk();"/> 합의후 결정</label>
				</td>-->
				<th class="requ">답변 만료일</th>
				<td class="term"><input type="text" id="rplyDt" name="rplyDt" readonly="readonly"/></td>
			</tr>
			 <!--<tr>
				<th>납품 장소</th>
				<td colspan="3"><input type="text" id="delyPlac" name="delyPlac"/></td>
			</tr> -->
			<tr>
				<th>첨부파일</th>
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
			<a href='#' onclick="jsCommentCancel();" class="btns st1 icn icnDel"> 취 소 </a>
			<a href="#" onclick="jsRequestSend();"   class="btns st1 icn icnSend"> 발 송 </a>
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
	  $( "#delyDt, #rplyDt" ).datepicker({
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