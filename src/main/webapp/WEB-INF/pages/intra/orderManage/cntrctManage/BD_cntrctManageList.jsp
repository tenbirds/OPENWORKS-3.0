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
<title>이용실적목록</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<op:jsTag type="openworks" items="ckeditor" />
<script type="text/javascript">

//<![CDATA[
    $().ready(function () {
        $("input[name=chk-all]").click(function() {
            var isChecked = this.checked;
            $("input[name=cntrctSns]").each(function() {
                this.checked = isChecked;
            });
        });
        
        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
                
    });//ready end

    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero

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
        document.dataForm.action = "BD_cntrctManageList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_userType").val("");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");
        $("#q_beginDate").val("");
        $("#orgnCode").val("");
        $("#orgn_nm").val("");
        $("#q_mainList").val("");
        
    };
    
    // 계약결과 등록 화면 호출
    var jsMyCntrctForm = function(cntrctSn){
        $("#strCntrctSn").val(cntrctSn);
        document.dataForm1.action = "BD_cntrctManageDetail.do";        
        document.dataForm1.submit();
    }
    
    var jsExcelList = function() {
        $("#q_excel").val("2");
        location.href = "INC_cntrctExcel.do?" + $("#dataForm").serialize();
        $("#q_excel").val("");
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
    
    var jscntrctRegistModify = function(cntrctSn){
    	
        $("#strCntrctSn").val(cntrctSn);
        document.dataForm1.action = "BD_cntrctManageDetail.do";
        document.dataForm1.submit();
        
    };
    

//	var jscntrctRegistModify = function(){
        //document.dataForm.action = "/korean/pt/suplerCeart/BD_myCntrctForm.do";
        //document.dataForm.method = "POST";
        //document.dataForm.submit();
    //}
    
    
    var jsTempUserView = function(el,id){
      	$(el).colorbox({
          	title : "사용자 정보",
          	href  : "/intra/orderManage/purchs/PD_tempUserView.do?userId=" + id,
          	width : "500",
          	height: "450",
        	iframe: true
    	});
    };
    var jsStoreView = function(el,id){
        $(el).colorbox({
            title : "판매자 정보",
            href  : "/intra/orderManage/purchs/PD_reqstCnView.do?userId=" + id,
            width : "700",
            height: "600",
            iframe: true
        });
     };
    
     var organSearchPop = function(el) {
	        $(el).colorbox({
	            title  : "기관명 검색",
	            href   : "/korean/pt/register/PD_organSearchPop.do",
	            width  : "900",
	            height : "700",
	            overlayClose : false,
	            iframe : true
	        });
	    };
    /**
     * 목록 삭제
     */
    var jsDeleteList = function(){
        var url = "ND_deleteAction.do?";
        var cntrctSns = new Array();
        $("input[name=cntrctSns]:checked").each(function (i) {
            cntrctSns[i] = $(this).val();
            url += "cntrctSns=" + $(this).val() + "&";
        });

        if(cntrctSns.length == 0){
            jsWarningBox("삭제 대상 계약을 1개 이상 선택하세요.");
            return false;
        }else{
            if(confirm("선택한 " + cntrctSns.length + "개의 계약을 정말 삭제하시겠습니까?")){
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
    
    
    /**
     * 목록 삭제
     */
    var jsUpdateUseList = function(sn, at){
        
        var url = "ND_UpdateCntrctUseAction.do?cntrctSn="+sn+"&useAt="+at;
        $.get(url,
               function(response){
                   try {
                       if(eval(response)) {
                           self.location.reload();
                       } else {
                           jsErrorBox(Message.msg.processFail);
                       }
                   } catch (e) {
                       jsSysErrorBox(response, e);
                       return;
                   }
               });
    };
//]]>
</script>
</head>
<body>
    <div id="contents">
        
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_cntrctManageList.do">
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                            <colgroup>
                                <col width="120" />
                                <col width="100" />
                                <col width="100" />
                                 <col width="*" />
                            </colgroup>
                            <tbody>
                           		<tr>
                                    <th>검색조건 </th>
                                    <td colspan="3"><select id="q_userType" name="q_userType" >
                                    		<option value="" <c:if test="${searchMap.q_userType == ''}">selected="selected"</c:if>>전체</option>
                                    		<option value="ceart"  <c:if test="${searchMap.q_userType == 'ceart'}">selected="selected"</c:if>>씨앗회원</option>
                                    	    <option value="none"  <c:if test="${searchMap.q_userType == 'none'}">selected="selected"</c:if>>비회원</option>
                                    	</select>
                                    <!-- 검색조건 회원ID/사업명 -->
                                     <select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요"> 
                                          <option value="1001" <c:if test="${searchMap.q_searchKey == '1001'}">selected="selected"</c:if>>이용자ID</option>
                                          <option value="1002" <c:if test="${searchMap.q_searchKey == '1002'}">selected="selected"</c:if> >제공자ID</option>
                                      </select>
                                        <input type="text" class="w215" name="q_searchVal" id="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />"  title="검색어를 입력하세요." />
                                      </td>  
                                </tr>
                                <tr><%--  <th>이용자구분</th>
                                    <td><select id="q_userType1" name="q_userType1" >
                                    		<option value="" <c:if test="${searchMap.q_userType1 == ''}">selected="selected"</c:if>>전체</option>
                                    		<option value="30"  <c:if test="${searchMap.q_userType1 == '30'}">selected="selected"</c:if>>공공기관</option>
                                    		<option value="20"  <c:if test="${searchMap.q_userType1 == '30'}">selected="selected"</c:if>>민간기업</option>
                                    	</select>
                                    </td> --%>
                                    <th>계약시작일</th>
                                    <td colspan="3"><input class="w80" type="text"  name="q_beginDate" id="q_beginDate" title="시작날짜선택" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if>/></td>
                                </tr>
                                <tr>
                                	 <th>공공기관</th>
                                	 <td colspan="3">
                                	 	<input type="hidden" name="q_orgnCode" id="orgnCode" value="${searchMap.orgnCode}"  />
										<input type="text" name="q_orgn_nm" id="orgn_nm" readonly style="width:250px;" value="<c:out value="${searchMap.q_orgn_nm}" />" />
										<a href="#" class="btns st3" onclick="organSearchPop(this);">기관검색</a>
                                	 </td>
                                </tr>
                                <tr>
                               		<th>메인통계</th>
                               		<td colspan="3">(${cntInfo.CNT_AMT}개,  <fmt:formatNumber value="${cntInfo.SPLY_AMT}" type="NUMBER" groupingUsed="true" />만원)
                               			<input type="checkbox" name="q_mainList"  id="q_mainList" value="mainList" <c:if test="${not empty searchMap.q_mainList}"> checked </c:if>>메인통계 기준(계약실적)으로 보기</input>
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
            
            <op:pagerParam title="계약목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="30px"/>
                <col width="50px"/>
                <col width="100px"/>
                <col width="100px"/>
                <col width="*"/>
                <col width="*"/>
                <col width="100px"/>
                <col width="*"/>
                <col width="*"/>
                <col width="50px"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="50px"/>
                <col width="50px"/>
            </colgroup>
            <thead>
            	<tr>
            		<th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
	                <th>번호</th>
	                <th>이용자ID</th>
	                <th>제공자ID</th>
	                <th>사업명</th>
	                <th>판매서비스</th>
	                <th>계약체결일</th>
	                <th>계약기간</th>
	                <th>계약금액</th>
	                <th>판매<br />수량</br></th>
	                <th>이용기관</th>
	                <th>제공기관</th>
	                <th>계약서(PDF)</th>
	                <th>사용<br />여부</br></th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                    	<td><input type="checkbox" name="cntrctSns" value="${baseVo.cntrctSn}"/></td>
                        <td><c:out value="${index-status.index}"/></td>
                        <%-- <td><a href="javascript:;" onclick="jsUserView(this,'${baseVo.registId}');"><c:out value="${baseVo.purchsInsttNm}"/><br/>(<c:out value="${baseVo.registId}"/>)</a></td>
                        <td><a href="#" id="userId" name="userId"onclick="jsUserView(this,'<c:out value="${baseVo.userId}" />');"><c:out value="${baseVo.sleInsttNm}"/><br/>(<c:out value="${baseVo.userId}"/>)</a></td> 
                       	--%>
                        <td>
                        <c:if test="${baseVo.tempUserSn != null and baseVo.tempUserSn > 0}">
                         <a href="javascript:;" onclick="jsTempUserView(this,'${baseVo.tempUserSn}');">비회원</a>
                        </c:if>
                         <c:if test="${baseVo.tempUserSn == null or baseVo.tempUserSn == 0 }">
                        <a href="javascript:;" onclick="jsUserView(this,'${baseVo.registId}');"><c:out value="${baseVo.registId}"/></a>
                        </c:if>
                        </td>
                        <td><a href="#" id="userId" name="userId"onclick="jsUserView(this,'<c:out value="${baseVo.userId}" />');"><c:out value="${baseVo.userId}"/></a></td>
                        <td class="tx_l">
													<a href="#" id="cntrctSn" name="cntrctSn"onclick="jscntrctRegistModify('<c:out value="${baseVo.cntrctSn}" />');">${baseVo.svcNm}</a>	
                        </td>
                        <td class="tx_l">${baseVo.goodsNm}</td>
                        <td>${baseVo.cntrDt}</td>
                        <td>
                        	<fmt:parseDate var="cntrctBeginDe" value="${baseVo.cntrctBeginDe}" pattern="yyyyMMdd" />
                        	<fmt:parseDate var="cntrctEndDe" value="${baseVo.cntrctEndDe}" pattern="yyyyMMdd" />
                        	<fmt:formatDate value="${cntrctBeginDe}" type="both" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${cntrctEndDe}" type="both" pattern="yyyy-MM-dd"/>
                        </td>
                        <td class="tx_r"><fmt:formatNumber value="${baseVo.cntrctAmount}" groupingUsed="true"/></td>
                        <td class="tx_r"><fmt:formatNumber value="${baseVo.cntrCount}" groupingUsed="true"/></td>
                        <td class="tx_l">${baseVo.purchsInsttNm}</td>
                        <td class="tx_l">${baseVo.sleInsttNm}</td>
                        <td>
                        	<c:if test="${not empty baseVo.ctrtcFile[0]}">
	                        	<c:set var="fileVo" value="${baseVo.ctrtcFile[0]}" />
		                        <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">
		                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
		                    	</a>
	                    	</c:if>
                        </td>
                        <td>
                        	<c:if test="${baseVo.useAt eq 'Y'}"><a href="#" onClick="jsUpdateUseList('${baseVo.cntrctSn}','N');">계약실적</a></c:if> <c:if test="${baseVo.useAt eq 'N'}"><a href="#" onClick="jsUpdateUseList('${baseVo.cntrctSn}','Y');">이용실적</a></c:if> </td>
                    </tr> 
                </c:forEach>
                <op:no-data obj="${pager}" colspan="14" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        
        <op:pager pager="${pager}" />
        <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
        	<div class="float_l">
                <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
            </div>
            <div class="float_r">
				<a href="javascript:;" onclick="jsMyCntrctForm('<c:out value="" />'); return false;"><button class="w_blue" type="button">계약결과 수기등록</button></a>            
	            <a href="javascript:;" onclick="jsExcelList(this);"><button class="w_blue" type="button">엑셀다운로드</button></a>
	        </div>
        </c:if>
    </div>
	<form name="dataForm1" id="dataForm1" method="post">
    	<input type="hidden" id="strCntrctSn" name="strCntrctSn" />	
    </form>    
</body>

</html>