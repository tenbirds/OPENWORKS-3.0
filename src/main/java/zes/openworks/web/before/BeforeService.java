/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.before;

import java.util.HashMap;
import java.util.List;


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
public interface BeforeService {

    /**
     * selectBeforeEsteNotifySeqAction (입찰공고정보 공고차수 채번)
     * @param vo
     * @return
     */
    int selectBeforeEsteNotifySeqAction(TcnBeforeNotifyVO tcnBeforeNotifyVO);
    
    /**
     * insertBeforeNotifyAction (입찰공고정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeEsteNotifyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO);

    /**
     * updateBeforeNotifyAction (입찰공고정보 수정)
     * @param vo
     * @return
     */
    int updateBeforeEsteNotifyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO);

    /**
     * insertNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * @param vo
     * @return
     */
    int insertNotifySplyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO);

    /**
     * insertBeforeSaasAction (입찰공고 SaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaasAction(BeforeSaasInfoVO beforeSaasInfoVO);

    /**
     * insertBeforeSaas2Action (입찰공고 SaaS2 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaas2Action(BeforeSaas2InfoVO beforeSaas2InfoVO);

    /**
     * updateBeforeSaasAction (입찰공고 SaaS 정보 수정)
     * @param vo
     * @return
     */
    int updateBeforeSaasAction(BeforeSaasInfoVO beforeSaasInfoVO);

    /**
     * deleteBeforeSaasDetailAction (입찰공고 SaaS 정보 삭제)
     * @param vo
     * @return
     */
    int deleteBeforeSaasDetailAction(BeforeSaasInfoVO beforeSaasInfoVO);
    
    /**
     * insertBeforeSaasDetailAction (입찰공고 SaaS 상세정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeSaasDetailAction(HashMap<String, Object> map);
    
    /**
     * insertBeforeSaas2NeedAction (입찰공고 SaaS2 필요정보 등록)
     * @param paramMap1
     */
    int insertBeforeSaas2NeedAction(int i,HashMap<String, Object> paramMap1);
    
    /**
     * selectBeforeSaas2DnSeq (입찰공고 SaaS2 필요정보 Seq)
     * @param paramMap1
     * @return
     */
    int selectBeforeSaas2NeedSeq(HashMap<String, Object> paramMap1);

    /**
     * insertBeforeSaas2OptionAction  (입찰공고 SaaS2 옵션정보 등록)
     * @param paramMap2
     */
    int insertBeforeSaas2OptionAction(int i,int j,HashMap<String, Object> paramMap2);    

    /**
     * insertBeforeIaasAction (입찰공고 IaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaasAction(BeforeIaasInfoVO beforeIaasInfoVO);

    /**
     * insertBeforeIaas2Action (입찰공고 IaaS2 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaas2Action(BeforeIaas2InfoVO beforeIaas2InfoVO);

    /**
     * updateBeforeIaasAction (입찰공고 IaaS 정보 수정)
     * @param vo
     * @return
     */
    int updateBeforeIaasAction(BeforeIaasInfoVO beforeIaasInfoVO);

    /**
     * insertBeforeIaasServerAction (입찰공고 IaaS 상세정보(서버) 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaasServerAction(HashMap<String, Object> map);

    /**
     * insertBeforeIaasServerAction (입찰공고 IaaS2 상세정보(서버) 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaas2ServerAction(int i, HashMap<String, Object> map);

    /**
     * deleteBeforeIaasServerAction (입찰공고 IaaS 상세정보(서버) 삭제)
     * @param vo
     * @return
     */
    int deleteBeforeIaasServerAction(HashMap<String, Object> map);
    
    /**
     * insertBeforeIaasDbAction (입찰공고 IaaS 상세정보(DB) 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaasDbAction(HashMap<String, Object> map);
    
    /**
     * insertBeforeIaas2DdAction (입찰공고 IaaS 상세정보(DB) 등록)
     * @param vo
     * @return
     */
    int insertBeforeIaas2DdAction(int i, HashMap<String, Object> map);

    /**
     * deleteBeforeIaasDbAction (입찰공고 IaaS 상세정보(DB) 삭제)
     * @param vo
     * @return
     */
    int deleteBeforeIaasDbAction(HashMap<String, Object> map);

    /**
     * insertBeforePaasAction (입찰공고 PaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforePaasAction(BeforePaasInfoVO beforePaasInfoVO);


    /**
     * insertBeforePaasAction (입찰공고 PaaS2 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforePaas2Action(BeforePaas2InfoVO beforePaasInfoVO);

    /**
     * updateBeforePaasAction (입찰공고 PaaS 정보 수정)
     * @param vo
     * @return
     */
    int updateBeforePaasAction(BeforePaasInfoVO beforePaasInfoVO);


    /**
     * insertBeforeScsAction (입찰공고 Scs2 정보 등록)
     * @param vo
     * @return
     */
    int insertBeforeScs2Action(BeforeScs2InfoVO beforeScs2InfoVO);
    
    /**
     * selectSuplerList (공고현황 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<BeforeSuplerListVO> selectSuplerList(BeforeSuplerListVO vo);

    

    
}
