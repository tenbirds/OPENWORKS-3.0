/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandManage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.openworks.web.dmandExamin.DmandExaminVO;


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
* 2017. 09. 07.   손은국   신규
*</pre>
* @see
*/

@Service("DmandManageService")
public class DmandManageServiceImpl extends AbstractServiceImpl implements DmandManageService {

    @Resource DmandManageDAO dao;

    /* 수요조사 목록
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<DmandManageVO> dmandManageList(DmandManageVO vo) {
        return dao.dmandManageList(vo);
    }
    @Override
    public Pager<DmandManageVO> dmandManageList2018(DmandManageVO vo) {
        return dao.dmandManageList2018(vo);
    }

    /* 제출현황 목록
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<DmandManageVO> dmandPresentnList(DmandManageVO vo) {
        return dao.dmandPresentnList(vo);
    }
    @Override
    public Pager<DmandManageVO> dmandPresentnList2018(DmandManageVO vo) {
        return dao.dmandPresentnList2018(vo);
    }

    /* 제출현황 목록
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public List<DmandManageVO> dmandPresentnUnsubMission(DmandManageVO vo) {
        return dao.dmandPresentnUnsubMission(vo);
    }
    @Override
    public List<DmandManageVO> dmandPresentnUnsubMission2018(DmandManageVO vo) {
        return dao.dmandPresentnUnsubMission2018(vo);
    }

    /* 수요조사 통계(요약) 목록
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<DmandManageVO> dmandStatsList(DmandManageVO vo) {
        return dao.dmandStatsList(vo);
    }
    /* 수요조사 통계(기관유형) 목록
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<DmandManageVO> dmandNsttList(DmandManageVO vo) {
        return dao.dmandNsttList(vo);
    }
    
    /* 제출현황 전체 갯수 부분
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public List<DmandManageVO> presentnTotalCount(DmandManageVO vo) {
        return dao.presentnTotalCount(vo);
    }
    @Override
    public List<DmandManageVO> presentnTotalCount2018(DmandManageVO vo) {
        return dao.presentnTotalCount2018(vo);
    }

    /* 수요조사 기간 
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public List<DmandManageVO> dmandRegustMngr(DmandManageVO vo) {
        return dao.dmandRegustMngr(vo);
    }

}
