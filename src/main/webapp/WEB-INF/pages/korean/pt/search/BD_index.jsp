<%@page import="java.net.URLDecoder"%><%@page
	import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
String sessionID = (String)session.getId();
session.setAttribute("tempId", sessionID);
%>

<%@ page import="zes.openworks.intra.cms.support.CmsUtil,QueryAPI500.Search"%>
<%@ page import="java.text.DecimalFormat,
                 java.text.FieldPosition,
                 java.io.UnsupportedEncodingException,
                 java.io.*,
                 java.text.*,
				 javax.xml.parsers.*,
				 org.w3c.dom.*,
				 org.xml.sax.SAXException,
                 java.util.*"%>
<%@ include file="./common/WNAnchor.jsp"%>
<%
	Search search = new Search();
	Search search_col = new Search();
	int ret = 0;
	String START_DATE = "1970.01.01"; // 기본 시작일
	int viewCount = 20; // 더보기시 출력 건수
	String realSvrIP = "202.30.77.186";

	// 검색 필수 요소 Request
	//String totalKeyword = new String(getCheckReqXSS(request, "totalKeyword", "클라우드").getBytes("ISO-8859-1"), "UTF-8");//검색어
	String totalKeyword = getCheckReqXSS(request, "totalKeyword", "클라우드");//검색어
	
	String query = getCheckReqXSS(request, "query", totalKeyword);
	//String query = getCheckReqXSS(request, "query", "전체"); 

	String collection = getCheckReqXSS(request, "collection", "ALL");
	String sort = getCheckReqXSS(request, "sort", "RANK");
	String range = getCheckReqXSS(request, "range", "A");
	String startDate = getCheckReqXSS(request, "startDate", START_DATE);
	String endDate = getCheckReqXSS(request, "endDate", getCurrentDate());
	String searchField = getCheckReqXSS(request, "searchField", "");
	int startCount = Integer.parseInt(getCheckReqXSS(request, "startCount", "0")); // 최초페이지()

	// 필터 	
	String META1  = getCheckReqXSS(request, "sMeta1", ""); // 기업구분 
	String META2  = getCheckReqXSS(request, "sMeta2", ""); // 공공기관 이용 필터 > 국내 데이터센터 위치 / 나라장터종합쇼핑몰 서비스
	String META3  = getCheckReqXSS(request, "sMeta3", ""); // 계약단위
	String META4  = getCheckReqXSS(request, "sMeta4", ""); // 인증정보  
	String META5  = getCheckReqXSS(request, "sMeta5", ""); // 서비스기술지원 
	String META6  = getCheckReqXSS(request, "sMeta6", ""); // 호환성(표준)
	String META7  = getCheckReqXSS(request, "sMeta7", ""); // 클라우드 구축방식 
	String META8  = getCheckReqXSS(request, "sMeta8", ""); // 지원언어 
	String META9  = getCheckReqXSS(request, "sMeta9", ""); // 교육, 기술지원
	String META10 = getCheckReqXSS(request, "sMeta10", ""); // 관리정보제공
	String META11 = getCheckReqXSS(request, "sMeta11", ""); // 고객지원
	String META12 = getCheckReqXSS(request, "sMeta12", ""); // 서비스 구분
	String META13 = getCheckReqXSS(request, "sMeta13", ""); // 공공기관 이용 필터 > 클라우드서비스보안인증(CSAP)
 
/*  
	String META1  = getCheckReqXSS(request, "META1" , ""); // 중소기업 
	String META2  = getCheckReqXSS(request, "META2" , ""); // 무료체험  
	String META3  = getCheckReqXSS(request, "META3" , ""); // 계약단위
	String META4  = getCheckReqXSS(request, "META4" , ""); // 인증  
	String META5  = getCheckReqXSS(request, "META5" , ""); // 서비스관리 
	String META6  = getCheckReqXSS(request, "META6" , ""); // 호환성(표준)
	String META7  = getCheckReqXSS(request, "META7" , ""); // 구축방식 
	String META8  = getCheckReqXSS(request, "META8" , ""); // 지원언어 
	String META9  = getCheckReqXSS(request, "META9" , ""); // CSQC_LEVEL
	String META10 = getCheckReqXSS(request, "META10", ""); // CSQC_LEVEL
	String META11 = getCheckReqXSS(request, "META11", ""); // CSQC_LEVEL
	String META12 = getCheckReqXSS(request, "META12", ""); // CSQC_LEVEL
	String META13 = getCheckReqXSS(request, "META13", ""); // CSQC_LEVEL
 */	
	
	// filter조건
	/*
		검색 노출 순서
		1. 소프트웨어(프리미엄, 솔루션), 2. IT서비스(컨설팅), 3. 지식(커뮤니케이션), 4. 소개 (인트로덕션) 
		5. 비즈매칭(비드매칭) 6. 고객센터(커스토머)  7. 공지사항(노티스) 8. 나라장터입찰정보(narabid) 9. 나라장터 입찰계약(naracntrct) 10. 입찰공고(biddingnotice)
	*/

	// 2017.01.24 입찰공고컬렉션 추가
	String[] COLLECTIONS		= new String[]{  "cloud_service"
			                                   , "communication_cloud"
			                                   , "introduction_cloud"
			                                   , "bizmatc_cloud"
			                                   , "customer_cloud"
			                                   , "notice_cloud"
			                                   , "narabid_cloud"
			                                   , "naracntrct_cloud"
			                                   , "biddingnotice_cloud"};
	String[] SVC_COLLECTIONS	= new String[]{  "cloud_service"};
	String[] RESULT_COLLECTIONS	= new String[]{  "cloud_service"
			                                   , "communication_cloud"
			                                   , "introduction_cloud"
			                                   , "bizmatc_cloud"
			                                   , "customer_cloud"
			                                   , "notice_cloud"
			                                   , "narabid_cloud"
			                                   , "naracntrct_cloud"
			                                   , "biddingnotice_cloud"};
	
	String cloud_service_searchField    = "GOODSNM,GOODSSUMRY,LANGSTORENM,SMLPZ_CHK,SVC_MANAGE_STTUS_INFO_SUPLY,SVC_USE_LOG_SUPLY_AT,USER_EDC_SPORT_AT,VISIT_EDC_SPORT_AT,USER_MNL_SUPLY_AT,VISIT_TCHNLGY_SPORT_AT,VISIT_ELSE_TCHNLGY_SPORT_AT,S_SOURC_OTHBC_AT,S_API_ACCESS_SPORT_AT,S_DB_MIGRATION_SPORT_AT,S_MULTI_PLTFOM_SPORT_AT,S_OPEN_STD_SPORT_AT,S_GVRN_FRMWRK_SPORT_AT,S_OPEN_SOURC_SW_AT,S_PAASTA_AT,CLUSTERING_SPORT_AT,ATMC_ESTN_SPORT_AT,SLA_APPLC_AT,SFSRV_PROVISIONING_SPORT_AT,DATA_CNTER_LC_INFO,PRIVATE_CLOUD_AT,PUBLIC_CLOUD_AT,HYBRID_CLOUD_AT";
	String cloud_service_documentField  = "DOCID,REGISTDT,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTCINSTTCD,LANGNM,SLEMTHDNM,GOODSREGISTSTTUSNM,SELLCNT,EVLSCORE,LANGSTORENM,CMMNTYID,MARK_IMG,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13,ENTNM,CATE_NM,GOODSMAINIMAGE,CTGRY_CODE,LANG_CTGRY_NM,CTGRY_CL_CD,CTGRY_GROUP,CTGRY_DP,PARNTS_CTGRY_CODE,SUB_CNT,SMLPZ_CHK,SVC_MANAGE_STTUS_INFO_SUPLY,SVC_USE_LOG_SUPLY_AT,USER_EDC_SPORT_AT,VISIT_EDC_SPORT_AT,USER_MNL_SUPLY_AT,VISIT_TCHNLGY_SPORT_AT,VISIT_ELSE_TCHNLGY_SPORT_AT,S_SOURC_OTHBC_AT,S_API_ACCESS_SPORT_AT,S_DB_MIGRATION_SPORT_AT,S_MULTI_PLTFOM_SPORT_AT,S_OPEN_STD_SPORT_AT,S_GVRN_FRMWRK_SPORT_AT,S_OPEN_SOURC_SW_AT,S_PAASTA_AT,CLUSTERING_SPORT_AT,ATMC_ESTN_SPORT_AT,SLA_APPLC_AT,SFSRV_PROVISIONING_SPORT_AT,DATA_CNTER_LC_INFO,PRIVATE_CLOUD_AT,PUBLIC_CLOUD_AT,HYBRID_CLOUD_AT";
	
	String communication_searchField	= "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";
	String communication_documentField	= "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN/50,CN_SUMRY,SOURCENAME,CTGRY_NM,ATTACH_CON,CMMNTY_ID";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	
	String introduction_searchField		= "BODY_CNTNTS";
	String introduction_documentField	= "DOCID,REGIST_DT,HEAD_CNTNTS,BODY_CNTNTS/200,CONFM_STTUS,USER_MENU_URL,MENU_PATH";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	
	String bizmatc_searchField			= "BBSCTT_SJ,BBSCTT_CN";
	String bizmatc_documentField		= "DOCID,REGIST_DT,BBS_CD,BBSCTT_SEQ,BBSCTT_SJ,BBSCTT_CN/150,CN_SUMRY,CTGRY_NM,ATTACH_CON";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	
	String customer_searchField			= "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";
	String customer_documentField		= "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN/150,CN_SUMRY,ATTACH_CON,CTGRY_NM,SOURCENAME,PROGRESS_YN";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	
	String notice_searchField			= "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";
	String notice_documentField			= "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN/150,CN_SUMRY,FILE_SEQ,ATTACH_CON,MENU_PATH";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	
	String narabid_searchField			= "TITLE,ORDER_ORGN_NM,REAL_ORGN_NM";
	String narabid_documentField		= "DOCID,REG_DATE,TITLE,BID_UNION_NO,BID_NOTIFY_NO,BID_NOTIFY_SEQ_NO,START_DATE,ORDER_ORGN_NM,REAL_ORGN_NM,CNTRCT_MTH,BID_MTHD,SCSBID_MTH,BID_STRT_DATE,BID_END_DATE,PRSMP_AMT,SENDER_ID,MESS_TYPE,MESS_NM,DOCU_MANG_NO";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	
	String naracntrct_searchField 		= "TITLE,ORDER_ORGN_NM,REAL_ORGN_NM";
	String naracntrct_documentField		= "DOCID,REG_DATE,TITLE,CNTRCT_UNION_NO,CNTRCT_NO,CNTRCT_TYPE,CNTRCT_MTH,CNTRCT_PD,CNTRCT_AMT,BID_NOTIFY_NO,BID_NOTIFY_SEQ_NO,ORDER_ORGN_NM,REAL_ORGN_CODE,REAL_ORGN_NM,MAIN_CNTRCT_ENTRPS_TYPE,MAIN_CNTRCT_ENTRPS_NM,SENDER_ID,MESS_TYPE,MESS_NM,DOCU_MANG_NO,CNTRCT_ITEM_NM,CNTRCT_ITEM_AMT";//,META1,META2,META3,META4,META5,META6,META7,META8,META9,META10,META11,META12,META13";
	// 입찰공고 추가 2017.01.24
	String biddingnotice_searchField 	= "BID_NOTIFY_NM";
	String biddingnotice_documentField	= "DOCID,DATE,NOTIFY_NUM,NOTIFY_SEQ,VIEW_NOTIFY,BID_NOTIFY_NM,STRT_DT,CLSE_DT";

	query = URLDecoder.decode(query, "UTF-8");

	// 결과내 재검색 추가 2017.03.09
	String reQuery		= getCheckReqXSS(request, "reQuery", 	""); //결과내 재검색 체크필드
	String realQuery	= getCheckReqXSS(request, "realQuery", 	""); //결과내 검색어

	if (reQuery.equals("1")) {
		realQuery = realQuery + " " + query;
		//realQuery =  query + " " +  realQuery ;
	} else if (!reQuery.equals("2")) {
		realQuery = query;
	}

	String[] collections = null;
	String FilterString = getFilterString(META1, META2, META3, META4, META5, META6, META7, META8, META9, META10, META11, META12, META13);

	int QUERY_LOG = 1; // 서버에 쿼리로그 남기기(0:쿼리로그 남기지않음, 1:남김)
	int EXTEND_OR = 0; // 확장검색(검색어가 나오지 않을시 확장형 or검색 )	
	int RESULT_COUNT = 10;
	int USE_HIGHLIGHT = 1;
	int USE_SNIPPET = 1;
	
	int totalCountAll = 0;
	int resultCountAll = 0;
	int totalCount = 0;
	int resultCount = 0;
	int resultColCnt = 0;
	int resultColTotalCnt = 0;
	
	int resultCloudCnt = 0;
	int resultCommunicationCnt = 0;
	int resultIntroductionCnt = 0;
	int resultBizmatcCnt = 0;
	int resultCustomerCnt = 0;
	int resultNoticeCnt = 0;
	int resultNarabidCnt = 0;
	int resultNaracntrctCnt = 0;
	int resultBiddingnoticeCnt = 0;

	int USE_LA = 1;
	int IGNORE_CASE = 0;
	int USER_ORIGINAL = 1;
	int USER_SYNONYM = 1;

	int TOTALVIEWCOUNT = 50; //통합검색시 출력건수
	int COLLECTIONVIEWCOUNT = viewCount; //더보기시 출력건수

	

	if ("ALL".equals(collection)) { //통합검색
		collections = COLLECTIONS;
		COLLECTIONVIEWCOUNT = TOTALVIEWCOUNT;
	} else { //개별검색(시스템별)
		collections = new String[]{collection};
	}

/* 
	for (String colNm : COLLECTIONS) {
		totalCountAll	+= search.w3GetResultTotalCount(colNm);
		resultCountAll	+= search.w3GetResultCount(colNm);
	}
 */
 
	//단일 콜렉션 선택시
	ret = search_col.w3SetCodePage("UTF-8");
	ret = search_col.w3SetQueryLog(QUERY_LOG);
	//ret = search_col.w3SetCommonQuery( query, EXTEND_OR ); 
	ret = search_col.w3SetCommonQuery(realQuery, EXTEND_OR);

	for (String colNm : COLLECTIONS) {
		ret = search_col.w3AddCollection(colNm); //검색기 콜렉션 추가
		ret = search_col.w3SetPageInfo(colNm, startCount, COLLECTIONVIEWCOUNT);
		ret = search_col.w3SetRanking(colNm, "basic", "ropfm", 100);
		ret = search_col.w3SetSortField(colNm, sort + "/DESC");
		ret = search_col.w3SetHighlight(colNm, USE_HIGHLIGHT, USE_SNIPPET);
		ret = search_col.w3SetDateRange(colNm, startDate.replaceAll("[.]", "/"),
				endDate.replaceAll("[.]", "/"));
		ret = search_col.w3SetQueryAnalyzer(colNm, USE_LA, IGNORE_CASE, USER_ORIGINAL, USER_SYNONYM);
		
		System.out.println("colNm: " + colNm);
		
		if ("cloud_service".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, cloud_service_searchField);
			ret = search_col.w3SetDocumentField(colNm, cloud_service_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("communication_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, communication_searchField);
			ret = search_col.w3SetDocumentField(colNm, communication_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("introduction_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, introduction_searchField);
			ret = search_col.w3SetDocumentField(colNm, introduction_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("bizmatc_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, bizmatc_searchField);
			ret = search_col.w3SetDocumentField(colNm, bizmatc_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("customer_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, customer_searchField);
			ret = search_col.w3SetDocumentField(colNm, customer_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("notice_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, notice_searchField);
			ret = search_col.w3SetDocumentField(colNm, notice_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("narabid_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, narabid_searchField);
			ret = search_col.w3SetDocumentField(colNm, narabid_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("naracntrct_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, naracntrct_searchField);
			ret = search_col.w3SetDocumentField(colNm, naracntrct_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else if ("biddingnotice_cloud".equals(colNm)) {
			ret = search_col.w3SetSearchField(colNm, biddingnotice_searchField);
			ret = search_col.w3SetDocumentField(colNm, biddingnotice_documentField);
			if (colNm.equals(collection) && !"".equals(FilterString)) {
				ret = search_col.w3SetFilterQuery(colNm, FilterString);
			}
		} else {
			ret += search_col.w3SetFilterQuery(colNm, FilterString);
		}
	}
	// 운영
	ret = search_col.w3ConnectServer(realSvrIP, 7000, 1000); //202.30.77.186
	// 개발 
	//ret = search_col.w3ConnectServer( "202.30.77.190", 7000, 1000 );
	//ret = search_col.w3ConnectServer( "202.30.77.210", 7000, 1000 );
	ret = search_col.w3ReceiveSearchQueryResult(3);
	//ret = search_col.w3ReceiveSearchQueryResultAsXml(3);
	if (search_col.w3GetError() != 0) {
		out.println("<b>" + search_col.w3GetErrorInfo() + "</b>");

		return;
	}

/* 	for (String colNm : collections) {
		totalCount += search_col.w3GetResultTotalCount(colNm);
		resultCount += search_col.w3GetResultCount(colNm);
	}
*/
	resultCloudCnt 			= search_col.w3GetResultCount("cloud_service");
	resultCommunicationCnt	= search_col.w3GetResultCount("communication_cloud");
	resultIntroductionCnt	= search_col.w3GetResultCount("introduction_cloud");
	resultBizmatcCnt		= search_col.w3GetResultCount("bizmatc_cloud");
	resultCustomerCnt		= search_col.w3GetResultCount("customer_cloud");
	resultNoticeCnt			= search_col.w3GetResultCount("notice_cloud");
	resultNarabidCnt		= search_col.w3GetResultCount("narabid_cloud");
	resultNaracntrctCnt		= search_col.w3GetResultCount("naracntrct_cloud");
	resultBiddingnoticeCnt	= search_col.w3GetResultCount("biddingnotice_cloud");
	
	totalCountAll = resultCloudCnt + resultCommunicationCnt + resultIntroductionCnt + resultBizmatcCnt + resultCustomerCnt + resultNoticeCnt + resultNarabidCnt + resultNaracntrctCnt + resultBiddingnoticeCnt;
%>
<%!
	public String getFilterString(  String META1, String META2, String META3, String META4, String META5
			                          , String META6, String META7, String META8, String META9, String META10
			                          , String META11, String META12, String META13) {
		String[] arr_META1 = null;
		String[] arr_META2 = null;
		String[] arr_META3 = null;
		String[] arr_META4 = null;
		String[] arr_META5 = null;
		String[] arr_META6 = null;
		String[] arr_META7 = null;
		String[] arr_META8 = null;
		String[] arr_META9 = null;
		String[] arr_META10 = null;
		String[] arr_META11 = null;
		String[] arr_META12 = null;
		String[] arr_META13 = null;
		
		String FilterString = "";
		String tempString = "";
		if (!"".equals(META1) && META1 != null) {
			arr_META1 = META1.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META1.length; idx++) {
				if (idx == 0)
					tempString = "<META1:substring:" + arr_META1[idx] + ">";
				else
					tempString = tempString + " <META1:substring:" + arr_META1[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META2) && META2 != null) {
			arr_META2 = META2.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META2.length; idx++) {
				if (idx == 0)
					tempString = "<META2:substring:" + arr_META2[idx] + ">";
				else
					tempString = tempString + " <META2:substring:" + arr_META2[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META3) && META3 != null) {
			arr_META3 = META3.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META3.length; idx++) {
				if (idx == 0)
					tempString = "<META3:substring:" + arr_META3[idx] + ">";
				else
					tempString = tempString + " <META3:substring:" + arr_META3[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META4) && META4 != null) {
			arr_META4 = META4.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META4.length; idx++) {
				if (idx == 0)
					tempString = "<META4:substring:" + arr_META4[idx] + ">";
				else
					tempString = tempString + " <META4:substring:" + arr_META4[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META5) && META5 != null) {
			arr_META5 = META5.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META5.length; idx++) {
				if (idx == 0)
					tempString = "<META5:substring:" + arr_META5[idx] + ">";
				else
					tempString = tempString + " <META5:substring:" + arr_META5[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META6) && META6 != null) {
			arr_META6 = META6.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META6.length; idx++) {
				if (idx == 0)
					tempString = "<META6:substring:" + arr_META6[idx] + ">";
				else
					tempString = tempString + " <META6:substring:" + arr_META6[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META7) && META7 != null) {
			arr_META7 = META7.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META7.length; idx++) {
				if (idx == 0)
					tempString = "<META7:substring:" + arr_META7[idx] + ">";
				else
					tempString = tempString + " <META7:substring:" + arr_META7[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META8) && META8 != null) {
			arr_META8 = META8.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META8.length; idx++) {
				if (idx == 0)
					tempString = "<META8:substring:" + arr_META8[idx] + ">";
				else
					tempString = tempString + " <META8:substring:" + arr_META8[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		if (!"".equals(META9) && META9 != null) {
			arr_META9 = META9.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META9.length; idx++) {
				if (idx == 0)
					tempString = "<META9:substring:" + arr_META9[idx] + ">";
				else
					tempString = tempString + " <META9:substring:" + arr_META9[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}

		if (!"".equals(META10) && META10 != null) {
			arr_META10 = META10.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META10.length; idx++) {
				if (idx == 0)
					tempString = "<META10:substring:" + arr_META10[idx] + ">";
				else
					tempString = tempString + " <META10:substring:" + arr_META10[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		
		if (!"".equals(META11) && META11 != null) {
			arr_META11 = META11.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META11.length; idx++) {
				if (idx == 0)
					tempString = "<META11:substring:" + arr_META11[idx] + ">";
				else
					tempString = tempString + " <META11:substring:" + arr_META11[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		
		if (!"".equals(META12) && META12 != null) {
			arr_META12 = META12.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META12.length; idx++) {
				if (idx == 0)
					tempString = "<META12:substring:" + arr_META12[idx] + ">";
				else
					tempString = tempString + " <META12:substring:" + arr_META12[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		
		if (!"".equals(META13) && META13 != null) {
			arr_META13 = META13.split(",");
			tempString = "";
			for (int idx = 0; idx < arr_META13.length; idx++) {
				if (idx == 0)
					tempString = "<META13:substring:" + arr_META13[idx] + ">";
				else
					tempString = tempString + " <META13:substring:" + arr_META13[idx] + ">";
			}
			if (!"".equals(FilterString)) {
				FilterString = FilterString + " " + tempString;
			} else {
				FilterString = tempString;
			}
		}
		
		return FilterString;
	}
	//request변수 초기화
	public String getCheckReqXSS(javax.servlet.http.HttpServletRequest req, String parameter, String default_value) {
		String req_value = (req.getParameter(parameter) == null || req.getParameter(parameter).equals(""))
				? default_value
				: req.getParameter(parameter);
		req_value = req_value.replaceAll("</?[a-zA-Z][0-9a-zA-Zê°-\uD7A3ã±-ã=/\"\'%;:,._()\\-# ]+>", "");
		req_value = req_value.replaceAll(">", "");
		req_value = req_value.replaceAll(">", "");
		
		//System.out.println("req_value: " + req_value);
		return req_value;
	}

	//오늘날짜 가져오기
	public static String getCurrentDate() {
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy.MM.dd", java.util.Locale.KOREA);
		return dateFormat.format(new java.util.Date());
	}

	//페이징 Print
	public String getPageLinks(int startCount, int totalCount, int viewListCount, int bundleCount) {
		StringBuffer sbRet = new StringBuffer();
		WNAnchor wnanchor = getPageAnchor(startCount, totalCount, viewListCount, bundleCount);

		if (startCount != 0) {
			if (wnanchor.getCurPageNumber() >= 11) { // 고정값으로 해놓음
				sbRet.append("<a href=\"#\" onClick=\"javascript:doPaging('0');\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_first.gif\" alt=\"처음\"></a>");
			}
		} else {
			//sbRet.append("<a class=\"prev\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_first.gif\" alt=\"처음\"></a>");	
		}

		if (wnanchor.getCurPageNumber() != 1) {
			if (wnanchor.getCurPageNumber() >= 11) { // 고정값으로 해놓음
				sbRet.append("<a href=\"#\" class=\"goPrev\" onClick=\"javascript:doPaging('"
						+ viewListCount * (wnanchor.getCurPageNumber() - 2)
						+ "');\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_prev.gif\" alt=\"이전\"></a>");
			}
		} else {
			//sbRet.append("<a class=\"prev\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_prev.gif\" alt=\"이전\"></a>");
		}

		int pageCount = wnanchor.getPageCount();
		String pages[][] = wnanchor.getPages();
		sbRet.append("<span>");
		for (int i = 0; i < pageCount && i < pages.length; i++) {
			if (pages[i][1].equals("-1")) {
				sbRet.append("<a href=\"#\" class=\"on\">" + pages[i][0] + "</a>");
			} else {
				sbRet.append("<a href=\"#none\" onClick=\"javascript:doPaging('" + pages[i][1] + "');\" title=\"페이징\"> "
						+ pages[i][0] + " </a>");
			}
		}
		sbRet.append("</span>");
		/*
		if(wnanchor.getCurPageNumber() != wnanchor.getPageCount()) {
			sbRet.append("<a class=\"next\" href=\"#\" onClick=\"javascript:doPaging('"+viewListCount * (wnanchor.getCurPageNumber()) +"')\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_next.gif\" alt=\"다음\"></a>");
		} else {
			//sbRet.append("<a class=\"next\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_next.gif\" alt=\"다음\"></a>");
		}
		
		if(wnanchor.getCurPageNumber() != wnanchor.getPageCount()) {
			sbRet.append("<a class=\"next\" href=\"#\" onClick=\"javascript:doPaging('"+ wnanchor.getBundleNext() +  "')\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_end.gif\" alt=\"끝\"></a>");
		} else {
			//sbRet.append("<a class=\"next\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_end.gif\" alt=\"끝\"></a>");
		}
		*/
		if (wnanchor.getBundleNext() != -1) {
			if (wnanchor.getTotalPgCount() > 10) {
				sbRet.append("<a href=\"#\" class=\"goNext\" onClick=\"javascript:doPaging('"
						+ viewListCount * (wnanchor.getCurPageNumber())
						+ "')\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_end.gif\" alt=\"다음\"></a>");
			}

		} else {
			//sbRet.append("&nbsp;&nbsp;"+nextImg+"");
		}
		if (wnanchor.getLastPage() != -1) {
			if (wnanchor.getTotalPgCount() > 10) {
				sbRet.append("<a href=\"#\" class=\"goLast\" onClick=\"javascript:doPaging('" + wnanchor.getBundleNext()
						+ "')\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_end.gif\" alt=\"끝\"></a>");
			}

		} else {
			//sbRet.append("&nbsp;&nbsp;"+nnextImg+"");
		}
		return sbRet.toString();
	}

	//페이징 처리

	public WNAnchor getPageAnchor(int startNum, int totalcount, int resultCnt, int anchorSacle) {
		WNAnchor anchor = new WNAnchor();

		if (totalcount == 0) { //등록된 정보가 없으면 페이지 Anchor를 생성 하지 않는다.
			return anchor;
		}

		int curBunbleNum = startNum / (resultCnt * anchorSacle);
		int totalPageCnt = totalcount / resultCnt;
		if (totalcount % resultCnt > 0) {
			totalPageCnt++;
		}

		anchor.setTotalPgCount(totalPageCnt); // 전체 페이지 세팅

		if (startNum > 0) { // 이전 페이지
			int beforePg = startNum - resultCnt;
			anchor.setBefore(beforePg);
		}

		if (startNum + resultCnt < totalcount) { // 다음페이지
			int nextPg = startNum + resultCnt;
			anchor.setNext(nextPg);
		}

		//번들 뒤로 이동
		int bunbleBeforePg = (curBunbleNum - 1) * resultCnt * anchorSacle; //이전 번들로 이동하는 번호
		if (curBunbleNum > 0) {
			anchor.setBundleBefore(bunbleBeforePg);
		}

		//번들 앞으로 이동
		int bundleNextPg = (1 + curBunbleNum) * anchorSacle * resultCnt;
		if (totalPageCnt >= anchorSacle && (curBunbleNum + 1) * anchorSacle < totalPageCnt) {
			anchor.setBundleNext(bundleNextPg);
		}

		//맨처음..
		if (startNum != 0 && curBunbleNum != 0) {
			anchor.setFirstPage(0);
		}
		//맨끝...
		int lastPage = (resultCnt * totalPageCnt) - resultCnt;
		if (totalPageCnt >= anchorSacle && (curBunbleNum + 1) * anchorSacle < totalPageCnt) {
			anchor.setLastPage(lastPage);
		}

		int pageCount = 1;
		String[][] pages = new String[anchorSacle][2];
		for (int i = 0; i < anchorSacle; i++) {
			int startCnt = ((curBunbleNum * anchorSacle) + i) * resultCnt;
			int pageNum = (curBunbleNum * anchorSacle) + i + 1;
			if (startCnt < totalcount) {
				if (startCnt != startNum) {
					pages[i][0] = Integer.toString(pageNum);
					pages[i][1] = Integer.toString(startCnt);
				} else {
					pages[i][0] = Integer.toString(pageNum);
					pages[i][1] = "-1";
					anchor.setCurPageNumber(pageNum);
				}
				anchor.setPageCount(pageCount);
				pageCount++;
			}
		}
		anchor.setPages(pages);
		return anchor;
	}

	public static String parseDate(String input, String inFormat, String outFormat) {
		String retStr = "";
		Date date = null;
		SimpleDateFormat formatter = null;
		try {
			date = (new SimpleDateFormat(inFormat)).parse(input.trim());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		formatter = new SimpleDateFormat(outFormat);
		retStr = formatter.format(date);
		return retStr;
	}

	public static String numberFormat(int num) {
		return NumberFormat.getNumberInstance().format(num);
	}
	public static String numberFormat(long num) {
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(num);

	}%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"	src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"	src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
<!--<script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>-->
<script type="text/javascript"	src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
<!--<script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>-->
<script type="text/javascript"	src="/resources/web/theme/default/js/common.js"></script>

<script type="text/javascript" src="/resources/openworks/spi/jquery/notice/jquery.notice.js"></script>
<script type="text/javascript"	src="/resources/openworks/spi/jquery/printPreview/jquery.print-preview.js"></script>

<script type="text/javascript" src="/resources/openworks/spi/jquery/cookie/jquery.cookie.js"></script>

<script type="text/javascript" src="/resources/web/analyze/tracking/js/detector.js"></script>

<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>
<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>

<script type="text/javascript">

	$().ready(function () {
		
	    // 2017.11.29 eulro.yoon 추가
		// '서비스 비교 담기' 
		$('#svcCompare').click(function() {
			var items = []; 
		    var checkCnt = 0;
		    var sessionid = '${sessionScope.tempId}';
		    $('input:checkbox[name=goods_check]:checked').each(function () { 
		        	items.push($(this).val());
		        });
		    checkCnt = items.length;
		    if (checkCnt == 0 ) {
		        alert('비교하실 서비스는 적어도 1개 이상 선택 하셔야 합니다.');
		        return false;
		    }
		    _loadComare(items, '${sessionScope.tempId}', true);
		    $('input:checkbox[name=goods_check]:checked').attr("checked", false);
		}) ;
		
	    
	    var items = []; 
	    items.push('');
	    _loadComare(items, '${sessionScope.tempId}', false);
	});

	var _loadComare= function(items, sessionid, showflg){
	    $.ajax({
	        type     : "POST",
	        url      : "/myCeart/BD_goodsTmp.do",
	        data     : { "item"      : items
	                    ,"sessionId" : sessionid
	                   },
	        dataType : "json",
	        success  :function(data){
				var goodsHtml = "";//new StringBuffer();
	         
	         	$('#itemWrap').html('');	//append 초기화
	         	if(showflg){ // 아래 서비스 비교창을 보이도록한다.
	             	$('.location_wrap').animate({ bottom:'0' }, 300).addClass('active');
	    			$('.btn_compare').css('background-image','url(/cloud_ver3/html_web/images/icon_compareClose.png)')
	         	}
	         	$('#compCnt').text(data.length);
	                 
                for (i=0; i<data.length; i++) {
                	goodsHtml = '<li>';
                    goodsHtml = goodsHtml + '<span><label><input  type="checkbox"  id="goods_code" name="goods_code" goods_type="'+data[i].GOODSTYNM+'"  value='+data[i].GOODS_CODE+' class="goods_code"></label></span>'
                    goodsHtml = goodsHtml + '<span>['+data[i].GOODSTYNM+']</span> <span>'+data[i].GOODS_NM+'</span> ';
                    goodsHtml = goodsHtml + '<span class="btn_delete"><a href="#none" onClick="fnGoodsDelete(\''+data[i].GOODS_CODE+'\'); return false;">삭제</a></span>';
                    goodsHtml = goodsHtml + '</li>';
                    
                    $('#itemWrap').append(goodsHtml);
                }
                
                return false;
	        }
	    }); 
	}

    //서비스비교 전체선택/해제
	var fnGoodsCheckAll = function(obj){
	    var i;
	    var chk = document.getElementsByName("goods_code");
	    var tot = chk.length;
	    var checkedVal = $('.goods_code').prop("checked");
	        
	    if (checkedVal) {
	        $("input[name=goods_code]:checkbox").attr("checked", false);
	    }else{
	        $("input[name=goods_code]:checkbox").attr("checked", true);
	    }
    };
    
    //서비스비교
	var fnGoodsCheckComp = function(el){
        var items = []; 
        var checkCnt = 0;
        var sessionid = '${sessionScope.tempId}';
        var type=""; var checkType= true;
        $('input:checkbox[name=goods_code]:checked').each(function () { 
           	items.push($(this).val());
           	if(type == "") type=$(this).attr('goods_type');
           	if(type != $(this).attr('goods_type'))  checkType = false;
        });
        
        if(checkType == false){
	        alert("서비스 구분을 복합하여 선택하면 비교가 적용되지 않습니다.\n- 예 : IaaS, PaaS = 비교 불가\n        IaaS, IaaS = 비교 가능");
	        return false;
        }
        
        checkCnt = items.length;
        $(".btn_select a").removeClass("cboxElement");
        if(checkCnt > 3) {
            alert("선택상품 비교는 최대 3개까지 가능합니다.");
            return false;
        }else{
            $(el).colorbox({
                title        : "계약대상 선정",
                href         : "/korean/pt/popup/PD_dbGoodsPop.do?checkCnt="+checkCnt+"&items="+items+"&si="+sessionid,
                width        : "1190",
                height       : "700",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
        }
    };
	
    //전체비우기
    var _serCompareClear = function(){
        var items = [];
        var checkCnt = 0;
        var sessionid = '${sessionScope.tempId}';
        $('input:checkbox[name=goods_code]:checked').each(function () { 
            items.push($(this).val());
        });
        
        checkCnt = items.length;
 		
        if ($('#compCnt').text() != '0') {
	        if (confirm("정말 삭제하시겠습니까??") == true){
		        $.ajax({
		            type: "POST",
		            url: "/myCeart/BD_goodsTmpDelete.do",
		            data: {"item" : items, "sessionId" : sessionid},
		            dataType: "json",
		            success:function(data){
		                console.log("data: " + data);
		                $('#itemWrap').html('');
		                $('#compCnt').text("0");
		                $('#btnDel').unbind('click');
		                return false;
		            }
		        });
	        }else {
	            return false;
	        }
        }else{
            alert('삭제할 비교서비스가 없습니다.');
            return false;
        }
    };
    
    //개별 삭제
    var fnGoodsDelete = function (goodsCode) {
        var item = goodsCode;
        var sessionid = '${sessionScope.tempId}';
        
        if (confirm("정말 삭제하시겠습니까??") == true){
	        $.ajax({
	            type: "POST",
	            url: "/myCeart/BD_goodsTmpDelete.do",
	            data: {"item" : item, "sessionId" : sessionid},
	            dataType: "json",
	            success:function(data){
                 	$('#itemWrap').html('');	//append 초기화
                 	$('.serCompare').removeClass('hidden').addClass('on');
                 	$('#compCnt').text(data.length);
                    var goodsHtml="";
                    
                    for (var i=0; i<data.length; i++) {
                        goodsHtml = goodsHtml + "<li>"
                        goodsHtml = goodsHtml + '<span><label><input  type="checkbox"  id="goods_code" name="goods_code" value='+data[i].GOODS_CODE+' class="goods_code"></label></span>'
                        goodsHtml = goodsHtml + '<span>['+data[i].GOODSTYNM+']</span> <span>'+data[i].GOODS_NM+'</span> ';
                        goodsHtml = goodsHtml + '<span class="btn_delete"><a href="#none" onClick="fnGoodsDelete(\''+data[i].GOODS_CODE+'\'); return false;">삭제</a></span>';
                        goodsHtml = goodsHtml + '</li>';
                     $('#itemWrap').html(goodsHtml);
                    }
	                return false;
	            }
	        });
        }
        
    };
    

	  	$('.btn_open').on('click', function() {
			$('.filter_close').css('display','block');
		});
	  	$('.btn_close').on('click', function() {
			$('.filter_close').css('display','none');
		});
  	
	    // 좌측 메뉴 클릭
	    function doCollection(collection){
		    // 필터 초기화
		    //filterInit();
		    //$("#reQuery").val("2");
		    
	         createItem();
	         
	         $("#selecItemNames").val("");
			    
			    totalKeyword = document.getElementById("totalKeyword");
			    //totalKeyword = unescape(encodeURIComponent(totalKeywords));
			    if(totalKeyword.value == ""){
			        alert(Message.msg.enterSrchWrd);
			        totalKeyword.focus();
			        return;
			    }
			    $("#query").val($("#totalKeyword").val());
	         
	         //document.search.action = "BD_index.do";
	         document.search.elements["q_currPage"].value = "1";
		    
		    $("#collection").val(collection);
		    document.search.submit();
	    }
		
		// 메인 헤더에서 검색
		function fn_mainSearch(){
		    // 필터 초기화
		    filterInit();
		    //filterSet();
	      
		    //document.search.action = "BD_index.do";
	      //document.search.elements["q_currPage"].value = "1";
	      //document.search.submit();
		    
		    $("#selecItemNames").val("");
		    
		    totalKeyword = document.getElementById("totalKeyword");
		    //totalKeyword = unescape(encodeURIComponent(totalKeywords));
		    if(totalKeyword.value == ""){
		        alert(Message.msg.enterSrchWrd);
		        totalKeyword.focus();
		        return;
		    }
		    
		    //var filter_dtl_cnt = $("input[name='"+filter_name+"']").length;
		    
		    $("#query").val($("#totalKeyword").val());
		    //createItem();
		    document.search.submit();
		}
		
		// 필터 초기화
		function filterInit(){
		    $("#META1").val("");
		    $("#META2").val("");
		    $("#META3").val("");
		    $("#META4").val("");
		    $("#META5").val("");
		    $("#META6").val("");
		    $("#META7").val("");
		    $("#META8").val("");
		    $("#META9").val("");
		    $("#META10").val("");
		    $("#META11").val("");
		    $("#META12").val("");
		    $("#META13").val("");
		    
	        // 필터 갯수 만큼 for문 수행 - 소프트웨어
	        var filter_tot_cnt = "13";
	        
	        for(i=1; i<=filter_tot_cnt; i++){
	            var filter_name    = "sMeta" + i;              // 필터 체크박스 ID
	            var filter_dtl_cnt = $("input[name='"+filter_name+"']").length; // 필터 체크박스 element 갯수
	            
		        for(j=0; j<filter_dtl_cnt; j++){
		            $("input[name='"+filter_name+"']")[j].checked = false;
		        }
	        }
		}


		// 필터적용 검색
		function doCollectionFilter(){
		    // 검색 필터 셋팅
		    filterSet();
		    $("#reQuery").val("2");
		    // form submit
		    $("form[name=search]").submit();

		}

	    // 선택된 필터 셋팅
	    function filterSet(){
	        
	        // 필터 갯수
	        var filter_tot_cnt = "13";
	        
	        // 필터 갯수 만큼 for문 수행
	        for(i=1; i<=filter_tot_cnt; i++){
	            
	            var filter_name					= "sMeta" + i;  // 필터 체크박스 ID
	            var filter_dtl 					= $("input[name='"+filter_name+"']");
	            var filter_dtl_cnt			= $("input[name='"+filter_name+"']").length; 	// 필터 체크박스 element 갯수
	            var return_value   			= "";                                        	// 결과 반환값
	            var return_filter_name 	= "META" + i;                            			// 반환값 적용 컬럼명
	            var return_value   			= "";                                        	// 결과 반환값
	            
	            
	            //alert(filter_dtl_cnt);
			        for(j=0; j< filter_dtl_cnt; j++){
			        	
			        	console.log(filter_name+": " + $("input[name='"+filter_name+"']")[j].checked)

			            if($("input[name='"+filter_name+"']")[j].checked){
			                // 체크박스 코드값 가져오기
			                if(return_value == ""){
			                    return_value = $("input[name='"+filter_name+"']").eq(j).val();
			                }else{
			                    return_value = return_value + "," + $("input[name='"+filter_name+"']").eq(j).val();
			                }
			            }
			        }

		        	// 전달 파라미터 값 셋팅
		       		//alert(return_value);
		        	$("input[name='"+return_filter_name+"']").val(return_value);
	        }
	        
	    }
		
		
		
		// 페이징 처리 조회
		function doPaging(page){		   
		   	$("#startCount").val(page);
		   	$("#reQuery").val("2");
		   	
		    document.search.submit();
		}

		// 인기검색어 링크
		function fn_rankSearch(searchVal){

		    $("#query").val(searchVal);
		    document.search.submit();
		}
		
		// 연관검색어 링크
		function fn_relativeSearch(searchVal){

		    $("#query").val(searchVal);
		    $("#collection").val("ALL");
		    document.search.submit();
		}
		
		function recommend(query){
		    var recommend = "";
		    $.ajax({
		  	  type: "POST",
		  	  //url: "http://202.30.77.186:7800/manager/WNRun.do?target=recommend&label=_ALL_&datatype=xml&query="+query,
		  	  url: "./relative.do",
		  	  dataType: "xml",
		  	  data : {"query" : query, "target" : "recommend", "datatype" : "xml", "label" : "_ALL_"},
		  	  success: function(xml) {
		  	    str = "";
		  	    $(xml).find("Word").each(function(index){
		  	      //str += "<li><a href=\"javascript:fn_relativeSearch('" +  $(this).text() + "')\">" + $(this).text() + "</a></li>";
		  	      if(index == 0){
		  	        str += " <a href=\"javascript:fn_relativeSearch('" +  $(this).text() + "')\">" + $(this).text() + "</a>";
		  	      }else{
		  	        str += ", <a href=\"javascript:fn_relativeSearch('" +  $(this).text() + "')\">" + $(this).text() + "</a>";    
		  	      }
		  	    });
		  	    $("#relative").html(str);
		  	  },error: function(xhr,status,error){
		          //alert("code:"+xhr.status);

		      }
		  	});
		   
		}
		
		function popword(){
		    var recommend = "";
		    $.ajax({
		  	  type: "POST",
		  	  //url: "http://202.30.77.186:7800/manager/WNRun.do?target=recommend&label=_ALL_&datatype=xml&query="+query,
		  	  url: "./popword.do",
		  	  dataType: "xml",
		  	  data : {"target" : "popword", "datatype" : "xml", "range" : "W", "collection" : "_ALL_"},
		  	  success: function(xml) {
		  	    str = "";
		  	    $(xml).find("Query").each(function(){
		  	      str += "<li><a href=\"javascript:fn_rankSearch('" + $(this).text() + "');\">" + $(this).text() + "</a></li>";
		  	    });
		  	    $("#popword").html(str);
		  	  },error: function(xhr,status,error){
		          //alert("code:"+xhr.status);

		      }
		  	});
		   
		}
		
		$(document).ready(function() {
			recommend('<%=query%>');
			popword();

        $("#all_check").click(function() {
            if($("#all_check").is(":checked")) {
                $(".goods_check").attr("checked", true);
            } else {
                $(".goods_check").attr("checked", false);
            }
        });
    });

    // 판매자 링크
    var jsSeller = function(userId) {
        $("#userId").val(userId);
        document.search.action = "/korean/pt/store/BD_goodsOfSeller.do";
        document.search.elements["q_currPage"].value = "1";
        document.search.submit();
    };

    
    
    // 구매기록
    /* 
    <c:set var="flgChk" value="N" />
    <c:if test="${not empty sessionScope['MEM_CHK'] and  sessionScope['MEM_CHK'] eq 'Y'}">
    <c:set var="flgChk" value="Y" />
       
    var jsWishPurch = function(el) {
        <c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin;
        }
        </c:if>
    
        <c:if test="${not empty sessionScope['__usk']}">
            $(el).colorbox({
                title : "구매희망담기",
                href : "/korean/pt/popup/PD_wishOrderPop.do",
                width : "910",
                height : "300",
                overlayClose : false,
                escKey : false,
                iframe : true
            });
        </c:if>
        
    };
    </c:if>
     */
     
    // '이용희망목록 담기' 클릭
    var jsWishPurch = function(el, goodsTyCd) {
        <c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin;
        }
        </c:if>
        <c:if test="${not empty sessionScope['__usk']}">
        $(el).colorbox({
            title : "구매희망담기",
            href : "/korean/pt/popup/PD_wishOrderPop.do?goodsTyCd=" + goodsTyCd + "&mode=list",
            width : "910",
            height : "230",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
        </c:if>
    };

    // 결과내 재검색
    var temp_query = "";
    function checkReSearch() {
        //alert("aaaaa");
        var searchForm = document.search;
        var query = $("#totalKeyword").val();
        var reQuery = $("#reQuery").val();
        if(document.getElementById("reChk").checked == true) {
            //temp_query = query.value;
            temp_query = query;
            //reQuery.value = "1";
            $("#reQuery").val("1");
            //query.value = "";
            $("#totalKeyword").val("");
            //query.focus();
            $("#totalKeyword").focus();
        } else {
            //query.value = trim(temp_query);
            $("#totalKeyword").val(temp_query);
            //reQuery.value = "";
            $("#reQuery").val("");
            temp_query = "";
        }
    }
    
    
    function filterSearch() {
        /*  if($("input[type='checkbox']:checked").length < 1){
         	alert('1개이상 선택하세요');
         	return;
         } */
         createItem();
         
         $("#selecItemNames").val("");
		    
		    totalKeyword = document.getElementById("totalKeyword");
		    //totalKeyword = unescape(encodeURIComponent(totalKeywords));
		    if(totalKeyword.value == ""){
		        alert(Message.msg.enterSrchWrd);
		        totalKeyword.focus();
		        return;
		    }
		    $("#query").val($("#totalKeyword").val());
         
         //document.search.action = "BD_index.do";
         document.search.elements["q_currPage"].value = "1";
         document.search.submit();
     };
     
     function createItem(){
         var items = [];
         var itemsName = [];
         var selectItem12Len = $('input:checkbox[name="sMeta12"]:checked').length;
         if(selectItem12Len > 0) {
             $('input:checkbox[name=sMeta12]:checked').each(function () {
                	items.push($(this).val());
                	
                	if ($(this).val() == '1001') {
                		itemsName.push('IaaS');               	    
                	}
                	if ($(this).val() == '1002') {
                		itemsName.push('SaaS');
                	}
                	if ($(this).val() == '1003') {
                		itemsName.push('PaaS');
                	}
                	if ($(this).val() == '1004') {
                		itemsName.push('SCS');
                	}
                	
                	//alert($(this).val());
             });
             $("#sMeta3").val(items);
             //$("#selectNames").text(itemsName);
         }else{
             $("#sMeta3").remove();
         }
         
         
         if($('input:checkbox[name="sMeta5"]:checked').length > 0)
             $("#creteItem").html("<input type='hidden' name='sMeta5' value='3'>");
         else 
             $("#creteItem").html("");
    	 
/*     	 
         if($('input:checkbox[name="selectItem5"]:checked').length > 0)
         	$("#creteItem").html("<input type='hidden' name='selectItem5' value='3'>");
         else 
         	$("#creteItem").html(""); */
     }
     
     function initFilter() {
         var checkObjs = $("input[type='checkbox']:checked");
         $(".filter_result").text("");
         checkObjs.prop("checked", false);
     }
     
     

</script>
<!--[if lt IE 9]>
		<script src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<![endif]-->
</head>

<body>
	<!-- content -->
	<form name="search" id="search" action="BD_index.do" method="POST">
		<input type="hidden" id="q_currPage"  		name="q_currPage"       	value="${searchMap.q_currPage}" />
		<input type="hidden" id="q_sortName"  		name="q_sortName"       	value="${searchMap.q_sortName}" />
		<input type="hidden" id="q_sortOrder" 		name="q_sortOrder"      	value="${searchMap.q_sortOrder}" />
		<input type="hidden" id="ctgryCode"   		name="ctgryCode"        	value="${ctgry.ctgryCode}" />
		<input type="hidden" id="goodsCode"   		name="goodsCode"        	value="" />
		<input type="hidden" id="section"     		name="section"          	value="" />
		<input type="hidden" id="ctgryParentCode"	name="ctgryParentCode"  	value="${ctgryParentInit}">
		<input type="hidden" id="goodsTyCd"   		name="goodsTyCd"        	value="${goodsTyCd}">
		<input type="hidden" id="userId"	 	 	name="userId" 				value="">	
		<input type="hidden" id="goodsCheck"  		name="goodsCheck"       	value="" />
		
		<input type="hidden" id="query" 			name="query"				value="<%=query%>" /> 
		<input type="hidden" id="startCount" 		name="startCount"			value="0" /> 
		<input type="hidden" id="sort" 				name="sort"					value="<%=sort%>" /> 
		<input type="hidden" id="collection" 		name="collection"			value="<%=collection%>" /> 
		<input type="hidden" id="searchField"		name="searchField"			value="<%=searchField%>" /> 
		<input type="hidden" id="reQuery" 			name="reQuery" 				value="" /> 
		<input type="hidden" id="keyWord" 			name="keyWord" 				value="<%=query%>" /> 
		<input type="hidden" id="realQuery" 		name="realQuery"			value="<%=realQuery%>" />
		<input type="hidden" id="sMeta3" 			name="sMeta3"				value="" />
		<input type="hidden" id="META1" 			name="META1" 				value="" />
		<input type="hidden" id="META2" 			name="META2" 				value="" />
		<input type="hidden" id="META3" 			name="META3" 				value="" />
		<input type="hidden" id="META4" 			name="META4" 				value="" />
		<input type="hidden" id="META5" 			name="META5" 				value="" />
		<input type="hidden" id="META6" 			name="META6" 				value="" />
		<input type="hidden" id="META7" 			name="META7" 				value="" />
		<input type="hidden" id="META8" 			name="META8" 				value="" />
		<input type="hidden" id="META9" 			name="META9" 				value="" />
		<input type="hidden" id="META10" 			name="META10"				value="" />
		<input type="hidden" id="META11" 			name="META11"				value="" />
		<input type="hidden" id="META12" 			name="META12"				value="" />
		<input type="hidden" id="META13" 			name="META13"				value="" />
		<input type="hidden" id="selecItemNames"	name="selecItemNames"		value="" />
		
		<div class="conWrap new_schResult">
			<!--필터검색-->
<%
	if ("cloud_service".equals(collection)) {
%>
			<c:set var="selecItemNames" value="" /> 
			<div class="filter_area">
				<p>필터검색</p>
				<ul class="btn_top">
					<li><a href="#" onClick="initFilter();" class="btns st3">초기화</a></li>
					<!-- <li><a href="#" onClick="filterSearch();" class="btns st5">적용</a></li> -->
					<li><a href="#" onClick="filterSearch();" class="btns st5">적용</a></li>
				</ul>
				<div class="filter_St01 clearfix">
					<h3>공공기관 이용 필터</h3>
					<ul class="clearfix">
					<c:forEach items="${organUserList}" var="_organUserList" varStatus="status">
						<li>
							<c:if test="${_organUserList.prvCd eq '1001'}">
								<c:set var="codeval" value="1004" />
								<input type="checkbox" id="sMeta13" name="sMeta13" value="${codeval}" <c:if test="${fn:contains(sMeta13,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
							</c:if>
							<c:if test="${_organUserList.prvCd ne '1001'}">
								<c:set var="codeval" value="2060${_organUserList.prvCd}" />
								<input type="checkbox" id="sMeta2" name="sMeta2" value="${codeval}" <c:if test="${fn:contains(sMeta2,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
							</c:if>
							<label>${_organUserList.prvNm}</label>
						</li>
					</c:forEach>
					</ul>
				</div>
				<div class="filter_St01 clearfix">
					<h3>서비스 구분</h3>
					<ul class="clearfix">
						<li>
							<label>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1003" <c:if test="${fn:contains(param.sMeta12,'1003')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / IaaS" /></c:if> />
						 		IaaS
						 	</label>
						</li>
						<li>
							<label>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1002" <c:if test="${fn:contains(param.sMeta12,'1002')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SaaS" /></c:if> /> 
						 		SaaS
						 	</label>
						</li>
						<li>
							<label>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1001" <c:if test="${fn:contains(param.sMeta12,'1001')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / PaaS" /></c:if> /> 
						 		PaaS
						 	</label>
						</li>
						<li>
							<label>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1004" <c:if test="${fn:contains(param.sMeta12,'1004')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SCS" /></c:if> /> 
						 		SCS
						 	</label>
						</li>		
					</ul>
				</div>
				<div class="filter_St01 clearfix">
					<h3>클라우드 구축방식</h3>
					<ul class="clearfix">
						<c:forEach items="${buildMethodList}" var="_buildMethodList" varStatus="status">
						<li>
							<c:set var="codeval" value="2032${_buildMethodList.prvCd}" />
							<label>
								<input type="checkbox" id="sMeta7" name="sMeta7" value="${codeval}"  <c:if test="${fn:contains(sMeta7,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_buildMethodList.prvNm} " /> </c:if>/> 
								${_buildMethodList.prvNm}
							</label>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="filter_St01 clearfix">
					<h3>인증정보</h3>
					<ul class="clearfix">
					<c:forEach items="${certificationList}" var="_certificationList" varStatus="status">
						<li>
							<c:set var="codeval" value="${_certificationList.prvCd}" />
							<label>
								<input type="checkbox" id="sMeta4" name="sMeta4" value="${codeval}" <c:if test="${fn:contains(sMeta4,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_certificationList.prvNm} " /> </c:if>/> 
								${_certificationList.prvNm}
							</label>
						</li>
					</c:forEach>
					</ul>
				</div>
				<a href="#none" class="btn_open">확장</a>
				<div class="filter_close">
					<a href="#none" class="btn_close">숨김</a>
					<div class="filter_St01 clearfix">
						<h3>서비스기술지원</h3>
						<ul class="clearfix">
							<c:forEach items="${serviceManageList}" var="_serviceManageList" varStatus="status">
							<c:set var="codeval" value="2030${_serviceManageList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" id="sMeta5" name="sMeta5" value="${codeval}" <c:if test="${fn:contains(sMeta5,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_serviceManageList.prvNm} " /></c:if>/> 
									${_serviceManageList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>호환성 지원</h3>
						<ul class="clearfix">
						<c:forEach items="${compatibilityList}" var="_compatibilityList" varStatus="status">
							<c:set var="codeval" value="2031${_compatibilityList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" id="sMeta6" name="sMeta6" value="${codeval}" <c:if test="${fn:contains(sMeta6,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_compatibilityList.prvNm} " /> </c:if>/> 
									${_compatibilityList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>개발지원</h3>
						<ul class="clearfix">
						<c:forEach items="${deploySupportList}" var="_deploySupportList" varStatus="status">
							<c:set var="codeval" value="2056${_deploySupportList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" id="sMeta8" name="sMeta8" value="${codeval}" <c:if test="${fn:contains(sMeta8,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_deploySupportList.prvNm} " /></c:if>/> 
									${_deploySupportList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>교육, 기술지원</h3>
						<ul class="clearfix">
						<c:forEach items="${eduTechSupportList}" var="_eduTechSupportList" varStatus="status">
							<li>
								<label>
									<c:set var="codeval" value="2057${_eduTechSupportList.prvCd}" />
									<input type="checkbox" id="sMeta9" name="sMeta9" value="${codeval}" <c:if test="${fn:contains(sMeta9,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_eduTechSupportList.prvNm} " /></c:if>/> 
									${_eduTechSupportList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>관리정보제공</h3>
						<ul class="clearfix">
						<c:forEach items="${mangerInfotList}" var="_mangerInfotList" varStatus="status">
							<li>
								<label>
									<c:set var="codeval" value="2058${_mangerInfotList.prvCd}" />
									<input type="checkbox" id="sMeta10" name="sMeta10" value="${codeval}" <c:if test="${fn:contains(sMeta10,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_mangerInfotList.prvNm} " /></c:if>/> 
									${_mangerInfotList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>기업구분</h3>
						<ul class="clearfix">
							<li><input type="checkbox" id="sMeta1" name="sMeta1" value="Y" <c:if test="${fn:contains(sMeta1,'Y')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중소기업 " /> </c:if> /> <label>중소기업</label></li>
					  		<li><input type="checkbox" id="sMeta1" name="sMeta1" value="M" <c:if test="${fn:contains(sMeta1,'M')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중견기업 " /> </c:if> /> <label>중견기업</label></li>
					    	<li><input type="checkbox" id="sMeta1" name="sMeta1" value="B" <c:if test="${fn:contains(sMeta1,'B')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 대기업 " /> </c:if> /> <label>대기업</label></li>
					    </ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>고객지원 </h3>
						<ul class="clearfix">
						<c:forEach items="${customSupportList}" var="_customSupportList" varStatus="status">
							<li>
								<label>
									<c:set var="codeval" value="2059${_customSupportList.prvCd}" />
									<input type="checkbox" id="sMeta11" name="sMeta11"  value="${codeval}" <c:if test="${fn:contains(sMeta11,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_customSupportList.prvNm} " /></c:if> />
						 			${_customSupportList.prvNm}
						 		</label>
						 	</li>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div>
<%
	}else{
%>
<div class="filter_area">
</div>
<%
	}
%>
	        <!--필터검색 end-->
			<div class="list_product">
			<!-- 필터 적용 결과 -->
			<!-- <p class="filter_result"><i>CC인증</i> 필터 적용 결과 입니다.</p> -->
			<c:if test="${not empty selecItemNames}">
			<p class="filter_result"><i>${fn:replace(fn:substring(selecItemNames,3,fn:length(selecItemNames)),'/',',')}</i> 필터 적용 결과 입니다.</p>
			</c:if>
			<!-- //필터 적용 결과 -->
				<ul class="nav_list">
					<li><a href="javascript:doCollection('ALL')"                 <%="ALL".equals(collection) ? "class=\"select\"" : ""%>                ><strong>전체</strong> (<%=totalCountAll%>)</a></li>
					<li><a href="javascript:doCollection('cloud_service')"       <%="cloud_service".equals(collection) ? "class=\"select\"" : ""%>      ><strong>클라우드서비스</strong> (<%=resultCloudCnt%>건)</a></li>
 					<li><a href="javascript:doCollection('communication_cloud')" <%="communication_cloud".equals(collection) ? "class=\"select\"" : ""%>><strong>클라우드허브</strong> (<%=resultCommunicationCnt%>건)</a></li>
					<li><a href="javascript:doCollection('introduction_cloud')"  <%="introduction_cloud".equals(collection) ? "class=\"select\"" : ""%> ><strong>소개</strong> 	(<%=resultIntroductionCnt%>건)</a></li>
					<li><a href="javascript:doCollection('bizmatc_cloud')"       <%="bizmatc_cloud".equals(collection) ? "class=\"select\"" : ""%>      ><strong>비즈매칭</strong> (<%=resultBizmatcCnt%>건)</a></li>
					<li><a href="javascript:doCollection('customer_cloud')"      <%="customer_cloud".equals(collection) ? "class=\"select\"" : ""%>     ><strong>고객센터</strong> (<%=resultCustomerCnt%>건)</a></li>
					<li><a href="javascript:doCollection('notice_cloud')"        <%="notice_cloud".equals(collection) ? "class=\"select\"" : ""%>       ><strong>공지사항</strong> (<%=resultNoticeCnt%>건)</a></li>
					<li><a href="javascript:doCollection('narabid_cloud')"       <%="narabid_cloud".equals(collection) ? "class=\"select\"" : ""%>      ><strong>나라장터<br />입찰정보<br /></strong> (<%=resultNarabidCnt%>건)</a></li>
					<li><a href="javascript:doCollection('naracntrct_cloud')"    <%="naracntrct_cloud".equals(collection) ? "class=\"select\"" : ""%>   ><strong>나라장터<br />계약정보<br /></strong> (<%=resultNaracntrctCnt%>건)</a></li>
					<li><a href="javascript:doCollection('biddingnotice_cloud')" <%="biddingnotice_cloud".equals(collection) ? "class=\"select\"" : ""%>><strong>입찰공고</strong> (<%=resultBiddingnoticeCnt%>건)</a></li>
				</ul>
				<!-- <p class="tit">SaaS<span>(N건)</span></p> -->
				<div class="btnArea">
					<div class="f_l">
						<!--span id="svcCompare" style="cursor:pointer;" class="btns st5" >비교</span-->
					</div>
					<div class="f_r">
						<!-- <a href="#" class="btns st1">이용희망목록 담기</a> -->
						<a href="#"  onclick="jsWishPurch(this,'list');" class="btns st1">이용희망목록 담기</a>
						<span class="sel_box jqtransformdone" style="width: 121px;">
							<div class="jq_sel" style="z-index: 50;">
								<div><span>최신 등록순</span><a href="#none" class="jqTransformSelectOpen" title="선택" style="cursor: pointer;"></a></div>
								<ul style="width: 121px; visibility: visible; display: block;">
									<li><a href="#" index="0" class="selected">최신 등록순</a></li>
									<li><a href="#" index="1">조회순</a></li>
								</ul>
								<span class="selectbox_title jq_sel_hide" style="width: 75px; vertical-align: middle; display: none; cursor: pointer;"><strong>최신 등록순</strong></span> 
								<select name="q_searchKeyType" id="q_searchKeyType" onchange="selectSort(this.value,'1001');" class="jq_sel_hide" style="position: absolute; left: -100000px; display: none; height: auto;">
									<option value="1" selected="selected">최신 등록순</option>
									<option value="3">조회순</option>
								</select>
							</div>
						</span>
					</div>
				</div>
				<ul class="view_list">
<%
String colNmStr = "";

if (totalCountAll > 0) { 
	if ("ALL".equals(collection)) {
%>
<%
		for (String colNm : COLLECTIONS) {
			resultColTotalCnt = search_col.w3GetResultTotalCount(colNm);
			resultColCnt = search_col.w3GetResultCount(colNm);

			if(resultColCnt > 0){
				for(int i=0; i < resultColCnt; i++){
					String DOCID = search_col.w3GetField(colNm,"DOCID",i);
					String URL   = ""; //"/korean/pt/store/inc/BD_storeView.do?goodsCode=" +DOCID;
					String MARK_IMG = search_col.w3GetField(colNm,"MARK_IMG",i);
					String[] MARK_IMG_ARRAY = null;
					MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");
					String REGISTDT = search_col.w3GetField(colNm, "REGISTDT", i);
					String USERID = search_col.w3GetField(colNm, "USERID", i);
					String GOODSMAINIMAGE = search_col.w3GetField(colNm, "GOODSMAINIMAGE", i);
					String GOODSNM = search_col.w3GetField(colNm, "GOODSNM", i);
					String LANGSTORENM = search_col.w3GetField(colNm, "LANGSTORENM", i);
					String GOODSSUMRY = search_col.w3GetField(colNm, "GOODSSUMRY", i);
%>
<%	
			if (("cloud_service").equals(colNm)) {
			/* if (("cloud_service").equals(colNm)) { */
				/* colNmStr = "[PaaS] "; */
				colNmStr = "[클라우드서비스] ";
				URL = "/korean/pt/store/inc/BD_storeView.do?goodsCode="+DOCID+"&ctgryCode=";
%>
				<fmt:parseDate value='<%=REGISTDT%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
					<li>
						<p class="name_product">
							<input type="checkbox" id="goods_check" name="goods_check" class="goods_check" value='<%=DOCID %>'>
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=GOODSNM.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company">
							<a href="javascript:location.href='<%=URL%>'"><%=LANGSTORENM.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a><span>|</span><fmt:formatDate value="${registDt}" pattern="yyyy.MM.dd"/>
						</p>
						<p class="txt_product">
							<a href="javascript:location.href='<%=URL%>'"><%=GOODSSUMRY.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						</p>			
					</li>
<%
			}
%>
<%
			if (("communication_cloud").equals(colNm)) {
				colNmStr = "[클라우드허브] ";
				String BBS_CD	  	= search_col.w3GetField(colNm,"BBS_CD",i);
				String SOURCENAME = search_col.w3GetField(colNm,"SOURCENAME",i);
				String CMMNTY_ID  = search_col.w3GetField(colNm,"CMMNTY_ID",i);
				String CTGRY_NM	  = search_col.w3GetField(colNm,"CTGRY_NM",i);
				String CATE_NM   	= "" ; 
		
            	if (("community").equals(SOURCENAME)) {
            		CATE_NM = "홈 &gt; 클라우드허브 &gt; " + CTGRY_NM;
            		URL = "/community/" + CMMNTY_ID;
            	} else if ("communication".equals(SOURCENAME)) {
            		CATE_NM = "홈 &gt; 클라우드허브 &gt; " + CTGRY_NM;
            		URL ="/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID; 
		        }
						
		        String BBSCTT_SJ = search_col.w3GetField(colNm, "BBSCTT_SJ", i);
		        String BBSCTT_CN = search_col.w3GetField(colNm, "BBSCTT_CN", i);
		        REGISTDT = search_col.w3GetField(colNm, "REGIST_DT", i);
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company">
							<a href="<%=URL%>"><%=CATE_NM %></a><span>|</span><%=REGISTDT%>
						</p>
						<p class="txt_product">
							<a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						</p>			
					</li>
<%
			}
%>
<%
			if (("introduction_cloud").equals(colNm)) {
				colNmStr = "[소개] ";
				URL = search_col.w3GetField(colNm,"USER_MENU_URL",i);
				String Data1 = search_col.w3GetField(colNm, "REGIST_DT", i);
				Data1 = Data1.substring(0, 10);
				String HEAD_CNTNTS = search_col.w3GetField(colNm, "HEAD_CNTNTS", i);
				String BODY_CNTNTS = search_col.w3GetField(colNm, "BODY_CNTNTS", i);
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=HEAD_CNTNTS.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company"><%=Data1%></p>
						<p class="txt_product">
							<a href="<%=URL%>"><%= BODY_CNTNTS.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						</p>
					</li>
<%
			}
%>
<%
			if (("bizmatc_cloud").equals(colNm)) {
				colNmStr = "[비즈매칭] ";
                String BBS_CD	  = search_col.w3GetField(colNm,"BBS_CD",i);
				URL = "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
				String BBSCTT_SJ = search_col.w3GetField(colNm, "BBSCTT_SJ", i);
				String BBSCTT_CN = search_col.w3GetField(colNm, "BBSCTT_CN", i);
				REGISTDT = search_col.w3GetField(colNm, "REGIST_DT", i);
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company"><%=REGISTDT%></p>
						<p class="txt_product"><a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></p>			
					</li>
<%
			}
%>
<%
			if (("customer_cloud").equals(colNm)) {
				colNmStr = "[고객센터] ";
				String PROGRESS_YN = search_col.w3GetField(colNm,"PROGRESS_YN",i);
                String BBS_CD	   = search_col.w3GetField(colNm,"BBS_CD",i);
                
        	    if (PROGRESS_YN.length() > 0) {
        	    	// 이벤트 항목은 항상 상세조회 할 수 있도록 수정[2016.01.29]
        	    	PROGRESS_YN = "Y";
        	    	URL = "/korean/pt/webevent/BD_eventView.do?eventSn=" + DOCID + "&flag=" + PROGRESS_YN;
        	    } else {
        	    	URL = "/web/board/BD_board.list.do?domainCd=2&bbsCd=" + BBS_CD;
        	    }
        	    
        	    String CTGRY_NM = search_col.w3GetField(colNm, "CTGRY_NM", i);
        	    String BBSCTT_SJ = search_col.w3GetField("customer_cloud", "BBSCTT_SJ", i);
        	    String BBSCTT_CN = search_col.w3GetField("customer_cloud", "BBSCTT_CN", i);
        	    REGISTDT = search_col.w3GetField("customer_cloud", "REGIST_DT", i);
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company"><%=REGISTDT%></p>
						<p class="txt_product">
							<a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						</p>			
					</li>
<%
			}
%>
<%
			if (("notice_cloud").equals(colNm)) {
				colNmStr = "[공지사항] ";
				DOCID      = search_col.w3GetField(colNm,"DOCID",i);
				String BBS_CD	  = search_col.w3GetField(colNm,"BBS_CD",i);
				URL 		  = "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
				String Data1 = search_col.w3GetField(colNm, "REGIST_DT", i);
				REGISTDT = Data1.substring(0, 10);
				String BBSCTT_SJ = search_col.w3GetField(colNm, "BBSCTT_SJ", i);
				String BBSCTT_CN = search_col.w3GetField(colNm, "BBSCTT_CN", i);
				
				if ("[CEART NEWS]".equals(BBSCTT_SJ.substring(0, 12))) {
					colNmStr = "[씨앗 블로그]";
					BBSCTT_SJ = BBSCTT_SJ.replace("[CEART NEWS]", "");
				}
				
				if ("[공지사항]".equals(BBSCTT_SJ.substring(0, 6))) {
					BBSCTT_SJ = BBSCTT_SJ.replace("[공지사항]", "");
				}
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
							
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company"><%=REGISTDT%></p>
						<p class="txt_product">
							<a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						</p>			
					</li>
<%
			}
%>
<%
			if (("narabid_cloud").equals(colNm)) {
				colNmStr = "[나라장터 입찰정보] ";
				
        String BIDNO      = search_col.w3GetField("narabid_cloud","BID_NOTIFY_NO",i);
        String BIDSEQ	  = search_col.w3GetField("narabid_cloud","BID_NOTIFY_SEQ_NO",i);
				URL        = "http://www.g2b.go.kr:8081/ep/invitation/publish/bidInfoDtl.do?bidno="+BIDNO+"&bidseq="+BIDSEQ;
				String Data1 = search_col.w3GetField("narabid_cloud", "REGIST_DT", i);
				String TITLE = search_col.w3GetField("narabid_cloud", "TITLE", i);
				String BID_STRT_DATE = search_col.w3GetField("narabid_cloud", "BID_STRT_DATE", i);
				String BID_END_DATE = search_col.w3GetField("narabid_cloud", "BID_END_DATE", i);
				String ORDER_ORGN_NM = search_col.w3GetField("narabid_cloud", "ORDER_ORGN_NM", i);
				String REAL_ORGN_NM = search_col.w3GetField("narabid_cloud", "REAL_ORGN_NM", i);
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'" target="_blank"><%=colNmStr%><%=TITLE.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company">
							게시일자(마감일자) : <%=BID_STRT_DATE %> (<%=BID_END_DATE %>)
						</p>
						<p class="txt_product">
							공고기관 : <%=ORDER_ORGN_NM %> </br></br>
							수요기관 : <%=REAL_ORGN_NM %>
						</p>			
					</li>
<%
			}
%>
<%
			if (("naracntrct_cloud").equals(colNm)) {
				colNmStr = "[나라장터 계약정보] ";
				
        String CNTRCT_UNION_NO = search_col.w3GetField("naracntrct_cloud","CNTRCT_UNION_NO",i);
				URL    = "http://www.g2b.go.kr:8067/contract/contDetail.jsp?Union_number="+CNTRCT_UNION_NO;
				String Data1 = search_col.w3GetField("naracntrct_cloud", "REGIST_DT", i)+ " ";
				String TITLE = search_col.w3GetField("naracntrct_cloud", "TITLE", i);
				String REG_DATE = search_col.w3GetField("naracntrct_cloud", "REG_DATE", i);
				String CNTRCT_ITEM_AMT = search_col.w3GetField("naracntrct_cloud", "CNTRCT_ITEM_AMT", i);
				long CNTRCT_ITEM_AMT_LONG = Long.parseLong(CNTRCT_ITEM_AMT) ;
				CNTRCT_ITEM_AMT = numberFormat(CNTRCT_ITEM_AMT_LONG);
				
				String ORDER_ORGN_NM = search_col.w3GetField("naracntrct_cloud", "ORDER_ORGN_NM", i);
				String REAL_ORGN_NM = search_col.w3GetField("naracntrct_cloud", "REAL_ORGN_NM", i);
%>
					<fmt:parseDate value='<%=REGISTDT%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=TITLE.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company">
							계약일자 : <fmt:formatDate value="${registDt}" pattern="yyyy.MM.dd"/>
						</p>
						<p class="txt_product">
							계약금액 : <%=CNTRCT_ITEM_AMT %>원 </br></br>
							계약기관 : <%=ORDER_ORGN_NM %> </br></br>
							수요기관 : <%=REAL_ORGN_NM %>	
						</p>			
					</li>
<%
			}
%>
<%
			if (("biddingnotice_cloud").equals(colNm)) {
				colNmStr = "[입찰공고] ";
				
        String NOTIFY_NUM = search_col.w3GetField("biddingnotice_cloud","NOTIFY_NUM", i);
        String NOTIFY_SEQ = search_col.w3GetField("biddingnotice_cloud","NOTIFY_SEQ", i);
				URL  = "http://www.ceart.kr/korean/pt/bidSttus/BD_bidSttusDetailView.do" + "?p_notifyNum="+NOTIFY_NUM + "&p_notifySeq="+NOTIFY_SEQ;
				
				String BID_NOTIFY_NM = search_col.w3GetField("biddingnotice_cloud", "BID_NOTIFY_NM", i);
				String VIEW_NOTIFY = search_col.w3GetField("biddingnotice_cloud", "VIEW_NOTIFY", i);
				String STRT_DT = search_col.w3GetField("biddingnotice_cloud", "STRT_DT", i);
				String CLSE_DT = search_col.w3GetField("biddingnotice_cloud", "CLSE_DT", i);
%>
					<li>
						<p class="name_product">
							<!-- <input name="" type="checkbox" value="" /> -->
								<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BID_NOTIFY_NM.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
								<!-- span><img src="/images/icon_confirm3.jpg"></span -->
						</p>
						<p class="name_company">
							공고번호 : <%=VIEW_NOTIFY %>
						</p>
						<p class="txt_product">
							접수일시 : <%=STRT_DT%> </br></br>
							마감일시 : <%=CLSE_DT%> 
						</p>			
					</li>
<%
			}
%>
<%
				}//for resultColCnt End */
%>
<%
			}//if resultColCnt End
%>
<%
		}//for (String colNm : COLLECTIONS)
%>
<%
	}else{ //ALL End
%>
<!-- SaaS, PaaS, IaaS List -->
<%
		if ("cloud_service".equals(collection)) {
			colNmStr = "[클라우드서비스] ";
			resultColTotalCnt = search_col.w3GetResultTotalCount("cloud_service");// + search_col.w3GetResultTotalCount("saas_cloud") + search_col.w3GetResultTotalCount("iaas_cloud");
			resultColCnt = search_col.w3GetResultCount("cloud_service");// + search_col.w3GetResultCount("saas_cloud") + search_col.w3GetResultCount("iaas_cloud");
	
			if (resultColCnt > 0) {
					for (int i= 0; i < resultColCnt; i++) {
						String DOCID = search_col.w3GetField("cloud_service","DOCID",i);
						String URL   = ""; //"/korean/pt/store/inc/BD_storeView.do?goodsCode=" +DOCID;
						String MARK_IMG = search_col.w3GetField("cloud_service","MARK_IMG",i);
						String[] MARK_IMG_ARRAY = null;
						MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");
						
						String REGISTDT = search_col.w3GetField("cloud_service", "REGISTDT", i);
						String USERID = search_col.w3GetField("cloud_service", "USERID", i);
						String GOODSMAINIMAGE = search_col.w3GetField("cloud_service", "GOODSMAINIMAGE", i);
						String GOODSNM = search_col.w3GetField("cloud_service", "GOODSNM", i);
						String LANGSTORENM = search_col.w3GetField("cloud_service", "LANGSTORENM", i);
						String GOODSSUMRY = search_col.w3GetField("cloud_service", "GOODSSUMRY", i);
						URL = "/korean/pt/store/inc/BD_storeView.do?goodsCode="+DOCID+"&ctgryCode=";
			
						if (DOCID != "") {
%>
			<fmt:parseDate value='<%=REGISTDT%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
				<li>
					<p class="name_product">
						<input type="checkbox" id="goods_check" name="goods_check" class="goods_check" value='<%=DOCID %>'>
						<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=GOODSNM.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
						<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company">
						<a href="#"><%=LANGSTORENM.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a><span>|</span><fmt:formatDate value="${registDt}" pattern="yyyy.MM.dd"/>
					</p>
					<p class="txt_product">
						<a href="#"><%=GOODSSUMRY.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</p>			
				</li>
<%
					}
				}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
//if ()
	if (("communication_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("communication_cloud");
		resultColCnt = search_col.w3GetResultCount("communication_cloud");
			
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[클라우드허브] ";
				String BBS_CD	  = search_col.w3GetField(collection,"BBS_CD",i);
				String SOURCENAME = search_col.w3GetField(collection,"SOURCENAME",i);
				String CMMNTY_ID  = search_col.w3GetField(collection,"CMMNTY_ID",i);
				String CTGRY_NM	  = search_col.w3GetField(collection,"CTGRY_NM",i);
				String CATE_NM   = "" ; 
				String URL = "";
				String BBSCTT_SJ = search_col.w3GetField(collection, "BBSCTT_SJ", i);
		        String BBSCTT_CN = search_col.w3GetField(collection, "BBSCTT_CN", i);
		        String REGISTDT = search_col.w3GetField(collection, "REGIST_DT", i);
		        String DOCID = search_col.w3GetField(collection,"DOCID",i);
				
				if (("community").equals(SOURCENAME)) {
					CATE_NM = "홈 &gt; 클라우드허브 &gt; " + CTGRY_NM;
					URL = "/community/" + CMMNTY_ID;
				}else if ("communication".equals(SOURCENAME)) {
					CATE_NM = "홈 &gt; 클라우드허브 &gt; " + CTGRY_NM;
					URL ="/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
				}
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company">
						<a href="<%=URL%>"><%=CATE_NM %></a><span>|</span><%=REGISTDT%>
					</p>
					<p class="txt_product">
						<a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</p>			
				</li>
<%
			}
		}else {
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
	if (("introduction_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("introduction_cloud");
		resultColCnt = search_col.w3GetResultCount("introduction_cloud");
			
			
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[소개] ";
				String URL = search_col.w3GetField(collection,"USER_MENU_URL",i);
				String Data1 = search_col.w3GetField(collection, "REGIST_DT", i);
				Data1 = Data1.substring(0, 10);
				String HEAD_CNTNTS = search_col.w3GetField(collection, "HEAD_CNTNTS", i);
				String BODY_CNTNTS = search_col.w3GetField(collection, "BODY_CNTNTS", i);
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=HEAD_CNTNTS.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company"><%=Data1%></p>
					<p class="txt_product">
						<a href="<%=URL%>"><%= BODY_CNTNTS.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</p>
				</li>
<%
			}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
	if (("bizmatc_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("bizmatc_cloud");
		resultColCnt = search_col.w3GetResultCount("bizmatc_cloud");
		
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[비즈매칭] ";
				String DOCID = search_col.w3GetField(collection,"DOCID",i);
				String BBS_CD	= search_col.w3GetField(collection,"BBS_CD",i);
				String URL = "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
				String BBSCTT_SJ = search_col.w3GetField(collection, "BBSCTT_SJ", i);
				String BBSCTT_CN = search_col.w3GetField(collection, "BBSCTT_CN", i);
				String REGISTDT = search_col.w3GetField(collection, "REGIST_DT", i);
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company"><%=REGISTDT%></p>
					<p class="txt_product"><a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></p>			
				</li>
<%
			}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
	if (("customer_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("customer_cloud");
		resultColCnt = search_col.w3GetResultCount("customer_cloud");
		
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[고객센터] ";
				String DOCID = search_col.w3GetField(collection,"DOCID",i);
				String PROGRESS_YN = search_col.w3GetField(collection,"PROGRESS_YN",i);
				String BBS_CD	   = search_col.w3GetField(collection,"BBS_CD",i);

				String URL = "";
				
				if (PROGRESS_YN.length() > 0) {
				// 이벤트 항목은 항상 상세조회 할 수 있도록 수정[2016.01.29]
				PROGRESS_YN = "Y";
				URL = "/korean/pt/webevent/BD_eventView.do?eventSn=" + DOCID + "&flag=" + PROGRESS_YN;
				} else {
				URL = "/web/board/BD_board.list.do?domainCd=2&bbsCd=" + BBS_CD;
				}

				String CTGRY_NM = search_col.w3GetField(collection, "CTGRY_NM", i);
				String BBSCTT_SJ = search_col.w3GetField(collection, "BBSCTT_SJ", i);
				String BBSCTT_CN = search_col.w3GetField(collection, "BBSCTT_CN", i);
				String REGISTDT = search_col.w3GetField(collection, "REGIST_DT", i);
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company"><%=REGISTDT%></p>
					<p class="txt_product">
						<a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</p>			
				</li>
<%
			}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
	if (("notice_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("notice_cloud");
		resultColCnt = search_col.w3GetResultCount("notice_cloud");
		
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[공지사항] ";
				String DOCID      = search_col.w3GetField(collection,"DOCID",i);
				String BBS_CD	  = search_col.w3GetField(collection,"BBS_CD",i);
				String URL 		  = "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
				String Data1 = search_col.w3GetField(collection, "REGIST_DT", i);
				String REGISTDT = Data1.substring(0, 10);
				String BBSCTT_SJ = search_col.w3GetField(collection, "BBSCTT_SJ", i);
				String BBSCTT_CN = search_col.w3GetField(collection, "BBSCTT_CN", i);
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BBSCTT_SJ.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company"><%=REGISTDT%></p>
					<p class="txt_product">
						<a href="<%=URL%>"><%=BBSCTT_CN.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</p>			
				</li>
<%
			}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
	if (("narabid_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("narabid_cloud");
		resultColCnt = search_col.w3GetResultCount("narabid_cloud");
		
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[나라장터 입찰정보] ";
				String BIDNO      = search_col.w3GetField("narabid_cloud","BID_NOTIFY_NO",i);
				String BIDSEQ	  = search_col.w3GetField("narabid_cloud","BID_NOTIFY_SEQ_NO",i);
				String URL        = "http://www.g2b.go.kr:8081/ep/invitation/publish/bidInfoDtl.do?bidno="+BIDNO+"&bidseq="+BIDSEQ;
				String Data1 = search_col.w3GetField("narabid_cloud", "REGIST_DT", i);
				String TITLE = search_col.w3GetField("narabid_cloud", "TITLE", i);
				String BID_STRT_DATE = search_col.w3GetField("narabid_cloud", "BID_STRT_DATE", i);
				String BID_END_DATE = search_col.w3GetField("narabid_cloud", "BID_END_DATE", i);
				String ORDER_ORGN_NM = search_col.w3GetField("narabid_cloud", "ORDER_ORGN_NM", i);
				String REAL_ORGN_NM = search_col.w3GetField("narabid_cloud", "REAL_ORGN_NM", i);
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'" target="_blank"><%=colNmStr%><%=TITLE.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company">
						게시일자(마감일자) : <%=BID_STRT_DATE %> (<%=BID_END_DATE %>)
					</p>
					<p class="txt_product">
						공고기관 : <%=ORDER_ORGN_NM %> </br></br>
						수요기관 : <%=REAL_ORGN_NM %>
					</p>			
				</li>
<%
			}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%
		}
	}
%>
<%
	if (("naracntrct_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("naracntrct_cloud");
		resultColCnt = search_col.w3GetResultCount("naracntrct_cloud");
		
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[나라장터 계약정보] ";
                String CNTRCT_UNION_NO = search_col.w3GetField("naracntrct_cloud","CNTRCT_UNION_NO",i);
                String URL    = "http://www.g2b.go.kr:8067/contract/contDetail.jsp?Union_number="+CNTRCT_UNION_NO;
				String Data1 = search_col.w3GetField("naracntrct_cloud", "REGIST_DT", i)+ " ";
				String TITLE = search_col.w3GetField("naracntrct_cloud", "TITLE", i);
				String REG_DATE = search_col.w3GetField("naracntrct_cloud", "REG_DATE", i);
				String CNTRCT_ITEM_AMT = search_col.w3GetField("naracntrct_cloud", "CNTRCT_ITEM_AMT", i);
				long CNTRCT_ITEM_AMT_LONG = Long.parseLong(CNTRCT_ITEM_AMT) ;
				CNTRCT_ITEM_AMT = numberFormat(CNTRCT_ITEM_AMT_LONG);
				
				String ORDER_ORGN_NM = search_col.w3GetField("naracntrct_cloud", "ORDER_ORGN_NM", i);
				String REAL_ORGN_NM = search_col.w3GetField("naracntrct_cloud", "REAL_ORGN_NM", i);
					
%>
				<fmt:parseDate value='<%=REG_DATE%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=TITLE.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company">
						계약일자 : <fmt:formatDate value="${registDt}" pattern="yyyy.MM.dd"/>
					</p>
					<p class="txt_product">
						계약금액 : <%=CNTRCT_ITEM_AMT %>원 <br /><br />
						계약기관 : <%=ORDER_ORGN_NM %> <br /><br />
						수요기관 : <%=REAL_ORGN_NM %>
					</p>			
				</li>
<%
			}
		}else{
%>
				<li><p class="no_content">검색결과가 없습니다.</p></li>
<%				
		}
	}
%>
<%
	if (("biddingnotice_cloud").equals(collection)) {
		resultColTotalCnt = search_col.w3GetResultTotalCount("biddingnotice_cloud");
		resultColCnt = search_col.w3GetResultCount("biddingnotice_cloud");
		
		if (resultColCnt > 0) {
			for (int i=0; i < resultColCnt; i++) {
				colNmStr = "[입찰공고] ";
				String NOTIFY_NUM = search_col.w3GetField("biddingnotice_cloud","NOTIFY_NUM", i);
				String NOTIFY_SEQ = search_col.w3GetField("biddingnotice_cloud","NOTIFY_SEQ", i);
				String URL  = "http://www.ceart.kr/korean/pt/bidSttus/BD_bidSttusDetailView.do" + "?p_notifyNum="+NOTIFY_NUM + "&p_notifySeq="+NOTIFY_SEQ;
				String BID_NOTIFY_NM = search_col.w3GetField("biddingnotice_cloud", "BID_NOTIFY_NM", i);
				String VIEW_NOTIFY = search_col.w3GetField("biddingnotice_cloud", "VIEW_NOTIFY", i);
				String STRT_DT = search_col.w3GetField("biddingnotice_cloud", "STRT_DT", i);
				String CLSE_DT = search_col.w3GetField("biddingnotice_cloud", "CLSE_DT", i);
%>
				<li>
					<p class="name_product">
						<!-- <input name="" type="checkbox" value="" /> -->
							<span onclick="javascript:location.href='<%=URL%>'"><%=colNmStr%><%=BID_NOTIFY_NM.replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span> 
							<!-- span><img src="/images/icon_confirm3.jpg"></span -->
					</p>
					<p class="name_company">
						공고번호 : <%=VIEW_NOTIFY %>
					</p>
					<p class="txt_product">
						접수일시 : <%=STRT_DT%> <br /><br /> 마감일시 : <%=CLSE_DT%> 
					</p>			
				</li>
<%
			}
		}
	}
}
%>
				</ul>
			</div>

<!--서비스 비교-->
		<div class="location_wrap">
			<div class="compare_wrap">
				<p class="tit">서비스 비교(<label id="compCnt"></label>)
				<span id="svcCompare" style="height:30px; margin:0 0 0 10px; cursor:pointer;" class="btns st5" >서비스 비교 담기</span> 
				<a href="#none" class="btn_compare"></a></p>
				<!--img_select-->
				<div class="img_select">
					<div class="scrollarea">
						<ul id="itemWrap">
						</ul>
					</div>
				</div>
				<!--img_select end-->
				<ul class="btn_select">
					<li><a href="#" onClick="fnGoodsCheckAll();" class="btn_bordergray" style="cursor:pointer;">전체선택/해제</a></li>
					<li><a href="#" onClick="fnGoodsCheckComp(this); return false;"  class="btn_darkblue">서비스비교</a></li>
					<li><a href="#" onClick="_serCompareClear(); return false;" class="btn_darkblue">전체비우기</a></li>
					<li><a href="#" onClick="jsWishPurch(this,'compare'); return false;"  class="btn_darkblue">이용희망목록 담기</a></li>
				</ul>
			</div>
		</div>
<!--서비스 비교 end-->
<!-- paging  -->
 			<div class="paging"><%=getPageLinks(startCount, resultColTotalCnt, 50, 20)%></div>
<!--// paging  -->
		</div>
<%
}else{
%>
					<li>
						<p class="no_content">
							찾고 계신 클라우드 서비스가 없나요?<br /><br />
							비즈매칭을 통해 원하는 클라우드서비스에 대한 조언을 받아보세요.<br /><br /><br />
							-<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1010"><strong style="font-size:14px">비즈매칭 이동하기</strong></a>-  
						</p>
					</li>
<%
}
%>
	</form>
	<!--// content -->
</body>
</html>