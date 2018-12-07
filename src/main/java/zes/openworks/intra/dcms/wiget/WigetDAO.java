/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dcms.wiget;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;
import zes.openworks.intra.board.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 사용자컨텐츠 관리 DAO 객체
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
@Repository
public class WigetDAO extends EgovAbstractMapper {

    /**
     * 화면 폼 목록
     */
    public Pager<WigetVO> getWigetFormList(WigetVO wigetVO) throws Exception {

        @SuppressWarnings("unchecked")
        List<WigetVO> dataList = list("intra.dcms.wiget.getWigetFormList", wigetVO.getDataMap());
        wigetVO.setTotalNum((Integer) (selectByPk("intra.dcms.wiget.getWigetFormListCount", wigetVO.getDataMap())));

        return new Pager<WigetVO>(dataList, wigetVO);
    }

    /**
     * 화면 폼 상세
     */
    public WigetVO getPageForm(WigetVO wigetVO) {
        return (WigetVO) selectByPk("intra.dcms.wiget.getPageForm", wigetVO.getDataMap());
    }

    /**
     * 화면 폼 등록
     */
    @Transactional(rollbackFor = Exception.class)
    public Object insertPageForm(WigetVO wigetVO) throws Exception {
        return insert("intra.dcms.wiget.insertPageForm", wigetVO);
    }

    /**
     * 화면 폼 위젯 영역 등록
     */
    @Transactional(rollbackFor = Exception.class)
    public Object insertWigetArea(WigetVO wigetVO) throws Exception {
        return insert("intra.dcms.wiget.insertWigetArea", wigetVO);
    }

    /**
     * 화면 폼 수정
     */
    @Transactional(rollbackFor = Exception.class)
    public int updatePageForm(WigetVO wigetVO) throws Exception {
        return update("intra.dcms.wiget.updatePageForm", wigetVO);
    }

    /**
     * 화면 폼 위젯 영역 목록
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getWigetAreaList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getWigetAreaList", wigetVO);
    }

    /**
     * 화면 폼 위젯 영역 삭제
     */
    @Transactional(rollbackFor = Exception.class)
    public int deleteWigetArea(WigetVO wigetVO) throws Exception {

        return delete("intra.dcms.wiget.deleteWigetArea", wigetVO);
    }

    /**
     * 위젯 목록
     */
    public Pager<WigetVO> getWigetList(WigetVO wigetVO) throws Exception {

        @SuppressWarnings("unchecked")
        List<WigetVO> dataList = list("intra.dcms.wiget.getWigetList", wigetVO.getDataMap());
        wigetVO.setTotalNum((Integer) (selectByPk("intra.dcms.wiget.getWigetListCount", wigetVO.getDataMap())));

        return new Pager<WigetVO>(dataList, wigetVO);
    }

    /**
     * 위젯 상세
     */
    public WigetVO getWiget(WigetVO wigetVO) {
        return (WigetVO) selectByPk("intra.dcms.wiget.getWiget", wigetVO.getDataMap());
    }

    /**
     * 게시판 목록
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getBbsConfList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getBbsConfList", wigetVO);
    }

    /**
     * 위젯 등록
     */
    @Transactional(rollbackFor = Exception.class)
    public Object insertWiget(WigetVO wigetVO) throws Exception {
        return insert("intra.dcms.wiget.insertWiget", wigetVO);
    }

    /**
     * 위젯 수정
     */
    @Transactional(rollbackFor = Exception.class)
    public int updateWiget(WigetVO wigetVO) throws Exception {
        return update("intra.dcms.wiget.updateWiget", wigetVO);
    }

    /**
     * 위젯 삭제
     */
    @Transactional(rollbackFor = Exception.class)
    public int deleteWiget(WigetVO wigetVO) throws Exception {

        return delete("intra.dcms.wiget.deleteWiget", wigetVO);
    }

    /**
     * 화면 목록
     */
    public Pager<WigetVO> getPageList(WigetVO wigetVO) throws Exception {

        @SuppressWarnings("unchecked")
        List<WigetVO> dataList = list("intra.dcms.wiget.getPageList", wigetVO.getDataMap());
        wigetVO.setTotalNum((Integer) (selectByPk("intra.dcms.wiget.getPageListCount", wigetVO.getDataMap())));

        return new Pager<WigetVO>(dataList, wigetVO);
    }

    /**
     * 화면 상세
     */
    public WigetVO getPage(WigetVO wigetVO) {
        return (WigetVO) selectByPk("intra.dcms.wiget.getPage", wigetVO.getDataMap());
    }

    /**
     * 사용 가능한 화면 폼 목록
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getUsePageFormList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getUsePageFormList", wigetVO);
    }

    /**
     * 화면 폼 및 화면 폼 위젯 목록
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getPageFormAreaList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getPageFormAreaList", wigetVO);
    }

    /**
     * 사이즈가 동일한 위젯 정보 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getEqualSizeWigetList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getEqualSizeWigetList", wigetVO);
    }

    /**
     * 위젯 화면 등록
     */
    @Transactional(rollbackFor = Exception.class)
    public Object insertPage(WigetVO wigetVO) throws Exception {
        return insert("intra.dcms.wiget.insertPage", wigetVO);
    }

    /**
     * 위젯 화면 내용 등록
     */
    @Transactional(rollbackFor = Exception.class)
    public Object insertPageWiget(WigetVO wigetVO) throws Exception {
        return insert("intra.dcms.wiget.insertPageWiget", wigetVO);
    }

    /**
     * 화면 위젯 목록
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getPageWigetList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getPageWigetList", wigetVO);
    }

    /**
     * 화면에 등록된 위젯 정보 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getSetPageWigetList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getSetPageWigetList", wigetVO);
    }

    /**
     * 화면 위젯 수정
     */
    @Transactional(rollbackFor = Exception.class)
    public int updatePage(WigetVO wigetVO) throws Exception {
        return update("intra.dcms.wiget.updatePage", wigetVO);
    }

    /**
     * 화면 위젯 삭제
     */
    @Transactional(rollbackFor = Exception.class)
    public int deletePage(WigetVO wigetVO) throws Exception {
        return delete("intra.dcms.wiget.deletePage", wigetVO);
    }

    /**
     * 화면 위젯 삭제
     */
    @Transactional(rollbackFor = Exception.class)
    public int deletePageWiget(WigetVO wigetVO) throws Exception {
        return delete("intra.dcms.wiget.deletePageWiget", wigetVO);
    }

    /**
     * 화면 위젯 정보 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getAreaPageWigetList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getAreaPageWigetList", wigetVO);
    }

    /**
     * 게시판 목록 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> getBoardList(BoardVO boardVO) throws Exception {

        return list("intra.dcms.wiget.getBoardList", boardVO);
    }

    /**
     * 화면 전체 목록 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<WigetVO> getPageAllList(WigetVO wigetVO) throws Exception {

        return list("intra.dcms.wiget.getPageAllList", wigetVO);
    }
}
