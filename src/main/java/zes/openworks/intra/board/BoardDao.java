/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.bind.VoBinder;
import zes.core.crypto.DESCrypto;
import zes.core.lang.Validate;
import zes.core.spi.oscache.Cache;
import zes.core.utils.Converter;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.cache.BoardConfCache;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.boardconf.BoardConfConstant;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.web.register.RegisterUserVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 기본 게시판 DAO
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일		          수정자                   수정내용
 * --------------  --------  ---------------------------------
 *  2012. 5. 14.     손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Repository
public class BoardDao extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * 게시물 목록 조회
     *
     * @param : bbsCd, noticeBbscttAt, bannedWordYn
     */
    @SuppressWarnings("unchecked")
    public Pager<BoardVO> boardList(BoardVO boardVO, String listSkin) {
        Map<String, Object> parameterMap = boardVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardVO);

        parameterMap.put("noticeBbscttAt", "N");

        int listTotalCount = ((Integer) (selectByPk("_board.boardListCount", parameterMap))).intValue();

        if(listSkin.equals("reply")) {
            // 답글형 기본 정렬
            if(Validate.isEmpty(parameterMap.get("q_sortName"))) {
                parameterMap.put("q_sortName", "ROWNUM");
                parameterMap.put("q_sortOrder", "DESC");
            }
        }

        parameterMap.put(
            "pagingEndNum",
            Pager.getEndNum(Integer.parseInt(parameterMap.get("pagingStartNum").toString()),
                Integer.parseInt(parameterMap.get("q_rowPerPage").toString())));
        List<BoardVO> dataList = list("_board.boardList", parameterMap);
        for(BoardVO dataVO : dataList) {
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));

        }
        boardVO.setTotalNum(listTotalCount);

        return new Pager<BoardVO>(dataList, boardVO);
    }

    /**
     * 게시물 목록 조회(컨버전 다운로드용)
     */
    @SuppressWarnings("unchecked")
    public Pager<BoardVO> boardAllList(BoardConvertOptionVO boardConvertOptionVO) {
        Map<String, Object> parameterMap = boardConvertOptionVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardConvertOptionVO);

        if(!"Y".equals(boardConvertOptionVO.getShowAll())) {
            parameterMap.put("bbsCd", boardConvertOptionVO.getBbsCd());
            if(Validate.isNotEmpty(boardConvertOptionVO.getMaxResult()) && boardConvertOptionVO.getMaxResult() > 0) {
                parameterMap.put("pagingStartNum", String.valueOf(1));
                parameterMap.put("pagingEndNum", String.valueOf(boardConvertOptionVO.getMaxResult()));
            } else {
                parameterMap.remove("pagingStartNum");
                parameterMap.remove("pagingEndNum");
            }
        } else {
            parameterMap.remove("pagingStartNum");
            parameterMap.remove("pagingEndNum");
        }

        List<BoardVO> dataList = list("_board.boardAllList", parameterMap);
        int listTotalCount = ((Integer) (selectByPk("_board.boardListCount", parameterMap))).intValue();
        boardConvertOptionVO.setTotalNum(listTotalCount);

        return new Pager<BoardVO>(dataList, boardConvertOptionVO);
    }

    /**
     * 게시물 공지 목록 조회
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> noticeList(BoardVO boardVO, String listSkin) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.putAll(boardVO.getDataMap());
        VoBinder.methodBind(parameterMap, boardVO);
        parameterMap.put("noticeBbscttAt", "Y");

        return list("_board.noticeList", parameterMap);
    }

    /**
     * 게시물 상세 조회
     */
    @SuppressWarnings("unchecked")
    public BoardVO boardView(BoardVO boardVO) {
        BoardVO dataVO = (BoardVO) selectByPk("_board.boardView", boardVO);

        if(dataVO != null) {
            dataVO.setPrevVO((BoardVO) selectByPk("_board.boardPrevView", boardVO));
            dataVO.setNextVO((BoardVO) selectByPk("_board.boardNextView", boardVO));
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
            dataVO.setFileCnt(dataVO.getFileList().size());
        }

        // 태그를 가져온다.
        List<String> list = new ArrayList<String>();
        if(dataVO != null) {
            list = list("_board.boardTagList", dataVO);
        }
        if(Validate.isNotEmpty(list)) {
            dataVO.setBbsTags(list.toArray(new String[list.size()]));
        }

        return dataVO;
    }

    /**
     * 게시물 상세 조회 카운트를 증가시킨다.
     */
    public Object incReadCount(BoardVO boardVO) {
        return update("_board.boardIncRdCnt", boardVO);
    }

    /**
     * 게시물 평가 액션
     */
    public Object scoreAction(BoardVO boardVO) {
        Object result = update("_board.scoreInc", boardVO);
        return result;
    }

    /**
     * 게시물 추천 액션
     */
    public Object recommAction(BoardVO boardVO) {
        Object result = update("_board.recommInc", boardVO);
        return result;
    }

    /**
     * 게시물 신고 액션
     */
    public Object accuseAction(BoardVO boardVO) {
        Object result = update("_board.accuseInc", boardVO);
        return result;
    }

    /**
     * 게시물 등록 액션
     */
    public Object boardInsert(BoardVO boardVO) {

        int fileSeq = fileDao.saveFile(boardVO.getFileList(), boardVO.getFileSeq());
        boardVO.setFileSeq(fileSeq);

        boardVO.setBbscttSj(Converter.cleanHtml(boardVO.getBbscttSj()));
        boardVO.setCnSumry(StringUtil.omit(Converter.cleanHtml(StringUtil.replace(boardVO.getBbscttCn(), "\"", "'")), 170));
        if(Validate.isNotEmpty(boardVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardVO.setRegistPassword(descrypto.encrypt(boardVO.getRegistPassword()));
        }

        if(Validate.isNotEmpty(boardVO.getAditCtgCd()) && Validate.isNotEmpty(boardVO.getCtgCd()) ){
            boardVO.setEstnColumn1(Integer.toString(boardVO.getAditCtgCd()));
            boardVO.setEstnColumn2(boardVO.getAditCtgNm());
        }

        String date = DateFormatUtil.getTodayMsec();

        // 답글 작성시
        if(Validate.isNotEmpty(boardVO.getRefrnSeq())) {
            BoardVO tempVO = boardVO.copyCreateVO();
            int lastChildNo = getMinChildNo(tempVO);
            boardVO.setBbscttOrdrNo(lastChildNo);
            update("_board.boardUpdateOrderNo", boardVO);
            boardVO.setBbscttOrdrNo(lastChildNo + 1);
            boardVO.setBbscttDp(boardVO.getBbscttDp() + 1);
            boardVO.setBbscttSeq(date);
        }
        // 신규 등록시
        else {
            boardVO.setBbscttOrdrNo(0);
            boardVO.setBbscttDp(0);
            boardVO.setBbscttSeq(date);
            boardVO.setRefrnSeq(date);
        }
        boardVO.setRdcnt(0);

        insert("_board.boardInsert", boardVO);

        // 갤러리 게시판인 경우 썸네일을 생성한다.
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        if(BoardConfConstant.GUBUN_BOARD_GALLERY == boardConfVO.getKndCd()) {
            createThumbNail(fileSeq, 100, 100);
        }

        addTags(boardVO);

        return StringUtil.ONE;
    }

    /**
     * 민원형 게시물 답변 액션
     */
    public int boardAnswer(BoardVO boardVO) {
        return update("_board.boardAnswerUpdate", boardVO);
    }

    /**
     * 태그를 등록한다.
     */
    private void addTags(BoardVO boardVO) {
        if(Validate.isEmpty(boardVO.getBbsTags()) || (boardVO.getBbsTags()[0].length() == 0)) {
            return;
        }

        for(int i = 0 ; i < boardVO.getBbsTags().length ; i++) {

            String tags = boardVO.getBbsTags()[i];
            BoardTagVO boardTagVO = new BoardTagVO(boardVO.getDomainCd(), boardVO.getBbsCd(), boardVO.getBbscttSeq(), StringUtil.trim(tags));
            if(Validate.isEmpty(boardTagVO.getTagNm())) {
                return;
            }
            if(((Integer) selectByPk("_board.boardTagCount", boardTagVO)).intValue() > 0) {
                continue;
            }
            insert("_board.boardTagInsert", boardTagVO);
        }

       /*
        String[] tags = boardVO.getBbsTags()[0].split(",");
        for(String tagNm : tags) {
            BoardTagVO boardTagVO = new BoardTagVO(boardVO.getDomainCd(), boardVO.getBbsCd(), boardVO.getBbscttSeq(), StringUtil.trim(tagNm));


            if(Validate.isEmpty(boardTagVO.getTagNm())) {
                return;
            }
            if(((Integer) selectByPk("_board.boardTagCount", boardTagVO)).intValue() > 0) {
                continue;
            }
            insert("_board.boardTagInsert", boardTagVO);
        }*/
    }

    /**
     * 재귀적 호출을 하여 자식중 orderNo가 최고 낮은 마지막 자식의 orderNo를 넘겨준다.
     */
    private int getMinChildNo(BoardVO boardVO) {
        BoardVO dataVO = new BoardVO();

        while(true) {
            dataVO = (BoardVO) selectByPk("_board.boardMinChildNode", boardVO);
            if(boardVO.getBbscttOrdrNo().intValue() == dataVO.getBbscttOrdrNo().intValue()) {
                // 현재 제일 마지막 자식 노드의 넘버를 리턴한다.
                return dataVO.getBbscttOrdrNo();
            } else {
                boardVO.setBbsCd(dataVO.getBbsCd());
                boardVO.setBbscttSeq(dataVO.getBbscttSeq());
                boardVO.setRefrnSeq(dataVO.getRefrnSeq());
                boardVO.setBbscttOrdrNo(dataVO.getBbscttOrdrNo());
                boardVO.setBbscttDp(dataVO.getBbscttDp());
            }
        }
    }

    private int getMaxChildNo(BoardVO boardVO) {
        BoardVO dataVO = new BoardVO();

        while(true) {
            dataVO = (BoardVO) selectByPk("_board.boardMaxChildNode", boardVO);
            if(boardVO.getBbscttOrdrNo().intValue() == dataVO.getBbscttOrdrNo().intValue()) {
                // 현재 제일 마지막 자식 노드의 넘버를 리턴한다.
                return dataVO.getBbscttOrdrNo();
            } else {
                boardVO.setBbsCd(dataVO.getBbsCd());
                boardVO.setBbscttSeq(dataVO.getBbscttSeq());
                boardVO.setRefrnSeq(dataVO.getRefrnSeq());
                boardVO.setBbscttOrdrNo(dataVO.getBbscttOrdrNo());
                boardVO.setBbscttDp(dataVO.getBbscttDp());
            }
        }
    }

    /**
     * 게시물 수정 액션
     */
    public int boardUpdate(BoardVO boardVO) {
        boardVO.setBbscttSj(Converter.cleanHtml(boardVO.getBbscttSj()));
        boardVO.setCnSumry(StringUtil.omit(Converter.cleanHtml(StringUtil.replace(boardVO.getBbscttCn(), "\"", "'")), 170));

        if(Validate.isNotEmpty(boardVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardVO.setRegistPassword(descrypto.encrypt(boardVO.getRegistPassword()));
        }
        boardVO.setUpdtDt(DateFormatUtil.getToday());

        int affected = update("_board.boardUpdate", boardVO);

        if(affected == StringUtil.ONE) {
            // ajax 삭제 기능으로 불필요해짐
            // fileDao.removeFile(boardVO.getFileSeq(), boardVO.getFileIds());

            int fileSeq = fileDao.saveFile(boardVO.getFileList(), boardVO.getFileSeq());
            boardVO.setFileSeq(fileSeq);

            // 갤러리 게시판인 경우 썸네일을 생성한다.
            BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
            if(BoardConfConstant.GUBUN_BOARD_GALLERY == boardConfVO.getKndCd()) {
                createThumbNail(fileSeq, 100, 100);
            }
        }

        affected = update("_board.boardUpdate", boardVO);

        delete("_board.boardTagDeleteAll", boardVO);

        addTags(boardVO);

        return affected;
    }

    /**
     * 게시물 수정 액션
     */
    /*
     * public int updateActionYn(BoardVO boardVO){
     * Map<String, Object> paramMap = new HashMap<String, Object>();
     * paramMap.put("bbsCd", String.valueOf(boardVO.getBbsCd().intValue()));
     * paramMap.put("bbscttSeq", boardVO.getbbscttSeq());
     * paramMap.put("banYn", boardVO.getBanYn());
     * paramMap.put("modDt", DateFormatUtil.getToday());
     * return update("_board.boardUpdateYn", paramMap);
     * }
     */

    /**
     * 게시물 삭제 액션
     */
    @SuppressWarnings("unchecked")
    public int boardDelete(BoardVO boardVO, String delDesc, boolean useTrash) {
        BoardVO data = (BoardVO) selectByPk("_board.boardView", boardVO);
        if(Validate.isEmpty(data.getBbscttSeq())) {
            return 0;
        }

        BoardVO tempVO = data.copyCreateVO();
        int lastChildNo = getMaxChildNo(tempVO);
        data.setBbscttDp(lastChildNo);

        List<BoardVO> dataList = list("_board.deleteBoardList", data);

        int affected = 0;
        for(BoardVO dataVO : dataList) {
            BoardVO deleteVO = (BoardVO) selectByPk("_board.boardView", dataVO);
            if(useTrash) {
                deleteVO.setDelDt(DateFormatUtil.getToday());
                deleteVO.setDelDesc(delDesc);
                deleteVO.setCmtSeq(null);

                insert("_board.trashBoardInsert", deleteVO);
                insert("_board.trashTagInsert", deleteVO);
                insert("_board.trashCommentInsert", deleteVO);

                fileDao.removeFile(dataVO.getFileSeq());
            }
            delete("_board.commentDeleteAll", dataVO);
            delete("_board.boardTagDeleteAll", dataVO);

            affected += delete("_board.boardDelete", dataVO);
        }

        return (affected == dataList.size()) ? affected : 0;
    }

    /**
     * 게시물 삭제 액션(목록에서 여러개 삭제시)
     */
    public int boardListDelete(BoardVO boardVO, String delDesc, boolean useTrash) {
        int result = 0;

        for(String bbscttSeq : boardVO.getBbscttSeqs()) {
            BoardVO dataVO = new BoardVO();
            dataVO.setDomainCd(boardVO.getDomainCd());
            dataVO.setBbsCd(boardVO.getBbsCd());
            dataVO.setBbscttSeq(bbscttSeq);
            result += boardDelete(dataVO, delDesc, useTrash);
        }
        return result;
    }

    /**
     * 게시물 플래그 삭제 액션
     */
    public int boardFlagDelete(BoardVO boardVO) {
        return update("_board.updateMngrDelAt", boardVO);
    }

    /**
     * 게시물 플래그 삭제 액션(목록에서 여러개 삭제시)
     */
    public int boardListFlagDelete(BoardVO boardVO) {
        int result = 0;

        for(int i = 0 ; i < boardVO.getBbscttSeqs().length ; i++) {
        }
        for(String bbscttSeq : boardVO.getBbscttSeqs()) {

            BoardVO dataVO = new BoardVO();
            dataVO.setDomainCd(boardVO.getDomainCd());
            dataVO.setBbsCd(boardVO.getBbsCd());
            dataVO.setBbscttSeq(bbscttSeq);
            result += boardFlagDelete(dataVO);
        }
        return result;
    }

    /**
     * 덧글 목록 조회
     */
    @SuppressWarnings("unchecked")
    public Pager<BoardCmtVO> commentList(BoardCmtVO boardCmtVO) {
        Map<String, Object> parameterMap = boardCmtVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardCmtVO);

        int listTotalCount = ((Integer) (selectByPk("_board.commentListCount", parameterMap))).intValue();

        List<BoardCmtVO> dataList = list("_board.commentList", parameterMap);
        for(BoardCmtVO cmtVo : dataList) {
            cmtVo.setNttCmtCn(Converter.translateBR(cmtVo.getNttCmtCn()));
        }

        boardCmtVO.setTotalNum(listTotalCount);

        return new Pager<BoardCmtVO>(dataList, boardCmtVO);
    }

    /**
     * 덧글 등록 액션
     */
    public Object insertComment(BoardCmtVO boardCmtVO) {
        if(Validate.isNotEmpty(boardCmtVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardCmtVO.setRegistPassword(descrypto.encrypt(boardCmtVO.getRegistPassword()));
        }
        String date = DateFormatUtil.getTodayMsec();
        // 답글 작성시
        if(Validate.isNotEmpty(boardCmtVO.getRefrnCmtSeq())) {
            int maxOrderNo = ((Integer) (selectByPk("_board.boardCmtMaxOrderNo", boardCmtVO))).intValue();
            boardCmtVO.setCmtOrdrNo(maxOrderNo + 1);
            boardCmtVO.setCmtDp(boardCmtVO.getCmtDp() + 1);
            boardCmtVO.setRefrnCmtSeq(boardCmtVO.getCmtSeq());
            boardCmtVO.setCmtSeq(date);
        }
        // 신규 등록시
        else {
            boardCmtVO.setCmtOrdrNo(0);
            boardCmtVO.setCmtDp(0);
            boardCmtVO.setCmtSeq(date);
            boardCmtVO.setRefrnCmtSeq(date);
        }

        boardCmtVO.setNttCmtCn(Converter.XSS(boardCmtVO.getNttCmtCn()));
        Object result = insert("_board.commentInsert", boardCmtVO);
        return result;
    }

    /**
     * 덧글 상세 보기
     */
    public BoardCmtVO viewComment(BoardCmtVO boardCmtVO) {
        BoardCmtVO dataVO = (BoardCmtVO) selectByPk("_board.commentView", boardCmtVO);
        if(Validate.isNotEmpty(dataVO) && Validate.isNotEmpty(dataVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            dataVO.setRegistPassword(descrypto.decrypt(dataVO.getRegistPassword()));
        }
        return dataVO;
    }

    /**
     * 덧글 수정 액션
     */
    public Object updateComment(BoardCmtVO boardCmtVO) {
        boardCmtVO.setUpdtDt(DateFormatUtil.getToday());
        if(Validate.isNotEmpty(boardCmtVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardCmtVO.setRegistPassword(descrypto.encrypt(boardCmtVO.getRegistPassword()));
        }
        boardCmtVO.setNttCmtCn(Converter.XSS(boardCmtVO.getNttCmtCn()));
        Object result = update("_board.commentUpdate", boardCmtVO);
        return result;
    }

    /**
     * 덧글 삭제 액션(완전삭제) - 관리자
     */
    public String deleteComment(BoardCmtVO boardCmtVO) {
        BoardVO deleteVO = new BoardVO();
        deleteVO.setBbsCd(boardCmtVO.getBbsCd());
        deleteVO.setBbscttSeq(boardCmtVO.getBbscttSeq());
        deleteVO.setCmtSeq(boardCmtVO.getCmtSeq());
        deleteVO.setDelDt(DateFormatUtil.getToday());
        deleteVO.setDelDesc("댓글 개별 삭제");
        insert("_board.trashCommentInsert", deleteVO);

        if(boardCmtVO.getRefrnCmtSeq().equals(boardCmtVO.getCmtSeq())){
            //댓글(1Depth)_하위댓글모두삭제
            boardCmtVO.setRefrnCmtSeq(boardCmtVO.getCmtSeq());
        }else{
            //댓글(2Depth)
            boardCmtVO.setRefrnCmtSeq("");
        }

        int num = delete("_board.commentDelete", boardCmtVO);

        String result = "";

        if(num > 0){
             result = "TRUE";
        }
        return result;
    }

    /**
     * 덧글 플래그 삭제 액션
     */
    public int cmtFlagDelete(BoardCmtVO boardCmtVO) {
        return update("_board.updateCmtMngrDelAt", boardCmtVO);
    }

    /**
     * 게시판 목록들(선택한 게시판이 아닌 다른 모든 게시판목록)
     */
    @SuppressWarnings("unchecked")
    public List<BoardConfVO> boardConfList(Integer domainCd, Integer bbsCd) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        map.put("domainCd", domainCd);
        map.put("bbsCd", bbsCd);

        return list("_boardconf.boardConfSimpleList", map);
    }

    /**
     * 목록보기에서 게시물 복사 & 이동
     */

    public Integer listTransfer(Integer domainCd, String bbsCd, Integer[] toBbsCds, String[] bbscttSeqs, String isMove, Integer[] newCtg) {
        int primaryKey = 0;
        for(int i = 0 ; i < bbscttSeqs.length ; i++) {
            primaryKey += articleTransfer(domainCd,bbsCd, toBbsCds[i], bbscttSeqs[i], isMove, newCtg[i]);
        }

        return primaryKey;
    }

    /**
     * 상세보기에서 게시물 복사 & 이동
     */
    @SuppressWarnings("unchecked")
    public Integer articleTransfer(Integer domainCd, String bbsCd, Integer toBbsCd, String bbscttSeq, String isMove, Integer newCtg) {
        BoardVO boardVO = new BoardVO();
        boardVO.setBbsCd(Integer.valueOf(bbsCd));
        boardVO.setBbscttSeq(bbscttSeq);
        BoardVO dataVO = (BoardVO) selectByPk("_board.boardMoveView", boardVO);

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        if(boardConfVO.getKndCd() == BoardConfConstant.GUBUN_BOARD_GALLERY) {
            if(!isAllImage(dataVO.getFileSeq())) {
                return 0;
            }
        }

        dataVO.setBbsCd(toBbsCd);
        if(Validate.isNotEmpty(newCtg)) {
            dataVO.setCtgCd(newCtg);
        } else {
            dataVO.setCtgCd(-1);
        }

        dataVO.setUpdtDt(DateFormatUtil.getToday());

        // 게시물을 대상 게시판으로 복사
        if((Integer) selectByPk("_board.getBoardCount", dataVO) > 0) {
            return 0;
        }

        try {
            insert("_board.boardInsert", dataVO);
            // 원본게시물에 이동한게시판코드 저장
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("toBbsCd", toBbsCd);
            param.put("bbsCd", bbsCd);
            param.put("bbscttSeq", bbscttSeq);
//            update("_board.updateMoveBbsCd", param);
        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.debug("article move failed", e);
            }
            return 0;
        }

        if(BoardConfConstant.GUBUN_BOARD_GALLERY == boardConfVO.getKndCd()) {
            // 이동할 게시판이 갤러리 게시판인 경우 썸네일을 생성한다.
            createThumbNail(dataVO.getFileSeq(), 100, 100);
        }

        List<BoardCmtVO> commentList = list("_board.commentListAll", boardVO);

        for(BoardCmtVO boardCommentVO : commentList) {
            boardCommentVO.setBbsCd(toBbsCd);
            insert("_board.commentInsert", boardCommentVO);
        }

        List<BoardTagVO> tagList = list("_board.boardTagListAll", boardVO);

        for(BoardTagVO boardTagVO : tagList) {
            boardTagVO.setBbsCd(toBbsCd);
            insert("_board.boardTagInsert", boardTagVO);
        }

        // 원본 게시물 삭제 => 원본 게시물 보관
        if("Y".equals(isMove)) {
            // return boardDelete(boardVO, "게시물이동 : " + bbsCd + " -> " +
            // toBbsCd.toString(), false);
        }

        return 1;
    }

    /**
     * 첨부파일이 모두 이미지 파일인지 확인한다.
     */
    private boolean isAllImage(Integer fileSeq) {
        List<FileVO> fileList = fileDao.getFiles(fileSeq);
        for(FileVO bean : fileList) {
            if(!bean.getFileType().startsWith("image/")) {
                return false;
            }
        }
        return true;
    }

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    public boolean fileDelete(List<FileVO> fileList) {
        int deleteCnt = 0;
        if(Validate.isNotEmpty(fileList)) {
            // 물리적인 첨부파일 삭제
            for(FileVO fileVO : fileList) {
                if(FileUtil.delete(GlobalConfig.UPLOAD_ROOT + fileVO.getFileUrl())) {
                    deleteCnt++;
                }
            }
        }
        return (deleteCnt == fileList.size()) ? true : false;
    }

    /**
     * 게시판에 대한 클라우드 태그 목록을 가져온다.
     */
    @SuppressWarnings("unchecked")
    public String tagCloud(Integer domainCd, Integer bbsCd) {
        BoardTagVO resultVO = new BoardTagVO();
        resultVO.setDomainCd(domainCd);
        resultVO.setBbsCd(bbsCd);

        StringBuilder jsonStr = new StringBuilder();
        Integer tagMaxCnt = 0;
        Integer tagMinCnt = 0;
        Integer tagAvgCnt = 0;

        List<BoardTagVO> dataList = list("_board.boardTagAllList", bbsCd);

        tagMaxCnt = (Integer) selectByPk("_board.boardTagMaxCount", bbsCd);
        tagMinCnt = (Integer) selectByPk("_board.boardTagMinCount", bbsCd);
        tagAvgCnt = (Integer) selectByPk("_board.boardTagAvgCount", bbsCd);

        jsonStr.append("({ tags:[ ");

        for(int i = 0 ; i < dataList.size() ; i++) {
            jsonStr.append("{tag:'" + dataList.get(i).getTagNm() + "', freq:'" + dataList.get(i).getTagCnt() + "'}");
            if(i != (dataList.size() - 1)) {
                jsonStr.append(",");
            }
        }
        jsonStr.append("],");

        jsonStr.append("tagMaxCnt: '" + tagMaxCnt + "',");
        jsonStr.append("tagMinCnt: '" + tagMinCnt + "',");
        jsonStr.append("tagAvgCnt: '" + tagAvgCnt + "'");
        jsonStr.append("})");

        return jsonStr.toString();
    }

    // 갤러리 게시판용 썸네일 이미지를 생성한다. (같은 폴더, postfix = "_t")
    private void createThumbNail(Integer fileSeq, int width, int height) {
        List<FileVO> fileList = fileDao.getFiles(fileSeq);
        createThumbNail(fileList, width, height);
    }

    // 갤러리 게시판용 썸네일 이미지를 생성한다. (같은 폴더, postfix = "_t")
    private void createThumbNail(List<FileVO> fileList, int width, int height) {
        for(FileVO baseFileVO : fileList) {
            String filePath = baseFileVO.getServerNm();
            String fileName = filePath.substring(0, filePath.length() - 4) + "_t.jpg";

            if(FileUtil.isFile(fileName) || !baseFileVO.getFileType().startsWith("image/")) {
                continue;
            }

            try {
                BufferedImage bi = ImageIO.read(new File(GlobalConfig.UPLOAD_ROOT + baseFileVO.getFileUrl()));

                // width, height는 원하는 thumbnail 이미지의 크기

                // aspect ratio 유지하기 위해 크기 조정
                if((float) width / bi.getWidth() > (float) height / bi.getHeight()) {
                    width = (int) (bi.getWidth() * ((float) height / bi.getHeight()));
                } else {
                    height = (int) (bi.getHeight() * ((float) width / bi.getWidth()));
                }

                BufferedImage thImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
                Graphics2D g2 = thImg.createGraphics();
                g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                g2.drawImage(bi, 0, 0, width, height, null);

                g2.dispose();

                // thumbnail 이미지를 JPEG 형식으로 저장
                ImageIO.write(thImg, "jpg", new File(fileName));
            } catch (IOException e) {
                if(logger.isDebugEnabled()) {
                    logger.debug("create thumbnail failed", e);
                }
            }
        }
    }

    /**
     * recomList 설명
     * @param boardConfVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> recomList(BoardVO boardVO) {
        List<BoardVO> recomList = list("_board.recomList", boardVO);
        return recomList;
    }

    /**
     * boardAditCtgList 설명
     * @param boardConfVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardConfVO> boardAditCtgList(BoardConfVO boardConfVO) {

        List<BoardConfVO> AditCtgList = new ArrayList<BoardConfVO>();
            AditCtgList.addAll(list("_board.AditCtgList", boardConfVO));

        return AditCtgList;
    }

    /**
     * othbcAtUpdateAction 설명
     * @param boardVo
     * @return
     */
    public int othbcAtUpdateAction(BoardVO boardVo) {
        return update("_board.othbcAtUpdateAction", boardVo);
    }

    /**
     * 비즈매칭 댓글 선정하기
     * @param boardVo
     * @return
     */
    public int selectionUpdate(BoardVO boardVo) {
        return update("_board.selectionUpdate", boardVo);
    }

    /**
     * userBoardSelect 설명
     * @param boardVO
     * @return
     */
    public RegisterUserVO userBoardSelect(BoardVO boardVO) {
        RegisterUserVO dataVO = (RegisterUserVO) selectByPk("_board.userBoardSelect", boardVO);
        return dataVO;
    }


}
