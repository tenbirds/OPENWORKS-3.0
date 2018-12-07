<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!-- title-area -->

<c:if test="${boardConfVo.bbsCd ne 1002}">
<%-- <h2 id="menuNm">${boardConfVo.bbsNm}</h2> --%>
	<!-- sorting -->
	<div class="sech_form">
		<div class="cont_wrap">
			<c:if test="${boardConfVo.bbsCd eq 1003}">
			<div class="fl txtadd">
			<img src="/cloud_ver2/new_cloud/images/icon_call.png" width="37" height="37" style="float: left;margin-right: 10px;margin-top: 2px;" alt="민간클라우드 도입절차,서비스 등록방법 등 클라우드서비스 관련 문의가 필요하시면 질문을 남기시거나 , 고객센터로 상담신청해주시기 바랍니다."/><span class="num_call">1522-0089<br/>(평일 9:00~18:00)</span>
				민간클라우드 도입절차,서비스 등록방법 등 클라우드서비스 관련 문의가 필요하시면 질문을 남기시거나 <br/>고객센터로 상담신청해주시기 바랍니다.
			</div>
			</c:if>
			<c:if test="${boardConfVo.bbsCd eq 1008}">
			<div class="selected">
		  	<span class="selectbox_title" style="width:115px;vertical-align:middle;display:inline-block;cursor:pointer;"></span>
		  	<select name="q_product" id="q_product" title="서비스 선택" style="width:150px;" onchange="jsListReq(1);">
        	<option value="">-- 선택 --</option>
          <c:forEach items="${boardConfVo.productList}" var="productVo" varStatus="status">
          <option value="${productVo.goodsCd}" <c:if test="${param.q_product eq productVo.goodsCd}"> selected="selected"</c:if>>${productVo.goodsNm}</option>
          </c:forEach>
        </select>
			</div>
			</c:if>
			<div class="schArea">
				<span class="sel_box">
			  	<select name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}">
				  	<option value="">-- 선택 --</option>
				  	<c:if test="${boardConfVo.bbsCd ne 1031}">
				    <option value="BBSCTT_SJ_BBSCTT_CN" <c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ_BBSCTT_CN' or boardConfVo.bbsCd eq 1001 or boardConfVo.bbsCd eq 1023 or boardConfVo.bbsCd eq 1024}"> selected="selected"</c:if>>제목+내용</option>
				    </c:if>
				    <!-- 도입사례 1031 추가-->
				    <c:if test="${boardConfVo.bbsCd eq 1031}">
				    <option value="BBSCTT_SJ" <c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ'}"> selected="selected"</c:if>>사례명</option>
				    <option value="BBSCTT_CN" <c:if test="${param.q_searchKeyType eq 'BBSCTT_CN'}"> selected="selected"</c:if>>내용</option>
				    <option value="BBSCTT_SJ_BBSCTT_CN" <c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ_BBSCTT_CN'}"> selected="selected"</c:if>>사례명+내용</option>
				    <option value="GOODS_NM" 	<c:if test="${param.q_searchKeyType eq 'GOODS_NM'}">  selected="selected"</c:if>>서비스명</option>
				    </c:if>
			      <!-- 공지사항 사용안함 20161220 1023,1024 추가-->
			      <c:if test="${boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1007 and boardConfVo.bbsCd ne 1023 and boardConfVo.bbsCd ne 1024 and boardConfVo.bbsCd ne 1031}">
				    <option value="REGISTER_NM___1002" <c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1002'}"> selected="selected"</c:if>>작성자</option>
	          </c:if>
	          <!-- 20150827 뉴스레터 사용안함 추가  -->
	          <!-- 묻고답하기, 자주찾는질문,공지사항 사용안함  20161220 1023,1024 추가-->
			      <c:if test="${boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1002 and boardConfVo.bbsCd ne 1003 and boardConfVo.bbsCd ne 1007 and boardConfVo.bbsCd ne 1012 and boardConfVo.bbsCd ne 1023 and boardConfVo.bbsCd ne 1024 and boardConfVo.bbsCd ne 1030 and boardConfVo.bbsCd ne 1031}">
					  <option value="NTT_CMT_CN" <c:if test="${param.q_searchKeyType eq 'NTT_CMT_CN'}"> selected="selected"</c:if>>댓글내용</option>
					  <option value="REGISTER_NM___1007" <c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1007'}"> selected="selected"</c:if>>댓글작성자</option>
				    </c:if>
				    <c:forEach var="extensionVo" items="${boardConfVo.searchColunms}">
					  <c:set var="searchKey" value="${extensionVo.columnId}___${extensionVo.searchTy}" />
					  <option value="${searchKey}"<c:if test="${param.q_searchKeyType eq searchKey}"> selected="selected"</c:if>>${extensionVo.columnNm}</option>
				    </c:forEach>
				    <c:if test="${param.q_searchKeyType eq 'TAG___1005'}">
					  <option value="TAG___1005"<c:if test="${param.q_searchKeyType eq 'TAG___1005'}"> selected="selected"</c:if>>태그</option>
				    </c:if>
			  	</select><label for="q_searchKeyType" for="q_searchKeyType" style="display: none;">검색하실 단어 제목, 내용 중 선택</label>
				</span>
				
				<div>
					<input type="hidden" name="q_searchKey" value="<c:out value='${param.q_searchKey}'/>" />
			    <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" maxlength='50' class="input" title="검색하실 단어 입력" />
			    <label for="q_searchVal" style="display: none;">검색</label>
				</div>
        <input type="submit" value="검색" onclick="jsSearch(); return false;" class="btns st5" />
			</div>
		</div>
	</div>
</c:if>


<!-- //title-area -->


		
		
        
 
