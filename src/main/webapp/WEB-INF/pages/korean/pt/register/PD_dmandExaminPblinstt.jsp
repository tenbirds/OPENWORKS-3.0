<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>기관검색</title>
	<script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>
	<script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
	<script type="text/javascript" src="/resources/web/theme/common/js/html5shiv.js"></script>

    <link href="/new_cloud/css/main_ver2.css" rel="stylesheet" type="text/css" />
    <link href="/new_cloud/css/sub_ver2.css" rel="stylesheet" type="text/css" />
    <link href="/new_cloud/css/popup_ver2.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
    $().ready(function() {
        //$("#pblinsttNm").focus();
        //jsSetSearchEnterEvent();
        //jsToggleBtn();
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

    var returnValue = function(pCd, pNm){
        
        if(pCd == '1000'){
            parent.$("#pblinsttCd").val(pCd);
            parent.$("#pblinsttNm").val("");
            parent.$("#pblinsttNm").attr("readonly",false);
            parent.$("#pblinsttNm").focus();
        } else {
            parent.$("#pblinsttCd").val(pCd);
            parent.$("#pblinsttNm").val(pNm);
            parent.$("#pblinsttNm").attr("readonly",true);
            parent.$("#bizrno1").focus();
        }
        
        parent.$.fn.colorbox.close();
    };
    
    var jsSearch = function(){
        dataForm.submit();
    };
    </script>
</head>

<body>
<div class="popup L">
    <ul class="popup_title">
        <li class="icon_popupt"><img src="/new_cloud/images/sub/icon_popupt.gif" width="50" height="43"></li>
        <li>기관명 검색</li>
        <li class="btn_close"><a href="javascript:;" onclick="javascript:parent.$.fn.colorbox.close();"><img src="/new_cloud/images/sub/btn_close.gif" width="43" height="43"></a></li>
    </ul>
    <div class="popupsub">
	    <form name="dataForm" id="dataForm" method="get" action="PD_dmandExaminPblinstt.do">
	    	<ul class="searcharea">
	        	<li>
	        	<span class="sel_box">
	            	<select class="width125 mr7" id="pblinsttType" name="pblinsttType" onchange="jsSearch();">
	            		<option value="">기관유형</option>
		            	<c:forEach items="${pblinsttTypeList}" var="pblinsttTypeList">
			            	<option value="${pblinsttTypeList.pblinsttType}" <c:if test="${pblinsttTypeList.pblinsttType == baseVo.pblinsttType}">selected="selected"</c:if>>${pblinsttTypeList.pblinsttType}</option>
						</c:forEach>
	                </select>
	                </span>
	            </li>
	            <li>
	            <span class="sel_box">
	            	<select class="width125 mr7" id="upperPblinsttNm" name="upperPblinsttNm">
	            		<option value="">상위기관</option>
	                	<c:forEach items="${upperPblinsttList}" var="upperPblinsttList">
			            	<option value="${upperPblinsttList.upperPblinsttNm}" <c:if test="${upperPblinsttList.upperPblinsttNm == baseVo.upperPblinsttNm}">selected="selected"</c:if>>${upperPblinsttList.upperPblinsttNm}</option>
						</c:forEach>
	                </select> 
	                </span>           
	            </li>
	            <li><input class="width294 mr6" name="pblinsttNm" id="pblinsttNm" type="text" placeholder="기관명 입력" value="${baseVo.pblinsttNm}"></li>
	            <li><a href="javascript:;" onclick="jsSearch();"><img src="/new_cloud/images/sub/btn_psearch.gif" width="72" height="31"></a></li>
	        </ul>
	    </form>
      	<p class="tacenter mt10">목록에 없는 <b>공공기관과 민간기업은 <span>‘기타'</span></b>를 선택하여 직접 입력하세요.</p>
        <div class="result_chart">
			<p class="res_title mt30"><span><img src="/new_cloud/images/sub/icon_psearch.gif" width="41" height="39"></span>검색결과</p>
        	<div class="chart mt20">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="popup_table">
                	<caption class="hidden">board</caption>
                    <colgroup>
                    	<col width="172px;" >
                        <col width="292px;">
                        <col width="155px;">
                	</colgroup>
                    <thead> 
                    	<tr>
                        	<th>기관유형</th>
                            <th>상위기관명</th>
                            <th>기관명</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                        	<td colspan="3" class="scroll_y">
                            	<div class="resultBox" style="height:170px;">
                                	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <caption></caption>
                                        <colgroup>
                                            <col width="172px;" >
                                            <col width="292px;">
                                            <col width="155px;">
                                        </colgroup>
										<tbody> 
                                        	<c:forEach items="${pblinsttList}" var="pblinsttList">
                                        		<tr onclick="returnValue('${pblinsttList.pblinsttCd}','${pblinsttList.pblinsttNm}');" style="cursor:pointer;">                                   
	                                                <td>${pblinsttList.pblinsttType}</td>
	                                                <td>${pblinsttList.upperPblinsttNm}</td>
	                                                <td>${pblinsttList.pblinsttNm}</td>
	                                            </tr>
											</c:forEach>
                                    	</tbody>
                                	</table>
                            	</div>         
                        	</td>      
                        </tr>
						<tr>
                          	<td colspan="3">
                           		<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                	<caption></caption>
                                    <colgroup>
                                    	<col width="172px;" >
                                        <col width="292px;">
                                        <col width="155px;">
                                    </colgroup>
                                    <tbody> 
	                                    <tr onclick="returnValue('1000','');" style="cursor:pointer;">                                   
	                                    	<td>기타</td>
	                                        <td>기타</td>
	                                    	<td>직접입력</td>
	                                    </tr>
                            		</tbody>
								</table>         
                        	</td>      
                    	</tr>                                                                            
                	</tbody>
            	</table>
        	</div>            
    	</div>
	</div>
</div>
</body>
</html>


