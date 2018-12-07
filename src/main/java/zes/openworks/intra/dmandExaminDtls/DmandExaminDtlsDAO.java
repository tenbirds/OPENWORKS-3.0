/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDtls;

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
 * 2016. 10. 01.   최강식   신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class DmandExaminDtlsDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * 수요정보조사 목록
     * @param vo
     * @return
     */
    public Pager<DmandExaminDtlsVO> dmandExaminDtlsList(DmandExaminDtlsVO vo) {

        List<DmandExaminDtlsVO> dataList = list("_dmandExaminDtls.dmandExaminDtlsList", vo.getDataMap());

        for(DmandExaminDtlsVO dataVo : dataList){
            // 계약서 파일 정보
            if (Validate.isNotEmpty(dataVo.getFileSeq())) {
                dataVo.setDmandExaminFile(fileDao.getFiles(dataVo.getFileSeq()));
            }
        }
        vo.setTotalNum((Integer) selectByPk("_dmandExaminDtls.dmandExaminDtlsCount", vo.getDataMap()));;

        return new Pager<DmandExaminDtlsVO>(dataList, vo);
    }

    /**
     * 수요정보조사 목록 엑셀 다운로드
     * @param vo
     * @return
     */
    public List<DmandExaminDtlsVO> dmandExaminDtlsListExcel(DmandExaminDtlsVO vo) {

        List<DmandExaminDtlsVO> dataList = list("_dmandExaminDtls.dmandExaminDtlsListExcel", vo.getDataMap());

        for(DmandExaminDtlsVO dataVo : dataList){
            // 계약서 파일 정보
            if (Validate.isNotEmpty(dataVo.getFileSeq())) {
                dataVo.setDmandExaminFile(fileDao.getFiles(dataVo.getFileSeq()));
            }
        }

        return dataList;
    }

}
