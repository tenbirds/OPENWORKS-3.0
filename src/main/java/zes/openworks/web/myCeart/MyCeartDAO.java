/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNofyVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNotifySplyVO;
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.myCeart.vo.MyCeartGoodsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2IVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartNotifySplyVO;
import zes.openworks.web.myCeart.vo.MyCeartPaas2VO;
import zes.openworks.web.myCeart.vo.MyCeartPaasVO;
import zes.openworks.web.myCeart.vo.MyCeartPurchsDtlsVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DnVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DoVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2IVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasDVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartScs2VO;
import zes.openworks.web.myCeart.vo.MyCeartTenderVO;
import zes.openworks.web.register.RegisterUserVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctGoodsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;
import zes.openworks.web.wish.myWish.MyWishVO;

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
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */
@Repository
public class MyCeartDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;    

    /**
     * getCodeNames 그룹코드에 해당하는 코드의 내용을 리스트로 구한다.
     * @param groupcd
     * @param indvdiz_cds
     * @return
     */
    private List<String> getCodeNames(int groupcd, Object indvdiz_cds) 
    {
        if (indvdiz_cds != null) 
        {
            String cds = String.valueOf(indvdiz_cds) ;
            if  (!"".equals(cds))
            {
                Map<String, Object> parameterMap = new HashMap<String, Object>();
                parameterMap.put("groupCd",    groupcd);                             
                parameterMap.put("indvdizCds", cds);           
                
                List<String> termLst = (List<String>)list("_myCeart.opCodeIndvdlzNames", parameterMap);
                
                return termLst;
            }
            else
            {
                return null;
            }
        }
        else
        {
            return null;
        }        
    }
    
    /**
     * getCommanString 리스트의 문자열을 콤머로 연결한다.
     * @param termLst
     * @return
     */
    private String getCommanString(List<String> termLst) 
    {
        if (!Validate.isEmpty(termLst)) 
        {
            StringBuilder commaSepValueBuilder = new StringBuilder();
            for ( int j = 0; j< termLst.size(); j++)
            {
                commaSepValueBuilder.append(termLst.get(j));
               
                if ( j != termLst.size()-1)
                {
                    commaSepValueBuilder.append(",");
                }
            }
    
            return commaSepValueBuilder.toString();
        }
        else
        {
            return null;
        }
    }
    

    /**
     * buyingRequestList (상세정보(견적)요청서 목록)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCeartVO> buyingRequestList(Map parameterMap) {
        return list("_myCeart.buyingRequestList", parameterMap);
    }

    /**
     * buyingRequestListExcel (상세정보(견적)요청서 목록(엑셀다운용))
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCeartVO> buyingRequestListExcel(Map parameterMap) {
        return list("_myCeart.buyingRequestListExcel", parameterMap);
    }

    /**
     * 상세정보(견적)요청서 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int buyingRequestListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCeart.buyingRequestListCount", parameterMap);
    }

    /**
     * buyingRequestList (상세정보(견적)요청서 목록)
     * @param vo
     * @return
     */
    public Map<String, Object> buyingRequestInfo(MyCeartVO vo) {
        return (Map<String, Object>) selectByPk("_myCeart.buyingRequestInfo", vo);
    }

    /**
     * buyingRequestList (상세정보(견적)요청서 공급자 정보 목록)
     * @param vo
     * @return
     */
    public List<MyCeartVO> buyingRequestDetailList(MyCeartVO vo) {
        return list("_myCeart.buyingRequestDetailList", vo);
    }

    /**
     * updateContractChoice (계약대상 선정)
     * @param tcnBidNotifyVO
     * @return int
     */
    public int updateContractChoice(MyCeartVO vo) {
        // 첨부파일
        if(vo.getEvalSheetFileList() != null && vo.getEvalSheetFileList().size() > 0) {
            vo.setEvalSheetFile(fileDao.saveFile(vo.getEvalSheetFileList(), vo.getEvalSheetFile()));
        }

        update("_myCeart.updateContractChoiceDtl", vo); // 상세정보 완료처리
        return update("_myCeart.updateContractChoiceMst", vo); // 마스터 완료처리
    }

    /**
     * buyingRequestChoiceReport (선정평가서 정보 조회)
     * @param vo
     * @return
     */
    public Map<String, Object> buyingRequestChoiceReport(MyCeartVO vo) {
        return (Map<String, Object>) selectByPk("_myCeart.buyingRequestChoiceReport", vo);
    }

    /**
     * updateFinishRequest (계약체결 완료요청)
     * @param HashMap
     * @return int
     */
    public int updateFinishRequest(HashMap map) {

        return update("_myCeart.updateFinishRequest", map);
    }

    /**
     * myCeartBidNotifyInfo (입찰공고정보 조회)
     * @param vo
     * @return
     */
    public List<MyCeartBidNotifyVO> myCeartBidNotifyInfo(MyCeartBidNotifyVO vo) {
        return list("_myCeart.selectMyCeartBidNotifyInfo", vo);
    }

    /**
     * myCeartNotifySplyInfo (입찰공고 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    public List<MyCeartNotifySplyVO> myCeartNotifySplyInfo(MyCeartNotifySplyVO vo) {
        return list("_myCeart.selectMyCeartNotifySplyInfo", vo);
    }

    /**
     * myCeartInfoBySassI (상세정보(견적)요청서 SaaS I)
     * @param vo
     * @return
     */
    public List<MyCeartSaasIVO> myCeartInfoBySassI(MyCeartSaasIVO vo) {
        return list("_myCeart.selectMyCeartInfoBySassI", vo);
    }

    /**
     * myCeartInfoBySassI (상세정보(견적)요청서 SaaS2 I)
     * @param vo
     * @return
     */
    public List<MyCeartSaasIVO> myCeartInfoBySass2I(MyCeartSaas2IVO vo) {
        return list("_myCeart.selectMyCeartInfoBySass2I", vo);
    }

    /**
     * myCeartInfoBySassD (상세정보(견적)요청서 SaaS D)
     * @param vo
     * @return
     */
    public List<MyCeartSaasDVO> myCeartInfoBySassD(MyCeartSaasDVO vo) {
        return list("_myCeart.selectMyCeartInfoBySassD", vo);
    }

    /**
     * myCeartInfoBySass2Dn (상세정보(견적)요청서 SaaS2 Dn)
     * @param vo
     * @return
     */
    public List<MyCeartSaas2DnVO> myCeartInfoBySass2Dn(MyCeartSaas2DnVO vo) {
        return list("_myCeart.selectMyCeartInfoBySass2Dn", vo);
    }

    /**
     * myCeartInfoBySass2Do (상세정보(견적)요청서 SaaS2 Do)
     * @param vo
     * @return
     */
    public List<MyCeartSaas2DoVO> myCeartInfoBySass2Do(MyCeartSaas2DoVO vo) {
        return list("_myCeart.selectMyCeartInfoBySass2Do", vo);
    }

    /**
     * myCeartInfoByPass (상세정보(견적)요청서 PaaS)
     * @param vo
     * @return
     */
    public List<MyCeartPaasVO> myCeartInfoByPass(MyCeartPaasVO vo) {
        return list("_myCeart.selectMyCeartInfoByPass", vo);
    }

    /**
     * myCeartInfoByPass2 (상세정보(견적)요청서 PaaS2)
     * @param vo
     * @return
     */
    public List<MyCeartPaas2VO> myCeartInfoByPass2(MyCeartPaas2VO vo) {
        return list("_myCeart.selectMyCeartInfoByPass2", vo);
    }

    /**
     * myCeartInfoByIassI (상세정보(견적)요청서 IaaS I)
     * @param vo
     * @return
     */
    public List<MyCeartIaasIVO> myCeartInfoByIassI(MyCeartIaasIVO vo) {
        return list("_myCeart.selectMyCeartInfoByIassI", vo);
    }

    /**
     * myCeartInfoByIass2I (상세정보(견적)요청서 IaaS2 I)
     * @param vo
     * @return
     */
    public List<MyCeartIaas2IVO> myCeartInfoByIass2I(MyCeartIaas2IVO vo) {
        return list("_myCeart.selectMyCeartInfoByIass2I", vo);
    }

    /**
     * myCeartInfoByIassDd (상세정보(견적)요청서 IaaS DD)
     * @param vo
     * @return
     */
    public List<MyCeartIaasDdVO> myCeartInfoByIassDd(MyCeartIaasDdVO vo) {
        return list("_myCeart.selectMyCeartInfoByIassDd", vo);
    }

    /**
     * myCeartInfoByIass2Dd (상세정보(견적)요청서 IaaS2 DD)
     * @param vo
     * @return
     */
    public List<MyCeartIaas2DdVO> myCeartInfoByIass2Dd(MyCeartIaas2DdVO vo) {
        return list("_myCeart.selectMyCeartInfoByIass2Dd", vo);
    }

    /**
     * myCeartInfoByIassDs (상세정보(견적)요청서 IaaS DS)
     * @param vo
     * @return
     */
    public List<MyCeartIaasDsVO> myCeartInfoByIassDs(MyCeartIaasDsVO vo) {
        return list("_myCeart.selectMyCeartInfoByIassDs", vo);
    }

    /**
     * myCeartInfoByIass2Ds (상세정보(견적)요청서 IaaS2 DS)
     * @param vo
     * @return
     */
    public List<MyCeartIaas2DsVO> myCeartInfoByIass2Ds(MyCeartIaas2DsVO vo) {
        return list("_myCeart.selectMyCeartInfoByIass2Ds", vo);
    }

    /**
     * myCeartGoodsList (상세정보(견적)요청서 서비스 상세 정보 조회)
     * @param vo
     * @return
     */
    public List<MyCeartGoodsVO> myCeartGoodsList(MyCeartGoodsVO vo) {
        return list("_myCeart.selectMyCeartGoodsList", vo);
    }

    /**
     * compareMyCeartInfoBySassI (상세정보(견적)요청서 SaaS 조회(비교 팝업용))
     * @param vo
     * @return
     */
    public List<MyCeartSaasIVO> compareMyCeartInfoBySassI(MyCeartSaasIVO vo) {
        return list("_myCeart.compareMyCeartInfoBySassI", vo);
    }

    /**
     * compareMyCeartInfoBySassD (상세정보(견적)요청서 SaaS 상세 조회(비교 팝업용))
     * @param vo
     * @return
     */
    public List<MyCeartSaasDVO> compareMyCeartInfoBySassD(MyCeartSaasDVO vo) {
        return list("_myCeart.compareMyCeartInfoBySassD", vo);
    }

    /**
     * compareMyCeartInfoByPass (상세정보(견적)요청서 PaaS 조회(비교 팝업용))
     * @param vo
     * @return
     */
    public List<MyCeartPaasVO> compareMyCeartInfoByPass(MyCeartPaasVO vo) {
        return list("_myCeart.compareMyCeartInfoByPass", vo);
    }

    /**
     * compareMyCeartInfoByIassI (상세정보(견적)요청서 IaaS I(비교 팝업용))
     * @param vo
     * @return
     */
    public List<MyCeartIaasIVO> compareMyCeartInfoByIassI(MyCeartIaasIVO vo) {
        return list("_myCeart.compareMyCeartInfoByIassI", vo);
    }

    /**
     * compareMyCeartInfoByIassDd (상세정보(견적)요청서 IaaS DD(비교 팝업용))
     * @param vo
     * @return
     */
    public List<MyCeartIaasDdVO> compareMyCeartInfoByIassDd(MyCeartIaasDdVO vo) {
        return list("_myCeart.compareMyCeartInfoByIassDd", vo);
    }

    /**
     * compareMyCeartInfoByIassDs (상세정보(견적)요청서 IaaS DS(비교 팝업용))
     * @param vo
     * @return
     */
    public List<MyCeartIaasDsVO> compareMyCeartInfoByIassDs(MyCeartIaasDsVO vo) {
        return list("_myCeart.compareMyCeartInfoByIassDs", vo);
    }

    /**
     * buyingRequestList (입찰공고관리 목록 조회)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCeartBidNotifyVO> myCeartBidList(Map parameterMap) {
        return list("_myCeart.myCeartBidList", parameterMap);
    }

    /**
     * 상세정보(견적)요청서 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int myCeartBidListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCeart.myCeartBidListCount", parameterMap);
    }

    /**
     * cancleMyCeartBid (입찰 취소처리)
     * @param MyCeartBidNotifyVO
     * @return int
     */
    public int cancleMyCeartBid(MyCeartBidNotifyVO vo) {
        return update("_myCeart.cancleMyCeartBid", vo);
    }

    /**
     * updateMyCeartBidTerm (입찰공고 연기)
     * @param MyCeartBidNotifyVO
     * @return int
     */
    public int updateMyCeartBidTerm(MyCeartBidNotifyVO vo) {
        return update("_myCeart.updateMyCeartBidTerm", vo);
    }

    /**
     * updateMyCeartBidInfo (입찰공고 변경)
     * @param MyCeartBidNotifyVO
     * @return int
     */
    public int updateMyCeartBidInfo(MyCeartBidNotifyVO vo) {
        // 첨부파일 - 수의계약 첨부 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(vo.getOptlCntrFileList() != null && vo.getOptlCntrFileList().size() > 0) {
            if(vo.getOptlCntrFile() == 0){
                vo.setOptlCntrFile(fileDao.saveFile(vo.getOptlCntrFileList(), vo.getOptlCntrFile()));  
            }            
        }
        return update("_myCeart.updateMyCeartBidInfo", vo);
    }

    /**
     * myCeartTenderList (입찰공고관리 응찰현황(응찰자) 목록 조회)
     * @param vo
     * @return
     */
    public List<MyCeartTenderVO> myCeartTenderList(MyCeartTenderVO vo) {
        return list("_myCeart.myCeartTenderList", vo);
    }

    /**
     * updateMyCeartOpenAction (입찰공고 개찰처리)
     * @param MyCeartTenderVO
     * @return int
     */
    public int updateMyCeartOpenAction(MyCeartTenderVO vo) {
        int result = 0;

        try{
            // STEP1) 낙찰여부 정보에 insert
            result = insert("_myCeart.insertMyCeartOpenSuss", vo);

            // STEP2) 입찰공고 공급자 정보의 상태 변경
            if(result > 0 ){
                result = update("_myCeart.updateMyCeartOpenSply", vo);            
            }else{
                return 0;
            }

            // STEP3) 입찰공고 정보에 상태값 변경
            if(result > 0 ){
                result = update("_myCeart.updateMyCeartOpenMst", vo);            
            }else{
                return 0;
            }            
        }catch(Exception e){
            
        }

        return result;
    }

    /**
     * updateMyCeartSuccBidder (입찰공고 낙찰처리)
     * @param MyCeartTenderVO
     * @return int
     */
    public int updateMyCeartSuccBidder(MyCeartTenderVO vo) {
        int result = 0;
        try{
            // 평가서 정보 upload - 낙찰자만 처리
            if(vo.getBidSussGbn().equals("Y")){
                if(vo.getEvalSheetFileList() != null && vo.getEvalSheetFileList().size() > 0) {
                    if(vo.getEvalSheetFile() == 0){
                        vo.setEvalSheetFile(fileDao.saveFile(vo.getEvalSheetFileList(), vo.getEvalSheetFile()));  
                    }            
                }                
            }else{
                vo.setEvalSheetFile(0);
            }

            // STEP1) 입찰공고 공급자 확인정보(TCN_NOTIFY_SPLY_I) UPDATE
            result = update("_myCeart.updateSuccBidderSplyI", vo);
    
            // STEP2) 낙찰여부정보(TCN_BID_SUSS_I) UPDATE
            result = update("_myCeart.updateSuccBidderSussI", vo);
        }catch(Exception e){
            
        }
        return result;
    }

    /**
     * updateMyCeartSuccBidMst (낙찰자 정보 수정에 성공할 경우 공고 마스터에 상태 변경)
     * @param MyCeartTenderVO
     * @return int
     */
    public int updateMyCeartSuccBidMst(MyCeartTenderVO vo) {

        return update("_myCeart.updateMyCeartSuccBidMst", vo);
    }
    
    /**
     * updateMyCeartBidCancel (입찰공고 낙찰취소처리)
     * @param MyCeartTenderVO
     * @return int
     */
    public int updateMyCeartBidCancel(MyCeartTenderVO vo) {

        return update("_myCeart.updateMyCeartBidCancel", vo);
    }

    /**
     * updateMyCeartCancelBidMst (입찰공고 낙찰취소처리에 성공할 경우 공고 마스터에 상태 변경)
     * @param MyCeartTenderVO
     * @return int
     */
    public int updateMyCeartCancelBidMst(MyCeartTenderVO vo) {

        return update("_myCeart.updateMyCeartCancelBidMst", vo);
    }

    /**
     * purchsDtlsListCount (구매내역 관리 목록 갯수)
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int purchsDtlsListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCeart.purchsDtlsListCount", parameterMap);
    }

    /**
     * purchsDtlsList (구매내역 관리 목록)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCeartPurchsDtlsVO> purchsDtlsList(Map parameterMap) {
        return list("_myCeart.purchsDtlsList", parameterMap);
    }

    /**
     * purchsDtlsListExcel (구매내역 관리 목록 (엑셀다운용))
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCeartPurchsDtlsVO> purchsDtlsListExcel(Map parameterMap) {
        return list("_myCeart.purchsDtlsListExcel", parameterMap);
    }

    /**
     * updateAcmsltCrtfRequst (구매(실적)증명서 발급요청)
     * @param HashMap
     * @return int
     */
    public int updateAcmsltCrtfRequst(HashMap map) {

        return update("_myCeart.updateAcmsltCrtfRequst", map);
    }

    /**
     * insertCntrctCmpl (계약결과 등록)
     * @param SuplerCntrctVO
     * @return int
     */
    public int insertCntrctCmpl(SuplerCntrctVO vo) {
        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            if(vo.getCtrtcSn() <= 0){
                vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList()));  
            }            
        }
        
       
       /*if(vo.getSbscrbTyCd().equals(2002)) vo.setBuseoCode("ZZZZZZZ");
        vo.setBuseoNm(vo.getPurchsInsttNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);*/

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("userId", vo.getCommUserId());
        parameterMap.put("userTyCd", vo.getSbscrbTyCd());
        if(vo.getSbscrbTyCd() == 1001) {//개인 수요자/공급자
            parameterMap.put("tableId", "OP_USER_OPTION");
        } else if(vo.getSbscrbTyCd() == 3001 || vo.getSbscrbTyCd() == 3002){//공공기관 수요자
            parameterMap.put("tableId", "OP_USER_PBLINSTT_OPTION");
        } else {//기업 수요자/공급자
            parameterMap.put("tableId", "OP_USER_ENTRPRS_OPTION");
        }
        RegisterUserVO rvo = (RegisterUserVO) selectByPk("_suplerCeart.selectCntrcnUserInfor", parameterMap);
        vo.setPurchsInsttNm(rvo.getOrgnNm());
        
        int result = insert("_suplerCeart.insertSuplerCntrctCmpl", vo);
        vo.setBuseoCode(rvo.getBuseoCode());
        vo.setBuseoNm(rvo.getOrgnNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);
        
        SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
        gvo.setCntrctSn(vo.getCntrctSn());
        if(vo.getGoodsCodes() != null)
            for(int i =0; i < vo.getGoodsCodes().length; i++){
                if(!vo.getGoodsCodes()[i].equals("")){
                   gvo.setGoodsCode(vo.getGoodsCodes()[i]);
                   gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
                   /*gvo.setCntrctCount(vo.getCntrctCounts()[i]);*/
                   gvo.setSplyForm(vo.getSplyForms()[i]);
                   gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
                   insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
                }
            }
        return result;
    }

    /**
     * updateCntrctCmpl (계약결과 수정)
     * @param SuplerCntrctVO
     * @return int
     */
    public int updateCntrctCmpl(SuplerCntrctVO vo) {
        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(), vo.getCtrtcSn()));
        }
        
        int result =0;
        if(vo.getRlCntrctInsttAt() == null){
            delete("_suplerCeart.deleteRLuserInitInfo", vo);
        }
        
        
        //등록된 체결서비스중 삭제, 등록 , 수정 {{{{{ 
        if(vo.getCntrctSvcSns() != null && vo.getCntrctSvcSns().length > 0)
            result = delete("_suplerCeart.cntrctGoodsNotDelete", vo); 
        
        if(vo.getGoodsCodes() != null && vo.getGoodsCodes().length > 0){
            SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
            gvo.setCntrctSn(vo.getCntrctSn());
            for(int i =0; i < vo.getGoodsCodes().length; i++){
               gvo.setGoodsCode(vo.getGoodsCodes()[i]);
               gvo.setCntrctSvcSn(vo.getCntrctSvcSns()[i]);
               gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
               /*gvo.setCntrctCount(vo.getCntrctCounts()[i]);*/
               gvo.setSplyForm(vo.getSplyForms()[i]);
               gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
               result = insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
            }
        }
        //}}}
        
        //실이용자 민간기업으로 선택시 
        if(vo.getUserSe() != null && vo.getUserSe().equals("2")){
            //공공기관 있을시 삭제
            vo.setBuseoCode("");
            delete("_suplerCeart.deleteRLuserInfo", vo);
            
            //실제이용정보 민간기업시 등록 
            vo.setBuseoCode("ZZZZZZZ");
            vo.setBuseoNm(vo.getRealCmpny());
            vo.setRlCntrctInsttAt("Y");
            insert("_suplerCeart.mergeRLuserInfo", vo);
        }else if(vo.getUserSe() != null && vo.getUserSe().equals("3")){
            vo.setBuseoCode("ZZZZZZZ");
            delete("_suplerCeart.deleteRLuserInfo", vo);
        }
        
        return update("_suplerCeart.updateSuplerCntrctCmpl", vo);
    }

    /**
     * wholeServiceListCount (씨앗 전체 서비스 갯수)
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int wholeServiceListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCeart.wholeServiceListCount", parameterMap);
    }
    @SuppressWarnings("rawtypes")
    public int wholeServiceListCount2(Map parameterMap) {
        return (Integer) selectByPk("_myCeart.wholeServiceListCount2", parameterMap);
    }

    /**
     * wholeServiceList (씨앗 전체 서비스)
     * @param Map
     * @return
     */
    public List<SuplerServiceVO> wholeServiceList(Map parameterMap) {
        return list("_myCeart.wholeServiceList", parameterMap);
    }
    public List<SuplerServiceVO> wholeServiceList2(Map parameterMap) {
        return list("_myCeart.wholeServiceList2", parameterMap);
    }

    /**
     * cntrctDtlInfo (계약서 등록 데이터 조회)
     * @param SuplerCntrctVO
     * @return
     */
    public List<SuplerCntrctVO> cntrctDtlInfo(SuplerCntrctVO vo) {
        return list("_myCeart.cntrctDtlInfo", vo);
    }
    
    /**
     * cntrctDtlInfo (계약서 초기 등록폼에 기업/기관명 수정)
     * @param SuplerCntrctVO
     * @return
     */
    public List<SuplerCntrctVO> cntrctInitInfo(SuplerCntrctVO vo) {
        return list("_myCeart.cntrctInitInfo", vo);
    }
    
    
    /**
     * updateCntrctCmpl (계약결과 삭제)
     * @param SuplerCntrctVO
     * @return int
     */
    public int deleteCntrctCmpl(SuplerCntrctVO vo) {
        return delete("_myCeart.deleteCntrctCmpl", vo);
    }
    
    /**
     * myPgesStatCheck (입찰공고 관리 진행상태 체크)
     * @param MyCeartBidNotifyVO
     * @return int
     */
    public int myPgesStatCheck(MyCeartBidNotifyVO vo) {
        return delete("_myCeart.myPgesStatCheck", vo);
    }
    
    /**
     * myPgesStatCheck (로그인 회원 타입 코드 추출)
     * @param MyCeartBidNotifyVO
     * @return int
     */
    @SuppressWarnings("rawtypes")
    public int purchsDtlsUserTyCd(MyCeartPurchsDtlsVO vo) {
        return (Integer) selectByPk("_myCeart.purchsDtlsUserTyCd", vo);
    }
    
    /**
     * beffatEstmtList (사전견적관리)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCeartBeforeNofyVO> myCeartBeforeRequestList(Map parameterMap) {
        return list("_myCeart.myCeartBeforeRequestList", parameterMap);
    }
    
    /**
     *사전견적요청서 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int myCeartBeforeRequestListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCeart.myCeartBeforeRequestListCount", parameterMap);
    }
    
    /**
     * myCeartBidNotifyInfo (사전견적관리 조회)
     * @param vo
     * @return
     */
    public List<MyCeartBeforeNofyVO> myCeartBeforeNotifyInfo(MyCeartBeforeNofyVO vo) {
        return list("_myCeart.selectMyCeartBeforeNotifyInfo", vo);
    }

    
    /**
     * myCeartNotifySplyInfo (사전견적 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    public List<MyCeartBeforeNotifySplyVO> myCeartBeforeNotifySplyInfo(MyCeartBeforeNotifySplyVO vo) {
        return list("_myCeart.selectMyCeartBeforeNotifySplyInfo", vo);
    }
    
    
    /**
     * myCeartBeforeInfoBySassI (상세정보(사전견적)요청서 SaaS I)
     * @param vo
     * @return
     */
    public List<MyCeartSaasIVO> myCeartBeforeInfoBySassI(MyCeartSaasIVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoBySassI", vo);
    }
    
    /**
     * myCeartBeforeInfoBySassI (상세정보(사전견적)요청서 SaaS2 I)
     * @param vo
     * @return
     */
    public List<MyCeartSaas2IVO> myCeartBeforeInfoBySass2I(MyCeartSaas2IVO vo) {

        List<MyCeartSaas2IVO> lstSaasVo =  list("_myCeart.selectMyCeartBeforeInfoBySass2I", vo);
        
        int len = lstSaasVo.size();
        for(int i = 0; i<len ; i++)
        {
            MyCeartSaas2IVO saasVo = lstSaasVo.get(i);
            
            List<String> termLst = null;
            
            // 제공방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2042, saasVo.getSupportMethod());                
            lstSaasVo.get(i).setSupportMethodNm(getCommanString(termLst));
            
            // 사용자/관리자분리 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2061, saasVo.getUserManagerSeparate());                
            lstSaasVo.get(i).setUserManagerSeparateNm(getCommanString(termLst));
            
            // 서비스 제공방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2062, saasVo.getServiceSupplyMethod());                
            lstSaasVo.get(i).setServiceSupplyMethodNm(getCommanString(termLst));
            
            // 암호화 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2063, saasVo.getEncryption());                
            lstSaasVo.get(i).setEncryptionNm(getCommanString(termLst));
        }
        
        return lstSaasVo;
    }

    /**
     * myCeartBeforeInfoBySassD (상세정보(사전견적)요청서 SaaS D)
     * @param vo
     * @return
     */
    public List<MyCeartSaasDVO> myCeartBeforeInfoBySassD(MyCeartSaasDVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoBySassD", vo);
    }

    /**
     * myCeartBeforeInfoBySass2Dn (상세정보(사전견적)요청서 SaaS2 DNeed)
     * @param vo
     * @return
     */
    public List<MyCeartSaas2DnVO> myCeartBeforeInfoBySass2Dn(MyCeartSaas2DnVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoBySass2Dn", vo);
    }

    /**
     * myCeartBeforeInfoBySass2Do (상세정보(사전견적)요청서 SaaS2 Do)
     * @param vo
     * @return
     */
    public List<MyCeartSaas2DoVO> myCeartBeforeInfoBySass2Do(MyCeartSaas2DoVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoBySass2Do", vo);
    }

    /**
     * myCeartBeforeInfoByPass (상세정보(사전견적)요청서 PaaS)
     * @param vo
     * @return
     */
    public List<MyCeartPaasVO> myCeartBeforeInfoByPass(MyCeartPaasVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoByPass", vo);
    }

    /**
     * myCeartBeforeInfoByPass2 (상세정보(사전견적)요청서 PaaS2)
     * @param vo
     * @return
     */
    public List<MyCeartPaas2VO> myCeartBeforeInfoByPass2(MyCeartPaas2VO vo) 
    {
        List<MyCeartPaas2VO> lstPaasVo =  list("_myCeart.selectMyCeartBeforeInfoByPass2", vo);
        
        int len = lstPaasVo.size();
        for(int i = 0; i<len ; i++)
        {
            MyCeartPaas2VO paasVo = lstPaasVo.get(i);
            
            List<String> termLst = null ;
            
            // 호스팅 방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2064, paasVo.gethostingMethod()); 
            lstPaasVo.get(i).sethostingMethodNm(getCommanString(termLst));
            
            // 스케일링 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2066, paasVo.getScaling());    
            lstPaasVo.get(i).setScalingNm(getCommanString(termLst));
            
            // 플래폼 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2067, paasVo.getPlatform());                
            lstPaasVo.get(i).setPlatformNm(getCommanString(termLst));                
            
            // 런타임 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2068, paasVo.getRuntimes());                
            lstPaasVo.get(i).setRuntimesNm(getCommanString(termLst));                
            
            // 미들웨어 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2069, paasVo.getMiddlewares());                
            lstPaasVo.get(i).setMiddlewaresNm(getCommanString(termLst));                
            
            // 프레임워크 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2070, paasVo.getFrameworks());                
            lstPaasVo.get(i).setFrameworksNm(getCommanString(termLst));                
            
            // 서비스 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2071, paasVo.getServices());                
            lstPaasVo.get(i).setServicesNm(getCommanString(termLst));                
            
            // 애드온 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2072, paasVo.getAddons());                
            lstPaasVo.get(i).setAddonsNm(getCommanString(termLst));                
            
            // 위치 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2073, paasVo.getGeolocations());                
            lstPaasVo.get(i).setGeolocationsNm(getCommanString(termLst));                
        }
        
        return lstPaasVo;
    }


        

    /**
     * myCeartBeforeInfoByIassI (상세정보(사전견적)요청서 IaaS I)
     * @param vo
     * @return
     */
    public List<MyCeartIaasIVO> myCeartBeforeInfoByIassI(MyCeartIaasIVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoByIassI", vo);
    }

    /**
     * myCeartBeforeInfoByIass2I (상세정보(사전견적)요청서 IaaS2 I)
     * @param vo
     * @return
     */
    public List<MyCeartIaas2IVO> myCeartBeforeInfoByIass2I(MyCeartIaas2IVO vo) 
    {        
        List<MyCeartIaas2IVO> lstIaasVo =  list("_myCeart.selectMyCeartBeforeInfoByIass2I", vo);
        
        int len = lstIaasVo.size();
        for(int i = 0; i<len ; i++)
        {
            MyCeartIaas2IVO iaasVo = lstIaasVo.get(i);
            
            // 웹방화벽 - 상품유형 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            List<String> termLst = getCodeNames(2074, iaasVo.getWebGoodsKind());
            lstIaasVo.get(i).setWebGoodsKindNm(getCommanString(termLst));
        }
        
        return lstIaasVo;
    }

    /**
     * myCeartBeforeInfoByIassDd (상세정보(사전견적)요청서 IaaS DD)
     * @param vo
     * @return
     */
    public List<MyCeartIaasDdVO> myCeartBeforeInfoByIassDd(MyCeartIaasDdVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoByIassDd", vo);
    }

    /**
     * myCeartBeforeInfoByIass2Dd (상세정보(사전견적)요청서 IaaS2 DD)
     * @param vo
     * @return
     */
    public List<MyCeartIaas2DdVO> myCeartBeforeInfoByIass2Dd(MyCeartIaas2DdVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoByIass2Dd", vo);
    }

    /**
     * myCeartBeforeInfoByScs2 설명
     * @param vo
     * @return
     */
    public List<MyCeartScs2VO> myCeartBeforeInfoByScs2(MyCeartScs2VO vo) {

        List<MyCeartScs2VO> lstScsVo = list("_myCeart.selectMyCeartBeforeInfoByScs2", vo);
        
        List<String> termLst = null ;
        
        int len = lstScsVo.size();
        for(int i = 0 ; i < len ; i++) {
            MyCeartScs2VO scsVo = lstScsVo.get(i);

            // 컨설팅 영역 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2082, scsVo.getCnslRelm());
            lstScsVo.get(i).setCnslRelmNm(getCommanString(termLst));

            // 컨설팅 범위 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2083, scsVo.getCnslScope());
            lstScsVo.get(i).setCnslScopeNm(getCommanString(termLst));

            //컨설팅된 수행 가능 지역 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2036, scsVo.getExcArea());
            lstScsVo.get(i).setExcAreaNm(getCommanString(termLst));
        }
        
        return lstScsVo;
    }
    
    /**
     * myCeartBeforeInfoByIassDs (상세정보(사전견적)요청서 IaaS DS)
     * @param vo
     * @return
     */
    public List<MyCeartIaasDsVO> myCeartBeforeInfoByIassDs(MyCeartIaasDsVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoByIassDs", vo);
    }

    /**
     * myCeartBeforeInfoByIass2Ds (상세정보(사전견적)요청서 IaaS2 DS)
     * @param vo
     * @return
     */
    public List<MyCeartIaas2DsVO> myCeartBeforeInfoByIass2Ds(MyCeartIaas2DsVO vo) {
        return list("_myCeart.selectMyCeartBeforeInfoByIass2Ds", vo);
    }
    
    /**
     * mybeffatEstmtListDeleteAction (사전견적관리 - 삭제)
     * @param vo
     * @return
     */
    public int myCeartBeforeRequestListDeleteAction(HashMap dataMap) {
        int confirmCnt = 0;
        confirmCnt += update("_myCeart.myCeartBeforeRequestListDelete", dataMap);
        return confirmCnt;
    }

    /**
     * insertbdGoodsTmp 설명
     * @param dataMap
     * @return
     */
    public int insertbdGoodsTmp(HashMap dataMap) {
        // TODO Auto-generated method stub
        int confirmCnt = 0;
        confirmCnt += update("_myCeart.insertbdGoodsTmp", dataMap);
        return confirmCnt;
    }
    

    /**
     * selectBdGoodsTmpNm 설명
     * @param string
     * @param vo
     * @return
     */
    public Map<String, Object> selectBdGoodsTmpNm(HashMap dataMap) {
        // TODO Auto-generated method stub
        return (Map<String, Object>) selectByPk("_myCeart.selectBdGoodsTmpNm", dataMap);
    }

    /**
     * selectBgGoodsList 설명
     * @param dataMap
     * @return
     */
    public List selectBgGoodsList(HashMap<String, String> dataMap) {
        // TODO Auto-generated method stub
        return list("_myCeart.selectBgGoodsList", dataMap);
    }

    /**
     * deleteBdGoodsTmp 설명
     * @param dataMap
     * @return
     */
    public int deleteBdGoodsTmp(HashMap<String, String> dataMap) {
        return delete("_myCeart.deleteBdGoodsTmp", dataMap);
    }

    /**
     * myWishHistory 설명
     * @param vo
     * @return
     */
    public List<MyWishVO> myWishHistory(MyWishVO vo) {
        return list("_myCeart.selectMyWishHistory", vo);
    }

}
