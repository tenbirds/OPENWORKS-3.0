/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.webLog;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.user.UserVO;
import zes.openworks.intra.user.grade.UserGradeVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
 *  2012. 5. 22.    유상원   회원 관리
 * </pre>
 * @see
 */

@Service("userWebLogService")
public class UserWebLogServiceImpl extends AbstractServiceImpl implements UserWebLogService {

    @Resource
    private UserWebLogDAO dao;

    @Override
    public Pager<UserWebLogVO> userWebLog(UserWebLogVO vo) {
        return dao.userWebLog(vo);
    }

    @Override
    public String userLoginIp(UserWebLogVO vo) {
        return dao.userLoginIp(vo);
    }

    @Override
    public List<UserWebLogVO> userWebLogExcel(UserWebLogVO vo) {
        return dao.userWebLogExcel(vo);
    }

    @Override
    public Pager<UserWebLogVO> userWebLogList(UserVO vo) {
        return dao.userWebLogList(vo);
    }

    @Override
    public List<UserVO> userWebLogListExcel(UserVO vo) {
        return dao.userWebLogListExcel(vo);
    }

    @Override
    public UserWebLogVO getStatistic1(UserWebLogVO vo) {
        return dao.getStatistic1(vo);
    }

    @Override
    public List<UserWebLogVO> getStatistic2(UserWebLogVO logVo) {
        return dao.getStatistic2(logVo);
    }

    @Override
    public UserWebLogVO getStatistic3(UserWebLogVO logVo) {
        return dao.getStatistic3(logVo);
    }

    @Override
    public List<CodeVO> codePrvList(CodeVO codeVo) {
        return dao.codePrvList(codeVo);
    }

    @Override
    public List<UserGradeVO> userGradeList() {
        return dao.userGradeList();
    }
}
