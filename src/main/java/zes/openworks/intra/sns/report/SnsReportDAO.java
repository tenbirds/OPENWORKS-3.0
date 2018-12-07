/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.sns.report;

import java.util.List;

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
 *  2013. 4. 29.    구선모   생성
 * </pre>
 * @see
 */
@Repository
public class SnsReportDAO extends EgovAbstractMapper {

    /**
     * snsReportList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<SnsReportVO> snsReportList(SnsReportVO vo) {

        List<SnsReportVO> dataList = list("_snsReport.list", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_snsReport.listCount", vo.getDataMap()));
        return new Pager<SnsReportVO>(dataList, vo);
    }

    /**
     * snsReportDelUpdate 설명
     * 
     * @param vo
     * @return
     */
    public int snsReportDelUpdate(SnsReportVO vo) {
        return update("_snsReport.snsDelUpdate", vo);
    }

    /**
     * snsReportDel 설명
     * 
     * @param vo
     * @return
     */
    public int snsDel(SnsReportVO vo) {
        return update("_snsReport.snsDel", vo);
    }

    /**
     * snsReportDel 설명
     * 
     * @param vo
     * @return
     */
    public String getDomainOption(SnsReportVO vo) {
        return (String) selectByPk("_snsReport.getDomainOption", vo);
    }

    /**
     * 메뉴리스트조회
     * 
     * @param request
     * @param crudVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<SnsReportVO> getMenuCodeList(SnsReportVO vo) {
        return list("_snsReport.getMenuCodeList", vo);
    }

}
