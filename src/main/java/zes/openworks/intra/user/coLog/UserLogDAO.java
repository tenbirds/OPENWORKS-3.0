/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.coLog;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
 *  2012. 5. 22.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Repository
@SuppressWarnings("unchecked")
public class UserLogDAO extends EgovAbstractMapper {

    /**
     * userLogListR 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserLogVO> userLogListR(UserLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();

        List<UserLogVO> dataList = list("_userLog.useLogListR", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_userLog.userLogListCountR", parameterMap));

        return new Pager<UserLogVO>(dataList, vo);
    }

    /**
     * userLogListO 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserLogVO> userLogListO(UserLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();

        List<UserLogVO> dataList = list("_userLog.useLogListO", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_userLog.userLogListCountO", parameterMap));

        return new Pager<UserLogVO>(dataList, vo);
    }

    /**
     * userLogListU 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserLogVO> userLogListU(UserLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();

        List<UserLogVO> dataList = list("_userLog.userLogListU", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_userLog.userLogListUCount", parameterMap));

        return new Pager<UserLogVO>(dataList, vo);
    }

    /**
     * userLogListRExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserLogVO> userLogListExcel(UserLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        String menuType = vo.getLogMenuTy();
        parameterMap.put("menuType", menuType);

        if(menuType.equals("R")) {
            List<UserLogVO> dataList = list("_userLog.userLogListRExcel", parameterMap);
            return dataList;
        } else if(menuType.equals("U")) {
            List<UserLogVO> dataList = list("_userLog.userLogListUExcel", parameterMap);
            return dataList;
        } else {
            List<UserLogVO> dataList = list("_userLog.userLogListOExcel", parameterMap);
            return dataList;
        }
    }

    /**
     * menuNmList 설명
     * 
     * @param vo
     * @return
     */
    public List<UserLogVO> menuNmList(UserLogVO vo) {

        return list("_userLog.menuNmList", vo);
    }

}
