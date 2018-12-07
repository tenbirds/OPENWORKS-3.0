<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>우편번호 검색</title>
<op:jsTag type="openworks" items="web-core"/>
<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
<script type="text/javascript" src="/resources/web/zipcode/zipcommon.js"></script>
<script type="text/javascript">
    $().ready(function() {

        jsSetSearchEnterEvent();
        jsToggleBtn();
    });

    // 검색 엔터 이벤트
    var jsSetSearchEnterEvent = function() {
        $("#q_searchVal").keyup(function(event){
            if(event.keyCode == 13) {
                $(this).next().click();
                return false;
            }
        });
    };

    var jsToggleBtn = function (){      
        if($("#q_searchKey").val() == "dong"){
            
            $("#idspan1").text("");
            $("#idspan2").text("번지");
            $("#q_searchVal").val("");
            $("#q_searchBun1").val("");
            $("#q_searchBun2").val("");
        }else if ($("#q_searchKey").val() == "doro"){
            
            $("#idspan1").text("건물번호(본-부)");
            $("#idspan2").text("");
            $("#q_searchVal").val("");
            $("#q_searchBun1").val("");
            $("#q_searchBun2").val("");
        }else{
            $("#idspan1").text("");
            $("#idspan2").text("");
            $("#q_searchVal").val("");
            $("#q_searchBun1").val("");
            $("#q_searchBun2").val("");
        }
    };

    // 페이지 이동
    var jsMovePage = function(page) {
        
    };

        
    //주소찾기를 호출한 부모창에는 ID가 zipCodeId,baseAddrId,detailAddrId 가 존재하여야 하고 주소찾기 창을 호울할 때 각각의 값을 셋팅해 준다.
    //부모창에서 우편번호찾기 팝업 호출하기 - 입력할 주소가 여러가지일 때 입력할 input ID를 담아서 jsZipcodePop을 호출한다.        
    //우편번호 input ID가  biz_zipCode1 면 숫자 뺀 이름인 'biz_zipCode' 를 인자로 넘겨준다.        
    //(예 : jsZipcodePop(this,'biz_zipCode','biz_baseAddr','biz_detailAddr') 
    var returnValue = function(zip, addr1, addr2){
        
        var zipcode = zip.split("-");
        parent.$("#"+ parent.$("#zipCodeId").val()+"1").val(zipcode[0]);
        parent.$("#"+ parent.$("#zipCodeId").val()+"2").val(zipcode[1]);
        parent.$("#"+ parent.$("#baseAddrId").val()).val(addr1);
        parent.$("#"+ parent.$("#detailAddrId").val()).val(addr2);
        parent.$("#"+ parent.$("#detailAddrId").val()).focus();

        parent.$.fn.colorbox.close();
    };
    </script>
    
    <link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
    <!-- link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" / -->
</head>
<body>
	
<div class="layer-pop" style="display:block;"> 
    	
		<!-- div class="bg"></div -->
    	
    	<div class="pop-cont orange post-area">
    	    	
    	<h3>주소찾기</h3>
		<!-- 번지 검색 -->
		<div class="post-search">
					
		<dl class="searching">
			<dt>· 시도</dt>
			<dd>
				<!-- static select -->
				<div class="select-area">
					<!-- select box -->
					<div class="sech_form">
						<div class="cont_wrap">

							<div class="selected">
								<span class="sel_box">
								  <select id="q_sidoCd" name="q_sidoCd" class="over" title="시도 선택" autofocus="autofocus">
				                        <option value=""                                >::선택::</option>
				                        <option value="11" <c:if test="${param.q_sidoCd eq '11'}">selected="selected"</c:if> title="서울특별시">서울특별시</option>
				                        <option value="26" <c:if test="${param.q_sidoCd eq '26'}">selected="selected"</c:if> title="부산광역시">부산광역시</option>
				                        <option value="27" <c:if test="${param.q_sidoCd eq '27'}">selected="selected"</c:if> title="대구광역시">대구광역시</option>
				                        <option value="28" <c:if test="${param.q_sidoCd eq '28'}">selected="selected"</c:if> title="인천광역시">인천광역시</option>
				                        <option value="29" <c:if test="${param.q_sidoCd eq '29'}">selected="selected"</c:if> title="광주광역시">광주광역시</option>
				                        <option value="30" <c:if test="${param.q_sidoCd eq '30'}">selected="selected"</c:if> title="대전광역시">대전광역시</option>
				                        <option value="31" <c:if test="${param.q_sidoCd eq '31'}">selected="selected"</c:if> title="울산광역시">울산광역시</option>
				                        <option value="41" <c:if test="${param.q_sidoCd eq '41'}">selected="selected"</c:if> title="경기도">경기도</option>
				                        <option value="42" <c:if test="${param.q_sidoCd eq '42'}">selected="selected"</c:if> title="강원도">강원도</option>
				                        <option value="43" <c:if test="${param.q_sidoCd eq '43'}">selected="selected"</c:if> title="충청북도">충청북도</option>
				                        <option value="44" <c:if test="${param.q_sidoCd eq '44'}">selected="selected"</c:if> title="충청남도">충청남도</option>
				                        <option value="45" <c:if test="${param.q_sidoCd eq '45'}">selected="selected"</c:if> title="전라북도">전라북도</option>
				                        <option value="46" <c:if test="${param.q_sidoCd eq '46'}">selected="selected"</c:if> title="전라남도">전라남도</option>
				                        <option value="47" <c:if test="${param.q_sidoCd eq '47'}">selected="selected"</c:if> title="경상북도">경상북도</option>
				                        <option value="48" <c:if test="${param.q_sidoCd eq '48'}">selected="selected"</c:if> title="경상남도">경상남도</option>
				                        <option value="50" <c:if test="${param.q_sidoCd eq '50'}">selected="selected"</c:if> title="제주특별자치도">제주특별자치도</option>
				                        <option value="36" <c:if test="${param.q_sidoCd eq '36'}">selected="selected"</c:if>title="세종특별자치시">세종특별자치시</option>
				                    </select>
				              	</span>
							</div>
						</div>
					</div>
					<!-- //select box -->
				</div>
				<!-- //static select -->
			</dd>
			
			<!-- 동(읍/면/리)명 + 지번 -->
			<dd>
				<!-- static select -->
				<div class="select-area">
					<!-- select box -->
					<div class="sech_form">
						<div class="cont_wrap">
							<div class="selected">
								<span class="sel_box">
								   <select id="q_searchKey" name="q_searchKey" class="plantext over" style="width:145px;" onchange="jsToggleBtn();">
		                                <option value="dong" <c:if test="${param.q_searchKey eq 'dong'}">selected="selected"</c:if>>동(읍/면/리)명+지번</option>
		                                <option value="doro" <c:if test="${param.q_searchKey eq 'doro'}">selected="selected"</c:if>>도로명+건물번호</option>
		                                <option value="bd" <c:if test="${param.q_searchKey eq 'bd'}">selected="selected"</c:if>>건물명</option>
			                    </select>
			                   </span>
							</div>
						</div>
					</div>
					<!-- //select box -->
				</div>
				<!-- //static select -->
			</dd>
			<dd>
				<input type="text" class="w124"  value="${param.q_searchVal}" id="q_searchVal" name="q_searchVal"  /><input type="text" title="검색어입력"  value="${param.q_searchBun1}" id="q_searchBun1" name="q_searchBun1"  class="w74 ml5" /><span class="space">-</span>
				<input type="text" title="검색어입력" value="${param.q_searchBun2}" id="q_searchBun2" name="q_searchBun2"  class="w74" />
				<span class="ml5">번지</span><a href="#" class="b-btn ml10 type1" onclick="normalSearch(1); return false;" ><strong><span class="ml10 mr10">검색</span></strong></a>
			</dd>
		</dl>		
		<!-- //시도 선택 -->
		
		
		<!-- 검색방법 -->
		<dl class="txt-searching">
			<dt>* 검색방법</dt>
			<dd>
				<ul>
				<li>- 동(읍/면/리)명+지번
					<ul>
					<li>서울시 중구 <strong>충무로1가 21-1</strong> 예) '<strong>충무로1가</strong>(동명) <strong>21-1</strong>(지번)'</li>
					</ul>
				</li>
				<li>- 도로명(~로, ~길) + 건물번호
					<ul>
					<li>서울시 중구 <strong>소공로 70</strong> 예) '<strong>소공로</strong>(도로명) <strong>70</strong>(건물번호)'</li>
					</ul>
				</li>
				<li>- 시/도 및 시/군/구 선택 후 건물명 입력
					<ul>
					<li>서울시 중구 <strong>중앙우체국</strong> 예) '<strong>서울</strong>' 및 '<strong>중구</strong>' 선택 후 '<strong>중앙우체국(건물명)</strong>'</li>
					</ul>
				</li>
				</ul>
			</dd>
		</dl>
		<!-- //검색방법 -->
	</div>
	<!-- //번지 검색 -->
					
	<!-- 우편번호 지번주소 도로명주소 -->
	<div class="section">
		<table id="ziptable" cellspacing="0" border="0" summary="우편번호" class="popup_list">
			<colgroup>
				<col style="width:20%;" />
				<col style="width:40%;" />
				<col style="width:*;" />
			</colgroup>
			<thead>
				<tr>
					<th>우편번호</th>
					<th>지번주소</th>
					<th>도로명주소</th>
				</tr>
			</thead>
			 <tbody>
	               <tr class="no-search">
						<td colspan="3">- 검색어를 입력하십시오 -</td>
					</tr>
	            </tbody>
		</table>
		
		  <div class="paginate">
	            <div id="pagenate"></div>
	        </div>
	</div>
	<!-- //우편번호 지번주소 도로명주소 -->
	</div>
</div>
<!-- //layer popup -->
    
</body>
</html>