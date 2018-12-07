<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>실적증명발급관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">
		$().ready(function () {
		    $("input[name=chk-all]").click(function() {
		        var isChecked = this.checked;
		        $("input[name=indexs]").each(function() {
		            this.checked = isChecked;
		        });
		    });
		            
		});//ready end
		/*  페이지 이동 (페이징 처리) */
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
		/*  검색 */
	    var jsSearch = function(){
		    var q_searchVal = $('#q_searchVal').val();
		    var q_beginDate = $('#q_beginDate').val();
		    var q_endDate = $('#q_endDate').val();
	/* 	    if(q_searchVal == null || q_searchVal == ''){
		       alert("검색조건 : 회원ID 혹은 회원명 입력해주세요.");
		       	return false;
		   } */
	       document.dataForm.action = "BD_index.do";
	       document.dataForm.elements["q_currPage"].value = "1";
	       $("#dataForm").submit();
		    
	    };  

        var jsAcmsltCrtfReport = function(el,certResultCode) {
            var indexs = new Array();
            var codeNm = new Array();
            var cntrctSn = new Array();
            var commUserId = new Array();
	        var cntrDt = new Array();
			var type = 0;
			var Msg ="";
            $("input[name=indexs]:checked").each(function (i) {
                indexs[i] = $(this).val();
                codeNm[i] = $("#codeNm" + this.value).val();
                cntrctSn[i] = $("#cntrctSn" + this.value).val();
                commUserId[i] = $("#commUserId" + this.value).val();
                cntrDt[i] = $("#cntrDt" + this.value).val();
            });
            if(indexs[0] == null || codeNm[0] == null|| commUserId[0] == null){
                alert("데이터를 선택되지 않았습니다.");
            	return false;
            }
            if(indexs.length != 1){
      	         for(var i = 0; i < indexs.length; i += 1){
                      if(commUserId[i+1] != null){
                          if(commUserId[i] == commUserId[i+1]){
                              type=0;
                          }else{
                              /*순서 : 실적증명요청 -> 관리자 승인 -> 증명서 발급
                               	증명서 발급이 최종 단계
                              	
                               	발급완료된 데이터는 관리자 승인이 안됨*/
                              if(certResultCode == 1004){
                                  if(codeNm[i] == "발급완료"){
                                      type = 2;
                                  }
                              /* 관리자 승인일때만 가능*/
                              }else if(certResultCode ==1003){
                                  if(codeNm[i] == "실적증명요청"){
                                      type = 3;
                                  }
                              }else{
                                  type = 1;
                              }
                          }
                          if(type!=0){
                              break;
                          }
                      }else if(commUserId[i] == commUserId[i-1]){
                          type = 0;
                      }else{
                          type = 1;
                      }
                      if(certResultCode == 1004){
                          if(codeNm[i] == "발급완료"){
                              type = 2;
                          }
                      }else  if(certResultCode == 1003){
                          if(codeNm[i] == "실적증명요청"){
                              type = 3;
                          }
                      }
                      if(type!=0){
                          break;
                      }
                  }
            }else{
                if(certResultCode ==1004){
                    if(codeNm[0] == "발급완료"){
                        type = 2;
                    }
                }else if(certResultCode ==1003){
                    if(codeNm[0] == "실적증명요청"){
                        type = 3;
                    }
                }else{
                type = 0;
                }
            }
            if(certResultCode == 1003){
                if(type == 1){
                    alert("회원명이 같지 않은 데이터가 있습니다."); 
                    return false;
                }else if(type == 3){
                    alert("관리자 승인된 데이터만 발급가능합니다."); 
                    return false;
                }    
               	Msg ="증명서 발급"
            }else if(certResultCode == 1004){
                if(type == 2){
                    alert("발급완료된 데이터가 포함되어있습니다."); 
                    return false;
                }       
                Msg ="관리자 승인"
            }
            if(confirm("선택한 " + indexs.length + "개의 "+Msg+"하시겠습니까?")){
                
           		jQuery.ajaxSettings.traditional = true;
           		if(certResultCode == 1003){
           		var open = "/report/reporting.jsp?reportSection=4001&cntrctSn="+cntrctSn+"&commUserId="+commUserId[0];
    			window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
           		}
                $.ajax({
                    url     : "BD_upDate.do",
                    type    : "POST",
                    data	: {cntrctSnArray : cntrctSn, certResultCode : certResultCode},
                    success : function(result) {
                       self.location.reload();
                    }
              	});
          	}
        }    
//]]>         
</script>      
</head>     
<body>    	
    <div id="contents">
        	
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_index.do">
        	<input name="userId" id="userId" value="${param.q_searchVal}" type="hidden"/>
        	<input name="cntrctSnArray" id="cntrctSnArray" type="hidden"/>
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" summary="검색 조건">
                            <colgroup>
                                <col width="10%" />
                                <col width="18%" />
                                <col width="5%" />
                                <col width="20%" />
                            </colgroup>
                            <tbody>
                           		 <tr>
                                    <th>검색조건</th>
                                    <td>
                                    <!-- 검색조건 회원ID/사업명 -->
                                      <select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요"> 
                                          <option value="1002" <c:if test="${param.q_searchKey eq 1002}">selected="selected"</c:if>>회원명</option>
                                          <option value="1001" <c:if test="${param.q_searchKey eq 1001}">selected="selected"</c:if>>회원ID</option>
                                      </select>
                                        <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value="${param.q_searchVal}" />" class="w215" title="검색어를 입력하세요." />
                                    </td>
	                                <th>신청상태</th>
	                                <td>
	                                <select id="q_searchType" name="q_searchType" title="신청상태를 선택하세요.">
                                    <option value="" <c:if test="${param.q_searchType eq ''}">selected="selected"</c:if>>전체</option>
                                    <c:forEach items="${codeList}" var="code" varStatus="status">							
										<c:if test="${code.prvNm ne '반려'}" >
										<option value="${code.prvCd}" <c:if test="${param.q_searchType eq code.prvCd}">selected="selected"</c:if>>${code.prvNm}</option>
					                	</c:if>
					                </c:forEach>	
					                </select>
	                               <%--  <select id="q_searchType" name="q_searchType" title="신청상태를 선택하세요.">
                                          <option value="" <c:if test="${param.q_searchType eq ''}">selected="selected"</c:if>>전체</option>
                                          <option value="1001" <c:if test="${param.q_searchType eq '1001'}">selected="selected"</c:if>>발급신청</option>
                                          <option value="1003" <c:if test="${param.q_searchType eq '1003'}">selected="selected"</c:if>>발급완료</option>
                                          <option value="1004" <c:if test="${param.q_searchType eq '1004'}">selected="selected"</c:if>>관리자승인</option>
                                    </select> --%>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                      <div>
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                      </div>
                </fieldset>
            </div>
            <op:pagerParam title="실적증명발급관리" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
	            <col width="3%"/>
	            <col width="7%"/>
	            <col width="10%"/>
                <col width="5%"/>
                <col width="20%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="10%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="7%"/>
                <col width="7%"/>
            </colgroup>
            <thead>
            	<tr>
            		<th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
            		<th>회원명</th>
            		<th>구매기관</th>
	                <th>구매방식</th>
	                <th>서비스명</th>
	                <th>등록일</th>
	                <th>계약일</th>
	                <th>계약기간</th>
	                <th>승인일자</th>
	                <th>발급일자</th>
	                <th>계약금액</th>
	                <th>실적증명신청상태</th>
                </tr>
            </thead>
            <tbody id="odd-color">

                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                    	<td><input type="checkbox" name="indexs" value="${index-status.index}"/></td>
                    	<td>${baseVo.userNm}
	                    <input type="hidden" name="userNm" id="userNm${index-status.index}" value="${baseVo.userNm}"/>
	                    <input type="hidden" name="commUserId" id="commUserId${index-status.index}" value="${baseVo.commUserId}"/>
	                    <input type="hidden" name="cntrctSn" id="cntrctSn${index-status.index}" value="${baseVo.cntrctSn}"/>
	                    <input type="hidden" name="cntrDt" id="cntrDt${index-status.index}" value="${baseVo.cntrDt}"/>
                    	<input type="hidden" name="codeNm" id="codeNm${index-status.index}" value="${baseVo.codeNm}" id="codeNm${index-status.index}"/>
    					
                    	</td>
    <!-- 구매기관 -->	    <td>${baseVo.realDmndOrgn}</td>
    <!-- 구매방식 -->	    <td>${baseVo.bidGbnCd}</td>
    <!-- 서비스명 -->     <td>${baseVo.svcNm}</td>
    <!-- 등록일   -->     <td>${baseVo.registDt}</td>
    <!-- 계약일   -->     <td>${baseVo.cntrDt}</td>
    <!-- 계약기간 -->     <td>
    					${fn:substring(baseVo.cntrctBeginDe,0,4)}-${fn:substring(baseVo.cntrctBeginDe,4,6)}-${fn:substring(baseVo.cntrctBeginDe,6,8)}
    					~
    					${fn:substring(baseVo.cntrctEnd,0,4)}-${fn:substring(baseVo.cntrctEnd,4,6)}-${fn:substring(baseVo.cntrctEnd,6,8)}
    					</td>
    <!-- 승인일자 -->		<td>${baseVo.recogDt}</td>
    <!-- 발급일자 -->		<td>
    					<c:if test="${baseVo.certResultDt ne null}">
    					${fn:substring(baseVo.certResultDt,0,4)}-${fn:substring(baseVo.certResultDt,4,6)}-${fn:substring(baseVo.certResultDt,6,8)}
    					</c:if>
    					</td>
    <!-- 계약금액 -->     <td class="tx_r">${baseVo.cntrctMount}</td>
    <!-- 신청상태 -->     <td>${baseVo.codeNm}</td>
                    </tr> 
                </c:forEach>
                <op:no-data obj="${pager}" colspan="12" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        
        	<div class="tx_r">
                <button class="blue" type="button" name="submits" id="submits" onclick="jsAcmsltCrtfReport(this,1004);">관리자 승인</button>
                <button class="blue" type="button" name="submits" id="submits" onclick="jsAcmsltCrtfReport(this,1003);">증명서 발급</button>
            </div>
    </div>
</body>

</html>