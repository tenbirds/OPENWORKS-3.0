<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<html>
<head>
<title>사용자 권한 등록</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function(){        
        $("#butSave").click(function(){
            
            var strSubmitData = jsSubmitData();
            
            $("#strSubmitData").val(strSubmitData);
            
	        $("#dataForm").ajaxSubmit({
	            url      : "PD_insertUserAuthPopAction.do",
	            type     : "POST",
	            dataType : "json",	            
	            success  : function(response) {
	                if (response.result) {
	                    jsSuccessBox(response.message);
	                    //parent.jsSearch();
	                } else { 
	                    jsErrorBox(response.message);
	                }
	            }
	        });
        });
    });
    
    var jsSubmitData = function(){
        var intObjLength = $("input[name=userId]").length;
        
        var resultData = "";
        
        for(var i = 0 ; i < intObjLength; i++){                
            var strUserId = "";
            var strAuthC = "N";
            var strAuthR = "N";
            var strAuthU = "N";
            var strAuthD = "N";
            
            strUserId = $("input[name=userId]").eq(i).val();
            
            if($("input[name=authC]").eq(i).is(":checked")){
                strAuthC = "Y";
            }
            
            if($("input[name=authR]").eq(i).is(":checked")){
                strAuthR = "Y";    
            }
             
            if($("input[name=authU]").eq(i).is(":checked")){
                strAuthU = "Y";    
            }
             
            if($("input[name=authD]").eq(i).is(":checked")){
                strAuthD = "Y";    
            }
            
            if(i==0){
                resultData += strUserId+","+strAuthC+","+strAuthR+","+strAuthU+","+strAuthD;    
            }else{
                resultData += "|"+strUserId+","+strAuthC+","+strAuthR+","+strAuthU+","+strAuthD;
            }   
        }
        
        return resultData;
    }
    
    var jsSearch = function(){
        document.dataForm.elements["q_currPage"].value = "1";        
        $("#dataForm").attr("action","PD_manageUserAuthPopView.do").submit();
    }
    
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
//]]>              
</script>               
</head>
<body>
<form name="dataForm"id="dataForm">
	<!-- 컨텐츠영역 -->
    <div id="popup" style="width:720px;">
        <!-- 기본정보 -->
        <h2 class="mar_t20">
	        	사용자 권한 등록
        </h2>
        <fieldset>
        <legend>메타정보등록</legend>
        <table id="userAuthTab" class="boardWrite" cellspacing="0" border="1" summary="메타 정보 입니다.">
            <caption class="hidden"> 메타정보 </caption>
            <colgroup>
                <col width="40%"/>
                <col/>
        	</colgroup>
        	<tbody>
        	<tr>
        		<th>메타정보명</th>
                <td>
                 ${ metaMasterDetail.metaMasterNmV }
                <input type="hidden" name="i_metaMasterSeqN"  id="i_metaMasterSeqN" value="${ metaMasterDetail.metaMasterSeqN }"/>
                <input type="hidden" name="q_metaMasterSeqN"  id="q_metaMasterSeqN" value="${ metaMasterDetail.metaMasterSeqN }"/>
                <input type="hidden" name="strSubmitData"  	  id="strSubmitData"/>
                </td>
        	</tr>
        	</tbody>
        </table><br/>
        
        <div class="search">
	        <fieldset>
	            <legend>검색하세요</legend>
	            <select name="q_searchKind" id="q_searchKind">
	            <option>선택하세요.</option>
	            <option value="userNM" <c:if test="${ param.q_searchKind eq 'userNM' }">selected</c:if>>사용자명</option>
	            <option value="userID" <c:if test="${ param.q_searchKind eq 'userID' }">selected</c:if>>사용자ID</option>
	            </select> &nbsp;
	            <input type="text" name="q_serchUser" id="q_serchUser" value="${param.q_serchUser }" />
	            <button type="button" class="gray mar_l5" id="buttSearch" onclick="JavaScript:jsSearch();">검색</button>      
	        </fieldset>
    	</div>
        <op:pagerParam title="사용자 권한 리스트" />
        <table id="userAuthTab" class="boardWrite" cellspacing="0" border="1" summary="사용자 권한 등록 입니다.">
            <caption class="hidden"> 사용자 리스트 </caption>
            <colgroup>
                <col width="40%" />
                <col width="15%" />
                <col width="15%" />
                <col width="15%" />
                <col width="15%" />
            </colgroup>
            <tbody>
                <tr>
                    <th style="text-align:center;">사용자아이디</th>
                    <th style="text-align:center;">쓰기</th>
                    <th style="text-align:center;">읽기</th>
                    <th style="text-align:center;">수정</th>                    
                    <th style="text-align:center;">삭제</th>                    
                </tr> 
                <c:forEach items="${pager.list}" var="listVO" varStatus="status">
                <tr>
                    <td style="text-align:center;">
                    	${ listVO.userNmV }( ${ listVO.userId } )
                   	</td>
                    <td style="text-align:center;">
                    	<input type="hidden" name="userId" id="userId" value="${ listVO.userId }" />
                    	<input type="checkbox" name="authC" id="authC" <c:if test="${ listVO.authCC eq 'Y' }">checked</c:if> />
                    </td>
                    <td style="text-align:center;">
                    	<input type="checkbox" name="authR" id="authR" <c:if test="${ listVO.authRC eq 'Y' }">checked</c:if> />
					</td>
                    <td style="text-align:center;">
                    	<input type="checkbox" name="authU" id="authU" <c:if test="${ listVO.authUC eq 'Y' }">checked</c:if> />
                    </td>                    
                    <td style="text-align:center;">
                    	<input type="checkbox" name="authD" id="authD" <c:if test="${ listVO.authDC eq 'Y' }">checked</c:if> />
                    </td>                    
                </tr>  
                </c:forEach>
                <op:no-data obj="${pager.list}" colspan="5" />        
            </tbody>            
        </table>
        <!-- 페이징 -->
    	<op:pager pager="${pager}" />
    	<!-- //페이징 -->
        </fieldset>
         	<p class="tx_c mar_t20">	         	 
	         	<a href="#"><button class="blue" type="button" id="butSave">저장</button></a> 
	         	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
			</p>        
    </div>
    <!-- //컨텐츠영역 -->
</form>            
</body>
</html>