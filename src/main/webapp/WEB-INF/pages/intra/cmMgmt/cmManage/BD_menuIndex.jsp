<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 게시판 관리</title>
	<op:jsTag type="spi" items="form,validate,colorbox, datepicker" />
	<op:jsTag type="openworks" items="form, validate, ui" />
    <script type="text/javascript">
  	//<![CDATA[
	    $(document).ready(function() {
					var  langCodeTab = "${param.q_langCodeTab}";
					if(langCodeTab ==""){
					    $("#q_langCodeTab").val("00");
					}
   	 	});
	    
     
	   // 페이지 이동
	   var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	   };
	 
        // 커뮤니티 개설신청 정보 팝업 view 
        var jsPopupView = function(el, cmmntyId, langCode, userId) {
            $(el).colorbox({
               	title : "커뮤니티 개설신청 정보",         
     			href      : "PD_openInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId,
     			width : "1200px",
     	        height : "600px",
               iframe : true
           }); 
        };
        var jsMovePage = function(page) {
            var p = 1;
            if (page == 'page') {
                p = $('input[name=page]').val();
            } else {
                p = page;
            }
            $("#dataForm input[name=q_currPage]").val(p);
            $("#dataForm").submit();
        };    
        
//         var validation = {     
//                 /** ajax submit validation **/
//         		   dataForm : function() {
//         		       /** 지역변수 **/
//         		       if($("input[name=ckMultiBox]").is(':checked') == false){
//         		           		alert("최소 한개이상은 체크하셔야 합니다.");
//                            	$("input[name=ckMultiBox]").focus();
//         		           return false;
//         		       }	
//         		   }
//         	};
		// 언어탭 이동
        var toplangMove = function(langCode){
            
            $("#q_langCodeTab").val(langCode);
            $('#q_currPage').val("1");
            $('#dataForm').submit();
            
       	};
      //언어코드 메뉴 수정 
        var jsCmMenuUpdate = function(){
            //checkSelectedValue();
          	 if ( confirm("커뮤니티 메뉴 목록을 수정 하시겠습니까?") ) {
          	   checkSelectedValue();
   	 	        $("#dataForm").ajaxSubmit({
   	   	            url      : "INC_cmMenuUpdate.do",
   	   	            type     : "POST",
   	   	            dataType : "json",
   	   	            success  : function(response) {
   	   	                if (response.result) {
   	   	                    jsSuccessBox("메뉴 목록이 수정 되었습니다.");
   	   	                 	jrMove("BD_menuIndex.do");
   	   	                } else { 
   	   	                    jsErrorBox(response.message);
   	   	                   	return;
   	   	                }
   	   	            }
   	   	        });
          	 }
       	};
       	//새 언어코드 메뉴 등록
        var jsCmMenuInsert = function(){
					
         	 if ( confirm("커뮤니티 새 메뉴 목록을 등록 하시겠습니까?") ) {
         	    checkSelectedValue();
  	 	        $("#dataForm").ajaxSubmit({
  	   	            url      : "INC_cmMenuInsert.do",
  	   	            type     : "POST",
  	   	            dataType : "json",
  	   	            success  : function(response) {
  	   	                if (response.result) {
  	   	                    jsSuccessBox("새 메뉴 목록이 등록 되었습니다.");
  	   	                 	jrMove("BD_menuIndex.do");
  	   	                } else { 
  	   	                    jsErrorBox(response.message);
  	   	                   	return;
  	   	                }
  	   	            }
  	   	        });
         	 }
      	};
      	
      	var checkSelectedValue = function (){
		    var valueArr = new Array();
		    var list = $("input[name='ckMultiBox']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){
		            valueArr.push(list[i].value);
		        }else{
		            valueArr.push("2");
		        }
		    }
		    $("#multiCheck").val(valueArr);
		};
	//]]>
	 </script>
</head>
<body>
	<!-- 컨텐츠영역 -->
	<div id="contents">
	<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" name="multiCheck" id="multiCheck"  value="" />
	<input type="hidden" name="q_langCodeTab" id="q_langCodeTab"  value="${param.q_langCodeTab}" />
	<input type="hidden" name="multiCheck" id="multiCheck"  value="" />
		   <h2 class="mar_t20">커뮤니티 메뉴 목록</h2>
			<div class="mar_t30">
	            <ul class="blet">
	                <li > 커뮤니티 최초 개설 시에 자동으로 생성되는 게시판을 설정합니다.</li>
	            </ul>
        	</div>
            <!-- 탭 -->
            <ul class="tab">
           	<c:forEach items="${langCodeList}" var="data" varStatus="status">
           	<c:choose>
           		<c:when test="${status.count == 1 }">
           		    <li><a href="#" id="<c:out value='${data.langCode}'/>" onclick="toplangMove('<c:out value='${data.langCode}'/>');" <c:if test="${data.langCode == param.q_langCodeTab || empty param.q_langCodeTab }">class="on"</c:if>><c:out value="${data.langNm}"/></a></li>
           		</c:when>
           		<c:otherwise>
				<li><a href="#" id="<c:out value='${data.langCode}'/>" onclick="toplangMove('<c:out value='${data.langCode}'/>');" <c:if test="${data.langCode == param.q_langCodeTab}">class="on"</c:if>><c:out value="${data.langNm}"/></a></li>
				</c:otherwise>
			</c:choose>
			</c:forEach>         
            </ul>
            <!-- //탭 -->
            
                        <!-- 리스트 -->
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
                    <col width="20%"/>
                    <col width="15%"/>
					<col width="15%"/>
					<col width="*%"/>
					<c:if test="${cmManagelistTotalCnt == 0 }" >
					<col width="25%"/>
					</c:if>
                </colgroup>
                <thead>
                    <tr>
                    	<th>게시판명 </th>
                    	<th>구분</th>
                        <th>커뮤니티 개설 필수</th>
                        <th>JSP 폴더명</th>
                        <c:if test="${cmManagelistTotalCnt == 0 }" >
                        <th>언어별 메뉴명</th>  
                        </c:if>                  
                    </tr>
                </thead>
                <tbody id="odd-color">	
                	<c:if test="${ cmManagelistTotalCnt > 0 }" >
                    <c:forEach items="${cmManagelist}" var="data" varStatus="status">
                        <tr>
                            <td><input type="text" id="cmmntyMenuMultiNm_<c:out value='${status.count}'/>"  name="cmmntyMenuMultiNm" value="<c:out value="${data.cmmntyMenuNm}"/>" maxlength="45" />
                            <input type="hidden" id="cmmntyMenuMultiCode_<c:out value='${status.count}'/>"  name="cmmntyMenuMultiCode" value="<c:out value="${data.cmmntyMenuCode}"/>" />
                            </td>
                            <td><c:out value="${data.menuCharctNm}"/></td>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="1" <c:if test="${data.essntlMenuAt eq '1'}">checked="checked"</c:if>
                            </td>
                            <td><c:out value="${data.cmmntyMenuFolderNm}"/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${cmManagelist}" colspan="4" />
                    </c:if>
                    <c:if test="${ cmManagelistTotalCnt == 0 }" >
                    <c:forEach items="${cmManageKorealist}" var="data" varStatus="status">
                        <tr>
                            <td><c:out value="${data.cmmntyMenuNm}"/> <input type="hidden" id="cmmntyMenuMultiCode_<c:out value='${status.count}'/>"  name="cmmntyMenuMultiCode" value="<c:out value="${data.cmmntyMenuCode}"/>" /></td>
                            <td><c:out value="${data.menuCharctNm}"/></td>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="1" <c:if test="${data.essntlMenuAt eq '1'}">checked="checked"</c:if>/>
                            <input type="hidden" id="cmmntyMenuMultiCode_<c:out value='${status.count}'/>"  name="cmmntyMenuMultiCode" value="<c:out value="${data.cmmntyMenuCode}"/>" />
                            </td>
                            <td><c:out value="${data.cmmntyMenuFolderNm}"/></td>
                            <td><input class="w215" type="text" id="cmmntyMenuMultiNm_<c:out value='${status.count}'/>"  name="cmmntyMenuMultiNm" value=""  maxlength="50"/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${cmManageKorealist}" colspan="5" />
                    </c:if>
                </tbody>
            </table>
            <!-- //리스트 -->
            <br/>
	            <!-- 버튼 -->
            <div>
                <div class="float_r">
                	<c:if test="${ cmManagelistTotalCnt > 0 }" >
                    <a href="#" class="btn"><button id="butCon" type="button" onclick="jsCmMenuUpdate();" class="blue">적용</button></a>
                    </c:if>
                    <c:if test="${ cmManagelistTotalCnt == 0 }" >
                    <a href="#" class="btn"><button id="butCon" type="button" onclick="jsCmMenuInsert();" class="blue">적용</button></a>
                    </c:if>
                </div>
            </div>
            </form>
          <div class="mar_t30">
            <ul class="blet">
                <li class="tx_b"> 기본 게시판은 1개 이상 생성이 불가능한 게시판입니다.</li>
                <li class="tx_b"> 기본 게시판은 삭제는 불가능 하고, 이름 변경 및 게시판의 순서변경은 가능합니다.</li>
                <li class="tx_b"> 선택 게시판은 커뮤니티 운영자가 사용 목적에 따라 동일한 형태의 게시판을 추가하여 이름 변경 및 게시판의 순서를 변경하여 사용하고 삭제 할 수 있습니다.</li>
                <li class="tx_b"> 개설 필수 체크 항목은 커뮤니티가 개설되면 자동으로 1개씩 생성되는 게시판입니다.</li>
            </ul>
        </div>
        </div>
        <!-- //컨텐츠영역 -->
        <br/>
</body>
</html>