/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.bassDegreeManage;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.bassAgremManage.BassAgremManageVO;
import zes.openworks.intra.user.UserVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 3.    방기배       신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class BassDegreeManageDAO extends EgovAbstractMapper{
    @Resource
    private FileDAO fileDao;

    /**
     * bassAgremManageList (기본협약관리 목록)
     * @param vo
     * @return
     */
    public Pager<BassDegreeManageVO> bassDegreeManageList(BassDegreeManageVO vo) {
  
        List<BassDegreeManageVO> dataList = list("_bassDegreeManage.bassDegreeManageList", vo.getDataMap());
        
        vo.setTotalNum((Integer) selectByPk("_bassDegreeManage.bassDegreeManageListCount", vo.getDataMap()));
      
        return new Pager<BassDegreeManageVO>(dataList, vo);
    }
    
    /**
     * bassDegreeManageUpdate (기본협약관리 Insert)
     * @param vo
     * @return
     */
    public int bassDegreeManageInsert(BassDegreeManageVO vo) {
        return update("_bassDegreeManage.bassDegreeManageInsert", vo) ;
    }
    
    /**
     * bassDegreeManageUpdate (기본협약관리 Delete)
     * @param vo
     * @return
     */
    public int bassDegreeManageDelete(BassDegreeManageVO vo) {
        return update("_bassDegreeManage.bassDegreeManageDelete", vo) ;
    }
    
    /**
     * bassDegreeManageUpdate (기본협약관리 Update)
     * @param vo
     * @return
     */
    public int bassDegreeManageUpdate(BassDegreeManageVO vo) {
        return update("_bassDegreeManage.bassDegreeManageUpdate", vo) ;
    }
}
