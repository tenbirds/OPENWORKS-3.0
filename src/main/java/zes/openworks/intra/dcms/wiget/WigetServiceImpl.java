/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dcms.wiget;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.component.domain.DomainDAO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.cms.CmsDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 사용자컨텐츠 서비스 객체
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
@Service(" wigetService")
public class WigetServiceImpl extends AbstractServiceImpl implements WigetService {

    @Resource
    private CmsDAO cmsDAO;
    @Resource
    private WigetDAO wigetDAO;
    @Resource
    private DomainDAO domainDAO;

    @Override
    public Pager<WigetVO> getWigetFormList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getWigetFormList(wigetVo);
    }

    @Override
    public WigetVO getPageForm(WigetVO wigetVo) throws Exception {

        return wigetDAO.getPageForm(wigetVo);
    }

    @Override
    public Object insertPageForm(WigetVO wigetVo) throws Exception {

        /** OP_CMS_PAGE_FORM 등록 */
        String primaryKey = (String) wigetDAO.insertPageForm(wigetVo);

        /** OP_CMS_WIGET_AREA 등록 */
        if(primaryKey != null && Integer.parseInt(primaryKey) > 0) {
            wigetVo.setPageFormCd(primaryKey);

            if(wigetVo.getArrSizeWidth() != null && wigetVo.getArrSizeHight() != null && wigetVo.getArrStartX() != null
                && wigetVo.getArrStartY() != null) {
                for(int i = 0 ; i < wigetVo.getArrSizeWidth().length ; i++) {
                    String wigetAreaWidth = (String) wigetVo.getArrSizeWidth()[i];
                    String wigetAreaHeight = (String) wigetVo.getArrSizeHight()[i];
                    String wigetAreaX = (String) wigetVo.getArrStartX()[i];
                    String wigetAreaY = (String) wigetVo.getArrStartY()[i];

                    wigetVo.setSizeWidth(wigetAreaWidth);
                    wigetVo.setSizeHeight(wigetAreaHeight);
                    wigetVo.setStartX(wigetAreaX);
                    wigetVo.setStartY(wigetAreaY);

                    wigetDAO.insertWigetArea(wigetVo);
                }
            }
        }

        return primaryKey;
    }

    @Override
    public List<WigetVO> getWigetAreaList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getWigetAreaList(wigetVo);
    }

    @Override
    public Object updatePageForm(WigetVO wigetVo) throws Exception {

        /** OP_CMS_PAGE_FORM 수정 */
        Integer actStatus = (int) wigetDAO.updatePageForm(wigetVo);

        /** OP_CMS_WIGET_AREA 수정 */
        if(actStatus > 0) {
            /** 기존 정보 삭제 */
            wigetDAO.deleteWigetArea(wigetVo);

            wigetVo.setPageFormCd(wigetVo.getQ_pageFormCd());

            if(wigetVo.getArrSizeWidth() != null && wigetVo.getArrSizeHight() != null && wigetVo.getArrStartX() != null
                && wigetVo.getArrStartY() != null) {
                for(int i = 0 ; i < wigetVo.getArrSizeWidth().length ; i++) {
                    String wigetAreaWidth = (String) wigetVo.getArrSizeWidth()[i];
                    String wigetAreaHeight = (String) wigetVo.getArrSizeHight()[i];
                    String wigetAreaX = (String) wigetVo.getArrStartX()[i];
                    String wigetAreaY = (String) wigetVo.getArrStartY()[i];

                    wigetVo.setSizeWidth(wigetAreaWidth);
                    wigetVo.setSizeHeight(wigetAreaHeight);
                    wigetVo.setStartX(wigetAreaX);
                    wigetVo.setStartY(wigetAreaY);

                    wigetDAO.insertWigetArea(wigetVo);
                }
            }

        }

        return actStatus;
    }

    @Override
    public Pager<WigetVO> getWigetList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getWigetList(wigetVo);
    }

    @Override
    public WigetVO getWiget(WigetVO wigetVo) throws Exception {

        return wigetDAO.getWiget(wigetVo);
    }

    @Override
    public List<WigetVO> getBbsConfList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getBbsConfList(wigetVo);
    }

    @Override
    public Object insertWiget(WigetVO wigetVo) throws Exception {

        return wigetDAO.insertWiget(wigetVo);
    }

    @Override
    public Object updateWiget(WigetVO wigetVo) throws Exception {

        return wigetDAO.updateWiget(wigetVo);
    }

    @Override
    public Object deleteWiget(WigetVO wigetVo) throws Exception {

        return wigetDAO.deleteWiget(wigetVo);
    }

    @Override
    public Pager<WigetVO> getPageList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getPageList(wigetVo);
    }

    @Override
    public WigetVO getPage(WigetVO wigetVo) throws Exception {

        return wigetDAO.getPage(wigetVo);
    }

    @Override
    public List<WigetVO> getUsePageFormList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getUsePageFormList(wigetVo);
    }

    @Override
    public List<WigetVO> getPageFormAreaList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getPageFormAreaList(wigetVo);
    }

    @Override
    public List<WigetVO> getEqualSizeWigetList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getEqualSizeWigetList(wigetVo);
    }

    @Override
    public Object insertPage(WigetVO wigetVo) throws Exception {
        /** OP_CMS_PAGE 등록 */
        String primaryKey = (String) wigetDAO.insertPage(wigetVo);

        /** OP_CMS_PAGE_WIGET 등록 */
        if(primaryKey != null && Integer.parseInt(primaryKey) > 0) {
            wigetVo.setPageCd(primaryKey);

            if(wigetVo.getArrPageWiget() != null && wigetVo.getArrPageWiget().length > 0) {
                for(int i = 0 ; i < wigetVo.getArrPageWiget().length ; i++) {
                    String[] spitWigetInfo = wigetVo.getArrPageWiget()[i].split("_");

                    wigetVo.setWigetAreaCd(spitWigetInfo[1]);
                    wigetVo.setWigetCd(spitWigetInfo[2]);

                    wigetDAO.insertPageWiget(wigetVo);
                }
            }
        }

        return primaryKey;
    }

    @Override
    public List<WigetVO> getPageWigetList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getPageWigetList(wigetVo);
    }

    @Override
    public List<WigetVO> getSetPageWigetList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getSetPageWigetList(wigetVo);
    }

    @Override
    public Object updatePage(WigetVO wigetVo) throws Exception {
        /** OP_CMS_PAGE 수정 */
        int primaryKey = wigetDAO.updatePage(wigetVo);

        /** OP_CMS_PAGE_WIGET 등록 */
        if(primaryKey > 0) {
            wigetDAO.deletePageWiget(wigetVo);

            wigetVo.setPageCd(wigetVo.getQ_pageCd());

            if(wigetVo.getArrPageWiget() != null && wigetVo.getArrPageWiget().length > 0) {
                for(int i = 0 ; i < wigetVo.getArrPageWiget().length ; i++) {
                    String[] spitWigetInfo = wigetVo.getArrPageWiget()[i].split("_");

                    wigetVo.setWigetAreaCd(spitWigetInfo[1]);
                    wigetVo.setWigetCd(spitWigetInfo[2]);

                    wigetDAO.insertPageWiget(wigetVo);
                }
            }
        }

        return primaryKey;
    }

    @Override
    public Object deletePage(WigetVO wigetVo) throws Exception {
        int primaryKey = wigetDAO.deletePage(wigetVo);

        if(primaryKey > 0)
            wigetDAO.deletePageWiget(wigetVo);

        return primaryKey;
    }

    @Override
    public List<WigetVO> getAreaPageWigetList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getAreaPageWigetList(wigetVo);
    }

    @Override
    public List<BoardVO> getBoardList(BoardVO boardVo) throws Exception {

        return wigetDAO.getBoardList(boardVo);
    }

    @Override
    public List<WigetVO> getPageAllList(WigetVO wigetVo) throws Exception {

        return wigetDAO.getPageAllList(wigetVo);
    }
}
