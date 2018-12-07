<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>기본협약관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">

//<![CDATA[
    $().ready(function () {
        $("input[name=chk-all]").click(function() {
            var isChecked = this.checked;
            $("input[name=bassAgremManageSeqs]").each(function() {
                this.checked = isChecked;
            });
        });
    });//ready end
    
    var jsMovePage = function(page){
      	var p = 1;
      	if(page == 'page'){
          	p = $('input[name=page]').val();
      	}else{
          	p = page;
      	}
      	$("#dataForm input[name=q_currPage]").val(p);
      	$("#dataForm").submit();
    };

    var jsSearch = function(){
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };
    
    var jsClean = function(){
        $("#q_searchVal").val("");
        document.dataForm.elements["q_init"].value = ""; /* 2016.07.26 수정 */
    };
    
    var jsMainForm = function(){
        history.back();
    };
    
    //기보협약등록
    var jsInsertForm = function(){
        document.dataForm2.action = "BD_insertForm.do";
        document.dataForm2.submit();
    };

    var jsUpdate = function(el, vl){
        document.dataForm2.action = "BD_updateForm.do?bassAgremManageSeq=" + vl;
        document.dataForm2.submit();
    };
    
    /**
     * 목록 삭제
     */
    var jsDeleteList = function(){
        var url = "ND_deleteAction.do?";
        var bassAgremManageSeqs = new Array();
        $("input[name=bassAgremManageSeqs]:checked").each(function (i) {
            bassAgremManageSeqs[i] = $(this).val();
            url += "bassAgremManageSeqs=" + $(this).val() + "&";
        });

        if(bassAgremManageSeqs.length == 0){
            jsWarningBox("삭제 대상을 1개 이상 선택하세요.");
            return false;
        }else{
            if(confirm("선택한 " + bassAgremManageSeqs.length + "개의 협약을 정말 삭제하시겠습니까?")){
                $.post(url,
                function(response){
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            self.location.reload();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                });
            }
        }
    };    
    
    var jsExcelList = function() {
      	location.href = "BD_indexExcel.do?" + $("#dataForm").serialize();
      	/* 
	    if ($('#excelFr').length == 0) {
            $('body').append('<iframe id="excelFr" style="display: none;"/>');
        }

        var url = "BD_indexExcel.do?" + $("#dataForm").serialize();
        $('#excelFr').attr('src',url);
         */
    };
    
    var jsUserView = function(el,id){
      	$(el).colorbox({
          	title : "사용자 정보",
          	href  : "/intra/orderManage/purchs/PD_userView.do?userId=" + id,
          	width : "500",
          	height: "450",
        	iframe: true
    	});
    };
    
    var jsStoreView = function(el,id){
        $(el).colorbox({
            title : "판매자 정보",
            href  : "/intra/orderManage/purchs/PD_storeView.do?userId=" + id,
            width : "700",
            height: "600",
            iframe: true
        });
     };
//]]>
</script>
</head>
<body>
    <div id="contents">
    	<form name="dataForm2" id="dataForm2" method="post">
        </form>
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>
            

            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="280" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                             <tr>
                                <th>정상 협약건수</th>
                                <td>${summaryBassAgrem.normalityAgreement}건</td>
                                <th>승인완료건수</th>
                                <td>${summaryBassAgrem.admissionCompletion}건(갱신${summaryBassAgrem.updateAgreement}건)</td>
                            </tr>
                             <tr>
                                <th>반려/보완신청 건수</th>
                                <td>${summaryBassAgrem.returnSupplementation}건</td>
                                <th>협약종료건수</th>
                                <td>${summaryBassAgrem.agreementExpiration}건</td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
            </div>
            
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                    	<colgroup>
                        	<col width="280" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                       		 <tr>
                                <th>회사명</th>
                                <td>
                                	<input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />" class="w215" title="검색어를 입력하세요." />
                                </td>
                                <th>제공자 신청 상태</th>
                                <td>
                                	<select name="q_searchStatVal" id="q_searchStatVal">
                                		<option value="">-- 전체 --</option>
	                                	<c:forEach items="${codeList_stat}" var="codeList" varStatus="status">
	                                		<option value="${codeList.prvCd}" <c:if test="${q_searchStatVal == codeList.prvCd}">selected="selected"</c:if>>${codeList.prvNm}</option>
	                                	</c:forEach>
                                	</select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                        
					<div>
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                    </div>
                </fieldset>
               
            </div>
            
            <op:pagerParam title="기본협약관리 목록" />
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
            	<col width="2%"/>
                <col width="4%"/>
                <col width="*%"/>
                <col width="6%"/>
                <col width="10%"/>
                <col width="7%"/>
                <%-- <col width="7%"/> --%>
                <col width="7%"/>
                <%-- <col width="7%"/> --%>
                <col width="3%"/>
                <col width="7%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="4%"/>
                <col width="4%"/>
            </colgroup>
            <thead>
            	<tr>
            		<th rowspan="2"><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
	                <th rowspan="2">No</th>
	                <th rowspan="2">회사명</th>
	                <!-- 제공자 신청 상태 신설 -->
	                <th rowspan="2">공급신청<br/>상태</th>
	                <th rowspan="2">담당자<br />(담당자ID)</th>
	                <th rowspan="2">신청일</th>
	                <!-- <th rowspan="2">제출일</th> -->
	                <th rowspan="2">체결완료일</th>
	                <!-- <th rowspan="2">발송일</th> -->
	                <th rowspan="2">차수</th>
	                <th rowspan="2">협약종료일</th>
	                <th colspan="7">제출서류</th>
	                <th rowspan="2">서비스<br/>등록</th>
                </tr>
                <tr>
                	<th>확정<br/>협약서</th>
                	<th>제출<br/>협약서</th>
                	<th>등기부<br/>등본</th>
                	<th>벤처기업<br/>증명서</th>
                	<th>직접생산<br/>증명서</th>
                	<th>신용<br/>평가서</th>
                	<th>재무<br/>제표</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                    	<td style="padding:0 0 0 0;"><input type="checkbox" name="bassAgremManageSeqs" value="${baseVo.bassAgremManageSeq}"/></td>
                        <td class="tx_r">${index-status.index}</td>
                        <td class="tx_l"><a href="#" onclick="jsUpdate(this,'${baseVo.bassAgremManageSeq}');">${baseVo.cmpnyNm}</a></td>
                        <!-- 제공자 신청 상태 변경 -->
                        <td style="padding:0 0 0 0;">
						<c:forEach items="${codeList_stat}" var="codeList" varStatus="status">
							<c:if test="${codeList.prvCd == baseVo.agremStatCd}">
								<c:out value="${codeList.prvNm}"/>
							</c:if>
						</c:forEach>
                     	 </td>
                        <td style="padding:0 0 0 0;"><%-- ${baseVo.chargerNm} --%>
                        
                        <a href="javascript:;" onclick="jsUserView(this,'${baseVo.userId}');"><span > ${baseVo.chargerNm} </span><br />(${baseVo.userId})</a>
                        </td>
                        <%-- <td style="padding:0 0 0 0;">${baseVo.presentnPrearngeDe}</td> --%>
                        <td style="padding:0 0 0 0;">${baseVo.presentnDe}</td>
                        <td style="padding:0 0 0 0;">${baseVo.cnclsComptDe}</td>
                        <%-- <td style="padding:0 0 0 0;">${baseVo.sndngDe}</td> --%>
                        <td style="padding:0 0 0 0;"><c:if test="${'' ne baseVo.agremOrder}">${baseVo.agremOrder}차</c:if></td>
                        <td style="padding:0 0 0 0;">${baseVo.agremEndDe}</td>
                        <td>
                        	<c:if test="${not empty baseVo.lastAgrmntFile[0]}">
	                        	<c:set var="bassAgrmntFileVo" value="${baseVo.lastAgrmntFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${bassAgrmntFileVo.fileId }" title="${bassAgrmntFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${not empty baseVo.bassAgrmntFile[0]}">
	                        	<c:set var="bassAgrmntFileVo" value="${baseVo.bassAgrmntFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${bassAgrmntFileVo.fileId }" title="${bassAgrmntFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${not empty baseVo.rgsbukTrnscrFile[0]}">
	                        	<c:set var="rgsbukTrnscrFileVo" value="${baseVo.rgsbukTrnscrFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${rgsbukTrnscrFileVo.fileId }" title="${rgsbukTrnscrFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${not empty baseVo.vnentrCrtfFile[0]}">
	                        	<c:set var="vnentrCrtfFileVo" value="${baseVo.vnentrCrtfFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${vnentrCrtfFileVo.fileId }" title="${vnentrCrtfFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${not empty baseVo.directPrdctnCrtfFile[0]}">
	                        	<c:set var="directPrdctnCrtfFileVo" value="${baseVo.directPrdctnCrtfFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${directPrdctnCrtfFileVo.fileId }" title="${directPrdctnCrtfFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${not empty baseVo.cdltDocFile[0]}">
	                        	<c:set var="cdltDocFileVo" value="${baseVo.cdltDocFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${cdltDocFileVo.fileId }" title="${cdltDocFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${not empty baseVo.fnlttFile[0]}">
	                        	<c:set var="fnlttFileVo" value="${baseVo.fnlttFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${fnlttFileVo.fileId }" title="${fnlttFileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td class="tx_r">${baseVo.goodsCnt}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="17" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        </form>
    </div>
    <div class="tx_r">
    <!-- 기본협약서 등록 불가 -->
    	<button class="blue" type="button" onclick="jsInsertForm();">기본협약등록</button>
        <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
    	<a href="#" onclick="jsExcelList();"><button class="blue" type="button">엑셀다운로드</button></a>
    </div>
</body>

</html>