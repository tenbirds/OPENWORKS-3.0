/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.markMgmt;

import java.util.List;

import zes.base.vo.FileVO;
import zes.openworks.intra.code.CodeVO;




/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 24.    김영상       신규
 *</pre>
 * @see
 */
public interface MarkService {

    /**
     * markList 설명
     * @param 
     * @return
     */
    List<CodeVO> markList();

    /**
     * cntcImgList 설명
     * @param 
     * @return
     */
    List<CodeVO> cntcImgList();

    /**
     * chkCnt 설명
     * @param vo
     * @return
     */
    int chkCnt(MarkVO vo);

    /**
     * saveMarkInfo 설명
     * @param vo
     * @return
     */
    int saveMarkInfo(MarkVO vo);
    
    /**
     * saveCntcImgInfo 설명
     * @param vo
     * @return
     */
    int saveCntcImgInfo(MarkVO vo);

    /**
     * fileDelete 설명
     * @param fileVO
     * @return
     */
    int fileDelete(FileVO fileVO, MarkVO vo);

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    boolean fileDelete(List<FileVO> fileList);

    /**
     * getMarkInfo 설명
     * @param vo
     * @return
     */
    MarkVO getMarkInfo(MarkVO vo);

    /**
     * getCntcImgInfo 설명
     * @param vo
     * @return
     */
    MarkVO getCntcImgInfo(MarkVO vo);
    
}
