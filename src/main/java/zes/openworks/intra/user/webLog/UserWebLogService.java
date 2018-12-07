/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.webLog;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.user.UserVO;
import zes.openworks.intra.user.grade.UserGradeVO;

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
public interface UserWebLogService {

    /**
     * userWebLog 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserWebLogVO> userWebLog(UserWebLogVO vo);

    /**
     * userLoginDtIp 설명
     * 
     * @param vo
     * @return
     */
    public String userLoginIp(UserWebLogVO vo);

    /**
     * userWebLogExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserWebLogVO> userWebLogExcel(UserWebLogVO vo);

    /**
     * userWebLogList 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserWebLogVO> userWebLogList(UserVO vo);

    /**
     * userWebLogListExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserVO> userWebLogListExcel(UserVO vo);

    /**
     * getStatistic1 설명
     * 
     * @param vo
     * @return
     */
    public UserWebLogVO getStatistic1(UserWebLogVO vo);

    /**
     * getStatistic2 설명
     * 
     * @param logVo
     * @return
     */
    public List<UserWebLogVO> getStatistic2(UserWebLogVO logVo);

    /**
     * getStatistic3 설명
     * 
     * @param logVo
     * @return
     */
    public UserWebLogVO getStatistic3(UserWebLogVO logVo);

    /**
     * codePrvList 설명
     * 
     * @param grpCd
     * @return List<CodeVO>
     */
    public List<CodeVO> codePrvList(CodeVO codeVo);

    /**
     * userGradeList 설명
     * 
     * @param
     * @return List<UserGradeVO>
     */
    public List<UserGradeVO> userGradeList();
}
