<%@page import="java.net.URLDecoder"%><%@page import="java.net.URLEncoder"%><%@ page contentType="text/xml;charset=UTF-8" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ page import="zes.openworks.intra.cms.support.CmsUtil,QueryAPI500.Search" %><%	
	Search search = new Search();  
	int ret = 0;
	String START_DATE = "1970.01.01";	// 기본 시작일
	int viewCount = 10;
	
	String query = getCheckReqXSS(request, "query", "긴급구조시스템"); 
	String collection = getCheckReqXSS(request, "collection", "ALL");
	String sort = getCheckReqXSS(request, "sort", "RANK");
	String range = getCheckReqXSS(request, "range", "A");
	String startDate = getCheckReqXSS(request, "startDate", START_DATE);
	String endDate = getCheckReqXSS(request, "endDate", getCurrentDate());
	String searchField = getCheckReqXSS(request, "searchField", "");	
	int startCount = Integer.parseInt(getCheckReqXSS(request, "startCount", "0"));		// 최초페이지()
	
	/*
		검색 노출 순서
		1. 소프트웨어(프리미엄, 솔루션), 2. IT서비스(컨설팅), 3. 지식(커뮤니케이션), 4. 소개 (인트로덕션) 
		5. 비즈매칭(비즈매칭) 6. 고객센터(커스토머)  7. 공지사항(노티스) 8. 나라장터입찰정보(narabid) 9. 나라장터 입찰계약(naracntrct)
	*/
	
	//String[] COLLECTIONS = new String[]{"premium","solution","consulting","communication","introduction","bizmatc","customer","notice","narabid","naracntrct"};
	String merge_collection = "merge_software";	String[] merged_collection = {"premium", "solution"};
	String[] COLLECTIONS = new String[]{merge_collection,"consulting","communication","introduction","bizmatc","customer","notice","narabid","naracntrct"};
	String[] RESULT_COLLECTIONS = new String[]{"merge_software","consulting","communication","introduction","bizmatc","customer","notice","narabid","naracntrct"};
	String premium_searchField = "GOODSSUMRY";			String Premium_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM";
	//String Premium_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,ENTNM";
	String solution_searchField = "GOODSSUMRY";			String solution_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM";
	//String solution_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,ENTNM";
	String consulting_searchField = "GOODSSUMRY";		//String consulting_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM";
	String consulting_documentField = "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,ENTNM";
	String communication_searchField = "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY"; String communication_documentField = "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,SOURCENAME,CTGRY_NM,ATTACH_CON,CMMNTY_ID";
	String introduction_searchField = "BODY_CNTNTS"; 	String introduction_documentField = "DOCID,REGIST_DT,HEAD_CNTNTS,BODY_CNTNTS,CONFM_STTUS,USER_MENU_URL,MENU_PATH";
	String bizmatc_searchField = "ATTACH_CON";			String bizmatc_documentField = "DOCID,REGIST_DT,BBS_CD,BBSCTT_SEQ,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON";
	String customer_searchField = "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";	String customer_documentField = "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM,SOURCENAME,PROGRESS_YN";
	String notice_searchField = "BBSCTT_SJ,BBSCTT_CN,CN_SUMRY";		String notice_documentField = "DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,FILE_SEQ,ATTACH_CON,MENU_PATH";
	String narabid_searchField = "TITLE,ORDER_ORGN_NM,REAL_ORGN_NM";	String narabid_documentField = "DOCID,REG_DATE,TITLE,BID_UNION_NO,BID_NOTIFY_NO,BID_NOTIFY_SEQ_NO,START_DATE,ORDER_ORGN_NM,REAL_ORGN_NM,CNTRCT_MTH,BID_MTHD,SCSBID_MTH,BID_STRT_DATE,BID_END_DATE,PRSMP_AMT,SENDER_ID,MESS_TYPE,MESS_NM,DOCU_MANG_NO";
	String naracntrct_searchField = "TITLE,ORDER_ORGN_NM,REAL_ORGN_NM";	 String naracntrct_documentField = "DOCID,REG_DATE,TITLE,CNTRCT_UNION_NO,CNTRCT_NO,CNTRCT_TYPE,CNTRCT_MTH,CNTRCT_PD,CNTRCT_AMT,BID_NOTIFY_NO,BID_NOTIFY_SEQ_NO,ORDER_ORGN_NM,REAL_ORGN_CODE,REAL_ORGN_NM,MAIN_CNTRCT_ENTRPS_TYPE,MAIN_CNTRCT_ENTRPS_NM,SENDER_ID,MESS_TYPE,MESS_NM,DOCU_MANG_NO,CNTRCT_ITEM_NM,CNTRCT_ITEM_AMT";
		
	String DOCUMENT_FIELD_MERGE	= "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM";
	//String DOCUMENT_FIELD_MERGE	= "DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,ENTNM";
	
	query = URLDecoder.decode(query, "UTF-8");
	String[] collections = null;
	
	int QUERY_LOG		= 1;						// 서버에 쿼리로그 남기기(0:쿼리로그 남기지않음, 1:남김)
	int EXTEND_OR		= 0;						// 확장검색(검색어가 나오지 않을시 확장형 or검색 )	
	int RESULT_COUNT	= 10;
	int USE_HIGHLIGHT	= 1; 
	int USE_SNIPPET		= 1; 
	int totalCount		= 0;
	int resultCount		= 0;
	int USE_LA			= 1;
	int IGNORE_CASE		= 1;
	int USER_ORIGINAL	= 1;
	int USER_SYNONYM	= 1;
	
	int TOTALVIEWCOUNT = 3;   						//통합검색시 출력건수
    int COLLECTIONVIEWCOUNT = viewCount;   			//더보기시 출력건수
    
    if("ALL".equals(collection)){					//통하검색
    	collections = COLLECTIONS;
    	COLLECTIONVIEWCOUNT = TOTALVIEWCOUNT;	
    }else{											//개별검색(시스템별)
    	collections = new String[] {collection};
    }
    
    String[] merge_documentField = DOCUMENT_FIELD_MERGE.split(","); // merge_documentField setting
    
    ret = search.w3SetCodePage( "UTF-8" );
    //ret = search.w3SetSessionInfo(S_SVRID, S_EMAIL_CODE, "MI-KEP");
    ret = search.w3SetQueryLog( QUERY_LOG );
    ret = search.w3SetCommonQuery( query, EXTEND_OR );
    
    for(String colNm : collections){
    	if(!merge_collection.equals(colNm)){
	    	ret = search.w3AddCollection(colNm);		//검색기 콜렉션 추가
	    	ret = search.w3SetPageInfo(colNm, startCount, COLLECTIONVIEWCOUNT);
	    	ret = search.w3SetRanking(colNm, "basic","ropfm", 100);
	    	ret = search.w3SetSortField( colNm, sort + "/DESC" );
	    	ret = search.w3SetHighlight( colNm, USE_HIGHLIGHT, USE_SNIPPET );
	    	ret = search.w3SetDateRange( colNm, startDate.replaceAll("[.]","/"), endDate.replaceAll("[.]","/") );
	    	ret = search.w3SetQueryAnalyzer( colNm, USE_LA, IGNORE_CASE, USER_ORIGINAL, USER_SYNONYM );
    	}

    	if(merge_collection.equals(colNm)){
    		for(String mergecolNm : merged_collection){
    			ret = search.w3AddCollection(mergecolNm);		//검색기 콜렉션 추가
    	    	ret = search.w3SetPageInfo(mergecolNm, startCount, COLLECTIONVIEWCOUNT);
    	    	ret = search.w3SetRanking(mergecolNm, "basic","ropfm", 100);
    	    	ret = search.w3SetSortField( mergecolNm, sort + "/DESC" );
    	    	ret = search.w3SetHighlight( mergecolNm, USE_HIGHLIGHT, USE_SNIPPET );
    	    	ret = search.w3SetDateRange( mergecolNm, startDate.replaceAll("[.]","/"), endDate.replaceAll("[.]","/") );
    	    	ret = search.w3SetQueryAnalyzer( mergecolNm, USE_LA, IGNORE_CASE, USER_ORIGINAL, USER_SYNONYM );
    			ret = search.w3SetSearchField(mergecolNm, premium_searchField);
        		ret = search.w3SetDocumentField(mergecolNm, Premium_documentField);
        		ret = search.w3AddMergeCollection(merge_collection, mergecolNm);
        		for(String docField : merge_documentField){
        			ret = search.w3AddMergeDocumentField( merge_collection, docField, mergecolNm, docField );
        		}
    		}
    	}else if("consulting".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, consulting_searchField);
    		ret = search.w3SetDocumentField(colNm, consulting_documentField);
    	}else if("communication".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, communication_searchField);
    		ret = search.w3SetDocumentField(colNm, communication_documentField);
    	}else if("introduction".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, introduction_searchField);
    		ret = search.w3SetDocumentField(colNm, introduction_documentField);
    	}else if("bizmatc".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, bizmatc_searchField);
    		ret = search.w3SetDocumentField(colNm, bizmatc_documentField);
    	}else if("customer".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, customer_searchField);
    		ret = search.w3SetDocumentField(colNm, customer_documentField);
    	}else if("notice".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, notice_searchField);
    		ret = search.w3SetDocumentField(colNm, notice_documentField);
    	}else if("narabid".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, narabid_searchField);
    		ret = search.w3SetDocumentField(colNm, narabid_documentField);
    	}else if("naracntrct".equals(colNm)){
    		ret = search.w3SetSearchField(colNm, naracntrct_searchField);
    		ret = search.w3SetDocumentField(colNm, naracntrct_documentField);
    	}
    }
    
    ret = search.w3SetMergePageInfo( merge_collection, startCount, COLLECTIONVIEWCOUNT );
    ret = search.w3ConnectServer( "202.30.77.190", 7000, 1000 );
    //ret = search.w3ReceiveSearchQueryResult( 3 );
	ret = search.w3ReceiveSearchQueryResultAsXml(3);
    if( search.w3GetError() != 0 ){
    	out.println( "<b>" + search.w3GetErrorInfo () + "</b>" );
    	return;
    }
    
	for(String colNm : collections){
		totalCount	+= search.w3GetResultTotalCount( colNm );
	    resultCount	+= search.w3GetResultCount( colNm );
	}
	out.println(search.w3GetResultXml());
%>
<%!
	public String getCheckReqXSS(javax.servlet.http.HttpServletRequest req, String parameter, String default_value) {
	    String req_value = (req.getParameter(parameter) == null ||  req.getParameter(parameter).equals("")) ? default_value : req.getParameter(parameter);
	    req_value = req_value.replaceAll("</?[a-zA-Z][0-9a-zA-Zê°-\uD7A3ã±-ã=/\"\'%;:,._()\\-# ]+>","");
	    req_value = req_value.replaceAll(">","");
	    req_value = req_value.replaceAll(">","");
	    return req_value;
	}
	
	public static String getCurrentDate() {
	    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat
	            ("yyyy.MM.dd", java.util.Locale.KOREA);
	    return dateFormat.format(new java.util.Date());
	}
%>