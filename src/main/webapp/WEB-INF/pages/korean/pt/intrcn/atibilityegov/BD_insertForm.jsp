<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>호환성 신청 및 확인 | 표준프레임워크 | 소개 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form,validate,datepicker" />
 	<script type="text/javascript">
        $().ready(function () {
            $("#dataForm").validate({
                rules: {
                    cmptbAnalsTrgetNm       :        { required:true,maxByte:60},
                    cmptbClCd               :        { required:true },
                    bsnnNm                  :        { required:true,maxByte:60},
                    analsApplcntNm          :        { required:true,maxByte:20},
                    applcntTelno            :        { required:true,phone:true},
                    applcntFxnum           :        { required:true,phone:true},
                    applcntEmail            :        { required:true,email:true,maxByte:50},
                    analsTrgetDc            :        { required:true,maxByte:4000},
                    ver                     :        { required:true,maxByte:20  },
                    analsReqstDe            :        { required:true},
                    analsPlaceZip1          :        { required:true },
                    analsPlaceZip2          :        { required:true },
                    analsPlaceBassAdres     :        { required:true },
                    analsPlaceDetailAdres   :        { required:true ,maxByte:100}
                    //archtcImeReqstSumry      :        { required:true ,maxByte:1000},
                    //guideImeReqstSumry      :        { required:true ,maxByte:1000},
                    //egovFrameIemSumry       :        { required:true ,maxByte:1000}
                },
                messages : {
                    cmptbAnalsTrgetNm : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    bsnnNm : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    analsApplcntNm : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},                    
                    //applcntTelno : {phone:"숫자 또는 대시('-')만 입력하세요. [ex:02-111-2222]"},
                    //applcntFxnum : {phone:"숫자 또는 대시('-')만 입력하세요. [ex:02-111-2222]"},
                    applcntTelno : {phone:"예시 (010-111-2222)"},
                    applcntFxnum : {phone:"예시 (02-111-2222)"},
                    applcntEmail : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)"),
                                        //email: "'@'문자가 표현된 이메일 주소를 입력하세요. [ex:tester@abc.com]"
                                          email: "예시 (tester@abc.com)"
                        },
                    analsTrgetDc : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    ver : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    cmptbAnalsTrgetNm : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    analsPlaceDetailAdres : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    archtcImeReqstSumry : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    guideImeReqstSumry : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                    egovFrameIemSumry : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")}
                },
                submitHandler : function(form) {
                  
                    if(confirm("호환성지원을 신청하시겠습니까?")){
                        
                        var analsPlaceZip = $("#analsPlaceZip1").val() + "-" + $("#analsPlaceZip2").val();                        
                        $(form).ajaxSubmit({
                            url : "ND_insertAction.do",
                            type : "POST",
                            dataType : "text",
                            data : {
                                       analsPlaceZip:analsPlaceZip
                                   },
                            success : function(response){
                                try {
                                    if(eval(response)) {
                                        alert(Message.msg.insertOk);
                                        //location.href = "BD_applyFinish.do";
                                        location.href = "BD_index.do";
                                    } else {
                                        alert(Message.msg.processFail);
                                    }
                                } catch (e) {
                                    //jsSysErrorBox(response, e);
                                    alert(response);
                                    return;
                                }
                            }
                        });
                    }

                }
            });

            //기본 날짜 세팅
            
            
            //$.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
            
            $('#analsReqstDe').datepicker({
                dateFormat: 'yy-mm-dd',
                showOn : 'button'
            }).datepicker("setDate",new Date());
            
        }); //ready end
    
        var jsList = function(){
            location.href = "BD_index.do";
        };
    
        var zipCodePop = function(el){
            $(el).colorbox({
                title : "우편번호 검색",
                //href : "/${_pathLang}/pt/zipcode/PD_searchList.do",
                href : "/web/zipcode/PD_searchList.do",
                width : "1000",
                height: "750",
                iframe: true
            });
        };
        
        
      //글자수체크
        var displayBytes  = function (event, nm, id ){
            var obj  = document.getElementById( id );
            var sRad = "<span class='orange'>";
            var eRad = "</span>";
            var text = "";
            
                if (obj.value.bytes() > nm){
                        text = sRad + eval('dataForm.'+id).value.bytes() + eRad;
                }else{
                    text = eval('dataForm.'+id).value.bytes();
                }
                eval('document.all.'+id+'_bytes').innerHTML = text;
        };
        
        //글자수체크 bytes 계산 속성 추가
        String.prototype.bytes = function(){
            var str = this;
            var size = 0;
            for (var i=0; i<str.length; i++){
                size += (str.charCodeAt(i) > 128) ? 2 : 1;
            }
            return size;
        };
        
	</script>
</head>
<body>
	<form id="dataForm" method="post">
		<input type="hidden" id="zipCodeId"     value="analsPlaceZip"           title="우편번호" />
		<input type="hidden" id="baseAddrId"    value="analsPlaceBassAdres"     title="기본주소" />
		<input type="hidden" id="detailAddrId"  value="analsPlaceDetailAdres"   title="상세주소" />
		
		<section class="member">    
		    <table class="tbl_list_input orgmargin">
		            <caption>
		                <strong>호환성 테스트 신청</strong>
		                <details>
		                    <summary>호환성 분석 대상명, 호환성 분류, 사업자명, 호환성 분석 신청자, 호환성 전화번호, 신청자 이메일, 신청자 팩스 번호, 분석대상 설명, 버전, 분석장소 정보를 입력하는 서식입니다.</summary>
		                </details>
		            </caption>
		            <colgroup>
		            <col style="width:21%">
		            <col>
		            <col style="width:18%">
		            <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="name">호환성 분석 대상명</label></th>
		                    <td colspan="3"><input type="text" id="cmptbAnalsTrgetNm"  name="cmptbAnalsTrgetNm" title="서비스 이름을 입력해 주세요" style="width:550px;"></td>
		                </tr>   
		                <tr>
		                    <th scope="row"><span class="ast">*</span> 호환성 분류</th>
		                    <td colspan="3">
		                        <dl class="standard">                             
		                             <c:forEach items="${dataVo}" var="dataVo" varStatus="status">                            
		                                <dt><input type="radio" id="cmptbClCd0${status.index + 1}" name="cmptbClCd" title="호환성 분류를 선택해 주세요" value="${dataVo.prvCd}"><label for="frame0${status.index + 1}">${dataVo.prvNm}</label></dt>
		                                <c:choose>
		                                    <c:when test="${dataVo.prvCd eq '1001'}">
		                                        <dd>표준프레임워크 실행환경 및 공통컴포넌트를 활용하여 구축된 SW 패키지 SW 등</dd>
		                                    </c:when>
		                                    <c:when test="${dataVo.prvCd eq '1002'}">
		                                        <dd>표준프레임워크와 연동하여 시스템 구축시 필요·활용 가능한 SW - DB, WAS, System형 솔루션 RIA 솔루션, SSO, 암호화 솔루션 등</dd>
		                                    </c:when>
		                                    <c:when test="${dataVo.prvCd eq '1003'}">
		                                        <dd>표준프레임워크 기반의 시스템 구축에 필요한 부가적인 기능을 지원하는 SW.<br />- Case Tool, ALM 솔루션 등</dd>
		                                    </c:when>
		                                </c:choose>
		                            </c:forEach>
		                        
		                            <!-- 
		                            <dt><input type="radio" id="cmptbClCd01" name="cmptbClCd" title="호환서 분류를 선택해 주세요" value="1001"><label for="frame01">표준프레임워크기반 SW</label></dt>
		                            <dd>표준프레임워크 실행환경 및 공통컴포넌트를 활용하여 구축된 SW 패키지 SW 등</dd>
		                            <dt><input type="radio" id="cmptbClCd02" name="cmptbClCd" title="호환서 분류를 선택해 주세요" value="1002"><label for="frame02">표준프레임워크연동 SW</label></dt>
		                            <dd>표준프레임워크와 연동하여 시스템 구축시 필요·활용 가능한 SW - DB, WAS, System형 솔루션 RIA 솔루션, SSO, 암호화 솔루션 등</dd>
		                            <dt><input type="radio" id="cmptbClCd03" name="cmptbClCd" title="호환서 분류를 선택해 주세요" value="1003"><label for="frame03">표준프레임워크지원 SW</label></dt>
		                            <dd>표준프레임워크 기반의 시스템 구축에 필요한 부가적인 기능을 지원하는 SW.<br />
		                            - Case Tool, ALM 솔루션 등</dd>
		                             -->
		                        </dl>
		                    </td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="c_name">사업자(업체)명</label></th>
		                    <td colspan="3"><input type="text" id="bsnnNm" name="bsnnNm" title="사업자(업체)명을 입력해 주세요" style="width:550px;"/></td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="cp_name">호환성 분석 신청자</label></th>
		                    <td colspan="3"><input type="text" id="analsApplcntNm" name="analsApplcntNm" title="신청자 이름을 입력해 주세요" style="width:550px;"/></td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="cp_phone">호환성 전화번호</label></th>
		                    <td colspan="3"><input type="text" id="applcntTelno" name="applcntTelno" title="전화번호를 입력해 주세요"  style="width:550px;"/></td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="email">신청자 이메일</label></th>
		                    <td colspan="3"><input type="text" id="applcntEmail" name="applcntEmail" title="신청자 이메일을 입력해 주세요"  style="width:550px;"/></td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="fax">신청자 팩스번호</label></th>
		                    <td colspan="3"><input type="text" id="applcntFxnum" name="applcntFxnum" title="팩스번호를 입력해 주세요" style="width:550px;"/></td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span> <label for="comment">분석 대상 설명</label></th>
		                    <td colspan="3">
		                        <textarea name="analsTrgetDc" id="analsTrgetDc"  title="분석 대상 설명을 입력해 주세요"
		                        onkeyup="javascript:displayBytes(event,4000,'analsTrgetDc');"  onblur="javascript:displayBytes(event,4000,'analsTrgetDc');"
		                        style="width:550px;height:60px;margin:7px 0;padding:0 10px;"></textarea><br />
		                        <span class="byte">
		                            <span id="analsTrgetDc_bytes">0</span> / 4,000 Byte
		                        </span>
		                    </td>
		                </tr>
		                <tr>
		                    <th id="ver"><span class="ast">*</span> <label for="version">버전</label></th>
		                    <td headers="ver"><input type="text" id="ver" name="ver"  title="버전을 입력해 주세요" style="width:170px;"></td>
		                    <th id="r_date"><span class="ast">*</span> 분석 신청 날짜</th>
		                    <td headers="r_date" class="rel">
		                    
		                    <div class="calendar_input">
		                      <input class="input" type="text" readonly="readonly" name="analsReqstDe" id="analsReqstDe" title="날짜선택" style="width:118px;height:23px;" />
		                    </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th scope="row"><span class="ast">*</span>분석장소</th>
		                    <td class="addr" colspan="3">
		                        <span class="btn_light_gray02">
		                            <a href="#" onclick="zipCodePop(this);" title="팝업 창 열림">우편번호</a>
		                        </span>
		                        <input type="text" readonly="readonly" title="우편번호 앞자리 입력" id="analsPlaceZip1" name="analsPlaceZip01" style="float:left;width:70px;" /><span class="divide">-</span>
		                        <input type="text" readonly="readonly" title="우편번호 뒷자리 입력" id="analsPlaceZip2" name="analsPlaceZip02" style="float:left;margin-right:10px;width:70px;" /> <br />                                            
		                        <input type="text" readonly="readonly" title="주소 자동 입력" id="analsPlaceBassAdres" name = "analsPlaceBassAdres" style="width:263px;" /> 
		                        <input type="text" title="상세 주소 입력" id="analsPlaceDetailAdres" name="analsPlaceDetailAdres" style="width:263px;" />
		                    </td>
		                </tr>
		            </tbody>
		        </table>
		        
		        <table class="tbl_list type_A">
		        <caption>
		          <strong>호환성 신청</strong>
		          <details>
		            <summary>선택, 항목명, 항목설명, 신청요약 정보를 제공합니다.</summary>
		          </details>
		        </caption>
		        <colgroup>
		          <col style="width:10%">
		          <col style="width:20%">
		          <col style="width:35%">
		          <col style="width:*">
		        </colgroup>
		        <thead>
		          <tr>
		            <th scope="col">선택</th>
		            <th scope="col">항목명</th>
		            <th scope="col">항목설명</th>
		            <th scope="col">신청요약</th>
		          </tr>
		        </thead>
		        <tbody>
		          <tr>
		            <td><input type="checkbox"  id="archtcIemAt" name="archtcIemAt" value="Y"  title="아키텍처"></td>
		            <td>아키텍처</td>
		            <td>표준프레임워크 아키텍처 및 환경제약사항 준수</td>
		            <td>
		              <textarea class="textarea"  id="archtcImeReqstSumry" name="archtcImeReqstSumry" title="아키텍처를 입력해 주세요"></textarea>
		            </td>
		          </tr>
		          <tr>
		            <td><input type="checkbox" id="guideIemAt" name="guideIemAt" value="Y" title="가이드" ></td>
		            <td>가이드</td>
		            <td>솔루션(SW)가이드 제공 여부를 확인함</td>
		            <td>
		              <textarea class="textarea" id="guideImeReqstSumry" name="guideImeReqstSumry" title="가이드를 입력해 주세요"></textarea>
		            </td>
		          </tr>
		          <tr>
		            <td><input type="checkbox" id="egovFrameIemAt" name="egovFrameIemAt"  value="Y" title="표준프레임워크호환성"></td>
		            <td>표준프레임워크호환성</td>
		            <td>표준프레임워크 호환성 점검</td>
		            <td>
		              <textarea class="textarea" id="egovFrameIemSumry" name="egovFrameIemSumry" title="표준프레임워크호환성을 입력해 주세요" ></textarea>
		            </td>
		          </tr>
		        </tbody>
		      </table>
		
		    <div class="btn_area">
		            <div class="btn_l">
		                <div class="btn_navi_g">
		                    <a href="#" onclick="jsList();"><span class="total">목록</span></a>
		                </div>                          
		            </div>
		            <div class="btn_r">
		                <div class="btn_navi">
		                    <button id="submitClick"><a href="#"><span class="inp_info">신청</span></a></button>
		                </div>
		            </div>
		        </div>
		</section>
	</form>
</body>
</html>