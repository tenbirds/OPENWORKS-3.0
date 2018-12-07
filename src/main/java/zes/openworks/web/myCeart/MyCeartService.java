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

import zes.base.pager.Pager;
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
public interface MyCeartService {

    /**
     * buyingRequestList (상세정보(견적)요청서 목록)
     * @param vo
     * @return
     */
    Pager<MyCeartVO> buyingRequestList(MyCeartVO vo);

    /**
     * buyingRequestListExcel (상세정보(견적)요청서 목록(엑셀다운용))
     * @param vo
     * @return
     */
    Pager<MyCeartVO> buyingRequestListExcel(MyCeartVO vo);

    /**
     * buyingRequestInfo (상세정보(견적)요청서 상세 조회)
     */
    public Map<String, Object> buyingRequestInfo(MyCeartVO vo);

    /**
     * buyingRequestDetailList (상세정보(견적)요청서 공급자 정보 목록)
     * @param vo
     * @return
     */
    List<MyCeartVO> buyingRequestDetailList(MyCeartVO vo);

    /**
     * updateContractChoice (계약대상 선정)
     * @param vo
     * @return
     */
    int updateContractChoice(MyCeartVO vo);
    
    /**
     * buyingRequestChoiceReport (선정평가서 정보 조회)
     */
    public Map<String, Object> buyingRequestChoiceReport(MyCeartVO vo);
    
    /**
     * updateFinishRequest (계약체결 완료요청)
     * @param vo
     * @return
     */
    int updateFinishRequest(HashMap map);

    /**
     * myCeartBidNotifyInfo (입찰공고정보 조회)
     */
    List<MyCeartBidNotifyVO> myCeartBidNotifyInfo(MyCeartBidNotifyVO vo);

    /**
     * myCeartNotifySplyInfo (입찰공고 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<MyCeartNotifySplyVO> myCeartNotifySplyInfo(MyCeartNotifySplyVO vo);
    
    /**
     * myCeartInfoBySassI (상세정보(견적)요청서 SaaS I)
     * @param vo
     * @return
     */
    List<MyCeartSaasIVO> myCeartInfoBySassI(MyCeartSaasIVO vo);
    
    /**
     * myCeartInfoBySassI (상세정보(견적)요청서 SaaS2 I)
     * @param vo
     * @return
     */
    List<MyCeartSaasIVO> myCeartInfoBySass2I(MyCeartSaas2IVO vo);

    /**
     * myCeartInfoBySassD (상세정보(견적)요청서 SaaS D)
     * @param vo
     * @return
     */
    List<MyCeartSaasDVO> myCeartInfoBySassD(MyCeartSaasDVO vo);

    /**
     * myCeartInfoBySass2Dn (상세정보(견적)요청서 SaaS2 DNeed)
     * @param vo
     * @return
     */
    List<MyCeartSaas2DnVO> myCeartInfoBySass2Dn(MyCeartSaas2DnVO vo);

    /**
     * myCeartInfoBySass2Do (상세정보(견적)요청서 SaaS2 Do)
     * @param vo
     * @return
     */
    List<MyCeartSaas2DoVO> myCeartInfoBySass2Do(MyCeartSaas2DoVO vo);

    /**
     * myCeartInfoBySassI (상세정보(견적)요청서 PaaS)
     * @param vo
     * @return
     */
    List<MyCeartPaasVO> myCeartInfoByPass(MyCeartPaasVO vo);

    /**
     * myCeartInfoBySass2I (상세정보(견적)요청서 PaaS2)
     * @param vo
     * @return
     */
    List<MyCeartPaas2VO> myCeartInfoByPass2(MyCeartPaas2VO vo);

    /**
     * myCeartInfoByIassI (상세정보(견적)요청서 IaaS I)
     * @param vo
     * @return
     */
    List<MyCeartIaasIVO> myCeartInfoByIassI(MyCeartIaasIVO vo);

    /**
     * myCeartInfoByIass2I (상세정보(견적)요청서 IaaS2 I)
     * @param vo
     * @return
     */
    List<MyCeartIaas2IVO> myCeartInfoByIass2I(MyCeartIaas2IVO vo);

    /**
     * myCeartInfoByIassDs (상세정보(견적)요청서 IaaS DS)
     * @param vo
     * @return
     */
    List<MyCeartIaasDsVO> myCeartInfoByIassDs(MyCeartIaasDsVO vo);

    /**
     * myCeartInfoByIass2Ds (상세정보(견적)요청서 Iaa2S DS)
     * @param vo
     * @return
     */
    List<MyCeartIaas2DsVO> myCeartInfoByIass2Ds(MyCeartIaas2DsVO vo);

    /**
     * myCeartInfoByIassDd (상세정보(견적)요청서 IaaS DD)
     * @param vo
     * @return
     */
    List<MyCeartIaasDdVO> myCeartInfoByIassDd(MyCeartIaasDdVO vo);

    /**
     * myCeartInfoByIass2Dd (상세정보(견적)요청서 IaaS2 DD)
     * @param vo
     * @return
     */
    List<MyCeartIaas2DdVO> myCeartInfoByIass2Dd(MyCeartIaas2DdVO vo);

    /**
     * myCeartGoodsList (상세정보(견적)요청서 서비스 상세 정보 조회)
     * @param vo
     * @return
     */
    List<MyCeartGoodsVO> myCeartGoodsList(MyCeartGoodsVO vo);

    /**
     * compareMyCeartInfoBySassI (상세정보(견적)요청서 SaaS 조회(비교 팝업용))
     * @param vo
     * @return
     */
    List<MyCeartSaasIVO> compareMyCeartInfoBySassI(MyCeartSaasIVO vo);

    /**
     * compareMyCeartInfoBySassD (상세정보(견적)요청서 SaaS 상세 조회(비교 팝업용))
     * @param vo
     * @return
     */
    List<MyCeartSaasDVO> compareMyCeartInfoBySassD(MyCeartSaasDVO vo);

    /**
     * compareMyCeartInfoBySassD (상세정보(견적)요청서 PaaS 조회(비교 팝업용))
     * @param vo
     * @return
     */
    List<MyCeartPaasVO> compareMyCeartInfoByPass(MyCeartPaasVO vo);
    
    /**
     * compareMyCeartInfoByIassI (상세정보(견적)요청서 IaaS I(비교 팝업용))
     * @param vo
     * @return
     */
    List<MyCeartIaasIVO> compareMyCeartInfoByIassI(MyCeartIaasIVO vo);

    /**
     * compareMyCeartInfoByIassDs (상세정보(견적)요청서 IaaS DS(비교 팝업용))
     * @param vo
     * @return
     */
    List<MyCeartIaasDsVO> compareMyCeartInfoByIassDs(MyCeartIaasDsVO vo);

    /**
     * compareMyCeartInfoByIassDd (상세정보(견적)요청서 IaaS DD(비교 팝업용))
     * @param vo
     * @return
     */
    List<MyCeartIaasDdVO> compareMyCeartInfoByIassDd(MyCeartIaasDdVO vo);

    /**
     * myCeartBidList (입찰공고관리 목록 조회)
     * @param vo
     * @return
     */
    Pager<MyCeartBidNotifyVO> myCeartBidList(MyCeartBidNotifyVO vo);

    /**
     * cancleMyCeartBid (입찰공고 취소)
     * @param vo
     * @return
     */
    int cancleMyCeartBid(MyCeartBidNotifyVO vo);

    /**
     * updateMyCeartBidTerm (입찰공고 연기)
     * @param vo
     * @return
     */
    int updateMyCeartBidTerm(MyCeartBidNotifyVO vo);

    /**
     * updateMyCeartBidInfo (입찰공고 변경)
     * @param vo
     * @return
     */
    int updateMyCeartBidInfo(MyCeartBidNotifyVO vo);

    /**
     * myCeartBidList (입찰공고관리 응찰현황(응찰자) 목록 조회)
     * @param vo
     * @return
     */
    List<MyCeartTenderVO> myCeartTenderList(MyCeartTenderVO vo);

    /**
     * updateMyCeartOpenAction (입찰공고 개찰처리)
     * @param vo
     * @return
     */
    int updateMyCeartOpenAction(MyCeartTenderVO vo);

    /**
     * updateMyCeartSuccBidder (입찰공고 낙찰처리)
     * @param vo
     * @return
     */
    int updateMyCeartSuccBidder(MyCeartTenderVO vo);

    /**
     * updateMyCeartSuccBidMst (낙찰자 정보 수정에 성공할 경우 공고 마스터에 상태 변경)
     * @param vo
     * @return
     */
    int updateMyCeartSuccBidMst(MyCeartTenderVO vo);

    /**
     * updateMyCeartBidCancel (입찰공고 낙찰취소처리)
     * @param vo
     * @return
     */
    int updateMyCeartBidCancel(MyCeartTenderVO vo);

    /**
     * updateMyCeartCancelBidMst (입찰공고 낙찰취소처리에 성공할 경우 공고 마스터에 상태 변경)
     * @param vo
     * @return
     */
    int updateMyCeartCancelBidMst(MyCeartTenderVO vo);

    /**
     * buyingRequestList (로그인회워 타입 코드)
     * @param vo
     * @return
     */
    int purchsDtlsUserTyCd(MyCeartPurchsDtlsVO vo);
    
    /**
     * buyingRequestList (구매내역 관리 목록)
     * @param vo
     * @return
     */
    Pager<MyCeartPurchsDtlsVO> purchsDtlsList(MyCeartPurchsDtlsVO vo);

    /**
     * buyingRequestListExcel (구매내역 관리 목록(엑셀다운용))
     * @param vo
     * @return
     */
    Pager<MyCeartPurchsDtlsVO> purchsDtlsListExcel(MyCeartPurchsDtlsVO vo);

    /**
     * updateAcmsltCrtfRequst (구매(실적)증명서 발급요청)
     * @param vo
     * @return
     */
    int updateAcmsltCrtfRequst(HashMap map);

    /**
     * insertCntrctCmpl (계약결과 등록)
     * @param vo
     * @return
     */
    int insertCntrctCmpl(SuplerCntrctVO vo);

    /**
     * updateCntrctCmpl (계약결과 수정)
     * @param vo
     * @return
     */
    int updateCntrctCmpl(SuplerCntrctVO vo);
    
    /**
     * wholeServiceList (씨앗 전체 서비스 찾기 팝업)
     * @param vo
     * @return
     */
    Pager<SuplerServiceVO> wholeServiceList(SuplerServiceVO vo);
    Pager<SuplerServiceVO> wholeServiceList2(SuplerServiceVO vo);
    
    /**
     * cntrctDtlInfo (계약서 등록 데이터 조회)
     * @param vo
     * @return
     */
    List<SuplerCntrctVO> cntrctDtlInfo(SuplerCntrctVO vo);

    /**
     * cntrctDtlInfo (계약서 등록 데이터 조회)
     * @param vo
     * @return
     */
    List<SuplerCntrctVO> cntrctInitInfo(SuplerCntrctVO vo);
    
    /**
     * updateCntrctDel (수의계약 삭제)
     * @param vo
     * @return
     */
    int deleteCntrctCmpl(SuplerCntrctVO vo);
    
    /**
     * myPgesStatCheck (입찰관고 관리 진행상태 체크)
     * @param vo
     * @return
     */
    int myPgesStatCheck(MyCeartBidNotifyVO vo);
    
    /**
     * beffatEstmtList (사전견적관리)
     * @param vo
     * @return
     */
    Pager<MyCeartBeforeNofyVO> myCeartBeforeRequestList(MyCeartBeforeNofyVO vo);
    
    /**
     * myCeartBeforeNotifyInfo (사전견적관리 상세)
     */
    List<MyCeartBeforeNofyVO> myCeartBeforeNotifyInfo(MyCeartBeforeNofyVO vo);
    
    /**
     * myCeartBeforeNotifySplyInfo (사전견적관리 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<MyCeartBeforeNotifySplyVO> myCeartBeforeNotifySplyInfo(MyCeartBeforeNotifySplyVO vo);
    
    /**
     * myCeartBeforeInfoBySassI (상세정보(사전견적)요청서 SaaS I)
     * @param vo
     * @return
     */
    List<MyCeartSaasIVO> myCeartBeforeInfoBySassI(MyCeartSaasIVO vo);

    /**
     * myCeartBeforeInfoBySass2I 설명
     * @param vo
     * @return
     */
    List<MyCeartSaas2IVO> myCeartBeforeInfoBySass2I(MyCeartSaas2IVO vo);
    
    /**
     * myCeartBeforeInfoBySassD (상세정보(사전견적)요청서 SaaS D)
     * @param vo
     * @return
     */
    List<MyCeartSaasDVO> myCeartBeforeInfoBySassD(MyCeartSaasDVO vo);

    /**
     * myCeartBeforeInfoBySass2Dn (상세정보(사전견적)요청서 SaaS2 DNeed)
     * @param vo
     * @return
     */
    List<MyCeartSaas2DnVO> myCeartBeforeInfoBySass2Dn(MyCeartSaas2DnVO vo);

    /**
     * myCeartBeforeInfoBySass2Do (상세정보(사전견적)요청서 SaaS2 Do)
     * @param vo
     * @return
     */
    List<MyCeartSaas2DoVO> myCeartBeforeInfoBySass2Do(MyCeartSaas2DoVO vo);

    /**
     * myCeartBeforeInfoByPass (상세정보(사전견적)요청서 PaaS)
     * @param vo
     * @return
     */
    List<MyCeartPaasVO> myCeartBeforeInfoByPass(MyCeartPaasVO vo);

    /**
     * myCeartBeforeInfoByPass (상세정보(사전견적)요청서 PaaS)
     * @param vo
     * @return
     */
    List<MyCeartPaas2VO> myCeartBeforeInfoByPass2(MyCeartPaas2VO vo);

    /**
     * myCeartBeforeInfoByIassI (상세정보(사전견적)요청서 IaaS I)
     * @param vo
     * @return
     */
    List<MyCeartIaasIVO> myCeartBeforeInfoByIassI(MyCeartIaasIVO vo);

    /**
     * myCeartBeforeInfoByIass2I (상세정보(사전견적)요청서 IaaS2 I)
     * @param vo
     * @return
     */
    List<MyCeartIaas2IVO> myCeartBeforeInfoByIass2I(MyCeartIaas2IVO vo);

    /**
     * myCeartBeforeInfoByIassDs (상세정보(사전견적)요청서 IaaS DS)
     * @param vo
     * @return
     */
    List<MyCeartIaasDsVO> myCeartBeforeInfoByIassDs(MyCeartIaasDsVO vo);

    /**
     * myCeartBeforeInfoByIass2Ds (상세정보(사전견적)요청서 IaaS2 DS)
     * @param vo
     * @return
     */
    List<MyCeartIaas2DsVO> myCeartBeforeInfoByIass2Ds(MyCeartIaas2DsVO vo);

    /**
     * myCeartBeforeInfoByIassDd (상세정보(사전견적)요청서 IaaS DD)
     * @param vo
     * @return
     */
    List<MyCeartIaasDdVO> myCeartBeforeInfoByIassDd(MyCeartIaasDdVO vo);

    /**
     * myCeartBeforeInfoByIass2Dd (상세정보(사전견적)요청서 IaaS2 DD)
     * @param vo
     * @return
     */
    List<MyCeartIaas2DdVO> myCeartBeforeInfoByIass2Dd(MyCeartIaas2DdVO vo);
    
    /**
     * myCeartBeforeInfoByScs2 설명
     * @param scs2vo
     * @return
     */
    List<MyCeartScs2VO> myCeartBeforeInfoByScs2(MyCeartScs2VO vo);
    
    /**
     * myCeartBeforeRequestListDeleteAction (사전견적관리 - 삭제)
     * @param dataMap
     * @return
     */
    int myCeartBeforeRequestListDeleteAction(HashMap<String, String> dataMap);

    /**
     * insertbdGoodsTmp (비교하기 temp에 넣기)
     * @param dataMap
     * @return
     */
    int insertbdGoodsTmp(HashMap<String, String> dataMap);
    
    /**
     * selectBdGoodsTmpNm (비교하기 상품 이름가져오기)
     * @param vo
     * @return
     */
    Map<String, Object> selectBdGoodsTmpNm(HashMap<String, String> dataMap);

    /**
     * selectBgGoodsList 설명
     * @param dataMap
     * @return
     */
    List selectBgGoodsList(HashMap<String, String> dataMap);

    /**
     * deleteBdGoodsTmp 서비스비교 템프 삭제
     * @param dataMap
     */
    int deleteBdGoodsTmp(HashMap<String, String> dataMap);

    /**
     * myCeartBeforeNotifySplyHistory 설명
     * @param beforeNotifySplyVO
     * @return
     */
    List<MyWishVO> myWishHistory(MyWishVO vo);
}
