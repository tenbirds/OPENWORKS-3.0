/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartBidPartcptnVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2DdVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2DsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2IVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDdVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaas2VO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2DnVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2DoVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2IVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartScs2VO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSuplySttusVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctGoodsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;
import zes.openworks.web.suplerCeart.vo.SuplySttusEndsUserVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 22.    이슬버미       신규
 * 2017. 12. 12.    SKYOU  수정    공급현황>계약수기등록
 *         </pre>
 * 
 * @see
 */
@Repository
public class SuplerCeartDAO extends EgovAbstractMapper {

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
     * 상세정보(견적)요청서 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int buyingRequestListCount(Map parameterMap) {

        return (Integer) selectByPk("_suplerCeart.buyingRequestListCount", parameterMap);
    }

    /**
     * buyingRequestList (상세정보(견적)요청서 목록)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartVO> buyingRequestList(Map parameterMap) {
        return list("_suplerCeart.buyingRequestList", parameterMap);
    }

    /**
     * buyingRequestListExcel (상세정보(견적)요청서 목록(엑셀다운용))
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartVO> buyingRequestListExcel(Map parameterMap) {
        return list("_suplerCeart.buyingRequestListExcel", parameterMap);
    }

    /**
     * updateSplyConfmGbn (입찰공고 공급자 확인정보의 확인여부 update)
     * 
     * @param SuplerCeartBidNotifyVO
     * @return int
     */
    public int updateSplyConfmGbn(SuplerCeartBidNotifyVO vo) {

        return update("_suplerCeart.updateSplyConfmGbn", vo);
    }

    /**
     * suplerCeartBidNotifyInfo (입찰공고정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartBidNotifyVO> suplerCeartBidNotifyInfo(SuplerCeartBidNotifyVO vo) {
        return list("_suplerCeart.suplerCeartBidNotifyInfo", vo);
    }

    /**
     * suplerCeartNotifySplyInfo (입찰공고 공급자 확인정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartNotifySplyVO> suplerCeartNotifySplyInfo(SuplerCeartNotifySplyVO vo) {
        return list("_suplerCeart.selectSuplerCeartNotifySplyInfo", vo);
    }

    /**
     * suplerCeartInfoByPass (상세정보(견적)요청서 PaaS)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartPaasVO> suplerCeartInfoByPass(SuplerCeartPaasVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByPass", vo);
    }

    /**
     * suplerCeartInfoByPass (상세정보(견적)요청서 PaaS2)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartPaas2VO> suplerCeartInfoByPass2(SuplerCeartPaas2VO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByPass2", vo);
    }

    /**
     * suplerCeartInfoBySassI (상세정보(견적)요청서 SaaS I)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaasIVO> suplerCeartInfoBySassI(SuplerCeartSaasIVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoBySassI", vo);
    }

    /**
     * suplerCeartInfoBySass2I (상세정보(견적)요청서 SaaS2 I)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaas2IVO> suplerCeartInfoBySass2I(SuplerCeartSaas2IVO vo) {
        List<SuplerCeartSaas2IVO> lstSaasVo = list("_suplerCeart.selectSuplerCeartInfoBySass2I", vo);

        List<String> termLst = null ;
        
        int len = lstSaasVo.size();        
        for(int i = 0 ; i < len ; i++) 
        {
            SuplerCeartSaas2IVO saasVo = lstSaasVo.get(i);

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
     * suplerCeartInfoBySassD (상세정보(견적)요청서 SaaS D)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaasDVO> suplerCeartInfoBySassD(SuplerCeartSaasDVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoBySassD", vo);
    }

    /**
     * suplerCeartInfoBySass2Dn (상세정보(견적)요청서 SaaS2 Dn)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaas2DnVO> suplerCeartInfoBySass2Dn(SuplerCeartSaas2DnVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoBySass2Dn", vo);
    }

    /**
     * suplerCeartInfoBySass2Do (상세정보(견적)요청서 SaaS2 Do)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaas2DoVO> suplerCeartInfoBySass2Do(SuplerCeartSaas2DoVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoBySass2Do", vo);
    }

    /**
     * suplerCeartInfoByIassI (IaaS 마스터 정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaasIVO> suplerCeartInfoByIassI(SuplerCeartIaasIVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByIassI", vo);
    }

    /**
     * suplerCeartInfoByIass2I (IaaS2 마스터 정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaas2IVO> suplerCeartInfoByIass2I(SuplerCeartIaas2IVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByIass2I", vo);
    }

    /**
     * suplerCeartInfoByIassDs (IaaS 서버문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaasDsVO> suplerCeartInfoByIassDs(SuplerCeartIaasDsVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByIassDs", vo);
    }

    /**
     * suplerCeartInfoByIass2Ds (IaaS 서버문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaas2DsVO> suplerCeartInfoByIass2Ds(SuplerCeartIaas2DsVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByIass2Ds", vo);
    }

    /**
     * suplerCeartInfoByIassDd (IaaS DB문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaasDdVO> suplerCeartInfoByIassDd(SuplerCeartIaasDdVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByIassDd", vo);
    }

    /**
     * suplerCeartInfoByIass2Dd (IaaS2 DB문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaas2DdVO> suplerCeartInfoByIass2Dd(SuplerCeartIaas2DdVO vo) {
        return list("_suplerCeart.selectSuplerCeartInfoByIass2Dd", vo);
    }

    /**
     * suplerReturnRequestAction (견적요청 반려처리)
     * 
     * @param SuplerCeartVO
     * @return int
     */
    public int suplerReturnRequestAction(SuplerCeartVO vo) {

        return update("_suplerCeart.suplerReturnRequest", vo);
    }

    /**
     * updateNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * 
     * @param SuplerCeartVO
     * @return int
     */
    public int updateNotifySplyAction(SuplerCeartNotifySplyVO vo) {
        // 첨부파일
        if(vo.getSplyFileList() != null && vo.getSplyFileList().size() > 0) {
            if(vo.getSplyFile() == 0) {
                vo.setSplyFile(fileDao.saveFile(vo.getSplyFileList(), vo.getSplyFile()));
            }
        }

        return update("_suplerCeart.updateNotifySply", vo);
    }

    /**
     * insertPaasAnswerAction (입찰공고 PaaS 답변 등록)
     * 
     * @param SuplerCeartPaasVO
     * @return int
     */
    public int insertPaasAnswerAction(SuplerCeartPaasVO vo) {

        return insert("_suplerCeart.insertPaasAnswer", vo);
    }

    /**
     * updatePaasAnswerAction (입찰공고 PaaS 답변 수정)
     * 
     * @param SuplerCeartPaasVO
     * @return int
     */
    public int updatePaasAnswerAction(SuplerCeartPaasVO vo) {

        return update("_suplerCeart.updatePaasAnswer", vo);
    }

    /**
     * insertSaasIAnswerAction (입찰공고 SaaS 마스터 답변 등록)
     * 
     * @param SuplerCeartSaasIVO
     * @return int
     */
    public int insertSaasIAnswerAction(SuplerCeartSaasIVO vo) {

        return insert("_suplerCeart.insertSaasIAnswer", vo);
    }

    /**
     * updateSaasIAnswerAction (입찰공고 SaaS 마스터 답변 수정)
     * 
     * @param SuplerCeartSaasIVO
     * @return int
     */
    public int updateSaasIAnswerAction(SuplerCeartSaasIVO vo) {

        return update("_suplerCeart.updateSaasIAnswer", vo);
    }

    /**
     * insertSaasDAnswerAction (입찰공고 SaaS 상세 답변 등록)
     * 
     * @param SuplerCeartSaasDVO
     * @return int
     */
    public int insertSaasDAnswerAction(SuplerCeartSaasDVO vo) {

        return insert("_suplerCeart.insertSaasDAnswer", vo);
    }

    /**
     * deleteSaasDAnswerAction (입찰공고 SaaS 상세 답변 삭제)
     * 
     * @param SuplerCeartSaasIVO
     * @return int
     */
    public int deleteSaasDAnswerAction(SuplerCeartSaasIVO vo) {

        return delete("_suplerCeart.deleteSaasDAnswer", vo);
    }

    /**
     * insertIaasIAnswerAction (입찰공고 IaaS 마스터 답변 등록)
     * 
     * @param SuplerCeartIaasIVO
     * @return int
     */
    public int insertIaasIAnswerAction(SuplerCeartIaasIVO vo) {

        return insert("_suplerCeart.insertIaasIAnswer", vo);
    }

    /**
     * updateIaasIAnswerAction (입찰공고 IaaS 마스터 답변 수정)
     * 
     * @param SuplerCeartIaasIVO
     * @return int
     */
    public int updateIaasIAnswerAction(SuplerCeartIaasIVO vo) {

        return insert("_suplerCeart.updateIaasIAnswer", vo);
    }

    /**
     * insertIaasDsAnswerAction (입찰공고 IaaS 서버 답변 등록)
     * 
     * @param SuplerCeartIaasDsVO
     * @return int
     */
    public int insertIaasDsAnswerAction(SuplerCeartIaasDsVO vo) {

        return insert("_suplerCeart.insertIaasDsAnswer", vo);
    }

    /**
     * deleteIaasDsAnswerAction (입찰공고 IaaS 서버 답변 삭제)
     * 
     * @param SuplerCeartIaasIVO
     * @return int
     */
    public int deleteIaasDsAnswerAction(SuplerCeartIaasIVO vo) {

        return delete("_suplerCeart.deleteIaasDsAnswer", vo);
    }

    /**
     * insertIaasDdAnswerAction (입찰공고 IaaS DB 답변 등록)
     * 
     * @param SuplerCeartIaasDdVO
     * @return int
     */
    public int insertIaasDdAnswerAction(SuplerCeartIaasDdVO vo) {

        return insert("_suplerCeart.insertIaasDdAnswer", vo);
    }

    /**
     * deleteIaasDdAnswerAction (입찰공고 IaaS DB 답변 삭제)
     * 
     * @param SuplerCeartIaasDdVO
     * @return int
     */
    public int deleteIaasDdAnswerAction(SuplerCeartIaasIVO vo) {

        return delete("_suplerCeart.deleteIaasDdAnswer", vo);
    }

    /**
     * contractCompleteInfo (공급자 계약관리정보 조회)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCntrctVO> contractCompleteInfo(SuplerCntrctVO vo) {
        return list("_suplerCeart.contractCompleteInfo", vo);
    }

    /**
     * insertCntrctCmplAction (계약관리정보 등록-계약체결 완료)
     * 
     * @param SuplerCntrctVO
     * @return int
     */
    public int insertCntrctCmplAction(SuplerCntrctVO vo) {
        // STEP1) 공급자 확인정보의 계약체결 요청정보 UPDATE
        update("_suplerCeart.updateCntrctCmpl", vo);

        // 첨부파일
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            if(vo.getCtrtcSn() == 0) {
                vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(), vo.getCtrtcSn()));
            }
        }
        // STEP2) 계약관리정보 데이터 INSERT
        return insert("_suplerCeart.insertCntrctCmpl", vo);
    }

    /**
     * updateCntrctCmplAction (계약관리정보 등록-계약수정)
     * 
     * @param SuplerCntrctVO
     * @return int
     */
    public int updateCntrctCmplAction(SuplerCntrctVO vo) {
        // STEP1) 공급자 확인정보의 계약체결 요청정보 UPDATE
        update("_suplerCeart.updateCntrctCmpl", vo);

        // 첨부파일
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            if(vo.getCtrtcSn() == 0) {
                vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(), vo.getCtrtcSn()));
            }
        }

        // STEP2) 계약관리정보 데이터 UPDATE
        return update("_suplerCeart.updateCntrctCmplChange", vo);
    }

    /**
     * bidPartcptnListCount (입찰참여 현황 목록 갯수)
     * 
     * @param Map
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int bidPartcptnListCount(Map parameterMap) {

        return (Integer) selectByPk("_suplerCeart.bidPartcptnListCount", parameterMap);
    }

    /**
     * bidPartcptnList (입찰참여 현황 목록)
     * 
     * @param Map
     * @return List
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartBidPartcptnVO> bidPartcptnList(Map parameterMap) {
        return list("_suplerCeart.bidPartcptnList", parameterMap);
    }

    /**
     * 공급현황 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int suplySttusListCount(Map parameterMap) {

        return (Integer) selectByPk("_suplerCeart.suplySttusListCount", parameterMap);
    }

    /**
     * suplySttusList (공급현황 목록)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartSuplySttusVO> suplySttusList(Map parameterMap) {
        return list("_suplerCeart.suplySttusList", parameterMap);
    }

    /**
     * suplySttusListExcel (공급현황 목록(엑셀다운용))
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartSuplySttusVO> suplySttusListExcel(Map parameterMap) {
        return list("_suplerCeart.suplySttusListExcel", parameterMap);
    }

    /**
     * suplySttusEndsUserInfo (공급 수요자 정보 조회)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplySttusEndsUserVO> suplySttusEndsUserInfo(SuplySttusEndsUserVO vo) {
        return list("_suplerCeart.suplySttusEndsUserInfo", vo);
    }

    /**
     * suplySttusHistList (공급자의 수요자에 대한 공급이력)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCntrctVO> suplySttusHistList(SuplerCntrctVO vo) {
        return list("_suplerCeart.suplySttusHistList", vo);
    }

    /**
     * totSuplySttusHistList (공급자의 서비스에 대한 총 공급이력)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCntrctVO> totSuplySttusHistList(SuplerCntrctVO vo) {
        return list("_suplerCeart.totSuplySttusHistList", vo);
    }

    /**
     * 상세정보(사전견적)요청서 목록 갯수
     * beforeRequestListCount
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int beforeRequestListCount(Map parameterMap) {

        return (Integer) selectByPk("_suplerCeart.beforeRequestListCount", parameterMap);
    }

    /**
     * beforeRequestList (상세정보(사전견적)요청서 목록)
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartVO> beforeRequestList(Map parameterMap) {
        return list("_suplerCeart.beforeRequestList", parameterMap);
    }

    /**
     * beforeRequestListExcel (상세정보(사전견적)요청서 목록(엑셀다운용))
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCeartVO> beforeRequestListExcel(Map parameterMap) {
        return list("_suplerCeart.beforeRequestListExcel", parameterMap);
    }

    /**
     * updateBeforeSplyConfmGbn (사전견적공고 공급자 확인정보의 확인여부 update)
     * 
     * @param SuplerCeartBidNotifyVO
     * @return int
     */
    public int updateBeforeSplyConfmGbn(SuplerCeartBidNotifyVO vo) {

        return update("_suplerCeart.updateBeforeSplyConfmGbn", vo);
    }

    /**
     * suplerCeartBidNotifyInfo (사 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartBidNotifyVO> suplerCeartBeforeNotifyInfo(SuplerCeartBidNotifyVO vo) {
        return list("_suplerCeart.suplerCeartBeforeNotifyInfo", vo);
    }

    /**
     * suplerCeartNotifySplyInfo (입찰공고 공급자 확인정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartNotifySplyVO> suplerCeartBeforeNotifySplyInfo(SuplerCeartNotifySplyVO vo) {
        return list("_suplerCeart.selectSuplerCeartBeforeNotifySplyInfo", vo);
    }

    /**
     * suplerCeartInfoByPass (상세정보(견적)요청서 PaaS)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartPaasVO> suplerCeartBeforeInfoByPass(SuplerCeartPaasVO vo) {
        return list("_suplerCeart.selectSuplerCeartBeforeInfoByPass", vo);
    }

    /**
     * suplerCeartInfoByPass2 (상세정보(견적)요청서 PaaS2)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartPaas2VO> suplerCeartBeforeInfoByPass2(SuplerCeartPaas2VO vo) {

        List<SuplerCeartPaas2VO> lstPaasVo = list("_suplerCeart.selectSuplerCeartBeforeInfoByPass2", vo);

        List<String> termLst = null;
        
        int len = lstPaasVo.size();
        for(int i = 0 ; i < len ; i++) 
        {
            SuplerCeartPaas2VO paasVo = lstPaasVo.get(i);

            // 서비스 제공방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2064, paasVo.getHostingMethod());
            lstPaasVo.get(i).setHostingMethodNm(getCommanString(termLst));

            // 서비스 제공방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
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
     * suplerCeartInfoBySassI (상세정보(견적)요청서 SaaS I)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaasIVO> suplerCeartBeforeInfoBySassI(SuplerCeartSaasIVO vo) {
        return list("_suplerCeart.selectSuplerCeartBeforeInfoBySassI", vo);
    }

    /**
     * suplerCeartInfoBySass2I (상세정보(견적)요청서 SaaS2 I)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaas2IVO> suplerCeartBeforeInfoBySass2I(SuplerCeartSaas2IVO vo) {
        List<SuplerCeartSaas2IVO> lstSaasVo = list("_suplerCeart.selectSuplerCeartBeforeInfoBySass2I", vo);
        
        List<String> termLst = null;

        int len = lstSaasVo.size();
        for(int i = 0 ; i < len ; i++) 
        {
            SuplerCeartSaas2IVO saasVo = lstSaasVo.get(i);

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
     * suplerCeartInfoBySassD (상세정보(견적)요청서 SaaS D)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaasDVO> suplerCeartBeforeInfoBySassD(SuplerCeartSaasDVO vo) {
        return list("_suplerCeart.selectSuplerCeartBeforeInfoBySassD", vo);
    }

    /**
     * suplerCeartInfoBySass2Dn (상세정보(견적)요청서 SaaS2 Dn)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaas2DnVO> suplerCeartBeforeInfoBySass2Dn(SuplerCeartSaas2DnVO vo) {
        return list("_suplerCeart.selectSuplerCeartBeforeInfoBySass2Dn", vo);
    }

    /**
     * suplerCeartInfoBySass2D (상세정보(견적)요청서 SaaS2 D)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartSaas2DoVO> suplerCeartBeforeInfoBySass2Do(SuplerCeartSaas2DoVO vo) {
        return list("_suplerCeart.selectSuplerCeartBeforeInfoBySass2Do", vo);
    }

    /**
     * suplerCeartInfoByIassI (IaaS 마스터 정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaasIVO> suplerCeartBeforeInfoByIassI(SuplerCeartIaasIVO vo) {
        return list("_suplerCeart.suplerCeartBeforeInfoByIassI", vo);
    }

    /**
     * suplerCeartInfoByIass2I (Iaa2S 마스터 정보 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaas2IVO> suplerCeartBeforeInfoByIass2I(SuplerCeartIaas2IVO vo) {

        List<SuplerCeartIaas2IVO> lstIaasVo = list("_suplerCeart.suplerCeartBeforeInfoByIass2I", vo);

        int len = lstIaasVo.size();
        for(int i = 0 ; i < len ; i++) {
            SuplerCeartIaas2IVO iaasVo = lstIaasVo.get(i);

            // 웹방화벽 - 상품유형 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            List<String> termLst = getCodeNames(2074, iaasVo.getWebGoodsKind());
            lstIaasVo.get(i).setWebGoodsKindNm(getCommanString(termLst));
        }

        return lstIaasVo;
    }

    /**
     * suplerCeartInfoByIassDs (IaaS 서버문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaasDsVO> suplerCeartBeforeInfoByIassDs(SuplerCeartIaasDsVO vo) {
        return list("_suplerCeart.suplerCeartBeforeInfoByIassDs", vo);
    }

    /**
     * suplerCeartInfoByIass2Ds (Iaa2S 서버문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaas2DsVO> suplerCeartBeforeInfoByIass2Ds(SuplerCeartIaas2DsVO vo) {
        return list("_suplerCeart.suplerCeartBeforeInfoByIass2Ds", vo);
    }

    /**
     * suplerCeartInfoByIassDd (IaaS DB문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaasDdVO> suplerCeartBeforeInfoByIassDd(SuplerCeartIaasDdVO vo) {
        return list("_suplerCeart.suplerCeartBeforeInfoByIassDd", vo);
    }

    /**
     * suplerCeartInfoByIass2Dd (Iaa2S DB문의 조회)
     * 
     * @param vo
     * @return
     */
    public List<SuplerCeartIaas2DdVO> suplerCeartBeforeInfoByIass2Dd(SuplerCeartIaas2DdVO vo) {
        return list("_suplerCeart.suplerCeartBeforeInfoByIass2Dd", vo);
    }
    
    /**
     * suplerCeartBeforeInfoByScs2 설명
     * @param vo
     * @return
     */
    public List<SuplerCeartScs2VO> suplerCeartBeforeInfoByScs2(SuplerCeartScs2VO vo) {
        List<SuplerCeartScs2VO> lstScsVo = list("_suplerCeart.suplerCeartBeforeInfoByScs2", vo);
        
        List<String> termLst = null ;
        
        int len = lstScsVo.size();
        for(int i = 0 ; i < len ; i++) {
            SuplerCeartScs2VO scsVo = lstScsVo.get(i);

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
     * updateBeforeNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * 
     * @param SuplerCeartVO
     * @return int
     */
    public int updateBeforeNotifySplyAction(SuplerCeartNotifySplyVO vo) {
        // 첨부파일
        if(vo.getSplyFileList() != null && vo.getSplyFileList().size() > 0) {
            if(vo.getSplyFile() == 0) {
                vo.setSplyFile(fileDao.saveFile(vo.getSplyFileList(), vo.getSplyFile()));
            }
        }

        return update("_suplerCeart.updateBeforeNotifySply", vo);
    }

    /**
     * insertPaasAnswerAction (입찰공고 PaaS 답변 등록)
     * 
     * @param SuplerCeartPaasVO
     * @return int
     */
    public int insertBeforePaasAnswerAction(SuplerCeartPaasVO vo) {

        return insert("_suplerCeart.insertBeforePaasAnswer", vo);
    }

    /**
     * insertPaas2AnswerAction (입찰공고 PaaS2 답변 등록)
     * 
     * @param SuplerCeartPaas2VO
     * @return int
     */
    public int insertBeforePaas2AnswerAction(SuplerCeartPaas2VO vo) {

        return insert("_suplerCeart.insertBeforePaas2Answer", vo);
    }

    /**
     * updatePaasAnswerAction (입찰공고 PaaS 답변 수정)
     * 
     * @param SuplerCeartPaasVO
     * @return int
     */
    public int updateBeforePaasAnswerAction(SuplerCeartPaasVO vo) {

        return update("_suplerCeart.updateBeforePaasAnswer", vo);
    }

    /**
     * insertSaasIAnswerAction (입찰공고 SaaS 마스터 답변 등록)
     * 
     * @param SuplerCeartSaasIVO
     * @return int
     */
    public int insertBeforeSaasIAnswerAction(SuplerCeartSaasIVO vo) {

        return insert("_suplerCeart.insertBeforeSaasIAnswer", vo);
    }

    /**
     * insertSaas2IAnswerAction (입찰공고 SaaS2 마스터 답변 등록)
     * 
     * @param SuplerCeartSaas2IVO
     * @return int
     */
    public int insertBeforeSaas2IAnswerAction(SuplerCeartSaas2IVO vo) {

        return insert("_suplerCeart.insertBeforeSaas2IAnswer", vo);
    }

    /**
     * updateSaasIAnswerAction (입찰공고 SaaS 마스터 답변 수정)
     * 
     * @param SuplerCeartSaasIVO
     * @return int
     */
    public int updateBeforeSaasIAnswerAction(SuplerCeartSaasIVO vo) {

        return update("_suplerCeart.updateBeforeSaasIAnswer", vo);
    }

    /**
     * insertSaasDAnswerAction (입찰공고 SaaS 상세 답변 등록)
     * 
     * @param SuplerCeartSaasDVO
     * @return int
     */
    public int insertBeforeSaasDAnswerAction(SuplerCeartSaasDVO vo) {

        return insert("_suplerCeart.insertBeforeSaasDAnswer", vo);
    }

    /**
     * insertSaas2NeedAnswerAction (입찰공고 SaaS2 상세필요 답변 등록)
     * 
     * @param SuplerCeartSaas2DnVO
     * @return int
     */
    public int insertBeforeSaas2NeedAnswerAction(int i, SuplerCeartSaas2DnVO vo) 
    {
        if  (i==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_suplerCeart.updateBeforeSaas2NeedAnswer", vo);
        }
        return insert("_suplerCeart.insertBeforeSaas2NeedAnswer", vo);
    }

    /**
     * selectBeforeSaas2NeedSeq (입찰공고 SaaS2 상세필요 Seq)
     * 
     * @param SuplerCeartSaas2DnVO
     * @return int
     */
    public int selectBeforeSaas2NeedSeq(SuplerCeartSaas2DnVO vo) {

        return (Integer) selectByPk("_suplerCeart.selectBeforeSaas2NeedSeq", vo);
    }

    /**
     * insertSaas2OptionAnswerAction (입찰공고 SaaS2 상세옵션 답변 등록)
     * 
     * @param SuplerCeartSaas2DoVO
     * @return int
     */
    public int insertBeforeSaas2OptionAnswerAction(int i, int j, SuplerCeartSaas2DoVO vo) 
    {
        if  (i==0 && j==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_suplerCeart.updatetBeforeSaas2OptionAnswer", vo);
        }
        return insert("_suplerCeart.insertBeforeSaas2OptionAnswer", vo);
    }

    /**
     * deleteSaasDAnswerAction (입찰공고 SaaS 상세 답변 삭제)
     * 
     * @param SuplerCeartSaasIVO
     * @return int
     */
    public int deleteBeforeSaasDAnswerAction(SuplerCeartSaasIVO vo) {

        return delete("_suplerCeart.deleteBeforeSaasDAnswer", vo);
    }

    /**
     * insertIaasIAnswerAction (입찰공고 IaaS 마스터 답변 등록)
     * 
     * @param SuplerCeartIaasIVO
     * @return int
     */
    public int insertBeforeIaasIAnswerAction(SuplerCeartIaasIVO vo) {

        return insert("_suplerCeart.insertBeforeIaasIAnswer", vo);
    }

    /**
     * insertIaas2IAnswerAction (입찰공고 IaaS2 마스터 답변 등록)
     * 
     * @param SuplerCeartIaas2IVO
     * @return int
     */
    public int insertBeforeIaas2IAnswerAction(SuplerCeartIaas2IVO vo) {

        return insert("_suplerCeart.insertBeforeIaas2IAnswer", vo);
    }

    /**
     * updateIaasIAnswerAction (입찰공고 IaaS 마스터 답변 수정)
     * 
     * @param SuplerCeartIaasIVO
     * @return int
     */
    public int updateBeforeIaasIAnswerAction(SuplerCeartIaasIVO vo) {

        return insert("_suplerCeart.updateBeforeIaasIAnswer", vo);
    }

    /**
     * insertIaasDsAnswerAction (입찰공고 IaaS 서버 답변 등록)
     * 
     * @param SuplerCeartIaasDsVO
     * @return int
     */
    public int insertBeforeIaasDsAnswerAction(SuplerCeartIaasDsVO vo) {

        return insert("_suplerCeart.insertBeforeIaasDsAnswer", vo);
    }

    /**
     * insertIaas2DsAnswerAction (입찰공고 IaaS 서버 답변 등록)
     * 
     * @param SuplerCeartIaas2DsVO
     * @return int
     */
    public int insertBeforeIaas2DsAnswerAction(int i, SuplerCeartIaas2DsVO vo) 
    {
        if  (i==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_suplerCeart.updateBeforeIaas2DsAnswer", vo);
        }
        return insert("_suplerCeart.insertBeforeIaas2DsAnswer", vo);
    }

    /**
     * deleteIaasDsAnswerAction (입찰공고 IaaS 서버 답변 삭제)
     * 
     * @param SuplerCeartIaasIVO
     * @return int
     */
    public int deleteBeforeIaasDsAnswerAction(SuplerCeartIaasIVO vo) {

        return delete("_suplerCeart.deleteBeforeIaasDsAnswer", vo);
    }

    /**
     * insertIaasDdAnswerAction (입찰공고 IaaS DB 답변 등록)
     * 
     * @param SuplerCeartIaasDdVO
     * @return int
     */
    public int insertBeforeIaasDdAnswerAction(SuplerCeartIaasDdVO vo) {

        return insert("_suplerCeart.insertBeforeIaasDdAnswer", vo);
    }

    /**
     * insertIaas2DdAnswerAction (입찰공고 IaaS2 DB 답변 등록)
     * 
     * @param SuplerCeartIaas2DdVO
     * @return int
     */
    public int insertBeforeIaas2DdAnswerAction(int i, SuplerCeartIaas2DdVO vo) 
    {
        if  (i==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_suplerCeart.updateBeforeIaas2DdAnswer", vo);
        }

        return insert("_suplerCeart.insertBeforeIaas2DdAnswer", vo);
    }

    /**
     * insertBeforeScs2AnswerAction 설명
     * @param vo
     * @return
     */
    public int insertBeforeScs2AnswerAction(SuplerCeartScs2VO vo) {
        return insert("_suplerCeart.insertBeforeScs2Answer", vo);
    }

    /**
     * deleteIaasDdAnswerAction (입찰공고 IaaS DB 답변 삭제)
     * 
     * @param SuplerCeartIaasDdVO
     * @return int
     */
    public int deleteBeforeIaasDdAnswerAction(SuplerCeartIaasIVO vo) {

        return delete("_suplerCeart.deleteBeforeIaasDdAnswer", vo);
    }

    /**
     * wholeServiceListCount (구매자선택 팝업 갯수)
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int buyUserListCount(Map parameterMap) {
        return (Integer) selectByPk("_suplerCeart.buyUserListCount", parameterMap);
    }

    /**
     * buyUserList (구매자선택 팝업)
     * 
     * @param Map
     * @return
     */
    public List<SuplerServiceVO> buyUserList(Map parameterMap) {
        return list("_suplerCeart.buyUserList", parameterMap);
    }

    /**
     * buyUserList (구매자 정보 가져오기)
     * 
     * @param Map
     * @return
     */
    public SuplerServiceVO buyUserInfo(Map parameterMap) {
        return (SuplerServiceVO) selectByPk("_suplerCeart.buyUserInfo", parameterMap);
    }

    /**
     * cntrctDtlInfo (계약서 등록 데이터 조회)
     * 
     * @param SuplerCntrctVO
     * @return
     */
    public List<SuplerCntrctVO> cntrctDtlInfo(SuplerCntrctVO vo) {
        return list("_suplerCeart.cntrctDtlInfo", vo);
    }

    public SuplerCntrctVO cntrctDetail(SuplerCntrctVO vo) {
        SuplerCntrctVO cvo = (SuplerCntrctVO) selectByPk("_suplerCeart.cntrctDetail", vo);
        cvo.setCtrtcSnList(fileDao.getFiles(cvo.getCtrtcSn()));
        return cvo;
    }

    /**
     * insertCntrctCmpl (계약결과 등록)
     * 
     * @param SuplerCntrctVO
     * @return int
     */
    public int insertCntrctCmpl(SuplerCntrctVO vo) {

        /*****************************************************
         * 2017-12-07
         * 비회원 사용안함, 파일 첨부 멀티로 변경하면서 로찍 빠짐
         * {{{{{{{
         */
        /* 게약 등록시 구매담담다아자 수기 등록 */
        /*
         * if(vo.getCommUserId().equals("")){
         * int userSn = insert("_suplerCeart.insertSuplerTempUser", vo);
         * }
         */
        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        /*
         * if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
         * if(vo.getCtrtcSn() == 0){
         * vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(),
         * vo.getCtrtcSn()));
         * }
         * }
         */
        /* }}}}}}}} */
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            if(vo.getCtrtcSn() <= 0) {
                vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList()));
            }
        }
        int result = insert("_suplerCeart.insertSuplerCntrctCmpl", vo);
        if(vo.getSbscrbTyCd().equals(2002))
            vo.setBuseoCode("ZZZZZZZ");
        vo.setBuseoNm(vo.getPurchsInsttNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);

        SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
        gvo.setCntrctSn(vo.getCntrctSn());
        if(vo.getGoodsCodes() != null)
            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                if(!vo.getGoodsCodes()[i].equals("")) {
                    gvo.setGoodsCode(vo.getGoodsCodes()[i]);
                    gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
                    /* gvo.setCntrctCount(vo.getCntrctCounts()[i]); */
                    gvo.setSplyForm(vo.getSplyForms()[i]);
                    gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
                    insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
                }
            }
        return result;
    }

    /**
     * updateCntrctCmpl (계약결과 수정)
     * 
     * @param SuplerCntrctVO
     * @return int
     */
    public int updateCntrctCmpl(SuplerCntrctVO vo) {

        // 비회원구매자일경우 엡데이트
        /*
         * if(vo.getUserSn() > 0 )
         * update("_suplerCeart.updateSuplerTempUser", vo);
         * 게약 등록시 구매담담아이디가 없을시 비회원으로 등록
         * if(vo.getCommUserId().equals("") && vo.getUserSn() == 0 ){
         * int userSn = insert("_suplerCeart.insertSuplerTempUser", vo);
         * }
         */

        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(), vo.getCtrtcSn()));
        }
        int result = 0;

        if(vo.getRlCntrctInsttAt() == null) {
            delete("_suplerCeart.deleteRLuserInitInfo", vo);
        }

        // 계약정보 등록 혹은 수정{{{
        if(vo.getSbscrbTyCd().equals(2002))
            vo.setBuseoCode("ZZZZZZZ");
        vo.setBuseoNm(vo.getPurchsInsttNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);
        // }}}

        // 등록된 체결서비스중 삭제, 등록 , 수정 {{{{{
        if(vo.getCntrctSvcSns() != null && vo.getCntrctSvcSns().length > 0)
            result = delete("_suplerCeart.cntrctGoodsNotDelete", vo);

        if(vo.getGoodsCodes() != null && vo.getGoodsCodes().length > 0) {
            SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
            gvo.setCntrctSn(vo.getCntrctSn());
            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                gvo.setGoodsCode(vo.getGoodsCodes()[i]);
                gvo.setCntrctSvcSn(vo.getCntrctSvcSns()[i]);
                gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
                /* gvo.setCntrctCount(vo.getCntrctCounts()[i]); */
                gvo.setSplyForm(vo.getSplyForms()[i]);
                gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
                result = insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
            }
        }
        // }}}

        // 실이용자 민간기업으로 선택시
        if(vo.getUserSe() != null && vo.getUserSe().equals("2")) {
            // 공공기관 있을시 삭제
            vo.setBuseoCode("");
            delete("_suplerCeart.deleteRLuserInfo", vo);

            // 실제이용정보 민간기업시 등록
            vo.setBuseoCode("ZZZZZZZ");
            vo.setBuseoNm(vo.getRealCmpny());
            vo.setRlCntrctInsttAt("Y");
            insert("_suplerCeart.mergeRLuserInfo", vo);
        } else if(vo.getUserSe() != null && vo.getUserSe().equals("3")) {
            vo.setBuseoCode("ZZZZZZZ");
            delete("_suplerCeart.deleteRLuserInfo", vo);
        }
        return update("_suplerCeart.updateSuplerCntrctCmpl", vo);
    }

    public List<SuplerCntrctGoodsVO> cntrctDtlGoodsList(SuplerCntrctVO vo) {
        return list("_suplerCeart.cntrctGoodsList", vo);
    }
   

}
