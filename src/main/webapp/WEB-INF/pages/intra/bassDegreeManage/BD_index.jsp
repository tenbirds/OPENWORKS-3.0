<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>기본 협약 차수 관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
    $().ready(function () {
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
        $('#bassDegreeStdt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#bassDegreeEnddt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#DegreeEnddt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
		
        $("#dataForm #bassDegree").val($('input[name=bassDegreeTemp]').val());
        $("#dataForm #bassDegreeStdt").val($('input[name=bassDegreeEnddtTemp]').val());
    });//ready end
    var jsMovePage = function(page) {
        if(page!=1){
            $("input[name=q_currPage]").val(page);
        }else{
            $("input[name=q_currPage]").val(1);
        }
        $("#srcForm").submit();

    };
    var jsInsert = function() {
        var bassDegreeStdt = $('input[name=bassDegreeStdt]').val();
        var bassDegreeEnddt = $('input[name=bassDegreeEnddt]').val();
        var bassDegreeEnddtTemp = $('input[name=bassDegreeEnddtTemp]').val();
        if(bassDegreeEnddt == '' || bassDegreeEnddt == null){
            alert("협약 종료일을 입력해주세요.");
            return false;
        }else{
            if(bassDegreeEnddtTemp > bassDegreeStdt){
                alert("협약 시작일을 확인 해주시길 바랍니다.");
                return false;   
            }else if(bassDegreeStdt > bassDegreeEnddt){
                alert("협약 종료일을 확인 해주시길 바랍니다.");
                return false;   
            }else{
                if(confirm("기본협약차수를 추가하시겠습니까?")) {
	                $("#dataForm").attr("action", "BD_degreeInsert.do");
	                $("#dataForm").submit();
                }
            }


        }
    };
    
    
    var check = true;
    var jsUpdate = function(DegreeStdt,UpdateDegree) {
        var bassDegreeEnddt = $('input[name=DegreeEnddt]').val();
        if(check){
            $("#DegreeEnddtTD2").show();
            $("#DegreeEnddtTD1").hide();
            check = false;
        }else{
            if(DegreeStdt > bassDegreeEnddt){
                alert("협약 종료일을 확인 해주시길 바랍니다.");
                return false;   
            }
	        if(bassDegreeEnddt == '' || bassDegreeEnddt == null){
	            alert("협약 종료일을 입력해주세요.");
	            return false;
	        }else{
	            if(confirm("기본협약차수를 수정하시겠습니까?")) {
	                $("#dataForm").attr("action", "BD_degreeUpdate.do?UpdateDegree="+UpdateDegree+"&bassDegreeEnddt="+bassDegreeEnddt);
	                $("#dataForm").submit();
	        	}
	        }
        }
    };
    
    var jsDelete = function(DeleteDegree) {
        if(confirm("기본협약차수를 삭제하시겠습니까?")) {
            $("#dataForm").attr("action", "BD_degreeDelete.do?DeleteDegree="+DeleteDegree);
	        $("#dataForm").submit();
        }
	};

</script>

</head>
<body>
<c:set var="index" value="${pager.indexNo}"/>
    <div id="contents">
        <h4>기본 협약 차수 추가</h4>
        	<form name="dataForm" id="dataForm" method="POST" action="BD_degreeInsert.do">
                    <table class="boardList" summary="추가">
			            <colgroup>
			            	<col width="4%"/>
			                <col width="4%"/>
			                <col width="10%"/>
			                <col width="10%"/>
			            </colgroup>
                         <thead>
			            	<tr>
				                <th>차수</th>
				                <th>협약 시작일</th>
				                <th><span class="tx_red_s">*</span> 협약 종료일</th>
				                <th>기능</th>
			                </tr>
			            </thead>
					   <tbody id="odd-color">
								<td>
									<input type="text" name="bassDegree" style="width:23px;" id="bassDegree" value=""  readonly/>차
								</td>
                                <td>
                                	<input type="text" name="bassDegreeStdt" id="bassDegreeStdt" size="10" maxlength="10" value="" readonly/> 
                                </td>
                                <td>
                                	<input class="w120" type="text" name="bassDegreeEnddt" id="bassDegreeEnddt" title="종료날짜선택" maxlength="10" value="" readonly/>
                                </td>
                                <td>
                                	<button  class="blue" onclick="jsInsert(); return false;" >추 가</button>
                                </td>
                        </tbody>
                    </table>
                    </form>
                    <br /> <br /> <br />
                    
                     <form name="srcForm" id="srcForm" method="GET" action="BD_index.do">
                     
                    <op:pagerParam title="기본 협약 차수 리스트" />
                    <table class="boardList" summary="리스트">
				            <colgroup>
				            	<col width="4%"/>
				                <col width="4%"/>
				                <col width="10%"/>
				                <col width="10%"/>
				                <col width="4%"/>
				            </colgroup>
				            <thead>
				            	<tr>
					                <th>No</th>
					                <th>차수</th>
					                <th>협약 시작일</th>
					                <th>협약 종료일</th>
					                <th>기능</th>
				                </tr>
				            </thead>
				            <tbody id="odd-color">
				                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
				                <tr>	
					                	<td>
					                		<c:out value="${index-status.index}"/>
					                	</td>
							            <td>
							            	<input name="bassDegreeTemp" id="bassDegreeTemp" type="hidden" value="${baseVo.bassDegreeMax}">
							            	${baseVo.bassDegree}차
							            </td>
							            <td>
								            ${baseVo.bassDegreeStdt}
							            </td> 
							            <td>
							            	<!-- 협약 종료일 뷰 -->
							            	<div id ="DegreeEnddtTD1">
								            	<input name="bassDegreeEnddtTemp" id="bassDegreeEnddtTemp" type="hidden" value="${baseVo.bassDegreeEnddtMax}">
							            		${baseVo.bassDegreeEnddt}
							            	</div>
							            	<!-- 협압 종료일 수정 클릭 시 input창 -->	
							            	<div id="DegreeEnddtTD2" style="display: none;">
												<input class="w120" type="text" name="DegreeEnddt" id="DegreeEnddt" title="종료날짜선택" maxlength="10"	value="${baseVo.bassDegreeEnddt}" readonly>
											</div>
										</td>
							            <td>
							            <c:if test="${baseVo.bassDegreeMax -1 eq baseVo.bassDegree}">
							            	<button  class="blue" onclick="jsUpdate('${baseVo.bassDegreeStdt}','${baseVo.bassDegree}'); return false;" >수정</button>
							            </c:if>
							            	<button  class="blue" onclick="jsDelete('${baseVo.bassDegree}'); return false;" >삭 제</button>
							            </td>
				                </tr>
				                </c:forEach> 
				                <op:no-data obj="${pager}" colspan="5" />
				            </tbody>
					</table>
					</form>
                   <!-- 페이징 -->
			        <op:pager pager="${pager}" script="jsMovePage"/>
			        <!-- //페이징 -->
		</div>

     
           
</body>
</html>