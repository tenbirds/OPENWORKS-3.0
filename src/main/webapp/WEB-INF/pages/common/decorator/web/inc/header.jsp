<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header -->
	<header id="gnb">
		<div class="conWrap">
			 <h1>
			 	<a href="/" title="클라우드서비스 씨앗"><img src="/cloud_ver3/html_web/images/logo_header.png" width="173" height="47"  alt="클라우드서비스 씨앗" /></a>
<!-- 			 	
			 	&nbsp;&nbsp;
			 	<a href="https://www.ceart.kr"  target="_blank"><img src="/cloud_ver3/html_web/images/banner_20180508.png" alt="씨앗 2.0 돌아가기" class="banner_2"/></a>
 -->			 	
			 </h1>
			<aside>
				<div>
					<!-- 구글 사이트 번역 API -->
					<!--
					<div id="google_translate_element"></div>
					<script type="text/javaScript">
						function googleTranslateElementInit() {
						    new google.translate.TranslateElement({pageLanguage: 'ko', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
						    }
					</script>
					<script type="text/javaScript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
					-->
					<!--// 구글 사이트 번역 API -->
					<ul>
						<c:if test="${empty sessionScope['__usk']}">
							<c:if test="${sslYn eq 'Y'}">
								<li><a href="https://<%=GlobalConfig.DOMAIN_SUBNM %>:443/korean/pt/login/user/BD_index.do" title="로그인">로그인</a></li>
							</c:if>
							<c:if test="${sslYn ne 'Y'}">
								<li><a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/pt/login/user/BD_index.do" title="로그인">로그인</a></li>
							</c:if>
						</c:if>
						<c:if test="${not empty sessionScope['__usk']}">
						<li>
							<c:out value="${fn:substring(sessionScope['__usk'].userNm, 0, 3)}" /> 님
							<i><a href="javascript:;" id="alarmcnt" title="알람">0</a></i>
							<div id="alarmlist"></div>
						</li>
						<li>	
							<c:if test="${sslYn eq 'Y'}">
								<a href="https://<%=GlobalConfig.DOMAIN_SUBNM %>:443/korean/pt/login/user/ND_logoutAction.do" title="로그아웃">로그아웃</a>
							</c:if>
							<c:if test="${sslYn ne 'Y'}">
								<a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/pt/login/user/ND_logoutAction.do" title="로그아웃">로그아웃</a>
							</c:if>
						</li>
						</c:if>
						<c:if test="${empty sessionScope['__usk']}">
							<li><a href="/korean/pt/register/BD_join.do" title="회원가입">회원가입</a></li>
						</c:if>
						<li><a href="/korean/pt/wish/BD_index.do" title="이용희망목록">이용희망목록</a></li>
						<c:if test="${not empty sessionScope['__usk']}">
						<li>
							<a href="javascript:;" title="마이씨앗">마이씨앗</a><!--  <a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1015">마이씨앗</a> -->
							<div>
								<img src="/cloud_ver2/new_cloud/images/bgIcn_arr_up.png" alt="마이씨앗" />
								<span>
									<c:forEach items="${allSubMenuList}" var="siteSubMenu4">
										<c:if test="${siteSubMenu4.menuDepth == 2 && siteSubMenu4.showYn eq 'Y' &&  'myPage' eq siteSubMenu4.parentMenuCode}">
											<c:if test="${siteSubMenu4.menuCode eq 'dcPartcptReqst' || siteSubMenu4.menuCode eq 'dcPartcptAprslt' || siteSubMenu4.menuCode eq 'dmandExamin'}">
												<c:if test="${fn:startsWith(sessionScope['MEM_TYPE'], '30') && sessionScope['MEM_CHARGER_AT'] eq 'Y' }">
													<a href="<c:url value="${siteSubMenu4.userMenuUrl}" />" title="${siteSubMenu4.menuNm}">${siteSubMenu4.menuNm}</a>
												</c:if>
											</c:if>
											<c:if test="${siteSubMenu4.menuCode ne 'dcPartcptReqst' && siteSubMenu4.menuCode ne 'dcPartcptAprslt' && siteSubMenu4.menuCode ne 'dmandExamin'}">
												<a href="<c:url value="${siteSubMenu4.userMenuUrl}" />" title="${siteSubMenu4.menuNm}">${siteSubMenu4.menuNm}</a>
											</c:if>
										</c:if>
									</c:forEach>
								</span>
							</div>
						</li>
						<li>
						<c:if test="${sessionScope['MEM_TYPE'] ne 1001 && sessionScope['MEM_TYPE'] ne 1002 && sessionScope['MEM_TYPE'] ne 2002 && sessionScope['MEM_TYPE'] ne 3002 }">
							<a href="/korean/pt/register/BD_suppliIndex.do" title="제공자씨앗">제공자씨앗</a>
						</c:if>
						<c:if test="${sessionScope['MEM_TYPE'] eq 1002 || sessionScope['MEM_TYPE'] eq 2002 || sessionScope['MEM_TYPE'] eq 3002 }"> 
							<a href="javascript:;" title="제공자씨앗">제공자씨앗</a>
							<div>
							<img src="/cloud_ver2/new_cloud/images/bgIcn_arr_up.png" alt="제공자씨앗" />
							<span>
								<c:forEach items="${allSubMenuList}" var="siteSubMenu4">
									<c:if test="${siteSubMenu4.menuDepth == 2 && siteSubMenu4.showYn eq 'Y' &&  'forSale' eq siteSubMenu4.parentMenuCode}">
									<a href="<c:url value="${siteSubMenu4.userMenuUrl}" />">${siteSubMenu4.menuNm}</a>
									</c:if>
								</c:forEach>
							</span>
							</div>
						</c:if>	
						</li>
						</c:if>
					</ul>
				</div>

				<!-- 전체 검색 -->
				<form class="sech_form" onsubmit="return false">
					<span onkeydown="javascript:if(event.keyCode == 13){ fn_mainSearch(); return false;}" style="position:relative;">
					<input type="text"  value="${totalKeyword}"  id="totalKeyword" name="totalKeyword" placeholder="클라우드서비스 검색" title="클라우드서비스 검색"/><label for="totalKeyword" style="display: none;">클라우드서비스 검색</label>
					</span>
					<input type="image" id="icon_Hsearch" name="icon_Hsearch" src="/cloud_ver3/html_web/images/icon_Hsearch.gif" alt="클라우드서비스 검색" onclick="javascript:fn_mainSearch();" /><label for="icon_Hsearch" style="display: none">클라우드서비스 검색</label>
				</form>
				<!--// 전체 검색 -->
				
				<!--img src="/cloud_ver3/html_web/images/banner_20180131.png" width="150" height="47" alt="제공자 2차협약"-->
				
			</aside>
			<!-- 상단 메뉴 -->
		</div>

		<!-- gnb -->
		<nav>
			<div class="conWrap">
				<span class="view_allmenu" style="cursor: pointer;"></span><!-- <a href="#" class="view_allmenu"></a> -->
				<ul class="clearfix">
				<c:forEach items="${topMenuList}" var="topMenu" varStatus="topCount">
					<c:if test="${topMenu.menuDepth == 1 and topMenu.showYn eq 'Y' and topMenu.parentMenuCode eq 'kor'}">
						<c:set var="menuUrl" value="#" />
						<c:choose>
							<c:when test="${not empty topMenu.userMenuUrl}">
								<c:set var="menuUrl" value="${topMenu.userMenuUrl}" />
							</c:when>
              <c:otherwise>
              	<c:if test="${not empty topMenu.childList}">
                	<c:forEach items="${topMenu.childList}" var="cMenu" varStatus="cStatus">
                  	<c:if test="${cStatus.first}">
                    	<c:set var="menuUrl" value="${cMenu.userMenuUrl}" />
                    </c:if>
                  </c:forEach>
                </c:if>
              </c:otherwise>
            </c:choose>
						<li  class="main_menu">
						<span class="main_txt01" id="<c:out value="${topMenu.menuCode}" />"><c:out value="${topMenu.menuNm}" /></span>
						<%-- <a href="<c:url value="${menuUrl}" />" id="<c:out value="${topMenu.menuCode}" />"><c:out value="${topMenu.menuNm}" /></a> --%>
						<c:if test="${topMenu.menuNm eq '클라우드서비스'}">
						<ul class="sub_menu sub_cloudservice">
							<!-- SaaS PaaS IaaS 제이 나머지는 메뉴정보에서 가져오기 PaaS //-->
							<%-- <c:if test="${topMenu.menuNm ne 'SaaS' && topMenu.menuNm ne 'PaaS' && topMenu.menuNm ne 'IaaS'}"> --%>
							<!-- SaaS PaaS IaaS 는 카테고리 정보에서 가져오기 //-->
							
							<li class="first_all"><a href="${menuUrl}">전체보기</a></li>
							<li class="cs01">
								<ul class="cs_sub clearfix">
									<li>
										<ul>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1003&ctgryCode=6202_354&ctgryParentCode=6202_354" title="컴퓨팅">컴퓨팅</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1003&ctgryCode=6202_356&ctgryParentCode=6202_356" title="네트워킹">네트워킹</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1003&ctgryCode=6202_355&ctgryParentCode=6202_355" title="스토리지">스토리지</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_338&ctgryParentCode=6202_338" title="보안">보안</a></li>
										</ul>
									</li>
									<li>
										<ul>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_331&ctgryParentCode=6202_331" title="데이터관리">데이터관리</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_339&ctgryParentCode=6202_339" title="의사결정지원/데이터분석">의사결정지원/데이터분석</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1003&ctgryCode=6202_358&ctgryParentCode=6202_358" title="블록체인">블록체인</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1003&ctgryCode=6202_362&ctgryParentCode=6202_362" title="인공지능">인공지능</a></li>
										</ul>
									</li>
									<li>
										<ul>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1001&ctgryCode=6202_368&ctgryParentCode=6202_368" title="플랫폼">플랫폼</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_334&ctgryParentCode=6202_334" title="소프트웨어 개발도구">소프트웨어 개발도구</a></li>
										</ul>
									</li>
								</ul>
								<!-- <ul class="multicolumn01">
									<c:forEach items="${goodsSubMenuList}" var="ctgryList">
										<c:if test="${ctgryList.ctgryGroup eq '00' }">
											<li><a href="${menuUrl}&ctgryCode=${ctgryList.ctgryCode}&ctgryParentCode=${ctgryList.ctgryCode}">${ctgryList.langCtgryNm}</a></li>
										</c:if>
									</c:forEach>								
								</ul> -->
							</li>
							
							<li class="cs02">    
								<ul class="cs_sub clearfix">
									<li>
										<ul>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_340&ctgryParentCode=6202_340" title="ERP">ERP</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_344&ctgryParentCode=6202_344" title="마케팅/세일즈">마케팅/세일즈</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_342&ctgryParentCode=6202_342" title="인적 자원 관리">인적 자원 관리</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_345&ctgryParentCode=6202_345" title="고객 관계 관리(CRM)">고객 관계 관리(CRM)</a></li>										
										</ul>
									</li>
									<li>
										<ul>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_332&ctgryParentCode=6202_332" title="IT">IT관리</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_336&ctgryParentCode=6202_336" title="협업도구">협업도구</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_333&ctgryParentCode=6202_333" title="프로젝트 관리">프로젝트 관리</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_335&ctgryParentCode=6202_335" title="전자 문서/기록 관리(EDRM)">전자 문서/기록 관리(EDRM)</a></li>
										</ul>
									</li>
									<li>
										<ul>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_350&ctgryParentCode=6202_350" title="산업">산업</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_348&ctgryParentCode=6202_348" title="교육/도서">교육/도서</a></li>
											<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_353&ctgryParentCode=6202_353" title="방송/문화/콘텐츠">방송/문화/콘텐츠</a></li>
										</ul>
									</li>
								</ul>
								<!-- <ul class="multicolumn02">
									<c:forEach items="${goodsSubMenuList}" var="ctgryList">
										<c:if test="${ctgryList.ctgryGroup eq '01' }">
											<li><a href="${menuUrl}&ctgryCode=${ctgryList.ctgryCode}&ctgryParentCode=${ctgryList.ctgryCode}">${ctgryList.langCtgryNm}</a></li>
										</c:if>
									</c:forEach>
								</ul> -->
							</li>
								
							<li class="cs03">
								<ul>
									<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_375&ctgryParentCode=6202_375" title="컨설팅서비스">컨설팅서비스</a></li>
									<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002&ctgryCode=6202_376&ctgryParentCode=6202_376" title="마이그레이션">마이그레이션</a></li>
								</ul>
							</li>
								
						</ul>
						</c:if>
						<c:if test="${topMenu.menuNm ne '클라우드서비스'}">
						<ul class="sub_menu">
							<c:forEach items="${allSubMenuList}" var="siteSubMenu1">
								<c:if test="${siteSubMenu1.menuDepth == 2 && siteSubMenu1.parentMenuCode eq topMenu.menuCode}">
									<li ><a href="<c:url value="${siteSubMenu1.userMenuUrl}" />" title="<c:out value="${siteSubMenu1.menuNm}" />"><c:out value="${siteSubMenu1.menuNm}" /></a></li>
								</c:if>								
							</c:forEach>
						</ul>
						</c:if>
						</li>
					</c:if>	
				</c:forEach>
				</ul>
			</div>

			<!-- allmenu -->
			<div class="all_menu">
				<div class="conWrap">
					<table summary="전체보기">
					<caption>전체보기</caption>
					<colgroup>
						<col />
						<col />
					</colgroup>
					<thead style="display: none;">
						<tr>
							<th scope="col" colspan="5">전체보기</th>
						</tr> 
					</thead>
					<tbody>
						<tr>
							<td scope="col">
								<ul>
									<li><a href="/korean/pt/store/software/BD_index.do?goodsTyCd=1002" title="전체보기">전체보기</a></li>
								</ul>
							</td>
							<td>
								<ul><!-- 클라우드 허브 -->
								<c:forEach items="${allSubMenuList}" var="siteSubMenu1">
									<c:if test="${siteSubMenu1.menuDepth == 2 && siteSubMenu1.parentMenuCode eq 'communication'}">
										<li><a href="<c:url value="${siteSubMenu1.userMenuUrl}" />" title="<c:out value="${siteSubMenu1.menuNm}" />"><c:out value="${siteSubMenu1.menuNm}" /></a></li>
									</c:if>	
								</c:forEach>
								</ul><!-- //클라우드 허브 -->
							</td>
							<td>
								<ul><!-- //씨앗소식 -->
								<c:forEach items="${allSubMenuList}" var="siteSubMenu1">
									<c:if test="${siteSubMenu1.menuDepth == 2 && siteSubMenu1.parentMenuCode eq 'story'}">
										<li><a href="<c:url value="${siteSubMenu1.userMenuUrl}" />" title="<c:out value="${siteSubMenu1.menuNm}" />"><c:out value="${siteSubMenu1.menuNm}" /></a></li>
									</c:if>	
								</c:forEach>
								</ul><!-- //씨앗소식 -->
							</td>
							<td>
								<ul><!-- //이용안내 -->
								<c:forEach items="${allSubMenuList}" var="siteSubMenu1">
									<c:if test="${siteSubMenu1.menuDepth == 2 && siteSubMenu1.parentMenuCode eq 'opguide'}">
										<li><a href="<c:url value="${siteSubMenu1.userMenuUrl}" />" title="<c:out value="${siteSubMenu1.menuNm}" />"><c:out value="${siteSubMenu1.menuNm}" /></a></li>
									</c:if>	
								</c:forEach>
								</ul><!-- //이용안내 -->
							</td>
							<td>
								<ul><!-- //씨앗소개 -->
								<c:forEach items="${allSubMenuList}" var="siteSubMenu1">
									<c:if test="${siteSubMenu1.menuDepth == 2 &&siteSubMenu1.parentMenuCode eq 'ceartInfo'}">
										<li><a href="<c:url value="${siteSubMenu1.userMenuUrl}" />" title="<c:out value="${siteSubMenu1.menuNm}" />"><c:out value="${siteSubMenu1.menuNm}" /></a></li>
									</c:if>	
								</c:forEach>
								</ul><!-- //씨앗소개 -->
							</td>
							
						</tr>
						<tr>
							<td scope="row" class="st_thead">로그인</td>
							<td class="st_thead">회원가입</td>
							<td class="st_thead">이용희망목록</td>
							<td class="st_thead">마이씨앗</td>
							<td class="st_thead">제공자씨앗</td>
						</tr>
						<tr>
							<td scope="col">
								<ul>
									<li><a href="/korean/pt/login/user/BD_findId.do" title="아이디 찾기">아이디 찾기</a></li>
									<li><a href="/korean/pt/login/user/BD_findPwd.do" title="비밀번호 찾기">비밀번호 찾기</a></li>
								</ul>
							</td>
							<td>
								<ul>
									<li><a href="/korean/pt/register/BD_userCrtfc.do?userTyCd=1001&nationCode=410">일반회원가입</a></li>
									<li><a href="/korean/pt/register/BD_userCrtfc.do?userTyCd=3001&nationCode=410">공공회원가입</a></li>
									<li><a href="/korean/pt/register/BD_userCrtfc.do?nationCode=410">제공권한신청</a></li>
								</ul>
							</td>
							<td>
								<ul>
									<li><a href="/korean/pt/wish/BD_index.do">이용희망목록</a></li>
								</ul>
							</td>
							<td>
								<ul>
									<c:forEach items="${allSubMenuList}" var="siteSubMenu4">
										<c:if test="${siteSubMenu4.menuDepth == 2 && siteSubMenu4.showYn eq 'Y' &&  'myPage' eq siteSubMenu4.parentMenuCode}">
											<c:if test="${siteSubMenu4.menuCode eq 'dcPartcptReqst' || siteSubMenu4.menuCode eq 'dcPartcptAprslt' || siteSubMenu4.menuCode eq 'dmandExamin'}">
												<c:if test="${fn:startsWith(sessionScope['MEM_TYPE'], '30') && sessionScope['MEM_CHARGER_AT'] eq 'Y' }">
													<li><a href="<c:url value="${siteSubMenu4.userMenuUrl}" />">${siteSubMenu4.menuNm}</a></li>
												</c:if>
											</c:if>
											<c:if test="${siteSubMenu4.menuCode ne 'dcPartcptReqst' && siteSubMenu4.menuCode ne 'dcPartcptAprslt' && siteSubMenu4.menuCode ne 'dmandExamin'}">
												<li><a href="<c:url value="${siteSubMenu4.userMenuUrl}" />">${siteSubMenu4.menuNm}</a></li>
											</c:if>
										</c:if>
									</c:forEach>
								</ul>
							</td>
							<td>
								<ul>
									<c:forEach items="${allSubMenuList}" var="siteSubMenu4">
										<c:if test="${siteSubMenu4.menuDepth == 2 && siteSubMenu4.showYn eq 'Y' &&  'forSale' eq siteSubMenu4.parentMenuCode}">
										<li><a href="<c:url value="${siteSubMenu4.userMenuUrl}" />">${siteSubMenu4.menuNm}</a></li>
										</c:if>
									</c:forEach>	
								</ul>
							</td>
						</tr>	
						</tbody>
						<tfoot style="display: none;">
							<tr>
								<th colspan="5" scope="col">메뉴</th>
							</tr> 
						</tfoot> 
					</table>
				</div>
			</div>
			<!--// allmenu -->
		</nav>
		<!--// gnb -->
	</header>
	<!--// header -->
	<c:if test="${not empty sessionScope['__usk']}">
	 <script type="text/javascript">
	$.ajax({
	    type:        "POST",
	    url:         "/korean/Alarm/BD_aramList.do",
	    dataType:    "json",
	    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	    async:       false,
	    success:     function(data) {
	        
	       $("#alarmcnt").html(data.length);
	       
	       if(data.length > 0) {
		        var listhtml ='<img src="/cloud_ver2/new_cloud/images/bgIcn_arr_up.png" alt="견적용청목록" />';
		        var bizNm="";
		        var returnUrl ="";
		        var url="";
		        listhtml += "<dl>"; /*01 02 03*/

		        for (var i = 0; i < data.length; i++) {
		        	if(data[i].alarmBizGbn =="01"){
			          	bizNm="비즈매칭"; 
			            returnUrl ="/korean/pt/sale/bizMatching/BD_index.do?domainCd=2&bbsCd=1010";
			          }else if(data[i].alarmBizGbn =="02"){
			          	bizNm="구매 요청서"; 
			            returnUrl ="/korean/pt/myCeart/BD_buyingRequestList.do";
			          }else if(data[i].alarmBizGbn =="03"){
			          	bizNm="구매 요청서";
			            returnUrl ="/korean/pt/suplerCeart/BD_buyingRequestList.do";
			          }else if(data[i].alarmBizGbn =="04"){
			            bizNm="응찰지명"; 
			            returnUrl ="/korean/pt/myCeart/BD_myCeartBidList.do";
			          }else if(data[i].alarmBizGbn =="05"){
			            bizNm="응찰지명"; 
			            returnUrl ="/korean/pt/suplerCeart/BD_bidPartcptnList.do";
			          }else if(data[i].alarmBizGbn =="06"){
			            bizNm="입찰공고"; 
			            returnUrl ="/korean/pt/suplerCeart/BD_bidPartcptnList.do";
			          }else if(data[i].alarmBizGbn =="07"){
			            bizNm="견적 관리"; //마이씨앗
			            returnUrl ="/korean/pt/myCeart/BD_myCeartBeforeRequestList.do";
			          }else if(data[i].alarmBizGbn =="08"){
			            bizNm="견적 관리"; //이용자씨앗
			          	returnUrl ="/korean/pt/suplerCeart/BD_beforeRequestList.do";
			          }
			          
		            listhtml += "<dt>"+bizNm+"</dt>";
		            url="/korean/Alarm/BD_aramCheck.do?sn="+data[i].alarmSeq+"&returnUrl="+returnUrl;
		            listhtml += "<dd><a href="+url+">"+data[i].alarmTitle+"</a></dd>";
		        }
		        listhtml += "</dl>";
		        $("#alarmlist").html(listhtml);
	    	}
	    },
	    error:       function () { 
	     //   alert('정상적으로 처리되지 않았습니다.'); 
	    }
	});
	</script>
	</c:if>
	