/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.goods.qna;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.intra.code.CodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
@Repository
@SuppressWarnings("unchecked")
public class GoodsQnADAO  extends EgovAbstractMapper   {

    public Pager<GoodsQnAVO> qnaList(GoodsQnAVO vo) {
     
        
        Object langCodes = vo.getDataMap().get("q_langCodes");
        
        //언어
        if(Validate.isNotEmpty(langCodes)) {
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }
        
        // 날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate", sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
        
        List<GoodsQnAVO> dataList = list("_goodsqna.qnaList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_goodsqna.qnaCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        
        return new Pager<GoodsQnAVO>(dataList, vo);
        
        
    }

    public GoodsQnAVO qnaCommentList(GoodsQnAVO vo) {
        vo.getDataMap().put("goodsInqryNo", vo.getGoodsInqryNo());
        return (GoodsQnAVO) selectByPk("_goodsqna.qnaList", vo.getDataMap());
    }
    
    public int qnADeleteAction(GoodsQnAVO vo) {
        return delete("_goodsqna.deleteAction", vo);
    }
    
    public int qnACommentDeleteAction(GoodsQnAVO vo) {
        return update("_goodsqna.qnACommentDeleteAction", vo);
    }
    
    
    public Pager<GoodsQnAVO> sttemntList(GoodsQnAVO vo) {
     
        
        Object langCodes = vo.getDataMap().get("q_langCodes");
        
        //언어
        if(Validate.isNotEmpty(langCodes)) {
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }
        
        // 날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDateAcc"))) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDateAcc", sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDateAcc", sdf.format(c1.getTime()));
        }
        
        List<GoodsQnAVO> dataList = list("_goodsqna.sttemntList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_goodsqna.sttemntCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        
        return new Pager<GoodsQnAVO>(dataList, vo);
        
        
    }
    
    public int deleteAction(GoodsQnAVO vo) {        
        int affected = 0;        
        if(Validate.isNotEmpty(vo.getGoodsInqryNos())){
            for(String seqs : vo.getGoodsInqryNos()) {
                GoodsQnAVO goodsQnAVO  = new GoodsQnAVO(); 
                goodsQnAVO.setGoodsInqryNo(Integer.valueOf(seqs));
                affected += update("_goodsqna.deleteAction", goodsQnAVO);
            }
        }
        return affected;
    }
    
    
    
    public List<CodeVO> langList() {
        return list("_code.getLangCodeList",new CodeVO());
    }

    
    public List<GoodsQnAVO> ctgryList(GoodsQnAVO vo) {
        return list("_goodsqna.ctgryList", vo);
    }
    
}
