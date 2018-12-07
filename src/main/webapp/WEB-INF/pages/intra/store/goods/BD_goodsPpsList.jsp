<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>조달청 서비스정보 리스트</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
    $().ready(function () {
        $("#dataForm").validate({
            rules: {
                q_beginDate : { dateISO: true, date: true },
                q_endDate : { dateISO: true, date: true },
            },
            messages: {
                q_beginDate : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                  date: "시작날짜가 형식에 맞지 않습니다."},
                q_endDate   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
                                  date: "종료날짜가 형식에 맞지 않습니다."},
            },

            submitHandler : function(form) {

                if ($("#q_beginDate").val()=='' &&  $("#q_endDate").val()!='') {
                    alert("시작날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate").val()!='' &&  $("#q_endDate").val()=='') {
                    alert("종료날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate").val() > $("#q_endDate").val()) {
                    alert("종료날짜가 시작날짜 보다 작습니다.");
                    return false;
                }

                form.submit();
            }
        });

 
        $("span#registPeriod  a  button.gray").click(function(){
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;

            if ($("#q_endDate").val()==''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
            if (! $("#q_endDate").dateValidator()) {
                alert("종료날짜가 형식에 맞지 않습니다.");
                return false;
            }
            
            switch(sType){
                case '0' :
                    q_beginDate = new Date();
                    $('#q_beginDate').val(getDateStr(q_beginDate));
                    q_endDate = new Date();
                    $('#q_endDate').val(getDateStr(q_endDate));
                    break;
                case '7D':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),0,-7);
                    break;
                case '1M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-1,0);
                    break;
                case '3M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-3,0);
                    break;
                default:
                    $("#q_beginDate").val("2000-01-01");
                    $("#q_endDate").val("2100-12-31");
                    break;
            }
            $('#q_beginDate').val(getDateStr(q_beginDate));

        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
 
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

        $("#q_beginDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });

        $("#q_endDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
        
        
        $("input[name=chk-all]").click(function() {
            var isChecked = this.checked;
            $("input[name=index]").each(function() {
                this.checked = isChecked;
            });
        });
        
    });//ready end
	
    /*  기능별 스크립트 정의 */

    var getCalDate = function(date, months, days){
        var newDate = date;
        if(typeof(date.getDate) != 'function'){
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;

    };

    var getDateStr = function(date){
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl){
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };

    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };

    var jsSearch = function(){
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
        $("#dataForm").attr("action", "BD_goodsPpsList.do");
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_itemName").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");

    };
      
    var jsDspy = function() {
  
        var url = "ND_goodsCdUpdateAction.do";
        var indexs = new Array();
        var cntrNums = new Array();
        var lineNums = new Array();
        var goodsCodes = new Array();
        var nullCount = 0;
        
       $("input[name=index]:checked").each(function (i) {
         
           var goodsCddNewTrim = new String($.trim($("#goodsCode" + this.value).val()));
           var goodsCdOldTrim = new String($.trim($("#goodsCdOld" + this.value).val()));
       
	        if (goodsCddNewTrim =='' && goodsCdOldTrim != '') {    
	
	            goodsCddNewTrim = "ISNULL";          
	        }
	 
	        if (goodsCddNewTrim =='' && goodsCdOldTrim == '') {    
 
                value="${baseVo.goodsCode}"              
            	nullCount++;          
            }
 
            indexs[i] = $(this).val();
            cntrNums[i] = $("#cntrNum" + this.value).val();
            lineNums[i] = $("#lineNum" + this.value).val();
            goodsCodes[i] = goodsCddNewTrim;
      	                   	           
        });

        
 		if(indexs.length == 0){
            
            jsWarningBox("대상 항목을 1개 이상 선택하세요.");          
            return false;
          
 		} else if(nullCount > 0){
            
            jsWarningBox("대상 항목의 서비스코드를 입력하세요");          
            return false;
          
 		} else {
            
            if(confirm("선택한 " + indexs.length + "개의 서비스코드를 저장 하시겠습니까?")){
                
           		jQuery.ajaxSettings.traditional = true;
  
                $.ajax({
                    url     : "ND_goodsCdUpdateAction.do",
                    type    : "POST",
                    data : { cntrNums : cntrNums, lineNums : lineNums, goodsCodes : goodsCodes },
 
                    success : function(result) {
                       
                        if(result.result) {
                            jsSuccessBox(Message.msg.insertOk);
                            self.location.reload();
                        } else {
                            if (result.message != "") {
                                alert("실패");
                                jsWarningBox(result.message);
                            } else {
                                jsWarningBox(Message.msg.processFail);
                            }
                        }
                    }
              	});
          	}
       	 }
    };

</script>

</head>
<body>
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_goodsPpsList.do">
            <input type="hidden" name="q_init" 	  id="q_init" 	 value="${param.q_init}"/>
 
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                            <tr>
                                <th>등록일</th>
                                <td colspan="3">
                                    <input class="w120" type="text" name="q_beginDate" id="q_beginDate" title="시작날짜선택" maxlength="10" style="ime-mode:disabled;"<c:if test="${not empty param.q_beginDate}"> value="${param.q_beginDate}"</c:if>/> ~
                                    <input class="w120" type="text" name="q_endDate" id="q_endDate" title="종료날짜선택" maxlength="10"<c:if test="${not empty param.q_endDate}"> value="${param.q_endDate}"</c:if>/>
                                    <span class="mar_l10" id="registPeriod">
                                        <a href="javascript:;"><button type="button" id="0"   class="gray">오늘</button></a>
                                        <a href="javascript:;"><button type="button" id="7D"   class="gray">일주일</button></a>
                                        <a href="javascript:;"><button type="button" id="1M"   class="gray">1개월</button></a>
                                        <a href="javascript:;"><button type="button" id="3M"   class="gray">3개월</button></a>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>규격명</th>
                                <td colspan="3">
                                    <input type="text" name="q_itemName" id="q_itemName" value="${param.q_itemName}" class="w215" title="검색어를 입력하세요." />
                                </td>

                             </tr>
                        </tbody>
                    </table>
                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;

                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>

                </fieldset>
            </div>

            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="서비스 전체 목록" />

        <!-- //검색 -->

        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="3%"/>
                <col width="4%"/>
                <col width="12%"/>
                <col width="6%"/>
                <col width="36%"/>
                <col />
                <col width="15%"/>
                <col width="13%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                    <th>순번</th>
                    <th>계약번호</th>
                    <th>물품</br>일련번호</th>
                    <th>규격명</th>
                    <th>금액</th>
                    <th>제조사명</th>
                    <th>클라우드</br>서비스코드</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
 						
                       <td><input type="checkbox" name=index id=index value="${index-status.index}" />
    						<input type="hidden" name="cntrNum" id="cntrNum${index-status.index}"  value="${baseVo.cntrNum}"/>
    						<input type="hidden" name="lineNum" id="lineNum${index-status.index}"  value="${baseVo.lineNum}"/></td>
                        <td>${index-status.index}</td>                        
                        <td>${baseVo.cntrNum}</td>
                        <td>${baseVo.lineNum}</td>
                        <td>${baseVo.itemName}</td>
                        <td><fmt:formatNumber value="${baseVo.unitPric}" type="NUMBER" groupingUsed="true"/></td> 
                        <td>${baseVo.manuName}</td>
    					<td><input type="text" name="goodsCode" id="goodsCode${index-status.index}" class="w_92p" maxlength=12 value="${baseVo.goodsCode}" />
    						<input type="hidden" name="goodsCdOld" id="goodsCdOld${index-status.index}" class="w_92p" maxlength=12 value="${baseVo.goodsCode}" />
    					</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="8" />
            </tbody>
        </table>

        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

       <!-- 버튼 -->
        <div>
            <div class="float_l">
                <a href="javascript:;" onclick="jsDspy(this);"><button class="w_blue" type="button">저장</button></a>
            </div>
        </div>
        <!--  //버튼 -->
        
    </form>
    </div>    
           
</body>
</html>