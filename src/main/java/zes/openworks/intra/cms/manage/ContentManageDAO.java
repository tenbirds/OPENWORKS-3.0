/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.manage;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.intra.cms.CmsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 사용자 컨텐츠 승인/반려 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 21.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class ContentManageDAO extends EgovAbstractMapper {

    /**
     * 승인 대상 컨텐츠 목록
     */
    @SuppressWarnings("unchecked")
    public Pager<ContentManageVO> getApproveContentList(ContentManageVO contentManageVo) {

        List<ContentManageVO> dataList = list("intra.cms.manage.getApproveContentList", contentManageVo.getDataMap());
        contentManageVo.setTotalNum((Integer) selectByPk("intra.cms.manage.getApproveContentListCount", contentManageVo.getDataMap()));

        return new Pager<ContentManageVO>(dataList, contentManageVo);
    }

    /**
     * 승인 대상 컨텐츠 상세
     */
    public ContentManageVO getApproveContent(ContentManageVO contentManageVo) {

        return (ContentManageVO) selectByPk("intra.cms.manage.getApproveContent", contentManageVo.getDataMap());
    }

    /**
     * 승인 대상 컨텐츠 승인/반려 액션
     */
    public int approveAction(ContentManageVO contentManageVo) {

        if(contentManageVo.getApprovalSt().equals("1040")) {
            update("intra.cms.manage.updateApplyN", contentManageVo);

            CmsVO cmsVO = new CmsVO();
            cmsVO.setDomainCd(contentManageVo.getDomainCd());
            cmsVO.setMenuCode(contentManageVo.getMenuCode());
            cmsVO.setContentSeqNo(contentManageVo.getCntntsSeq());

            update("intra.cms.updateContentInfo", cmsVO);
        }

        return update("intra.cms.manage.updateApprovalSt", contentManageVo);
    }

}
