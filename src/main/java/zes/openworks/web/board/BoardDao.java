/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.board;

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
import zes.openworks.intra.board.BoardCmtVO;
import zes.openworks.intra.board.BoardConvertOptionVO;
import zes.openworks.intra.board.BoardTagVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.boardconf.BoardConfConstant;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.mgr.MgrVO;
import zes.openworks.intra.orderManage.consult.ConsultOrderVO;
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
 *   수정일                  수정자                   수정내용
 * --------------  --------  ---------------------------------
 *  2012. 6. 14.     손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Repository("boardWebDAO")
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
        parameterMap.put("userId", boardVO.getUserId());
        parameterMap.put("langCode",boardVO.getLangCode());
        
        int listTotalCount = ((Integer) (selectByPk("_boardWeb.boardListCount", parameterMap))).intValue();

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
        
        List<BoardVO> dataList = list("_boardWeb.boardList", parameterMap);
        for(BoardVO dataVO : dataList) {
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
            
            if(dataVO.getBbsCd() == 1002){ //자주찾는질문 검색어 css추가
                String searchValueSj = "<em class='point'>"+boardVO.getQ_searchVal()+"</em>";
                String searchValueCn = "<em class='point'>"+boardVO.getQ_searchVal()+"</em>";
                if(Validate.isNotEmpty(boardVO.getQ_searchVal()) && Validate.isNotEmpty(boardVO.getQ_searchType()) ){
                    dataVO.setBbscttSj(dataVO.getBbscttSj().replaceAll(boardVO.getQ_searchVal(),searchValueSj));
                    dataVO.setBbscttCn(dataVO.getBbscttCn().replaceAll(boardVO.getQ_searchVal(),searchValueCn));
                }
            }
            
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
            parameterMap.put("domainCd", boardConvertOptionVO.getDomainCd());
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

        List<BoardVO> dataList = list("_boardWeb.boardAllList", parameterMap);
        int listTotalCount = ((Integer) (selectByPk("_boardWeb.boardListCount", parameterMap))).intValue();
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

        return list("_boardWeb.noticeList", parameterMap);
    }

    /**
     * 게시물 상세 조회
     */
    @SuppressWarnings("unchecked")
    public BoardVO boardView(BoardVO boardVO) {
        
        BoardVO dataVO = (BoardVO) selectByPk("_boardWeb.boardView", boardVO);

        if(dataVO != null) {
            dataVO.setPrevVO((BoardVO) selectByPk("_boardWeb.boardPrevView", boardVO));
            dataVO.setNextVO((BoardVO) selectByPk("_boardWeb.boardNextView", boardVO));
            
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
            dataVO.setFileCnt(dataVO.getFileList().size());
            if(Validate.isNotEmpty(dataVO.getRegistPassword())) {
                DESCrypto descrypto = new DESCrypto();
                dataVO.setRegistPassword(descrypto.decrypt(dataVO.getRegistPassword()));
            }
        }

        // 태그를 가져온다.
        List<String> list = new ArrayList<String>();
        if(dataVO != null) {
            list = list("_boardWeb.boardTagList", dataVO);
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
        return update("_boardWeb.boardIncRdCnt", boardVO);
    }

    /**
     * 게시물 평가 액션
     */
    public Object scoreAction(BoardVO boardVO) {
        Object result = update("_boardWeb.scoreInc", boardVO);
        return result;
    }

    /**
     * 게시물 추천 액션
     */
    public Object recommAction(BoardVO boardVO) {
        Object result = update("_boardWeb.recommInc", boardVO);
        return result;
    }

    /**
     * 게시물 신고 액션
     */
    public Object accuseAction(BoardVO boardVO) {
        Object result = update("_boardWeb.accuseInc", boardVO);
        return result;
    }

    /**
     * 게시물 등록 액션
     */
    public Object boardInsert(BoardVO boardVO) {

        int fileSeq = fileDao.saveFile(boardVO.getFileList(), boardVO.getFileSeq());
        boardVO.setFileSeq(fileSeq);

        //HTML제거
        boardVO.setBbscttSj(Converter.cleanHtml(boardVO.getBbscttSj()));
        
        if(boardVO.getDomainCd() == 2) {
            boardVO.setCnSumry(StringUtil.omit(StringUtil.replace(StringUtil.replace(Converter.cleanHtmlAndComment(Converter.cleanHtml(StringUtil.replace(StringUtil.replace(boardVO.getBbscttCn(), "&nbsp;", " "), "\"", "'"))), "\t", ""), "\r", ""),  60));
        } else if(boardVO.getDomainCd() == 3) {
            boardVO.setCnSumry(StringUtil.omit(StringUtil.replace(StringUtil.replace(Converter.cleanHtmlAndComment(Converter.cleanHtml(StringUtil.replace(StringUtil.replace(boardVO.getBbscttCn(), "&nbsp;", " "), "\"", "'"))), "\t", ""), "\r", ""),  60));
        } else if(boardVO.getDomainCd() == 4) {
            boardVO.setCnSumry(StringUtil.omit(StringUtil.replace(StringUtil.replace(Converter.cleanHtmlAndComment(Converter.cleanHtml(StringUtil.replace(StringUtil.replace(boardVO.getBbscttCn(), "&nbsp;", " "), "\"", "'"))), "\t", ""), "\r", ""),  60));
        }
        
        
        if(Validate.isNotEmpty(boardVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardVO.setRegistPassword(descrypto.encrypt(boardVO.getRegistPassword()));
        }

        String date = DateFormatUtil.getTodayMsec();

        // 답글 작성시
        if(Validate.isNotEmpty(boardVO.getRefrnSeq())) {
            BoardVO tempVO = boardVO.copyCreateVO();
            int lastChildNo = getMinChildNo(tempVO);
            boardVO.setBbscttOrdrNo(lastChildNo);
            update("_boardWeb.boardUpdateOrderNo", boardVO);
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
        
        insert("_boardWeb.boardInsert", boardVO);

        // 갤러리 게시판인 경우 썸네일을 생성한다.
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        if(BoardConfConstant.GUBUN_BOARD_GALLERY == boardConfVO.getKndCd()) {
            createThumbNail(fileSeq, 100, 100);
        }

        addTags(boardVO);

        return StringUtil.ONE;
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
            if(((Integer) selectByPk("_boardWeb.boardTagCount", boardTagVO)).intValue() > 0) {
                continue;
            }
            insert("_boardWeb.boardTagInsert", boardTagVO);
        }
        
    }

    /**
     * 재귀적 호출을 하여 자식중 orderNo가 최고 낮은 마지막 자식의 orderNo를 넘겨준다.
     */
    private int getMinChildNo(BoardVO boardVO) {
        BoardVO dataVO = new BoardVO();

        while(true) {
            dataVO = (BoardVO) selectByPk("_boardWeb.boardMinChildNode", boardVO);
            if(boardVO.getBbscttOrdrNo().intValue() == dataVO.getBbscttOrdrNo().intValue()) {
                // 현재 제일 마지막 자식 노드의 넘버를 리턴한다.
                return dataVO.getBbscttOrdrNo();
            } else {
                boardVO.setDomainCd(dataVO.getDomainCd());
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
            dataVO = (BoardVO) selectByPk("_boardWeb.boardMaxChildNode", boardVO);
            if(boardVO.getBbscttOrdrNo().intValue() == dataVO.getBbscttOrdrNo().intValue()) {
                // 현재 제일 마지막 자식 노드의 넘버를 리턴한다.
                return dataVO.getBbscttOrdrNo();
            } else {
                boardVO.setDomainCd(dataVO.getDomainCd());
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
        if(Validate.isNotEmpty(boardVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardVO.setRegistPassword(descrypto.encrypt(boardVO.getRegistPassword()));
        }
        boardVO.setUpdtDt(DateFormatUtil.getToday());
        
        if(boardVO.getDomainCd() == 2) {
            boardVO.setCnSumry(StringUtil.omit(StringUtil.replace(StringUtil.replace(Converter.cleanHtmlAndComment(Converter.cleanHtml(StringUtil.replace(StringUtil.replace(boardVO.getBbscttCn(), "&nbsp;", " "), "\"", "'"))), "\t", ""), "\r", ""),  60));
        } else if(boardVO.getDomainCd() == 3) {
            boardVO.setCnSumry(StringUtil.omit(StringUtil.replace(StringUtil.replace(Converter.cleanHtmlAndComment(Converter.cleanHtml(StringUtil.replace(StringUtil.replace(boardVO.getBbscttCn(), "&nbsp;", " "), "\"", "'"))), "\t", ""), "\r", ""),  60));
        } else if(boardVO.getDomainCd() == 4) {
            boardVO.setCnSumry(StringUtil.omit(StringUtil.replace(StringUtil.replace(Converter.cleanHtmlAndComment(Converter.cleanHtml(StringUtil.replace(StringUtil.replace(boardVO.getBbscttCn(), "&nbsp;", " "), "\"", "'"))), "\t", ""), "\r", ""),  60));
        }

        int affected = update("_boardWeb.boardUpdate", boardVO);

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

        affected = update("_boardWeb.boardUpdate", boardVO);

        delete("_boardWeb.boardTagDeleteAll", boardVO);

        addTags(boardVO);

        return affected;
    }

    /**
     * 게시물 삭제 액션
     */
    @SuppressWarnings("unchecked")
    public int boardDelete(BoardVO boardVO, String delDesc, boolean useTrash) {
        BoardVO data = (BoardVO) selectByPk("_boardWeb.boardView", boardVO);
        if(Validate.isEmpty(data.getBbscttSeq())) {
            return 0;
        }

        BoardVO tempVO = data.copyCreateVO();
        int lastChildNo = getMaxChildNo(tempVO);
        data.setBbscttDp(lastChildNo);

        List<BoardVO> dataList = list("_boardWeb.deleteBoardList", data);

        int affected = 0;
        for(BoardVO dataVO : dataList) {
            BoardVO deleteVO = (BoardVO) selectByPk("_boardWeb.boardView", dataVO);
            if(useTrash) {
                deleteVO.setDelDt(DateFormatUtil.getToday());
                deleteVO.setDelDesc(delDesc);
                deleteVO.setCmtSeq(null);

                insert("_boardWeb.trashBoardInsert", deleteVO);
                insert("_boardWeb.trashTagInsert", deleteVO);
                insert("_boardWeb.trashCommentInsert", deleteVO);

                fileDao.removeFile(dataVO.getFileSeq());
            }
            delete("_boardWeb.commentDeleteAll", dataVO);
            delete("_boardWeb.boardTagDeleteAll", dataVO);

            affected += delete("_boardWeb.boardDelete", dataVO);
        }

        return (affected == dataList.size()) ? affected : 0;
    }

    /**
     * 덧글 목록 조회
     */
    @SuppressWarnings("unchecked")
    public Pager<BoardCmtVO> commentList(BoardCmtVO boardCmtVO) {
        Map<String, Object> parameterMap = boardCmtVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardCmtVO);

        int listTotalCount = ((Integer) (selectByPk("_boardWeb.commentListCount", parameterMap))).intValue();

        List<BoardCmtVO> dataList = list("_boardWeb.commentList", parameterMap);
        
        for(BoardCmtVO cmtVo : dataList) {
            cmtVo.setNttCmtCn(Converter.translateBR(cmtVo.getNttCmtCn()));
            cmtVo.setFileList(fileDao.getFiles(cmtVo.getFileSeq()));
            cmtVo.setFileCnt(cmtVo.getFileList().size());
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

        //비즈매칭만 댓글 첨부파일 추가 2015.09.16
        if(boardCmtVO.getBbsCd() == 1010){
            int fileSeq = fileDao.saveFile(boardCmtVO.getFileList(), boardCmtVO.getFileSeq());

            boardCmtVO.setFileSeq(fileSeq);
        }

        String date = DateFormatUtil.getTodayMsec();

        // 답글 작성시
        if(Validate.isNotEmpty(boardCmtVO.getRefrnCmtSeq())) {
            int maxOrderNo = ((Integer) (selectByPk("_boardWeb.boardCmtMaxOrderNo", boardCmtVO))).intValue();
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
        Object result = insert("_boardWeb.commentInsert", boardCmtVO);
        
        return result;
    }

    /**
     * 덧글 상세 보기
     */
    public BoardCmtVO viewComment(BoardCmtVO boardCmtVO) {
        BoardCmtVO dataVO = (BoardCmtVO) selectByPk("_boardWeb.commentView", boardCmtVO);
        if(Validate.isNotEmpty(dataVO) && Validate.isNotEmpty(dataVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            dataVO.setRegistPassword(descrypto.decrypt(dataVO.getRegistPassword()));
        }
        //첨부파일 관련 추가 2015.09.18
        dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
        dataVO.setFileCnt(dataVO.getFileList().size());
        return dataVO;
    }

    /**
     * 덧글 수정 액션
     */
    public Object updateComment(BoardCmtVO boardCmtVO) {
        
        if(Validate.isNotEmpty(boardCmtVO.getRegistPassword())) {
            DESCrypto descrypto = new DESCrypto();
            boardCmtVO.setRegistPassword(descrypto.encrypt(boardCmtVO.getRegistPassword()));
        }
        boardCmtVO.setNttCmtCn(Converter.XSS(boardCmtVO.getNttCmtCn()));

        //비즈매칭만 댓글 첨부파일 추가 2015.09.16
        if(boardCmtVO.getBbsCd() == 1010){           
            int fileSeq = fileDao.saveFile(boardCmtVO.getFileList(), boardCmtVO.getFileSeq());

            boardCmtVO.setFileSeq(fileSeq);
        }

        Object result = update("_boardWeb.commentUpdate", boardCmtVO);
        return result;
    }
    
    /**
     * 덧글 플래그 삭제 액션
     */
    public int cmtFlagDelete(BoardCmtVO boardCmtVO) {
        return update("_boardWeb.updateCmtMngrDelAt", boardCmtVO);
    }

    /**
     * 덧글 삭제 액션
     */
    public String deleteComment(BoardCmtVO boardCmtVO) {
        BoardVO deleteVO = new BoardVO();
        deleteVO.setBbsCd(boardCmtVO.getBbsCd());
        deleteVO.setBbscttSeq(boardCmtVO.getBbscttSeq());
        deleteVO.setCmtSeq(boardCmtVO.getCmtSeq());
        deleteVO.setDelDt(DateFormatUtil.getToday());
        deleteVO.setDelDesc("댓글 개별 삭제");
        insert("_board.trashCommentInsert", deleteVO);
        
        int num=0;
        
        if(boardCmtVO.getBbsCd() == 1010){
            num = delete("_boardWeb.commentDelete", boardCmtVO);
       }else if(boardCmtVO.getRefrnCmtSeq().equals(boardCmtVO.getCmtSeq())){
            //댓글(1Depth)_하위댓글모두삭제
            boardCmtVO.setRefrnCmtSeq(boardCmtVO.getCmtSeq());
        }else{
            //댓글(2Depth)
//            boardCmtVO.setRefrnCmtSeq( "");
        }
        
        if(boardCmtVO.getBbsCd() != 1010){
            num = delete("_boardWeb.updateCmtUserDelYn", boardCmtVO);
        }
        String result = "";
        
        if(num > 0){
             result = "TRUE";
        }
        return result;
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

        List<BoardTagVO> dataList = list("_boardWeb.boardTagAllList", resultVO);

        tagMaxCnt = (Integer) selectByPk("_boardWeb.boardTagMaxCount", resultVO);
        tagMinCnt = (Integer) selectByPk("_boardWeb.boardTagMinCount", resultVO);
        tagAvgCnt = (Integer) selectByPk("_boardWeb.boardTagAvgCount", resultVO);

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
                    logger.debug("thumbnail create failed", e);
                }
            }
        }
    }

    /**
     * recomList 설명
     * @param boardCmtVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> recomList(BoardVO boardVO) {
        List<BoardVO> recomList = list("_boardWeb.recomList", boardVO);
        return recomList;
    }

    /**
     * boardAnswerUpdate 설명
     * @param boardVO
     * @return
     */
    public int boardAnswerUpdate(BoardVO boardVO) {
        int result = update("_boardWeb.boardAnswerUpdate", boardVO);
        return result;
    }

    /**
     * popProduct 서비스 설명
     * @param boardVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<ConsultOrderVO> popProduct(ConsultOrderVO consultOrderVO,BoardVO boardVO) {
        
        Map<String, Object> parameterMap = consultOrderVO.getDataMap();
        
        VoBinder.methodBind(parameterMap, consultOrderVO);
        parameterMap.put("q_searchVal", boardVO.getQ_searchVal());
        parameterMap.put("q_searchType", boardVO.getQ_searchType());
        parameterMap.put("q_searchKey", boardVO.getQ_searchKey());
        parameterMap.put("ordrrId", boardVO.getUserId()); // 로그인ID = 주문자ID = 게시글등록자ID
        parameterMap.put("domainCd", boardVO.getDomainCd());
        parameterMap.put("bbsCd", boardVO.getBbsCd());
        parameterMap.put("langCode", boardVO.getLangCode());
        parameterMap.put("orderNo", boardVO.getOrderNo());
        parameterMap.put("bbscttSeq", boardVO.getBbscttSeq());
        
        int listTotalCount = ((Integer) (selectByPk("_boardWeb.productListCount", parameterMap))).intValue();
        
        consultOrderVO.setTotalNum(listTotalCount);

        parameterMap.put(
            "pagingEndNum",
            Pager.getEndNum(Integer.parseInt(parameterMap.get("pagingStartNum").toString()),
                Integer.parseInt(parameterMap.get("q_rowPerPage").toString())));

        List<ConsultOrderVO> dataList = list("_boardWeb.productOrdrList", parameterMap);
        
        return new Pager<ConsultOrderVO>(dataList, consultOrderVO);
    }
    
    /**
     * 비즈매칭 댓글 선정하기
     * @param boardVo
     * @return
     */
    public int selectionUpdate(BoardVO boardVo) {
        return update("_boardWeb.selectionUpdate", boardVo);
    }

    /**
     * 비즈매칭 댓글_게시판정보조회
     * @param boardCmtVO
     * @return
     */
    public BoardCmtVO cmtBoardView(BoardCmtVO boardCmtVO) {
        BoardCmtVO dataVO = (BoardCmtVO) selectByPk("_boardWeb.cmtBoardView", boardCmtVO);
        return dataVO;
    }

    /**
     * 비즈매칭 댓글_중복체크
     * @param boardCmtVO
     * @return
     */
    public Object bizCommentCheck(BoardCmtVO boardCmtVO) {
        int result = (Integer) selectByPk("_boardWeb.bizCommentCheck", boardCmtVO);
        return result;
    }

    /**
     * productView 설명
     * @param boardVO
     * @return
     */
    public int productView(BoardVO boardVO) {
        boardVO.setBannedWordAt("");
        Map<String, Object> parameterMap =  boardVO.getDataMap();
        
        VoBinder.methodBind(parameterMap, boardVO);
        parameterMap.put("ordrrId", boardVO.getUserId()); // 로그인ID = 주문자ID = 게시글등록자ID
        
        int result = ((Integer) (selectByPk("_boardWeb.productListCount", parameterMap))).intValue();
        return result;
    }

    /**
     * 카테고리에 등록된 서비스의 담당자 리스트정보 조회
     * @param boardVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<RegisterUserVO> categoryUserList(BoardVO boardVO) {
        List<RegisterUserVO> dataList = list("_boardWeb.userCategoryList", boardVO);
        return dataList;
    }
    
    /**
     * 희망 답변자 유저정보 조회
     * @param boardVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<RegisterUserVO> selectCtgryUserList(BoardVO boardVO) {
        List<RegisterUserVO> dataList = list("_boardWeb.selectCtgryUserList", boardVO);
        return dataList;
    }

    /**
     * userBoardSelect 설명
     * @param boardVO
     * @return
     */
    public BoardVO userBoardSelect(BoardVO boardVO) {
        BoardVO dataVO = (BoardVO) selectByPk("_boardWeb.userBoardSelect", boardVO);
        return dataVO;
    }

    /**
     * mgrInfo 설명
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO>  mgrInfo() {
        List<MgrVO> dataList = list("_boardWeb.mgrInfo", null);
        return dataList;
    }

    /**
     * boardAditCtgList 설명
     * @param boardConfVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> boardAditCtgList(BoardVO boardVO) {

        List<BoardVO> AditCtgList = new ArrayList<BoardVO>();
            AditCtgList.addAll(list("_boardWeb.AditCtgList", boardVO));

        return AditCtgList;
    }
    
}
