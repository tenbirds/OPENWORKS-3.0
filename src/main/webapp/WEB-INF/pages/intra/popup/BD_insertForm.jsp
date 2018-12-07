<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>팝업 관리 <c:if test="${empty baseVo}">등록</c:if><c:if test="${not empty baseVo}">수정</c:if></title>
<op:jsTag type="spi" items="validate,ui,form"/>
<op:jsTag type="openworks" items="ckeditor" />
<script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->
<script type="text/javascript">
//<![CDATA[
    var cookieToogle = function(checkYn){
        if(checkYn){
            $(".cookieDay").each(function(idx){
                $(this).removeAttr("disabled");
            });
        }else{
            $(".cookieDay").each(function(idx){
                $(this).attr("disabled", "disabled");
            });
        }
    };

    $().ready(function(){
    	$("#domainClick:button.blue").click(function(){
            var domainCd = $('select[name="domainCd"] option:selected').val();
            var domainDc = $('select[name="domainCd"] option:selected').text();
            if(domainCd == ''){
                jsWarningBox("해당 사이트를 선택하세요.");
            }else if($('#domainCd_'+domainCd).length > 0){
                jsWarningBox("이미 선택하셨습니다.");
            }else{
            	var domainHtml = jsMakeHtml(domainCd, domainDc);
            	$("#domainCheck").append(domainHtml);
            };
        });

        $('#popupHtml').hide();
        $('#popupUrl').hide();
        $('#popupFile').hide();
        var cookieVal = $('input[name="cookieYn"]:checked').val();
        if(cookieVal == "Y"){
            cookieToogle(true);
        }else{
            cookieToogle(false);
        }
        var makeTyCdVal = $('input[name="makeTyCd"]:checked').val();
        
        if(makeTyCdVal == "1001"){
            $('#popupHtml').show();
            $('#popupUrl').hide();
            $('#popupFile').hide();
        }else if(makeTyCdVal == "1002"){
            $('#popupHtml').hide();
            $('#popupUrl').show();
            $('#popupFile').hide();
        }else if(makeTyCdVal == "1003"){
            $('#popupHtml').hide();
            $('#popupUrl').hide();
            $('#popupFile').show();
        }

        $("#area").find('input[name="makeTyCd"]').click(function(){
            var mType = $(this).attr('value');
            switch(mType){
	            case '1001' :
	                $('#popupHtml').show();
	                $('#popupUrl').hide();
	                $('#non').hide();
	                $('#popupFile').hide();
	                break;
	            case '1002' :
	                $('#popupHtml').hide();
	                $('#popupUrl').show();
	                $('#non').hide();
	                $('#popupFile').hide();
	                break;
	            case '1003' :
	                $('#popupHtml').hide();
	                $('#popupUrl').hide();
	                $('#non').hide();
	                $('#popupFile').show();
	                break;
	            default:
	                $('#popupHtml').hide();
	             $('#popupUrl').hide();
	             $('#popupFile').hide();
	                break;
            }
        });

        if($('#beginDate').val() == ''){
            $('#beginDate').val(getDateStr(new Date()));
        }
        if($('#endDate').val() == ''){
            $('#endDate').val(getDateStr(new Date()));
        }

        $("span#popupPeriod  a  button.gray").click(function(){
            var sType = $(this).attr('id');
            var beginDate = null;
            var endDate = null;
            $('#beginDate').val("");
            $('#endDate').val("");
            switch(sType){
                case '0' :
                    beginDate = new Date();
                    $('#beginDate').val(getDateStr(beginDate));
                    endDate = new Date();
                    $('#endDate').val(getDateStr(endDate));
                    break;
                case '1D':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),0,1);
                    }else{
                        endDate = getCaldate2($("#beginDate").val(),0,1);
                    }
                    break;
                case '7D':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),0,7);
                      }else{
                        endDate = getCaldate2($("#beginDate").val(),0,7);
                      }
                    break;
                case '10D':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),0,10);
                      }else{
                        endDate = getCaldate2($("#beginDate").val(),0,10);
                      }
                    break;
                case '15D':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),0,15);
                      }else{
                        endDate = getCaldate2($("#beginDate").val(),0,15);
                      }
                    break;
                case '1M':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),1,0);
                      }else{
                        endDate = getCaldate2($("#beginDate").val(),1,0);
                      }
                    break;
                case '3M':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),3,0);
                      }else{
                        endDate = getCaldate2($("#beginDate").val(),3,0);
                      }
                    break;
                case '6M':
                    if($("#beginDate").val() == getDateStr(new Date()) || $("#beginDate").val() == ""){
                        endDate = getCalDate(new Date(),6,0);
                      }else{
                        endDate = getCaldate2($("#beginDate").val(),6,0);
                      }
                    break;
                default:
                    $("#beginDate").val("20000101");
                    $("#endDate").val("21001231");
                    break;
            }
            if($('#endDate').val() != "21001231"){
                $('#endDate').val(getDateStr(endDate));
            }
            if($('#beginDate').val() == ''){
                $('#beginDate').val(getDateStr(new Date()));
            }
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

        $("#dataForm").validate({
            rules: {
                 domainCd:   { required:true },
                 domainCds:   { required:true },
                 popupTitle :        { required:true },
                 beginDate :      { required:true, minlength:8, maxlength:10},
                 endDate :        { required:true, minlength:8, maxlength:10},
                 heightSize :   { required:true, minlength:1, maxlength:4 , number : true},
                 widthSize :    { required:true, minlength:1, maxlength:4 , number : true},
                 leftLc : { required:true, minlength:1, maxlength:4 , number : true},
                 topLc :  { required:true, minlength:1, maxlength:4 , number : true},
                 cookieDeCo : { required:true }

            },
            submitHandler : function(form) {
                if($("#beginDate").val().length == 10){
                    $("#beginDate").val($("#beginDate").val().replace(/-/gi,""));
                };
                if($("#endDate").val().length == 10){
                    $("#endDate").val($("#endDate").val().replace(/-/gi,""));

                };
                if($("#beginDate").val() > $("#endDate").val() || $("#beginDate").val().replace(/-/gi,"") > $("#endDate").val().replace(/-/gi,"")){
                    jsWarningBox("시작일이 종료일보다 뒤에 날짜로 올수 없습니다.");
                    $("#beginDate").focus();
                    return false;
                };
                
                var domainCds = '' +  ',' + $("select[name=domainCds]").val();

                /* if(CKEDITOR.instances.cnHtml.getData() == ''){
                    jsWarningBox("내용을 입력해주세요.");
                    $("#cnHtml").focus();
                    return false;
                }else{
                    $("#cnHtml").val(CKEDITOR.instances.cnHtml.getData());
                } */
                
                $("#cnHtml").val(CKEDITOR.instances.cnHtml.getData());
                
                $(form).ajaxSubmit({
                    url : "ND_insertAction.do",
                    type : "POST",
                    dataType : "text",
                    data : {domainCds1 : domainCds.substring(1)},
                    success : function(response){
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.insertOk);
                                self.location.href = "BD_index.do";
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        } catch (e) {
                            jsSysErrorBox(response, e);
                            return;
                        }
                    }
                });
            }
        });
    });

    var getCalDate = function(date, months, days){
        var newDate = date;
        if(typeof(date.getDate) != 'function'){
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;

    };

    var getCaldate2 = function(date, months, days){
        if(date.length == 8){
            var a = date;
            var date2 = a.substring(0,4) + '-' + a.substring(4,6) + '-' + a.substring(6,8);

            var newDate = new XDate(date2);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        }else{
	        var newDate = new XDate(date);
	        newDate.setMonth(newDate.getMonth() + months);
	        newDate.setDate(newDate.getDate() + days);
	        return newDate;
        }
    };

    var getDateStr = function(date){
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl){
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };

    var jsList = function(){
        location.href = "BD_index.do";
    };

    var jsBack = function(event){
        history.go(-1);
        event.preventDefault();
    };
    
    var jsHide = function(el, vl){
        if(confirm("이미지를 삭제 하시겠습니까?")){

        $("#oh").hide();
        $("#flag").val(vl);
        }
    };

    var jsUpdate = function(){
        if($("#beginDate").val().length == 10){
            $("#beginDate").val($("#beginDate").val().replace(/-/gi,""));
        }
        if($("#endDate").val().length == 10){
            $("#endDate").val($("#endDate").val().replace(/-/gi,""));

        }
        if($("#beginDate").val() > $("#endDate").val() || $("#beginDate").val().replace(/-/gi,"") > $("#endDate").val().replace(/-/gi,"")){
            jsWarningBox("시작일이 종료일보다 뒤에 날짜로 올 수 없습니다.");
            $("#beginDate").focus();
            return false;
        }
        
        var domainCds = '' +  ',' + $("select[name=domainCds]").val();
        if(domainCds == ','){
            jsWarningBox("사이트를 선택해주세요.");
            return false;
        }

        /* if(CKEDITOR.instances.cnHtml.getData() == ''){
            jsWarningBox("내용을 입력해주세요.");
            $("#cnHtml").focus();
            return false;
        }else{
            $("#cnHtml").val(CKEDITOR.instances.cnHtml.getData());
        } */
        
        $("#cnHtml").val(CKEDITOR.instances.cnHtml.getData());
        
        $("#dataForm").ajaxSubmit({
            url      : "ND_updateAction.do",
            type : "POST",
            dataType : "text",
            data : {domainCds1 : domainCds.substring(1)},
            async    : false,
            success  : function(response){
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.updateOk);
                        self.location.href = "BD_index.do";
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }
            }
        });
    };

    var jsCookie = function(el, vl){
        $("#cookieDeCo").val(vl);
    };

    var jsViewPop = function(el){
        $(el).colorbox({
            title :     $("#popupTitle").val(),
            href  :     $("#").val(),
            width :     $("#widthSize").val(),
            height:     $("#heightSize").val(),
            top   :     $("#topSize").val(),
            left  :     $("#leftSize").val(),
            scrolling : $("#scrlYn").val(),
            iframe: true
        });

    };

    var jsMakeHtml = function(domainCd, domainDc){
        var domainHtml = '';
        domainHtml += '<input ';
        domainHtml += 'type="checkbox"';
        domainHtml += ' name="domainCds"';
        domainHtml += ' id="domainCd_';
        domainHtml +=  domainCd ;
        domainHtml +=  '"';
        domainHtml += ' checked="checked"';
        domainHtml += 'value="' + domainCd + '"';
        domainHtml += '/>&nbsp;&nbsp;';
        domainHtml += domainDc;
        return domainHtml;
    };
//]]>
</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
    <div id="content">
        <form id="dataForm" enctype="multipart/form-data" method="post">
        <input type="hidden" id="flag" name="flag" value=""/>
        <input type="hidden" id="popupSn" name="popupSn" value="${baseVo.popupSn}"/>
        <!-- 내용쓰기 -->
        <fieldset>
        <legend>팝업등록</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 팝업등록하기 </caption>
            <colgroup>
                <col width="10%" />
                <col width="40%" />
                <col width="10%" />
                <col width="40%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="popupTitle">제목<span class="tx_red tx_b">*</span></label></th>
                    <td colspan="3"><input type="text" id="popupTitle" class="w85_p" name="popupTitle" title="제목을 입력해주세요" value="${baseVo.popupTitle }" />
                    </td>
                </tr>
                <tr>
                    <th><label for="part">사이트<span class="tx_red tx_b">*</span></label></th>
                    <td colspan="3">
                    <p class="mar_t5" id="domainCheck">
                        <%--
	                       <c:forEach items="${dataVo }" var="_bean" varStatus="status">
	                       <input type="checkbox" name="domainCds" id="domainCd_${_bean.domainCd }" <c:if test="${not empty _bean.checkYn}">checked="checked"</c:if> value="${_bean.domainCd }"/>&nbsp;&nbsp;${_bean.domainDc }
	                       </c:forEach>
                          --%>
                           <select id="domainCds" title="사이트를 선택해주세요" name="domainCds">
                            <option value="">사이트선택</option>
                            <c:forEach items="${dataVo }" var="_bean" varStatus="status">
                                <option value="${_bean.domainCd}" <c:if test="${not empty _bean.checkYn}">selected="selected"</c:if> >${_bean.domainDc}</option>
                            </c:forEach>
                            </select>
                    </p>
                    </td>
                </tr>
                <tr>
                    <th><label for="advrtsClientCd">광고주</label></th>
                    <td colspan="3">
                        <select id="advrtsClientCd" title="광고주를 선택해주세요" name="advrtsClientCd">
                            <option value="">광고주선택</option>
                            <c:forEach items="${advertisList}" var="advList" varStatus="status">
                                <option value="${advList.advrtsClientSeq}" <c:if test="${baseList.advrtsClientCd eq advList.advrtsClientSeq}">selected="selected"</c:if> >${advList.advrtsReqestEntrpsNm}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="sub">팝업기간<span class="tx_red tx_b">*</span></label></th>
                    <td colspan="3"><input class="w120" type="text" name="beginDate" id="beginDate" title="시작 날짜를 선택해주세요" <c:if test="${not empty baseVo.beginDate }">value="${fn:substring(baseVo.beginDate,0,4)}-${fn:substring(baseVo.beginDate,4,6)}-${fn:substring(baseVo.beginDate,6,8)}"</c:if>/> ~
                        <input class="w120" type="text" name="endDate" id="endDate" title="종료 날짜를 선택해주세요" <c:if test="${not empty baseVo.endDate }">value="${fn:substring(baseVo.endDate,0,4)}-${fn:substring(baseVo.endDate,4,6)}-${fn:substring(baseVo.endDate,6,8)}"</c:if>/>
                    <span class="mar_l10" id="popupPeriod">
                        <a href="#"><button type="button" id="0"   class="gray">당일</button></a>
                        <a href="#"><button type="button" id="1D"  class="gray">1일</button></a>
                        <a href="#"><button type="button" id="7D"  class="gray">7일</button></a>
                        <a href="#"><button type="button" id="10D" class="gray">10일</button></a>
                        <a href="#"><button type="button" id="15D" class="gray">15일</button></a>
                        <a href="#"><button type="button" id="1M"  class="gray">1개월</button></a>
                        <a href="#"><button type="button" id="3M"  class="gray">3개월</button></a>
                        <a href="#"><button type="button" id="6M"  class="gray">6개월</button></a>
                        <a href="#"><button type="button" id="ALL" class="gray">전체</button></a>
                    </span>
                    </td>
                </tr>
                <tr>
                    <th><label for="widthSize">사이즈<span class="tx_red tx_b">*</span></label></th>
                    <td>가로 : <input type="text" id="widthSize" class="w55" name="widthSize" title="사로사이즈를 입력해주세요" value="${baseVo.widthSize}" /> Pixel &nbsp;&nbsp; 
                        세로 : <input type="text" id="heightSize" class="w55" name="heightSize" title="세로사이즈를 입력해주세요" value="${baseVo.heightSize}" /> Pixel
                    </td>
                    <th>리사이징</th>
                    <td>
                        <input type="radio" name="resizingYn" id="resizingY" value="Y" <c:if test="${baseVo.resizingYn eq 'Y'}">checked="checked"</c:if>/>
                        <label for="reraiz">사용</label>&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="resizingYn" id="resizingN" value="N" <c:if test="${empty baseVo.resizingYn ||  baseVo.resizingYn eq 'N'}">checked="checked"</c:if>/>
                        <label for="reraiz1">미사용</label>
                    </td>
                </tr>
                <tr>
                    <th><label for="heightSize">위치<span class="tx_red tx_b">*</span></label></th>
                    <td>Top : <input type="text" id="topLc" class="w55" name="topLc" title="Top위치를 입력해주세요" value="${baseVo.topLc}" /> Pixel &nbsp;&nbsp; 
                        Left : <input type="text" id="leftLc" class="w55" name="leftLc" title="Left위치를 입력해주세요" value="${baseVo.leftLc}" /> Pixel</td>
                    <th>스크롤</th>
                    <td>
                        <input type="radio" name="scrlYn" id="scrollY" value="true" <c:if test="${baseVo.scrlYn eq 'true'}">checked="checked"</c:if>/>
                        <label for="scroll">사용</label>&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="scrlYn" id="scrollN" value="false" <c:if test="${empty baseVo.scrlYn || baseVo.scrlYn eq 'false'}">checked="checked"</c:if>/>
                        <label for="scroll1">미사용</label>
                    </td>
                </tr>
                <tr>
                    <th>쿠키</th>
                    <td>
                        <input type="radio" name="cookieYn" id="cookiesY" value="Y" <c:if test="${baseVo.cookieYn eq 'Y'}">checked="checked"</c:if> onclick="cookieToogle(true);" />
                        <label for="cooki">사용</label>&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="cookieYn" id="cookiesN" value="N" <c:if test="${empty baseVo.cookieYn || baseVo.cookieYn eq 'N'}">checked="checked"</c:if> onclick="cookieToogle(false);" />
                        <label for="cooki1">미사용</label>
                    </td>
                    <th><label for="cookieDeCo">쿠키일자</label></th>
                    <td>
                        <input type="text" id="cookieDeCo" class="w55 cookieDay" name="cookieDeCo" value="${baseVo.cookieDeCo}" /> 일
                        <span class="mar_l10" id="cookie">
	                        <a href="#"><button type="button" class="gray cookieDay" onclick="jsCookie(this,3);" >3일</button></a>
	                        <a href="#"><button type="button" class="gray cookieDay" onclick="jsCookie(this,7);" >7일</button></a>
	                        <a href="#"><button type="button" class="gray cookieDay" onclick="jsCookie(this,15);" >15일</button></a>
	                        <a href="#"><button type="button" class="gray cookieDay" onclick="jsCookie(this,30);" >30일</button></a>
	                    </span>
                    </td>
                </tr>
                <tr>
                    <th>팝업형식</th>
                    <td colspan="3">
                        <op:code id="popupTyCd" grpCd="67" type="radio" defaultValues="${baseVo.popupTyCd == null ? '1001' : baseVo.popupTyCd}"/>
                    </td>
                </tr>
                <tr>
                    <th>작성방법</th>
                    <td colspan="3" id="area">
                    <op:code id="makeTyCd" grpCd="68" type="radio" defaultValues="${baseVo.makeTyCd == null ? '1001' : baseVo.makeTyCd}"/>
                    </td>
                </tr>
                <tr>
                    <th>내용입력</th>
                    <td id="popupHtml" colspan="3">
                        <textarea id="cnHtml" name="cnHtml" rows="6" class="w99_p">${baseVo.cnHtml}</textarea>
                        <script type="text/javascript">
                            //<![CDATA[
                            CKEDITOR.replace('cnHtml', {
                                height : 200,
                                enterMode : "2",
                                skin : "moono",
                                toolbar : toolbar_config.default_toolbar,
                                allowedContent: true,
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
                            });
                            //]]>
                        </script>
                    </td>
                    <td id="popupUrl" colspan="3">
                        <input type="text" id="cnUrl" class="w85_p" name="cnUrl" title="URL을 입력해주세요" value="${baseVo.cnUrl}" /><p class="mar_t10 tx_blue_s"><img src="../../resources/openworks/theme/default/images/icon/icon_check.gif" alt="" class="vm"/> 전체 URL을 입력하시기 바랍니다.&nbsp;&nbsp;예)http://www.openwork.co.kr/popup/popup.html</p>
                    </td>
                    <td id="popupFile" colspan="3">
                        <input type="file" id="popupFilePath" size="100px" name="popupFilePath" accept="jsp|html|HTML|htm" /><p class="mar_t10 tx_blue_s"><img src="../../resources/openworks/theme/default/images/icon/icon_check.gif" alt="" class="vm"/> jsp, html, HTML, htm 하나의 파일만 업로드 가능합니다.</p><c:if test="${not empty baseVo.fileNm}"><p class="mar_t10"><img src="../../resources/openworks/theme/default/images/icon/icon_file.gif" alt="첨부파일" class="vm" />${baseVo.fileNm}</p></c:if>
                    </td>
                    <td id="non" colspan="3"></td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td colspan="3">
                    <input type="radio" name="useYn" id="useY" value="Y" <c:if test="${baseVo.useYn eq 'Y' or empty baseVo.useYn}">checked="checked"</c:if>/>
                    <label for="radio">사용</label>&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="useYn" id="useN" value="N" <c:if test="${baseVo.useYn eq 'N'}">checked="checked"</c:if>/>
                    <label for="radio1">미사용</label>
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>
        <!-- //내용쓰기 -->

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <c:if test="${empty baseVo.popupSn}">
                	<c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
                    	<li><a href="#"><button class="blue">등록</button></a></li>
                    </c:if>
                </c:if>
                <c:if test="${not empty baseVo.popupSn}">
                	<c:if test="${(MenuAssignType eq 'A' && baseVo.registId eq __msk.mgrId) or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
                	     <!-- or MenuAssignType eq 'R' : 권한문제로 임시로 추가한 조건임.. 권한문제 해결하면 원복할것 -->
                    	<li><a href="#" onclick="jsUpdate();"><button class="blue" type="button">수정</button></a></li>
                   	</c:if>
                </c:if>
                <li><a href="#" onclick="jsBack(event);"><button class="blue" type="button">목록</button></a></li>
            </ul>
        </div>
        <!-- //버튼 -->
    </form>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>