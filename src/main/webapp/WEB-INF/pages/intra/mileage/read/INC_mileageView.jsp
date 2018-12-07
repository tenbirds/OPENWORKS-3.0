<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

        <script type="text/javascript" src="/resources/intra/js/user.pwdConfirm.js"></script>
		<script type="text/javascript">
		$().ready(function() {
	        $(".mo_why").hide();
		});
		
	    // 적립사유 상세설명 레이어
	    var reasonLayerYn = 'N';
	    var idNum = '';
	    
	    var reasonLayer = function(argIdNum){
	        if(argIdNum == idNum && reasonLayerYn == "Y"){
	            $("#mo_why_"+argIdNum).hide();
	            reasonLayerYn = "N";
	        }else{
	               $("#mo_why_"+idNum).hide();
	            $("#mo_why_"+argIdNum).show();
	            idNum = argIdNum;
	            reasonLayerYn = "Y";
	        }
	    }; 
	    
	    var jsMovePage = function(page) {
	        var p = 1;
	        if (page == 'page') {
	            p = $('input[name=page]').val();
	        } else {
	            p = page;
	        }
	        $("#q_currPage").val(p);
	        $("#pagingForm").action= "PD_mileageView.do";
	        $("#pagingForm").submit();
	    };
		
	    </script>

            <!-- 마일리지이력 -->
            <h2 class="float_l">마일리지이력</h2>
            <span class="float_r">
                <button class="blue" type="button" onclick="pwdConfirm(this, '마일리지 엑셀 출력', 'O', '/intra/mileage/read/INC_mileageViewExcel.do', '900', '700', '${dataVo.userId}', '∬userId=${dataVo.userId}', '리스트' );">엑셀출력</button>
            </span>
            <div class="mar_b20">
            <table class="boardWrite" cellspacing="0" border="0" summary="마일리지 정보조회">
                <caption class="hidden"> 마일리지 이력 </caption>
                <colgroup>
                    <col width="25%" />    
                    <col width="25%" />
                    <col width="25%" />
                    <col width="25%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th rowspan="2">총 마일리지</th>
                        <td rowspan="2" class="tx_red_s"><fmt:formatNumber value="${dataVo.lastMileageAmount}" type="number" />점</td>
                        <th>소멸예정 마일리지(1개월내)</th>
                        <td class="tx_red_s"><fmt:formatNumber value="${dataVo.mmRemoveMileage}" type="number" />점</td>
                    </tr>
                    <!-- <tr>
                        <th>정기 소멸예정 마일리지</th>
                        <td>100점</td>
                    </tr> -->
                </tbody>
            </table>
            </div>
            <p class="tx_r mar_b30">※ 정기 소멸예정은 마일리지 항목설정의 유효기간 설정에서 확인하실 수 있습니다.</p>
            <form id="pagingForm" name="pagingForm" method="post">
            <op:pagerParam title="마일리지 이력 목록"/>
            </form>
            <input type="hidden" id="reasonLayerYn" value="N"/>
                <!-- 리스트 -->
                <table class="boardList" cellspacing="0" border="0" summary="마일리지 조회 리스트입니다.">
                    <caption class="hidden"> 목록 </caption>
                    <colgroup>
                        <col width="5%" />
                        <col width="" />
<%--                         <col width="18%" /> --%>
                        <col width="8%" />
                        <col width="6%" />
                        <col width="12%" />
                        <col width="13%" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>마일리지명</th>
<!--                             <th>마일리지타입</th> -->
                            <th>점수</th>
                            <th>구분</th>
                            <th>적립일자</th>
                            <th class="lr_none">적립사유</th>
                        </tr>
                    </thead>
                    <tbody id="odd-color">
                        <c:set var="index" value="${pager.indexNo}"/>
                        <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                            <tr>
                                <td>${index-status.index}</td>
                                <td>${_bean.mileageNm}</td>
<!--                                 <td></td> -->
                                <td class="tx_r">
                                    <c:if test="${_bean.accuType eq 'S'}">-</c:if><fmt:formatNumber value="${_bean.mileagePoint}" type="number" />
                                </td>
                                <td>
                                    <c:if test="${_bean.accuType eq 'A'}">적립</c:if>
                                    <c:if test="${_bean.accuType eq 'S'}">차감</c:if>
                                </td>
                                <td>
                                    <fmt:parseDate pattern="yyyyMMdd" value="${_bean.accuDt}" var="accuDt" /><fmt:formatDate value="${accuDt}" pattern="yyyy-MM-dd" />
                                </td>
                                <td class="lr_none po_rel">
                                    <div style="z-index: 2; text-align: center;">
                                        <a href="#" onclick="reasonLayer('${index-status.index}'); return false;">[ 보 기 ]</a>
                                        <!-- 적립사유 레이어 -->
                                        <div id="mo_why_${index-status.index}" class="mo_why" onclick="reasonLayer('${index-status.index}'); return false;">
                                            <h5>사유</h5>
                                            <pre><c:out value="${_bean.accuReason}" default="-" /></pre>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty pager.list}">
                            <op:no-data obj="${pager}" colspan="7" />
                        </c:if>
                    </tbody>
                </table>
                <!-- //리스트 -->
                <!-- 페이징 -->
                <op:pager pager="${pager}" />
                <!-- //페이징 -->
