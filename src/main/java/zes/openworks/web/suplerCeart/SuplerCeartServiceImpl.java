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

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.core.bind.VoBinder;
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
 * 2017. 12. 12.    SKYOU  수정    공급현황>계약수기등록 
 *</pre>
 * @see
 */
@Service("SuplerCeartService")
public class SuplerCeartServiceImpl extends AbstractServiceImpl implements SuplerCeartService {

    @Resource SuplerCeartDAO dao;

    /**
     * (상세정보(견적)요청서 목록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#buyingRequestList(zes.openworks.web.suplerCeart.MyCeartVO)
     */
    @Override
    public Pager<SuplerCeartVO> buyingRequestList(SuplerCeartVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartVO> dataList = null;

        dataList = dao.buyingRequestList(parameterMap);
        vo.setTotalNum(dao.buyingRequestListCount(parameterMap));

        return new Pager<SuplerCeartVO>(dataList, vo);
    }

    /**
     * (상세정보(견적)요청서 목록(엑셀 다운용))
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#buyingRequestListExcel(zes.openworks.web.suplerCeart.SuplerCeartVO)
     */
    @Override
    public Pager<SuplerCeartVO> buyingRequestListExcel(SuplerCeartVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartVO> dataList = null;
        
        dataList = dao.buyingRequestListExcel(parameterMap);
        vo.setTotalNum(dao.buyingRequestListCount(parameterMap));

        return new Pager<SuplerCeartVO>(dataList, vo);
    }
    
    /* (입찰공고 공급자 확인정보의 확인여부 update)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##updateSplyConfmGbn(zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO)
     */
    @Override
    public int updateSplyConfmGbn(SuplerCeartBidNotifyVO vo){
        return dao.updateSplyConfmGbn(vo);
    }

    /* (입찰공고정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartBidNotifyInfo(zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO)
     */
    @Override
    public List<SuplerCeartBidNotifyVO> suplerCeartBidNotifyInfo(SuplerCeartBidNotifyVO vo) {

        return dao.suplerCeartBidNotifyInfo(vo);
    }
    
    /* (입찰공고 공급자 확인정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartNotifySplyInfo(zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO)
     */
    @Override
    public List<SuplerCeartNotifySplyVO> suplerCeartNotifySplyInfo(SuplerCeartNotifySplyVO vo) {

        return dao.suplerCeartNotifySplyInfo(vo);
    }

    /* (상세정보(견적)요청서 PaaS)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByPass(zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO)
     */
    @Override
    public List<SuplerCeartPaasVO> suplerCeartInfoByPass(SuplerCeartPaasVO vo) {

        return dao.suplerCeartInfoByPass(vo);
    }

    /* (상세정보(견적)요청서 PaaS2)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByPass2(zes.openworks.web.suplerCeart.vo.SuplerCeartPaas2VO)
     */
    @Override
    public List<SuplerCeartPaas2VO> suplerCeartInfoByPass2(SuplerCeartPaas2VO vo) {

        return dao.suplerCeartInfoByPass2(vo);
    }

    /* (상세정보(견적)요청서 SaaS I)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoBySassI(zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO)
     */
    @Override
    public List<SuplerCeartSaasIVO> suplerCeartInfoBySassI(SuplerCeartSaasIVO vo) {

        return dao.suplerCeartInfoBySassI(vo);
    }

    /* (상세정보(견적)요청서 SaaS2 I)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoBySass2I(zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2IVO)
     */
    @Override
    public List<SuplerCeartSaas2IVO> suplerCeartInfoBySass2I(SuplerCeartSaas2IVO vo) {

        return dao.suplerCeartInfoBySass2I(vo);
    }

    /* (상세정보(견적)요청서 SaaS D)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoBySassD(zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO)
     */
    @Override
    public List<SuplerCeartSaasDVO> suplerCeartInfoBySassD(SuplerCeartSaasDVO vo) {

        return dao.suplerCeartInfoBySassD(vo);
    }

    /* (상세정보(견적)요청서 SaaS2 Dn)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoBySass2Dn(zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2DnVO)
     */
    @Override
    public List<SuplerCeartSaas2DnVO> suplerCeartInfoBySass2Dn(SuplerCeartSaas2DnVO vo) {

        return dao.suplerCeartInfoBySass2Dn(vo);
    }

    /* (상세정보(견적)요청서 SaaS2 Do)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoBySass2Do(zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2DoVO)
     */
    @Override
    public List<SuplerCeartSaas2DoVO> suplerCeartInfoBySass2Do(SuplerCeartSaas2DoVO vo) {

        return dao.suplerCeartInfoBySass2Do(vo);
    }

    /* (IaaS 마스터 정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIassI(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO)
     */
    @Override
    public List<SuplerCeartIaasIVO> suplerCeartInfoByIassI(SuplerCeartIaasIVO vo) {

        return dao.suplerCeartInfoByIassI(vo);
    }

    /* (IaaS2 마스터 정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIass2I(zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2IVO)
     */
    @Override
    public List<SuplerCeartIaas2IVO> suplerCeartInfoByIass2I(SuplerCeartIaas2IVO vo) {

        return dao.suplerCeartInfoByIass2I(vo);
    }
    
    /* (IaaS 서버문의 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIassDs(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDsVO)
     */
    @Override
    public List<SuplerCeartIaasDsVO> suplerCeartInfoByIassDs(SuplerCeartIaasDsVO vo) {

        return dao.suplerCeartInfoByIassDs(vo);
    }
    
    /* (IaaS2 서버문의 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIass2Ds(zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2DsVO)
     */
    @Override
    public List<SuplerCeartIaas2DsVO> suplerCeartInfoByIass2Ds(SuplerCeartIaas2DsVO vo) {

        return dao.suplerCeartInfoByIass2Ds(vo);
    }
    
    /* (IaaS DB문의 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIassDd(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDdVO)
     */
    @Override
    public List<SuplerCeartIaasDdVO> suplerCeartInfoByIassDd(SuplerCeartIaasDdVO vo) {

        return dao.suplerCeartInfoByIassDd(vo);
    }
    
    /* (IaaS2 DB문의 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIass2Dd(zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2DdVO)
     */
    @Override
    public List<SuplerCeartIaas2DdVO> suplerCeartInfoByIass2Dd(SuplerCeartIaas2DdVO vo) {

        return dao.suplerCeartInfoByIass2Dd(vo);
    }

    /* (견적요청 반려처리)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##suplerReturnRequestAction(zes.openworks.web.suplerCeart.vo.SuplerCeartVO)
     */
    @Override
    public int suplerReturnRequestAction(SuplerCeartVO vo){
        return dao.suplerReturnRequestAction(vo);
    }

    /* (입찰공고 공급자 확인정보 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##updateNotifySplyAction(zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO)
     */
    @Override
    public int updateNotifySplyAction(SuplerCeartNotifySplyVO vo){
        return dao.updateNotifySplyAction(vo);
    }

    /* (입찰공고 PaaS 답변 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertPaasAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO)
     */
    @Override
    public int insertPaasAnswerAction(SuplerCeartPaasVO vo){
        return dao.insertPaasAnswerAction(vo);
    }

    /* (입찰공고 PaaS 답변 수정)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##updatePaasAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO)
     */
    @Override
    public int updatePaasAnswerAction(SuplerCeartPaasVO vo){
        return dao.updatePaasAnswerAction(vo);
    }

    /* (입찰공고 SaaS 마스터 답변 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertSaasIAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO)
     */
    @Override
    public int insertSaasIAnswerAction(SuplerCeartSaasIVO vo){
        return dao.insertSaasIAnswerAction(vo);
    }

    /* (입찰공고 SaaS 마스터 답변 수정)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##updateSaasIAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO)
     */
    @Override
    public int updateSaasIAnswerAction(SuplerCeartSaasIVO vo){
        return dao.updateSaasIAnswerAction(vo);
    }

    /* (입찰공고 SaaS 상세 답변 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertSaasDAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO)
     */
    @Override
    public int insertSaasDAnswerAction(SuplerCeartSaasDVO vo){
        return dao.insertSaasDAnswerAction(vo);
    }

    /* (입찰공고 SaaS 상세 답변 삭제)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##deleteSaasDAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO)
     */
    @Override
    public int deleteSaasDAnswerAction(SuplerCeartSaasIVO vo){
        return dao.deleteSaasDAnswerAction(vo);
    }

    /* (입찰공고 IaaS 마스터 답변 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertIaasIAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO)
     */
    @Override
    public int insertIaasIAnswerAction(SuplerCeartIaasIVO vo){
        return dao.insertIaasIAnswerAction(vo);
    }

    /* (입찰공고 IaaS 마스터 답변 수정)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##updateIaasIAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO)
     */
    @Override
    public int updateIaasIAnswerAction(SuplerCeartIaasIVO vo){
        return dao.updateIaasIAnswerAction(vo);
    }

    /* (입찰공고 IaaS 서버 답변 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertIaasDsAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDsVO)
     */
    @Override
    public int insertIaasDsAnswerAction(SuplerCeartIaasDsVO vo){
        return dao.insertIaasDsAnswerAction(vo);
    }

    /* (입찰공고 IaaS 서버 답변 삭제)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##deleteIaasDsAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO)
     */
    @Override
    public int deleteIaasDsAnswerAction(SuplerCeartIaasIVO vo){
        return dao.deleteIaasDsAnswerAction(vo);
    }

    /* (입찰공고 IaaS DB 답변 등록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertIaasDdAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDdVO)
     */
    @Override
    public int insertIaasDdAnswerAction(SuplerCeartIaasDdVO vo){
        return dao.insertIaasDdAnswerAction(vo);
    }

    /* (입찰공고 IaaS DB 답변 삭제)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##deleteIaasDdAnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO)
     */
    @Override
    public int deleteIaasDdAnswerAction(SuplerCeartIaasIVO vo){
        return dao.deleteIaasDdAnswerAction(vo);
    }

    /* (공급자 계약관리정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#contractCompleteInfo(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public List<SuplerCntrctVO> contractCompleteInfo(SuplerCntrctVO vo) {

        return dao.contractCompleteInfo(vo);
    }

    /* (계약관리정보 등록-계약체결 완료)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##insertCntrctCmplAction(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public int insertCntrctCmplAction(SuplerCntrctVO vo){
        return dao.insertCntrctCmplAction(vo);
    }

    /* (계약관리정보 등록-계약수정)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService##updateCntrctCmplAction(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public int updateCntrctCmplAction(SuplerCntrctVO vo){
        return dao.updateCntrctCmplAction(vo);
    }

    /**
     * (입찰참여 현황 목록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#bidPartcptnList(zes.openworks.web.suplerCeart.vo.SuplerCeartBidPartcptnVO)
     */
    @Override
    public Pager<SuplerCeartBidPartcptnVO> bidPartcptnList(SuplerCeartBidPartcptnVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartBidPartcptnVO> dataList = null;

        dataList = dao.bidPartcptnList(parameterMap);
        vo.setTotalNum(dao.bidPartcptnListCount(parameterMap));

        return new Pager<SuplerCeartBidPartcptnVO>(dataList, vo);
    }

    /**
     * (공급현황 목록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplySttusList(zes.openworks.web.suplerCeart.SuplerCeartSuplySttusVO)
     */
    @Override
    public Pager<SuplerCeartSuplySttusVO> suplySttusList(SuplerCeartSuplySttusVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartSuplySttusVO> dataList = null;

        dataList = dao.suplySttusList(parameterMap);
        vo.setTotalNum(dao.suplySttusListCount(parameterMap));

        return new Pager<SuplerCeartSuplySttusVO>(dataList, vo);
    }

    /**
     * (공급현황 목록(엑셀 다운용))
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplySttusListExcel(zes.openworks.web.suplerCeart.vo.SuplerCeartSuplySttusVO)
     */
    @Override
    public Pager<SuplerCeartSuplySttusVO> suplySttusListExcel(SuplerCeartSuplySttusVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartSuplySttusVO> dataList = null;
        
        dataList = dao.suplySttusListExcel(parameterMap);
        vo.setTotalNum(dao.suplySttusListCount(parameterMap));

        return new Pager<SuplerCeartSuplySttusVO>(dataList, vo);
    }

    /**
     * (공급 수요자 정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplySttusEndsUserInfo(zes.openworks.web.suplerCeart.vo.SuplySttusEndsUserVO)
     */
    @Override
    public List<SuplySttusEndsUserVO> suplySttusEndsUserInfo(SuplySttusEndsUserVO vo) {

        return dao.suplySttusEndsUserInfo(vo);
    }

    /**
     * (공급자의 수요자에 대한 공급이력)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplySttusHistList(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public List<SuplerCntrctVO> suplySttusHistList(SuplerCntrctVO vo) {

        return dao.suplySttusHistList(vo);
    }

    /**
     * (공급자의 서비스에 대한 총 공급이력)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#totSuplySttusHistList(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public Pager<SuplerCntrctVO> totSuplySttusHistList(SuplerCntrctVO vo) {
/*
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCntrctVO> dataList = null;
*/
        List<SuplerCntrctVO> dataList = dao.totSuplySttusHistList(vo);
        vo.setTotalNum(dataList.size());

        return new Pager<SuplerCntrctVO>(dataList, vo);
    }
    
    /**
     * (상세정보(견적)요청서 목록)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#beforeRequestList(zes.openworks.web.suplerCeart.SuplerCeartVO)
     */
    @Override
    public Pager<SuplerCeartVO> beforeRequestList(SuplerCeartVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartVO> dataList = null;

        dataList = dao.beforeRequestList(parameterMap);
        vo.setTotalNum(dao.beforeRequestListCount(parameterMap));

        return new Pager<SuplerCeartVO>(dataList, vo);
    }

    /**
     * (상세정보(견적)요청서 목록(엑셀 다운용))
     */
    @Override
    public Pager<SuplerCeartVO> beforeRequestListExcel(SuplerCeartVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerCeartVO> dataList = null;
        
        dataList = dao.beforeRequestListExcel(parameterMap);
        vo.setTotalNum(dao.beforeRequestListCount(parameterMap));

        return new Pager<SuplerCeartVO>(dataList, vo);
    }
  
    /* (사전견적공고 공급자 확인정보의 확인여부 update)
     */
    @Override
    public int updateBeforeSplyConfmGbn(SuplerCeartBidNotifyVO vo){
        return dao.updateBeforeSplyConfmGbn(vo);
    }
    
    /* (사전견적공고 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartBeforeNotifyInfo(zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO)
     */
    @Override
    public List<SuplerCeartBidNotifyVO> suplerCeartBeforeNotifyInfo(SuplerCeartBidNotifyVO vo) {
        return dao.suplerCeartBeforeNotifyInfo(vo);
    }
    
    /* (입찰공고 공급자 확인정보 조회)
     */
    @Override
    public List<SuplerCeartNotifySplyVO> suplerCeartBeforeNotifySplyInfo(SuplerCeartNotifySplyVO vo) {
        return dao.suplerCeartBeforeNotifySplyInfo(vo);
    }
    
    
    /* (상세정보(사전견적)요청서 PaaS)
     */
    @Override
    public List<SuplerCeartPaasVO> suplerCeartBeforeInfoByPass(SuplerCeartPaasVO vo) {

        return dao.suplerCeartBeforeInfoByPass(vo);
    }
    
    /* (상세정보(사전견적)요청서 PaaS2)
     */
    @Override
    public List<SuplerCeartPaas2VO> suplerCeartBeforeInfoByPass2(SuplerCeartPaas2VO vo) {

        return dao.suplerCeartBeforeInfoByPass2(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS I)
     */
    @Override
    public List<SuplerCeartSaasIVO> suplerCeartBeforeInfoBySassI(SuplerCeartSaasIVO vo) {

        return dao.suplerCeartBeforeInfoBySassI(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS2 I)
     */
    @Override
    public List<SuplerCeartSaas2IVO> suplerCeartBeforeInfoBySass2I(SuplerCeartSaas2IVO vo) {

        return dao.suplerCeartBeforeInfoBySass2I(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS D)
     */
    @Override
    public List<SuplerCeartSaasDVO> suplerCeartBeforeInfoBySassD(SuplerCeartSaasDVO vo) {

        return dao.suplerCeartBeforeInfoBySassD(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS2 D1)
     */
    @Override
    public List<SuplerCeartSaas2DnVO> suplerCeartBeforeInfoBySass2Dn(SuplerCeartSaas2DnVO vo) {

        return dao.suplerCeartBeforeInfoBySass2Dn(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS2 D2)
     */
    @Override
    public List<SuplerCeartSaas2DoVO> suplerCeartBeforeInfoBySass2Do(SuplerCeartSaas2DoVO vo) {

        return dao.suplerCeartBeforeInfoBySass2Do(vo);
    }

    /* (IaaS 마스터 정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIassI(zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO)
     */
    @Override
    public List<SuplerCeartIaasIVO> suplerCeartBeforeInfoByIassI(SuplerCeartIaasIVO vo) {

        return dao.suplerCeartBeforeInfoByIassI(vo);
    }

    /* (Iaa2S 마스터 정보 조회)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#suplerCeartInfoByIass2I(zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2IVO)
     */
    @Override
    public List<SuplerCeartIaas2IVO> suplerCeartBeforeInfoByIass2I(SuplerCeartIaas2IVO vo) {

        return dao.suplerCeartBeforeInfoByIass2I(vo);
    }
    
    /* (IaaS 서버문의 조회)
     */
    @Override
    public List<SuplerCeartIaasDsVO> suplerCeartBeforeInfoByIassDs(SuplerCeartIaasDsVO vo) {

        return dao.suplerCeartBeforeInfoByIassDs(vo);
    }
    
    /* (Iaa2S 서버문의 조회)
     */
    @Override
    public List<SuplerCeartIaas2DsVO> suplerCeartBeforeInfoByIass2Ds(SuplerCeartIaas2DsVO vo) {

        return dao.suplerCeartBeforeInfoByIass2Ds(vo);
    }
    
    /* (IaaS DB문의 조회)
     */
    @Override
    public List<SuplerCeartIaasDdVO> suplerCeartBeforeInfoByIassDd(SuplerCeartIaasDdVO vo) {

        return dao.suplerCeartBeforeInfoByIassDd(vo);
    }
    
    /* (Iaa2S DB문의 조회)
     */
    @Override
    public List<SuplerCeartIaas2DdVO> suplerCeartBeforeInfoByIass2Dd(SuplerCeartIaas2DdVO vo) {

        return dao.suplerCeartBeforeInfoByIass2Dd(vo);
    }    
    
    /* (상세정보(사전견적)요청서 PaaS2)
     */
    @Override
    public List<SuplerCeartScs2VO> suplerCeartBeforeInfoByScs2(SuplerCeartScs2VO vo) {

        return dao.suplerCeartBeforeInfoByScs2(vo);
    }

    /* (사전공고 공급자 확인정보 등록)
     */
    @Override
    public int updateBeforeNotifySplyAction(SuplerCeartNotifySplyVO vo){
        return dao.updateBeforeNotifySplyAction(vo);
    }
    
    /* (사전공고 PaaS 답변 등록)
     */
    @Override
    public int insertBeforePaasAnswerAction(SuplerCeartPaasVO vo){
        return dao.insertBeforePaasAnswerAction(vo);
    }
    
    /* (사전공고 PaaS2 답변 등록)
     */
    @Override
    public int insertBeforePaas2AnswerAction(SuplerCeartPaas2VO vo){
        return dao.insertBeforePaas2AnswerAction(vo);
    }

    /* (사전공고 PaaS 답변 수정)
     */
    @Override
    public int updateBeforePaasAnswerAction(SuplerCeartPaasVO vo){
        return dao.updateBeforePaasAnswerAction(vo);
    }

    /* (사전공고 SaaS 마스터 답변 등록)
     */
    @Override
    public int insertBeforeSaasIAnswerAction(SuplerCeartSaasIVO vo){
        return dao.insertBeforeSaasIAnswerAction(vo);
    }

    /* (사전공고 SaaS2 마스터 답변 등록)
     */
    @Override
    public int insertBeforeSaas2IAnswerAction(SuplerCeartSaas2IVO vo){
        return dao.insertBeforeSaas2IAnswerAction(vo);
    }

    /* (사전공고 SaaS 마스터 답변 수정)
     */
    @Override
    public int updateBeforeSaasIAnswerAction(SuplerCeartSaasIVO vo){
        return dao.updateBeforeSaasIAnswerAction(vo);
    }

    /* (사전공고 SaaS 상세 답변 등록)
     */
    @Override
    public int insertBeforeSaasDAnswerAction(SuplerCeartSaasDVO vo){
        return dao.insertBeforeSaasDAnswerAction(vo);
    }

    /* (사전공고 SaaS2 상세필요 답변 등록)
     */
    @Override
    public int insertBeforeSaas2NeedAnswerAction(int i, SuplerCeartSaas2DnVO vo){
        return dao.insertBeforeSaas2NeedAnswerAction(i,vo);
    }

    /* (사전공고 SaaS2 상세필요 Seq)
     */
    @Override
    public int selectBeforeSaas2NeedSeq(SuplerCeartSaas2DnVO vo){
        return dao.selectBeforeSaas2NeedSeq(vo);
    }

    /* (사전공고 SaaS2 상세옵션 답변 등록)
     */
    @Override
    public int insertBeforeSaas2OptionAnswerAction(int i, int j, SuplerCeartSaas2DoVO vo){

        return dao.insertBeforeSaas2OptionAnswerAction(i,j,vo);
    }

    /* (사전공고 SaaS 상세 답변 삭제)
     */
    @Override
    public int deleteBeforeSaasDAnswerAction(SuplerCeartSaasIVO vo){
        return dao.deleteBeforeSaasDAnswerAction(vo);
    }

    /* (사전공고 IaaS 마스터 답변 등록)
     */
    @Override
    public int insertBeforeIaasIAnswerAction(SuplerCeartIaasIVO vo){
        return dao.insertBeforeIaasIAnswerAction(vo);
    }

    /* (사전공고 IaaS2 마스터 답변 등록)
     */
    @Override
    public int insertBeforeIaas2IAnswerAction(SuplerCeartIaas2IVO vo){
        return dao.insertBeforeIaas2IAnswerAction(vo);
    }

    /* (사전공고 IaaS 마스터 답변 수정)
     */
    @Override
    public int updateBeforeIaasIAnswerAction(SuplerCeartIaasIVO vo){
        return dao.updateBeforeIaasIAnswerAction(vo);
    }

    /* (사전공고 IaaS 서버 답변 등록)
     */
    @Override
    public int insertBeforeIaasDsAnswerAction(SuplerCeartIaasDsVO vo){
        return dao.insertBeforeIaasDsAnswerAction(vo);
    }

    /* (사전공고 IaaS2 서버 답변 등록)
     */
    @Override
    public int insertBeforeIaas2DsAnswerAction(int i, SuplerCeartIaas2DsVO vo){
        return dao.insertBeforeIaas2DsAnswerAction(i,vo);
    }

    /* (사전공고 IaaS 서버 답변 삭제)
     */
    @Override
    public int deleteBeforeIaasDsAnswerAction(SuplerCeartIaasIVO vo){
        return dao.deleteBeforeIaasDsAnswerAction(vo);
    }

    /* (사전공고 IaaS DB 답변 등록)
     */
    @Override
    public int insertBeforeIaasDdAnswerAction(SuplerCeartIaasDdVO vo){
        return dao.insertBeforeIaasDdAnswerAction(vo);
    }

    /* (사전공고 IaaS2 DB 답변 등록)
     */
    @Override
    public int insertBeforeIaas2DdAnswerAction(int i, SuplerCeartIaas2DdVO vo){
        return dao.insertBeforeIaas2DdAnswerAction(i,vo);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#insertBeforeScs2AnswerAction(zes.openworks.web.suplerCeart.vo.SuplerCeartScs2VO)
     */
    @Override
    public int insertBeforeScs2AnswerAction(SuplerCeartScs2VO vo) {
        return dao.insertBeforeScs2AnswerAction(vo);
        
    }    

    /* (사전공고 IaaS DB 답변 삭제)
     */
    @Override
    public int deleteBeforeIaasDdAnswerAction(SuplerCeartIaasIVO vo){
        return dao.deleteBeforeIaasDdAnswerAction(vo);
    }
    
    /**
     * (구매자선택 팝업)
     * @see zes.openworks.web.myCeart.MyCeartService#buyUserList(zes.openworks.web.suplerCeart.vo.SuplerServiceVO)
     */
    @Override
    public Pager<SuplerServiceVO> buyUserList(SuplerServiceVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerServiceVO> dataList = null;
        
        dataList = dao.buyUserList(parameterMap);
        vo.setTotalNum(dao.buyUserListCount(parameterMap));

        return new Pager<SuplerServiceVO>(dataList, vo);

    }
    
    /* (구매자 정보 가져오기)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#buyUserInfo(zes.openworks.web.bidSttus.vo.SuplerServiceVO)
     */
    @Override
    public SuplerServiceVO buyUserInfo(String supplyId) {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("commUserId" , supplyId);
        return dao.buyUserInfo(param); 
    }

    /**
     * (계약서 등록 데이터 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#cntrctDtlInfo(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public List<SuplerCntrctVO> cntrctDtlInfo(SuplerCntrctVO vo) {

        return dao.cntrctDtlInfo(vo);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#cntrctDetail(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public SuplerCntrctVO cntrctDetail(SuplerCntrctVO vo) {
        // TODO Auto-generated method stub
        return dao.cntrctDetail(vo);
    }

    /* (계약결과 등록)
     * @see zes.openworks.web.myCeart.MyCeartService##insertCntrctCmpl(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public int insertCntrctCmpl(SuplerCntrctVO vo){
        return dao.insertCntrctCmpl(vo);
    }

    /* (계약결과 수정)
     * @see zes.openworks.web.myCeart.MyCeartService##updateCntrctCmpl(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public int updateCntrctCmpl(SuplerCntrctVO vo){
        return dao.updateCntrctCmpl(vo);
    }
 
    @Override
    public List<SuplerCntrctGoodsVO> cntrctDtlGoodsList(SuplerCntrctVO vo){
        return dao.cntrctDtlGoodsList(vo);
    }

}
