<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!doctype html>
<html lang="ko">
	<head>
  		<meta charset="UTF-8" />
  		<title>POPUP - 전문가 선택</title>
  		<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
  		<script type="text/javascript" src="${contextPath}/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  
  		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
  		<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
  		<script type="text/javascript">   
	  	var jsCancel = function() {
	      	parent.$.fn.colorbox.close();
	  	}
  
		var jsDspy = function() {
			var indexs = new Array();
	      	var ctgryUserNms = "";
	      	var ctgryUserIds = "";
	      	
	     	$("input[name=index]:checked").each(function (i) {
	     	    indexs[i] = $(this).val();
			  	if(i > 0){
			  		ctgryUserNms += ", " + $("#cmpnyUser" + $(this).val()).val();
			  		ctgryUserIds += "," + $("#userId" + $(this).val()).val();
			  	} else {
			  	  	ctgryUserNms += $("#cmpnyUser" + $(this).val()).val();
				  	ctgryUserIds += $("#userId" + $(this).val()).val();
			  	}
	      	});
			
	     	if(indexs.length == 0){
				alert("한명 이상의 전문상담가를 선택하세요.");          
          		return false;
			} else if(indexs.length > 5 ){
          		alert("전문가 선택은 최대 5개 기업 까지 가능합니다.");          
          		return false;		    
			} else {
          		if(confirm( indexs.length + "명의 전문상담가를 선택 하시겠습니까?")){
          		  	parent.$("#viewCtgryUserNms").text(ctgryUserNms);
          		    parent.$("#estnColumn2").val(ctgryUserNms); 
              		parent.$("#estnColumn1").val(ctgryUserIds); 
              		//parent.jsCtgryUserSel(); 
              		parent.$.fn.colorbox.close();    
          		}
     	 	}
  		};
 </script >   
 </head>

 <body class="winPopup selPro">
 	<h2>전문가 선택 <a href="#" onclick="jsCancel();">닫기</a></h2>
	<div>
		<ul class="notice">
			<li>※ 선택하신 카테고리에 해당하는 전문가(제공자)중 상담을 원하는 1개 이상 5개 이하 기업을 선택해 주세요.</li>
		</ul>
		
		<table class="tbl_st3">
			<thead>
				<tr>
					<th>전문가(제공자)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
		                <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">				
		                	<label>
			                  	<input type="checkbox" name="index" id="index" value="${status.index}" />
								<input type="hidden" name="cmpnyUser" id="cmpnyUser${status.index}" value="${_dataVo.langStoreNm} (${_dataVo.userNm})"/>
								<input type="hidden" name="userId" id="userId${status.index}" value="${_dataVo.userId}"/>					
								${_dataVo.langStoreNm} (${_dataVo.userNm})
							</label> 	
						</c:forEach>
					</td>
				</tr>
			</tbody>			
		</table>

		<div class="btnArea cen">
			<a href="javascript:;" class="btns st2" onclick="jsCancel();">취소</a>
			<a href="javascript:;" class="btns st1" onclick="jsDspy(this);">등록</a>
		</div> 
	</div>

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  
  
 </body>
</html>