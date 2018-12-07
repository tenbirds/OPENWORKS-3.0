/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.layout;

import java.util.List;

import zes.openworks.component.domain.DomainVO;

/**
 * 사이트관리 서비스객체 인터페이스
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
 *  2012. 5. 7.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface LayoutService {

    /**
     * 사이트 목록
     * 
     * @param layoutVo
     * @return
     * @throws Exception
     */
    List<DomainVO> getDomainList(LayoutVO layoutVo) throws Exception;

    /**
     * Layout 상세
     * 
     * @param layoutVo
     * @return
     */
    LayoutVO getLayout(LayoutVO layoutVo) throws Exception;

    /**
     * Layout 목록
     * 
     * @param layoutVo
     * @return
     */
    List<LayoutVO> getLayoutList(LayoutVO layoutVo) throws Exception;

    /**
     * Layout 등록
     * 
     * @param layoutVo
     * @return
     */
    Object insertLayout(LayoutVO layoutVo) throws Exception;

    /**
     * Layout 수정
     * 
     * @param layoutVo
     * @return
     */
    int updateLayout(LayoutVO layoutVo) throws Exception;

    /**
     * Layout 삭제
     * 
     * @param layoutVo
     * @return
     */
    int deleteLayout(LayoutVO layoutVo) throws Exception;

    /**
     * 레이아웃을 설정된 사이트 모두에 동기화 한다.
     * 
     * @param layoutVo
     * @return
     * @throws Exception 동기화 실패시
     */
    String synchronize(LayoutVO layoutVo) throws Exception;
}
