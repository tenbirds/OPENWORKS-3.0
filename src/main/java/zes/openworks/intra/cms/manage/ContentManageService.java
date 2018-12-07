/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.manage;

import zes.base.pager.Pager;

/**
 * 사용자 컨텐츠 승인/반려 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 21.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface ContentManageService {

    /**
     * 승인 대상 컨텐츠 목록
     */
    Pager<ContentManageVO> getApproveContentList(ContentManageVO contentManageVo) throws Exception;

    /**
     * 승인 대상 컨텐츠 상세
     */
    ContentManageVO getApproveContent(ContentManageVO contentManageVo) throws Exception;

    /**
     * 승인 대상 컨텐츠 승인/반려 액션
     */
    int approveAction(ContentManageVO contentManageVo) throws Exception;

    /**
     * 컨텐츠 동기화
     */
    String synchronize(ContentManageVO contentManageVo) throws Exception;
}
