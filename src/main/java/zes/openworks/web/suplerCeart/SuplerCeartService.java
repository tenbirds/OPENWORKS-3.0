/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart;

import java.util.List;

import zes.base.pager.Pager;
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
public interface SuplerCeartService {

    /**
     * buyingRequestList (상세정보(견적)요청서 목록)
     * @param vo
     * @return
     */
    Pager<SuplerCeartVO> buyingRequestList(SuplerCeartVO vo);

    /**
     * buyingRequestListExcel (상세정보(견적)요청서 목록(엑셀다운용))
     * @param vo
     * @return
     */
    Pager<SuplerCeartVO> buyingRequestListExcel(SuplerCeartVO vo);
    
    /**
     * updateSplyConfmGbn (입찰공고 공급자 확인정보의 확인여부 update)
     * @param vo
     * @return
     */
    int updateSplyConfmGbn(SuplerCeartBidNotifyVO vo);

    /**
     * suplerCeartBidNotifyInfo (입찰공고정보 조회)
     */
    List<SuplerCeartBidNotifyVO> suplerCeartBidNotifyInfo(SuplerCeartBidNotifyVO vo);
    
    /**
     * suplerCeartNotifySplyInfo (입찰공고 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartNotifySplyVO> suplerCeartNotifySplyInfo(SuplerCeartNotifySplyVO vo);

    /**
     * suplerCeartInfoByPass (상세정보(견적)요청서 PaaS)
     * @param vo
     * @return
     */
    List<SuplerCeartPaasVO> suplerCeartInfoByPass(SuplerCeartPaasVO vo);

    /**
     * suplerCeartInfoByPass2 (상세정보(견적)요청서 PaaS2)
     * @param vo
     * @return
     */
    List<SuplerCeartPaas2VO> suplerCeartInfoByPass2(SuplerCeartPaas2VO vo);

    /**
     * suplerCeartInfoBySassI (상세정보(견적)요청서 SaaS I)
     * @param vo
     * @return
     */
    List<SuplerCeartSaasIVO> suplerCeartInfoBySassI(SuplerCeartSaasIVO vo);

    /**
     * suplerCeartInfoBySass2I (상세정보(견적)요청서 SaaS2 I)
     * @param vo
     * @return
     */
    List<SuplerCeartSaas2IVO> suplerCeartInfoBySass2I(SuplerCeartSaas2IVO vo);

    /**
     * suplerCeartInfoBySassD (상세정보(견적)요청서 SaaS D)
     * @param vo
     * @return
     */
    List<SuplerCeartSaasDVO> suplerCeartInfoBySassD(SuplerCeartSaasDVO vo);

    /**
     * suplerCeartInfoBySass2Dn (상세정보(견적)요청서 SaaS2 Dn)
     * @param vo
     * @return
     */
    List<SuplerCeartSaas2DnVO> suplerCeartInfoBySass2Dn(SuplerCeartSaas2DnVO vo);

    /**
     * suplerCeartInfoBySass2Do (상세정보(견적)요청서 SaaS2 Do)
     * @param vo
     * @return
     */
    List<SuplerCeartSaas2DoVO> suplerCeartInfoBySass2Do(SuplerCeartSaas2DoVO vo);

    /**
     * suplerCeartInfoByIassI (IaaS 마스터 정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaasIVO> suplerCeartInfoByIassI(SuplerCeartIaasIVO vo);

    /**
     * suplerCeartInfoByIassI (IaaS2 마스터 정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaas2IVO> suplerCeartInfoByIass2I(SuplerCeartIaas2IVO vo);
    
    /**
     * suplerCeartInfoByIassDs (IaaS 서버문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaasDsVO> suplerCeartInfoByIassDs(SuplerCeartIaasDsVO vo);
    
    /**
     * suplerCeartInfoByIass2Ds (IaaS2 서버문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaas2DsVO> suplerCeartInfoByIass2Ds(SuplerCeartIaas2DsVO vo);
    
    /**
     * suplerCeartInfoByIassDs (IaaS DB문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaasDdVO> suplerCeartInfoByIassDd(SuplerCeartIaasDdVO vo);
    
    /**
     * suplerCeartInfoByIass2Ds (IaaS2 DB문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaas2DdVO> suplerCeartInfoByIass2Dd(SuplerCeartIaas2DdVO vo);

    /**
     * suplerReturnRequestAction (견적요청 반려처리)
     * @param vo
     * @return
     */
    int suplerReturnRequestAction(SuplerCeartVO vo);

    /**
     * updateNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * @param vo
     * @return
     */
    int updateNotifySplyAction(SuplerCeartNotifySplyVO vo);

    /**
     * insertPaasAnswerAction (입찰공고 PaaS 답변 등록)
     * @param vo
     * @return
     */
    int insertPaasAnswerAction(SuplerCeartPaasVO vo);

    /**
     * updatePaasAnswerAction (입찰공고 PaaS 답변 수정)
     * @param vo
     * @return
     */
    int updatePaasAnswerAction(SuplerCeartPaasVO vo);

    /**
     * insertSaasIAnswerAction (입찰공고 SaaS 마스터 답변 등록)
     * @param vo
     * @return
     */
    int insertSaasIAnswerAction(SuplerCeartSaasIVO vo);

    /**
     * updateSaasIAnswerAction (입찰공고 SaaS 마스터 답변 수정)
     * @param vo
     * @return
     */
    int updateSaasIAnswerAction(SuplerCeartSaasIVO vo);

    /**
     * insertSaasDAnswerAction (입찰공고 SaaS 상세 답변 등록)
     * @param vo
     * @return
     */
    int insertSaasDAnswerAction(SuplerCeartSaasDVO vo);

    /**
     * deleteSaasDAnswerAction (입찰공고 SaaS 상세 답변 삭제)
     * @param vo
     * @return
     */
    int deleteSaasDAnswerAction(SuplerCeartSaasIVO vo);

    /**
     * insertIaasIAnswerAction (입찰공고 IaaS 마스터 답변 등록)
     * @param vo
     * @return
     */
    int insertIaasIAnswerAction(SuplerCeartIaasIVO vo);

    /**
     * updateIaasIAnswerAction (입찰공고 IaaS 마스터 답변 수정)
     * @param vo
     * @return
     */
    int updateIaasIAnswerAction(SuplerCeartIaasIVO vo);
    
    /**
     * insertIaasDsAnswerAction (입찰공고 IaaS 서버 답변 등록)
     * @param vo
     * @return
     */
    int insertIaasDsAnswerAction(SuplerCeartIaasDsVO vo);

    /**
     * deleteIaasDsAnswerAction (입찰공고 IaaS 서버 답변 삭제)
     * @param vo
     * @return
     */
    int deleteIaasDsAnswerAction(SuplerCeartIaasIVO vo);

    /**
     * insertIaasDdAnswerAction (입찰공고 IaaS DB 답변 등록)
     * @param vo
     * @return
     */
    int insertIaasDdAnswerAction(SuplerCeartIaasDdVO vo);

    /**
     * deleteIaasDdAnswerAction (입찰공고 IaaS DB 답변 삭제)
     * @param vo
     * @return
     */
    int deleteIaasDdAnswerAction(SuplerCeartIaasIVO vo);

    /**
     * contractCompleteInfo (공급자 계약관리정보 조회)
     */
    List<SuplerCntrctVO> contractCompleteInfo(SuplerCntrctVO vo);

    /**
     * insertCntrctCmplAction (계약관리정보 등록-계약체결 완료)
     * @param vo
     * @return
     */
    int insertCntrctCmplAction(SuplerCntrctVO vo);

    /**
     * updateCntrctCmplAction (계약관리정보 등록-계약수정)
     * @param vo
     * @return
     */
    int updateCntrctCmplAction(SuplerCntrctVO vo);

    /**
     * bidPartcptnList (입찰참여 현황 목록)
     * @param vo
     * @return
     */
    Pager<SuplerCeartBidPartcptnVO> bidPartcptnList(SuplerCeartBidPartcptnVO vo);

    /**
     * suplySttusList (공급현황 목록)
     * @param vo
     * @return
     */
    Pager<SuplerCeartSuplySttusVO> suplySttusList(SuplerCeartSuplySttusVO vo);

    /**
     * suplySttusListExcel (공급현황 목록(엑셀다운용))
     * @param vo
     * @return
     */
    Pager<SuplerCeartSuplySttusVO> suplySttusListExcel(SuplerCeartSuplySttusVO vo);

    /**
     * suplySttusEndsUserInfo (공급 수요자 정보 조회)
     */
    List<SuplySttusEndsUserVO> suplySttusEndsUserInfo(SuplySttusEndsUserVO vo);

    /**
     * suplySttusHistList (공급자의 수요자에 대한 공급이력)
     * @param vo
     * @return
     */
    List<SuplerCntrctVO> suplySttusHistList(SuplerCntrctVO vo);

    /**
     * totSuplySttusHistList (공급자의 서비스에 대한 총 공급이력)
     * @param vo
     * @return
     */
    Pager<SuplerCntrctVO> totSuplySttusHistList(SuplerCntrctVO vo);
  
   
    /**
     * buyingRequestList (상세정보(사전견적)요청서 목록)
     * @param vo
     * @return
     */
    Pager<SuplerCeartVO> beforeRequestList(SuplerCeartVO vo);

    /**
     * buyingRequestListExcel (상세정보(사전견적)요청서 목록(엑셀다운용))
     * @param vo
     * @return
     */
    Pager<SuplerCeartVO> beforeRequestListExcel(SuplerCeartVO vo);
    
    /**
     * updateSplyConfmGbn (사전견적공고 공급자 확인정보의 확인여부 update)
     * @param vo
     * @return
     */
    int updateBeforeSplyConfmGbn(SuplerCeartBidNotifyVO vo);
    
    /**
     * suplerCeartBeforeNotifyInfo (사전견적공고)
     */
    List<SuplerCeartBidNotifyVO> suplerCeartBeforeNotifyInfo(SuplerCeartBidNotifyVO vo);
    
    /**
     * suplerCeartBeforeNotifySplyInfo (사전공고 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartNotifySplyVO> suplerCeartBeforeNotifySplyInfo(SuplerCeartNotifySplyVO vo);
    
    
    
    /**
     * suplerCeartInfoByPass (상세정보(사전견적)요청서 PaaS)
     * @param vo
     * @return
     */
    List<SuplerCeartPaasVO> suplerCeartBeforeInfoByPass(SuplerCeartPaasVO vo);
    
    /**
     * suplerCeartInfoByPass (상세정보(사전견적)요청서 PaaS2)
     * @param vo
     * @return
     */
    List<SuplerCeartPaas2VO> suplerCeartBeforeInfoByPass2(SuplerCeartPaas2VO vo);

    /**
     * suplerCeartInfoBySassI (상세정보(사전견적)요청서 SaaS I)
     * @param vo
     * @return
     */
    List<SuplerCeartSaasIVO> suplerCeartBeforeInfoBySassI(SuplerCeartSaasIVO vo);

    /**
     * suplerCeartInfoBySass2I (상세정보(사전견적)요청서 SaaS2 I)
     * @param vo
     * @return
     */
    List<SuplerCeartSaas2IVO> suplerCeartBeforeInfoBySass2I(SuplerCeartSaas2IVO vo);

    /**
     * suplerCeartInfoBySassD (상세정보(견적)요청서 SaaS D)
     * @param vo
     * @return
     */
    List<SuplerCeartSaasDVO> suplerCeartBeforeInfoBySassD(SuplerCeartSaasDVO vo);

    /**
     * suplerCeartInfoBySass2Dn (상세정보(견적)요청서 SaaS2 Dn)
     * @param vo
     * @return
     */
    List<SuplerCeartSaas2DnVO> suplerCeartBeforeInfoBySass2Dn(SuplerCeartSaas2DnVO vo);

    /**
     * suplerCeartInfoBySass2Do (상세정보(견적)요청서 SaaS2 Do)
     * @param vo
     * @return
     */
    List<SuplerCeartSaas2DoVO> suplerCeartBeforeInfoBySass2Do(SuplerCeartSaas2DoVO vo);

    /**
     * suplerCeartInfoByIassI (IaaS 마스터 정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaasIVO> suplerCeartBeforeInfoByIassI(SuplerCeartIaasIVO vo);

    /**
     * suplerCeartInfoByIass2I (IaaS2 마스터 정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaas2IVO> suplerCeartBeforeInfoByIass2I(SuplerCeartIaas2IVO vo);
    
    /**
     * suplerCeartInfoByIassDs (IaaS 서버문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaasDsVO> suplerCeartBeforeInfoByIassDs(SuplerCeartIaasDsVO vo);
    
    /**
     * suplerCeartInfoByIass2Ds (Iaa2S 서버문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaas2DsVO> suplerCeartBeforeInfoByIass2Ds(SuplerCeartIaas2DsVO vo);
    
    /**
     * suplerCeartInfoByIassDs (IaaS DB문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaasDdVO> suplerCeartBeforeInfoByIassDd(SuplerCeartIaasDdVO vo);
    
    /**
     * suplerCeartInfoByIass2Ds (Iaa2S DB문의 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartIaas2DdVO> suplerCeartBeforeInfoByIass2Dd(SuplerCeartIaas2DdVO vo);
    
    /**
     * suplerCeartBeforeInfoByScs2 (상세정보(사전견적)요청서 ScsS)
     * @param vo
     * @return
     */
    List<SuplerCeartScs2VO> suplerCeartBeforeInfoByScs2(SuplerCeartScs2VO vo); 
    
    /**
     * updateBeforeNotifySplyAction (사전공고 공급자 확인정보 등록)
     * @param vo
     * @return
     */
    int updateBeforeNotifySplyAction(SuplerCeartNotifySplyVO vo);
    
    
    /**
     * insertBeforePaasAnswerAction (사전공고 PaaS 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforePaasAnswerAction(SuplerCeartPaasVO vo);
    
    /**
     * insertBeforePaas2AnswerAction (사전공고 PaaS2 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforePaas2AnswerAction(SuplerCeartPaas2VO vo);

    /**
     * updateBeforePaasAnswerAction (사전공고 PaaS 답변 수정)
     * @param vo
     * @return
     */
    int updateBeforePaasAnswerAction(SuplerCeartPaasVO vo);

    /**
     * insertBeforeSaasIAnswerAction (사전공고 SaaS 마스터 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaasIAnswerAction(SuplerCeartSaasIVO vo);

    /**
     * insertBeforeSaas2IAnswerAction (사전공고 SaaS2 마스터 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaas2IAnswerAction(SuplerCeartSaas2IVO vo);

    /**
     * updateBeforeSaasIAnswerAction (사전공고 SaaS 마스터 답변 수정)
     * @param vo
     * @return
     */
    int updateBeforeSaasIAnswerAction(SuplerCeartSaasIVO vo);

    /**
     * insertBeforeSaasDAnswerAction (사전공고 SaaS 상세 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaasDAnswerAction(SuplerCeartSaasDVO vo);

    /**
     * insertBeforeSaas2NeedAnswerAction (사전공고 SaaS2 상세필요 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaas2NeedAnswerAction(int i, SuplerCeartSaas2DnVO vo);

    /**
     * selectBeforeSaas2NeedSeq (사전공고 SaaS2 상세필요 Seq)
     * @param vo
     * @return
     */
    int selectBeforeSaas2NeedSeq(SuplerCeartSaas2DnVO vo);

    /**
     * insertBeforeSaas2OptionActionn (사전공고 SaaS2 상세옵션 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaas2OptionAnswerAction(int i, int j,SuplerCeartSaas2DoVO vo);

    /**
     * deleteBeforeSaasDAnswerAction (사전공고 SaaS 상세 답변 삭제)
     * @param vo
     * @return
     */
    int deleteBeforeSaasDAnswerAction(SuplerCeartSaasIVO vo);

    /**
     * insertBeforeIaasIAnswerAction (사전공고 IaaS 마스터 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaasIAnswerAction(SuplerCeartIaasIVO vo);

    /**
     * insertBeforeIaas2IAnswerAction (사전공고 IaaS2 마스터 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaas2IAnswerAction(SuplerCeartIaas2IVO vo);

    /**
     * updateBeforeIaasIAnswerAction (사전공고 IaaS 마스터 답변 수정)
     * @param vo
     * @return
     */
    int updateBeforeIaasIAnswerAction(SuplerCeartIaasIVO vo);
    
    /**
     * insertBeforeIaasDsAnswerAction (사전공고 IaaS 서버 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaasDsAnswerAction(SuplerCeartIaasDsVO vo);
    
    /**
     * insertBeforeIaas2DsAnswerAction (사전공고 IaaS2 서버 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaas2DsAnswerAction(int i, SuplerCeartIaas2DsVO vo);

    /**
     * deleteBeforeIaasDsAnswerAction (사전공고 IaaS 서버 답변 삭제)
     * @param vo
     * @return
     */
    int deleteBeforeIaasDsAnswerAction(SuplerCeartIaasIVO vo);

    /**
     * insertBeforeIaasDdAnswerAction (사전공고 IaaS DB 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaasDdAnswerAction(SuplerCeartIaasDdVO vo);

    /**
     * insertBeforeIaas2DdAnswerAction (사전공고 IaaS2 DB 답변 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaas2DdAnswerAction(int i, SuplerCeartIaas2DdVO vo);
    
    /**
     * insertBeforeScs2AnswerAction 설명
     * @param scsVO
     */
    int insertBeforeScs2AnswerAction(SuplerCeartScs2VO vo);

    /**
     * deleteBeforeIaasDdAnswerAction (사전공고 IaaS DB 답변 삭제)
     * @param vo
     * @return
     */
    int deleteBeforeIaasDdAnswerAction(SuplerCeartIaasIVO vo);
    
    
    /**
     * buyUserList (구매자선택 팝업)
     * @param vo
     * @return
     */
    Pager<SuplerServiceVO> buyUserList(SuplerServiceVO vo);
    
    
    SuplerServiceVO buyUserInfo(String supplyId);
    
    /**
     * cntrctDtlInfo (계약서 등록 데이터 조회)
     * @param vo
     * @return
     */
    List<SuplerCntrctVO> cntrctDtlInfo(SuplerCntrctVO vo);
    
    SuplerCntrctVO cntrctDetail(SuplerCntrctVO vo);
    
    /**
     * updateCntrctCmpl (계약결과 수정)
     * @param vo
     * @return
     */
    int updateCntrctCmpl(SuplerCntrctVO vo);
    
    /**
     * insertCntrctCmpl (계약결과 등록)
     * @param vo
     * @return
     */
    int insertCntrctCmpl(SuplerCntrctVO vo);
    
    List<SuplerCntrctGoodsVO> cntrctDtlGoodsList(SuplerCntrctVO vo);

    
}
