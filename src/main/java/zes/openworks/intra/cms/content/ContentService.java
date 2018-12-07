/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.content;

import java.util.List;

import zes.base.pager.Pager;
import zes.core.spi.diff.DiffViewVO;

/**
 * 컨텐츠 관리 서비스 객체
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
 *  2012. 6. 27.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface ContentService {

    /**
     * 사용자컨텐츠 상세
     */
    ContentVO getContent(ContentVO contentVo) throws Exception;

    /**
     * 사용자컨텐츠 목록
     */
    Pager<ContentVO> getContentList(ContentVO contentVo) throws Exception;

    /**
     * 사용자컨텐츠 등록
     */
    Object insertContent(ContentVO contentVo) throws Exception;

    /**
     * 사용자컨텐츠 수정
     */
    int updateContent(ContentVO contentVo) throws Exception;

    /**
     * 사용자컨텐츠 삭제
     */
    int deleteContent(ContentVO contentVo) throws Exception;

    /**
     * 사용자컨텐츠 소스 비교보기
     */
    List<DiffViewVO> getSourceDiffView(ContentDiffVO contentDiffVO) throws Exception;

    /**
     * 사용자컨텐츠 화면 비교보기
     */
    ContentDiffVO getScreenDiffView(ContentDiffVO contentDiffVO) throws Exception;

    /**
     * 컨텐츠 동기화
     */
    String synchronize(ContentVO contentVo) throws Exception;
}
