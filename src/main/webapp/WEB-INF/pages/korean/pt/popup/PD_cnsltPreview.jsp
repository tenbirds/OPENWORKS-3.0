<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>미리보기 | 씨앗 마켓</title>
  	<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/style.css" />
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
<!--     <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script> -->
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/common/js/html5shiv.js"></script>
    <![endif]-->
<script type="text/javascript">
/********************************************
// 서비스상세 이미지 변경 보기
********************************************/
function productImageChange(tab) {
    var img = $("#goodsImg"+tab).attr("src");
    try {
        document.getElementById('pathImage1').src = img ;
    } catch(e) {
        document.getElementById('pathImage2').src = img ;
    }
}
$().ready(function() {
    $("#pathImage1").attr("src", $("#goodsImg1").attr("src"));
    //$("#goodsNm").text(parent.$("#goodsNm").val());
});
</script>
</head>
<body>
	<%@ include file="/WEB-INF/pages/web/inc/INC_SnsView.jsp" %>
<!--         <form name="dataForm" id="dataForm" method="post"> -->
        <!-- container -->
        <div id="container">
            <!-- contents -->
            <div id="contents">
                <!-- location -->
<%--                 <c:forEach items="${ctgryPath}" var="_ctgryPath" varStatus="status"> --%>
<%--                     <c:if test="${not status.last}"><span>${_ctgryPath}</span></c:if> --%>
<%--                     <c:if test="${status.last}"><strong>${_ctgryPath}</strong></c:if>  --%>
<%--                 </c:forEach> --%>
                <!-- //location -->
                <div class="mark">
                </div>
                <div class="mall_content mall_colsulting">
                    <h3 id="goodsNm"><c:out value="${param.goodsNm}"/></h3>
                    <input type="hidden" name="userId" id="userId" value=""/>
                    <!-- 서비스 이미지, 정보 영역 -->
                    <div class="product_area">
                        <!-- 서비스 이미지 영역 -->
                        <div class="imgArea">
                            <div class="photo"><a href="#none"><img src="" alt="미리보기 이미지" id="pathImage1" width="400" height="300"/></a></div>

                            <div class="list">
                                <ul>
                                    <c:set var="imgCount" value="1" />
                                    <c:forEach items="${param.image}" var="oldImage">
                                        <li><a href="javascript:productImageChange('${imgCount}');"><img src="${oldImage}" alt="미리보기 이미지${imgCount}" id="goodsImg${imgCount}" width="70" height="54"/></a></li>
                                        <c:set var="imgCount" value="${imgCount + 1}" />
                                    </c:forEach>
                                    <c:forEach items="${dataVo.imageFile}" var="newImage" varStatus="status">
                                        <li><a href="javascript:productImageChange('${imgCount}');"><img src="${newImage.fileUrl}" alt="미리보기 이미지${imgCount}" id="goodsImg${imgCount}" width="70" height="54"/></a></li>
                                        <c:set var="imgCount" value="${imgCount + 1}" />
                                    </c:forEach>
                                </ul>
                                <c:if test="${not empty param.demoExprnUrl}">
                                <div class="movie_btn"><a href="javascript:;"><img src="/resources/web/theme/default/images/btn/btn_introduce_movie.gif" alt="소개영상"/></a></div>
                                </c:if>
                            </div>
                        </div>
                        <!-- //서비스 이미지 영역 -->

                        <!-- 서비스 정보 -->
                        <div class="txtArea">
                            <div class="info">
                                <ul>
                                    <li>
                                        <span class="tit">구매문의 수</span>
                                        <div class="con"><fmt:formatNumber value="${dataVo.sellCnt}" type="NUMBER" groupingUsed="true"/></div>
                                    </li>
                                    <li>
                                        <span class="tit">가격</span>
                                        <c:if test="${not empty dataVo.goodsPc}">
                                        <div class="con">₩ <fmt:formatNumber value="${param.goodsPc}" type="NUMBER" groupingUsed="true"/></div>
                                        </c:if>
                                        <c:if test="${empty dataVo.goodsPc}">
                                        <div class="con">문의요망</div>
                                        </c:if>
                                    </li>
                                    <li>
                                        <span class="tit">A/S 방침</span>
                                        <div class="con">
                                        <c:forTokens items="${param.metaASnms}" delims="," var="_metaASnms" varStatus="status">
                                            <c:if test="${status.first}">
                                            <div>
                                                <c:out value="${_metaASnms}"/>
                                            </div>
                                            </c:if>
                                        <c:if test="${status.index eq 1}">
                                        <a href="javascript:;" class="btn_more">열기</a>
                                            <div class="cont_more">
                                        </c:if>
                                        <c:if test="${status.index >= 1}">
                                            <div>
                                                <c:out value="${_metaASnms}"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${status.index ne 0 and status.last}">
                                        </div>
                                        </c:if>
                                        </c:forTokens>
                                        </div>
                                    </li>
                                    <li>
                                        <span class="tit">전문 분야</span>
                                        <div class="con"><c:out value="${dataVo.spcltyRealm}"/></div>
                                    </li>
                                    <li>
                                        <span class="tit">전문 컨설턴트</span>
                                        <div class="con"><fmt:formatNumber value="${dataVo.cnstntCo}" type="NUMBER" groupingUsed="true"/>명</div>
                                    </li>
                                    <li>
                                        <span class="tit">보유기술 및  자격증</span>
                                        <div class="con">
                                        <c:forTokens items="${param.metaTECHnms}" delims="," var="_metaTECHnms" varStatus="status">
                                            <c:if test="${status.first}">
                                            <div>
                                                <c:out value="${_metaTECHnms}"/>
                                            </div>
                                            </c:if>
                                        <c:if test="${status.index eq 1}">
                                        <a href="javascript:;" class="btn_more">열기</a>
                                            <div class="cont_more">
                                        </c:if>
                                        <c:if test="${status.index >= 1}">
                                            <div>
                                                <c:out value="${_metaTECHnms}"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${status.index ne 0 and status.last}">
                                        </div>
                                        </c:if>
                                        </c:forTokens>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="btn">
                                <a href="javascript:;"><img src="/resources/web/theme/default/images/btn/btn_consulting_apply.gif" alt="IT전문가서비스 신청"/></a>
                                <a href="javascript:;"><img src="/resources/web/theme/default/images/btn/btn_register.gif" alt="관심등록"/></a>
                            </div>

                            <div class="sns">
                                <a href="javascript:;"><img src="/resources/web/theme/default/images/btn/btn_facebook.gif" alt="페이스북"/></a>
                                <a href="javascript:;"><img src="/resources/web/theme/default/images/btn/btn_twitter.gif" alt="트위터"/></a>
                            </div>
                        </div>
                        <!-- //서비스 정보 -->
                    </div>
                    <!-- //서비스 이미지, 정보 영역 -->

                    <!-- 판매자 정보 -->
                    <div class="seller_info">
                        <div class="seller">
                            <div class="photo"><img src="${dataVo.storeImageFile[0].fileUrl}" alt="${dataVo.storeImageFile[0].localNm}"/></div>
                            <div class="name">
                                <p>${param.langStoreNm}</p>
                                <div class="btn">
                                    <c:if test="${ not empty param.goodsHmpgUrl }">
                                    <span class="btn_light_gray02"><a href="${param.goodsHmpgUrl}" target="_blank">홈페이지</a></span>
                                    </c:if>
                                    <c:if test="${ not empty param.cmmntyId}">
                                    <span class="btn_light_gray02"><a href="/community/${param.cmmntyId}" target="_blank">판매자 커뮤니티</a></span>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="info">
                            <ul>
                                <li>
                                    <span class="tit">담당자</span>
                                    <div class="con"><c:out value="${param.goodsChargerNm}"/></div>
                                </li>
                                <li>
                                    <span class="tit">담당자 이메일</span>
                                    <div class="con"><a href="mailto:${param.goodsChargerEmail}"  class="mail"><c:out value="${param.goodsChargerEmail}"/></a></div>
                                </li>
                                <li>
                                    <span class="tit">담당자 연락처</span>
                                    <div class="con"><c:out value="${param.goodsChargerCttpc}"/></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- //판매자 정보 -->

                    <!-- 서비스상세 (개요 ~ 연관솔루션) -->
                    <div class="product_view">
                        <div id="tab_area" class="tab">
                            <ul>
                                <li><a href="#productInfo1">서비스설명</a></li>
                                <li><a href="#productInfo2">레퍼런스</a></li>
                                <li><a href="#productInfo3">문서</a></li>
                                <li><a href="#productInfo4">리뷰</a></li>
                                <li><a href="#productInfo5">서비스문의하기</a></li>
                                <li><a href="#productInfo6">연관 IT전문가서비스</a></li>
                            </ul>
                            <div class="top"><a href="#wrap">TOP</a></div>
                        </div>
                        <!-- 개요 -->
                        <div id="productInfo1" class="product_info">
                            <h4>개요</h4>
                            <div class="desc"><op:nrToBr content="${param.goodsSumry}" /></div>
                        </div>
                        <!-- //개요 -->

                        <!-- 주요특징 -->
                        <div class="product_info">
                            <h4>주요특징</h4>
                            <ul class="feature">
                                <li>
                                    <dl>
                                        <c:out value="${param.goodsMainFnct}" escapeXml="false"/>
                                    </dl>
                                </li>
                            </ul>
                        </div>
                        <!-- //주요특징 -->

                        <!-- 기대효과 -->
                        <div class="product_info">
                            <h4>기대효과</h4>
                            <ul class="desc">
                                <li>
                                    <c:out value="${param.cnslExpcEffect}" escapeXml="false"/>
                                </li>
                            </ul>
                        </div>
                        <!-- //기대효과 -->

                        <!-- 레퍼런스 -->
                        <div id="productInfo2" class="product_info">
                            <h4>레퍼런스</h4>
                            <ul class="desc">
                               <li><c:out value="${param.goodsRefer}" escapeXml="false"/></li>
                            </ul>
                        </div>
                        <!-- //레퍼런스 -->

                        <!-- 문서 -->
                        <div id="productInfo3" class="product_info">
                            <h4>문서</h4>
                            <div class="btnArea">
                                <c:forTokens items="${param.mnlFilesFileDesc}" delims="," var="_mnlFileDesc">
                                    <c:if test="${not empty _mnlFileDesc}">
                                        <div class="btn_round"><a href="#" title="${_mnlFileDesc}"><span>${_mnlFileDesc}</span></a></div>
                                    </c:if>
                                </c:forTokens>
                            </div>
                        </div>
                        <!-- //문서 -->

                        <!-- 리뷰 -->
                        <div id="productInfo4" class="product_info">
                            <h4>리뷰</h4>

                        </div>
                        <!-- //리뷰 -->

                        <!-- 서비스평 -->
<!--                         <div class="product_info"> -->
<!--                             <h4>서비스평</h4> -->
<!--                         </div> -->
                        <!-- //서비스평 -->

                        <!-- 서비스문의하기 -->
                        <div id="productInfo5" class="product_info">
                            <h4>서비스문의하기</h4>
                        </div>
                        <!-- //서비스문의하기 -->

                        <!-- 연관 IT전문가서비스 -->
                        <div id="productInfo6" class="product_info">
                            <h4>연관 IT전문가서비스</h4>
                        </div>
                        <!-- //연관 솔루션 -->
                    </div>
                    <!-- //서비스상세 (개요 ~ 연관솔루션) -->
                </div>
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
    </div>
<!--     </form> -->
</body>
</html>
