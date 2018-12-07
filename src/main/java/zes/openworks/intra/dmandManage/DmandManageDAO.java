/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandManage;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;


/**
 *
 *
 * @version 1.0
 * @since
 * @author
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 09. 07.   손은국   신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class DmandManageDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * 수요조사 목록
     * @param vo
     * @return
     */
    public Pager<DmandManageVO> dmandManageList(DmandManageVO vo) {

        List<DmandManageVO> dataList = list("dmandManage.dmandManageList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("dmandManage.dmandManageCount", vo.getDataMap()));

        return new Pager<DmandManageVO>(dataList, vo);
    }
    public Pager<DmandManageVO> dmandManageList2018(DmandManageVO vo) {

        List<DmandManageVO> dataList = list("dmandManage.dmandManageList2018", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("dmandManage.dmandManageCount2018", vo.getDataMap()));

        return new Pager<DmandManageVO>(dataList, vo);
    }

    /**
     * 제출현황 목록
     * @param vo
     * @return
     */
    public Pager<DmandManageVO> dmandPresentnList(DmandManageVO vo) {
        
        List<DmandManageVO> dataList = list("dmandManage.dmandPresentnList", vo.getDataMap());
        vo.setTotalNum(0);

        return new Pager<DmandManageVO>(dataList, vo);
    }
    public Pager<DmandManageVO> dmandPresentnList2018(DmandManageVO vo) {
        
        List<DmandManageVO> dataList = list("dmandManage.dmandPresentnList2018", vo.getDataMap());
        vo.setTotalNum(0);

        return new Pager<DmandManageVO>(dataList, vo);
    }

    /**
     * 제출현황 미제출 기관목록 엑셀 다운로드
     * @param vo
     * @return
     */
    public List<DmandManageVO> dmandPresentnUnsubMission(DmandManageVO vo) {
        return list("dmandManage.dmandPresentnUnsubMission", vo.getDataMap());
    }
    public List<DmandManageVO> dmandPresentnUnsubMission2018(DmandManageVO vo) {
        return list("dmandManage.dmandPresentnUnsubMission2018", vo.getDataMap());
    }

    /**
     * 수요조사 통계(요약) 목록
     * @param vo
     * @return
     */
    public Pager<DmandManageVO> dmandStatsList(DmandManageVO vo) {
        
        List<DmandManageVO> dataList = list("dmandManage.dmandStatsList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("dmandManage.dmandStatsCount", vo.getDataMap()));
        
        return new Pager<DmandManageVO>(dataList, vo);
    }
    
    /**
     * 수요조사 통계(기관유형) 목록
     * @param vo
     * @return
     */
    public Pager<DmandManageVO> dmandNsttList(DmandManageVO vo) {
        
        List<DmandManageVO> dataList = list("dmandManage.dmandNsttList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("dmandManage.dmandNsttCount", vo.getDataMap()));
        
        return new Pager<DmandManageVO>(dataList, vo);
    }
    
    /**
     * 제출현황 전체 갯수 부분
     * @param vo
     * @return
     */
    public List<DmandManageVO> presentnTotalCount(DmandManageVO vo) {
        return list("dmandManage.presentnTotalCount", vo.getDataMap());
    }
    public List<DmandManageVO> presentnTotalCount2018(DmandManageVO vo) {
        return list("dmandManage.presentnTotalCount2018", vo.getDataMap());
    }

    /**
     * 수요조사 기간 
     * @param vo
     * @return
     */
    public List<DmandManageVO> dmandRegustMngr(DmandManageVO vo) {
        return list("dmandManage.dmandRegustMngr", vo);
    }
}
