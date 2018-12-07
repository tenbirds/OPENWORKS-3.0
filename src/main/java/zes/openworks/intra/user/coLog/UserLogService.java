/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.coLog;

import java.util.List;

import zes.base.pager.Pager;

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
public interface UserLogService {

    /**
     * 회원정보조회이력관리 목록조회
     * 
     * @param vo
     * @return
     */
    public Pager<UserLogVO> userLogListR(UserLogVO vo);

    /**
     * 회원정보출력이력관리 목록조회
     * 
     * @param vo
     * @return
     */
    public Pager<UserLogVO> userLogListO(UserLogVO vo);

    /**
     * userLogListU 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserLogVO> userLogListU(UserLogVO vo);

    /**
     * userLogListRExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserLogVO> userLogListExcel(UserLogVO vo);

    /**
     * menuNmList 설명
     * 
     * @param vo
     * @return
     */
    public List<UserLogVO> menuNmList(UserLogVO vo);

}
