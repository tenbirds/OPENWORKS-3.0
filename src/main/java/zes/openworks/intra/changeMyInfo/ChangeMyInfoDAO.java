/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.changeMyInfo;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.openworks.intra.mgr.LoggingMgrVO;
import zes.openworks.intra.mgr.MgrVO;


/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 10.    김영상       신규
 *</pre>
 * @see
 */
@Repository
public class ChangeMyInfoDAO extends EgovAbstractMapper {

    /**
     * 나의 정보 보기
     */
    public MgrVO viewMyInfo(MgrVO vo) {
        MgrVO myVo = (MgrVO) selectByPk("_changeMyInfo.viewMyInfo", vo);

        if(myVo != null && Validate.isNotEmpty(myVo.getMngrPassword())) {
            myVo.setMngrPassword(myVo.getMngrPassword());
        }

        return myVo;
    }

    /**
     * 나의 정보 수정 액션
     */
    public int updateMyInfo(MgrVO vo) {

        if(Validate.isNotEmpty(vo.getMngrPassword())) {
            Crypto cry = CryptoFactory.getInstance();
            vo.setMngrPassword(cry.encrypt(vo.getMngrPassword()));
        }

        vo.setModiDt(DateFormatUtil.getTodayFull());

        int result = update("_changeMyInfo.updateMyInfo", vo);
        logging(vo, "U");

        return result;
    }

    /**
     * 나의 비밀번호 수정 액션
     */
    public int updateMyPwd(MgrVO vo) {

        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setMngrPassword(cry.encrypt(vo.getMngrPassword()));
        vo.setModiDt(DateFormatUtil.getTodayFull());
        int _result = 0;
        //현재비밀번호나 이전비밀번호와 같은지 체크
        String currentPwd = (String)selectByPk("_changeMyInfo.currentPwd", vo);
        String beforePwd = (String)selectByPk("_changeMyInfo.beforePwd", vo);
        if(Validate.isNotEmpty(beforePwd) && (vo.getMngrPassword().equals(currentPwd) || vo.getMngrPassword().equals(beforePwd))){
            _result = -1;
        }else{
            if(vo.getMngrPassword().equals(currentPwd)) {
                _result = -1;
            } else {
                vo.setModiDt(DateFormatUtil.getTodayFull());
    
                _result = update("_changeMyInfo.updatePwd", vo);
            }
        }

        return _result;
    }

    /**
     * logging
     */
    private void logging(MgrVO vo, String logType) {
        LoggingMgrVO log = new LoggingMgrVO();
        log.setMngrId(vo.getMngrId());
        log.setLogTy(logType);
        log.setUpdtId(vo.getModiId());

        insert("_mgr.logging", log);
    }

    /**
     * 담당자 아이디로 권한코드,권한명,권한타입코드 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO> currentlyList(MgrVO vo) {
        return list("_mgr.currentlyList", vo);
    }
}
