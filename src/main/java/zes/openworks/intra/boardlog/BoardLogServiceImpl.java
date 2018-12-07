/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.openworks.intra.boardconf.BoardConfVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 게시판 로그 서비스 구현
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2012. 6. 25.     홍길동      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Service("boardLogService")
public class BoardLogServiceImpl extends AbstractServiceImpl implements BoardLogService {

    @Resource
    private BoardLogDao boardLogDao;

    @Override
    public Map<String, String> overviewLog(Integer domainCd, Integer bbsCd, Integer ctgCd) {
        return boardLogDao.overviewLog(domainCd, bbsCd,ctgCd );
    }

    @Override
    public BoardLogData boardLog(BoardLogSearchVO searchVO) {
        return boardLogDao.boardLog(searchVO);

    }

    @Override
    public BoardLogData commentLog(BoardLogSearchVO searchVO) {
        return boardLogDao.commentLog(searchVO);
    }

    @Override
    public BoardLogData fileDownLog(BoardLogSearchVO searchVO) {
        return boardLogDao.fileDownLog(searchVO);
    }

    @Override
    public BoardLogData fileUploadLog(BoardLogSearchVO searchVO) {
        return boardLogDao.fileUploadLog(searchVO);
    }
    
    public List<BoardConfVO> boardConfList(BoardConfVO boardConfVo) {
        return boardLogDao.boardConfList(boardConfVo);
    }
    
    @Override
    public List<BoardConfVO> boardCtgNmsList(BoardConfVO boardConfVo) {
        return boardLogDao.boardCtgNmsList(boardConfVo);
    }
}
