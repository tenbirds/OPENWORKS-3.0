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

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


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
@Service("BeforeService")
public class BeforeServiceImpl extends AbstractServiceImpl implements BeforeService {

    @Resource BeforeDAO dao;

    /* (입찰공고정보 공고차수 채번)
     * @see zes.openworks.web.before.BeforeService##selectBeforeNotifySeqAction(zes.openworks.web.before.TcnBeforeNotifyVO)
     */
    @Override
    public int selectBeforeEsteNotifySeqAction(TcnBeforeNotifyVO tcnBeforeNotifyVO){
        return dao.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
    }

    /* (입찰공고정보 등록)
     * @see zes.openworks.web.before.BeforeService#insertBeforeNotifyAction(zes.openworks.web.before.TcnBeforeNotifyVO)
     */
    @Override
    public int insertBeforeEsteNotifyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO){
        return dao.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);
    }

    /* (입찰공고정보 수정)
     * @see zes.openworks.web.before.BeforeService#updateBeforeEsteNotifyAction(zes.openworks.web.before.TcnBeforeNotifyVO)
     */
    @Override
    public int updateBeforeEsteNotifyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO){
        return dao.updateBeforeEsteNotifyAction(tcnBeforeNotifyVO);
    }

    /* (입찰공고 공급자 확인정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeNotifyAction(zes.openworks.web.before.TcnBeforeNotifyVO)
     */
    @Override
    public int insertNotifySplyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO){
        return dao.insertNotifySplyAction(tcnBeforeNotifyVO);
    }

    /* (입찰공고 SaaS 정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeSaas(zes.openworks.web.before.BeforeSaasInfoVO)
     */
    @Override
    public int insertBeforeSaasAction(BeforeSaasInfoVO beforeSaasInfoVO){
        return dao.insertBeforeSaasAction(beforeSaasInfoVO);
    }

    /* (입찰공고 SaaS2 정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeSaas(zes.openworks.web.before.BeforeSaasInfoVO)
     */
    @Override
    public int insertBeforeSaas2Action(BeforeSaas2InfoVO beforeSaas2InfoVO){
        return dao.insertBeforeSaas2Action(beforeSaas2InfoVO);
    }

    /* (입찰공고 SaaS 정보 수정)
     * @see zes.openworks.web.before.BeforeService##updateBeforeSaasAction(zes.openworks.web.before.BeforeSaasInfoVO)
     */
    @Override
    public int updateBeforeSaasAction(BeforeSaasInfoVO beforeSaasInfoVO){
        return dao.updateBeforeSaasAction(beforeSaasInfoVO);
    }

    /* (입찰공고 SaaS 정보 삭제)
     * @see zes.openworks.web.before.BeforeService##deleteBeforeSaasDetailAction(zes.openworks.web.before.BeforeSaasInfoVO)
     */
    @Override
    public int deleteBeforeSaasDetailAction(BeforeSaasInfoVO beforeSaasInfoVO){
        return dao.deleteBeforeSaasDetailAction(beforeSaasInfoVO);
    }

    /* (입찰공고 SaaS 상세정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeSaasDetailAction(HashMap)
     */
    @Override
    public int insertBeforeSaasDetailAction(HashMap<String, Object> map){
        return dao.insertBeforeSaasDetailAction(map);
    }
    
    /* insertBeforeSaas2NeedAction (입찰공고 SaaS2 필요정보 등록)
     * @see zes.openworks.web.before.BeforeService#insertBeforeSaas2NeedAction(java.util.HashMap)
     */
    @Override
    public int insertBeforeSaas2NeedAction(int i,HashMap<String, Object> paramMap1) {
        return dao.insertBeforeSaas2NeedAction(i,paramMap1);        
    }
    
    /* selectBeforeSaas2NeedSeq (입찰공고 SaaS2 필요정보 Seq)
     * @see zes.openworks.web.before.BeforeService#selectBeforeSaas2DnSeq(java.util.HashMap)
     */
    @Override
    public int selectBeforeSaas2NeedSeq(HashMap<String, Object> paramMap1) {
        return dao.selectBeforeSaas2NeedSeq(paramMap1);
    }

    /* insertBeforeSaas2OptionAction (입찰공고 SaaS2 옵션정보 등록)
     * @see zes.openworks.web.before.BeforeService#insertBeforeSaas2OptionAction(java.util.HashMap)
     */
    @Override
    public int insertBeforeSaas2OptionAction(int i,int j,HashMap<String, Object> paramMap2) {
        return dao.insertBeforeSaas2OptionAction(i,j,paramMap2);        
    }
    
    /* (입찰공고 IaaS 정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeIaasAction(zes.openworks.web.before.BeforeIaasInfoVO)
     */
    @Override
    public int insertBeforeIaasAction(BeforeIaasInfoVO beforeIaasInfoVO){
        return dao.insertBeforeIaasAction(beforeIaasInfoVO);
    }
    
    /* (입찰공고 IaaS2 정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeIaas2Action(zes.openworks.web.before.BeforeIaas2InfoVO)
     */
    @Override
    public int insertBeforeIaas2Action(BeforeIaas2InfoVO beforeIaas2InfoVO){
        return dao.insertBeforeIaas2Action(beforeIaas2InfoVO);
    }

    /* (입찰공고 IaaS 정보 수정)
     * @see zes.openworks.web.before.BeforeService##updateBeforeIaasAction(zes.openworks.web.before.BeforeIaasInfoVO)
     */
    @Override
    public int updateBeforeIaasAction(BeforeIaasInfoVO beforeIaasInfoVO){
        return dao.updateBeforeIaasAction(beforeIaasInfoVO);
    }

    /* (입찰공고 IaaS 상세정보(서버) 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeIaasServerAction(HashMap)
     */
    @Override
    public int insertBeforeIaasServerAction(HashMap<String, Object> map){
        return dao.insertBeforeIaasServerAction(map);
    }

    /* (입찰공고 IaaS2 상세정보(서버) 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeIaas2ServerAction(HashMap)
     */
    @Override
    public int insertBeforeIaas2ServerAction(int i,HashMap<String, Object> map){
        return dao.insertBeforeIaas2ServerAction(i,map);
    }

    /* (입찰공고 IaaS 상세정보(서버) 삭제)
     * @see zes.openworks.web.before.BeforeService##deleteBeforeIaasServerAction(HashMap)
     */
    @Override
    public int deleteBeforeIaasServerAction(HashMap<String, Object> map){
        return dao.deleteBeforeIaasServerAction(map);
    }

    /* (입찰공고 IaaS 상세정보(DB) 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeIaasDbAction(HashMap)
     */
    @Override
    public int insertBeforeIaasDbAction(HashMap<String, Object> map){
        return dao.insertBeforeIaasDbAction(map);
    }

    /* (입찰공고 IaaS2 상세정보(DB) 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforeIaas2DdAction(HashMap)
     */
    @Override
    public int insertBeforeIaas2DdAction(int i,HashMap<String, Object> map){
        return dao.insertBeforeIaas2DdAction(i,map);
    }

    /* (입찰공고 IaaS 상세정보(DB) 삭제)
     * @see zes.openworks.web.before.BeforeService##deleteBeforeIaasDbAction(HashMap)
     */
    @Override
    public int deleteBeforeIaasDbAction(HashMap<String, Object> map){
        return dao.deleteBeforeIaasDbAction(map);
    }

    /* (입찰공고 PaaS 정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforePaasAction(zes.openworks.web.before.BeforePaasInfoVO)
     */
    @Override
    public int insertBeforePaasAction(BeforePaasInfoVO beforePaasInfoVO){
        return dao.insertBeforePaasAction(beforePaasInfoVO);
    }

    /* (입찰공고 PaaS2 정보 등록)
     * @see zes.openworks.web.before.BeforeService##insertBeforePaas2Action(zes.openworks.web.before.BeforePaasInfoVO)
     */
    @Override
    public int insertBeforePaas2Action(BeforePaas2InfoVO beforePaas2InfoVO){
        return dao.insertBeforePaas2Action(beforePaas2InfoVO);
    }

    /* (입찰공고 PaaS 정보 수정)
     * @see zes.openworks.web.before.BeforeService##updateBeforePaasAction(zes.openworks.web.before.BeforePaasInfoVO)
     */
    @Override
    public int updateBeforePaasAction(BeforePaasInfoVO beforePaasInfoVO){
        return dao.updateBeforePaasAction(beforePaasInfoVO);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.before.BeforeService#insertBeforeScs2Action(zes.openworks.web.before.BeforeScs2InfoVO)
     */
    @Override
    public int insertBeforeScs2Action(BeforeScs2InfoVO beforeScs2InfoVO) {
        return dao.insertBeforeScs2Action(beforeScs2InfoVO);
    }
    
    /**
     * (공고현황 공급자 확인정보 조회)
     * @see zes.openworks.web.before.BeforeService#selectSuplerList(zes.openworks.web.before.BeforeSuplerListVO)
     */
    @Override
    public List<BeforeSuplerListVO> selectSuplerList(BeforeSuplerListVO vo) {

        return dao.selectSuplerList(vo);
    }

}
