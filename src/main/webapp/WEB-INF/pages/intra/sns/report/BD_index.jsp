<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
Calendar cal = Calendar.getInstance();
int nowYear = 0;
nowYear = cal.get(Calendar.YEAR);
int year = nowYear;
%>


<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>현황관리</title>
<op:jsTag type="spi" items="validate,ui,form,highlight" />
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->

<script type="text/javascript">
    //<![CDATA[
    $().ready(function() {
        
        $.datepicker.setDefaults({
            dateFormat : 'yy-mm-dd'
        });

        $('#q_startDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

        $("span#schedulePeriod button.gray").click(function() {
            var sType = $(this).attr('id');
            var searchStart = null;
            var searchEndDt = null;

            switch(sType) {
            case '0':
                searchStart = new Date();
                $('#q_startDt').val(getDateStr(searchStart));
                searchEndDt = new Date();
                break;
            case '7D':
                if($("#q_startDt").val() == getDateStr(new Date()) || $("#q_startDt").val() == "") {
                    searchEndDt = getCalDate(new Date(), 0, 7);
                } else {
                    searchEndDt = getCaldate2($("#q_startDt").val(), 0, 7);
                }
                break;
            case '30D':
                if($("#q_startDt").val() == getDateStr(new Date()) || $("#q_startDt").val() == "") {
                    searchEndDt = getCalDate(new Date(), 1, 0);
                } else {
                    searchEndDt = getCaldate2($("#q_startDt").val(), 1, 0);
                }
                break;
            default:
                break;
            }

            if($('#q_startDt').val() == '') {
                $('#q_startDt').val(getDateStr(new Date()));
            }

            $('#q_endDt').val(getDateStr(searchEndDt));
        });
        
        
        //도메인변경시 메뉴변경함
        $("#q_searchDomain").change(function() {
            
          
            $.ajax({
                url     : "ND_menu.do",            
                type    : "POST",
                data    : { q_searchDomain : $(this).val() },
                async   : false,
                success : function(data) {
                    	
                   	var changeSel = "";
                   	
                   	$.each(data, function(idx, val){
             
                   		changeSel += '<option value="';                   		                   		
                   		
                   		if(val.q_searchMenuCD == null )
                   		{
                   		    changeSel += '"';
                   		    changeSel += 'selected="selected"';
                   		}
                   		else
               		    {
                   		 	changeSel += val.q_searchMenuCD+'" ';
               		    }                   		
                   		
                   		changeSel += ' >';
                   	    changeSel += val.q_searchMenuNM;
   	  	                changeSel += " </option>";              	    
     	               	    
   	               	});
                   	
	               $("#q_searchMenuCD").html(changeSel);
                }
            }); 
        });
        
        
    });
    
    
    var getDateStr = function(date) {
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };
    
    var set2Str = function(vl) {
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };
    
    
    //달력1
    var getCalDate = function(date, months, days) {
        var newDate = date;
        if(typeof (date.getDate) != 'function') {
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;
    };
    
    //달력2
    var getCaldate2 = function(date, months, days) {
        if(date.length == 8) {
            var a = date;
            var date2 = a.substring(0, 4) + '-' + a.substring(4, 6) + '-' + a.substring(6, 8);

            var newDate = new XDate(date2);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        } else {
            var newDate = new XDate(date);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        }
    };
    
 

    //검색
    var jsSearch = function() {
    
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
	
  

    //선택삭제
    var jsDeleteChoose = function() {
        
        var cnt = $('input.chk_seq:checked').length;        
		
        if(cnt == 0) {            
            jsWarningBox("삭제할 댓글을 선택해 주세요");
            return;
        }        
      
        var arr = new Array(cnt);

        $('input.chk_seq:checked').each(function(i) {
            arr[i] = $(this).val();            
        });
        
        $.ajax({
            url : "ND_snsReportDelUpdate.do",
            type : "POST",
            data : {
                delParam : JSON.stringify(arr),
                type     : 'A'
            },
            async : false,
            success : function(response) {
               
                if(jsMessage(response)) {
                    document.dataForm.action = "BD_index.do";
                    document.dataForm.submit();
                }
               
            }
        });

    };    
    
    
	//댓글의 메뉴창
	var jsViewMenu = function(el, menuNm, menuUrl){
	    
	    //alert("http://www.zesinc.co.kr/"+menuUrl);
	    
		$(el).colorbox({
			title : menuNm,
			href  : menuUrl,
// 			href  : "http://www.zesinc.co.kr"+menuUrl,
			width : "100%", height:"100%",
			iframe: true
		});
	};
    
    
    var jsMovePage = function(page) {
        var p = 1;
        if(page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action = "BD_index.do";
        document.dataForm.submit();
    };
	
      
   

       

    //]]>
</script>
</head>
<body>
	<div id="contents">
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
		
		 <input type="hidden" id="q_searchDel_yn" name="q_searchDel_yn" value="N" />
			
			<!-- 검색 -->
			<div class="search">
				<fieldset>
				
					<label class='tx_b'>
			            도메인 : 
			        </label>
			        <select id='q_searchDomain' name='q_searchDomain' class='over mar_r20'>
			            <option value='1' <c:if test="${param.q_searchDomain eq '1'}">selected='selected'</c:if>>localhost</option>
			            <option value='2' <c:if test="${param.q_searchDomain eq '2'}">selected='selected'</c:if>>127.0.0.1</option>
			            <option value='3' <c:if test="${param.q_searchDomain eq '3'}">selected='selected'</c:if>>local.openworks.co.kr</option>
			        </select>
			        
			        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			         
			        <label class='tx_b'>
			            메뉴 : 
			        </label>        
			        <select name="q_searchMenuCD" id="q_searchMenuCD" class="mar_r20">
				      <c:forEach items="${MenuList}" var="codeList">
				           <option value="${codeList.q_searchMenuCD}" <c:if test="${param.q_searchMenuCD eq codeList.q_searchMenuCD}">selected="selected" </c:if>> 
				           		${codeList.q_searchMenuNM}
				           </option>
				      </c:forEach> 
				  	</select>       
				  	 
				  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
				  	
<!-- 				  	<label class='tx_b'> -->
<!-- 			            삭제여부 :  -->
<!-- 			        </label> -->
<!-- 			        <select id='q_searchDel_yn' name='q_searchDel_yn' class='over mar_r20'> -->
<%-- 			            <option value=''    <c:if test="${param.q_searchDel_yn eq ''}">selected='selected'</c:if>>전체</option>			         --%>
<%-- 			            <option value='N'   <c:if test="${param.q_searchDel_yn eq 'N'}">selected='selected'</c:if>>삭제안됨</option> --%>
<%-- 			            <option value='A'   <c:if test="${param.q_searchDel_yn eq 'A'}">selected='selected'</c:if>>관리자삭제</option> --%>
<%-- 			            <option value='Y'   <c:if test="${param.q_searchDel_yn eq 'Y'}">selected='selected'</c:if>>사용자삭제</option> --%>
<!-- 			        </select>  -->
				         
<!-- 				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	 -->
				         
				    <label class='tx_b'>
			            신고여부 : 
			        </label>
			        <select id='q_searchReport_yn' name='q_searchReport_yn' class='over mar_r20'>
			            <option value=''    <c:if test="${param.q_searchReport_yn eq ''}">selected='selected'</c:if>>전체</option>
			            <option value='Y'   <c:if test="${param.q_searchReport_yn eq 'Y'}">selected='selected'</c:if>>예</option>
			            <option value='N'   <c:if test="${param.q_searchReport_yn eq 'N'}">selected='selected'</c:if>>아니오</option>
			        </select> 
				         
				  
				         
			        <br /><br />
			        
			        <label class='tx_b'>검색일자 :</label>
			        <input class="w120" type="text" value="${param.q_startDt }" name="q_startDt" id="q_startDt" title="날짜선택" /> ~ 
			        <input class="w120" type="text" value="${param.q_endDt }"   name="q_endDt"   id="q_endDt"   title="날짜선택" />

					<span class="mar_l10" id="schedulePeriod">
						<button class="gray mar_l5 mar_b5" type="button" id="0">일일</button>
						<button class="gray mar_l5 mar_b5" type="button" id="7D">주간</button>
						<button class="gray mar_l5 mar_b5" type="button" id="30D">월간</button>
					</span> 					
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
					<legend>검색하세요.</legend>
					<select id="q_searchKey" name="q_searchKey" value="${param.q_searchKey }" class="over">
						<option
							<c:if test="${param.q_searchKey eq  'search_tit'}">    selected="selected" </c:if>
							value="search_tit">선택하세요.</option>
						<option
							<c:if test="${param.q_searchKey eq  'search_nm'}">    selected="selected" </c:if>
							value="search_nm">덧글내용</option>
						<option
							<c:if test="${param.q_searchKey eq  'search_writer'}"> selected="selected" </c:if>
							value="search_writer">등록자</option>
					</select>
					<input class="w215" type="text" value="${param.q_searchVal }" name="q_searchVal" id="q_searchVal" title="검색어를 입력하세요." />
 					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<button class="s_blue mar_l5 mar_b5" onclick="jsSearch();">검색</button>					
					<button class="s_blue mar_l5 mar_b5" type="button"	onclick="jsDeleteChoose();">선택 삭제</button>

				</fieldset>
			</div>
			<!-- //검색 -->		
			
			<!-- 탭 -->
			<ul class="tab">
				<li><a href="BD_index.do"   class="on" /> 댓글목록</a></li>
			    <li><a href="BD_delList.do"            /> 삭제목록</a></li>			    		    
			</ul>
			<!-- //탭 -->		
		
			<!-- 페이지당 목록선택-->
			<op:pagerParam title="댓글 목록" />
		</form>


		<!-- 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
			<caption class="hidden">목록</caption>
			<colgroup>
				<col width="3%">
				<col width="10%">
				<col width="">	
				<col width="5%">		
				<col width="7%">
				<col width="7%">
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>메뉴명</th>
					<th>댓글내용</th>				
<!-- 					<th>삭제여부</th> -->
					<th>신고여부</th>
					<th>등록자</th>
					<th class="lr_none">등록일</th>
				</tr>
			</thead>
			<tbody>
				
				<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
					 <tr class=<c:choose>
						         <c:when test="${baseVo.report_yn == 'Y' }">'bg_light_red'</c:when>
						         <c:otherwise> 
						         	<c:if test='${(status.count mod 2) eq 0 }'>'bg_yellow'</c:if>
						         </c:otherwise>
								</c:choose> >
						<td><input type="checkbox" name="chk_seq" id="chk_seq" class="chk_seq" value="${baseVo.domain_cd},${baseVo.menu_code},${baseVo.page_url},${baseVo.seq}" /></td>
						
						<td>
							<a  href="#"  onclick="jsViewMenu(this,'${baseVo.menu_nm}', '${baseVo.page_url}');" >
								${baseVo.menu_nm}
							</a>
						</td>
						<td class="tx_l">	${baseVo.contents }</td>
<!-- 						<td> -->
<%-- 							<c:choose> --%>
<%-- 						         <c:when test="${baseVo.del_yn == 'A' }">관리자삭제</c:when> --%>
<%-- 						         <c:when test="${baseVo.del_yn == 'Y' }">사용자삭제</c:when> --%>
<%-- 						         <c:otherwise>삭제안됨</c:otherwise> --%>
<%-- 					        </c:choose>   --%>
<!-- 				        </td>						 -->
						<td>
							<c:choose>
						         <c:when test="${baseVo.report_yn == 'Y' }">예</c:when>
						         <c:when test="${baseVo.report_yn == 'N' }">아니오</c:when>
						         <c:otherwise>삭제안됨</c:otherwise>
					        </c:choose>  
						</td>
						<td>${baseVo.reg_id}</td>
						<td class="lr_none">${baseVo.reg_dt}</td>
					</tr>					
				</c:forEach>
				
				<c:if test="${empty pager.list}">
				 <tr>
              		  <td colspan="6">데이터가 존재하지 않습니다.</td>
           		 </tr>
				</c:if>
				
			</tbody>
		</table>
		<!-- //리스트 -->
		
		<!-- 페이징 --> 
		<op:pager pager="${pager}" />
		<!-- //페이징 -->
				
	</div>
	<!-- //컨텐츠영역 -->
</body>
</html>