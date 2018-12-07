/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dcms.wiget;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.board.BoardVO;

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
public interface WigetService {

    /**
     * 화면 폼 목록
     */
    Pager<WigetVO> getWigetFormList(WigetVO wigetVo) throws Exception;

    /**
     * 화면 폼 상세
     */
    WigetVO getPageForm(WigetVO wigetVo) throws Exception;

    /**
     * 화면 폼 등록
     */
    Object insertPageForm(WigetVO wigetVo) throws Exception;

    /**
     * 화면 수정 등록
     */
    Object updatePageForm(WigetVO wigetVo) throws Exception;

    /**
     * 화면 폼 위젯 영역 목록
     */
    List<WigetVO> getWigetAreaList(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 목록
     */
    Pager<WigetVO> getWigetList(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 상세
     */
    WigetVO getWiget(WigetVO wigetVo) throws Exception;

    /**
     * 게시판 목록
     */
    List<WigetVO> getBbsConfList(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 등록
     */
    Object insertWiget(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 수정
     */
    Object updateWiget(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 삭제
     */
    Object deleteWiget(WigetVO wigetVo) throws Exception;

    /**
     * 화면 목록
     */
    Pager<WigetVO> getPageList(WigetVO wigetVo) throws Exception;

    /**
     * 화면 상세
     */
    WigetVO getPage(WigetVO wigetVo) throws Exception;

    /**
     * 사용 가능한 화면 폼 목록
     */
    List<WigetVO> getUsePageFormList(WigetVO wigetVo) throws Exception;

    /**
     * 화면 폼 및 화면 폼 위젯 목록
     */
    List<WigetVO> getPageFormAreaList(WigetVO wigetVo) throws Exception;

    /**
     * 사이즈가 동일한 위젯 정보 가져오기
     */
    List<WigetVO> getEqualSizeWigetList(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 화면 등록
     */
    Object insertPage(WigetVO wigetVo) throws Exception;

    /**
     * 화면 위젯 목록
     */
    List<WigetVO> getPageWigetList(WigetVO wigetVo) throws Exception;

    /**
     * 화면에 등록된 위젯 정보 가져오기
     */
    List<WigetVO> getSetPageWigetList(WigetVO wigetVo) throws Exception;

    /**
     * 위젯 화면 수정
     */
    Object updatePage(WigetVO wigetVo) throws Exception;

    /**
     * 화면 삭제
     */
    Object deletePage(WigetVO wigetVo) throws Exception;

    /**
     * 화면 위젯 정보 가져오기
     */
    List<WigetVO> getAreaPageWigetList(WigetVO wigetVo) throws Exception;

    /**
     * 게시물 목록
     */
    List<BoardVO> getBoardList(BoardVO boardVo) throws Exception;

    /**
     * 화면 전체 목록 가져오기
     */
    List<WigetVO> getPageAllList(WigetVO wigetVo) throws Exception;

}
