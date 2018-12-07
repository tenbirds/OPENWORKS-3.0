/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.communication.community;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.utils.DateFormatUtil;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
 * 2014. 11. 11.    		 boseok       	신규
 *</pre>
 * @see
 */
@Repository
public class CmTotalMainDAO  extends EgovAbstractMapper {

    /**  
     * 커뮤니티 개설신청 목록
     * @param vo
     * @return pager   request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
    */
   @SuppressWarnings("unchecked")
    public Pager<CmManageVO> cmTotalMainList(CmManageVO vo){
       
       Map<String, Object> paraMap = vo.getDataMap();
       
       String time= "";
       Calendar cal = Calendar.getInstance();
       //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-ddHH24:mm:ss");
       //log.info("sdf:::::::::::>>>>>>sdf>>>>>>>>>>"+sdf.toString());
       time = DateFormatUtil.getDateShort (cal.getTime());
       
       paraMap.put("cmmntyCtgryCd", vo.getCmmntyCtgryCd());
       paraMap.put("langCode",vo.getLangCode());
       paraMap.put("cmmntySttusCd",vo.getCmmntySttusCd());
       paraMap.put("q_startDt", time);
       if(paraMap.get("q_cmSortListTab") == null){
           paraMap.put("q_cmSortListTab","1001");  // 기본 탭 전체 목록
       }

       if(paraMap.get("langCode") == null){
           paraMap.put("langCode","00");  // 기본 언어 한국어
       }
       
       if(paraMap.get("cmmntySttusCd") == null){
           paraMap.put("cmmntySttusCd","1002");  // 커뮤니티 승인 상태 1002 
       }
       List<CmManageVO> cmTotalMainList = list("_cmTotalMain.cmTotalMainList", paraMap);
       vo.setTotalNum((Integer)selectByPk("_cmTotalMain.cmTotalMainListCount",paraMap));
       return new Pager<CmManageVO>(cmTotalMainList, vo);  
   }
}
