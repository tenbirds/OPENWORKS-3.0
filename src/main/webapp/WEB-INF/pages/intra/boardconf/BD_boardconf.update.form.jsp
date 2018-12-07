<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>게시판 생성</title>

    <op:jsTag type="spi" items="form, highlight,multifile" />
    <op:jsTag type="openworks" items="form, validate, ui" />

    <!-- 유효성 검증 BEAN Annotation 기반 자동 설정 -->
    <valid:script type="msgbox" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="/resources/intra/boardconf/boardconf.js"></script>

    <script type="text/javascript">
        //<CDATA[[
        var confTabz;
        var changeFlag = false;
        var bbsCd = "${dataVo.bbsCd}";
        /* 공통 초기화 */
        $(document).ready(function(){

            
            jsAditCtgSetting();
            
            var option = {
                //내용을 표시할 컨테이너는 지정할 수도 있으며 미지정 시 임의로 생성됨.
                tabContainer : "tabContainer",
                //공통 파라미터를 지정할 수 있음.
                baseParam: {
                    domainCd: "${dataVo.domainCd}",
                    bbsCd: "${dataVo.bbsCd}"
                },
                //로드전 이벤트 정의
                beforeLoad : function(event, item){
                    if(changeFlag){
                        if(confirm("변경 사항이 있습니다. 저장 후 이동하세요.")){
                            return false;
                        }else{
                            changeFlag = false;
                            return true;
                        }
                    }
                    return true;
                },
                //로드 후 이벤트 정의
                afterLoad : function(event, item){
                    changeFlag = false;
                    return true;
                }
            };

            confTabz = $("#bbsConfTabDiv").jsTabUi(option);

            $("#dataForm").submit(function(){

                if(validate()){
                    
                //수정사항이 있는경우
                if(($("#bbsCd").val() == 1002 && changeFlag == true ) || ($("#bbsCd").val() == 1031 && changeFlag == true )){
                    if(!confirm("분류코드 수정하시면 등록되어있는 게시물에 영향을 끼칠수있습니다. 수정하시겠습니까? "))return false;
                }
                
                    return true;
                }
                return false;
            });

        });

        /*
         * validate() 호출시 사용자 정의 검증을 자동으로 호출함
         */
        var customValidate = function(){
            
            if($("#bbsCd").val() == 1002 || $("#bbsCd").val() == 1031){
                
	            // 1Depth 담기
	            var ctgNmArray ="";
	            // 2Depth 담기
	            var aditCtgNmArray ="";
	            var aditCount=0;
	            
	            for(var i = 0;  i < 7; i++){
		            var ctgNms = $("input[name=ctgNm]").eq(i).val();
		            var aditCtgNms = $("input[name=aditCtgNm]").eq(i).val();
		            var aditCtgNmsSplit = aditCtgNms.split(",");
		            
		            if(aditCtgNmsSplit.length > 8){
		                alert("부류명은 최대 8개까지 입력 가능 합니다. ");
		                $("input[name=aditCtgNm]").eq(i).focus();
		                return;
		            }
		            
		            if($("input[name=ctgYn]:checked").val() == "Y" ){
	
		            // 값 확인
			            if( (ctgNms.length != 0 &&  aditCtgNms.length == 0 )|| (ctgNms.length == 0 &&  aditCtgNms.length != 0)){
			                jsWarningBox("분류 사용 여부를 사용으로 선택 시 분류 정보를 설정해야 합니다.");
			                if(aditCtgNms.length == 0){ $("input[name=aditCtgNm]").eq(i).focus();
				            }else if(ctgNms.length == 0){ $("input[name=ctgNm]").eq(i).focus(); }
			                return false;
				        }
		            }
		            ctgNmArray += ctgNms
		            if(i < 6) ctgNmArray += ","
		            
		            aditCtgNmArray += aditCtgNms
	                if(i< 6) aditCtgNmArray += "/"
	            }
	             
	            $("#ctgNms").val(ctgNmArray);
	            $("#aditCtgNms").val(aditCtgNmArray);
            }else{
	            $("#ctgNms").val($("#ctgNm").val());

                }

            return true;
        };
        
        //리셋+부류값셋팅
        var jsResetBtn = function(){
            $("#dataForm").reset();
            jsAditCtgSetting();
        }
        
        //부류값 셋팅
        var jsAditCtgSetting = function(){
            if(bbsCd == 1002 || bbsCd == 1031){
                var aditCtgNm = "";
                var aditIndex = 0;
                <c:forEach var="aditCtg" items="${dataVo.aditCtgNms}"  varStatus="status"> 
                    if(${aditCtg != "/"} ){
                        aditCtgNm += "${aditCtg}";
                        aditCtgNm += ","
                        
                        if(${status.last}){
                            $("#aditCtgNms"+aditIndex).val(aditCtgNm.substring(0,aditCtgNm.lastIndexOf(",")));
	                        	$("#aditCtgNms"+aditIndex).attr("temp",aditCtgNm.substring(0,aditCtgNm.lastIndexOf(",")));
                        }
                    }else{
                        $("#aditCtgNms"+aditIndex).val(aditCtgNm.substring(0,aditCtgNm.lastIndexOf(",")));
                        $("#aditCtgNms"+aditIndex).attr("temp",aditCtgNm.substring(0,aditCtgNm.lastIndexOf(",")));
                        aditCtgNm = "";
                        aditIndex++;
                    }
                </c:forEach> 
    
                var index=0;
                <c:forEach var="Ctg" items="${dataVo.ctgNms}"  varStatus="status"> 
                    $("#ctgNms"+index).val("${Ctg}");
                    $("#ctgNms"+index).attr("temp","${Ctg}");
                    index++;
                </c:forEach>  
            }
        }
        
        
        //]]>
    </script>
</head>
<body>

<div class="po_rel">
    <h4>게시판 설정</h4>
    <div class="h4_r">
        <span class="tx_red tx_b">*</span> 표시는 필수입력사항입니다.
    </div>
</div>

<!-- 탭 -->
<div id="bbsConfTabDiv">
    <ul>
        <li><a href="#globalDiv" class="on"><span>기본 정보</span></a></li>
        <li><a href="<c:url value="/intra/boardconf/INC_list.config.do"/>"><span>목록 설정</span></a></li>
        <li><a href="<c:url value="/intra/boardconf/INC_list.arrange.do"/>"><span>목록 배치</span></a></li>
        <li><a href="<c:url value="/intra/boardconf/INC_view.config.do"/>"><span>상세조회 설정</span></a></li>
        <li><a href="<c:url value="/intra/boardconf/INC_view.arrange.do"/>"><span>상세조회 배치</span></a></li>
        <li><a href="<c:url value="/intra/boardconf/INC_form.config.do"/>"><span>입력폼 설정</span></a></li>
        <li><a href="<c:url value="/intra/boardconf/INC_ext.config.do"/>"><span>항목관리</span></a></li>
    </ul>
</div>
<!-- //탭 -->

<div id="globalDiv">

    <form name="dataForm" id="dataForm" method="post" action="ND_boardconf.update.do">

        <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
        <op:pagerParam view="view" />
        <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${dataVo.domainCd}'/>" />
        <input type="hidden" name="bbsCd" id="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>" />
        <input type="hidden" name="gubunCd" value="<%= BoardConfConstant.GUBUN_CD_GLOBAL %>" />
        <input type="hidden" name="ctgNms" id="ctgNms" value="" />
        <input type="hidden" name="aditCtgNms" id="aditCtgNms" value="" />

        <!-- 내용쓰기 -->
        <fieldset>
            <legend>글입력</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="게시판 내용 작성페이지입니다.">
                <caption class="hidden">게시판 생성 페이지</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="domainNm">사이트 구분</label> <span class="tx_red tx_b">*</span></th>
                        <td><c:out value="${dataVo.domainNm}"/></td>
                    </tr>
                    <tr>
                        <th><label for="bbsNm">게시판 명</label> <span class="tx_red tx_b">*</span></th>
                        <td>
                            <input type="text" name="bbsNm" id="bbsNm" class="w180" title="게시판 명" value="<c:out value='${dataVo.bbsNm}'/>" onchange="jsChkValueChange('text', 'bbsNm', '${dataVo.bbsNm}');" />
                            <span class="tx_blue_s">- 최대 30자</span>
                            <valid:msg name="bbsNm" />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="bbsDc">게시판 개요</label></th>
                        <td>
                            <textarea id="bbsDc" name="bbsDc" rows="3" class="w99_p" title="게시판 개요" onchange="jsChkValueChange('textarea', 'bbsDc', '${dataVo.bbsDc}');">${dataVo.bbsDc}</textarea>
                            <span class="tx_blue_s">- 최대 300자</span>
                            <valid:msg name="bbsDc" />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="kndCd">게시판 종류 <span class="tx_red tx_b">*</span></label></th>
                        <td>
                            목록 : <select id="listSkin" name="listSkin" class="mar_b5">
                                <c:forEach items="${listTemplates}" var="list">
                                    <option value="${list.tmplatId}"<c:if test="${list.tmplatId eq dataVo.listSkin}"> selected</c:if>>${list.tmplatNm}</option>
                                </c:forEach>
                            </select><br />
                            읽기 : <select id="viewSkin" name="viewSkin" class="mar_b5">
                                <c:forEach items="${viewTemplates}" var="view">
                                    <option value="${view.tmplatId}"<c:if test="${view.tmplatId eq dataVo.viewSkin}"> selected</c:if>>${view.tmplatNm}</option>
                                </c:forEach>
                            </select><br />
                            쓰기 : <select id="formSkin" name="formSkin">
                                <c:forEach items="${formTemplates}" var="form">
                                    <option value="${form.tmplatId}"<c:if test="${form.tmplatId eq dataVo.formSkin}"> selected</c:if>>${form.tmplatNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="ctgYn">분류 사용 여부 <span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <input type="radio" name="ctgYn" id="ctgYn_Y" value="Y"<c:if test="${dataVo.ctgYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'ctgYn', '${dataVo.ctgYn}'); $('#ctgNmsTR1').show(); $('#ctgNmsTR2').show();" />
                            <label for="ctgYnY">사용</label>
                            <input type="radio" name="ctgYn" id="ctgYn_N" value="N"<c:if test="${dataVo.ctgYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'ctgYn', '${dataVo.ctgYn}'); $('#ctgNmsTR1').hide(); $('#ctgNmsTR2').hide();" />
                            <label for="ctgYnN">미사용</label>
                            <valid:msg name="ctgYn" />
                        </td>
                    </tr>
                    <tr id="ctgNmsTR1"<c:if test="${dataVo.ctgYn eq 'N'}"> class="none"</c:if>>
                        <th><label for="ctgNm">분류 설정 </label></th>
                        <td>
                        <c:choose>
	                        <c:when test="${dataVo.bbsCd eq 1002}">
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms0" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms0', $('#ctgNms0').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms0" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms0', $('#aditCtgNms0').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms1" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms1', $('#ctgNms1').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms1" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms1', $('#aditCtgNms1').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms2" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms2', $('#ctgNms2').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms2" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms2', $('#aditCtgNms2').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms3" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms3', $('#ctgNms3').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms3" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms3',$('#aditCtgNms3').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms4" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms4', $('#ctgNms4').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms4" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms4', $('#aditCtgNms4').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms5" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms5', $('#ctgNms5').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms5" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms5', $('#aditCtgNms5').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms6" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms6',$('#ctgNms6').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms6" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms6', $('#aditCtgNms6').attr('temp'));" />
		                        </p>
	                        </c:when>
	                        	<c:when test="${dataVo.bbsCd eq 1031}">
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms0" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms0', $('#ctgNms0').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms0" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms0', $('#aditCtgNms0').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms1" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms1', $('#ctgNms1').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms1" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms1', $('#aditCtgNms1').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms2" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms2', $('#ctgNms2').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms2" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms2', $('#aditCtgNms2').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms3" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms3', $('#ctgNms3').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms3" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms3',$('#aditCtgNms3').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms4" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms4', $('#ctgNms4').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms4" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms4', $('#aditCtgNms4').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms5" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms5', $('#ctgNms5').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms5" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms5', $('#aditCtgNms5').attr('temp'));" />
		                        </p>
		                        <p style="padding-bottom: 5px">
		                            1Depth : <input type="text" name="ctgNm" id="ctgNms6" style="width: 120px"   value="" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms6',$('#ctgNms6').attr('temp'));" />&nbsp; 
		                            2Depth : <input type="text" name="aditCtgNm" id="aditCtgNms6" style="width: 520px"  value="" title="분류2Depth명" onchange="jsChkValueChange('text', 'aditCtgNms6', $('#aditCtgNms6').attr('temp'));" />
		                        </p>
	                        </c:when>
	                        <c:otherwise>
		                        <p >
		                            <input type="text" name="ctgNm" id="ctgNm" class="w85_p" value="${fn:join(dataVo.ctgNms, ', ')}" title="분류1Depth명" onchange="jsChkValueChange('text', 'ctgNms', '${dataVo.ctgNms}');" />&nbsp; 
		                        </p>
	                        </c:otherwise>
                        </c:choose>
                            <p class="tx_blue_s">- 쉼표로 구분하여 분류명을 입력해 주세요. 입력한 순서대로 정렬순번이 지정됩니다.</p>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="noticeBbscttUseYn">공지 사용 여부 <span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <input type="radio" name="noticeBbscttUseYn" id="noticeBbscttUseYn_Y" value="Y"<c:if test="${dataVo.noticeBbscttUseYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'noticeBbscttUseYn', '${dataVo.noticeBbscttUseYn}');" />
                            <label for="noticeBbscttUseYnY">사용</label>
                            <input type="radio" name="noticeBbscttUseYn" id="noticeBbscttUseYn_N" value="N"<c:if test="${dataVo.noticeBbscttUseYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'noticeBbscttUseYn', '${dataVo.noticeBbscttUseYn}');" />
                            <label for="noticeBbscttUseYnN">미사용</label>
                            <valid:msg name="noticeBbscttUseYn" />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="cmtYn">의견글 사용 여부 <span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <input type="radio" name="cmtYn" id="cmtYn_Y" value="Y"<c:if test="${dataVo.cmtYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'cmtYn', '${dataVo.cmtYn}');" />
                            <label for="cmtYnY">사용</label>
                            <input type="radio" name="cmtYn" id="cmtYn_N" value="N"<c:if test="${dataVo.cmtYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'cmtYn', '${dataVo.cmtYn}');" />
                            <label for="cmtYnN">미사용</label>
                            <valid:msg name="cmtYn" />
                        </td>
                    </tr>
                    <!-- <tr>
                        <th><label for="skinPath">게시판 스킨 경로</label></th>
                        <td>
                            <input type="text" name="skinPath" id="skinPath" class="w120" title="게시판 스킨 경로" value="${dataVo.skinPath}" onchange="jsChkValueChange('text', 'skinPath', '${dataVo.skinPath}');" />
                            <span class="tx_blue_s">- 최대 20자</span>
                            <p class="tx_blue_s">- 스킨 폴더명은 [WEB_ROOT/web/board/skin] 하위의 폴더명을 지정하세요.</p>
                        </td>
                    </tr> -->
                </tbody>
            </table>
        </fieldset>
        <!-- //내용쓰기 -->

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="submit" value="저장" class="w_blue" /></li>
                <li><input type="button" value="취소" class="w_blue" onclick="changeFlag=false; jsResetBtn();" /></li>
                <li><input type="button" value="목록" class="blue" onclick="jsList();" /></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>

</div>

</body>
</html>