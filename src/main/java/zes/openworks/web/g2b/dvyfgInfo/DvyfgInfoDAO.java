/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.dvyfgInfo;

import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


/**
 * @version 2.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)엔키소프트
 *
 *         <pre>
 * << 납품정보(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 11. 29.    guest1       신규
 * </pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class DvyfgInfoDAO extends EgovAbstractMapper {

    /**
     * cntrctInfoCheck (나라장터 납품정보 중복 체크)
     * @param vo
     * @return
     */
    public int dvyfgInfoCheck(DvyfgInfoVO vo) {
        return (Integer) selectByPk("_dvyfgInfo.dvyfgInfoCheck", vo);
    }

    /**
     * cntrctInfoInsertAction (나라장터 납품정보 등록)
     * @param vo
     * @return
     */
    public int dvyfgInfoInsertAction(DvyfgInfoVO vo) {
        return insert("_dvyfgInfo.dvyfgInfoInsertAction", vo);
    }

    /**
     * cntrctInfoUpdateAction (나라장터 납품정보 수정)
     * @param vo
     * @return
     */
    public int dvyfgInfoUpdateAction(DvyfgInfoVO vo) { 
        return update("_dvyfgInfo.dvyfgInfoUpdateAction", vo);
    }  

}
