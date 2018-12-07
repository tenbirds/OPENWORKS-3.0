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
    <title>상세정보(견적)요청서 Iaas</title>
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
    
        $().ready(function() {
        }); //ready

        // Server 영역 행추가
    	var jsServerAddRow = function(){	   
    	    $("#serverTable01").append($("#serverAddRow01").val());
    	    $("#serverTable02").append($("#serverAddRow02").val());
    	};
        // DB 영역 행추가
    	var jsDbAddRow = function(){	   
    	    $("#dbTable01").append($("#dbAddRow01").val());
    	    $("#dbTable02").append($("#dbAddRow02").val());
    	};

    	// Server 영역 행삭제
    	var jsServerDeleteRow = function(obj){
    	    var trNum = $(obj).parent().closest('tbody').prevAll().length - 1;
    	    $("#serverTable02 > tbody").children("tr:eq("+trNum+")").remove();
    	    $(obj).parent().parent().parent().remove();
        };

    	// DB 영역 행삭제
    	var jsDbDeleteRow = function(obj){
    	    var trNum = $(obj).parent().closest('tbody').prevAll().length - 1;
    	    $("#dbTable02 > tbody").children("tr:eq("+trNum+")").remove();
    	    $(obj).parent().parent().parent().remove();
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

        // 견적요청서 발송
        var jsRequestSend = function(){
            // 입력 필수값 체크
            if(checkEditor()){
                if(confirm("견적요청서를 발송 하시겠습니까?")) {
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

                    $("#dataForm").attr("action", "ND_requestIaasAction.do");
                    $("#dataForm").submit();
                }
            }
        };

        // 견적요청서 필수 입력값 체크
        var checkEditor = function(){
            // 납품요구조건 - 납품기한
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
            }
            
            // 응답 만료일
            if($("#rplyDt").val() == null || $("#rplyDt").val() == ""){
                alert("응답 만료일을 입력해주세요.");
                $("#rplyDt").focus();
                return false;
            }else{
                // 응답 만료일이 현재일 이전일 경우 return
                var rplyDt = $("#rplyDt").val().replace(/-/gi,"");
                if(nowDate > rplyDt){
                    alert("응답 만료일은 현재일 이전일수 없습니다.");
                    $("#rplyDt").focus();
                    return false;
                }
            }

            // 납품기한/응답만료일 구간 체크
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                var delyDt = $("#delyDt").val().replace(/-/gi,"");
                var rplyDt = $("#rplyDt").val().replace(/-/gi,"");

                if(rplyDt > delyDt){
                    alert("응답 만료일은 납품기한을 초과할 수 없습니다.");
                    $("#delyDt").focus();
                    return false;                    
                }
            }

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
    <input type="hidden" name="bidGbnCd"  id="bidGbnCd"  value="1002" /> <!-- 입찰종류 (그룹코드 :2037 중 1002:견적요청, 사전견적 : 1004) -->
    <input type="hidden" name="userId"    id="userId"    value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="grpSeq"    id="grpSeq"    value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd" id="goodsTyCd" value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="goodsCd"   id="goodsCd"   value="<c:out value="${p_goodsCd}" />" /> <!-- goodsCd -->
    <input type="hidden" name="goodArray" id="goodArray" value="" />
    <input type="hidden" name="vatGbn"    id="vatGbn"    value="" />
    <input type="hidden" name="talkGbn"   id="talkGbn"   value="" />
    <input type="hidden" name="userNm"    id="userNm"    value="${sessionScope['__usk'].userNm}" />

	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>상세정보(견적) 요청서</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap detailRequ iaas">
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
		<table id="serverTable01" class="tbl_st1">
			<thead>
				<tr>
					<th colspan="7">서버</th>
				</tr>
				<tr>
					<th>용도</th>
					<th>OS</th>
					<th>CPU(Vcore)</th>
					<th>메모리(GB)</th>
					<th>Disk(GB)</th>
					<th colspan="2">수량(CM)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="serverUse" /></td>
					<td><input type="text" name="serverOs" /></td>
					<td><input type="text" name="serverCpu" /></td>
					<td><input type="text" name="serverMemory" /></td>
					<td><input type="text" name="serverDisk" /></td>
					<td><input type="text" name="serverQnty" /></td>
					<td><a href="#" onclick="jsServerAddRow(); return false;" class="btns st3">행추가</a></td>
				</tr>
			</tbody>
		</table>
		<textarea id="serverAddRow01" style="display:none">
		    <tbody>
				<tr>
					<td><input type="text" name="serverUse" /></td>
					<td><input type="text" name="serverOs" /></td>
					<td><input type="text" name="serverCpu" /></td>
					<td><input type="text" name="serverMemory" /></td>
					<td><input type="text" name="serverDisk" /></td>
					<td><input type="text" name="serverQnty" /></td>
					<td><a href="#" onclick="jsServerDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
				</tr>	
			</tbody>
		</textarea>

		<table id="serverTable02" class="tbl_st1">
			<thead>
				<tr>
					<th colspan="6">서버</th>
				</tr>
				<tr>
					<th>공인 IP 수량</th>
					<th>네트워크 트래픽</th>
					<th>GSLB</th>
					<th>로드밸런서</th>
					<th>스냅샷</th>
					<th>이미지</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="serverIp"      id="serverIp" /></td>
					<td><input type="text" name="serverNetwork" id="serverNetwork" /></td>
					<td><input type="text" name="serverGslb"    id="serverGslb" /></td>
					<td><input type="text" name="serverLdbl"    id="serverLdbl" /></td>
					<td><input type="text" name="serverSnap"    id="serverSnap" /></td>
					<td><input type="text" name="serverImg"     id="serverImg" /></td>
				</tr>
			</tbody>
		</table>
		<textarea id="serverAddRow02" style="display:none">
		    <tbody>
				<tr>
					<td><input type="text" name="serverIp" /></td>
					<td><input type="text" name="serverNetwork" /></td>
					<td><input type="text" name="serverGslb" /></td>
					<td><input type="text" name="serverLdbl" /></td>
					<td><input type="text" name="serverSnap" /></td>
					<td><input type="text" name="serverImg" /></td>
				</tr>	
			</tbody>
		</textarea>

		<table id="dbTable01" class="tbl_st1">
			<thead>
				<tr>
					<th colspan="7">DB</th>
				</tr>
				<tr>
					<th>용도</th>
					<th>OS</th>
					<th>CPU(Vcore)</th>
					<th>메모리(GB)</th>
					<th>Disk(GB)</th>
					<th colspan="2">수량(CM)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="dbUse" /></td>
					<td><input type="text" name="dbOs" /></td>
					<td><input type="text" name="dbCpu" /></td>
					<td><input type="text" name="dbMemory" /></td>
					<td><input type="text" name="dbDisk" /></td>
					<td><input type="text" name="dbQnty" /></td>
					<td><a href="#" onclick="jsDbAddRow(); return false;" class="btns st3">행추가</a></td>
				</tr>
			</tbody>
		</table>

		<textarea id="dbAddRow01" style="display:none">
		    <tbody>
				<tr>
					<td><input type="text" name="dbUse" /></td>
					<td><input type="text" name="dbOs" /></td>
					<td><input type="text" name="dbCpu" /></td>
					<td><input type="text" name="dbMemory" /></td>
					<td><input type="text" name="dbDisk" /></td>
					<td><input type="text" name="dbQnty" /></td>
					<td><a href="#" onclick="jsDbDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
				</tr>	
			</tbody>
		</textarea>

		<table id="dbTable02" class="tbl_st1">
			<thead>
				<tr>
					<th colspan="4">DB</th>
					<th colspan="2">스토리지</th>
				</tr>
				<tr>
					<th>공인 IP 수량</th>
					<th>네트워크 트래픽</th>
					<th>추가 디스크</th>
					<th>백업 스토리지</th>
					<th class="sepa">저장공간</th>
					<th>전송량</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="dbIp" /></td>
					<td><input type="text" name="dbNetwork" /></td>
					<td><input type="text" name="dbAddDisk" /></td>
					<td><input type="text" name="dbBackStorg" /></td>
					<td class="sepa"><input type="text" name="dbStorgSpace" /></td>
					<td><input type="text" name="dbTransVlmn" /></td>
				</tr>
			</tbody>
		</table>

		<textarea id="dbAddRow02" style="display:none">
		    <tbody>
				<tr>
					<td><input type="text" name="dbIp" /></td>
					<td><input type="text" name="dbNetwork" /></td>
					<td><input type="text" name="dbAddDisk" /></td>
					<td><input type="text" name="dbBackStorg" /></td>
					<td class="sepa"><input type="text" name="dbStorgSpace" /></td>
					<td><input type="text" name="dbTransVlmn" /></td>
				</tr>	
			</tbody>
		</textarea>

		<table class="tbl_st1">
			<thead>
				<tr>
					<th colspan="2">CDN</th>
					<th colspan="2">웹방화벽</th>
					<th colspan="2">모니터링</th>
				</tr>
				<tr>
					<th>전송량</th>
					<th>예상 요청 수</th>
					<th class="sepa">서비스유형</th>
					<th>처리속도</th>
					<th class="sepa">VM</th>
					<th>계정 수량</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="cdnTransVlmn" id="cdnTransVlmn" /></td>
					<td><input type="text" name="cdnRequCnt" id="cdnRequCnt" /></td>
					<td class="sepa"><input type="text" name="webGoodsKind" id="webGoodsKind" /></td>
					<td><input type="text" name="webAccess" id="webAccess" /></td>
					<td class="sepa"><input type="text" name="mntingVm" id="mntingVm" /></td>
					<td><input type="text" name="mntingIdCnt" id="mntingIdCnt" /></td>
				</tr>
			</tbody>
		</table>

		<table class="tbl_st1">
			<thead>
				<tr>
					<th colspan="2">백업</th>
					<th rowspan="2">관리기능</th>
					<th colspan="2">보안관리</th>
					<th rowspan="2">시스템 설치 및<br /> 운영에 대한<br /> 기술지원 등</th>					
				</tr>
				<tr>
					<th>백업서버 수량 </th>
					<th>저장용량</th>					
					<th class="sepa">VPN</th>
					<th>SSL VPN</th>					
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="bakupCnt" id="bakupCnt" /></td>
					<td><input type="text" name="bakupStorg" id="bakupStorg" /></td>
					<td class="sepa"><input type="text" name="mangFunc" id="mangFunc" /></td>
					<td class="sepa"><input type="text" name="sectyVpn" id="sectyVpn" /></td>
					<td><input type="text" name="sectySslvpn" id="sectySslvpn" /></td>
					<td class="sepa"><input type="text" name="techSupt" id="techSupt" /></td>
				</tr>
			</tbody>
		</table>
		
		<h3>기능요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>
							가상화 및 클라우드 환경 구성<br />
							- 웹 환경에서 가상 자원(서버, 스토리지 등)을 다양한 조합(CPU, 메모리, OS, 스토리지, 네트워크 등)으로 신속하게  생성변경하는 기능 제공
						</dt>
						<dd><input type="text" name="funcDmnd1" id="funcDmnd1" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>2</th>
				<td>
					<dl>
						<dt>
							오토 스케일링 지원<br />
							- 이용자 증가, 서비스 기능 추가에 따른 IaaS 확장이나 변경발생시 정상적으로 유지될 수 있는 시스템 구조 제공 <br />
							 ※오토스케일링, 스케일업, 스케일아웃 등
						</dt>
						<dd><input type="text" name="funcDmnd2" id="funcDmnd2" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>3</th>
				<td>
					<dl>
						<dt>다양한 단말기ㆍ브라우저ㆍ운영체계 지원</dt>
						<dd><input type="text" name="funcDmnd3" id="funcDmnd3" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>4</th>
				<td>
					<dl>
						<dt>
							공통요건<br />
							- 제공자가 제공하는 IaaS서비스는 이용자가 명시한 규격과 동일하거나 상향된 사양의 서비스 제공<br />
							- 공개 SW가 제공될 경우 공공기관의 이용에 관리적, 기술적, 법적하자 관리<br />
							- 공개 SW에 대한 유지관리, 기술지원 방안 제공<br />
							※웹서버(WEB), 웹어플리케이션서버(WAS), 데이터베이스 관리시스템(DBMS) 등<br />
						</dt>
						<dd><input type="text" name="funcDmnd4" id="funcDmnd4" /></dd>
					</dl>
				</td>
			</tr>
		</table>

		<h3>인터페이스 요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>자사 및 타사 서비스를 연계하여 서비스 변경‧신규 서비스 생성기능 제공</dt>
						<dd><input type="text" name="interfaceDmnd" id="interfaceDmnd" /></dd>
					</dl>
				</td>
			</tr>
		</table>

		<h3>보안 요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>
							보안관제 및 관리방안<br />
							- 관리적, 기술적, 물리적 보안
						</dt>
						<dd><input type="text" name="sectyDmnd1" id="sectyDmnd1" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>2</th>
				<td>
					<dl>
						<dt>
							보안지침 준수<br />
							- 수요기관이 요구하는 보안규정 및 지침 준수
						</dt>
						<dd><input type="text" name="sectyDmnd2" id="sectyDmnd2" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>3</th>
				<td>
					<dl>
						<dt>
							데이터 보안<br />
							- DB 및 파일에 대한 보안유지, 백업, 이미징
						</dt>
						<dd><input type="text" name="sectyDmnd3" id="sectyDmnd3" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>4</th>
				<td>
					<dl>
						<dt>
							보안인증<br />
							- 네트워크, DB, 가상화, 접근통제 등에 대한 CC인증 보유<br />
							※IT보안인증사무국 지정 CC인증제품 유형에 해당하는 품목
						</dt>
						<dd><input type="text" name="sectyDmnd4" id="sectyDmnd4" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>5</th>
				<td>
					<dl>
						<dt>
							클라우드컴퓨팅서비스 정보보호에 관한 기준 준수<br />
							- 클라우드컴퓨팅서비스 정보보호에 관한 기준 및 공공기관용 추가 보호조치 등 항목 준수
						</dt>
						<dd><input type="text" name="sectyDmnd5" id="sectyDmnd5" /></dd>
					</dl>
				</td>
			</tr>
		</table>

		<h3>품질 요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>
							클라우드컴퓨팅서비스 품질성능에 관한 기준<br />
							- 클라우드컴퓨팅서비스 품질성능에 관한 기준의 세부기준 지표
						</dt>
						<dd><input type="text" name="qutyDmnd1" id="qutyDmnd1" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>2</th>
				<td>
					<dl>
						<dt>
							SLA(서비스수준협약)을 통해 품질보증, 손해배상
						</dt>
						<dd><input type="text" name="qutyDmnd2" id="qutyDmnd2" /></dd>
					</dl>
				</td>
			</tr>
		</table>

		<h3>운영 요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>
							모니터링 및 통계 제공<br />
							- 시스템 부하, CPU, 메모리, OS, 스토리지, 네트워크 등의 상태 실시간 모니터링 및 운영통계 제공
						</dt>
						<dd><input type="text" name="optnDmnd1" id="optnDmnd1" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>2</th>
				<td>
					<dl>
						<dt>
							과금관리<br />
							- 이용량, 과금액 실시간 모니터링 및 과금 기준의 유연한 변경기능 제공									
						</dt>
						<dd><input type="text" name="optnDmnd2" id="optnDmnd2" /></dd>
					</dl>
				</td>
			</tr>
		</table>

		<h3>프로젝트 지원요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>
							제공자의 안정성 보장<br />
							- 제공자의 재무상태 확인할 수 있어야 하며 기술보증과 이를 수행할 조직 및 인력 구성									
						</dt>
						<dd><input type="text" name="prjtDmnd1" id="prjtDmnd1" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>2</th>
				<td>
					<dl>
						<dt>
							이용자 교육<br />
							- 이용자가 서비스를 원활하게 사용할 수 있도록 교육 및 교육자료 제공
						</dt>
						<dd><input type="text" name="prjtDmnd2" id="prjtDmnd2" /></dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th>3</th>
				<td>
					<dl>
						<dt>
							고객의견 · 요구대응<br />
							- 이용자가 서비스 이용 중 발생하는 문제에 대해 지원을 받을 수 있는 콜센터 및 기술지원 제공
						</dt>
						<dd><input type="text" name="prjtDmnd3" id="prjtDmnd3" /></dd>
					</dl>
				</td>
			</tr>
		</table>

		<h3>기타 요구</h3>
		<table class="tbl_st4">
			<tr>
				<th>1</th>
				<td>
					<dl>
						<dt>
							수요기관이 필요한 기타 요구사항 입력
						</dt>
						<dd><input type="text" name="etcDmnd" id="etcDmnd" /></dd> 
					</dl>
				</td>
			</tr>
		</table>

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
				<th class="requ">납품 기한</th>
				<td class="term">
				    <input type="text" id="delyDt" name="delyDt" />
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
				</td>
				<th class="requ">응답 만료일</th>
				<td class="term"><input type="text" id="rplyDt" name="rplyDt" /></td>
			</tr>
			<tr>
				<th>납품 장소</th>
				<td colspan="3"><input type="text" id="delyPlac" name="delyPlac"/></td>
			</tr>
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
				<td colspan="3"><textarea id="notifyCont" name="notifyCont" ></textarea></td>
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
					<input type="text" id="goodsChargerCttpc1" name="goodsChargerCttpc1"/> - 
					<input type="text" id="goodsChargerCttpc2" name="goodsChargerCttpc2"/> -
					<input type="text" id="goodsChargerCttpc3" name="goodsChargerCttpc3"/>
				</td>
			</tr>					
		</table>
			
		<div class="btnArea rig">
			<a href="#" onclick="jsRequestSend(); return false;" class="btns st1 icn icnSend"> 발 송 </a>
		</div>
	</div>
	<!--// content -->
</form>

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

</body>
</html>