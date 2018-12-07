/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.intrcn.atibilityegov;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.intra.code.CodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
 *  2014. 10. 31.    이슬버미       신규
 * </pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class AtibilityEgovDAO extends EgovAbstractMapper {

    /**
     * atibilityEgovList (호환성 목록)
     * 
     * @param vo
     * @return
     */
    public Pager<AtibilityEgovVO> atibilityEgovList(AtibilityEgovVO vo) {
        
        
        Object cmptbClCds = vo.getDataMap().get("q_cmptbClCds");
        
        //분류
        if(Validate.isNotEmpty(cmptbClCds)) {
            String[] cmptbClCd = cmptbClCds.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_cmptbClCds", cmptbClCd);
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
        
        vo.getDataMap().put("registId", vo.getRegistId());
        
        
        List<AtibilityEgovVO> dataList = list("_atibilityegov.atibilityEgovList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_atibilityegov.atibilityEgovCount", vo.getDataMap()));
        
        //원상복수
        vo.getDataMap().put("q_cmptbClCds", cmptbClCds);
        
        return new Pager<AtibilityEgovVO>(dataList, vo);
    }

    /**
     * atibilityEgovView (호환성 상세)
     * 
     * @param vo
     * @return
     */
    public AtibilityEgovVO atibilityEgovView(AtibilityEgovVO vo) {
        return (AtibilityEgovVO) selectByPk("_atibilityegov.atibilityEgovView", vo);
    }

    /**
     * atibilityEgovInsertAction (호환성 등록)
     * 
     * @param vo
     * @return
     */
    public int atibilityEgovInsertAction(AtibilityEgovVO vo) {
        return insert("_atibilityegov.atibilityEgovInsertAction", vo);
    }

    
    /**
     * cmptbClCdList (호환성 분류)
     * @return
     */
    public List<CodeVO> cmptbClCdList(AtibilityEgovVO vo) {
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1002);
        codeVO.setLangCode(vo.getLangCd());
        return list("_code.prvCodeList", codeVO);
    }
    
}
