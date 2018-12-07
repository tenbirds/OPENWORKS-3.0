/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.suppost.qna;

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
 * 2014. 11. 14.    이슬버미       신규
 *</pre>
 * @see
 */
@Service
public class WebGoodsQnAServiceImpl  extends AbstractServiceImpl implements WebGoodsQnAService {

    @Resource WebGoodsQnADAO dao;

    /* (문의 목록)
     * @see zes.openworks.web.sale.suppost.qna.WebGoodsQnAService#qnaList(zes.openworks.web.sale.suppost.qna.WebGoodsQnAVO)
     */
    @Override
    public Pager<WebGoodsQnAVO> qnaList(WebGoodsQnAVO vo) {
        return dao.qnaList(vo);
    }

    /* (언어 목록)
     * @see zes.openworks.web.sale.suppost.qna.WebGoodsQnAService#langList(zes.openworks.web.sale.suppost.qna.WebGoodsQnAVO)
     */
    @Override
    public List<CodeVO> langList() {
        return dao.langList();
    }

    /* (구문 목록)
     * @see zes.openworks.web.sale.suppost.qna.WebGoodsQnAService#goodsTyList(zes.openworks.web.sale.suppost.qna.WebGoodsQnAVO)
     */
    @Override
    public List<CodeVO> goodsTyList(WebGoodsQnAVO vo) {
        return dao.goodsTyList(vo);
    }

    /* (문의 내역 목록)
     * @see zes.openworks.web.sale.suppost.qna.WebGoodsQnAService#commentList(zes.openworks.web.sale.suppost.qna.WebGoodsQnAVO)
     */
    @Override
    public WebGoodsQnAVO commentView(WebGoodsQnAVO vo) {
        return dao.commentView(vo);
    }


    /* (문의 내역 수정)
     * @see zes.openworks.web.sale.suppost.qna.WebGoodsQnAService#commentUpdateAction(zes.openworks.web.sale.suppost.qna.WebGoodsQnAVO)
     */
    @Override
    public int commentUpdateAction(WebGoodsQnAVO vo) {
        return dao.commentUpdateAction(vo);
    }
    
}
