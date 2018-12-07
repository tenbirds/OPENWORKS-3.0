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

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.openworks.component.file.FileDAO;


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
@SuppressWarnings("unchecked")
public class BeforeDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * selectBeforeNotifySeqAction (입찰공고정보 공고차수 채번)
     * @param tcnBeforeNotifyVO
     * @return int
     */
    public int selectBeforeEsteNotifySeqAction(TcnBeforeNotifyVO tcnBeforeNotifyVO) {
        return (Integer) selectByPk("_before.selectBeforeEsteNotifySeq", tcnBeforeNotifyVO);
    }


    /**
     * insertBeforeNotifyAction (입찰공고정보 등록)
     * @param tcnBeforeNotifyVO
     * @return int
     */
    public int insertBeforeEsteNotifyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO) {
        // 첨부파일
        if(tcnBeforeNotifyVO.getDelyFileList() != null && tcnBeforeNotifyVO.getDelyFileList().size() > 0) {
            tcnBeforeNotifyVO.setDelyFile(fileDao.saveFile(tcnBeforeNotifyVO.getDelyFileList(), tcnBeforeNotifyVO.getDelyFile()));
        }
        
        return insert("_before.insertBeforeEsteNotify", tcnBeforeNotifyVO);
    }

    /**
     * updateBeforeEsteNotifyAction (입찰공고정보 수정)
     * @param tcnBeforeNotifyVO
     * @return int
     */
    public int updateBeforeEsteNotifyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO) {
        // 첨부파일 - 납품 첨부 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(tcnBeforeNotifyVO.getDelyFileList() != null && tcnBeforeNotifyVO.getDelyFileList().size() > 0) {
            if(tcnBeforeNotifyVO.getDelyFile() == 0){
                tcnBeforeNotifyVO.setDelyFile(fileDao.saveFile(tcnBeforeNotifyVO.getDelyFileList(), tcnBeforeNotifyVO.getDelyFile()));
            }
        }

        return update("_before.updateBeforeEsteNotify", tcnBeforeNotifyVO);
    }

    /**
     * insertNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * @param tcnBeforeNotifyVO
     * @return int
     */
    public int insertNotifySplyAction(TcnBeforeNotifyVO tcnBeforeNotifyVO) {
        return insert("_before.insertNotifySply", tcnBeforeNotifyVO);
    }

    /**
     * insertBeforeSaasAction (입찰공고 SaaS 정보 등록)
     * @param beforeSaasInfoVO
     * @return int
     */
    public int insertBeforeSaasAction(BeforeSaasInfoVO beforeSaasInfoVO) {
        return insert("_before.insertBeforeSaas", beforeSaasInfoVO);
    }

    /**
     * insertBeforeSaas2Action (입찰공고 SaaS2 정보 등록)
     * @param beforeSaas2InfoVO
     * @return int
     */
    public int insertBeforeSaas2Action(BeforeSaas2InfoVO beforeSaas2InfoVO) {
        return insert("_before.insertBeforeSaas2", beforeSaas2InfoVO);
    }

    /**
     * updateBeforeSaasAction (입찰공고 SaaS 정보 수정)
     * @param beforeSaasInfoVO
     * @return int
     */
    public int updateBeforeSaasAction(BeforeSaasInfoVO beforeSaasInfoVO) {
        return update("_before.updateBeforeSaas", beforeSaasInfoVO);
    }

    /**
     * deleteBeforeSaasDetailAction (입찰공고 SaaS 정보 삭제)
     * @param beforeSaasInfoVO
     * @return int
     */
    public int deleteBeforeSaasDetailAction(BeforeSaasInfoVO beforeSaasInfoVO) {
        return update("_before.deleteBeforeSaasDetail", beforeSaasInfoVO);
    }

    /**
     * insertBeforeSaasDetailAction (입찰공고 SaaS 상세정보 등록)
     * @param HashMap
     * @return int
     */
    public int insertBeforeSaasDetailAction(HashMap<String, Object> map) {
        return insert("_before.insertBeforeSaasDetail", map);
    }
    
    /**
     * insertBeforeSaas2NeedAction (입찰공고 SaaS2 필요정보 등록)
     * @param paramMap1
     * @return
     */
    public int insertBeforeSaas2NeedAction(int i,HashMap<String, Object> paramMap1) 
    {
        if  (i==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_before.updateBeforeSaas2Need", paramMap1);
        }
        return insert("_before.insertBeforeSaas2Need", paramMap1);
    }

    /**
     * selectBeforeSaas2NeedSeq (입찰공고 SaaS2 필요정보 Seq)
     * @param paramMap1
     * @return
     */
    public int selectBeforeSaas2NeedSeq(HashMap<String, Object> paramMap1) {
        return (Integer) selectByPk("_before.selectBeforeSaas2NeedSeq", paramMap1);
    }

    /**
     * insertBeforeSaas2OptionAction (입찰공고 SaaS2 옵션정보 등록)
     * @param paramMap2
     * @return
     */
    public int insertBeforeSaas2OptionAction(int i,int j,HashMap<String, Object> paramMap2) 
    {
        if  (i==0 && j==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_before.updateBeforeSaas2Option", paramMap2);
        }
        return insert("_before.insertBeforeSaas2Option", paramMap2);
    }

    /**
     * insertBeforeIaasAction (입찰공고 IaaS 정보 등록)
     * @param beforeIaasInfoVO
     * @return int
     */
    public int insertBeforeIaasAction(BeforeIaasInfoVO beforeIaasInfoVO) {
        return insert("_before.insertBeforeIaas", beforeIaasInfoVO);
    }

    /**
     * insertBeforeIaas2Action (입찰공고 IaaS2 정보 등록)
     * @param beforeIaas2InfoVO
     * @return int
     */
    public int insertBeforeIaas2Action(BeforeIaas2InfoVO beforeIaas2InfoVO) {
        return insert("_before.insertBeforeIaas2", beforeIaas2InfoVO);
    }

    /**
     * updateBeforeIaasAction (입찰공고 IaaS 정보 수정)
     * @param beforeIaasInfoVO
     * @return int
     */
    public int updateBeforeIaasAction(BeforeIaasInfoVO beforeIaasInfoVO) {
        return insert("_before.updateBeforeIaas", beforeIaasInfoVO);
    }

    /**
     * insertBeforeIaasServerAction (입찰공고 IaaS 상세정보(서버) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBeforeIaasServerAction(HashMap<String, Object> map) {
        return insert("_before.insertBeforeIaasServer", map);
    }

    /**
     * insertBeforeIaas2ServerAction (입찰공고 IaaS2 상세정보(서버) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBeforeIaas2ServerAction(int i,HashMap<String, Object> map) 
    {
        if  (i==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_before.updateBeforeIaas2Ds", map);
        }
        return insert("_before.insertBeforeIaas2Ds", map);
    }

    /**
     * deleteBeforeIaasServerAction (입찰공고 IaaS 상세정보(서버) 삭제)
     * @param HashMap
     * @return int
     */
    public int deleteBeforeIaasServerAction(HashMap<String, Object> map) {
        return update("_before.deleteBeforeIaasServer", map);
    }

    /**
     * insertBeforeIaasDbAction (입찰공고 IaaS 상세정보(DB) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBeforeIaasDbAction(HashMap<String, Object> map) {
        return insert("_before.insertBeforeIaasDb", map);
    }

    /**
     * insertBeforeIaas2DdAction (입찰공고 IaaS2 상세정보(DB) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBeforeIaas2DdAction(int i,HashMap<String, Object> map) 
    {
        if  (i==0) // 첫번째일경우는 대표값을 설정한다.
        {
            update("_before.updateBeforeIaas2Dd", map);
        }
        return insert("_before.insertBeforeIaas2Dd", map);
    }

    /**
     * deleteBeforeIaasDbAction (입찰공고 IaaS 상세정보(DB) 삭제)
     * @param HashMap
     * @return int
     */
    public int deleteBeforeIaasDbAction(HashMap<String, Object> map) {
        return update("_before.deleteBeforeIaasDb", map);
    }

    /**
     * insertBeforePaasAction (입찰공고 PaaS 정보 등록)
     * @param beforePaasInfoVO
     * @return int
     */
    public int insertBeforePaasAction(BeforePaasInfoVO beforePaasInfoVO) {
        return insert("_before.insertBeforePaas", beforePaasInfoVO);
    }

    /**
     * insertBeforePaas2Action (입찰공고 PaaS2 정보 등록)
     * @param beforePaasInfoVO
     * @return int
     */
    public int insertBeforePaas2Action(BeforePaas2InfoVO beforePaas2InfoVO) {
        return insert("_before.insertBeforePaas2", beforePaas2InfoVO);
    }

    /**
     * updateBeforePaasAction (입찰공고 PaaS 정보 수정)
     * @param beforePaasInfoVO
     * @return int
     */
    public int updateBeforePaasAction(BeforePaasInfoVO beforePaasInfoVO) {
        return insert("_before.updateBeforePaas", beforePaasInfoVO);
    }

    /**
     * insertBeforeScs2Action 설명
     * @param beforeScs2InfoVO
     * @return
     */
    public int insertBeforeScs2Action(BeforeScs2InfoVO beforeScs2InfoVO) {
        return insert("_before.insertBeforeScs2", beforeScs2InfoVO);
    }

    /**
     * selectSuplerList (공고현황 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    public List<BeforeSuplerListVO> selectSuplerList(BeforeSuplerListVO vo) {
        return list("_before.selectSuplerList", vo);
    }


    
}
