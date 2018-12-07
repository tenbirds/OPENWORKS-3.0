<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>휴일등록</title>
    <op:jsTag type="spi" items="validate,ui,form"/>
    <script type="text/javascript">

    $().ready(function () {
        var repeatVal = $('input[name="repeatYearYn"]:checked').val();
        if(repeatVal == 'M'){
            $('#repeatMonthText').show();
            $('#repeatMonth').hide();
        }else{
            $('#repeatMonthText').hide();
        }
        $("#insert").bind("click", function () {
            mode = 'insert';
        });
        $("#reInsert").bind("click", function () {
            mode = 'reInsert';
        });
        $("#repeatYearM").bind("click", function () {
            $('#repeatMonthText').show();
            $('#repeatMonth').hide();
        });
        $("#repeatYearN").bind("click", function () {
            $('#repeatMonthText').hide();
            $('#repeatMonth').show();
        });
        $("#repeatYearY").bind("click", function () {
            $('#repeatMonthText').hide();
            $('#repeatMonth').show();
        });



        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#startDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $("#dataForm").validate({
            rules: {
                 /* domainCd:   { required:true }, */
                  title :        { required:true },
                 startDt :      { required:true, minlength:8, maxlength:10},
                 endDt :        { required:true, minlength:8, maxlength:10}
            },
            submitHandler : function(form) {
                if($('input[name="repeatYearYn"]:checked').val() == 'M'){
                    $("#endDt").val($("#startDt").val());
                }
                if($("#startDt").val().length == 10){
                    $("#startDt").val($("#startDt").val().replace(/-/gi,""));
                }
                if($("#endDt").val().length == 10){
                    $("#endDt").val($("#endDt").val().replace(/-/gi,""));

                }
                if($("#startDt").val() > $("#endDt").val() || $("#startDt").val().replace(/-/gi,"") > $("#endDt").val().replace(/-/gi,"")){
                    alert("시작일이 종료일보다 뒤에 날짜로 올수 없습니다.");
                    $("#startDt").focus();
                    return false;
                }

                if($("#seq").val() != ""){
                    _url = "ND_updateAction.do";
                }else{
                    _url = "ND_insertAction.do";
                }
                $(form).ajaxSubmit({
                    url : _url,
                    type : "POST",
                    success : function(response) {
                        try {
                            if(eval(response)) {
                                var message = Message.msg.insertOk;
                                if($("#seq").val() != ""){
                                    message = Message.msg.updateOk;
                                }

                                jsSuccessBox(message);
                                if(mode == 'reInsert'){
                                    document.dataForm.reset();
                                }else{
                                    parent.location.reload();
                                }
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

    var mode = "";

   var jsDelete = function(el,vl,zl){
       if ( confirm("삭제 하시겠습니까?") ) {
           $.post("ND_deleteAction.do", {
               seq : zl,
               gbn : vl
               }, function(response) {
                   try {
                       if(eval(response)) {
                           jsSuccessBox(Message.msg.deleteOk);
                           parent.location.reload();
                       } else {
                           jsErrorBox(Message.msg.processFail);
                       }
                   } catch (e) {
                       jsSysErrorBox(response, e);
                       return;
                   }
               }
           );
       }
   };

    </script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <div id="popup" style="width:550px;">
        <form name="dataForm"id="dataForm">
        <input type="hidden" id="seq" name="seq" value="${baseVo.seq}"/>
        <input type="hidden" id="gbn" name="gbn" value="${baseVo.gbn}"/>
        <!-- 기본정보 -->
        <h2 class="mar_t20">휴일등록</h2>

        <fieldset>
        <legend>휴일등록</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="휴일등록을 하실 수 있습니다.">
            <caption class="hidden"> 휴일등록 </caption>
            <colgroup>
                <col width="20%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><span class="tx_red_s">*</span> <label for="sub">휴일명</label></th>
                    <td><input type="text" id="title" class="w60_p" name="title" value="${baseVo.title }" /></td>
                </tr>
                <tr>
                    <th><span class="tx_red_s">*</span> <label for="day">구분</label></th>
                    <td>
                          <input type="radio" name="holidayYn" id="holidayY" value="Y" <c:if test="${empty baseVo.gbn or baseVo.gbn eq 'B'}">checked="checked"</c:if> <c:if test="${not empty baseVo.gbn}">disabled="disabled"</c:if> />
		                  <label for="radio">법정공휴일</label>
		                  &nbsp;&nbsp;&nbsp;
		                  <input type="radio" name="holidayYn" id="holidayN" value="N" <c:if test="${baseVo.gbn eq 'A'}">checked="checked" disabled="disabled"</c:if> <c:if test="${not empty baseVo.gbn}">disabled="disabled"</c:if>/>
		                  <label for="radio1">임시공휴일</label>
                    </td>
                </tr>
                <tr>
                    <th><label for="day">반복여부</label></th>
                        <td>
                            <input type="radio" name="repeatYearYn" id="repeatYearN" value="" <c:if test="${baseVo.repeatYearYn eq '' or empty baseVo.repeatYearYn}">checked="checked"</c:if>/>
                            <label for="radio1">반복없음</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="repeatYearYn" id="repeatYearY" value="Y" <c:if test="${baseVo.repeatYearYn eq 'Y' }">checked="checked"</c:if>/>
                            <label for="radio">매년</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="repeatYearYn" id="repeatYearM" value="M" <c:if test="${baseVo.repeatYearYn eq 'M' }">checked="checked"</c:if>/>
                            <label for="radio1">매월</label>&nbsp;&nbsp;&nbsp;
                        </td>
                </tr>
                <tr>
                    <th><span class="tx_red_s">*</span> <label for="day">날짜</label></th>
                    <td>
                        <input class="w120" type="text" <c:if test="${not empty baseVo.startDt }">value="${fn:substring(baseVo.startDt,0,4)}-${fn:substring(baseVo.startDt,4,6)}-${fn:substring(baseVo.startDt,6,8)}"</c:if> <c:if test="${not empty param.startDt }">value="${param.startDt }"</c:if> id="startDt" name="startDt" title="날짜선택"/>
                        <span id="repeatMonth">~ <input class="w120" type="text" <c:if test="${not empty baseVo.endDt }">value="${fn:substring(baseVo.endDt,0,4)}-${fn:substring(baseVo.endDt,4,6)}-${fn:substring(baseVo.endDt,6,8)}"</c:if> <c:if test="${not empty param.endDt }">value="${param.endDt }"</c:if> id="endDt" name="endDt" title="날짜선택"/></span>
                        <span id="repeatMonthText" class="tx_blue_s">월 반복시에는 하루만 가능합니다.</span>
                     </td>
                </tr>
                <tr>
                    <th><label for="con">휴일등록사유</label></th>
                    <td><textarea id="scheduleContent" name="scheduleContent"  rows="6" class="w99_p">${baseVo.scheduleContent}</textarea></td>
                </tr>
                <c:if test="${not empty baseVo}">
                <tr>
                    <th><label for="regDtm">등록일자</label></th>
                    <td>${baseVo.regDtm}</td>
                </tr>
                <tr>
                    <th><label for="regId">등록자</label></th>
                    <td>${baseVo.regId}</td>
                </tr>
                <tr>
                    <th><label for="modDtm">수정일자</label></th>
                    <td>${baseVo.modDtm}</td>
                </tr>
                <tr>
                    <th><label for="modId">수정자</label></th>
                    <td>${baseVo.modId}</td>
                </tr>
                </c:if>
            </tbody>
        </table>
        </fieldset>
        <!-- //기본정보 -->
        <c:choose>
            <c:when test="${not empty baseVo }">
                <p class="tx_c mar_t20"><a href="#"><button class="blue"  type="submit" id="insert">수정</button></a> <a href="#"><button class="blue" type="button" onclick="jsDelete(this,'${baseVo.gbn}','${baseVo.seq}');">삭제</button></a> <a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a></p>
            </c:when>
            <c:otherwise>
                <p class="tx_c mar_t20"><a href="#"><button class="blue" type="submit" id="insert">등록</button></a> <a href="#"><button class="blue" id="reInsert">등록후 계속</button></a> <a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a></p>
            </c:otherwise>
        </c:choose>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>