/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.boardCount;

import org.springframework.stereotype.Repository;

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
 *  2013. 5. 8.    sa   신규 생성
 * </pre>
 * @see
 */
@Repository("boardCountDao")
public class BoardCountDAO extends EgovAbstractMapper {

    /**
     * incMenuReadCount 설명
     * 
     * @param boardVO
     * @return
     */
    public Object incMenuReadCount(Integer bbsCd) {
        return insert("_boardCount.menuInsert", bbsCd);
    }
}
