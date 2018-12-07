<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>일정등록</title>
    <op:jsTag type="spi" items="validate,ui,form"/>
    <script type="text/javascript">

    $().ready(function () {
        
        $("#insert").bind("click", function () {
            mode = 'insert';
        });
        $("#reInsert").bind("click", function () {
            mode = 'reInsert';
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#start_dt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#end_dt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        
        $("#dataForm").validate({
            rules: {
                 /* domainCd:   { required:true },*/
                 title    :      { required:true, maxlength:100 },
                 start_dt :      { required:true, minlength:8, maxlength:10},
                 end_dt   :      { required:true, minlength:8, maxlength:10},
                 content   :     { maxlength:1000}
            },
            submitHandler : function(form) {

                if($("#start_dt").val() > $("#end_dt").val() || $("#start_dt").val().replace(/-/gi,"") > $("#end_dt").val().replace(/-/gi,"")){
                    alert("시작일이 종료일보다 뒤에 날짜로 올수 없습니다.");
                    $("#start_dt").focus();
                    return false;
                }

                //시작시간 - 시간
                if($("#s_startDt1").val() != "") {
                    if($("#s_startDt1").val() > 12) {
                        alert("00~12시까지의 시간을 입력하십시요.");
                        $("#s_startDt1").focus();
                        return false;
                    }

                    if($("#s_startDt1").val().length != 2) { 
                        $("#s_startDt1").val("0"+$("#s_startDt1").val());
                    }
                }
                //시작시간 - 분
                if($("#e_startDt1").val() != "") {
                    if($("#e_startDt1").val() > 59 ) {
                        alert("00~59분까지의 시간을 입력하십시요.");
                        $("#e_startDt1").focus();
                        return false;
                    } 

                    if($("#e_startDt1").val().length != 2) {
                        $("#e_startDt1").val("0"+$("#e_startDt1").val());
                    }
                }
                //종료시간 - 시간
                if($("#s_startDt2").val() != "") {
                    if($("#s_startDt2").val() > 12) { 
                        alert("00~12시까지의 시간을 입력하십시요.");
                        $("#s_startDt2").focus();
                        return false;
                    }

                    if($("#s_startDt2").val().length != 2) {
                        $("#s_startDt2").val("0"+$("#s_startDt2").val());
                    }
                }
                //시작시간 - 분
                if($("#e_startDt2").val() != "") {
                    if($("#e_startDt2").val() > 59 ) {
                        alert("00~59분까지의 시간을 입력하십시요.");
                        $("#e_startDt2").focus();
                        return false;
                    }

                    if($("#e_startDt2").val().length != 2) {
                        $("#e_startDt2").val("0"+$("#e_startDt2").val());
                    }
                }

                $("#start_time").val($("#s_startDt1").val() + $("#e_startDt1").val());
                $("#end_time").val($("#s_startDt2").val() + $("#e_startDt2").val());

                if($("#plan_seq").val() != ""){
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
                                if($("#plan_seq").val() != ""){
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

   var jsDelete = function(el,vl){
       if ( confirm("삭제 하시겠습니까?") ) {
           $.post("ND_deleteAction.do", {
               plan_seq : vl
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
        <input type="hidden" id="plan_seq" name="plan_seq" value="${baseVo.plan_seq}"/> 
        
        <input type="hidden" id="start_time" name="start_time" value=""/>
        <input type="hidden" id="end_time"   name="end_time"   value=""/>

       
        <!-- 기본정보 -->
        <h2 class="mar_t20">
         <c:choose>
             <c:when test="${empty baseVo }">일정등록</c:when>
             <c:otherwise>일정수정</c:otherwise>
         </c:choose>  
        </h2>

        <fieldset>
        <legend>일정등록</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="일정등록을 하실 수 있습니다.">
            <caption class="hidden"> 일정등록 </caption>
            <colgroup>
                <col width="20%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><span class="tx_red_s">*</span> <label for="sub">제목</label></th>
                    <td><input type="text" id="title" class="w60_p" name="title" value="${baseVo.title }" /></td>
                </tr>
                <tr>
                    <th><span class="tx_red_s">*</span> <label for="day">날짜</label></th>
                    <td>
                        <input class="w120" type="text" 
                            <c:if test="${not empty baseVo.start_dt }">value="${baseVo.start_dt}"</c:if> 
                            <c:if test="${not empty param.start_dt }">value="${param.start_dt}"</c:if> 
                            id="start_dt" name="start_dt" title="날짜선택"/>
                     
                        <span id="repeatMonth">~</span>
                        <input class="w120" type="text" 
                            <c:if test="${not empty baseVo.end_dt }">value="${baseVo.end_dt}"</c:if> 
                            <c:if test="${not empty param.end_dt }">value="${param.end_dt}"</c:if> 
                            id="end_dt" name="end_dt" title="날짜선택"/>
                        
                     </td>
                </tr>                
                <tr>
                    <th><label for="시작시간">시작시간</label></th>
                    <td>
                          <input type="radio" name="s_time_gb" id="s_time_a" value="A"   <c:if test="${empty baseVo.s_time_gb or baseVo.s_time_gb eq 'A' or param.s_time_gb eq 'A'}">checked="checked"</c:if> />
                          <label for="radio">오전</label>
                        
                          <input type="radio" name="s_time_gb" id="s_time_p" value="P" <c:if test="${baseVo.s_time_gb eq 'P' or param.s_time_gb eq 'P'}">checked="checked" </c:if> />
                          <label for="radio">오후</label>
                          
                          <input class="w15" type="text" 
                                   <c:if test="${not empty baseVo.start_time }">value="${fn:substring(baseVo.start_time,0,2)}"</c:if>
                                   <c:if test="${not empty param.start_time }">value="${fn:substring(param.start_time,0,2)}"</c:if>
                                   id="s_startDt1" name="s_startDt1" maxlength="2"/>
                          &nbsp;시&nbsp;
                          <input class="w15" type="text" 
                                 <c:if test="${not empty baseVo.start_time }">value="${fn:substring(baseVo.start_time,2,4)}"</c:if>
                                 <c:if test="${not empty param.start_time }">value="00"</c:if>  
                                 id="e_startDt1" name="e_startDt1" maxlength="2"/>
                          &nbsp;분&nbsp;(예: 07시30분)
                    </td>
                </tr>                
                 <tr>
                    <th><label for="종료시간">종료시간</label></th>
                    <td>    
                          <input type="radio" name="e_time_gb" id="s_time_a" value="A" <c:if test="${empty baseVo.e_time_gb or baseVo.e_time_gb eq 'A' or param.s_time_gb eq 'A'}">checked="checked"</c:if> />
                          <label for="radio">오전</label>                        
                          <input type="radio" name="e_time_gb" id="s_time_p" value="P" <c:if test="${baseVo.e_time_gb eq 'P' or param.s_time_gb eq 'P'}">checked="checked" </c:if> />
                          <label for="radio">오후</label>
                                   
                          <input class="w15" type="text" 
                                  <c:if test="${not empty baseVo.end_time }">value="${fn:substring(baseVo.end_time,0,2)}"</c:if> 
                                  id="s_startDt2" name="s_startDt2" maxlength="2"/>
                          &nbsp;시&nbsp;
                          <input class="w15" type="text" 
                                  <c:if test="${not empty baseVo.end_time }">value="${fn:substring(baseVo.end_time,2,4)}"</c:if> 
                                  id="e_startDt2" name="e_startDt2" maxlength="2" />
                          &nbsp;분&nbsp;(예: 07시30분)
                    </td>
                </tr>
           
                
                <tr>
                    <th><label for="con">일정내용</label></th>
                    <td><textarea id="content" name="content"  rows="6" class="w99_p">${baseVo.content}</textarea></td>
                </tr>
               
            <c:if test="${not empty baseVo}">
                <tr>
                    <th><label for="reg_dt">등록일자</label></th>
                    <td>${baseVo.reg_dt}</td>
                </tr>
                <tr>
                    <th><label for="reg_id">등록자</label></th>
                    <td>${baseVo.reg_id}</td>
                </tr>
                <tr>
                    <th><label for="modi_dt">수정일자</label></th>
                    <td>${baseVo.modi_dt}</td>
                </tr>
                <tr>
                    <th><label for="modi_id">수정자</label></th>
                    <td>${baseVo.modi_id}</td>
                </tr>
                </c:if>
                
                
            </tbody>
        </table>
        </fieldset>
        <!-- //기본정보 -->
        <c:choose>
            <c:when test="${not empty baseVo }">
                <p class="tx_c mar_t20">
                    <a href="#"><button class="blue"  type="submit" id="insert">수정</button></a> 
                    <a href="#"><button class="blue" type="button" onclick="jsDelete(this,'${baseVo.plan_seq}');">삭제</button></a> 
                    <a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a></p>
            </c:when>
            <c:otherwise>
                <p class="tx_c mar_t20">
                    <a href="#"><button class="blue" type="submit" id="insert">등록</button></a> 
                    <a href="#"><button class="blue" id="reInsert">등록후 계속</button></a> 
                    <a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
               </p>
            </c:otherwise>
        </c:choose>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>