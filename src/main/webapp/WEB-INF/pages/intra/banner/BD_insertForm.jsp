<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<jsp:useBean id="bannerVO" class="zes.openworks.intra.banner.BannerVO" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>배너 관리 <c:if test="${empty baseList}">등록</c:if><c:if test="${not empty baseList}">수정</c:if></title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->
<script type="text/javascript">
//<CDATA[[
    $().ready(function () {
        $("#domainClick:button.blue").click(function(){
            var domainCd = $('select[name="domainCd"] option:selected').val();
            var domainDc = $('select[name="domainCd"] option:selected').text();
            if(domainCd == ''){
                jsWarningBox("해당 도메인을 선택하세요.");
            }else if($('#domainCd_' + domainCd).length > 0){
                jsWarningBox("이미 선택하셨습니다.");
            }else{
                var domainHtml = jsMakeHtml(domainCd, domainDc);
                $("#domainCheck").append(domainHtml);
            };
        });

        //배너구분에 의해 등록위치 표시
        if($("#bannerTyCd").val() == "<%= bannerVO.BN_TY_CD_AD %>"){
            $("#lcseCheck").show();
        }else{
            $("#lcseCheck").hide();
        }
        
        $("#bannerTyCd").change(function(){

            if($(this).val() == "<%= bannerVO.BN_TY_CD_PZ %>"){
                $("#lcseCheck").hide();
            }if($(this).val() == "<%= bannerVO.BN_TY_CD_AD %>"){
                $("#lcseCheck").show();
            }else{
                $("#lcseCheck").hide();
            }
        });

        
        var ulHtml = '<li class="mar_b5"><img src="${baseList.bannerFilePath }" alt="${baseList.imageAlt }" style="height:60px;width: 100px; "/><img src="../../resources/openworks/theme/default/images/btn/btn_del.gif" alt="삭제" class="vm" onclick="jsHide(this,1);"/></li>';
        <c:if test="${not empty baseList.bannerFilePath }">
            $("#oh").append(ulHtml);
        </c:if>

        if($('#beginDate').val() == ''){
            $('#beginDate').val(getDateStr(new Date()));
        }
        if($('#endDate').val() == ''){
            $('#endDate').val(getDateStr(new Date()));
        }

        $("span.mar_l10  a  button.gray").click(function(){
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
                 bannerTyCd: { required:true },
                 domainCds:   { required:true },
                 bannerTitle :     { required:true },
                 beginDate :   { required:true, minlength:8, maxlength:10},
                 endDate :     { required:true, minlength:8, maxlength:10},
                 imageAlt:     { required:true },
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

                var bannerLcSeCds = '';
                if($("#bannerTyCd").val() == "<%= bannerVO.BN_TY_CD_AD %>"){
                    $('input[name="bannerLcSeCds"]:checked').each(function (i) {
                        bannerLcSeCds += ',' + $(this).val();                    
                    });
                    if(bannerLcSeCds == ''){
                        jsWarningBox("한개 이상의 등록위치을 선택해주세요.");
                        return false;
                    }
                }
                
                $(form).ajaxSubmit({
                    url : "ND_insertAction.do",
                    type : "POST",
                    dataType : "text",
                    data : {
                        domainCds1 : domainCds.substring(1),
                        bannerLcSeCds1 : bannerLcSeCds.substring(1)
                        },
                    success : function(response) {
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
        if(confirm("이미지를 삭제하시겠습니까?")){
            $("#oh").hide();
            $("#flag").val(vl);
        }
    };

    var jsUpdate = function(){
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
        if(domainCds == ','){
            jsWarningBox("사이트를 선택해주세요.");
            return false;
        }        
        
        var bannerLcSeCds = '';
        if($("#bannerTyCd").val() == "<%= bannerVO.BN_TY_CD_AD %>"){                    
            $('input[name="bannerLcSeCds"]:checked').each(function (i) {
                bannerLcSeCds += ',' + $(this).val();                    
            });
            if(bannerLcSeCds == ''){
                jsWarningBox("한개 이상의 등록위치을 선택해주세요.");
                return false;
            }
        }    
        $("#dataForm").ajaxSubmit({
            url      : "ND_updateAction.do",
            type     : "POST",
            dataType : "text",
            data : {
                domainCds1 : domainCds.substring(1),
                bannerLcSeCds1 : bannerLcSeCds.substring(1)
                },
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

    var jsMakeHtml = function(domainCd,domainDc){
        var domainHtml = '';
        domainHtml += '<input ';
        domainHtml += 'type="checkbox"';
        domainHtml += ' name="domainCds"';
        domainHtml += ' id="domainCd_';
        domainHtml += domainCd ;
        domainHtml += '"';
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
    <div id="contents">
        <form id="dataForm" enctype="multipart/form-data" method="post">
        <input type="hidden" id="flag" name="flag" value="" />
        <input type="hidden" id="flag2" name="flag2" value="" />
        <input type="hidden" id="bannerSn" name="bannerSn" value="${baseList.bannerSn}" />
        <!-- //타이틀 및 상단아이콘 -->
        <p class="tx_r mar_b10"><span class="tx_red tx_b">*</span>표시는 필수입력사항입니다.</p>
        <!-- 내용쓰기 -->
        <fieldset>
            <legend>글입력</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 글입력하기 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="bannerTitle">제목<span class="tx_red tx_b">*</span></label></th>
                        <td><input type="text" id="bannerTitle" class="w85_p" name="bannerTitle" title="제목을 입력해주세요" value="${baseList.bannerTitle}" /></td>
                    </tr>
                    <tr>
                        <th><label for="bannerTyCd">배너구분<span class="tx_red tx_b">*</span></label></th>
                        <td><op:code id="bannerTyCd" grpCd="40" defaultValues="${baseList.bannerTyCd}" type="select" defaultLabel="배너구분선택" /></td>
                    </tr>
                    <tr>
                        <th><label for="part">사이트<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <p class="mar_t5" id="domainCheck">
                                <%--
                                <c:forEach items="${dataVo }" var="_bean" varStatus="status">
                                    <input type="checkbox" name="domainCds" id="domainCd_${_bean.domainCd}"<c:if test="${not empty _bean.checkYn}"> checked="checked"</c:if> value="${_bean.domainCd}"/> ${_bean.domainDc}&nbsp;
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
                    <tr id="lcseCheck">
                        <th><label for="part">등록위치<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <p class="mar_t5" id="bannerLcSeCheck">
                                <c:forEach items="${dataVo1}" var="_bean" varStatus="status">
                                    <input type="checkbox" name="bannerLcSeCds" id="bannerLcSeCd_${_bean.bannerLcSeCd}"<c:if test="${not empty _bean.checkYn}"> checked="checked"</c:if> value="${_bean.bannerLcSeCd}"/> ${_bean.bannerLcSeNm}&nbsp;
                                </c:forEach>
                            </p>                            
                        </td>
                    </tr>
                    <tr>
                        <th><label for="sub">배너기간<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <input class="w120" type="text" name="beginDate" id="beginDate" title="날짜선택"<c:if test="${not empty baseList.beginDate}"> value="${fn:substring(baseList.beginDate,0,4)}-${fn:substring(baseList.beginDate,4,6)}-${fn:substring(baseList.beginDate,6,8)}"</c:if>/> ~
                            <input class="w120" type="text" name="endDate" id="endDate" title="날짜선택"<c:if test="${not empty baseList.endDate}"> value="${fn:substring(baseList.endDate,0,4)}-${fn:substring(baseList.endDate,4,6)}-${fn:substring(baseList.endDate,6,8)}"</c:if>/>
                            <span class="mar_l10">
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
                        <th><label for="linkUrl">링크URL</label></th>
                        <td><input type="text" id="linkUrl" class="w85_p" name="linkUrl" title="URL을 입력해주세요" value="${baseList.linkUrl}" /></td>
                    </tr>
                    <tr>
                        <th><label for="bannerDc">링크TITLE</label></th>
                        <td><input type="text" id="bannerDc" class="w85_p" name="bannerDc" title="상세설명을 입력해주세요" value="${baseList.bannerDc}" /></td>
                    </tr>
                    <tr>
                        <th><label for="linkTyCd">링크타겟</label></th>
                        <td>
                            <op:code id="linkTyCd" grpCd="41" defaultValues="${baseList.linkTyCd}" type="select"  />
                            <%-- 
                            <select id="linkTyCd" title="타켓을 선택해주세요" name="linkTyCd">
                            <option value="">타켓을 선택해 주세요</option>
                            <option value="_blank"<c:if test="${baseList.linkTyCd eq '_blank'}"> selected="selected"</c:if>>새창</option>
                            <option value="_self"<c:if test="${baseList.linkTyCd eq '_self'}"> selected="selected"</c:if>>자신</option>
                            </select>
                             --%>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="bannerFilePath">이미지파일</label></th>
                        <td>
                            <p class="mar_t5 mar_b5"><input type="file" id="bannerFilePath" size="100px" class="w470 multi" name="bannerFilePath" accept="gif|jpg|jpeg" /></p>
                            <ul id="oh">
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="imageAlt">이미지 ALT명<span class="tx_red tx_b">*</span></label></th>
                        <td><input type="text" id="imageAlt" class="w85_p" name="imageAlt" title="이미지 alt를 입력해주세요" value="${baseList.imageAlt}"/></td>
                    </tr>
                    <tr>
                        <th><label for="useYn">사용여부</label></th>
                        <td>
                            <input type="radio" name="useYn" id="useYn_Y" value="Y"<c:if test="${baseList.useYn eq 'Y' || empty baseList.useYn}"> checked="checked"</c:if> />
                            <label for="radio">사용</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="useYn" id="useYn_N" value="N"<c:if test="${baseList.useYn eq 'N'}"> checked="checked"</c:if> />
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
                <c:if test="${empty baseList}">
                    <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
                        <li><a href="#"><button class="blue">등록</button></a></li>
                    </c:if>
                </c:if>
                <c:if test="${not empty baseList.bannerSn}">
                    <c:if test="${(MenuAssignType eq 'A' && baseList.registId eq __msk.mgrId) or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
                        <!-- or MenuAssignType eq 'R' : 권한문제로 임시로 추가한 조건임.. 권한문제 해결하면 원복할것 -->
                        <li><a href="#" onclick="jsUpdate();"><button class="blue" type="button">수정</button></a></li>
                    </c:if>
                </c:if>
                <li><a href="#"  onclick="jsBack(event);"><button class="blue" type="button">목록</button></a></li>
            </ul>
        </div>
        <!-- //버튼 -->
    
        </form>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>