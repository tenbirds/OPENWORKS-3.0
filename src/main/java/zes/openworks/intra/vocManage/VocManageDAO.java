/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.vocManage;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.vocManage.VocManageVO;


/**
 *
 *
 * @version 1.0
 * @since
 * @author
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 10. 23.   이준범   신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class VocManageDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * VOC 목록
     * @param vo
     * @return
     */
    public List<VocManageVO> vocManageList(VocManageVO vo) {
        //vo.setTotalNum((Integer) selectByPk("vocManage.vocManageCount", vo.getDataMap()));
        return list("vocManage.vocManageList", vo.getDataMap());
    }
    
    /**
     * VOC 상세정보
     * @param vo
     * @return
     */
    public List<VocManageVO> vocManageView(VocManageVO vo) {
        // 상세정보는 1개만 가져옴
        return list("vocManage.vocManageView", vo.getDataMap());
    }
}
