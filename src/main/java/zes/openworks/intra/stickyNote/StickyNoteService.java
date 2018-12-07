/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.stickyNote;

import java.util.List;

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
 * 2013. 7. 25.    방기배       신규
 *</pre>
 * @see
 */
public interface StickyNoteService {

    /**
     * 포스트잇 목록
     */
    public List<StickyNoteVO> stickyNoteList(String mgrId);

    /**
     * 포스트잇 등록
     */
    public Integer insertAction(StickyNoteVO StickyNoteVO);

    /**
     * 포스트잇 수정
     */
    public int updateAction(StickyNoteVO StickyNoteVO);

    /**
     * 포스트잇 삭제
     */
    public int deleteAction(StickyNoteVO StickyNoteVO);

}
