/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.goods.evl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.code.CodeVO;
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
 * 2014. 11. 25.    이슬버미       신규
 *</pre>
 * @see
 */
@Service
public class GoodsEvlServiceImpl extends AbstractServiceImpl implements GoodsEvlService {

    @Resource GoodsEvlDAO dao;
    
    public Pager<GoodsEvlVO> evlList(GoodsEvlVO vo) {
        return dao.evlList(vo);
    }

    
    public List<CodeVO> langList() {
        return dao.langList();
    }

    
    public List<GoodsEvlVO> ctgryList(GoodsEvlVO vo) {
        return dao.ctgryList(vo);
    }

    public int deleteAction(GoodsEvlVO vo) {
        return dao.deleteAction(vo);
    }
    
 
}
