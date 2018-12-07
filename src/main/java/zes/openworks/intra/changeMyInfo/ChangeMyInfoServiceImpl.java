/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.changeMyInfo;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import zes.openworks.intra.mgr.MgrVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 10.    김영상       신규
 *</pre>
 * @see
 */

@Service("changeMyInfoService")
public class ChangeMyInfoServiceImpl extends AbstractServiceImpl implements ChangeMyInfoService {

    @Resource
    private ChangeMyInfoDAO dao;

    @Override
    public MgrVO viewMyInfo(MgrVO vo) {
        return dao.viewMyInfo(vo);
    }

    @Override
    public int updateMyInfo(MgrVO vo) {
        return dao.updateMyInfo(vo);
    }

    @Override
    public int updateMyPwd(MgrVO vo) {
        return dao.updateMyPwd(vo);
    }
    
    @Override
    public List<MgrVO> currentlyList(MgrVO vo) {
        return dao.currentlyList(vo);
    }
}
