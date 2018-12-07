<%@page import="java.net.URLDecoder"%><%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil,QueryAPI500.Search" %>
<%@ page import="java.text.DecimalFormat,
                 java.text.FieldPosition,
                 java.io.UnsupportedEncodingException,
                 java.io.*,
                 java.text.*,
				 javax.xml.parsers.*,
				 org.w3c.dom.*,
				 org.xml.sax.SAXException,
                 java.util.*"%>
<%@ include file="./common/WNAnchor.jsp" %>
<%
	Search search = new Search();  
	Search search_col = new Search();
	int ret = 0;
	String START_DATE = "1970.01.01";	// 기본 시작일
	int viewCount = 20;  // 더보기시 출력 건수
	
	
	// 검색 필수 요소 Request
	
	String totalKeyword = getCheckReqXSS(request, "totalKeyword", "클라우드");//검색어

	String query = getCheckReqXSS(request, "query", totalKeyword);
	//String query = getCheckReqXSS(request, "query", "전체"); 
	    
	    
	String collection = getCheckReqXSS(request, "collection", "ALL");
	String sort = getCheckReqXSS(request, "sort", "RANK");
	String range = getCheckReqXSS(request, "range", "A");
	String startDate = getCheckReqXSS(request, "startDate", START_DATE);
	String endDate = getCheckReqXSS(request, "endDate", getCurrentDate());
	String searchField = getCheckReqXSS(request, "searchField", "");	
	int startCount = Integer.parseInt(getCheckReqXSS(request, "startCount", "0"));		// 최초페이지()
	
	// 필터
	String META1 = getCheckReqXSS(request, "META1", "");	// 중소기업 
	String META2 = getCheckReqXSS(request, "META2", "");	// 무료체험  
	String META3 = getCheckReqXSS(request, "META3", "");	// 계약단위
	String META4 = getCheckReqXSS(request, "META4", "");	// 인증  
	String META5 = getCheckReqXSS(request, "META5", "");	// 서비스관리 
	String META6 = getCheckReqXSS(request, "META6", "");	// 호환성(표준)
	String META7 = getCheckReqXSS(request, "META7", "");	// 구축방식 
	String META8 = getCheckReqXSS(request, "META8", "");	// 지원언어 
	String META9 = getCheckReqXSS(request, "META9", "");	// CSQC_LEVEL
	
	
	// filter조건
	/*
		검색 노출 순서
		1. 소프트웨어(프리미엄, 솔루션), 2. IT서비스(컨설팅), 3. 지식(커뮤니케이션), 4. 소개 (인트로덕션) 
		5. 비즈매칭(비드매칭) 6. 고객센터(커스토머)  7. 공지사항(노티스) 8. 나라장터입찰정보(narabid) 9. 나라장터 입찰계약(naracntrct)
	*/
	
	//String[] COLLECTIONS = new String[]{"premium","solution","consulting","communication","introduction","bizmatc","customer","notice","narabid","naracntrct"};
	String[] COLLECTIONS								= new String[]{"cloud_service", "paas_cloud", "saas_cloud", "iaas_cloud", "scs_cloud"};
	String[] SVC_COLLECTIONS						= new String[]{"cloud_service", "paas_cloud", "saas_cloud", "iaas_cloud", "scs_cloud"};
	String[] RESULT_COLLECTIONS					= new String[]{"cloud_service", "paas_cloud", "saas_cloud", "iaas_cloud", "scs_cloud", "communication_cloud", "introduction_cloud", "bizmatc_cloud", "customer_cloud", "notice_cloud", "narabid_cloud", "naracntrct_cloud", "biddingnotice_cloud"};
	String cloud_service_searchField    = "GOODSNM,GOODSSUMRY,LANGSTORENM";
	String cloud_service_documentField  = "DOCID,REGISTDT,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/190,GOODSRDCNT,CNTCINSTTCD,LANGNM,SLEMTHDNM,GOODSREGISTSTTUSNM,SELLCNT,EVLSCORE,LANGSTORENM,CMMNTYID,MARK_IMG,META1,META2,META3,META4,META5,META6,META7,META8,META9,ENTNM,CATE_NM,GOODSMAINIMAGE";
	String paas_searchField							= "GOODSNM,GOODSSUMRY,LANGSTORENM";
	String paas_documentField						= "DOCID,REGISTDT,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/190,GOODSRDCNT,CNTCINSTTCD,LANGNM,SLEMTHDNM,GOODSREGISTSTTUSNM,SELLCNT,EVLSCORE,LANGSTORENM,CMMNTYID,MARK_IMG,META1,META2,META3,META4,META5,META6,META7,META8,META9,ENTNM,CATE_NM,GOODSMAINIMAGE";
	//String Premium_documentField 		= "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METALICENSE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,ENTNM";
	String saas_searchField							= "GOODSNM,GOODSSUMRY,LANGSTORENM";
	String saas_documentField						= "DOCID,REGISTDT,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/190,GOODSRDCNT,CNTCINSTTCD,LANGNM,SLEMTHDNM,GOODSREGISTSTTUSNM,SELLCNT,EVLSCORE,LANGSTORENM,CMMNTYID,MARK_IMG,META1,META2,META3,META4,META5,META6,META7,META8,META9,ENTNM,CATE_NM,GOODSMAINIMAGE";
	//String solution_documentField 	= "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METALICENSE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,ENTNM";
	String iaas_searchField							= "GOODSNM,GOODSSUMRY,LANGSTORENM"; //String consulting_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METALICENSE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM";
	String iaas_documentField						= "DOCID,REGISTDT,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/190,GOODSRDCNT,CNTCINSTTCD,LANGNM,SLEMTHDNM,GOODSREGISTSTTUSNM,SELLCNT,EVLSCORE,LANGSTORENM,CMMNTYID,MARK_IMG,META1,META2,META3,META4,META5,META6,META7,META8,META9,ENTNM,CATE_NM,GOODSMAINIMAGE";
	String scs_searchField							= "GOODSNM,GOODSSUMRY,LANGSTORENM"; //String consulting_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METALICENSE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM";
	String scs_documentField						= "DOCID,REGISTDT,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/190,GOODSRDCNT,CNTCINSTTCD,LANGNM,SLEMTHDNM,GOODSREGISTSTTUSNM,SELLCNT,EVLSCORE,LANGSTORENM,CMMNTYID,MARK_IMG,META1,META2,META3,META4,META5,META6,META7,META8,META9,ENTNM,CATE_NM,GOODSMAINIMAGE";
	String communication_searchField		= "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";
	String communication_documentField	= "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN/50,CN_SUMRY,SOURCENAME,CTGRY_NM,ATTACH_CON,CMMNTY_ID";
	String introduction_searchField			= "BODY_CNTNTS";
	String introduction_documentField		= "DOCID,REGIST_DT,HEAD_CNTNTS,BODY_CNTNTS/200,CONFM_STTUS,USER_MENU_URL,MENU_PATH";
	String bizmatc_searchField					= "BBSCTT_SJ,BBSCTT_CN";
	String bizmatc_documentField				= "DOCID,REGIST_DT,BBS_CD,BBSCTT_SEQ,BBSCTT_SJ,BBSCTT_CN/150,CN_SUMRY,CTGRY_NM,ATTACH_CON";
	String customer_searchField					= "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";
	String customer_documentField				= "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN/150,CN_SUMRY,ATTACH_CON,CTGRY_NM,SOURCENAME,PROGRESS_YN";
	String notice_searchField						= "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";
	String notice_documentField					= "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN/150,CN_SUMRY,FILE_SEQ,ATTACH_CON,MENU_PATH";
	String narabid_searchField					= "TITLE,ORDER_ORGN_NM,REAL_ORGN_NM";
	String narabid_documentField				= "DOCID,REG_DATE,TITLE,BID_UNION_NO,BID_NOTIFY_NO,BID_NOTIFY_SEQ_NO,START_DATE,ORDER_ORGN_NM,REAL_ORGN_NM,CNTRCT_MTH,BID_MTHD,SCSBID_MTH,BID_STRT_DATE,BID_END_DATE,PRSMP_AMT,SENDER_ID,MESS_TYPE,MESS_NM,DOCU_MANG_NO";
	String naracntrct_searchField 			= "TITLE,ORDER_ORGN_NM,REAL_ORGN_NM";
	String naracntrct_documentField			= "DOCID,REG_DATE,TITLE,CNTRCT_UNION_NO,CNTRCT_NO,CNTRCT_TYPE,CNTRCT_MTH,CNTRCT_PD,CNTRCT_AMT,BID_NOTIFY_NO,BID_NOTIFY_SEQ_NO,ORDER_ORGN_NM,REAL_ORGN_CODE,REAL_ORGN_NM,MAIN_CNTRCT_ENTRPS_TYPE,MAIN_CNTRCT_ENTRPS_NM,SENDER_ID,MESS_TYPE,MESS_NM,DOCU_MANG_NO,CNTRCT_ITEM_NM,CNTRCT_ITEM_AMT";
	// 입찰공고 추가 2017.01.24
	String biddingnotice_searchField 		= "BID_NOTIFY_NM";
	String biddingnotice_documentField	= "DOCID,DATE,NOTIFY_NUM,NOTIFY_SEQ,VIEW_NOTIFY,BID_NOTIFY_NM,STRT_DT,CLSE_DT";
	
	query = URLDecoder.decode(query, "UTF-8");
	String[] collections = null;
	String FilterString = getFilterString(META1, META2, META3, META4, META5, META6, META7, META8, META9);
	
	
	
	int QUERY_LOG		= 1;						// 서버에 쿼리로그 남기기(0:쿼리로그 남기지않음, 1:남김)
	int EXTEND_OR		= 0;						// 확장검색(검색어가 나오지 않을시 확장형 or검색 )	
	int RESULT_COUNT	= 10;
	int USE_HIGHLIGHT	= 1; 
	int USE_SNIPPET		= 1; 
	int totalCountAll	= 0;
	int resultCountAll	= 0;
	int totalCount	= 0;
	int resultCount	= 0;
	int resultColCnt = 0;
	int resultColTotalCnt = 0;
	int resultSaaSColTotalCnt = 0;
	int resultPaaSColTotalCnt = 0;
	int resultIaaSColTotalCnt = 0;
	int resultSCSColTotalCnt = 0; 
	int USE_LA			= 1;
	int IGNORE_CASE		= 0;
	int USER_ORIGINAL	= 1;
	int USER_SYNONYM	= 1;
	
	int TOTALVIEWCOUNT = 5;   						//통합검색시 출력건수
	int COLLECTIONVIEWCOUNT = viewCount;   			//더보기시 출력건수
	
	if("ALL".equals(collection)){					//통하검색
		collections = COLLECTIONS;
		COLLECTIONVIEWCOUNT = TOTALVIEWCOUNT;	
	}else{											//개별검색(시스템별)
		collections = new String[] {collection};
	}
	
	// 좌측 전체 건수는 콜렉션 상관없이 항상 검색결과는 출력해야 한다.
	ret = search.w3SetCodePage( "UTF-8" );
	//ret = search.w3SetSessionInfo(S_SVRID, S_EMAIL_CODE, "MI-KEP");
	ret = search.w3SetQueryLog( QUERY_LOG );
	ret = search.w3SetCommonQuery( query, EXTEND_OR );
	
	for(String colNm : COLLECTIONS){
		ret = search.w3AddCollection(colNm);		//검색기 콜렉션 추가
    	ret = search.w3SetPageInfo(colNm, startCount, COLLECTIONVIEWCOUNT);
    	ret = search.w3SetRanking(colNm, "basic","ropfm", 100);
    	ret = search.w3SetSortField( colNm, sort + "/DESC" );
    	ret = search.w3SetHighlight( colNm, USE_HIGHLIGHT, USE_SNIPPET );
    	ret = search.w3SetDateRange( colNm, startDate.replaceAll("[.]","/"), endDate.replaceAll("[.]","/") );
    	ret = search.w3SetQueryAnalyzer( colNm, USE_LA, IGNORE_CASE, USER_ORIGINAL, USER_SYNONYM );
    	
		if ("cloud_service".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, cloud_service_searchField);
			ret = search.w3SetDocumentField(colNm, cloud_service_documentField);
		}else if ("paas_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, paas_searchField);
			ret = search.w3SetDocumentField(colNm, paas_documentField);
		} else if ("saas_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, saas_searchField);
			ret = search.w3SetDocumentField(colNm, saas_documentField);
		} else if ("iaas_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, iaas_searchField);
			ret = search.w3SetDocumentField(colNm, iaas_documentField);
		} else if ("scs_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, scs_searchField);
			ret = search.w3SetDocumentField(colNm, scs_documentField);
		} else if ("communication_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, communication_searchField);
			ret = search.w3SetDocumentField(colNm, communication_documentField);
		} else if ("introduction_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, introduction_searchField);
			ret = search.w3SetDocumentField(colNm, introduction_documentField);
		} else if ("bizmatc_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, bizmatc_searchField);
			ret = search.w3SetDocumentField(colNm, bizmatc_documentField);
		} else if ("customer_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, customer_searchField);
			ret = search.w3SetDocumentField(colNm, customer_documentField);
		} else if ("notice_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, notice_searchField);
			ret = search.w3SetDocumentField(colNm, notice_documentField);
		} else if ("narabid_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, narabid_searchField);
			ret = search.w3SetDocumentField(colNm, narabid_documentField);
		} else if ("naracntrct_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, naracntrct_searchField);
			ret = search.w3SetDocumentField(colNm, naracntrct_documentField);
		} else if ("biddingnotice_cloud".equals(colNm)) {
			ret = search.w3SetSearchField(colNm, biddingnotice_searchField);
			ret = search.w3SetDocumentField(colNm, biddingnotice_documentField);
		}
	}
	   
	ret = search.w3ConnectServer( "202.30.77.186", 7000, 1000 );
	ret = search.w3ReceiveSearchQueryResult( 3 );
	//ret = search.w3ReceiveSearchQueryResultAsXml(3);
	if( search.w3GetError() != 0 ){
		out.println( "<b>zzzz" + search.w3GetErrorInfo () + "zzz</b>" );
		
		return;
	}
	  
	for(String colNm : COLLECTIONS){
		totalCountAll	+= search.w3GetResultTotalCount( colNm );
	    resultCountAll	+= search.w3GetResultCount( colNm );
	}  
	
	//단일 콜렉션 선택시
	ret = search_col.w3SetCodePage( "UTF-8" );
	ret = search_col.w3SetQueryLog( QUERY_LOG );
	ret = search_col.w3SetCommonQuery( query, EXTEND_OR ); 
	
	for(String colNm : COLLECTIONS){
		ret = search_col.w3AddCollection(colNm);		//검색기 콜렉션 추가
    	ret = search_col.w3SetPageInfo(colNm, startCount, COLLECTIONVIEWCOUNT);
    	ret = search_col.w3SetRanking(colNm, "basic","ropfm", 100);
    	ret = search_col.w3SetSortField( colNm, sort + "/DESC" );
    	ret = search_col.w3SetHighlight( colNm, USE_HIGHLIGHT, USE_SNIPPET );
    	ret = search_col.w3SetDateRange( colNm, startDate.replaceAll("[.]","/"), endDate.replaceAll("[.]","/") );
    	ret = search_col.w3SetQueryAnalyzer( colNm, USE_LA, IGNORE_CASE, USER_ORIGINAL, USER_SYNONYM );
    	
		if("paas_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, paas_searchField);
			ret = search_col.w3SetDocumentField(colNm, paas_documentField);
			if(colNm.equals(collection) && !"".equals(FilterString)){
    			ret = search_col.w3SetFilterQuery(colNm, FilterString);	    					
    		}
		}else if("saas_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, saas_searchField);
			ret = search_col.w3SetDocumentField(colNm, saas_documentField);
			if(colNm.equals(collection) && !"".equals(FilterString)){
    			ret = search_col.w3SetFilterQuery(colNm, FilterString);	    					
    		}
		}else if("iaas_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, iaas_searchField);
			ret = search_col.w3SetDocumentField(colNm, iaas_documentField);
			if(colNm.equals(collection) && !"".equals(FilterString)){
    			ret = search_col.w3SetFilterQuery(colNm, FilterString);	    					
    		}
		}else if("scs_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, scs_searchField);
			ret = search_col.w3SetDocumentField(colNm, scs_documentField);
			if(colNm.equals(collection) && !"".equals(FilterString)){
    			ret = search_col.w3SetFilterQuery(colNm, FilterString);	    					
    		}
		}else if("communication_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, communication_searchField);
			ret = search_col.w3SetDocumentField(colNm, communication_documentField);
		}else if("introduction_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, introduction_searchField);
			ret = search_col.w3SetDocumentField(colNm, introduction_documentField);
		}else if("bizmatc_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, bizmatc_searchField);
			ret = search_col.w3SetDocumentField(colNm, bizmatc_documentField);
		}else if("customer_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, customer_searchField);
			ret = search_col.w3SetDocumentField(colNm, customer_documentField);
		}else if("notice_cloud".equals(colNm)){
			ret = search_col.w3SetSearchField(colNm, notice_searchField);
			ret = search_col.w3SetDocumentField(colNm, notice_documentField);
		}else if("narabid_cloud".equals(colNm)){
			ret = search.w3SetSearchField(colNm, narabid_searchField);
			ret = search.w3SetDocumentField(colNm, narabid_documentField);
		}else if("naracntrct_cloud".equals(colNm)){
			ret = search.w3SetSearchField(colNm, naracntrct_searchField);
			ret = search.w3SetDocumentField(colNm, naracntrct_documentField);
		}
	} 
	ret = search_col.w3ConnectServer( "202.30.77.186", 7000, 1000 );
	ret = search_col.w3ReceiveSearchQueryResult( 3 );
	//ret = search_col.w3ReceiveSearchQueryResultAsXml(3);
	if( search_col.w3GetError() != 0 ){
		out.println( "<b>" + search_col.w3GetErrorInfo () + "</b>" );
		
		return;
	}  
	  
	for(String colNm : collections){
		totalCount	+= search_col.w3GetResultTotalCount( colNm );
	    resultCount	+= search_col.w3GetResultCount( colNm );  
	} 
%>
<%!
	public String getFilterString(String META1, String META2, String META3, String META4, String META5, String META6, String META7, String META8, String META9){
		String[] arr_META1 = null;
		String[] arr_META2 = null;
		String[] arr_META3 = null;
		String[] arr_META4 = null;
		String[] arr_META5 = null;
		String[] arr_META6 = null;
		String[] arr_META7 = null;
		String[] arr_META8 = null;
		String[] arr_META9 = null;
		String FilterString = "";
		String tempString = "";
		if(!"".equals(META1) && META1 != null){
			arr_META1 = META1.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META1.length; idx++){
				if(idx == 0) tempString = "<META1:substring:" + arr_META1[idx] + ">";
				else tempString = tempString + " <META1:substring:" + arr_META1[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META2) && META2 != null){
			arr_META2 = META2.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META2.length; idx++){
				if(idx == 0) tempString = "<META2:substring:" + arr_META2[idx] + ">";
				else tempString = tempString + " <META2:substring:" + arr_META2[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META3) && META3 != null){
			arr_META3 = META3.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META3.length; idx++){
				if(idx == 0) tempString = "<META3:substring:" + arr_META3[idx] + ">";
				else tempString = tempString + " <META3:substring:" + arr_META3[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META4) && META4 != null){
			arr_META4 = META4.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META4.length; idx++){
				if(idx == 0) tempString = "<META4:substring:" + arr_META4[idx] + ">";
				else tempString = tempString + " <META4:substring:" + arr_META4[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META5) && META5 != null){
			arr_META5 = META5.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META5.length; idx++){
				if(idx == 0) tempString = "<META5:substring:" + arr_META5[idx] + ">";
				else tempString = tempString + " <META5:substring:" + arr_META5[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META6) && META6 != null){
			arr_META6 = META6.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META6.length; idx++){
				if(idx == 0) tempString = "<META6:substring:" + arr_META6[idx] + ">";
				else tempString = tempString + " <META6:substring:" + arr_META6[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META7) && META7 != null){
			arr_META7 = META7.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META7.length; idx++){
				if(idx == 0) tempString = "<META7:substring:" + arr_META7[idx] + ">";
				else tempString = tempString + " <META7:substring:" + arr_META7[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META8) && META8 != null){
			arr_META8 = META8.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META8.length; idx++){
				if(idx == 0) tempString = "<META8:substring:" + arr_META8[idx] + ">";
				else tempString = tempString + " <META8:substring:" + arr_META8[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}
		if(!"".equals(META9) && META9 != null){
			arr_META9 = META9.split(",");
			tempString = "";
			for(int idx=0; idx < arr_META9.length; idx++){
				if(idx == 0) tempString = "<META9:substring:" + arr_META9[idx] + ">";
				else tempString = tempString + " <META9:substring:" + arr_META9[idx] + ">";
			}
			if(!"".equals(FilterString)){
				FilterString = FilterString + " " + tempString;
			}else{
				FilterString = tempString;
			}
		}

		
		return FilterString;
	}
	//request변수 초기화
	public String getCheckReqXSS(javax.servlet.http.HttpServletRequest req, String parameter, String default_value) {
	    String req_value = (req.getParameter(parameter) == null ||  req.getParameter(parameter).equals("")) ? default_value : req.getParameter(parameter);
	    req_value = req_value.replaceAll("</?[a-zA-Z][0-9a-zA-Zê°-\uD7A3ã±-ã=/\"\'%;:,._()\\-# ]+>","");
	    req_value = req_value.replaceAll(">","");
	    req_value = req_value.replaceAll(">","");
	    return req_value;  
	}
	
	//오늘날짜 가져오기
	public static String getCurrentDate() {
	    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat
	            ("yyyy.MM.dd", java.util.Locale.KOREA);
	    return dateFormat.format(new java.util.Date());
	}    
	
	//페이징 Print
	public String getPageLinks(int startCount, int totalCount, int viewListCount, int bundleCount) {
		StringBuffer sbRet = new StringBuffer();
		WNAnchor wnanchor = getPageAnchor(startCount, totalCount, viewListCount, bundleCount);
		
		if (startCount != 0) {
			//sbRet.append("<a class=\"prev\" href=\"#\" onClick=\"javascript:doPaging('0');\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_first.gif\" alt=\"처음\"></a>");	
		} else {
			//sbRet.append("<a class=\"prev\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_first.gif\" alt=\"처음\"></a>");	
		}
		
		if(wnanchor.getCurPageNumber() != 1) {
			//sbRet.append("<a class=\"prev\" href=\"#\" onClick=\"javascript:doPaging('"+viewListCount * (wnanchor.getCurPageNumber()-2)+"');\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_prev.gif\" alt=\"이전\"></a>");
		} else {
			//sbRet.append("<a class=\"prev\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_prev.gif\" alt=\"이전\"></a>");
		} 

		int pageCount = wnanchor.getPageCount();
		String pages[][] = wnanchor.getPages();

		for(int i=0; i<pageCount && i < pages.length; i++) {
			if(pages[i][1].equals("-1")) {
				sbRet.append("<a href=\"#\" class=\"on\">" + pages[i][0] + "</a>");
			} else {
				sbRet.append("<a href=\"#none\" onClick=\"javascript:doPaging('"+pages[i][1]+"');\" title=\"페이징\"> "+pages[i][0]+" </a>");
			}
		}

		if(wnanchor.getCurPageNumber() != wnanchor.getPageCount()) {
   			//sbRet.append("<a class=\"next\" href=\"#\" onClick=\"javascript:doPaging('"+viewListCount * (wnanchor.getCurPageNumber()) +"')\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_next.gif\" alt=\"다음\"></a>");
		} else {
			//bRet.append("<a class=\"next\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_next.gif\" alt=\"다음\"></a>");
		}
		
		if(wnanchor.getCurPageNumber() != wnanchor.getPageCount()) {
   			//sbRet.append("<a class=\"next\" href=\"#\" onClick=\"javascript:doPaging('"+ viewListCount * (wnanchor.getPageCount()-1) + "')\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_end.gif\" alt=\"끝\"></a>");
		} else {
			//sbRet.append("<a class=\"next\" href=\"#\"><img src=\"/resources/web/theme/default/images/btn/btn_paging_end.gif\" alt=\"끝\"></a>");
		}

		return sbRet.toString();
	}
	
	
	//페이징 처리
	
	public WNAnchor getPageAnchor(int startNum, int totalcount, int resultCnt, int anchorSacle) {
		WNAnchor anchor = new WNAnchor();
	
		if(totalcount == 0) {   //등록된 정보가 없으면 페이지 Anchor를 생성 하지 않는다.
			return anchor;
		}
	
		int curBunbleNum = startNum / (resultCnt * anchorSacle);
		int totalPageCnt = totalcount / resultCnt;
		if(totalcount % resultCnt > 0) {
			totalPageCnt++;
		}
	
		anchor.setTotalPgCount(totalPageCnt);      // 전체 페이지 세팅
	
		if ( startNum > 0){        // 이전 페이지
			int beforePg = startNum - resultCnt;
			anchor.setBefore(beforePg);
		}
	
		if( startNum+resultCnt < totalcount ){        // 다음페이지
			int nextPg = startNum + resultCnt;
			anchor.setNext(nextPg);
		}
	
		//번들 뒤로 이동
		int bunbleBeforePg = (curBunbleNum-1) * resultCnt * anchorSacle;    //이전 번들로 이동하는 번호
		if(curBunbleNum > 0){
			anchor.setBundleBefore(bunbleBeforePg);
		}
	
		//번들 앞으로 이동
		int bundleNextPg = (1 + curBunbleNum) * anchorSacle * resultCnt;
		if( totalPageCnt >= anchorSacle && (curBunbleNum+1) * anchorSacle <  totalPageCnt ){
			anchor.setBundleNext(bundleNextPg);
		}
	
		//맨처음..
		if(startNum != 0 && curBunbleNum != 0){
			anchor.setFirstPage(0);
		}
		//맨끝...
		int lastPage = (resultCnt * totalPageCnt) - resultCnt ;
		if( totalPageCnt >= anchorSacle && (curBunbleNum+1) * anchorSacle <  totalPageCnt ) {
			anchor.setLastPage(lastPage);
		}
	
		int pageCount = 1;
		String[][] pages = new String[anchorSacle][2];
		for(int i = 0; i < anchorSacle; i++) {
			int startCnt = ((curBunbleNum * anchorSacle) + i) * resultCnt;
			int pageNum = (curBunbleNum * anchorSacle) + i + 1;
			if(startCnt < totalcount) {
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
	 

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>씨앗 마켓</title>
	<script type="text/javascript">
		
	    // 좌측 메뉴 클릭
	    function doCollection(collection){
		    // 필터 초기화
		    filterInit();
		    
		    $("#collection").val(collection);
		    document.search.submit();
	    }
		
		// 메인 헤더에서 검색
		function fn_mainSearch(){

		    // 필터 초기화
		    filterInit();
		    
		    $("#selecItemNames").val("");
		    
		    totalKeyword = document.getElementById("totalKeyword");
		    if(totalKeyword.value == ""){
		        alert(Message.msg.enterSrchWrd);
		        totalKeyword.focus();
		        return;
		    }
		    $("#query").val($("#totalKeyword").val());
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
		    
		    // form submit
		    $("form[name=search]").submit();

		}

	    // 선택된 필터 셋팅
	    function filterSet(){
	        
	        // 필터 갯수
	        var filter_tot_cnt = "9";
	        
	        // 필터 갯수 만큼 for문 수행
	        for(i=1; i<=filter_tot_cnt; i++){
	            
	            var filter_name    = "sMeta" + i;  // 필터 체크박스 ID
	            
	            var filter_dtl_cnt = $("input[name='"+filter_name+"']").length; // 필터 체크박스 element 갯수
	            var return_value   = "";                                        // 결과 반환값
	            var return_filter_name = "META" + i;                            // 반환값 적용 컬럼명
	            var return_value   = "";                                        // 결과 반환값
	            
		        for(j=0; j<filter_dtl_cnt; j++){
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
		        $("input[name='"+return_filter_name+"']").val(return_value);
	        }
	        
	    }
		
		
		
		// 페이징 처리 조회
		function doPaging(page){		   
		   	$("#startCount").val(page);
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
		  	    $(xml).find("Word").each(function(){
		  	      str += "<li><a href=\"javascript:fn_relativeSearch('" +  $(this).text() + "')\">" + $(this).text() + "</a></li>";
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
		  	      str += "<li>" + $(this).attr("id") +". <a href=\"javascript:fn_rankSearch('" + $(this).text() + "');\">" + $(this).text() + "</a></li>";
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
		});
		
		// 판매자 링크
	    var jsSeller = function(userId) {
	        $("#userId").val(userId);
	        document.dataForm.action = "/korean/pt/store/BD_goodsOfSeller.do";
	        document.dataForm.elements["q_currPage"].value = "1";
	        document.dataForm.submit();
	    };
	    
	    
	    var jsFilterSearch = function() {
	        
	        /* if($("input[type='checkbox']:checked").length < 1){
	        	alert('1개이상 선택하세요');
	        	return;
	        } */
	      createItem();
	      document.search.action = "BD_index.do";
		    document.search.elements["q_currPage"].value = "1";
		    document.search.submit();
	    };
	    
	    var jsInitFilter = function() {
	        var checkObjs = $("input[type='checkbox']:checked");
	        checkObjs.prop("checked", false);
	        jsFilterSearch();
	    };
	    
	    function createItem(){     
	        var items = [];
	        var itemsName = [];
	        var selectItem12Len = $('input:checkbox[name="selectItem12"]:checked').length;
	        if(selectItem12Len > 0) {
	            $('input:checkbox[name=selectItem12]:checked').each(function () {
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
	            });
	            $("#selectItem3").val(items);
	            //$("#selectNames").text(itemsName);
	        }else{
	            $("#selectItem3").remove();
	        }
	        
	        
	        if($('input:checkbox[name="selectItem5"]:checked').length > 0)
	            $("#creteItem").html("<input type='hidden' name='selectItem5' value='3'>");
	        else 
	            $("#creteItem").html("");
	    }
	</script>
	<!--[if lt IE 9]>
		<script src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<![endif]-->
</head>
<body>
	<form name="search" id="search" action="BD_index.do" method="POST">
		<input type="hidden" id="query" 			name="query" 				value="<%=query%>" />
		<input type="hidden" id="q_currPage" 	name="q_currPage" 	value="" />
		
		<input type="hidden" id="startCount" 	name="startCount" 	value="0" />
		<input type="hidden" id="sort" 				name="sort" 				value="<%=sort%>" />
		<input type="hidden" id="collection" 	name="collection" 	value="<%=collection%>" />
		<input type="hidden" id="searchField" name="searchField"	value="<%=searchField%>" />
		<input type="hidden" id="reQuery" 		name="reQuery" 			value="" />
<!-- 		<input type="hidden" id="META1" 			name="META1"				value="" />
		<input type="hidden" id="META2" 			name="META2" 				value="" />
		<input type="hidden" id="META3" 			name="META3" 				value="" />
		<input type="hidden" id="META4" 			name="META4" 				value="" />
		<input type="hidden" id="META5" 			name="META5" 				value="" />
		<input type="hidden" id="META6" 			name="META6" 				value="" />
		<input type="hidden" id="META7" 			name="META7" 				value="" />
		<input type="hidden" id="META8" 			name="META8" 				value="" />
		<input type="hidden" id="META9" 			name="META9" 				value="" /> -->
		<!-- section -->
<%-- 		
		<div class="section side">					
			<p class="total">
				<span class="txt-search-word">“<%=query %>”</span><span>&nbsp;검색결과 <strong><%=totalCountAll %></strong>건</span>
			</p>
		</div>
 --%>		
 
    	<!-- section -->
		<div class="section  filBtn">
			<!-- filter section -->
<%-- 			<div>
				<c:set var="selecItemNames" value="" /> 
				<a href="#" class="s-btn filter-pop type2"><strong><span>필터링 보기</span></strong></a>
				<div class="filter-pop" style="display:none;">
					<div>
						<h2>필터링 선택</h2>
						<dl>
							<dt>공공기관 이용 필터</dt>
								<c:forEach items="${organUserList}" var="_organUserList" varStatus="status">
								<dd>
									<c:if test="${_organUserList.prvCd eq '1001'}">
									<c:set var="codeval" value="1004" />
									<input type="checkbox" id="sMeta13" name="sMeta13" value="${codeval}" <c:if test="${fn:contains(sMeta13,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
									</c:if>
									<c:if test="${_organUserList.prvCd ne '1001'}">
									<c:set var="codeval" value="2060${_organUserList.prvCd}" />
									<input type="checkbox" id="sMeta2" name="sMeta2" value="${codeval}" <c:if test="${fn:contains(sMeta2,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
									</c:if> 
								<label>${_organUserList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>서비스 구분</dt>
							<dd>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1003" <c:if test="${fn:contains(param.sMeta3,'1003')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / IaaS" /></c:if> />
						 		<label>IaaS</label>
							</dd>
							<dd>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1002" <c:if test="${fn:contains(param.sMeta3,'1002')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SaaS" /></c:if> />
								<label>SaaS</label>
							</dd>
							<dd>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1001" <c:if test="${fn:contains(param.sMeta3,'1001')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / PaaS" /></c:if> /> 
						 		<label>PaaS</label>
						 	</dd>
						 	<dd>
								<input type="checkbox" id="sMeta12" name="sMeta12" value="1004" <c:if test="${fn:contains(param.sMeta3,'1004')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SCS" /></c:if> /> 
						 		<label>SCS</label>
							</dd>
						</dl>
						<dl>
							<dt>클라우드 구축방식</dt>
							<c:forEach items="${buildMethodList}" var="_buildMethodList" varStatus="status">
							<c:set var="codeval" value="2032${_buildMethodList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta7" name="sMeta7" value="${codeval}"  <c:if test="${fn:contains(sMeta7,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_buildMethodList.prvNm} " /> </c:if>/> 
								<label>${_buildMethodList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>인증정보</dt>
							<c:forEach items="${certificationList}" var="_certificationList" varStatus="status">
							<c:set var="codeval" value="${_certificationList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta4" name="sMeta4" value="${codeval}" <c:if test="${fn:contains(sMeta4,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_certificationList.prvNm} " /> </c:if>/> 
								<label>${_certificationList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>서비스기술지원</dt>
							<c:forEach items="${serviceManageList}" var="_serviceManageList" varStatus="status">
							<c:set var="codeval" value="2030${_serviceManageList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta5" name="sMeta5" value="${codeval}" <c:if test="${fn:contains(sMeta5,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_serviceManageList.prvNm} " /></c:if>/> 
								<label>${_serviceManageList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>호환성 지원</dt>
							<c:forEach items="${compatibilityList}" var="_compatibilityList" varStatus="status">
							<c:set var="codeval" value="2031${_compatibilityList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta6" name="sMeta6" value="${codeval}" <c:if test="${fn:contains(sMeta6,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_compatibilityList.prvNm} " /> </c:if>/> 
								<label>${_compatibilityList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>개발지원</dt>
							<c:forEach items="${deploySupportList}" var="_deploySupportList" varStatus="status">
							<c:set var="codeval" value="2056${_deploySupportList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta8" name="sMeta8" value="${codeval}" <c:if test="${fn:contains(sMeta8,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_deploySupportList.prvNm} " /></c:if>/>
								<label>${_deploySupportList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>교육, 기술지원</dt>
							<c:forEach items="${eduTechSupportList}" var="_eduTechSupportList" varStatus="status">
							<c:set var="codeval" value="2057${_eduTechSupportList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta9" name="sMeta9" value="${codeval}" <c:if test="${fn:contains(sMeta9,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_eduTechSupportList.prvNm} " /> </c:if>/> 
								<label>${_eduTechSupportList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>관리정보제공</dt>
							<c:forEach items="${mangerInfotList}" var="_mangerInfotList" varStatus="status">
							<c:set var="codeval" value="2058${_mangerInfotList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta10" name="sMeta10" value="${codeval}" <c:if test="${fn:contains(sMeta10,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_mangerInfotList.prvNm} " /> </c:if>/>
								<label>${_mangerInfotList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>기업구분</dt>
							<dd>
								<input type="checkbox" id="sMeta1" name="sMeta1" value="Y" <c:if test="${fn:contains(sMeta1,'Y')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중소기업 " /> </c:if> /> 
								<label>중소기업</label>
							</dd>
							<dd>
								<input type="checkbox" id="sMeta1" name="sMeta1" value="M" <c:if test="${fn:contains(sMeta1,'M')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중견기업 " /> </c:if> /> 
								<label>중견기업</label>
							</dd>
							<dd>
								<input type="checkbox" id="sMeta1" name="sMeta1" value="B" <c:if test="${fn:contains(sMeta1,'B')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 대기업 " /> </c:if> /> 
								<label>대기업</label>
							</dd>
						</dl>
						<dl>
							<dt>고객지원</dt>
							<c:forEach items="${customSupportList}" var="_customSupportList" varStatus="status">
							<c:set var="codeval" value="2059${_customSupportList.prvCd}" />
							<dd>
								<input type="checkbox" id="sMeta11" name="sMeta11"  value="${codeval}"  <c:if test="${fn:contains(sMeta11,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_customSupportList.prvNm} " /> </c:if> />
						 		<label>${_customSupportList.prvNm}</label>
						 	</dd>
						</c:forEach>
						</dl>

						<div class="border ar">
							<a href="#" class="b-btn w80 ac type2"  onClick="jsInitFilter();"><strong><span>선택초기화</span></strong></a>
							<a href="#" class="b-btn w65 ac type2"  onClick="jsFilterSearch();return false;"><strong><span>적용</span></strong></a>
						</div>
					</div>
				</div>
			</div> --%>
			<!-- //filter section -->
		</div>
		<!-- //section -->
		<!-- section(result) -->
		<div class="section side total-result">
<%
String colNmStr = "";
if("ALL".equals(collection)){
	resultSaaSColTotalCnt = search_col.w3GetResultTotalCount( "saas_cloud" );
	resultPaaSColTotalCnt = search_col.w3GetResultTotalCount( "paas_cloud" );
	resultIaaSColTotalCnt = search_col.w3GetResultTotalCount( "iaas_cloud" );
	resultSCSColTotalCnt  = search_col.w3GetResultTotalCount( "scs_cloud" );
	
	resultColTotalCnt = resultSaaSColTotalCnt + resultPaaSColTotalCnt + resultIaaSColTotalCnt + resultSCSColTotalCnt;
	//resultColCnt 			= search_col.w3GetResultCount("saas_cloud") + search_col.w3GetResultCount("iaas_cloud") + search_col.w3GetResultCount("paas_cloud") + search_col.w3GetResultCount("scs_cloud");
%>
		<p>클라우드서비스<strong><%=resultColTotalCnt %></strong>건 <strong><c:if test="${not empty selecItemNames}">:	${fn:replace(fn:substring(selecItemNames,3,fn:length(selecItemNames)),'/','/')}</c:if></strong></p>
		<!-- list -->
		<div class="type-thumb">
<%
	if(resultColTotalCnt > 0){
		for (String colNm : COLLECTIONS) {
			resultColCnt = search_col.w3GetResultCount(colNm);
			System.out.println("colNm: " + colNm);
			
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
					String CTGRY_CL_CD = search_col.w3GetField(colNm, "CTGRY_CL_CD", i);

					
					//if (("paas_cloud").equals(colNm)) {
						colNmStr = "[클라우드서비스] ";
						URL = "/korean/m/store/software/BD_view.do?goodsCode="+DOCID+"&ctgryCode="+CTGRY_CL_CD;
%>
						<fmt:parseDate value='<%=REGISTDT%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
						<ul>
							<li class="cont">
								<dl>
					    		<dt>
					    			<a href="<%=URL%>"><%=search_col.w3GetField(colNm, "GOODSNM", i).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %><span><%=search_col.w3GetField(colNm, "LANGSTORENM", i).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span></a>
					    		</dt>
									<dd>
									    <a href="<%=URL%>"><%=search_col.w3GetField(colNm, "GOODSSUMRY", i).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
									</dd>
								</dl>
							</li>
							<li class="add">
								<span>
								<%
									if (MARK_IMG.length() > 0 ) {
										for (int j=0; j < MARK_IMG_ARRAY.length; j++) {
								%>
											<img src="<%=MARK_IMG_ARRAY[j]%>" alt="markImg" />
								<%
										}
									}
								%>
				    		</span>
							</li>
						</ul>
<%
					//}
				}
			}
		}
  }else{
%>
            <p>클라우드서비스<strong>0</strong>건</p>
            <div class="type-thumb">
		        <ul>
			        <li class="cont">
				        <dl>
					        <dt>검색결과가 없습니다.</dt>
					    </dl>
					</li>
			    </ul>
            </div>
<%
	}
}// end if
%>	
		</div>
		<!-- //section -->
    </form>
</body>
</html>