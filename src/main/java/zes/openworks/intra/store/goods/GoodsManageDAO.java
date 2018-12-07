/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.goods;

import java.io.File;
import java.io.FileReader;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Repository;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.user.UserVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.   김병욱       신규
 *</pre>
 * @see
 */
@Repository
public class GoodsManageDAO  extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsManageVO> goodsList(GoodsManageVO vo) {

        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }


        //날짜 설정 없으면 디폴트 현재 날짜
        /*if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }*/

        /* 서비스 현황 */
        if(!Validate.isEmpty(vo.getDataMap().get("q_goodsMonitorUrlChk")) ||  vo.getDataMap().get("q_goodsMonitorUrlChk") == "Y"){
            vo.getDataMap().put("q_beginDate",null);
            vo.getDataMap().put("q_endDate", null);
            vo.getDataMap().put("q_goodsTyCd", null);
        }

        vo.setTotalNum((Integer) selectByPk("_goodsManage.goodsCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<GoodsManageVO> dataList = list("_goodsManage.goodsList", vo.getDataMap());

//        Map<String, List<FileVO>> setmark = new HashMap<>();
//        List<FileVO>[] goodsMarkImage = new ArrayList<FileVO>();


        for(GoodsManageVO data : dataList) {
//            for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }

        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<GoodsManageVO>(dataList, vo);
    }

    /**
     * 서비스검토대기목록
     * goodsExmntList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsManageVO> goodsExmntList(GoodsManageVO vo) {

        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }

        //날짜 설정 없으면 디폴트 현재 날짜
        /* if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }*/
     
        Integer[] registSttus;
        registSttus = new Integer[] {1002, 1005, 1009}; // 검토대기, 승인반려
        vo.getDataMap().put("q_registSttus", registSttus);
        
        vo.setTotalNum((Integer) selectByPk("_goodsManage.goodsCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<GoodsManageVO> dataList = list("_goodsManage.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) 
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            if ( ! Validate.isNull(goodsMarkImage))  data.setMarkFile(goodsMarkImage);
            
            List<FileVO> goodsChngFile = new ArrayList<FileVO>();
            goodsChngFile = fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsChngSeq())));
            
            if( data.getGoodsChngSeq() > 0)
                data.setGcFile(goodsChngFile);
        }

        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<GoodsManageVO>(dataList, vo);
    }
    
    
    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsManageVO> goodsRequestList(GoodsManageVO vo) {
        
        vo.setTotalNum((Integer) selectByPk("_goodsManage.requestHisoryCount", vo.getDataMap()));
        List<GoodsManageVO> dataList = list("_goodsManage.requestHisory", vo.getDataMap());
        
        for(GoodsManageVO data : dataList) {
            if(data.getGoodsChngSeq() > 0)
                data.setGoodsFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsChngSeq()))));
        }
        
        return new Pager<GoodsManageVO>(dataList, vo);
    }

    /**
     * 서비스승인대기목록
     * goodsConfnList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsManageVO> goodsConfnList(GoodsManageVO vo) {

        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }

        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }

        Integer[] registSttus;
        //registSttus = new Integer[] {1002, 1005}; // 검토대기, 승인반려
        registSttus = new Integer[] {1004}; // 검토대기, 승인반려
        vo.getDataMap().put("q_registSttus", registSttus);
        vo.getDataMap().put("q_goodsRegistSttus", 1004); //임시저장

        vo.setTotalNum((Integer) selectByPk("_goodsManage.goodsCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<GoodsManageVO> dataList = list("_goodsManage.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
//            for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }

        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<GoodsManageVO>(dataList, vo);
    }

    /**
     * 삭제서비스목록
     * goodsDeleteList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsManageVO> goodsDeleteList(GoodsManageVO vo) {

        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }

        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }

        List<GoodsManageVO> dataList = list("_goodsManage.goodsDeleteList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
//            for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }
        vo.setTotalNum((Integer) selectByPk("_goodsManage.goodsDeleteCount", vo.getDataMap()));

        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<GoodsManageVO>(dataList, vo);
    }

    /**
     * 전시상태 Update 설명
     *
     * @param vo
     * @return int
     */
    public int dspyUpdate(GoodsManageVO vo) {
        int ret = 0;
        
        // 서비스 존재 연부 체크 
        for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
            vo.setGoodsCode(vo.getGoodsCodes()[i]);
            vo.setGoodsStatus(vo.getGoodsStatuss()[i]);
            ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);
            if (ret == 0) {
                return -1;
            }
        }
        // 서비스 전환 동시 업데이트
        int result = update("_goodsManage.dspyUpdate", vo);
     
        for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
            vo.setGoodsCode(vo.getGoodsCodes()[i]);
            vo.setExmntConfmCd(vo.getGoodsRegistSttus());
            vo.setReturnResn("");
            vo.setMngrId(vo.getUpdtId());
            
            if(vo.getExmntConfmHistSns() != null && vo.getExmntConfmHistSns()[i] > 0) {//변경요청시
             //   vo.setExmntConfmHistSn(vo.getExmntConfmHistSns()[i]);
             // result = update("_goodsManage.updateChangeAction", vo);
             // result = update("_goodsManage.dspyPricUpdate", vo);
            }else {
                result = insert("_goodsManage.reasonAction", vo);  // 히스토리 이력 남기기 
            } 
        }
        
        return result;
    }
    public int cfmItemContentUpdate(GoodsManageVO vo) {
        
        int result = 0;
        
        result = update("_goodsManage.cfmItemContentUpdate", vo);
     
        update("_goodsManage.tstGoodInfoIUpdate", vo);
        update("_goodsManage.tstGoodInfoITmpUpdate", vo);
        update("_goodsManage.tstExmnCnfmHStatUpdate", vo);        

        return result;
    }
    
    /**
     * 전시상태 Update 설명(승인처리 프로세스)
     *
     * @param vo
     * @return int
     */
    public int requestUpdate(GoodsManageVO vo) {
        
        int result = -1;
        int ret = 0;

        int ret1 = 0;
        int ret2 = 0;
        int ret3 = 0;
        int ret4 = 0;
        int ret5 = 0;
        int ret6 = 0;        
        
        vo.setLangCode("00");
        
        //goodsCode로 TST_GOOD_INFO_I_TMP에 있으면 수정 없으면 신규로 판별
//        ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);
        ret = (Integer) selectByPk("_goodsManage.cntTstGoodInfoITmpCount", vo);        
        ret6 = (Integer) selectByPk("_goodsManage.tstGoodSpecDescribeICount", vo);

        if(ret6 < 1){
            insert("_goodsManage.tstGoodSpecDescribeIInsert", vo);            
        }
        
        
        if (ret > 0) {
//1.TST_GOOD_INFO_I 테이블 업데이트
            update("_goodsManage.updateTstGoodInfoIApply", vo);

            update("_goodsManage.updateTstGoodSpecDescribeIApply", vo);
            
            
            ret1 = (Integer) selectByPk("_goodsManage.updateTstGoodMarkIApplyCnt", vo);
            if (ret1 > 0) {
            
                delete("_goodsManage.markDelete", vo);
                insert("_goodsManage.insertTstGoodMarkIApply", vo);
            }
            
            ret2 = (Integer) selectByPk("_goodsManage.updateTstGoodMetaIApplyCnt", vo);
            if (ret2 > 0) {
                
                delete("_goodsManage.metaDelete1", vo);                
                insert("_goodsManage.insertTstGoodMetaIApply", vo);
            }
            
            
            ret3 = (Integer) selectByPk("_goodsManage.updateTstCtfcAtchIApplyCnt", vo);
            if (ret3 > 0) {
                
                delete("_goodsManage.atchDelete", vo);                
                insert("_goodsManage.insertTstCtfcAtchIApply", vo);
            }            
            
            ret4 = (Integer) selectByPk("_goodsManage.updateTstGoodCateIApplyCnt", vo);
            if (ret4 > 0) {
                delete("_goodsManage.cateDelete", vo);                
                insert("_goodsManage.insertTstGoodCateIApply", vo);
            }            
            
            ret5 = (Integer) selectByPk("_goodsManage.updateTstGoodTagIApplyCnt", vo);            
            if (ret5 > 0) {
                delete("_goodsManage.tagDelete", vo);                
                insert("_goodsManage.insertTstGoodTagIApply", vo);
            }            
            
        }
        
        if (vo.getRequstSe() == 1001){  //전시 
            
            vo.setGoodsRegistSttus(1006);
            result = update("_goodsManage.goodsSttusUpdateTmp", vo);
            result = update("_goodsManage.goodsSttusUpdate", vo);
            
            
        }else if (vo.getRequstSe() == 1002){ //비전시
            vo.setGoodsRegistSttus(1007);
            result = update("_goodsManage.goodsSttusUpdate", vo);
            
        }else if (vo.getRequstSe() == 1003) {//삭제
            vo.setGoodsRegistSttus(1007);
            result = update("_goodsManage.goodsDelete", vo);
        }
        
        vo.setRequstProcessAt("Y"); //승인
        if (result > 0)
            result = update("_goodsManage.updateReuestProcessAt", vo);
        
        return result;
    }
    
    
    /**
     * goodsRequstAt 설명(검토/승인)
     *
     * @param vo
     * @return int
     */
    public int updateReuestProcessAt(GoodsManageVO vo) {
        int result = -1;
        result = update("_goodsManage.updateReuestExmnAt", vo);
        return result;
    }
    
    /**
     * langList 서비스 언어 목록
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> langList(GoodsManageVO vo) {
        return list("_goodsManage.langList", vo);
    }

    /**
     * ctgryList (카테고리 항목)
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> ctgryList(GoodsManageVO vo){
        return list("_goodsManage.ctgryList", vo);
    }



    /**
     * 서비스 상세 조회
     * @param GoodsManageVO vo
     * @return GoodsManageVO gvo
     */
    @SuppressWarnings("unchecked")
    public GoodsManageVO goodsView(GoodsManageVO vo){
        String goodsCode = vo.getGoodsCode();
        String ctgryCode = vo.getCtgryCode();
        
        GoodsManageVO gvo = new GoodsManageVO ();
        
        gvo = (GoodsManageVO)selectByPk("_goodsManage.goodsView", goodsCode);

        
        Map<String, String> parameterMap = new HashMap<String, String>(2);

        parameterMap.put("langCode", "00");
        parameterMap.put("ctgryCode", ctgryCode);
        parameterMap.put("goodsCode", goodsCode);
        List<String> listCtgryNm = list("_goodsManage.listCtgryNm", parameterMap);
        
        gvo.setLangCtgryNm(getCommanString(listCtgryNm));
        
        // 서비스 이미지 파일 정보
        if (Validate.isNotEmpty(gvo.getGoodsImageFileSeq())) {
            gvo.setImageFile(fileDao.getFiles(gvo.getGoodsImageFileSeq()));
        }

/*
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsFileSeq()))) {
            gvo.setGoodsFile(fileDao.getFiles(gvo.getGoodsFileSeq()));
        }
*/
        // 인증정보 파일 정보
        List<List<FileVO>> markCrtfc = new ArrayList<List<FileVO>>();
        for(int i = 0 ; i < gvo.getGoodsMark().size() ; i++) {
            if (gvo.getGoodsMark().get(i).get("CRTFCSEFILESEQ") == null) {
                markCrtfc.add(null);
            } else {
                markCrtfc.add(fileDao.getFiles(Integer.parseInt(String.valueOf(gvo.getGoodsMark().get(i).get("CRTFCSEFILESEQ") ))));
            }
        }
        gvo.setMarkCrtfcFile(markCrtfc);

        // 가격표 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getPriceDnFileSeq()))) {
            gvo.setPriceFile(fileDao.getFiles(gvo.getPriceDnFileSeq()));
        }

        // 서비스규격서 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsMnlFileSeq()))) {
            gvo.setMnlFile(fileDao.getFiles(gvo.getGoodsMnlFileSeq()));
        }

        // 사용자 메뉴얼 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getMnlDnFileSeq()))) {
            gvo.setDnlFile(fileDao.getFiles(gvo.getMnlDnFileSeq()));
        }

        // 기타첨부 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getEtcFileSeq()))) {
            gvo.setEtcFile(fileDao.getFiles(gvo.getEtcFileSeq()));
        }
        
        // 변경 사유서 첨부
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsChngSeq()))) {
            gvo.setGcFile(fileDao.getFiles(gvo.getGoodsChngSeq()));
        }

        return gvo;
    }

    

    /**
     * 서비스 상세 조회
     * @param GoodsManageVO vo
     * @return GoodsManageVO gvo
     */
    public GoodsManageVO goodsMailView(GoodsManageVO vo){
        String goodsCode = vo.getGoodsCode();
        
        GoodsManageVO gvo = (GoodsManageVO)selectByPk("_goodsManage.goodsMailView", goodsCode);
        // 서비스 이미지 파일 정보
        if (Validate.isNotEmpty(gvo.getGoodsImageFileSeq())) {
            gvo.setImageFile(fileDao.getFiles(gvo.getGoodsImageFileSeq()));
        }

/*
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsFileSeq()))) {
            gvo.setGoodsFile(fileDao.getFiles(gvo.getGoodsFileSeq()));
        }
*/
        // 인증정보 파일 정보
        List<List<FileVO>> markCrtfc = new ArrayList<List<FileVO>>();
        for(int i = 0 ; i < gvo.getGoodsMark().size() ; i++) {
            if (gvo.getGoodsMark().get(i).get("CRTFCSEFILESEQ") == null) {
                markCrtfc.add(null);
            } else {
                markCrtfc.add(fileDao.getFiles(Integer.parseInt(String.valueOf(gvo.getGoodsMark().get(i).get("CRTFCSEFILESEQ") ))));
            }
        }
        gvo.setMarkCrtfcFile(markCrtfc);

        // 가격표 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getPriceDnFileSeq()))) {
            gvo.setPriceFile(fileDao.getFiles(gvo.getPriceDnFileSeq()));
        }

        // 서비스소개서 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsMnlFileSeq()))) {
            gvo.setMnlFile(fileDao.getFiles(gvo.getGoodsMnlFileSeq()));
        }

        // 사용자 메뉴얼 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getMnlDnFileSeq()))) {
            gvo.setDnlFile(fileDao.getFiles(gvo.getMnlDnFileSeq()));
        }

        // 기타첨부 파일 정보
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getEtcFileSeq()))) {
            gvo.setEtcFile(fileDao.getFiles(gvo.getEtcFileSeq()));
        }
        
        // 변경 사유서 첨부
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsChngSeq()))) {
            gvo.setGcFile(fileDao.getFiles(gvo.getGoodsChngSeq()));
        }
        return gvo;
    }
    
    /**
     * 태그를 등록한다.
     */
    private int addTags(GoodsManageVO vo) {
        int ret = 1;
        /**
         * 메타태그 등록
         */
        int i = 0;
        if(Validate.isNotEmpty(vo.getMetaTAGs())) {
            String[] metaTAGs = vo.getMetaTAGs().split(",");
            i = metaTAGs.length;
            vo.setMetaGroupCd(1023);
            vo.setMetaEtcCn("");
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaTAGs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }

        if(Validate.isEmpty(vo.getGoodsTags()) || (vo.getGoodsTags().length() == 0)) {
            return ret;
        }

        String[] tags = vo.getGoodsTags().split(",");

        for(String tagNm : tags) {
            tagNm = tagNm.trim();
            if (Validate.isEmpty(tagNm)) {
                continue;
            }

            i++;
            if (i > 10) {
                return ret;
            }
            vo.setGoodsTagNm(tagNm);
            ret = insert("_goodsManage.tagInsert", vo);
        }
        return ret;
    }

    private int addMetas(GoodsManageVO vo) {
        int ret = 1;

        /**
         * 지원언어 등록
         */
        if(Validate.isNotEmpty(vo.getMetaLangs())) {
            Integer[] metaLangs = vo.getMetaLangs();
            String metaLangEtc = vo.getMetaLangEtc();
            vo.setMetaGroupCd(1019);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            
            for(Integer metaCode : metaLangs) {
                vo.setMetaCode(metaCode);
                if (metaCode == 1006) {
                    vo.setMetaEtcCn(metaLangEtc);
                } else {
                    vo.setMetaEtcCn("");
                }
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }else{
            vo.setMetaGroupCd(1019);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 지원OS 등록
         */
        if(Validate.isNotEmpty(vo.getMetaOSs())) {
            String[] metaOSs = vo.getMetaOSs().split(",");
            String metaOSetc = vo.getMetaOSetc();
            vo.setMetaGroupCd(1020);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            
            for(String metaCode : metaOSs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("9001")) {
                    vo.setMetaEtcCn(metaOSetc);
                } else {
                    vo.setMetaEtcCn("");
                }
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }else{
            vo.setMetaGroupCd(1020);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 지역 등록
         */
        if(Validate.isNotEmpty(vo.getMetaAreas())) {
            String[] metaAreas = vo.getMetaAreas().split(",");
            vo.setMetaGroupCd(2022);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaAreas) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2022);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 가격등록
         */
        if(Validate.isNotEmpty(vo.getMetaPrices())) {
            String[] metaPrices = vo.getMetaPrices().split(",");
            vo.setMetaGroupCd(2024);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaPrices) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2024);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 무료/체험 구분(2027)
         */      
        if(Validate.isNotEmpty(vo.getMetaExprns())) {
            String[] metaExprns = vo.getMetaExprns().split(",");
            vo.setMetaGroupCd(2027);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            
            for(String metaCode : metaExprns) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2027);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 계약단위(2028)
         */
        if(Validate.isNotEmpty(vo.getMetaCntrctUnits())) {
            String[] metaCntrctUnits = vo.getMetaCntrctUnits().split(",");
            String metaCntrctUnitetc = vo.getMetaCntrctUnitetc();
            vo.setMetaGroupCd(2028);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaCntrctUnits) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("1005")) {
                    vo.setMetaEtcCn(metaCntrctUnitetc);
                } else {
                    vo.setMetaEtcCn("");
                }
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }else{
            vo.setMetaGroupCd(2028);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 무료/체험 구분(2030)
         */
        if(Validate.isNotEmpty(vo.getMetaSvcs())) {
            String[] metaSvcs = vo.getMetaSvcs().split(",");
            vo.setMetaGroupCd(2030);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaSvcs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2030);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 호환성(표준)
         */
        if(Validate.isNotEmpty(vo.getMetaStds())) {
            String[] metaStds = vo.getMetaStds().split(",");
            vo.setMetaGroupCd(2031);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaStds) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2031);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);            
        }

        /**
         * 무료/체험 구분(2032)
         */
        if(Validate.isNotEmpty(vo.getMetaCnstcMthds())) {
            String[] metaCnstcMthds = vo.getMetaCnstcMthds().split(",");
            vo.setMetaGroupCd(2032);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaCnstcMthds) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2032);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 무료/체험 구분(2033)
         */
        if(Validate.isNotEmpty(vo.getMetaScqcLvs())) {
            String[] metaScqcLvs = vo.getMetaScqcLvs().split(",");
            vo.setMetaGroupCd(2033);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaScqcLvs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
        }else{
            vo.setMetaGroupCd(2033);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 지원AS 등록
         */
        if(Validate.isNotEmpty(vo.getMetaASs())) {
            String[] metaASs = vo.getMetaASs().split(",");
            String metaASetc = vo.getMetaASetc();
            vo.setMetaGroupCd(1021);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            for(String metaCode : metaASs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("1005") || metaCode.equals("2005")) {
                    vo.setMetaEtcCn(metaASetc);
                } else {
                    vo.setMetaEtcCn("");
                }
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }else{
            vo.setMetaGroupCd(1021);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }

        /**
         * 보유기술 및 자격증 등록
         */
        if(Validate.isNotEmpty(vo.getMetaTECHs())) {
            String[] metaTECHs = vo.getMetaTECHs().split(",");
            String metaTECHetc = vo.getMetaTECHetc();
            vo.setMetaGroupCd(1022);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
            
            for(String metaCode : metaTECHs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("1002")) {
                    vo.setMetaEtcCn(metaTECHetc);
                } else {
                    vo.setMetaEtcCn("");
                }
                //ret = insert("_webGoods.metaInsert", vo);
                ret = insert("_goodsManage.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }else{
            vo.setMetaGroupCd(1022);
            //ret = delete("_webGoods.metaDelete", vo);
            ret = delete("_goodsManage.metaDelete", vo);
        }
        

        return ret;
    }

    /**
     * goodsUpdate (클라우드 관리자 서비스 수정)
     * @return int
     */
    public int goodsUpdate(GoodsManageVO vo, HttpServletRequest request) {
        int ret = 0;
        Integer pChk = 0;
        
        // 서비스 판매상태 조회
        ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);

        // 판매상태가 ??? 이면 skip
        if (ret == 0) {
            return -1;
        }
        
        
        if ("dataForm1".equals(vo.getFormNm())) {  //서비스 일반 정보

            /********************************************/
            /** STEP1) 이미지 파일 처리 - 시작 *****************/
            /********************************************/
            // STEP1-1) 서비스 대표이미지 파일[수정시 대표이미지는 수정처리]
            if(vo.getImageMainFile().size() > 0) {
                fileDao.updateMainFile(vo.getImageMainFile(), vo.getGoodsImageFileSeq());
            }
            
            // STEP1-2) 사용자화면 이미지 등록
            if (vo.getImageFile().size() > 0) {
                vo.setGoodsImageFileSeq(fileDao.saveFile(vo.getImageFile(), vo.getGoodsImageFileSeq()));
            }
            
            /********************** **********************/
            /** STEP2) 서비스수정 처리 - 시작 *******************/
            /********************************************/
    
            if  (vo.getCtgryCds() != null)
            {
                // 서비스별 카테고리 정보 삭제
                ret = delete("_goodsManage.ctgryDelete", vo);
                
                // 서비스별 카테고리 정보 등록
                for ( String scode : vo.getCtgryCds()) {
                    vo.setpChk(pChk);
                    vo.setCtgryCd(scode);
                    ret = insert("_goodsManage.ctgryInsert", vo);
                }
            }
        }   //dataform1
        else if ("dataForm3".equals(vo.getFormNm())) {
            // 메타정보 등록
            ret = addMetas(vo);
        }
        else if ("dataForm4".equals(vo.getFormNm())) {
            // STEP1-3) 인증정보 파일
            ArrayList<Integer> CrtfcSeFileList;
            Integer[] markCdArry = {1004, 1001, 1007, 1005};
            
            if (Validate.isNotEmpty(vo.getCrtfcSeFileSeqs())) {
                CrtfcSeFileList = new ArrayList<Integer>(Arrays.asList(vo.getCrtfcSeFileSeqs()));
            } else {
                CrtfcSeFileList = new ArrayList<Integer>();
            }
            
            if (!"Y".equals(vo.getIsMark())) {//해당없음 체크 시 인증서 파일 전부 삭제
                /*******************************************************************/
                for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
                    int j = Integer.parseInt(vo.getMarkCrtfcFile().get(i).get(0).getInputNm().replace("markCrtfcFile", ""));
                    

                    
                    //Iterator it =  vo.getMarkCrtfcFile().get(i).iterator();
                    
                    /*for (FileVO itVo: vo.getMarkCrtfcFile().get(i)) {*/
                    
                    /*}*/
                    
                    /*******************************************************************/
                    /** STEP3) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 해당 상품코드 초기화 - 시작 **/
                    /*******************************************************************/
                   /* if (!Validate.isNotEmpty(vo.getCrtfcSeFileSeqs()[i])) {
                        ret = delete("_goodsManage.markDelete", vo);
                    }*/
                    /*******************************************************************/
                    /** STEP3) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 초기화 - 끝 *************/
                    /*******************************************************************/
                    

                    /**
                     * 1004: 클라우드서비스보안인증(CSAP)
                     * 1001: CC인증
                     * 1007: 클라우드서비스 품질성능 확인
                     * 1005: 나라장터종합쇼핑몰
                     */
                    if (Validate.isNotEmpty(vo.getMarkCrtfcFile().get(i).get(0).getInputNm())) {
                        /*markCdArry.add(Integer.parseInt(vo.getMarkCrtfcFile().get(i).get(0).getInputNm()));*/
                        if ("markCrtfcFile0".equals(vo.getMarkCrtfcFile().get(i).get(0).getInputNm())) {
                            vo.setMarkCd(markCdArry[0]);
                        }
                        if ("markCrtfcFile1".equals(vo.getMarkCrtfcFile().get(i).get(0).getInputNm())) {
                            vo.setMarkCd(markCdArry[1]);
                        }
                        if ("markCrtfcFile3".equals(vo.getMarkCrtfcFile().get(i).get(0).getInputNm())) {
                            vo.setMarkCd(markCdArry[2]);
                        }
                        
                        
                        /**********************************************************************/
                        /** STEP4) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 등록 - 시작 *******************/
                        /**********************************************************************/
                        ret = insert("_goodsManage.markInsert", vo);
                        /**********************************************************************/
                        /** STEP4) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 등록 - 끝 ********************/
                        /**********************************************************************/
                    }
                    
                    CrtfcSeFileList.set(j, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), Validate.isEmpty(CrtfcSeFileList.get(j)) ? -1 : CrtfcSeFileList.get(j)));
                }//end for
                


                if (Validate.isNotEmpty(vo.getCntrctNo())) {//나라장터 계약번호 등록 시
                    vo.setMarkCd(markCdArry[3]);
                    delete("_goodsManage.markDeleteOne", vo);
                    insert("_goodsManage.markInsert", vo);
                }else{
                    vo.setMarkCd(markCdArry[3]);
                    delete("_goodsManage.markDeleteOne", vo);
                }
                // 인증구분 첨부자료 정보
                if (Validate.isNotEmpty(vo.getMarkCds())) {
                    for (int i = 0; i < vo.getMarkCds().length ; i++) {
                        vo.setMarkCd(vo.getMarkCds()[i]);
                        if (Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
                            vo.setCrtfcSeFileSeq( CrtfcSeFileList.get(i) );
                            ret = update("_goodsManage.crtfcUpdate", vo);
                        }
                    }
                }
            }else{
                //isMark eq Y
                    if (Validate.isNotEmpty(CrtfcSeFileList)) {
                        delete("_goodsManage.markDelete", vo);
                        
                        for(int i = 0 ; i < CrtfcSeFileList.size() ; i++) {
                            
                            if (Validate.isNotEmpty(vo.getCrtfcSeFileSeqs()[i])) {
                                //removeFile(vo.getCrtfcSeFileSeqs()[i], CrtfcSeFileList.get(i).toString(), vo);
                                removeFile(vo.getCrtfcSeFileSeqs()[i], vo.getCrtfcSeFileIds());
                            }
                        }
                    }
                    
            }

            
        }
        else if ("dataForm14".equals(vo.getFormNm())) {
            // STEP1-4) 가격표 파일
            if(vo.getPriceFile().size() > 0) {
                vo.setPriceDnFileSeq(fileDao.saveFile(vo.getPriceFile(), vo.getPriceDnFileSeq()));
            }

            // STEP1-5) 서비스소개서 파일
            if (vo.getMnlFile().size() > 0) {
                vo.setGoodsMnlFileSeq(fileDao.saveFile(vo.getMnlFile(), vo.getGoodsMnlFileSeq()));
            }

            // STEP1-6) 사용자 메뉴얼 파일
            if(vo.getDnlFile().size() > 0) {
                vo.setMnlDnFileSeq(fileDao.saveFile(vo.getDnlFile(), vo.getMnlDnFileSeq()));
            }

            // STEP1-7) 기타첨부 파일
            if(vo.getEtcFile().size() > 0) {
                vo.setEtcFileSeq(fileDao.saveFile(vo.getEtcFile(), vo.getEtcFileSeq()));
            }
        }
        
        ret = update("_goodsManage.goodsUpdate", vo);
        
        /********************************************/
        /** STEP2) 서비스수정 처리 - 끝 *********************/
        /********************************************/

        // 서비스 수정이력 insert
        insert("_goodsManage.chngHistInsert", vo);
        
        return ret;
    }

    /**
     * goodsInsert (클라우드 관리자 서비스 등록)
     * @return int
     */
    public int goodsInsert(GoodsManageVO vo) {
        int ret = 0;

        /********************************************/
        /** STEP1) 이미지 파일 처리 - 시작 **********/
        /********************************************/
        
        // STEP1-1) 서비스 대표이미지 파일
        if (vo.getImageMainFile().size() > 0) {
            vo.setGoodsImageFileSeq(fileDao.saveFile(vo.getImageMainFile(), vo.getGoodsImageFileSeq()));
        }

        // STEP1-2) 서비스이미지 파일
        if (vo.getImageFile().size() > 0) {
            vo.setGoodsImageFileSeq(fileDao.saveFile(vo.getImageFile(), vo.getGoodsImageFileSeq()));
        }

        // STEP1-3) 인증정보 파일
        ArrayList<Integer> CrtfcSeFileList;
        if (Validate.isNotEmpty(vo.getCrtfcSeFileSeqs())) {
            CrtfcSeFileList = new ArrayList<Integer>(Arrays.asList(vo.getCrtfcSeFileSeqs()));
        } else {
            CrtfcSeFileList = new ArrayList<Integer>();
        }

        for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
            int j = Integer.parseInt(vo.getMarkCrtfcFile().get(i).get(0).getInputNm().replace("markCrtfcFile", ""));
            CrtfcSeFileList.set(j, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), Validate.isEmpty(CrtfcSeFileList.get(j)) ? -1 : CrtfcSeFileList.get(j)));
        }
        
        // STEP1-4) 가격표 파일
        if(vo.getPriceFile().size() > 0) {
            vo.setPriceDnFileSeq(fileDao.saveFile(vo.getPriceFile(), vo.getPriceDnFileSeq()));
        }

        // STEP1-5) 서비스소개서 파일
        if (vo.getMnlFile().size() > 0) {
            vo.setGoodsMnlFileSeq(fileDao.saveFile(vo.getMnlFile(), vo.getGoodsMnlFileSeq()));
        }

        // STEP1-6) 사용자 메뉴얼 파일
        if(vo.getDnlFile().size() > 0) {
            vo.setMnlDnFileSeq(fileDao.saveFile(vo.getDnlFile(), vo.getMnlDnFileSeq()));
        }

        // STEP1-7) 기타첨부 파일
        if(vo.getEtcFile().size() > 0) {
            vo.setEtcFileSeq(fileDao.saveFile(vo.getEtcFile(), vo.getEtcFileSeq()));
        }
        /********************************************/
        /** STEP1) 이미지 파일 처리 - 끝 ************/
        /********************************************/


        /********************************************/
        /** STEP2) 서비스등록 처리 - 시작 ***********/
        /********************************************/
        ret = insert("_goodsManage.goodsInsert", vo);
        /********************************************/
        /** STEP2) 서비스등록 처리 - 끝 *************/
        /********************************************/


        Integer pChk = 0;

        /**********************************************************************/
        /** STEP3) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 삭제 - 시작 ******/
        /**********************************************************************/
        ret = delete("_goodsManage.markDelete", vo);
        /**********************************************************************/
        /** STEP3) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 삭제 - 끝 ********/
        /**********************************************************************/

        /**********************************************************************/
        /** STEP4) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 등록 - 시작 ******/
        /**********************************************************************/
        if (Validate.isNotEmpty(vo.getGoodsMarkCds())) {
            for ( Integer icode : vo.getGoodsMarkCds()) {
                if (icode == 1001) {
                    pChk = 1;
                }
                vo.setMarkCd(icode);
                ret = insert("_goodsManage.markInsert", vo);
            }
        }
        /**********************************************************************/
        /** STEP4) 서비스별 표기 이미지정보(TST_GOOD_MARK_I) 등록 - 끝 ********/
        /**********************************************************************/

        // 인증구분 첨부자료 정보
        if (Validate.isNotEmpty(vo.getMarkCds())) {
            for (int i = 0; i < vo.getMarkCds().length ; i++) {
                vo.setMarkCd(vo.getMarkCds()[i]);

                if (Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
                    vo.setCrtfcSeFileSeq( CrtfcSeFileList.get(i) );
                    ret = update("_goodsManage.crtfcUpdate", vo);
                }
            }
        }

        // 서비스별 카테고리 정보 삭제
        ret = delete("_goodsManage.ctgryDelete", vo);

        // 서비스별 카테고리 정보 등록
        for ( String scode : vo.getCtgryCds()) {
            vo.setpChk(pChk);
            vo.setCtgryCd(scode);
            ret = insert("_goodsManage.ctgryInsert", vo);
        }


        // 서비스테그정보 삭제
        ret = delete("_goodsManage.tagDelete", vo);
        // 서비스테그정보 등록
        ret = addTags(vo);
        // 메타정보 등록
        ret = addMetas(vo);

        // 서비스정보에 수정일자 update
        update("_goodsManage.updtUpdate", vo);

        return ret;
    }

    public int g2bGoodsCount(GoodsPPSVO vo) {
        return (Integer) selectByPk("_goodsManage.g2bGoodsCount", vo);
    }

    public int g2bGoodsUpdate(GoodsPPSVO vo) {
        int ret = 0;
       /* //서비스카테고리 삭제
        delete("_goodsManage.ctgryDelete", vo);
        //서비스카테고리 등록
        insert("_goodsManage.g2bCtgryInsert", vo);
        //가격체크
        if(Validate.isNotEmpty(vo.getPriceChk())) {
            vo.setMetaGroupCd(2024);
            vo.setMetaEtcCn("");
            //서비스공통코드 삭제(가격체크)
            delete("_goodsManage.metaDelete", vo);
            vo.setMetaCode(Integer.valueOf(vo.getPriceChk()));
            insert("_goodsManage.metaInsert", vo);
        }
        //서비스인증구분
        if(Validate.isNotEmpty(vo.getMarkCd())) {
            //인증정보 삭제(나라장터인증)
            delete("_goodsManage.markDelete", vo);
            //인증정보 등록(나라장터인증)
            insert("_goodsManage.markInsert", vo);
        }*/
        ret = update("_goodsManage.g2bGoodsUpdate", vo);
        //insert("_goodsManage.chngHistInsert", vo);
        return ret;
    }

    public int g2bGoodsInsert(GoodsPPSVO vo) {
        int ret = 0;
        //서비스정보 등록
        ret = insert("_goodsManage.g2bGoodsInsert", vo);
       
        /*//서비스카테고리 삭제
        delete("_goodsManage.ctgryDelete", vo);
        //서비스카테고리 등록
        insert("_goodsManage.g2bCtgryInsert", vo);

        //가격체크
        if(Validate.isNotEmpty(vo.getPriceChk())) {
            vo.setMetaGroupCd(2024);
            vo.setMetaEtcCn("");
            //서비스공통코드 삭제(가격체크)
            delete("_goodsManage.metaDelete", vo);
            vo.setMetaCode(Integer.valueOf(vo.getPriceChk()));
            insert("_goodsManage.metaInsert", vo);
        }
        //서비스인증구분
        if(Validate.isNotEmpty(vo.getMarkCd())) {
            //인증정보 삭제(나라장터인증)
            delete("_goodsManage.markDelete", vo);
            //인증정보 등록(나라장터인증)
            insert("_goodsManage.markInsert", vo);
        }*/
        return ret;
    }

    /**
     * 삭제
     *
     * @param vo
     * @return
     */
    public int goodsDelete(GoodsManageVO vo) {
        
        int result = update("_goodsManage.goodsDelete", vo);
        if(result > 0){
            vo.setGoodsCode(vo.getGoodsCodes()[0]);
            vo.setExmntConfmCd(vo.getGoodsRegistSttus());
            vo.setReturnResn("");
            vo.setMngrId(vo.getUpdtId());
            insert("_goodsManage.reasonAction", vo); 
        }
        
        return result;
    }

    /**
     * 등록상태 Update
     *
     * @param vo
     * @return int
     */
    public int registUpdate(GoodsManageVO vo) {
        return update("_goodsManage.registUpdate", vo);
    }

    /**
     * fileCount 설명
     * @param fileSeq
     * @return
     */
    public int fileCount(Integer fileSeq) {
        return (Integer)selectByPk("_goodsManage.fileCount", fileSeq);
    }

    /**
     * ctgrySelect 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> ctgrySelect(GoodsManageVO vo) {

        return list("_goodsManage.ctgrySelect", vo);
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> goodsMarkCodeList(GoodsManageVO vo) {

        return list("_goodsManage.goodsMarkList", vo);
    }

    /**
     * 판매자 목록(팝업)
     */
    @SuppressWarnings("unchecked")
    public Pager<UserVO> sellerListPop(GoodsManageVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        if(Validate.isEmpty(parameterMap.get("q_searchKey0"))){
            parameterMap.put("q_searchKey0", "00");
        }
        List<UserVO> dataList = list("_goodsManage.sellerList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_goodsManage.sellerListCount", parameterMap));

        return new Pager<UserVO>(dataList, vo);
    }

    /**
     * 판매자 정보 조회
     * @param vo
     * @return
     */
    public GoodsManageVO sellerInfo(GoodsManageVO vo) {

        vo.setLangCode(Validate.isEmpty(vo.getLangCode()) ? "00" : vo.getLangCode());
        GoodsManageVO sellerInfoVo = (GoodsManageVO)selectByPk("_goodsManage.sellerInfo", vo);
        return sellerInfoVo;
    }

    /**
     * 검토자 정보 조회
     * @param vo
     * @return
     */
    public GoodsManageVO eManagerInfo(GoodsManageVO vo) {

        vo.setLangCode(Validate.isEmpty(vo.getLangCode()) ? "00" : vo.getLangCode());
        GoodsManageVO eManagerInfoVo = (GoodsManageVO)selectByPk("_goodsManage.eManagerInfo", vo);
        GoodsManageVO sellerInfoVo = (GoodsManageVO)selectByPk("_goodsManage.sellerInfo", vo);

        if (Validate.isNotEmpty(eManagerInfoVo)) {//승인반려 검토관리자, 승인관리자가 있는경우
            eManagerInfoVo.setLangCode(sellerInfoVo.getLangCode());
            eManagerInfoVo.setGoodsCode(sellerInfoVo.getGoodsCode());
            eManagerInfoVo.setExmntConfmCd(1005);
            eManagerInfoVo.setReturnResn((String) selectByPk("_goodsManage.returnReason", vo));
            return eManagerInfoVo;
        }else{//승인반려 검토자가 없는경우 판매자정보 출력
            return sellerInfoVo;
        }
    }

    /**
     * 반려사유 등록
     * @param vo
     * @return
     */
    public Integer reasonAction(GoodsManageVO vo) {
        Integer result = 0;
        
        if(vo.getExmntConfmHistSn() != null && vo.getExmntConfmHistSn()> 0) //변경요청시
            result = update("_goodsManage.updateChangeAction", vo); 
        else 
            result = insert("_goodsManage.reasonAction", vo);

        if(result > 0 ){
            vo.setGoodsRegistSttus(vo.getExmntConfmCd());
            //서비스변경
            if(vo.getExmntConfmCd() == 1003 || vo.getExmntConfmCd() == 1005 || vo.getExmntConfmCd() == 1010){ //반려인 경우
                result = update("_goodsManage.goodsSttusUpdate", vo);
            }else if(vo.getExmntConfmCd() == 1007){
                result = update("_goodsManage.goodsUpdateConfn", vo);
            }else if(vo.getExmntConfmCd() == 1004){
                result = update("_goodsManage.goodsSttusUpdate", vo);
            }
            
        }else{
            result = 0;
        }
        return result;
    }

    
    /**
     * 변경사유 등록
     * @param vo
     * @return
     */
    public Integer changeAction(GoodsManageVO vo) {
       
       Integer result =-1;
       GoodsManageVO gmVo = (GoodsManageVO) selectByPk("_webGoods.returnReason", vo);
       
       if (vo.getGcFile().size() > 0) 
           vo.setGoodsChngSeq(fileDao.saveFile(vo.getGcFile(), vo.getGoodsChngSeq()));
       
       if(gmVo != null)          
          result = update("_goodsManage.updateChangeAction", vo);
       else {
           result = insert("_goodsManage.insertChangeAction", vo);
       }
      
       return result;
    }
    
    /**
     * 변경사유 등록
     * @param vo
     * @return
     */
    public Integer confirmAction(GoodsManageVO vo) {        
        return update("_goodsManage.updateConfirmAction", vo);
    }
    
    /**
     * goodsMetaLang 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> goodsMetaLang(GoodsManageVO vo) {
        return list("_goodsManage.goodsMetaLangCode", vo);
    }

    /**
     * reasonView 설명
     * @param vo
     * @return
     */
    public GoodsManageVO reasonView(GoodsManageVO vo) {
        
        
        GoodsManageVO gvo =  (GoodsManageVO) selectByPk("_webGoods.changeView", vo);
        
        if (Validate.isNotEmpty(gvo)) {
            vo.setGoodsChngPc(gvo.getGoodsChngPc());    // 변경할 가격
            if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsChngSeq()))){
                vo.setGcFile(fileDao.getFiles(gvo.getGoodsChngSeq())); //사유서 파일 첨부
                vo.setGoodsChngSeq(gvo.getGoodsChngSeq()) ;
            }
        }
        
        return vo; 
    }
    
    
    /**
     * reasonView 설명
     * @param vo
     * @return
     */
    public GoodsManageVO changeView(GoodsManageVO vo) {
        return (GoodsManageVO) selectByPk("_webGoods.returnReason", vo);
    }


    /**
     * eManagerAuthInfo 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> eManagerAuthInfo(GoodsManageVO vo) {
        vo.setLangCode(Validate.isEmpty(vo.getLangCode()) ? "00" : vo.getLangCode());
        return list("_goodsManage.eManagerAuthInfo", vo);
    }

    /**
     * orderCnt 설명
     * @param vo
     * @return
     */
    public Integer orderCnt(GoodsManageVO vo) {
        return (Integer) selectByPk("_goodsManage.orderCnt", vo);
    }

    /**
     * 
     * goodCodeTmpCount 설명
     * @param vo
     * @return
     */
    public Integer goodCodeTmpCount(GoodsManageVO vo) {
        return (Integer) selectByPk("_goodsManage.goodCodeTmpCount", vo);
    }

    /**
     * goodsChngHist 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> goodsChngHist(GoodsManageVO vo) {
        return list("_goodsManage.goodsChngHist", vo);
    }
    
    /*변경신청 이력*/
    @SuppressWarnings("unchecked")
    public  List<Map<String, Object>> goodsChngRegHist(GoodsManageVO vo) {
        List<Map<String, Object>>  dataList  = list("_goodsManage.goodsChngRegHist", vo);
        
        
        for(Map<String, Object> data : dataList) {
            data.put("GOODS_CHNG_FILE_ID", fileDao.getFiles(Integer.parseInt(String.valueOf(data.get("GOODS_CHNG_FILE")))));
        }
        
        return dataList;
        
    }
    
    /*규격서 변경*/
    @SuppressWarnings("unchecked")
    public List<GoodsSpecVO> goodsSpecHist(GoodsManageVO vo) {
        List<GoodsSpecVO> dataList = list("_goodsManage.goodsSpecHist", vo);
        
        for(GoodsSpecVO data : dataList) {
            data.setSpecExcelFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getFileSeq()))));
        }
        
        return dataList;
    }

    /**
     * techCtgryChk 설명
     * @param vo
     * @return
     */
    public Integer techCtgryChk(GoodsManageVO vo) {
        return (Integer) selectByPk("_goodsManage.techCategory", vo);
    }

    /**
     * chngHistCodeInsert 설명
     * @param vo
     * @return
     */
    public Integer chngHistCodeInsert(GoodsManageVO vo) {
        return insert("_goodsManage.chngHistCodeInsert", vo);
    }

    /**
     * 서비스 모니터링 리스트
     * goodsMonitorList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public List<GoodsManageVO> goodsMonitorList(GoodsManageVO vo) {

        List<GoodsManageVO> dataList = list("_goodsManage.goodsMonitorList", vo);

        return dataList;
    }

    /**
     * 모니터링 정보 등록
     * @param vo
     * @return
     */
    public Integer goodsMonitorInsertAction(GoodsManageVO vo) {

        Integer result = insert("_goodsManage.goodsMonitorInsertAction", vo);

        return result;
    }

    /**
     * 서비스 모니터링 내역
     * goodsMonitorList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsManageVO> goodsMonitorHistory(GoodsManageVO vo) {

        //날짜 설정 없으면 디폴트 현재 날짜

        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            //c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }

        vo.setTotalNum((Integer) selectByPk("_goodsManage.goodsMonitorHistoryCount", vo.getDataMap()));

        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }

        List<GoodsManageVO> dataList = list("_goodsManage.goodsMonitorHistory", vo.getDataMap());

        return new Pager<GoodsManageVO>(dataList, vo);
    }

    /**
     * 조달청 서비스정보 리스트
     * goodsPpsList 설명
     * @param vo
     * @return
     */

    @SuppressWarnings({ "unchecked" })
    public Pager<GoodsPPSVO> goodsPpsList(GoodsPPSVO vo) {

         vo.setTotalNum((Integer) selectByPk("_goodsManage.goodsPpsCount", vo.getDataMap()));
        List<GoodsPPSVO> dataList = list("_goodsManage.goodsPpsList", vo.getDataMap());

        return new Pager<GoodsPPSVO>(dataList, vo);
    }
   
    /**
     * 조달청 서비스정보: 서비스코드 Update 설명
     *
     * @param vo
     * @return int
     */
    public int goodsCdUpdate(GoodsPPSVO vo) {
        
        int ret = 0;
 
        for(int i = 0 ; i < vo.getCntrNums().length ; i++) {
            vo.setCntrNum(vo.getCntrNums()[i]);
            vo.setLineNum(vo.getLineNums()[i]);
            vo.setGoodsCode(vo.getGoodsCodes()[i]);
                             
            ret = (Integer) selectByPk("_goodsManage.goodsCdUpCount", vo);
            if (ret == 0) {
                return -1;
            }
            ret =  update("_goodsManage.goodsCdUpdate", vo);
        }
        return ret;
    }

    public  GoodsSpecVO GoodsSpecInfo(GoodsSpecVO vo) {
        
        GoodsSpecVO gvo = (GoodsSpecVO)  selectByPk("_goodsManage.goodsSpecDescribeInfo", vo);
       if(gvo != null){
            if(Validate.isNotEmpty(fileDao.getFiles(gvo.getFileSeq()))) {
                gvo.setSpecExcelFile(fileDao.getFiles(gvo.getFileSeq()));
            }
        }
        return  gvo;
    }

    public void overseasProductsInsertUpdate(Map<String, String> paramMap) {
        insert("_goodsManage.overseasProductsInsertUpdate", paramMap);
    }
    
    /**
     * 신청자 정보 조회
     * @param vo
     * @return
     */
    public GoodsManageVO requestUserInfo(GoodsManageVO vo) {

        GoodsManageVO userInfoVo = (GoodsManageVO)selectByPk("_goodsManage.requestUserInfo", vo);
        return userInfoVo;
    }

    /**
     * storeLangNm 설명
     * @param langCode
     * @return
     */
    public GoodsManageVO storeLangNm(String langCode) {
        return (GoodsManageVO) selectByPk("_goodsManage.storeLangNm", langCode);
    }

    /**
     * goodsStoreList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> goodsStoreList(GoodsManageVO vo) {
        return (Map<String, Object>)selectByPk("_goodsManage.goodsStoreList", vo);
    }

    /**
     * goodsMetaPrice 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> goodsMetaPrice(GoodsManageVO vo) {
        return list("_goodsManage.goodsMetaPriceCode", vo);
    }

    /**
     * goodsMetaList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> goodsMetaList(GoodsManageVO vo) {
        return list ("_goodsManage.goodsMetaList", vo);
    }

    /**
     * updateTstGoodSpecDescribeI 설명
     * @param specVo
     * @return
     */
    public Integer updateTstGoodSpecDescribeI(GoodsSpecVO specVo) {
        return update("_goodsManage.updateTstGoodSpecDescribeI", specVo);
    }

    /**
     * goodsFormOneUpdate 설명
     * @param vo
     * @param request
     * @return
     */
    public Integer goodsFormOneUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return update("_goodsManage.goodsFormOneUpdate", vo);
    }

    /**
     * suplyCnt 설명
     * @param vo
     * @return
     */
    public int suplyCnt(GoodsManageVO vo) {
        return (Integer) selectByPk("_goodsManage.suplyCnt", vo);
    }
    
    /**
     * getCommanString 리스트의 문자열을 콤머로 연결한다.
     * 
     * @param termLst
     * @return
     */
    private String getCommanString(List<String> termLst) {
        if(!Validate.isEmpty(termLst)) {
            StringBuilder commaSepValueBuilder = new StringBuilder();
            for(int j = 0 ; j < termLst.size() ; j++) {
                commaSepValueBuilder.append(termLst.get(j));

                if(j != termLst.size() - 1) {
                    commaSepValueBuilder.append(", ");
                }
            }

            return commaSepValueBuilder.toString();
        } else {
            return null;
        }
    }

    /**
     * 파일 고유 ID를 통하여 하나의 파일을 삭제 한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @param fileId 삭제할 파일의 고유 id
     * @return
     */
    public int removeFile(Integer fileSeq, String fileId, GoodsManageVO vo) {

        int markRet = 0;
        int ret = 0;

        if(Validate.isNotEmpty(vo.getMarkCd())) {
            markRet = delete("_goodsManage.markDeleteOne", vo);    
        }
        
        if (markRet > 0) {
             ret = removeFile(fileSeq, new String[] { fileId });
        }
        
        return ret;
    }
    
    /**
     * 일련번호에 해당하는 파일중 지정된 고유 ID에 해당하는 파일들을 삭제한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @param fileIds 삭제할 파일의 고유 id 목록
     * @return
     */
    @SuppressWarnings("unchecked")
    public int removeFile(Integer fileSeq, String[] fileIds) {

        int affected = 0;

        if(fileSeq <= 0) {
            return affected;
        }

        if(Validate.isNotEmpty(fileIds)) {

            List<FileVO> fileList = list("zes.openworks.component.file.getFiles", fileSeq);

            for(String fileId : fileIds) {
                
                for(FileVO baseFileVo : fileList) {
                                        
                    if(fileId.equals(baseFileVo.getFileId())) {

                        FileUtil.delete(GlobalConfig.UPLOAD_ROOT + baseFileVo.getFileUrl());

                        affected += delete("zes.openworks.component.file.deleteFile", baseFileVo);
                        break;
                    }
                }
            }
        }
        return affected;
    }
    
    
    
}
