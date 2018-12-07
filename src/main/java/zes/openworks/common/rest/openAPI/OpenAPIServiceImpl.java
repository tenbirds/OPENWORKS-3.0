/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.openAPI;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
 * 2014. 12. 23.    이슬버미       신규
 *</pre>
 * @see
 */
@Service
public class OpenAPIServiceImpl extends AbstractServiceImpl  implements OpenAPIService {

    @Resource
    private OpenAPIDAO dao;
    
    /* (샘플 리스트)
     * @see zes.openworks.common.rest.openAPI.OpenAPIService#sampleList(zes.openworks.common.rest.openAPI.OpenAPIVO)
     */
    public Object sampleList(OpenAPIVO vo) {
        return dao.sampleList(vo);
    }
    
    /* (서비스 정보 요청)
     * @see zes.openworks.common.rest.openAPI.OpenAPIService#goodsInfoList(zes.openworks.common.rest.openAPI.OpenAPIVO)
     */
    public Object goodsInfoList(OpenAPIVO vo) {
        return dao.goodsInfoList(vo);
    }
    
    
}
