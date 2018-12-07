<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>이벤트 관리 <c:if test="${empty baseVo}">등록</c:if><c:if test="${not empty baseVo}">수정</c:if></title>
<op:jsTag type="spi" items="validate,ui,form,maskinput"/>
<op:jsTag type="openworks" items="ckeditor" />
<script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<script type="text/javascript">

    $().ready(function () {

        $("#presnatnHm").mask("99:99");
        
        //이미지 불러오기
        var ulHtml = '<li class="mar_b5"><img src="${baseList.eventFilePath }" alt="${baseList.imageAlt }" style="height:60px;width: 100px; "/><img src="../../resources/openworks/theme/default/images/btn/btn_del.gif" alt="삭제" class="vm" onclick="jsHide(this,1);"/></li>';
        <c:if test="${not empty baseList.eventFilePath }">
            $("#oh").append(ulHtml);
        </c:if>
        
        // 발표일 기본은 숨김
        $('#presnatnDateTr').hide();
        // 당첨자 확인 url 기본은 숨김
        $('#cnfirmUrl01').hide();
        
        //이벤트구분 이벤트 [참여형 선택시 발표일 활성화]
        $('#eventTyCd').change(function(){
            var mType = $("#eventTyCd option:selected").val();
            switch(mType){
	            case '1001' :
	                $('#presnatnDateTr').hide();
	                $('#cnfirmUrl01').hide();
	                break;
	            case '1002' :
	                $('#presnatnDateTr').show();
	                $('#cnfirmUrl01').show();
	                break;
                case '1003' :
                    $('#presnatnDateTr').show();
                    $('#cnfirmUrl01').show();
                    break;
	            default:
	                $('#presnatnDateTr').hide();
	                $('#cnfirmUrl01').hide();
	                break;
            }
        });

        var eventTyCd =  "${baseList.eventTyCd}";
        if(eventTyCd == "1001"){
            $('#presnatnDateTr').hide();
            $('#cnfirmUrl01').hide();
        }else if(eventTyCd == "1002"){
            $('#presnatnDateTr').show();
            $('#cnfirmUrl01').show();
        }else if(eventTyCd == "1003"){
            $('#presnatnDateTr').show();
            $('#cnfirmUrl01').show();
        }else{
            $('#presnatnDateTr').hide();
            $('#cnfirmUrl01').hide();
        }

        // 기간,발표일 달력 생성
        if($('#beginDate').val() == ''){
            $('#beginDate').val(getDateStr(new Date()));
        }
        if($('#endDate').val() == ''){
            $('#endDate').val(getDateStr(getCalDate(new Date(),1,0)));
        }
        if($('#presnatnDate').val() == ''){
            $('#presnatnDate').val(getDateStr(getCalDate(new Date(),1,10)));
        }

        $("span#eventPeriod  a  button.gray").click(function(){
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
            if($('#presnatnDate').val() == ''){
                $('#presnatnDate').val(getDateStr(new Date()));
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
        $('#presnatnDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });


        $("#dataForm").validate({
            rules: {
                 
                 eventTitle :        { required:true },
                 eventTyCd :         { required:true },
                 domainCd :         { required:true },
                 beginDate :      { required:true, minlength:8, maxlength:10},
                 endDate :        { required:true, minlength:8, maxlength:10},
                 presnatnHm:      { required:true},
                 eventCn :        { required:true},
                 eventFilePath :        { required:true},
                 imageAlt :        { required:true}
            },
            submitHandler : function(form) {
                if($("#beginDate").val().length == 10){
                    $("#beginDate").val($("#beginDate").val().replace(/-/gi,""));
                };
                if($("#endDate").val().length == 10){
                    $("#endDate").val($("#endDate").val().replace(/-/gi,""));
                };
                if($("#presnatnDate").val().length == 10){
                    $("#presnatnDate").val($("#presnatnDate").val().replace(/-/gi,""));
                };
                if($("#beginDate").val() > $("#endDate").val() || $("#beginDate").val().replace(/-/gi,"") > $("#endDate").val().replace(/-/gi,"")){
                    jsWarningBox("시작일이 종료일보다 뒤에 날짜로 올수 없습니다.");
                    $("#beginDate").focus();
                    return false;
                };
                if($("#presnatnHm").val().length == 5){
                    $("#presnatnHm").val($("#presnatnHm").val().replace(/:/gi,""));
                };

                var mType = $("#eventTyCd option:selected").val();
                if(mType == "1002" || mType == "1003"){
                    if($("#endDate").val() >= $("#presnatnDate").val() || $("#endDate").val().replace(/-/gi,"") > $("#presnatnDate").val().replace(/-/gi,"")){
                        jsWarningBox("발표일이 종료일보다 같거나 앞에 날짜로 올수 없습니다.");
                        $("#presnatnDate").focus();
                        return false;
                    };
                 }
                
                var domainCd = $("#domainCd option:selected").val();
                var eventLcSeCds = '';
                $('input[name="eventLcSeCds"]:checked').each(function (i) {
                    eventLcSeCds += ',' + $(this).val();                    
                });
                if(eventLcSeCds == ''){
                    jsWarningBox("한개 이상의 메뉴구분을 선택해주세요.");
                    return false;
                }
                if(CKEDITOR.instances.eventCn.getData() == ''){
                    jsWarningBox("내용을 입력해주세요.");
                    $("#eventCn").focus();
                    return false;
                }else{
                    $("#eventCn").val(CKEDITOR.instances.eventCn.getData());    
                }
                
                $(form).ajaxSubmit({
                    url : "ND_insertAction.do",
                    type : "POST",
                    dataType : "text",
                    data : {
                            domainCd : domainCd,
                            eventLcSeCds1 : eventLcSeCds.substring(1)
                           },
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
        
        urlChange();
        
        //당첨자url
        var przwnerCnfirmUrl = "${baseList.przwnerCnfirmUrl}";
        var url = przwnerCnfirmUrl.split("bbscttSeq=");
        $("#przwnerCnfirmUrl").val(url[1]);
    }); //ready end

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

    var jsHide = function(el, vl){
        if(confirm("이미지를 삭제 하시겠습니까?")){

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
        if($("#presnatnDate").val().length == 10){
            $("#presnatnDate").val($("#presnatnDate").val().replace(/-/gi,""));

        };
        
        if($("#beginDate").val() > $("#endDate").val() || $("#beginDate").val().replace(/-/gi,"") > $("#endDate").val().replace(/-/gi,"")){
            jsWarningBox("시작일이 종료일보다 뒤에 날짜로 올수 없습니다.");
            $("#beginDate").focus();
            return false;
        };
        
        var mType = $("#eventTyCd option:selected").val();
        if($("#presnatnHm").val().length == 5){
            $("#presnatnHm").val($("#presnatnHm").val().replace(/:/gi,""));
        }else{
          if(mType == "1002" || mType == "1003"){
            jsWarningBox("발표시간을 입력해주세요.");
            return false;
          } 
        }
        
        if(mType == "1002" || mType == "1003"){
            if($("#endDate").val() >= $("#presnatnDate").val() || $("#endDate").val().replace(/-/gi,"") > $("#presnatnDate").val().replace(/-/gi,"")){
                jsWarningBox("발표일이 종료일보다 같거나 앞에 날짜로 올수 없습니다.");
                $("#presnatnDate").focus();
                return false;
            };
         }
        
        var domainCd = $("#domainCd option:selected").val();
        if(domainCd == ''){
            jsWarningBox("사이트를 선택해주세요.");
            return false;
        }
        
        var eventLcSeCds = '';
        $('input[name="eventLcSeCds"]:checked').each(function (i) {
            eventLcSeCds += ',' + $(this).val();                    
        });
        if(eventLcSeCds == ''){
            jsWarningBox("한개 이상의 메뉴구분을 선택해주세요.");
            return false;
        }
        if(CKEDITOR.instances.eventCn.getData() == ''){
            jsWarningBox("내용을 입력해주세요.");
            $("#eventCn").focus();
            return false;
        }else{
            $("#eventCn").val(CKEDITOR.instances.eventCn.getData());    
        }
        //이전소스
        //var przwnerCnfirmUrl = $("#cnfirmurl02").text().split("ceart.kr");
        
        //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
       	// 변경소스
        var przwnerCnfirmUrl = $("#cnfirmurl02").text().split('<%=GlobalConfig.DOMAIN_MAINNM %>');
      	//}}
        $("#przwnerCnfirmUrl").val(przwnerCnfirmUrl[1].trim()+$("#przwnerCnfirmUrl").val());

        $("#dataForm").ajaxSubmit({
            url      : "ND_updateAction.do",
            type     : "POST",
            dataType : "text",
            data     : { 
                domainCd : domainCd,
                eventLcSeCds1 : eventLcSeCds.substring(1)
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
    
    var urlChange = function(){
        var domainCd = $("#domainCd option:selected").val();
        $("#cnfirmUrl").empty();
        var html="";
        var langNm="";
        
        switch(domainCd){
	        case '2' : langNm ="korean"  ; break;
	        case '3' : langNm ="english"  ; break;
	        case '4' : langNm ="spanish"  ; break;
        }
        
        html += "<div id='cnfirmurl02'>";
        //이전소스
        // html += "http://"+langNm+".ceart.kr/web/board/BD_board.view.do?domainCd="+domainCd+"&bbsCd=1001&bbscttSeq=";
        
        //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
        // 변경소스
        html += "http://<%=GlobalConfig.DOMAIN_SUBNM %>/web/board/BD_board.view.do?domainCd="+domainCd+"&bbsCd=1001&bbscttSeq=";
        //}}
        html += " <input type='text' id='przwnerCnfirmUrl' class='w85_p' style='width: 200px;' name='przwnerCnfirmUrl' title='URL을 입력해주세요' value='${baseList.przwnerCnfirmUrl}' />";
        html += "</div>";
        html += "<font style='color: blue;'>* [게시판관리 > 게시물관리 > 공지사항] 목록에서 게시물 번호(코드) 확인가능</font> ";
        
        $("#cnfirmUrl").append(html);
    };
    
</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
    <div id="contents">
        <form id="dataForm" enctype="multipart/form-data" method="post">
        <input type="hidden" id="flag" name="flag" value="" />        
        <input type="hidden" id="eventSn" name="eventSn" value="${baseList.eventSn}" />
        <input type="hidden" id="eventThumbFileSeq" name="eventThumbFileSeq" value="${baseList.eventThumbFileSeq}" />
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
                        <th><label for="eventTitle">제목<span class="tx_red tx_b">*</span></label></th>
                        <td><input type="text" id="eventTitle" class="w85_p" name="eventTitle" title="제목을 입력해주세요" value="<c:out value="${baseList.eventTitle}" />" /></td>
                    </tr>
                    <tr>
                        <th><label for="eventTyCd">이벤트구분<span class="tx_red tx_b">*</span></label></th>
                        <td id="area">
                            <op:code id="eventTyCd" grpCd="1006" defaultValues="${baseList.eventTyCd}" type="select" defaultLabel="이벤트구분선택" />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="part">사이트<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <p class="mar_t5" id="domainCheck">
                                <select id="domainCd" title="사이트를 선택해주세요" name="domainCd" onchange="urlChange();">
	                                <option value="">사이트선택</option>
	                                <c:forEach items="${dataVo}" var="_bean" varStatus="status">
	                                    <option value="${_bean.domainCd}" <c:if test="${not empty _bean.checkYn}">selected="selected"</c:if>>${_bean.domainDc}</option>
	                                </c:forEach>
                                </select>
                            </p>
                        </td>
                    </tr>
                    <tr>
                         <th><label for="eventLcSeCd">메뉴구분<span class="tx_red tx_b">*</span></label></th>
                         <td>
                            <p class="mar_t5" id="eventLcSeCheck">
                                <c:forEach items="${dataVo1}" var="_bean" varStatus="status">
                                    <input type="checkbox" name="eventLcSeCds" id="eventLcSeCd_${_bean.eventLcSeCd}"<c:if test="${not empty _bean.checkYn}"> checked="checked"</c:if> value="${_bean.eventLcSeCd}"/> ${_bean.eventLcSeNm}&nbsp;
                                </c:forEach>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="sub">기간<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <input class="w120" type="text" name="beginDate" id="beginDate" title="날짜선택"<c:if test="${not empty baseList.beginDate}"> value="${fn:substring(baseList.beginDate,0,4)}-${fn:substring(baseList.beginDate,4,6)}-${fn:substring(baseList.beginDate,6,8)}"</c:if>/> ~
                            <input class="w120" type="text" name="endDate" id="endDate" title="날짜선택"<c:if test="${not empty baseList.endDate}"> value="${fn:substring(baseList.endDate,0,4)}-${fn:substring(baseList.endDate,4,6)}-${fn:substring(baseList.endDate,6,8)}"</c:if>/>
                            <span class="mar_l10" id="eventPeriod">
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
                    <tr id="presnatnDateTr">
                        <th><label for="presnatnDate">발표일<span class="tx_red tx_b"></span></label></th>
                        <td>
                            <input class="w120" type="text" name="presnatnDate" id="presnatnDate" title="발표일을 입력해주세요"<c:if test="${not empty baseList.presnatnDate}"> value="${fn:substring(baseList.presnatnDate,0,4)}-${fn:substring(baseList.presnatnDate,4,6)}-${fn:substring(baseList.presnatnDate,6,8)}"</c:if>/>
                            <input style="width:40px" type="text" id="presnatnHm" name="presnatnHm" title="발표시간을 입력해주세요" value="${baseList.presnatnHm}" />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="eventCn">내용<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <textarea id="eventCn" name="eventCn"  rows="6" class="w99_p"><c:out value="${baseList.eventCn}" /></textarea>
                            <script type="text/javascript">
                            //<![CDATA[
                            CKEDITOR.replace('eventCn', {
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
                    </tr>
                    <tr>
                        <th><label for="linkUrl">링크URL</label></th>
                        <td><input type="text" id="linkUrl" class="w85_p" name="linkUrl" title="URL을 입력해주세요" value="${baseList.linkUrl}" /></td>
                    </tr>
                    <tr id="cnfirmUrl01">
                        <th><label for="przwnerCnfirmUrl">당첨자 확인 URL</label></th>
                        <td id="cnfirmUrl">
                        <div>
                            <input type="text" id="przwnerCnfirmUrl" class="w85_p" name="przwnerCnfirmUrl" title="URL을 입력해주세요" style="width: 200px;" value="${baseList.przwnerCnfirmUrl}" />
                        </div>
                            <font style="color: blue;">* [게시판관리 > 게시물관리 > 공지사항] 목록에서 게시물 번호(코드) 확인가능</font>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="eventFilePath">이미지파일<span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <p class="mar_t5 mar_b5"><input type="file" id="eventFilePath" size="100px" class="w470 multi" name="eventFilePath" accept="gif|jpg|jpeg" /></p>
                            <ul id="oh">
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="imageAlt">이미지 ALT명<span class="tx_red tx_b">*</span></label></th>
                        <td><input type="text" id="imageAlt" class="w85_p" name="imageAlt" title="이미지 alt를 입력해주세요" value="${baseList.imageAlt}"/></td>
                    </tr>
                    <tr>
                        <th><label for="enfrcClosAt">강제마감</label></th>
                        <td>
                            <input type="radio" name="enfrcClosAt" id="enfrcClosAt_N" value="N"<c:if test="${baseList.enfrcClosAt eq 'N' || empty baseList.enfrcClosAt}"> checked="checked"</c:if> />
                            <label for="radio">진행중</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="enfrcClosAt" id="enfrcClosAt_Y" value="Y"<c:if test="${baseList.enfrcClosAt eq 'Y'}"> checked="checked"</c:if> />
                            <label for="radio1">마감</label>
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
                <c:if test="${not empty baseList.eventSn}">
                    <c:if test="${(MenuAssignType eq 'A' && baseList.registId eq __msk.mgrId) or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
                        <li><a href="#" onclick="jsUpdate();"><button class="blue" type="button">저장</button></a></li>
                    </c:if>
                </c:if>
                <li><a href="#"  onclick="jsList();"><button class="blue" type="button">목록</button></a></li>
            </ul>
        </div>
        <!-- //버튼 -->
    
        </form>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>