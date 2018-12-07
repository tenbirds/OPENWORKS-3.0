<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>코드 선택</title>
	<%-- <op:jsTag type="openworks" items="web-core"/> --%>
    
    <script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/component/javascript/MD_globalConfig.do"></script>
    
    <script type="text/javascript" src="${contextPath}/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="${contextPath}/component/javascript/MD_massageConfig.do"></script>
    <op:jsTag type="spi" items="form,validate,extjs" />
    
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" /> 
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    
    <script type="text/javascript">    

        var jsSelect = function() 
        {
            var cDetailSvc = "" ;
            var cDetailSvcNm = "" ;
            var i = 0 ;
            
            
            $("input[type=checkbox]:checked").each(function(i) 
            {
                if (i==0) {
                    cDetailSvc   = cDetailSvc + this.value;
                    cDetailSvcNm = cDetailSvcNm + $("#ctgrynm"+this.value).text();
                } else {
                	cDetailSvc   = cDetailSvc + "," + this.value;
                    cDetailSvcNm = cDetailSvcNm + ", " + $("#ctgrynm"+this.value).text();
                }                
            });
            
            parent.$("#cDetailSvc").val(cDetailSvc);
            parent.$("#cDetailSvcNm").text(cDetailSvcNm);
            
            parent.$.fn.colorbox.close();
        };
        
        var jsCancel = function() {
            parent.$.fn.colorbox.close();
        }
        
        $(document).ready(function() {
            var height = $("#pop_wrap").height() + 70;
            var width = $("#pop_wrap").width() + 70;
            parent.$.fn.colorbox.resize({height:height+"px", width:width+"px"});
            
                $("#goodsLicenceCd" +parent.$("#goodsLicenceCd").val()).attr("checked","true");
                $("#goodsLicenceCn" +parent.$("#goodsLicenceCd").val()).val(parent.$("#goodsLicenceCn").val());
                $("input[name=goodsLicenceCd]").click( function() {
                    $("input[name=goodsLicenceCn]").val('');
                });
        });
      //]]>
</script>
</head>
<body class="winPopup qna">

	<h2>
		서비스 카테고리
    	<a href="#"  onclick="jsCancel();">닫기</a>
    </h2>
    
	<!-- 팝업 윈도우 크기 width:778px  -->
    <div id="pop_wrap">
    
            <!-- popup content -->
            <div class="section" style="margin: 0 auto;display: table;">
            	<br/><br/>
                <p class="guide_txt" style="padding: 5px;"></p>
                <fieldset>
                <legend><span>서비스 카테고리</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    
                    <c:choose>
	                  	<c:when test="${status.last and status.index % 3 lt 2}">
	                  		<td style="padding:5px;">
		                    	<label class="short_txt">
			                    	<input name="ctgry" id="ctgry${_dataVo.ctgryCode}" type="checkbox" value="${_dataVo.ctgryCode }"/> 
			                    	<span id="ctgrynm${_dataVo.ctgryCode}">${_dataVo.langCtgryNm}</span>
		                    	</label>
		                    </td>
	                  		<c:forEach var="i" begin="0" end="${status.index % 8}" step="1">
	                  			<td>&nbsp;</td>			                  			
	                  		</c:forEach>
	                  		</tr>
	                  	</c:when>
	                  	<c:when test="${status.index % 3 eq 0}">
	                      	<tr>
	                      	<td style="padding:5px;">
	                  			<label class="short_txt">
			                    	<input name="ctgry" id="ctgry${_dataVo.ctgryCode}" type="checkbox" value="${_dataVo.ctgryCode }"/> 
			                    	<span id="ctgrynm${_dataVo.ctgryCode}">${_dataVo.langCtgryNm}</span>
		                    	</label>
	                  	</c:when>                  
	                  	<c:when test="${status.index % 3 gt 0 and status.index % 3 lt 2 }">
	        				<td style="padding:5px;">
	                  			<label class="short_txt">
			                    	<input name="ctgry" id="ctgry${_dataVo.ctgryCode}" type="checkbox" value="${_dataVo.ctgryCode }"/> 
			                    	<span id="ctgrynm${_dataVo.ctgryCode}">${_dataVo.langCtgryNm}</span>
		                    	</label>
	    				</c:when>
	                  	<c:when test="${status.index % 3 eq 2}">
	                  		<td style="padding:5px;">
	                  			<label class="short_txt">
			                    	<input name="ctgry" id="ctgry${_dataVo.ctgryCode}" type="checkbox" value="${_dataVo.ctgryCode }"/> 
			                    	<span id="ctgrynm${_dataVo.ctgryCode}">${_dataVo.langCtgryNm}</span>
		                    	</label>
	                      	</tr>
	                  	</c:when>                                  
	              	</c:choose>
                    
                    </c:forEach>
                    
                </tbody>
                </table>
                </fieldset>
                
                <div class="sub_cate">
                </div>

                <div class="btn_area">
                    <div class="btn_pop_c">                     
                        <div class="btn_navi">
                            <a style="padding: 6px 20px 12px 10px;" href="#reg" onclick="jsSelect();"><span class="gt" style="color:white;">등록</span></a>                            
                        </div>
                        <div class="btn_navi_g">
                            <a href="#cancel" onclick="jsCancel();"><span class="cancel">취소</span></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //popup content -->
    </div>
</body>
</html>
