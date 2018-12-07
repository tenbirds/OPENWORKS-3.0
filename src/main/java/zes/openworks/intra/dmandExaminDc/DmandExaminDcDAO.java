/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDc;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;


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
 * 2016. 10. 01.   최강식   신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class DmandExaminDcDAO extends EgovAbstractMapper{

    /**
     * 수요조사 설명회 목록
     * @param vo
     * @return
     */
    public Pager<DmandExaminDcVO> dmandExaminDcList(DmandExaminDcVO vo) {

        vo.getDataMap().put("partcptSe", vo.getPartcptSe());

        List<DmandExaminDcVO> dataList = list("_dmandExaminDc.dmandExaminDcList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_dmandExaminDc.dmandExaminDcCount", vo.getDataMap()));;

        return new Pager<DmandExaminDcVO>(dataList, vo);
    }

    /**
     * 수요조사 설명회 목록 엑셀 다운로드
     * @param vo
     * @return
     */
    public List<DmandExaminDcVO> dmandExaminDcListExcel(DmandExaminDcVO vo) {

        vo.getDataMap().put("partcptSe", vo.getPartcptSe());
        return  list("_dmandExaminDc.dmandExaminDcListExcel", vo.getDataMap());

    }




}
