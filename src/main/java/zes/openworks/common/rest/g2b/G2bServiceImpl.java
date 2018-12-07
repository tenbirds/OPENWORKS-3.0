/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.openworks.common.rest.g2b.vo.G2bResponseVO;
import zes.openworks.common.rest.g2b.vo.G2bVO;
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
 * 2014. 12. 11.    이슬버미       신규
 *</pre>
 * @see
 */
@Service
public class G2bServiceImpl extends AbstractServiceImpl  implements G2bService {
    
    @Resource G2bDAO dao;
    
    /* (나라장터 기관별 입찰공고/재공고 용역 목록을 조회)
     * @see zes.openworks.common.rest.g2b.G2bService#getInsttAcctoBidPblancListServc(zes.openworks.common.rest.g2b.G2bVO)
     */
    public G2bResponseVO getInsttAcctoBidPblancListServc(G2bVO vo) throws Exception {

        return dao.getInsttAcctoBidPblancListServc(vo);
    }

    
    /* (나라장터 계약현황 기관별 용역 목록을 조회)
     * @see zes.openworks.common.rest.g2b.G2bService#getInsttCntrctInfoListServcCntrctSttus(zes.openworks.common.rest.g2b.G2bVO)
     */
    public G2bResponseVO getInsttCntrctInfoListServcCntrctSttus(G2bVO vo) throws Exception {
    
        return dao.getInsttCntrctInfoListServcCntrctSttus(vo);
    }

}
