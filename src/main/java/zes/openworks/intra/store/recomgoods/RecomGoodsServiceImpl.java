/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.recomgoods;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 10. 21.   김병욱       신규
 * </pre>
 * @see
 */
@Service("RecomGoodsService")
public class RecomGoodsServiceImpl extends AbstractServiceImpl implements RecomGoodsService {

    @Resource
    private RecomGoodsDAO dao;

    @Resource
    private FileDAO fileDao;

    @Override
    public Pager<RecomGoodsVO> recomGoodsList(RecomGoodsVO vo) {
        return dao.recomGoodsList(vo);
    }

    @Override
    public Pager<RecomGoodsVO> recomGoodsList2(RecomGoodsVO vo) {
        return dao.recomGoodsList2(vo);
    }

    @Override
    public int recomGoodsInsert(RecomGoodsVO vo, boolean recomApply) {
        return dao.recomGoodsInsert(vo, recomApply);
    }

    @Override
    public int recomGoodsInsert2(RecomGoodsVO vo, boolean recomApply) {
        return dao.recomGoodsInsert2(vo, recomApply);
    }

    @Override
    public int recomGoodsDelete(RecomGoodsVO vo) {
        return dao.recomGoodsDelete(vo);
    }

    @Override
    public Pager<RecomGoodsVO> goodsList(RecomGoodsVO vo) {
        return dao.goodsList(vo);
    }

    @Override
    public List<GoodsManageVO> langList(GoodsManageVO vo) {
        return dao.langList(vo);
    }

    @Override
    public List<GoodsManageVO> ctgryList(GoodsManageVO vo) {
        return dao.ctgryList(vo);
    }

}
