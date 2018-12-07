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
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
</head>
<body>
    <!-- 컨텐츠영역 -->
    <div id="pop_wrap">
        <div class="pop_container">
            <!-- popup header -->
            <div class="header">
                <h1>주소찾기</h1>
            </div>
            <!-- //header -->
            <!-- popup content -->
            <div class="section">
	            <dl class="clear">
	                <dt class="float_l"><strong><label for="sido">ㆍ시도 </label></strong></dt>
	                <dd class="float_l">
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
	                </dd>
	                <dd class="float_l mar_r5 mar_l2">
	                    <select id="q_searchKey" name="q_searchKey" class="plantext over" style="width:145px;" onchange="jsToggleBtn();">
	                        <%-- <c:choose>
	                            <c:when test="${param.q_searchKey eq 'dong' || param.q_searchKey eq null}"> --%>
	                                <option value="dong" <c:if test="${param.q_searchKey eq 'dong'}">selected="selected"</c:if>>동(읍/면/리)명+지번</option>
	                            <%-- </c:when>
	                            <c:when test="${param.q_searchKey eq 'doro' or param.q_searchKey eq 'bd'}"> --%>
	                                <option value="doro" <c:if test="${param.q_searchKey eq 'doro'}">selected="selected"</c:if>>도로명+건물번호</option>
	                                <option value="bd" <c:if test="${param.q_searchKey eq 'bd'}">selected="selected"</c:if>>건물명</option>
	                            <%-- </c:when>
	                        </c:choose> --%>
	                    </select>
	                </dd>
	                
	                <dd class="float_l mar_b10 mar_l2">
	                    <input type="text" title="검색어입력" value="${param.q_searchVal}" id="q_searchVal" name="q_searchVal"  class="w215" style="margin-left:43px; vertical-align: top;"/>
	                    <span id="idspan1"></span>
	                    <input type="text" title="검색어입력" value="${param.q_searchBun1}" style="width:50px; vertical-align: top;" size="50" id="q_searchBun1" name="q_searchBun1" />
	                    - <input type="text" title="검색어입력" value="${param.q_searchBun2}" style="width:50px; vertical-align: top;" size="50" id="q_searchBun2" name="q_searchBun2" />
	                    <span id="idspan2" style="vertical-align: middle;"></span>
	                    <input type="image" alt="검색" src="/resources/web/theme/default/images/btn/btn_g_search.gif" onclick="normalSearch(1); return false;" />
	                </dd>
	            </dl>
	            <br/>
	            <div id="schm1" class="clear mar" style="margin-top: 30px;">* 검색방법</div>
	            <div id="schm1" class="clear mar">- 동(읍/면/리)명+지번</div>
	            <div id="schm3" class="clear mar"> 서울시 중구 <strong>충무로1가 21-1</strong>&nbsp;&nbsp;예) '<strong>충무로1가</strong>(동명) <strong>21-1</strong>(지번)'</div>
	            <div id="schm1" class="clear mar">- 도로명(~로, ~길) + 건물번호</div>
	            <div id="schm3" class="clear mar"> 서울시 중구 <strong>소공로 70</strong>&nbsp;&nbsp;예) '<strong>소공로</strong>(도로명) <strong>70</strong>(건물번호)'</div>
	            <div id="schm1" class="clear mar">- 시/도 및 시/군/구 선택 후 건물명 입력</div>
	            <div id="schm3" class="clear mar"> 서울시 중구 <strong>중앙우체국</strong>&nbsp;&nbsp;예) '<strong>서울</strong>' 및 '<strong>중구</strong>' 선택 후 '<strong>중앙우체국</strong>(건물명)'</div>
	        </div>
	        
	        <table id="ziptable" cellspacing="0" border="0" summary="우편번호" class="popup_list">
	            <caption class="hidden">우편번호</caption>
	            <colgroup>
	                <col width="15%" />
	                <col width="40%" />
	                <col width="45%" />
	            </colgroup>
	            <thead>
	                <tr>
	                    <th>우편번호</th>
	                    <th>지번주소</th>
	                    <th class="lr_none">도로명주소</th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr>
	                    <td colspan="3" class="lr_none">- 검색어를 입력하십시오 -</td>
	                </tr>
	            </tbody>
	        </table>
	        <!-- //기본정보 -->
	        <div class="paginate">
	            <div id="pagenate"></div>
	        </div>
        </div>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>