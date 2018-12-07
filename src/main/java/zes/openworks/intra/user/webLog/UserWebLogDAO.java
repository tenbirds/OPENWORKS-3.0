/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.webLog;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.user.UserVO;
import zes.openworks.intra.user.grade.UserGradeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일              수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 22.    유상원                         회원 관리
 * </pre>
 * @see
 */

@Repository
@SuppressWarnings("unchecked")
public class UserWebLogDAO extends EgovAbstractMapper {

    public Pager<UserWebLogVO> userWebLog(UserWebLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("userId", vo.getUserId());

        List<UserWebLogVO> dataList = list("_webLog.userWebLog", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_webLog.userWebLogCount", parameterMap));

        return new Pager<UserWebLogVO>(dataList, vo);

    }

    public String userLoginIp(UserWebLogVO vo) {

        return (String) selectByPk("_webLog.userLoginIp", vo);
    }

    /**
     * userWebLogExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserWebLogVO> userWebLogExcel(UserWebLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("userId", vo.getUserId());
        List<UserWebLogVO> dataList = list("_webLog.userWebLogExcel", parameterMap);

        return dataList;
    }

    /**
     * userWebLogList 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserWebLogVO> userWebLogList(UserVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();

        List<UserWebLogVO> dataList = list("_webLog.userWebLogList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_webLog.userWebLogListCount", parameterMap));

        return new Pager<UserWebLogVO>(dataList, vo);
    }

    /**
     * userWebLogListExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserVO> userWebLogListExcel(UserVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        List<UserVO> dataList = list("_webLog.userWebLogListExcel", parameterMap);

        return dataList;
    }

    /**
     * 금일 로그인 통계
     * getStatistic1 설명
     * 
     * @param vo
     * @return
     */
    public UserWebLogVO getStatistic1(UserWebLogVO vo) {
        UserWebLogVO dataVo = (UserWebLogVO) selectByPk("_webLogState.login", vo);
        return dataVo;
    }

    /**
     * getStatistic2 설명
     * 
     * @param logVo
     * @return
     */
    public List<UserWebLogVO> getStatistic2(UserWebLogVO logVo) {
        return list("_webLogState.userloginIp", logVo);
    }

    /**
     * getStatistic3 설명
     * 
     * @param logVo
     * @return
     */
    public UserWebLogVO getStatistic3(UserWebLogVO logVo) {
        UserWebLogVO dataVo = (UserWebLogVO) selectByPk("_webLogState.loginIptotal", logVo);
        return dataVo;
    }

    /**
     * codePrvList
     * 
     * @param grpCd
     * @return
     */
    public List<CodeVO> codePrvList(CodeVO codeVo) {
        return list("_webLog.codePrvList", codeVo);
    }

    /**
     * userGradeList
     * 
     * @param userGradeVo
     * @return
     */
    public List<UserGradeVO> userGradeList() {
        UserGradeVO userGradeVo = new UserGradeVO();
        userGradeVo.setUseYn("Y");
        return list("intra.user.grade.getUserGradeList", userGradeVo);
    }
}
