<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- 이전/다음 목록 시작 -->
	<table class="tbl_prevNext">
		<caption>
		    <strong>이전글 다음글 목록입니다. </strong>
		    <details>
		        <summary>이전글,다음글의 제목, 등록일을 보여줍니다.</summary>
		    </details>
		</caption>
		<colgroup>
		<c:choose>
		  <c:when test="${boardConfVo.bbsCd eq '1003' }">
		      <col style="width:20%;">
              <col style="width:*;">
              <col style="width:12%;">
              <col style="width:12%;">
              <col style="width:20%;">
		  </c:when>
		  <c:otherwise>
			<col style="width:23%">
			<col style="width:*">
			<col style="width:15%">
			<col style="width:18%">
		  </c:otherwise>
		</c:choose>
		</colgroup>
		<tbody>
			<tr>
			    <td><span class="prev">Publicación anterior</span></td>
				<!-- 이전글 -->
			    <c:if test="${empty dataVo.prevVO}"><td class="t_al" colspan="${boardConfVo.bbsCd eq '1003'? '4':'3'}">No hay publicaciones anteriores.</td></c:if>
				<c:if test="${!empty dataVo.prevVO}">
					<c:choose>
						<c:when test="${dataVo.prevVO.mngrDeleteAt eq 'Y'}">
						  <td class="t_al">[Eliminada por el administrador]</td>
						</c:when>
						<c:otherwise>
							<td class="t_al">
								<a href="#" onclick="jsView('${dataVo.prevVO.domainCd}','${dataVo.prevVO.bbsCd}', '${dataVo.prevVO.bbscttSeq}', '${dataVo.prevVO.registPassword}', '${dataVo.prevVO.othbcAt}'); return false;">
								<c:out value='${fn:substring(dataVo.prevVO.bbscttSj,0,45)}'/><c:if test="${dataVo.prevVO.bbscttSjLength > 45}">...</c:if>
								</a>
							</td>
							<c:choose>
							    <c:when test="${boardConfVo.othbcYn eq 'Y'}">
	                                <c:if test="${ dataVo.prevVO.othbcAt eq 'Y'}">
	                                   <td class="fc_brown">Oculto</td>
	                                </c:if>
	                                <c:if test="${ dataVo.prevVO.othbcAt eq 'N'}">
    									<td>Divulgación</td>
	                                </c:if>
							    </c:when>
							    <c:otherwise>
									<td><c:out value='${dataVo.prevVO.maskRegistId}'/></td>
							    </c:otherwise>
							</c:choose>
                            <c:if test="${boardConfVo.bbsCd eq '1003'}">
								<td class="${dataVo.prevVO.estnColumn3 eq 'N' ? 'fc_brown':'' }">
                                    <c:if test="${dataVo.prevVO.estnColumn3 eq 'Y'}">Completar respuesta</c:if>
                                    <c:if test="${dataVo.prevVO.estnColumn3 eq 'N'}">No respondida</c:if>
                                </td>
                            </c:if>
							<td class="date"><c:out value='${dataVo.prevVO.registDt}'/></td>
						</c:otherwise>
					</c:choose>
				</c:if>
			</tr>
			<tr>
				<td><span class="next">Siguiente publicación</span></td>
				<c:if test="${empty dataVo.nextVO}"> <td class="t_al" colspan="${boardConfVo.bbsCd eq '1003'? '4':'3'}">No hay más publicaciones.</c:if>
				<c:if test="${!empty dataVo.nextVO}">
					<c:choose>
						<c:when test="${dataVo.nextVO.mngrDeleteAt eq 'Y'}">
						   <td class="t_al">[Eliminada por el administrador]</td>
						</c:when>
						<c:otherwise>
							<td class="t_al">
								<a href="#" onclick="jsView('${dataVo.nextVO.domainCd}','${dataVo.nextVO.bbsCd}', '${dataVo.nextVO.bbscttSeq}', '${dataVo.nextVO.registPassword}', '${dataVo.nextVO.othbcAt}'); return false;">
								<c:out value='${fn:substring(dataVo.nextVO.bbscttSj,0,45)}'/><c:if test="${dataVo.nextVO.bbscttSjLength > 45}">...</c:if>
								</a>
							</td>
							<c:choose>
                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
                                    <c:if test="${ dataVo.nextVO.othbcAt eq 'Y'}">
                                       <td class="fc_brown">Oculto</td>
                                    </c:if>
                                    <c:if test="${ dataVo.nextVO.othbcAt eq 'N'}">
                                        <td>Divulgación</td>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <td><c:out value='${dataVo.nextVO.maskRegistId}'/></td>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${boardConfVo.bbsCd eq '1003'}">
                                <td class="${dataVo.nextVO.estnColumn3 eq 'N' ? 'fc_brown':'' }">
                                    <c:if test="${dataVo.nextVO.estnColumn3 eq 'Y'}">Completar respuesta</c:if>
                                    <c:if test="${dataVo.nextVO.estnColumn3 eq 'N'}">No respondida</c:if>
                                </td>
                            </c:if>
							<td class="date"><c:out value='${dataVo.nextVO.registDt}'/></td>
						</c:otherwise>
					</c:choose>
				</c:if>
			</tr>
		</tbody>
	</table>
	<!-- //이전글, 다음글 -->

