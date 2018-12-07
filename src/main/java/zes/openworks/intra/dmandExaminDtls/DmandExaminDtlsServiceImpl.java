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

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
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
* 2016. 10. 06.   최강식   신규
*</pre>
* @see
*/

@Service("DmandExaminDtlsService")
public class DmandExaminDtlsServiceImpl extends AbstractServiceImpl implements DmandExaminDtlsService {

    @Resource DmandExaminDtlsDAO dao;

    /* 수요정보조사 목록
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<DmandExaminDtlsVO> dmandExaminDtlsList(DmandExaminDtlsVO vo) {
        return dao.dmandExaminDtlsList(vo);
    }

    /* 엑셀다운로드
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsListExcel(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public  List<DmandExaminDtlsVO> dmandExaminDtlsListExcel(DmandExaminDtlsVO vo){
        return dao.dmandExaminDtlsListExcel(vo);
    }

}
