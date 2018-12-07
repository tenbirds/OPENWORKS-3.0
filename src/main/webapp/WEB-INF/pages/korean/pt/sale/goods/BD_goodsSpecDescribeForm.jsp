<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>수요정보조사</title>
    <op:jsTag type="openworks" items="ui" />
    <op:jsTag type="spi" items="form,validate" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />

    <script type="text/javascript">
        $(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");});});
    </script>
    
    <style>
		.goodsDescribePage { margin-top: 20px; }
	</style>
    
    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">
    
        function explode()
        {           
            $('#goodsDescribePage2').hide();
            $('#goodsDescribePage3').hide();
            $('#goodsDescribePage4').hide();
            $('#goodsDescribePage5').hide();
            
            $('#goodsDescribePageIaas').hide();
            $('#goodsDescribePagePaas').hide();
            $('#goodsDescribePageSaas').hide();
        }   
        
        
        $(document).ready(function(){
            $("#loading-container").hide();
        //  jsSelectDetailList($("#userId").val());
            setTimeout(explode, 500);
            
        });
        var jsLoading = function(){
            $("#loading-container").show();
            return true;
        };
        
        // 입력값 체크
        var checkFormValue = function(){
            
            //수요조사 엑셀 파일
            /*
            if(($("input[name=dmandExaminFile1]").val() == null || $("input[name=dmandExaminFile1]").val() == "")  && $("input[name=dmandExaminFileVal1]").val() == "")
            {
                alert("서비스 규격서 엑셀파일 등록해주세요.");
                document.getElementById("dmandExaminFileBtn").focus();
                return false;
            }
            */
            
            return true;
        };
        
        // '규격서 업로드'버튼 클릭
        var jsUploadAction = function() {
            /*
            if(checkFormValue()){
                if(confirm("저장 하시겠습니까?")){
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });
            */      
                    $("#dummyForm").ajaxSubmit({
                        url     : "DummyGet.do",
                        type    : "POST",
                        async   : false,
                        success : function (response) {
                            if(response == "true"){
                                $("#loading-container").show();
                                $("#dataForm").attr("action", "BD_goodsSpecSaveAction.do");
                                $("#dataForm").submit();
                            }
                        }
                    });
            /*
                }else{
                    
                }
            }else{
                
            }
            */
        };
        
        // '규격서 저장'버튼 클릭
        var jsSaveAction = function() {
            
            if (checkFormValue())
            {
                $("#dummyForm").ajaxSubmit({
                    url     : "DummyGet.do",
                    type    : "POST",
                    async   : false,
                    success : function (response) 
			                  {
			                      if(response == "true"){
			                            $("#loading-container").show();
			                            $("#dataForm").attr("action", "BD_goodsSpecDescribeSaveAction.do");			                                                           
			                            $("#dataForm").submit();
			                      }
			                  }
                });
            }
        };
        
        
        jsViewAction = function(){
            location.href="BD_goodsSpecView.do?goodsCode=${goodsCode}";
        };
        
        var jsGoodsView = function(){
              location.href = "BD_goodsView.do?goodsCode=${goodsCode}&pageUrlNm=";
          };
        
        //파일종류 및 용량 체크
        var jsFileChk = function(inputId, inputIdFake, s, fileExt, fileSeq, maxCnt){
            document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
            
            var inputFile = document.getElementById(inputId);
            var filePath = inputFile.value;
            
            if(filePath == ""){
                return false;
            }
            
            var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
            var fileExtPermit = "xls,xlsx";
            var htmlVal = "";
            
            if(fileExtPermit.indexOf(fileExt) <= 0){
                alert(fileExt + Message.msg.fileCannotUplaod);
                jsInputFileReset(inputId, inputIdFake);
                return false;
            }
            
            if(inputFile.files[0].size > (s * 1024) && s != 0){
                alert(Message.msg.fileSizeOver);
                jsInputFileReset(inputId, inputIdFake);
                return false;
            }
            
            document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
            
        };
        
        // 첨부파일 삭제 X버튼 클릭
        var jsInputFileReset = function(fileId, textId){
            $("#" + textId).val("");
            var control = $("#" + fileId);
            control.replaceWith( control = control.clone( true ) );
        };
                        
        //첨부된 파일중 ajax를 이용하여 파일 삭제
        var jsFileDelete = function(element, seq, id){
            if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
                return false;
            
            var url = "ND_fileDelete.do";
            $("#dummyForm").ajaxSubmit({
                url     : "DummyGet.do",
                type    : "POST",
                async   : false,
                success : function (response) {
                    if(response == "true"){
                        $.post(url,
                            { fileId : id, fileSeq : seq },
                            function(result){
                                if(result == 1){
                                    $(element).parent().remove();
                                         self.location.reload();
                                }else{
                                    alert('파일을 삭제하지 못했습니다.');
                                }
                            }, 'json');
                    }
                }
            });
        };
        
        
        var goodDescribePage = 1;
        
        var hidegoodsDescribePage = function(page)
        {
            $('div#goodsDescribePage'+page).hide();         
        };
        
        var showgoodsDescribePage = function(page)
        {
            $('div#goodsDescribePage'+page).show();         
        };
        
        var jsGoodsDescribePrev = function()
        {           
            if  (goodDescribePage > 1)
            {
                if  (goodDescribePage == 6)
                {
                    if  ('${goodsKndCd}' == '1001') $('div#goodsDescribePagePaas').hide();  // Pass
                    if  ('${goodsKndCd}' == '1002') $('div#goodsDescribePageSaas').hide();  // Sass
                    if  ('${goodsKndCd}' == '1003') $('div#goodsDescribePageIaas').hide();  // Iass
                }
                else
                {
                    hidegoodsDescribePage(goodDescribePage) ;
                }
                
                goodDescribePage -- ;
                
                showgoodsDescribePage(goodDescribePage) ;
            }
            else
            {
                alert('더이상 이동할 수 없습니다.') ;
            }
        };
        
        var jsGoodsDescribeNext = function()
        {           
            if  (goodDescribePage <= 5)
            {
                hidegoodsDescribePage(goodDescribePage) ;
                
                goodDescribePage ++ ;
                
                if  (goodDescribePage == 6)
                {
                    if  ('${goodsKndCd}' == '1001') $('div#goodsDescribePagePaas').show();  // Pass
                    if  ('${goodsKndCd}' == '1002') $('div#goodsDescribePageSaas').show();  // Sass
                    if  ('${goodsKndCd}' == '1003') $('div#goodsDescribePageIaas').show();  // Iass
                }
                else
                {
                    showgoodsDescribePage(goodDescribePage) ;
                }
            }           
            else
            {
                alert('더이상 이동할 수 없습니다.') ;
            }           
        };
    
    </script>
    <!-- 사용자 스크립트 끝 -->
</head>
<body>

    <div class="supAdm view register">
        <img src="/cloud_ver2/new_cloud/images/srvRgst_step_2.png" alt="서비스 규격서 등록" />
        <h3>서비스 규격서 등록</h3>
                
        <form name="dummyForm" id="dummyForm"></form>
    
    <form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
        <input type="hidden" id="userId" name="userId" value="${dataVo.userId}" />
        <input type="hidden" id="goodsCode" name="goodsCode" value="${goodsCode}" />    
        
                <div class="btnArea rig">
                <a href="#"  onclick="jsGoodsView()" class="f_l btns st2 icn icnBck2">이전</a>        
                <c:if test="${empty specDescribeVo.specExcelFile[0]}">
                    <!-- <a href="#"  onclick="jsUploadAction()" class="btns st1 icn icnPaper">규격서 업로드</a> -->
                    <a href="#"  onclick="jsSaveAction()" class="btns st1 icn icnPaper">규격서 저장</a>
                </c:if> 
                <c:if test="${not empty specDescribeVo.specExcelFile[0]}">
                    <a href="#"  onclick="jsViewAction()" id="nexMove"  class="btns st1 icn_r next">다음</a>
                </c:if>                     
                </div>
                
                

                <div class="goodsDescribePage" id="goodsDescribePage1">               
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td rowspan="6">1. 회사 개요</td><td>회사 명칭</td><td><input type="text" id="cmpnyNm" name="cmpnyNm"/></td></tr>
                        <tr><td>회사 설립년도</td><td><input type="text" id="cmpnyFondYear" name="cmpnyFondYear"/></td></tr>
                        <tr><td>기업 구분 </td>
                            <td><span class="sel_box">
                                    <select id="entrprsSe" name="entrprsSe">
                                        <option value="">선택</option>
                                        <!-- 2075 -->
                                        <c:forEach items="${entrprsSeList}" var="entrprsSe" varStatus="status">
                                            <option value="${entrprsSe.PRVCD}">${entrprsSe.PRVNM}</option>    
                                        </c:forEach>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>회사 소개</td></td><td><input type="text" id="cmpnyIntrcn" name="cmpnyIntrcn"/></td></tr>
                        <tr><td>사업 분야</td><td><input type="text" id="bsnsRealm" name="bsnsRealm"/></td></tr>
                        <tr><td>주요 레퍼런스 (등록 서비스 기준)</td><td><input type="text" id="mainRefer" name="mainRefer"/></td></tr>
                    </tbody>
                    </table>
                </div>
                        
                <div class="goodsDescribePage" id="goodsDescribePage2">        
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td rowspan="18">2. 서비스 개요</td><td>서비스 명칭</td><td><input type="text" id="svcNm" name="svcNm"/></td></tr>
                        <tr><td>서비스 정의 및 특징</td><td><input type="text" id="svcDfnSfe" name="svcDfnSfe"/></td></tr>
                        <tr><td>서비스 기대효과</td><td><input type="text" id="svcExpcEffect" name="svcExpcEffect"/></td></tr>
                        <tr><td>서비스 유형  </td>
                            <td>
                                <span class="sel_box">
                                    <select id="svcTy" name="svcTy">
                                        <option value="">선택</option>
                                        <!-- 2076 -->
                                        <c:forEach items="${svcTyList}" var="svcTy" varStatus="status">
                                            <option value="${svcTy.PRVCD}">${svcTy.PRVNM}</option>    
                                        </c:forEach>
                                    </select>
                                </span> 
                            </td>
                        </tr>
                        <tr><td>서비스 제공 기업의 공급 유형 </td>
                            <td>
                                <span class="sel_box">
                                    <select id="svcEntrprsSuplyTy" name="svcEntrprsSuplyTy">
                                        <option value="">선택</option>
                                        <!-- 2055 -->
                                        <c:forEach items="${svcEntrprsSuplyTyList}" var="svcEntrprsSuplyTy" varStatus="status">
                                            <option value="${svcEntrprsSuplyTy.PRVCD}">${svcEntrprsSuplyTy.PRVNM}</option>    
                                        </c:forEach>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>과금 기준(최소) </td>
                            <td>
                                <span class="sel_box">
                                    <select id="dueStdrMumm" name="dueStdrMumm">
                                        <option value="">선택</option>
                                        <!-- 2077 -->
                                        <c:forEach items="${dueStdrMummList}" var="dueStdrMumm" varStatus="status">
                                            <option value="${dueStdrMumm.PRVCD}">${dueStdrMumm.PRVNM}</option>    
                                        </c:forEach>
                                    </select>
                                </span>
                            </td>                       
                        </tr>
                        <tr><td>서비스 가격</td><td><input type="text" id="svcPc" name="svcPc"/></td></tr>
                        <tr><td>최소 계약기간</td><td><input type="text" id="mummCntrctpd" name="mummCntrctpd"/></td></tr>
                        <tr><td>가격테이블 첨부 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="pcTableAtchAt" name="pcTableAtchAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>VAT포함여부 </td>
                            <td>
                                <span class="sel_box">
                                    <select id="vatInclsAt" name="vatInclsAt">
                                        <option value="">선택</option>
                                        <!-- 2078 -->
                                        <c:forEach items="${vatInclsAtList}" var="vatInclsAt" varStatus="status">
                                            <option value="${vatInclsAt.PRVCD}">${vatInclsAt.PRVNM}</option>    
                                        </c:forEach>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>서비스 시작 절차</td><td><input type="text" id="svcBeginProcss" name="svcBeginProcss"/></td></tr>
                        <tr><td>서비스 종료 절차</td><td><input type="text" id="svcEndProcss" name="svcEndProcss"/></td></tr>
                        <tr><td>서비스 평가판 제공여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="atSvcEvl" name="atSvcEvl">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>서비스 평가판 제공 기간</td><td><input type="text" id="svcEvlSuplyPd" name="svcEvlSuplyPd"/></td></tr>
                        <tr><td>서비스 담당자 이름</td><td><input type="text" id="svcChargerNm" name="svcChargerNm"/></td></tr>
                        <tr><td>서비스 담당자 전화번호</td><td><input type="text" id="svcChargerTelno" name="svcChargerTelno"/></td></tr>
                        <tr><td>서비스 담당자 이메일</td><td><input type="text" id="svcChargerEmail" name="svcChargerEmail"/></td></tr>
                        <tr><td>나라장터종합쇼핑몰 등록 여부</td><td><input type="text" id="gnrlzSopmalRegistAt" name="gnrlzSopmalRegistAt"/></td></tr>
                     </tbody>
                    </table>
                </div>
                        
                <div class="goodsDescribePage" id="goodsDescribePage3">        
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td rowspan="15">3. 서비스 기술 정보</td><td>Private cloud 구축 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="privateCloudAt" name="privateCloudAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>Public cloud 구축 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="publicCloudAt" name="publicCloudAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>Hybrid cloud 구축 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="hybridCloudAt" name="hybridCloudAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>클라우드 보안 인증(KISA) 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="kisaCrtfcAt" name="kisaCrtfcAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>클라우드 서비스 품질 인증 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="cloudSvcQlityCrtfcAt" name="cloudSvcQlityCrtfcAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>클라우드 서비스 확인제 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="cloudSvcCnfirmAt" name="cloudSvcCnfirmAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>CC 인증 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="ccCrtfcAt" name="ccCrtfcAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>GS 인증 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="gsCrtfcAt" name="gsCrtfcAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>SLA 적용 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="slaApplcAt" name="slaApplcAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>서비스 가용성 </td><td><input type="text" id="svcUseful" name="svcUseful"/></td></tr>
                        <tr><td>자동 확장 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="atmcEstnSportAt" name="atmcEstnSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>클러스터링 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="clusteringSportAt" name="clusteringSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>셀프서비스 프로비저닝 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sfsrvProvisioningSportAt" name="sfsrvProvisioningSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>서비스 프로비저닝 시간</td><td><input type="text" id="svcProvisioningTime" name="svcProvisioningTime"/></td></tr>
                        <tr><td>서비스 프로비저닝 해제 시간</td><td><input type="text" id="svcProvisioningRelisTime" name="svcProvisioningRelisTime"/></td></tr>
                     </tbody>
                    </table>
                </div>
                        
                <div class="goodsDescribePage" id="goodsDescribePage4">
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td rowspan="11">4. 서비스 및 데이터 관리 정보</td>
                            <td>데이터센터 국내, 외 위치 정보</td>
                            <td>
                                <span class="sel_box">
                                    <select id="dataCnterHbrdLcInfo" name="dataCnterHbrdLcInfo">
                                        <option value="">선택</option>
                                        <!-- 2079 -->
                                        <c:forEach items="${dataCnterHbrdLcInfoList}" var="dataCnterHbrdLcInfo" varStatus="status">
                                            <option value="${dataCnterHbrdLcInfo.PRVCD}">${dataCnterHbrdLcInfo.PRVNM}</option>    
                                        </c:forEach>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>데이터센터 위치 정보 </td><td><input type="text" id="dataCnterLcInfo" name="dataCnterLcInfo"/></td></tr>
                        <tr><td>재해복구계획 </td><td><input type="text" id="dsstrrecovryPlan" name="dsstrrecovryPlan"/></td></tr>
                        <tr><td>데이터 추출 절차</td><td><input type="text" id="dataExtrcProcss" name="dataExtrcProcss"/></td></tr>
                        <tr><td>미사용 데이터 보호 정책</td><td><input type="text" id="unuseDataPrtcPolicy" name="unuseDataPrtcPolicy"/></td></tr>
                        <tr><td>안전한 데이터 삭제 정책</td><td><input type="text" id="safeDataDeletePolicy" name="safeDataDeletePolicy"/></td></tr>
                        <tr><td>서비스 관리 및 현황 정보 제공 </td>
                            <td>
                                <span class="sel_box">
                                    <select id="svcManageSttusInfoSuply" name="svcManageSttusInfoSuply">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>서비스 이용 로그 제공 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="svcUseLogSuplyAt" name="svcUseLogSuplyAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>                       
                        </tr>
                        <tr><td>장애관리 및 보고 정책</td><td><input type="text" id="troblManageReprtPolicy" name="troblManageReprtPolicy"/></td></tr>
                        <tr><td>API 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="apiSportAt" name="apiSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>API 지원 타입</td><td><input type="text" id="apiSportTy" name="apiSportTy"/></td></tr>
                     </tbody>
                    </table>
                </div>
                        
                <div class="goodsDescribePage" id="goodsDescribePage5">
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td rowspan="10">5. 서비스 지원 정보</td>
                            <td>사용자 매뉴얼 제공 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="userMnlSuplyAt" name="userMnlSuplyAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>사용자 매뉴얼 정보 유무</td>
                            <td>
                                <span class="sel_box">
                                    <select id="userMnlInfoAt" name="userMnlInfoAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>사용자 매뉴얼 정보 입력</td><td><input type="text" id="userMnlInfoInput" name="userMnlInfoInput"/></td></tr>
                        <tr><td>사용자 교육 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="userEdcSportAt" name="userEdcSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>사용자 교육 정보</td><td><input type="text" id="userEdcInfo" name="userEdcInfo"/></td></tr>
                        <tr><td>방문 교육 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="visitEdcSportAt" name="visitEdcSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>방문 기술 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="visitTchnlgySportAt" name="visitTchnlgySportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>방문 외(온라인, 이메일, 전화 등) 기술 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="visitElseTchnlgySportAt" name="visitElseTchnlgySportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>고객센터 운영 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="cstmrCnterOperAt" name="cstmrCnterOperAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>고객센터 운영 시간</td><td><input type="text" id="cstmrCnterOperTime" name="cstmrCnterOperTime"/></td></tr>
                     </tbody>
                    </table>
                </div>

                <div class="goodsDescribePage" id="goodsDescribePageIaas">
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- <tr><td colspan="3">Iaas</td></tr> -->
                        <tr><td>공개표준지원</td><td>공개표준 지원 및 문서</td><td><input type="text" id="iOthbcStdSportDoc" name="iOthbcStdSportDoc"/></td></tr>
                        <tr><td rowspan="2">네트워그와 연결</td><td>서비스에 직접 연결하는 네트워크</td><td><input type="text" id="iSvcDirectCnncNtwrk" name="iSvcDirectCnncNtwrk"/></td></tr>
                        <tr><td>가상 네트워크 지원</td><td><input type="text" id="iVirtlNtwrkSport" name="iVirtlNtwrkSport"/></td></tr>
                        <tr><td rowspan="2">접근지원</td>
                            <td>동기화 지원 여부 </td>
                            <td>
                                <span class="sel_box">
                                    <select id="iSynchrnSportAt" name="iSynchrnSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>지원 장비 목록</td><td><input type="text" id="iSportEqpmnList" name="iSportEqpmnList"/></td></tr>
                        <tr><td rowspan="6">제공 서비스</td><td>서버/컴퓨터 서비스</td><td><input type="text" id="iServerComputerSvc" name="iServerComputerSvc"/></td></tr>
                        <tr><td>스토리지 서비스</td><td><input type="text" id="iStrgeSvc" name="iStrgeSvc"/></td></tr>
                        <tr><td>네트워크 서비스</td><td><input type="text" id="iNtwrkSvc" name="iNtwrkSvc"/></td></tr>
                        <tr><td>보안 서비스</td><td><input type="text" id="iScrtySvc" name="iScrtySvc"/></td></tr>
                        <tr><td>관리 서비스</td><td><input type="text" id="iManageSvc" name="iManageSvc"/></td></tr>
                        <tr><td>기타 서비스</td><td><input type="text" id="iEtcSvc" name="iEtcSvc"/></td></tr>
                     </tbody>
                    </table>
                </div>

                <div class="goodsDescribePage" id="goodsDescribePagePaas">
                
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- <tr><td colspan="3">Paas</td></tr> -->
                        <tr><td rowspan="2">Secure 개발</td><td>Secure 개발</td><td><input type="text" id="pSecureDevlop" name="pSecureDevlop"/></td></tr>
                        <tr><td>Secure design, coding, testing 및 배포</td><td><input type="text" id="pSecureDctWdtb" name="pSecureDctWdtb"/></td></tr>
                        <tr><td rowspan="5">아키텍처 계회 수립</td><td>지원 언어</td><td><input type="text" id="pSportLang" name="pSportLang"/></td></tr>
                        <tr><td>지원 플랫폼</td><td><input type="text" id="pSportPltfom" name="pSportPltfom"/></td></tr>
                        <tr><td>지원 Container 및 버전</td><td><input type="text" id="pSportContainerVer" name="pSportContainerVer"/></td></tr>
                        <tr><td>지원 데이터 저장소</td><td><input type="text" id="pSportDataStorge" name="pSportDataStorge"/></td></tr>
                        <tr><td>Sub-tenancy 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="pSubTenancySportAt" name="pSubTenancySportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td rowspan="4">응용프로그램 개발</td><td>개발자 도구 정보</td><td><input type="text" id="pDvlprUntInfo" name="pDvlprUntInfo"/></td></tr>
                        <tr><td>SDK/API 제공 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="pSdkApiSuplyAt" name="pSdkApiSuplyAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>테스트 및 디버깅 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="pTestDebugingSportAt" name="pTestDebugingSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>Add-on 서비스 및 마켓플레이스 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="pAddonSvcMarkplaceSportAt" name="pAddonSvcMarkplaceSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td rowspan="3">배포 및 운영환경</td><td>CISPORT(Continuous Integration) 지원</td><td><input type="text" id="pCisportSport" name="pCisportSport"/></td></tr>
                        <tr><td>로깅/모니터링 지원</td><td><input type="text" id="pLogingMntrngSport" name="pLogingMntrngSport"/></td></tr>
                        <tr><td>Load Balancing 지원</td><td><input type="text" id="pLoadBalancingSport" name="pLoadBalancingSport"/></td></tr>
                     </tbody>
                    </table>
                </div>

                <div class="goodsDescribePage" id="goodsDescribePageSaas">
                    <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th>세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- <tr><td colspan="3">Saas</td></tr> -->
                        <tr><td rowspan="2">서비스 제공 방식</td><td>사용자용 서비스 제공 방식</td><td><input type="text" id="sUserSvcSuplyMthd" name="sUserSvcSuplyMthd"/></td></tr>
                        <tr><td>관리용 서비스 제공 방식</td><td><input type="text" id="sManageSvcSuplyMthd" name="sManageSvcSuplyMthd"/></td></tr>
                        <tr><td rowspan="5">서비스 보안 관리</td><td>인프라 제공 방식</td><td><input type="text" id="sInfrstrctrSuplyMthd" name="sInfrstrctrSuplyMthd"/></td></tr>
                        <tr><td>보안 정책 </td><td><input type="text" id="sScrtyPolicy" name="sScrtyPolicy"/></td></tr>
                        <tr><td>데이터 암호화 여부 및 방식</td><td><input type="text" id="sDataEncptAtMthd" name="sDataEncptAtMthd"/></td></tr>
                        <tr><td>백업 및 복구 정책</td><td><input type="text" id="sBackupRecovryPolicy" name="sBackupRecovryPolicy"/></td></tr>
                        <tr><td>사용자 인증 및 보안 보호 정책</td><td><input type="text" id="sUserCrtfcScrtyPrtcPolicy" name="sUserCrtfcScrtyPrtcPolicy"/></td></tr>
                        <tr><td rowspan="4">다중 플랫폼<br />(cross platform)</td>
                            <td>다중 플랫폼 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sMultiPltfomSportAt" name="sMultiPltfomSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>지원 운영체계 목록</td><td><input type="text" id="sSportOpersysmList" name="sSportOpersysmList"/></td></tr>
                        <tr><td>지원 웹브라우저 목록</td><td><input type="text" id="sSportWbsrList" name="sSportWbsrList"/></td></tr>
                        <tr><td>지원 모바일 플랫폼 목록</td><td><input type="text" id="sSportMobilePltfomList" name="sSportMobilePltfomList"/></td></tr>
                        <tr><td rowspan="4">혼환성 정보</td>
                            <td>개방형 표준 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sOpenStdSportAt" name="sOpenStdSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span> 
                            </td>
                        </tr>
                        <tr><td>정부 프레임워크 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sGvrnFrmwrkSportAt" name="sGvrnFrmwrkSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>오픈소스 SW 호환 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sOpenSourcSwAt" name="sOpenSourcSwAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>PaaS-Ta 호환 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sPaastaAt" name="sPaastaAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td rowspan="7">개발지원 정보</td>
                            <td>소스 공개 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sSourcOthbcAt" name="sSourcOthbcAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>외부 API ACCESS 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sApiAccessSportAt" name="sApiAccessSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>DB 마이그레이션 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sDbMigrationSportAt" name="sDbMigrationSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>외부 응용프로그램 통합 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sExtrlApplicationSportAt" name="sExtrlApplicationSportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>Sub-tenancy 지원 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sSubTenancySportAt" name="sSubTenancySportAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>커스터마이징 가능 여부</td>
                            <td>
                                <span class="sel_box">
                                    <select id="sCstmzngPosblAt" name="sCstmzngPosblAt">
                                        <option value="">선택</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                        <tr><td>개발지원 조건 및 기타 사항</td><td><input type="text" id="sDevlopSportEtc" name="sDevlopSportEtc"/></td></tr>
                     </tbody>
                    </table>
                </div>
                
                <div class="btnArea rig" style="margin-bottom: 20px;">
                    <a href="#"  onclick="jsGoodsDescribePrev()" class="f_l btns st1 icn icnBck2">이전</a>
                    <a href="#"  onclick="jsGoodsDescribeNext()" class="btns st1 icn_r next">다음</a>
                </div>
        
                
        <!-- Detail List Area -->
        
        <div id="loading-container" class="loading-container">
            <div class="loading"></div>
            <div id="loading-text">loading</div>
        </div>
        
    </form>
</body>
</html>