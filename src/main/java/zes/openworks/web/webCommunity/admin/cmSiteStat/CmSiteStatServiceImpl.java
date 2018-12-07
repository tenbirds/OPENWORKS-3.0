/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmSiteStat;

import java.util.Calendar;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.core.lang.Validate;
import zes.core.utils.DateCalcUtil;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.intra.analyze.statistic.common.ResultVO;


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
@Service("CmSiteStatService")
public class CmSiteStatServiceImpl extends AbstractServiceImpl implements  CmSiteStatService {

    @Resource
    private CmSiteStatDAO dao;
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatService#cmSiteVisitCountStat(zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatVO)
     */
    @Override
    public ResultVO cmSiteVisitCountStat(CmSiteStatVO vo) {
        // TODO Auto-generated method stub
        defaultSearchDate(vo);
        return dao.cmSiteVisitCountStat(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatService#cmSiteBoardCountStat(zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatVO)
     */
    @Override
    public ResultVO cmSiteBoardCountStat(CmSiteStatVO vo) {
        // TODO Auto-generated method stub
        defaultSearchDate(vo);
        return dao.cmSiteBoardCountStat(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatService#cmSiteBoardCmtCountStat(zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatVO)
     */
    @Override
    public ResultVO cmSiteBoardCmtCountStat(CmSiteStatVO vo) {
        // TODO Auto-generated method stub
        defaultSearchDate(vo);
        return  dao.cmSiteBoardCmtCountStat(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatService#cmSitePageViewCountStat(zes.openworks.web.webCommunity.admin.cmSiteStat.CmSiteStatVO)
     */
    @Override
    public ResultVO cmSitePageViewCountStat(CmSiteStatVO vo) {
        // TODO Auto-generated method stub
        return dao.cmSitePageViewCountStat(vo);
    }
    
    /**
     * 검색일자 기본값을 셋팅
     * 
     * @param vo
     */
    protected void defaultSearchDate(CmSiteStatVO vo) {
        if(Validate.isEmpty(vo.getStartDate()) || Validate.isEmpty(vo.getEndDate())) {
            // 입력된 날짜가 없는경우(최초조회)에는 오늘 날짜를 기본값으로 한다
            String today = DateFormatUtil.getTodayShort();
            vo.setStartDate(today.substring(0, 8));
            vo.setEndDate(today.substring(0, 8));
            vo.setPastStartDate(DateCalcUtil.addDate(-1, today));
            vo.setPastEndDate(DateCalcUtil.addDate(-1, today));
        } else {
            if(vo.getSearchUnit().equals("DATE")) {
                vo.setPastStartDate(DateCalcUtil.addDate(-1, vo.getStartDate()));
                vo.setPastEndDate(DateCalcUtil.addDate(-1, vo.getStartDate()));
            } else if(vo.getSearchUnit().equals("WEEK")) {
                setPastWeek(vo);
            } else if(vo.getSearchUnit().equals("MONTH")) {
                setPastMonth(vo);
            }
        }
    }
    
 // 전주 날짜 설정
    private void setPastWeek(CmSiteStatVO vo) {
        Calendar basisDay = DateFormatUtil.getCalendarObj(DateCalcUtil.addDate(-7, vo.getStartDate()));
        int currentDaw = basisDay.get(Calendar.DAY_OF_WEEK);
        if(currentDaw == Calendar.MONDAY) {
            basisDay.add(Calendar.DATE, -1);
        } else {
            basisDay.add(Calendar.DATE, -(currentDaw - 1));
        }
        
        String startDt =  DateCalcUtil.parseCalendar2(basisDay.get(Calendar.YEAR), basisDay.get(Calendar.MONTH) + 1, basisDay.get(Calendar.DATE));
        vo.setPastStartDate(startDt);
        basisDay.add(Calendar.DATE, 6);
        String endDt = DateCalcUtil.parseCalendar2(basisDay.get(Calendar.YEAR), basisDay.get(Calendar.MONTH) + 1, basisDay.get(Calendar.DATE));
        vo.setPastEndDate(endDt);
    }

    // 전월 날짜 설정
    private void setPastMonth(CmSiteStatVO vo) {
        String startDate = vo.getStartDate();
        Calendar calendar = DateFormatUtil.getCalendarObj(startDate);
        calendar.add(Calendar.MONTH, -1);
        String pastDay = DateFormatUtil.getDateString(calendar);

        Calendar basisDay = DateFormatUtil.getCalendarObj(pastDay);
        int currentYear = basisDay.get(Calendar.YEAR);
        int currentMonth = basisDay.get(Calendar.MONTH) + 1;
        int lastDay = basisDay.getActualMaximum(Calendar.DATE);

        String startDt = DateCalcUtil.parseCalendar2(currentYear, currentMonth, StringUtil.ONE);
        vo.setPastStartDate(startDt);
        String endDt = startDt.substring(0, 6) + lastDay;
        vo.setPastEndDate(endDt);
    }

  
}
