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

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.core.bind.VoBinder;
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
@Service("MyCeartService")
public class MyCeartServiceImpl extends AbstractServiceImpl implements MyCeartService {

    @Resource MyCeartDAO dao;

    /* (상세정보(견적)요청서 목록)
     * @see zes.openworks.web.myCeart.MyCeartService#buyingRequestList(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Pager<MyCeartVO> buyingRequestList(MyCeartVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCeartVO> dataList = null;
        
        dataList = dao.buyingRequestList(parameterMap);
        vo.setTotalNum(dao.buyingRequestListCount(parameterMap));

        return new Pager<MyCeartVO>(dataList, vo);
    }

    /* (상세정보(견적)요청서 목록(엑셀 다운용))
     * @see zes.openworks.web.myCeart.MyCeartService#buyingRequestListExcel(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Pager<MyCeartVO> buyingRequestListExcel(MyCeartVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCeartVO> dataList = null;
        
        dataList = dao.buyingRequestListExcel(parameterMap);
        vo.setTotalNum(dao.buyingRequestListCount(parameterMap));

        return new Pager<MyCeartVO>(dataList, vo);
    }

    /* (상세정보(견적)요청서 상세 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#buyingRequestInfo(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Map<String, Object> buyingRequestInfo(MyCeartVO vo) {

        return dao.buyingRequestInfo(vo);
    }

    /* (상세정보(견적)요청서 공급자 정보 목록)
     * @see zes.openworks.web.myCeart.MyCeartService#buyingRequestDetailList(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public List<MyCeartVO> buyingRequestDetailList(MyCeartVO vo) {

        return dao.buyingRequestDetailList(vo);
    }

    /* (계약대상 선정)
     * @see zes.openworks.web.bid.BidService##updateContractChoice(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public int updateContractChoice(MyCeartVO vo){
        return dao.updateContractChoice(vo);
    }

    /* (선정평가서 정보 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#buyingRequestChoiceReport(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Map<String, Object> buyingRequestChoiceReport(MyCeartVO vo) {

        return dao.buyingRequestChoiceReport(vo);
    }

    /* (계약체결 완료요청)
     * @see zes.openworks.web.bid.BidService##updateFinishRequest(HashMap)
     */
    @Override
    public int updateFinishRequest(HashMap map){
        return dao.updateFinishRequest(map);
    }

    /* (입찰공고정보 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBidNotifyInfo(zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO)
     */
    @Override
    public List<MyCeartBidNotifyVO> myCeartBidNotifyInfo(MyCeartBidNotifyVO vo) {

        return dao.myCeartBidNotifyInfo(vo);
    }

    /* (입찰공고 공급자 확인정보 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartNotifySplyInfo(zes.openworks.web.myCeart.vo.MyCeartNotifySplyVO)
     */
    @Override
    public List<MyCeartNotifySplyVO> myCeartNotifySplyInfo(MyCeartNotifySplyVO vo) {

        return dao.myCeartNotifySplyInfo(vo);
    }

    /* (상세정보(견적)요청서 SaaS I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoBySassI(zes.openworks.web.myCeart.vo.MyCeartSaasIVO)
     */
    @Override
    public List<MyCeartSaasIVO> myCeartInfoBySassI(MyCeartSaasIVO vo) {

        return dao.myCeartInfoBySassI(vo);
    }

    /* (상세정보(견적)요청서 SaaS2 I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoBySassI(zes.openworks.web.myCeart.vo.MyCeartSaasIVO)
     */
    @Override
    public List<MyCeartSaasIVO> myCeartInfoBySass2I(MyCeartSaas2IVO vo) {

        return dao.myCeartInfoBySass2I(vo);
    }

    /* (상세정보(견적)요청서 SaaS D)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoBySassD(zes.openworks.web.myCeart.vo.MyCeartSaasDVO)
     */
    @Override
    public List<MyCeartSaasDVO> myCeartInfoBySassD(MyCeartSaasDVO vo) {

        return dao.myCeartInfoBySassD(vo);
    }

    /* (상세정보(견적)요청서 SaaS2 Dn)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoBySass2Dn(zes.openworks.web.myCeart.vo.MyCeartSaas2DnVO)
     */
    @Override
    public List<MyCeartSaas2DnVO> myCeartInfoBySass2Dn(MyCeartSaas2DnVO vo) {

        return dao.myCeartInfoBySass2Dn(vo);
    }

    /* (상세정보(견적)요청서 SaaS2 Do)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoBySass2Do(zes.openworks.web.myCeart.vo.MyCeartSaas2DoVO)
     */
    @Override
    public List<MyCeartSaas2DoVO> myCeartInfoBySass2Do(MyCeartSaas2DoVO vo) {

        return dao.myCeartInfoBySass2Do(vo);
    }

    /* (상세정보(견적)요청서 PaaS)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByPass(zes.openworks.web.myCeart.vo.MyCeartPaasVO)
     */
    @Override
    public List<MyCeartPaasVO> myCeartInfoByPass(MyCeartPaasVO vo) {

        return dao.myCeartInfoByPass(vo);
    }


    /* (상세정보(견적)요청서 PaaS2)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByPass2(zes.openworks.web.myCeart.vo.MyCeartPaas2VO)
     */
    @Override
    public List<MyCeartPaas2VO> myCeartInfoByPass2(MyCeartPaas2VO vo) {

        return dao.myCeartInfoByPass2(vo);
    }

    /* (상세정보(견적)요청서 IaaS I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIassI(zes.openworks.web.myCeart.vo.MyCeartIaasIVO)
     */
    @Override
    public List<MyCeartIaasIVO> myCeartInfoByIassI(MyCeartIaasIVO vo) {

        return dao.myCeartInfoByIassI(vo);
    }

    /* (상세정보(견적)요청서 IaaS2 I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIass2I(zes.openworks.web.myCeart.vo.MyCeartIaas2IVO)
     */
    @Override
    public List<MyCeartIaas2IVO> myCeartInfoByIass2I(MyCeartIaas2IVO vo) {

        return dao.myCeartInfoByIass2I(vo);
    }

    /* (상세정보(견적)요청서 IaaS DS)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIassDs(zes.openworks.web.myCeart.vo.MyCeartIaasDsVO)
     */
    @Override
    public List<MyCeartIaasDsVO> myCeartInfoByIassDs(MyCeartIaasDsVO vo) {

        return dao.myCeartInfoByIassDs(vo);
    }

    /* (상세정보(견적)요청서 IaaS2 DS)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIass2Ds(zes.openworks.web.myCeart.vo.MyCeartIaas2DsVO)
     */
    @Override
    public List<MyCeartIaas2DsVO> myCeartInfoByIass2Ds(MyCeartIaas2DsVO vo) {

        return dao.myCeartInfoByIass2Ds(vo);
    }

    /* (상세정보(견적)요청서 IaaS DD)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIassDd(zes.openworks.web.myCeart.vo.MyCeartIaasDdVO)
     */
    @Override
    public List<MyCeartIaasDdVO> myCeartInfoByIassDd(MyCeartIaasDdVO vo) {

        return dao.myCeartInfoByIassDd(vo);
    }

    /* (상세정보(견적)요청서 IaaS2 DD)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIass2Dd(zes.openworks.web.myCeart.vo.MyCeartIaas2DdVO)
     */
    @Override
    public List<MyCeartIaas2DdVO> myCeartInfoByIass2Dd(MyCeartIaas2DdVO vo) {

        return dao.myCeartInfoByIass2Dd(vo);
    }

    /* (상세정보(견적)요청서 서비스 상세 정보 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartInfoByIassDd(zes.openworks.web.myCeart.vo.MyCeartGoodsVO)
     */
    @Override
    public List<MyCeartGoodsVO> myCeartGoodsList(MyCeartGoodsVO vo) {

        return dao.myCeartGoodsList(vo);
    }

    /* (상세정보(견적)요청서 SaaS 조회(비교 팝업용))
     * @see zes.openworks.web.myCeart.MyCeartService#compareMyCeartInfoBySassI(zes.openworks.web.myCeart.vo.MyCeartSaasIVO)
     */
    @Override
    public List<MyCeartSaasIVO> compareMyCeartInfoBySassI(MyCeartSaasIVO vo) {

        return dao.compareMyCeartInfoBySassI(vo);
    }
    
    /* (상세정보(견적)요청서 SaaS 상세 조회(비교 팝업용))
     * @see zes.openworks.web.myCeart.MyCeartService#compareMyCeartInfoBySassD(zes.openworks.web.myCeart.vo.MyCeartSaasDVO)
     */
    @Override
    public List<MyCeartSaasDVO> compareMyCeartInfoBySassD(MyCeartSaasDVO vo) {

        return dao.compareMyCeartInfoBySassD(vo);
    }

    /* (상세정보(견적)요청서 PaaS 조회(비교 팝업용))
     * @see zes.openworks.web.myCeart.MyCeartService#compareMyCeartInfoByPass(zes.openworks.web.myCeart.vo.MyCeartPaasVO)
     */
    @Override
    public List<MyCeartPaasVO> compareMyCeartInfoByPass(MyCeartPaasVO vo) {

        return dao.compareMyCeartInfoByPass(vo);
    }

    /* (상세정보(견적)요청서 IaaS I(비교 팝업용))
     * @see zes.openworks.web.myCeart.MyCeartService#compareMyCeartInfoByIassI(zes.openworks.web.myCeart.vo.MyCeartIaasIVO)
     */
    @Override
    public List<MyCeartIaasIVO> compareMyCeartInfoByIassI(MyCeartIaasIVO vo) {

        return dao.compareMyCeartInfoByIassI(vo);
    }

    /* (상세정보(견적)요청서 IaaS DS(비교 팝업용))
     * @see zes.openworks.web.myCeart.MyCeartService#compareMyCeartInfoByIassDs(zes.openworks.web.myCeart.vo.MyCeartIaasDsVO)
     */
    @Override
    public List<MyCeartIaasDsVO> compareMyCeartInfoByIassDs(MyCeartIaasDsVO vo) {

        return dao.compareMyCeartInfoByIassDs(vo);
    }

    /* (상세정보(견적)요청서 IaaS DD(비교 팝업용))
     * @see zes.openworks.web.myCeart.MyCeartService#compareMyCeartInfoByIassDd(zes.openworks.web.myCeart.vo.MyCeartIaasDdVO)
     */
    @Override
    public List<MyCeartIaasDdVO> compareMyCeartInfoByIassDd(MyCeartIaasDdVO vo) {

        return dao.compareMyCeartInfoByIassDd(vo);
    }

    /* (입찰공고관리 목록 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBidList(zes.openworks.web.myCeart.MyCeartBidNotifyVO)
     */
    @Override
    public Pager<MyCeartBidNotifyVO> myCeartBidList(MyCeartBidNotifyVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCeartBidNotifyVO> dataList = null;
        
        dataList = dao.myCeartBidList(parameterMap);
        vo.setTotalNum(dao.myCeartBidListCount(parameterMap));

        return new Pager<MyCeartBidNotifyVO>(dataList, vo);
    }

    /* (입찰공고 취소)
     * @see zes.openworks.web.bid.BidService##cancleMyCeartBid(zes.openworks.web.myCeart.MyCeartBidNotifyVO)
     */
    @Override
    public int cancleMyCeartBid(MyCeartBidNotifyVO vo){
        return dao.cancleMyCeartBid(vo);
    }

    /* (입찰공고 연기)
     * @see zes.openworks.web.bid.BidService##updateMyCeartBidTerm(zes.openworks.web.myCeart.MyCeartBidNotifyVO)
     */
    @Override
    public int updateMyCeartBidTerm(MyCeartBidNotifyVO vo){
        return dao.updateMyCeartBidTerm(vo);
    }

    /* (입찰공고 변경)
     * @see zes.openworks.web.bid.BidService##updateMyCeartBidInfo(zes.openworks.web.myCeart.MyCeartBidNotifyVO)
     */
    @Override
    public int updateMyCeartBidInfo(MyCeartBidNotifyVO vo){
        return dao.updateMyCeartBidInfo(vo);
    }

    /* (입찰공고관리 응찰현황(응찰자) 목록 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartTenderList(zes.openworks.web.myCeart.vo.MyCeartTenderVO)
     */
    @Override
    public List<MyCeartTenderVO> myCeartTenderList(MyCeartTenderVO vo) {

        return dao.myCeartTenderList(vo);
    }

    /* (입찰공고 개찰처리)
     * @see zes.openworks.web.bid.BidService##updateMyCeartOpenAction(zes.openworks.web.myCeart.MyCeartTenderVO)
     */
    @Override
    public int updateMyCeartOpenAction(MyCeartTenderVO vo){
        return dao.updateMyCeartOpenAction(vo);
    }

    /* (입찰공고 낙찰처리)
     * @see zes.openworks.web.bid.BidService##updateMyCeartSuccBidder(zes.openworks.web.myCeart.MyCeartTenderVO)
     */
    @Override
    public int updateMyCeartSuccBidder(MyCeartTenderVO vo){
        return dao.updateMyCeartSuccBidder(vo);
    }

    /* (낙찰자 정보 수정에 성공할 경우 공고 마스터에 상태 변경)
     * @see zes.openworks.web.bid.BidService##updateMyCeartSuccBidMst(zes.openworks.web.myCeart.MyCeartTenderVO)
     */
    @Override
    public int updateMyCeartSuccBidMst(MyCeartTenderVO vo){
        return dao.updateMyCeartSuccBidMst(vo);
    }

    /* (입찰공고 낙찰취소처리)
     * @see zes.openworks.web.bid.BidService##updateMyCeartBidCancel(zes.openworks.web.myCeart.MyCeartTenderVO)
     */
    @Override
    public int updateMyCeartBidCancel(MyCeartTenderVO vo){
        return dao.updateMyCeartBidCancel(vo);
    }

    /* (입찰공고 낙찰취소처리에 성공할 경우 공고 마스터에 상태 변경)
     * @see zes.openworks.web.bid.BidService##updateMyCeartCancelBidMst(zes.openworks.web.myCeart.MyCeartTenderVO)
     */
    @Override
    public int updateMyCeartCancelBidMst(MyCeartTenderVO vo){
        return dao.updateMyCeartCancelBidMst(vo);
    }

    /* (구매내역 관리 목록)
     * @see zes.openworks.web.myCeart.MyCeartService#purchsDtlsList(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Pager<MyCeartPurchsDtlsVO> purchsDtlsList(MyCeartPurchsDtlsVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCeartPurchsDtlsVO> dataList = null;
        
        dataList = dao.purchsDtlsList(parameterMap);
        vo.setTotalNum(dao.purchsDtlsListCount(parameterMap));

        return new Pager<MyCeartPurchsDtlsVO>(dataList, vo);
    }

    /* (구매내역 관리 목록(엑셀 다운용))
     * @see zes.openworks.web.myCeart.MyCeartService#purchsDtlsListExcel(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Pager<MyCeartPurchsDtlsVO> purchsDtlsListExcel(MyCeartPurchsDtlsVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCeartPurchsDtlsVO> dataList = null;
        
        dataList = dao.purchsDtlsListExcel(parameterMap);
        vo.setTotalNum(dao.purchsDtlsListCount(parameterMap));

        return new Pager<MyCeartPurchsDtlsVO>(dataList, vo);
    }

    /* (구매(실적)증명서 발급요청)
     * @see zes.openworks.web.myCeart.MyCeartService##updateAcmsltCrtfRequst(HashMap)
     */
    @Override
    public int updateAcmsltCrtfRequst(HashMap map){
        return dao.updateAcmsltCrtfRequst(map);
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

    /**
     * (씨앗 전체 서비스 찾기 팝업)
     * @see zes.openworks.web.myCeart.MyCeartService#wholeServiceList(zes.openworks.web.suplerCeart.vo.SuplerServiceVO)
     */
    @Override
    public Pager<SuplerServiceVO> wholeServiceList(SuplerServiceVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerServiceVO> dataList = null;
        
        dataList = dao.wholeServiceList(parameterMap);
        vo.setTotalNum(dao.wholeServiceListCount(parameterMap));

        return new Pager<SuplerServiceVO>(dataList, vo);

    }
    @Override
    public Pager<SuplerServiceVO> wholeServiceList2(SuplerServiceVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<SuplerServiceVO> dataList = null;
        
        dataList = dao.wholeServiceList2(parameterMap);
        vo.setTotalNum(dao.wholeServiceListCount2(parameterMap));

        return new Pager<SuplerServiceVO>(dataList, vo);

    }
    
    /**
     * (계약서 등록 데이터 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#cntrctDtlInfo(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public List<SuplerCntrctVO> cntrctDtlInfo(SuplerCntrctVO vo) {

        return dao.cntrctDtlInfo(vo);
    }

    /**
     * (계약서 등록 데이터 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#cntrctDtlInfo(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public List<SuplerCntrctVO> cntrctInitInfo(SuplerCntrctVO vo) {

        return dao.cntrctInitInfo(vo);
    }
    
    /* (수의계약 삭제)
     * @see zes.openworks.web.myCeart.MyCeartService#updateCntrctDel(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public int deleteCntrctCmpl(SuplerCntrctVO vo) {
        // TODO Auto-generated method stub
        return  dao.deleteCntrctCmpl(vo);
    }

    /* (입찬공고관리 진행상태 체크)
     * @see zes.openworks.web.myCeart.MyCeartService#myPgesStatCheck(zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO)
     */
    @Override
    public int myPgesStatCheck(MyCeartBidNotifyVO vo) {
        // TODO Auto-generated method stub
        return dao.myPgesStatCheck(vo);
    }

    /* (로그인 회원 타입 구하기)
     * @see zes.openworks.web.myCeart.MyCeartService#purchsDtlsUserTyCd(zes.openworks.web.myCeart.vo.MyCeartPurchsDtlsVO)
     */
    @Override
    public int purchsDtlsUserTyCd(MyCeartPurchsDtlsVO vo) {
        // TODO Auto-generated method stub
        return dao.purchsDtlsUserTyCd(vo);
    }
    
    /* (사전견적관리)
     * @see zes.openworks.web.myCeart.MyCeartService#beffatEstmtList(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Pager<MyCeartBeforeNofyVO> myCeartBeforeRequestList(MyCeartBeforeNofyVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCeartBeforeNofyVO> dataList = null;
        
        dataList = dao.myCeartBeforeRequestList(parameterMap);
        vo.setTotalNum(dao.myCeartBeforeRequestListCount(parameterMap));

        return new Pager<MyCeartBeforeNofyVO>(dataList, vo);
    }
    
    /* (사전견적관리 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeNotifyInfo(zes.openworks.web.myCeart.vo.MyCeartBeforeNofyVO)
     */
    @Override
    public List<MyCeartBeforeNofyVO> myCeartBeforeNotifyInfo(MyCeartBeforeNofyVO vo) {

        return dao.myCeartBeforeNotifyInfo(vo);
    }

    /* (사전견적관리 공급자 확인정보 조회)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeNotifySplyInfo(zes.openworks.web.myCeart.vo.MyCeartBeforeNotifySplyVO)
     */
    @Override
    public List<MyCeartBeforeNotifySplyVO> myCeartBeforeNotifySplyInfo(MyCeartBeforeNotifySplyVO vo) {

        return dao.myCeartBeforeNotifySplyInfo(vo);
    }
    
    /* (상세정보(사전견적)요청서 SaaS I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoBySassI(zes.openworks.web.myCeart.vo.MyCeartSaasIVO)
     */
    @Override
    public List<MyCeartSaasIVO> myCeartBeforeInfoBySassI(MyCeartSaasIVO vo) {

        return dao.myCeartBeforeInfoBySassI(vo);
    }
    
    /* (상세정보(사전견적)요청서 SaaS2 I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoBySass2I(zes.openworks.web.myCeart.vo.MyCeartSaasIVO)
     */
    @Override
    public List<MyCeartSaas2IVO> myCeartBeforeInfoBySass2I(MyCeartSaas2IVO vo) {

        return dao.myCeartBeforeInfoBySass2I(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS D)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoBySassD(zes.openworks.web.myCeart.vo.MyCeartSaasDVO)
     */
    @Override
    public List<MyCeartSaasDVO> myCeartBeforeInfoBySassD(MyCeartSaasDVO vo) {

        return dao.myCeartBeforeInfoBySassD(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS2 Dn)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoBySass2Dn(zes.openworks.web.myCeart.vo.MyCeartSaas2DnVO)
     */
    @Override
    public List<MyCeartSaas2DnVO> myCeartBeforeInfoBySass2Dn(MyCeartSaas2DnVO vo) {

        return dao.myCeartBeforeInfoBySass2Dn(vo);
    }

    /* (상세정보(사전견적)요청서 SaaS2 Do)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoBySass2Do(zes.openworks.web.myCeart.vo.MyCeartSaas2DoVO)
     */
    @Override
    public List<MyCeartSaas2DoVO> myCeartBeforeInfoBySass2Do(MyCeartSaas2DoVO vo) {

        return dao.myCeartBeforeInfoBySass2Do(vo);
    }

    /* (상세정보(사전견적)요청서 PaaS)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByPass(zes.openworks.web.myCeart.vo.MyCeartPaasVO)
     */
    @Override
    public List<MyCeartPaasVO> myCeartBeforeInfoByPass(MyCeartPaasVO vo) {

        return dao.myCeartBeforeInfoByPass(vo);
    }

    /* (상세정보(사전견적)요청서 PaaS2)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByPass2(zes.openworks.web.myCeart.vo.MyCeartPaas2VO)
     */
    @Override
    public List<MyCeartPaas2VO> myCeartBeforeInfoByPass2(MyCeartPaas2VO vo) {

        return dao.myCeartBeforeInfoByPass2(vo);
    }

    /* (상세정보(사전견적)요청서 IaaS I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByIassI(zes.openworks.web.myCeart.vo.MyCeartIaasIVO)
     */
    @Override
    public List<MyCeartIaasIVO> myCeartBeforeInfoByIassI(MyCeartIaasIVO vo) {

        return dao.myCeartBeforeInfoByIassI(vo);
    }

    /* (상세정보(사전견적)요청서 IaaS2 I)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByIass2I(zes.openworks.web.myCeart.vo.MyCeartIaas2IVO)
     */
    @Override
    public List<MyCeartIaas2IVO> myCeartBeforeInfoByIass2I(MyCeartIaas2IVO vo) {

        return dao.myCeartBeforeInfoByIass2I(vo);
    }

    /* (상세정보(사전견적)요청서 IaaS DS)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByIassDs(zes.openworks.web.myCeart.vo.MyCeartIaasDsVO)
     */
    @Override
    public List<MyCeartIaasDsVO> myCeartBeforeInfoByIassDs(MyCeartIaasDsVO vo) {

        return dao.myCeartBeforeInfoByIassDs(vo);
    }

    /* (상세정보(사전견적)요청서 IaaS2 DS)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByIass2Ds(zes.openworks.web.myCeart.vo.MyCeartIaasDs2VO)
     */
    @Override
    public List<MyCeartIaas2DsVO> myCeartBeforeInfoByIass2Ds(MyCeartIaas2DsVO vo) {

        return dao.myCeartBeforeInfoByIass2Ds(vo);
    }

    /* (상세정보(사전견적)요청서 IaaS DD)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByIassDd(zes.openworks.web.myCeart.vo.MyCeartIaasDdVO)
     */
    @Override
    public List<MyCeartIaasDdVO> myCeartBeforeInfoByIassDd(MyCeartIaasDdVO vo) {

        return dao.myCeartBeforeInfoByIassDd(vo);
    }

    /* (상세정보(사전견적)요청서 IaaS2 DD)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByIass2Dd(zes.openworks.web.myCeart.vo.MyCeartIaas2DdVO)
     */
    @Override
    public List<MyCeartIaas2DdVO> myCeartBeforeInfoByIass2Dd(MyCeartIaas2DdVO vo) {

        return dao.myCeartBeforeInfoByIass2Dd(vo);
    }
    

    /* (non-Javadoc)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeInfoByScs2(zes.openworks.web.myCeart.vo.MyCeartScs2VO)
     */
    @Override
    public List<MyCeartScs2VO> myCeartBeforeInfoByScs2(MyCeartScs2VO vo) {
        
        return dao.myCeartBeforeInfoByScs2(vo);
    }
   
    /* (사전견적관리 - 삭제)
     * @see zes.openworks.web.suplerCeart.SuplerCeartService#myCeartBeforeRequestListDeleteAction(zes.openworks.web.suplerCeart.vo.SuplerCntrctVO)
     */
    @Override
    public int myCeartBeforeRequestListDeleteAction(HashMap dataMap){
        return dao.myCeartBeforeRequestListDeleteAction(dataMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCeart.MyCeartService#insertbdGoodsTmp(java.util.HashMap)
     */
    @Override
    public int insertbdGoodsTmp(HashMap<String, String> dataMap) {
        return dao.insertbdGoodsTmp(dataMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCeart.MyCeartService#selectBdGoodsTmpNm(zes.openworks.web.myCeart.MyCeartVO)
     */
    @Override
    public Map<String, Object> selectBdGoodsTmpNm(HashMap dataMap) {
        return dao.selectBdGoodsTmpNm(dataMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCeart.MyCeartService#selectBgGoodsList(java.util.HashMap)
     */
    @Override
    public List selectBgGoodsList(HashMap<String, String> dataMap) {
        // TODO Auto-generated method stub
        return dao.selectBgGoodsList(dataMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCeart.MyCeartService#deleteBdGoodsTmp(java.util.HashMap)
     */
    @Override
    public int deleteBdGoodsTmp(HashMap<String, String> dataMap) {
        return dao.deleteBdGoodsTmp(dataMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCeart.MyCeartService#myCeartBeforeNotifySplyHistory(zes.openworks.web.myCeart.vo.MyCeartBeforeNotifySplyVO)
     */
    @Override
    public List<MyWishVO> myWishHistory(MyWishVO vo) {
        
        return dao.myWishHistory(vo);
    }
}
