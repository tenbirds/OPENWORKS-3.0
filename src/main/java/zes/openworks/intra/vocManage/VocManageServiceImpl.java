/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.vocManage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
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

@Service("VocManageService")
public class VocManageServiceImpl extends AbstractServiceImpl implements VocManageService {

    @Resource VocManageDAO dao;

    /* voc 목록
     * @see zes.openworks.intra.vocManage.VocManageService#vocManageList(zes.openworks.intra.vocManage.VocManageVO)
     */
    @Override
    public List<VocManageVO> vocManageList(VocManageVO vo) {
        return dao.vocManageList(vo);
    }
    
    /* voc 상세정보
     * @see zes.openworks.intra.vocManage.VocManageService#vocManageDetail(zes.openworks.intra.vocManage.VocManageVO)
     */
    @Override
    public List<VocManageVO> vocManageView(VocManageVO vo) {
        return dao.vocManageView(vo);
    }
}
