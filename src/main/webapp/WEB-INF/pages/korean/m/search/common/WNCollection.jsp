<%@ page pageEncoding = "UTF-8" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%!
    /**
    *  subject: 검색 환경 설정 페이지
    **/

    final static int CONNECTION_TIMEOUT = 20000;
	final static String CHARSET = "UTF-8";
	final static int REALTIME_COUNT=100;
	final static int PAGE_SCALE = 10; //view page list count

	final static int CONNECTION_KEEP = 0; //recevive mode
	final static int CONNECTION_REUSE = 2;
	final static int CONNECTION_CLOSE = 3;

	final static int ASC = 0; //order
	final static int DESC = 1; //order

	final static int USE_KMA_OFFOFF = 0; //synonym, morpheme
	final static int USE_KMA_ONON = 1;
	final static int USE_KMA_ONOFF = 2;
	
	final static int USE_RESULT_STRING = 0; //result data type	
	final static int USE_RESULT_XML = 1;
	final static int USE_RESULT_JSON = 2;
	final static int USE_RESULT_DUPLICATE_STRING = 3; //uid result data type	
	final static int USE_RESULT_DUPLICATE_XML = 4;
	final static int USE_RESULT_DUPLICATE_JSON = 5;

	final static int IS_CASE_ON = 1; //case on, off
	final static int IS_CASE_OFF = 0;

	final static int HI_SUM_OFFOFF = 0; //summarizing, highlighting
	final static int HI_SUM_OFFON = 1;
	final static int HI_SUM_ONOFF = 2;
	final static int HI_SUM_ONON = 3;
			
	final static int COMMON_OR_WHEN_NORESULT_OFF = 0;
	final static int COMMON_OR_WHEN_NORESULT_ON = 1;

	final static int INDEX_NAME = 0;
	final static int COLLECTION_NAME = 1;
	final static int PAGE_INFO = 2;
	final static int ANALYZER = 3;
	final static int SORT_FIELD = 4;
	final static int RANKING_OPTION = 5;
	final static int SEARCH_FIELD = 6;
	final static int RESULT_FIELD = 7;
	final static int DATE_RANGE = 8;
	final static int RANK_RANGE = 9;
	final static int EXQUERY_FIELD = 10;
	final static int COLLECTION_QUERY =11;
	final static int BOOST_QUERY =12;
	final static int FILTER_OPERATION = 13;
	final static int GROUP_BY = 14;
	final static int GROUP_SORT_FIELD = 15;
	final static int CATEGORY_BOOST = 16;
	final static int CATEGORY_GROUPBY = 17;
	final static int CATEGORY_QUERY = 18;
	final static int PROPERTY_GROUP = 19;
	final static int PREFIX_FIELD = 20;
	final static int FAST_ACCESS = 21;
	final static int MULTI_GROUP_BY = 22;
	final static int AUTH_QUERY = 23;
	final static int DEDUP_SORT_FIELD = 24;
	final static int COLLECTION_KOR = 25;	
	
	final static int MERGE_COLLECTION_NAME = 0;
	final static int MERGE_MAPPING_COLLECTION_NAME = 1;
	final static int MERGE_PAGE_INFO = 2;
	final static int MERGE_RESULT_FIELD = 3;
	final static int MERGE_MAPPING_RESULT_FIELD = 4;
	final static int MERGE_MULTI_GROUP_BY_FIELD = 5;
	final static int MERGE_MAPPING_MULTI_GROUP_BY_FIELD = 6;
	final static int MERGE_CATEGORY_GROUPBY_FIELD = 7;
	final static int MERGE_MAPPING_CATEGORY_GROUPBY_FIELD = 8;

	//가상 통합 컬렉션을 사용하지 않을 경우 아래와 같이MERGE_COLLECTIONS에 정의한다.
	public String[] MERGE_COLLECTIONS = new String[]{""};

	//가상 통합 컬렉션을 사용할 경우 아래와 같이MERGE_COLLECTIONS에 정의한다.
	//public String[] MERGE_COLLECTIONS = new String[]{"merge_sample_bbs"}; 
    /*
	public class WNCollection {
		  
		public String[][] MERGE_COLLECTION_INFO = null;
		
		WNCollection(){
			
			//가상 통합 컬렉션을 사용할 경우, mapping되는 collection들의 정보를 정의한다.
			MERGE_COLLECTION_INFO = new String[][]
			{
				{
					"merge_sample_bbs", // set merge collection name
					"sample_bbs/sample_edu", // set collection name, delimiter: /
					"0,3",  // set merge collection pageinfo (start,count)
					"DOCID,TITLE,WRITER,CONTENT",// set merge document field
					"DOCID,TITLE,WRITER,CONTENT/DOCID,TITLE,WRITER,CONTENT", // set document field, delimiter: /
					"", // set merge collection multi-group-by field
					"", // set merge collection multi-group-by field, delimiter: /
					"", // set merge collection category-group-by field
					""  // set collection multi-group-by field, delimiter: /
				}					
			};
	*/
	
	static String SEARCH_IP="202.30.77.190";
	static int SEARCH_PORT=7000;
	static String MANAGER_IP="202.30.77.190";
	static int MANAGER_PORT=7800;

	public String[] COLLECTIONS = new String[]{"bizmatc","communication","notice","customer","premium","solution","consulting","introduction","en_bizmatc","en_communication","en_notice","en_customer","en_premium","en_solution","en_consulting","en_introduction","sp_bizmatc","sp_communication","sp_notice","sp_customer","sp_premium","sp_solution","sp_consulting","sp_introduction"};
	public String[] COLLECTIONS_NAME = new String[]{"bizmatc","communication","notice","customer","premium","solution","consulting","introduction","en_bizmatc","en_communication","en_notice","en_customer","en_premium","en_solution","en_consulting","en_introduction","sp_bizmatc","sp_communication","sp_notice","sp_customer","sp_premium","sp_solution","sp_consulting","sp_introduction"};
	public class WNCollection{
	public String[][] MERGE_COLLECTION_INFO = null;
	public String[][] COLLECTION_INFO = null;
		WNCollection(){
			COLLECTION_INFO = new String[][]
					{
					{
					"bizmatc", // set index name
					"bizmatc", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM",// set search field
					"DOCID,REGIST_DT,BBS_CD,BBSCTT_SEQ,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"bizmatc" // collection display name
					}
		         ,
					{
					"communication", // set index name
					"communication", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY/300,SOURCENAME,CTGRY_NM,ATTACH_CON,CMMNTY_ID",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"communication" // collection display name
					}
		         ,
					{
					"notice", // set index name
					"notice", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,FILE_SEQ,ATTACH_CON,MENU_PATH",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"notice" // collection display name
					}
		         ,
					{
					"customer", // set index name
					"customer", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM,SOURCENAME,PROGRESS_YN",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"customer" // collection display name
					}
		         ,
					{
					"premium", // set index name
					"premium", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"premium" // collection display name
					}
		         ,
					{
					"solution", // set index name
					"solution", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"solution" // collection display name
					}
		         ,
					{
					"consulting", // set index name
					"consulting", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"consulting" // collection display name
					}
		         ,
					{
					"introduction", // set index name
					"introduction", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"HEAD_CNTNTS,BODY_CNTNTS,MENU_PATH",// set search field
					"DOCID,REGIST_DT,HEAD_CNTNTS,BODY_CNTNTS/300,CONFM_STTUS,USER_MENU_URL,MENU_PATH",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"introduction" // collection display name
					}
		         ,
					{
					"en_bizmatc", // set index name
					"en_bizmatc", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM",// set search field
					"DOCID,REGIST_DT,BBS_CD,BBSCTT_SEQ,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_bizmatc" // collection display name
					}
		         ,
					{
					"en_communication", // set index name
					"en_communication", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY/300,SOURCENAME,CTGRY_NM,ATTACH_CON,CMMNTY_ID",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_communication" // collection display name
					}
		         ,
					{
					"en_notice", // set index name
					"en_notice", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,FILE_SEQ,ATTACH_CON,MENU_PATH",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_notice" // collection display name
					}
		         ,
					{
					"en_customer", // set index name
					"en_customer", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM,SOURCENAME,PROGRESS_YN",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_customer" // collection display name
					}
		         ,
					{
					"en_premium", // set index name
					"en_premium", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_premium" // collection display name
					}
		         ,
					{
					"en_solution", // set index name
					"en_solution", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_solution" // collection display name
					}
		         ,
					{
					"en_consulting", // set index name
					"en_consulting", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_consulting" // collection display name
					}
		         ,
					{
					"en_introduction", // set index name
					"en_introduction", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"HEAD_CNTNTS,BODY_CNTNTS,MENU_PATH",// set search field
					"DOCID,REGIST_DT,HEAD_CNTNTS,BODY_CNTNTS/300,CONFM_STTUS,USER_MENU_URL,MENU_PATH",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"en_introduction" // collection display name
					}
		         ,
					{
					"sp_bizmatc", // set index name
					"sp_bizmatc", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM",// set search field
					"DOCID,REGIST_DT,BBS_CD,BBSCTT_SEQ,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_bizmatc" // collection display name
					}
		         ,
					{
					"sp_communication", // set index name
					"sp_communication", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,CTGRY_NM,ATTACH_CON",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY/300,SOURCENAME,CTGRY_NM,ATTACH_CON,CMMNTY_ID",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_communication" // collection display name
					}
		         ,
					{
					"sp_notice", // set index name
					"sp_notice", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,FILE_SEQ,ATTACH_CON,MENU_PATH",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_notice" // collection display name
					}
		         ,
					{
					"sp_customer", // set index name
					"sp_customer", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM",// set search field
					"DOCID,REGIST_DT,BBS_CD,DOMAIN_CD,BBSCTT_SJ,BBSCTT_CN,CN_SUMRY,ATTACH_CON,CTGRY_NM,SOURCENAME,PROGRESS_YN",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_customer" // collection display name
					}
		         ,
					{
					"sp_premium", // set index name
					"sp_premium", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_premium" // collection display name
					}
		         ,
					{
					"sp_solution", // set index name
					"sp_solution", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_solution" // collection display name
					}
		         ,
					{
					"sp_consulting", // set index name
					"sp_consulting", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"GOODSNM,GOODSSUMRY,METAlICENCE,META_NM,ATTACH_CON,ENTNM,LANGSTORENM",// set search field
					"DOCID,REGIST_DT,CTGRY_CL_CD,LANGCODE,GOODSNM,USERID,GOODSIMAGEFILESEQ,GOODSSUMRY/60,GOODSRDCNT,CNTC_INSTT_CD,EVLSCORE,LANGSTORENM,CMMNTYID,ATTACH_CON,METAlICENCE,CNTC_GOODS_IMAGE_SEQ,MARK_IMG,META_NM,ENTNM",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_consulting" // collection display name
					}
		         ,
					{
					"sp_introduction", // set index name
					"sp_introduction", // set collection name
					"0,3",  // set pageinfo (start,count)
					"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
					"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
					"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
					"HEAD_CNTNTS,BODY_CNTNTS,MENU_PATH",// set search field
					"DOCID,REGIST_DT,HEAD_CNTNTS,BODY_CNTNTS/300,CONFM_STTUS,USER_MENU_URL,MENU_PATH",// set document field
					"", // set date range
					"", // set rank range
					"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
					"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
					"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
					"", // set filter operation (<fieldname:operator:value>)
					"", // set groupby field(field, count)
					"", // set sort field group(field/order,field/order,...)
					"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
					"", // set categoryGroupBy (fieldname:value)
					"", // set categoryQuery (fieldname:value)
					"", // set property group (fieldname,min,max, groupcount)
					"", // use check prefix query filed
					"", // set use check fast access field
					"", // set multigroupby field
					"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
					"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
					"sp_introduction" // collection display name
					}
					};
		}
	}
%>
<%
		// 개발 및 운영 도메인명을 확인해서 검색엔진 IP 변경
		if ("dev".equals(Config.getString("global.serviceMode"))) {
			SEARCH_IP="202.30.77.190";
			MANAGER_IP="202.30.77.190";
		} else if ("real".equals(Config.getString("global.serviceMode"))) {
			SEARCH_IP="202.30.77.186";
			MANAGER_IP="202.30.77.186";
		}
%>