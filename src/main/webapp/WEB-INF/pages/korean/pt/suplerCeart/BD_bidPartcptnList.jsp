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
    <title></title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "/korean/pt/suplerCeart/BD_bidPartcptnList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }

	    // 공고명 선택 - 상세조회
	    var jsDetailView = function(notifyNum, notifySeq){
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            document.dataForm.action = "/korean/pt/suplerCeart/BD_bidSttusDetailView.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
	    }

        // 계약체결 완료처리 팝업 호출
        function jsContractCompletePopup(el){
            var choiseBid = $("input[type=radio][name=notifyChk]:checked").val();

            if(choiseBid == null || choiseBid == 'undefined'){
                alert("처리할 공고를 선택하세요.");
                return false;
            }else{
                var notifyInfo = choiseBid.split('|');
                var notifyNum  = notifyInfo[0];
                var notifySeq  = notifyInfo[1];
                var cntrGbn    = notifyInfo[2];
                
                if(cntrGbn == 'Y'){
                    alert("이미 완료된 공고입니다.");
                    return false;
                }
            }

            $(el).colorbox({
                title : "계약체결 완료처리",
                href : "/korean/pt/popup/PD_cntrctCmplPop.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq+"&suplerId=null",
                width : "920",
                height : "560",
                overlayClose : false,
                escKey : false,
                iframe : true
            });
        }

        // 계약변경 팝업 호출
        function jsContractChangePopup(el){
            var choiseBid = $("input[type=radio][name=notifyChk]:checked").val();

            if(choiseBid == null || choiseBid == 'undefined'){
                alert("처리할 공고를 선택하세요.");
                return false;
            }else{
                var notifyInfo = choiseBid.split('|');
                var notifyNum  = notifyInfo[0];
                var notifySeq  = notifyInfo[1];
                var cntrGbn    = notifyInfo[2];
                
                if(cntrGbn != 'Y'){
                    alert("계약이 완료되지 않은 공고입니다.");
                    return false;
                }
            }

            $(el).colorbox({
                title : "계약변경",
                href : "/korean/pt/popup/PD_cntrctCmplPop.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq+"&suplerId=null",
                width : "920",
                height : "560",
                overlayClose : false,
                escKey : false,
                iframe : true
            });

        }
    </script>

</head>
<body>
	    
	        
			<div class="supAdm bidJoin">
			<form name="dataForm" id="dataForm">	        
	        <input type="hidden" name="q_currPage"  id="q_currPage"      value="${currPage}"/>            <!--  현재 페이지 -->
            <input type="hidden" name="p_notifyNum" id="p_notifyNum"   />                 <!--  상세페이지용 -->
            <input type="hidden" name="p_notifySeq" id="p_notifySeq"   />                 <!--  상세페이지용 -->
	        <input type="hidden" name="closeYn"     id="closeYn"    value=""/>            <!--  공고 마감여부 -->
	        <input type="hidden" name="bidKndCd"    id="bidKndCd"   value="1001"/>        <!--  공고종류 -->
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01" >
							<option value="1001" <c:if test="${searchDiv01 == '1001'}">selected="true"</c:if> >수요기관 명</option>
							<option value="1002" <c:if test="${searchDiv01 == '1002'}">selected="true"</c:if> >공고명</option>							
						</select><label for="searchDiv01"></label>
					</span>
					
					<div>
						<label><input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/></label>
					</div>
					<a href="#" onclick="javascript:jsListSearch(0);" class="btns st5">검 색</a>
				</div>				
				
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
						
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="javascript:jsListSearch(0);">
								<option value="1001" <c:if test="${searchDiv02 == '1001'}">selected="true"</c:if> >신규 등록순</option>					
								<option value="1002" <c:if test="${searchDiv02 == '1002'}">selected="true"</c:if> >마감 임박순</option>
								<option value="1003" <c:if test="${searchDiv02 == '1003'}">selected="true"</c:if> >수의계약</option>
								<!-- option value="1004" <c:if test="${searchDiv03 == '1004'}">selected="true"</c:if> >변경공고</option -->
							</select><label for="searchDiv02"></label>
						</span>
					</p>
					
					<table class="tbl_st1" summary="공고참여현황 목록">
						<caption>공고참여현황</caption>
						<colgroup>
							  <col width="5%"/>
								<col width="10%"/>
								<col width="*"/>
								<col width="20%"/>
								<col width="10%"/>
								<col width="5%"/>
								<col width="10%"/>
								<col width="10%"/>
								<col width="5%"/>
								<col width="5%"/>
						</colgroup>
						<thead>
							<tr>
							  <th scope="row">선택</th>
								<th scope="row">공고번호</th>
								<th scope="row">공고명</th>
								<th scope="row">수요기관</th>
								<th scope="row">계약방법</th>
								<th scope="row">진행상태</th>
								<th scope="row">공고일시<br />(마감일시)</th>
								<th scope="row">응찰일시</th>
								<th scope="row">낙찰<br />상태</th>
								<th scope="row">계약<br />상태</th>
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
	                           <c:forEach items="${pager.list}" var="listData" varStatus="status">
								<tr>
								    <td>
								        <c:if test="${listData.bidSussGbn eq 'Y'}"><input type="radio" name="notifyChk" value="${listData.notifyNum}|${listData.notifySeq}|${listData.cntrGbn}"/></c:if>
								    </td>
									<td>${listData.notifyNum}-${listData.notifySeq}</td>
									<td class="tit" style="word-break: break-all !important;"><a href="#" onclick="jsDetailView('${listData.notifyNum}', '${listData.notifySeq}'); return false;">${listData.bidNotifyNm}</a></td>
									<td style="word-break: break-all !important;">${listData.realDmndOrgn}</td>
									<td>${listData.cntrMothodNm}</td>
									<td>${listData.bidPgesStatNm}</td>
									<td>
										${listData.strtDt} ${listData.strtTime}시<br />
										(${listData.clseDt} ${listData.clseTime}시)
									</td>
									<td>
									    <c:if test="${listData.entrDt != '' and listData.entrDt != null}">
									        ${listData.entrDt}<br />${listData.entrTime}시
									    </c:if>
									</td>
									<td>
	                     	            <c:choose>
	                                        <c:when test="${listData.bidSussGbn eq 'Y'}">낙찰</c:when>
	                                        <c:otherwise>
	                                            <c:choose>
	                                                <c:when test="${listData.askApplyCd eq '1002'}">반려</c:when>
	                                                <c:when test="${listData.askApplyCd eq '1003'}">응찰</c:when>
	                                            </c:choose>
	                                        </c:otherwise>
	                                    </c:choose>
									</td>
									<td>
									    <c:if test="${listData.cntrGbn eq 'Y'}">체결</c:if>
									</td>
								</tr>
	                           </c:forEach>
	                           <!-- 데이터가 없을 때 알림 문구 -->
	                           <c:if test="${empty pager.list}">
	                               <op:no-data obj="${pager}" colspan="10" />
	                           </c:if>
						</tbody>
					</table>								
				</div>
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
                <!-- 버튼영역 -->
				<div class="btnArea rig">
					<a href="#" onclick="jsContractCompletePopup(this); return false;" class="btns st1 icn icnSave">계약체결 완료처리</a>
					<a href="#" onclick="jsContractChangePopup(this); return false;" class="btns st1 icn icnChange">계약변경</a>
				</div>
				<!-- //버튼영역 -->
				</form>
			</div>
		
</body>
</html>