/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.synchronize;

import javax.servlet.http.HttpServletRequest;

/**
 * <pre>
 * 컨텐츠 동기화 서비스 객체
 * &#64;Service Annotation의 명칭을 통하여 서비스를 구하고 해당 서비스에서
 * 사용되어야 할 정보는 SynchronizeVO.getDataMap();에 담아서 전달한다.
 * </pre>
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
 *  2012. 5. 8.    방기배   신규 생성
 * </pre>
 * @see
 */
public interface SynchronizeService {

    /**
     * 각 프로세스에 맞는 동기화 로직 구현
     */
    void synchronize(HttpServletRequest request, SynchronizeVO synchronizeVo) throws Exception;

}
