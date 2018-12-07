/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.stickyNote;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.core.utils.StringUtil;
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
 *  2012. 5. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class StickyNoteDao extends EgovAbstractMapper {

    /**
     * 포스트잇 목록
     */
    @SuppressWarnings("unchecked")
    public List<StickyNoteVO> stickyNoteList(String mgrId) {

        // Bogus 노트 삭제
        int affected = delete("_stickynote.deleteBogusNote", mgrId);
        if(affected > StringUtil.ZERO) {
            logger.info("Deleted bogus note : " + affected);
        }

        return list("_stickynote.stickyNoteList", mgrId);
    }

    /**
     * 포스트잇 등록
     */
    public Integer insertAction(StickyNoteVO StickyNoteVO) {

        insert("_stickynote.stickyNoteInsert", StickyNoteVO);
        Integer seq = StickyNoteVO.getSeq();

        return seq;
    }

    /**
     * 포스트잇 수정
     */
    public int updateAction(StickyNoteVO StickyNoteVO) {

        return update("_stickynote.stickyNoteUpdate", StickyNoteVO);
    }

    /**
     * 포스트잇 삭제
     */
    public int deleteAction(StickyNoteVO StickyNoteVO) {

        return delete("_stickynote.stickyNoteDelete", StickyNoteVO);
    }

}
