/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmCloseBatch;

import java.util.Calendar;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.core.utils.DateFormatUtil;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 12. 16.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmCloseBatchService") 
public class CmCloseBatchServiceImpl extends AbstractServiceImpl implements CmCloseBatchService{

    @Resource
    private CmCloseBatchDAO dao;
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmCloseBatch.CmCloseBatchService#cmCloseBatchSchedule(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public void cmCloseBatchSchedule() {
        // TODO Auto-generated method stub
        CmManageVO cmvo = new CmManageVO ();
        
        String time= "";
        Calendar cal = Calendar.getInstance();
        //cal.add(Calendar.DATE,  7 ); // 7일 이후 폐쇄 한다는 날짜 설정
        time = DateFormatUtil.getDateShort (cal.getTime());
        cmvo.setCmmntyClsDt(time);
        cmvo.setCmmntyClsId("ompadmin");
        int intCount = dao.cmCloseBatchCount(cmvo); // 1005 폐쇄중 체크
        if(intCount >0){
            dao.cmCloseBatchUpdate(cmvo); // 금일 이전 모든 CMMNTY_STTUS_CD  = 1004 / 폐쇄한다. 1001:신청  1002:승인   1003:승인보류  1004: 커뮤니티 폐쇄  1005 폐쇄중 
        }
    }

}
