<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%  response.setHeader("Cache-control","no-cache"); %>
<!DOCTYPE html>
<html>
<head>
	<title>수요예보조사</title>
	<op:jsTag type="openworks" items="ui" />
	<op:jsTag type="spi" items="form,validate" />
	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">	
		$(document).ready(function(){
		});
		var thisEl = false;
		// 수요예보조사 참여 클릭
		var jsDmandExaminChkAction = function(vl){

			
			if(vl == 1){			
				alert("회원님은 클라우드컴퓨팅 수요예보조사를 완료하였습니다.");
			}
			
		    var url = "ND_dmandExaminChkAction.do";
			$("#dataForm").ajaxSubmit({
				url		: url,
				type	: "GET",
				cache   : false,
				async	: false,
				success	: function (result) {
				    if(result == 1001){
				        jsDmandExaminPop();
					    return false;
					}else if(result == 1002){
					    jsInfoUpdtRequstPop();
						return false;
					}else if(result == 1003){
					    jsPstinstInfoCnfirmPop();
					    return false;
					}else if(result == 9999){
					    alert(Message.msg.noSession);
					    top.location.href = "/korean/pt/login/user/BD_index.do?returnUrl=/korean/pt/register/BD_dmandExamin.do";
					    return false;
					}else{
					    alert('수요예보조사자 정보 검색 오류:\r\n담당자에게 문의하시기바랍니다.');
					    return false;
					}	
				},
				error : function(result) {
					alert(result.statusText+":"+result.status+":"+result.responseText); 
	            }
			});
		};
		
		//회원정보수정요청
		var jsInfoUpdtRequstPop = function(){
		    $.colorbox({
	            title : "회원정보수정요청",
	            href : "PD_infoUpdtRequst.do",
	            width : 400,
	            height : 180,
	            overlayClose : false,
	            escKey : false,
	            iframe : true,
	            fixed : true
	        });
		};
		
		//소속기관정보확인
		var jsPstinstInfoCnfirmPop = function(){
		    $.colorbox({
	            title : "회원의 소속기관 정보 확인",
	            href : "PD_pstinstInfoCnfirm.do",
	            width : 800,
	            height : 350,
	            overlayClose : false,
	            escKey : false,
	            iframe : true,
	            fixed : true,
	            onClosed : function(){
	                if(thisEl == true){
	                    thisEl = false;
	                    jsDmandExaminChkAction();
	                }
	            }
	        });
		};
		
		//수요예보조사 참여 팝업
		var jsDmandExaminPop = function(){
		    $.colorbox({
	            title : "수요예보조사",
	            href : "PD_searchDmandExaminGridPop.do",
	            width : window.innerWidth-20,
	            height : window.innerHeight,
	            overlayClose : false,
	            escKey : false,
	            iframe : true,
	            scrolling : false,
	            fixed : true,
	            reposition : true
	            
	        });
		};
		
		//회원정보수정페이지 이동(+popup close)
		var jsInfoUpdt = function(){
		    $.colorbox.close();
		    top.location.href = "/korean/pt/register/BD_password.do";	
		};
		
		
		$(window).resize(function(){
		    if($("#cboxTitle").text() == '수요예보조사'){
			    $.colorbox.resize({
			        width: window.innerWidth-20,
			        height: window.innerHeight
			    });
		    }
		});
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>
	<div class="join_info">
		<form name="dataForm" id="dataForm">
			<h4>개요</h4>
			<div class="intro law">
				<ul style="margin-bottom:10px;">
	        <li><b>기간 : 2018년 10월 17일(수) ~ 2018년 10월 31일(수)</b></li>
	        <li><b>대상 : 중앙행정기관, 지방자치단체, 공공기관 등 1,140여 개</b></li>
	        <li><b>내용 : ’19년도 클라우드컴퓨팅사업의 수요예보 정보</b><br /></li>
				  <!-- <span style="margin-left:46px; font-size:14px"><b>- 기관 시스템 내역, 클라우드 전환 또는 도입예정(클라우드 유형, 예산) 등의 자료 수집</b></span><br/> -->
				  <!-- <span style="margin-left:46px; font-size:14px"><b>- 기본양식(excel) 및 '씨앗' 웹을 통하여 수요예보조사 참여</b></span><br/> -->
				  <!-- <span style="margin-left:46px; font-size:14px"><b>※ EA 관리시스템의 정보를 디폴트로 제공하고 수정/변경/삭제/추가를 허용하여 대상기관 수요조사 작성자의 편의성 도모</b></span>  -->
				  <!-- <span style="margin-left:46px; font-size:14px"><b>※ EA시스템 등록되어 있는 경우 EA정보를 기본으로 제공</b></span> -->
          <li><b>방법 : 온라인 직접입력 또는 엑셀 업로드</b> </li>
          <!-- <li><b>방법 : 클라우드스토어 '씨앗'홈페이지(<a href="http://www.ceart.kr" target="_blank">https://www.ceart.kr</a>)를 통한 온라인(on-line) 조사</b> </li> -->
        </ul>
      	<br/>
        <div style="text-align:left; margin:0 0 30px 50px;">
            <a href="javascript:self.location.href='/component/file/ND_directDownload.do?fp=/upload/contents/2019YearGuide.pdf&fn=' + encodeURIComponent('2019년_수요예보조사_가이드.pdf');" class="btns st6"><img src="/new_cloud/images/sub/icon_guide.png" width="13" height="14" style="margin-right:7px;" alt="수요예보조사 작성메뉴얼"/>수요예보조사 작성메뉴얼</a>
        </div>
		  </div>

			<h4>권장 브라우저</h4>
			<div class="intro law">
				<ul>
        	<li><b>IE 10.0 이상, Google Chrome</b>이며 하위버전을 사용할 시 이용에 어려움이 있을 수 있으므로 확인 후 참여하시기 바랍니다.</li>
        </ul>
			</div>
			<h4>문의</h4>
			<div class="intro law">
        <ul>
        	<li><b>한국정보화진흥원 공공클라우드지원센터 1522-0089</b></li>
        </ul>
			</div>
            
			<div style="text-align:center; margin-top:20px;">
				<a href="javascript:;" class="btns st4" style="width:145px;" id="dmandExaminPopBtn" onclick="jsDmandExaminChkAction(${targetSubmitChkCnt});"><img src="/new_cloud/images/sub/icon_participate.png" style="margin-right:7px;" alt="수요예보조사 참여"/>수요예보조사 참여</a>
			</div>
		</form>
  </div>
</body>
</html>