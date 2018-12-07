/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.masub;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일               수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 16.     홍길동     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("masterSubService")
public class MasterSubServiceImpl extends AbstractServiceImpl implements MasterSubService {

    @Resource
    private MasterSubDao dao;

    @Override
    public Pager<MasterSubVO> subBoardList(MasterSubVO vo) {
        return dao.subBoardList(vo);
    }

    @Override
    public int subBoardAction(MasterSubVO vo, HttpServletRequest request) {
        return dao.subBoardAction(vo);
    }

    @Override
    public MasterSubVO subBoardDetail(MasterSubVO vo) {
        return dao.subBoardDetail(vo);
    }
    @Override
    public List<MasterSubVO> subBoardReplyDetail(MasterSubVO vo) {
        return dao.subBoardReplyDetail(vo);
    }
    
}
