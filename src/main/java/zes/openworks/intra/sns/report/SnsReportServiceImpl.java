/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.sns.report;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
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
 *  2013. 4. 29.    구선모   생성
 * </pre>
 * @see
 */
@Service("snsReportService")
public class SnsReportServiceImpl extends AbstractServiceImpl implements SnsReportService {

    @Resource
    private SnsReportDAO dao;

    @Override
    public Pager<SnsReportVO> snsReportList(SnsReportVO vo) {
        return dao.snsReportList(vo);
    }

    @Override
    public int snsReportDelUpdate(HttpServletRequest request, String userId) {

        String[] delParam = request.getParameter("delParam").replace("[", "").replace("]", "").split("\",\"");
        String type = request.getParameter("type");

        int cnt = 0;
        String snsOption = "";

        for(String temp : delParam)
        {
            SnsReportVO vo = new SnsReportVO();

            String[] params = temp.replace("\"", "").split(",");

            vo.setDomain_cd(params[0].toString());
            vo.setMenu_code(params[1].toString());
            vo.setPage_url(params[2].toString());
            vo.setSeq(params[3].toString());
            vo.setModi_id(userId);

            if(cnt == 0) {
                snsOption = dao.getDomainOption(vo);
            }

            vo.setDel_yn(type);

            if(snsOption.equals("Y")) {
                cnt += dao.snsDel(vo);
            } else {
                cnt += dao.snsReportDelUpdate(vo);
            }

        }

        return cnt;
    }

    @Override
    public List<SnsReportVO> getMenuCodeList(SnsReportVO vo) {

        return dao.getMenuCodeList(vo);
    }

}
