/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.openworks.intra.mgr.MgrVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 메뉴관리 (외부) DAO
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OP 1.0
 */
@Repository
public class CmsDAO extends EgovAbstractMapper {

    /**
     * 메뉴정보 목록 조회 (계층별 JSON Tree 조회)
     */
    @SuppressWarnings("unchecked")
    public List<TreeVO> getMenuList(CmsVO cmsVo) throws Exception {

        return list("intra.cms.getMenuTreeList", cmsVo);
    }

    /**
     * 현재 메뉴를 포함한 하위 모든 메뉴정보 목록 조회
     */
    @SuppressWarnings("unchecked")
    public List<CmsVO> getBaseMenuList(CmsVO cmsVo) throws Exception {

        return list("intra.cms.getBaseMenuList", cmsVo);
    }

    /**
     * 컨텐츠 담당자의 메뉴정보 목록 조회 (계층별 JSON Tree 조회)
     */
    @SuppressWarnings("unchecked")
    public List<TreeVO> getChargeMenuList(CmsVO cmsVo) throws Exception {

        return list("intra.cms.getChargeMenuList", cmsVo);

    }

    /**
     * 메뉴 상세 조회
     */
    @SuppressWarnings("unchecked")
    public CmsVO getMenu(CmsVO cmsVo) throws Exception {

        CmsVO dataVO = (CmsVO) selectByPk("intra.cms.getMenu", cmsVo);

        List<String> subMenuUrl = list("intra.cms.getSubMenuUrl", cmsVo);

        if(Validate.isNotEmpty(subMenuUrl)) {
            dataVO.setSubMenuUrl(subMenuUrl);
        }

        if(Validate.isNotEmpty(dataVO)) {
            if(Validate.isNotEmpty(dataVO.getFileSeqNo())) {
                dataVO.setFileList(list("_file.list", dataVO.getFileSeqNo()));
            }

            if(Validate.isNotEmpty(dataVO.getChargerId())) {
                MgrVO mgrVo = new MgrVO();
                mgrVo.setMngrId(dataVO.getChargerId());

                dataVO.setChargerInfo((MgrVO) selectByPk("intra.cms.mgrView", mgrVo));
            }

            // 메뉴별 담당자 목록
            if(dataVO.getAuthType() != null && dataVO.getAuthType().equals("MGR")) {
                dataVO.setAuthMgrIdList(getAuthMgrList(cmsVo));
            }

            // 메뉴별 담당자 목록
            dataVO.setUserGradeCd(list("intra.cms.getUserGradeList", cmsVo));
        }

        return dataVO;
    }

    /**
     * 메뉴 등록
     */
    public Object insertMenu(CmsVO cmsVo) throws Exception {

        return insert("intra.cms.insertMenu", cmsVo);
    }

    /**
     * 메뉴 수정
     */
    public int updateMenu(CmsVO cmsVo) throws Exception {

        int uptCnt = update("intra.cms.updateMenu", cmsVo);

        delete("intra.cms.deleteSubMenuUrl", cmsVo);

        if(Validate.isNotEmpty(cmsVo.getSubMenuUrl())) {

            Map<String, String> parameterMap = new HashMap<String, String>();
            parameterMap.put("domainCd", String.valueOf(cmsVo.getDomainCd()));
            parameterMap.put("menuCode", cmsVo.getMenuCode());

            List<String> subMenuUrlList = cmsVo.getSubMenuUrl();
            for(String subMenuUrl : subMenuUrlList) {
                if(Validate.isNotEmpty(subMenuUrl)) {
                    parameterMap.put("subMenuUrl", subMenuUrl);
                    insert("intra.cms.insertSubMenuUrl", parameterMap);
                }
            }
        }

        // 메뉴별 담당자 등록(기존 삭제 후 신규로 등록)
        deleteAuthMgr(cmsVo);
        if(cmsVo.getAuthType() != null && cmsVo.getAuthType().equals("MGR")) {
            insertAuthMgr(cmsVo);
        }

        // 메뉴별 이용가능 회원등급 유형 등록(기존 삭제 후 신규로 등록)
        deleteUserGrade(cmsVo);
        if(Validate.isNotEmpty(cmsVo.getUserGradeCd())) {
            insertUserGrade(cmsVo);
        }

        return uptCnt;
    }

    /**
     * 메뉴 수정
     */
    public int chargerUpdateMenu(CmsVO cmsVo) throws Exception {

        int uptCnt = update("intra.cms.chargerUpdateMenu", cmsVo);

        return uptCnt;
    }

    /**
     * 상위메뉴레이아웃 상속을 설정한 모든 하위 메뉴의 레이아웃 코드를 변경한다.
     * 상위메뉴레이아웃을 초기화 한경우도 해당한다. 이경우는 사이트 기본 레이아웃이
     * 적용되며 DB는 업데이트 하지 않고, CmsCashe 설정된다.
     */
    public int updateChildLayoutCode(CmsVO cmsVo) throws Exception {

        return update("intra.cms.updateChildLayoutCode", cmsVo);
    }

    /**
     * 해당 메뉴 관리 담당자 목록을 반환한다.
     */
    public List<CmsMgrAuthVO> getAuthMgrList(CmsVO cmsVo) throws Exception {

        @SuppressWarnings("unchecked")
        List<CmsMgrAuthVO> authMgrList = list("intra.cms.getAuthMgrList", cmsVo);

        return authMgrList;
    }

    /**
     * 메뉴별 권한담당자 등록
     * (등록된 담당자 모두 삭제 후 등록)
     */
    public void insertAuthMgr(CmsVO cmsVo) throws Exception {

        CmsMgrAuthVO menuAuthVO = new CmsMgrAuthVO();
        menuAuthVO.setDomainCd(cmsVo.getDomainCd());
        menuAuthVO.setMenuCode(cmsVo.getMenuCode());
        menuAuthVO.setRegId(cmsVo.getModId());

        for(String mgrId : cmsVo.getAuthMgrId()) {
            menuAuthVO.setAuthMgrId(mgrId);
            insert("intra.cms.insertAuthMgr", menuAuthVO);
        }

    }

    /**
     * 메뉴별 회원등급 유형 등록
     * (등록된 회원등급 모두 삭제 후 등록)
     */
    public void insertUserGrade(CmsVO cmsVo) throws Exception {

        CmsUserGradeVO cmsUserGradeVo = new CmsUserGradeVO();
        cmsUserGradeVo.setDomainCd(cmsVo.getDomainCd());
        cmsUserGradeVo.setMenuCode(cmsVo.getMenuCode());
        cmsUserGradeVo.setRegId(cmsVo.getModId());

        for(CmsUserGradeVO userGradeVo : cmsVo.getUserGradeCd()) {
            cmsUserGradeVo.setUserGradeCd(userGradeVo.getUserGradeCd());
            insert("intra.cms.insertUserGrade", cmsUserGradeVo);
        }

    }

    /**
     * 해당 메뉴에 등록된 권한 당당자 모두 삭제
     * (수정시 삭제후 재등록 과정으로 처리)
     */
    public int deleteAuthMgr(CmsVO cmsVo) throws Exception {

        int delCnt = delete("intra.cms.deleteAuthMgr", cmsVo);

        return delCnt;
    }

    /**
     * 해당 메뉴에 등록된 회원등급 유형 모두 삭제
     * (수정시 삭제후 재등록 과정으로 처리)
     */
    public int deleteUserGrade(CmsVO cmsVo) throws Exception {

        int delCnt = delete("intra.cms.deleteUserGrade", cmsVo);

        return delCnt;
    }

    /**
     * 메뉴 이동
     */
    public int updateMoveMenu(CmsVO cmsVo) throws Exception {

        return update("intra.cms.updateMoveMenu", cmsVo);
    }

    /**
     * 삭제할 메뉴이미지 단일 정보
     */
    public CmsVO getDeleteMenu(CmsVO cmsVo) throws Exception {

        CmsVO delInfo = (CmsVO) selectByPk("intra.cms.getDeleteMenu", cmsVo);

        return delInfo;
    }

    /**
     * 삭제할 메뉴이미지 목록 정보
     */
    public List<CmsVO> getDeleteMenuList(CmsVO cmsVo) throws Exception {

        @SuppressWarnings("unchecked")
        List<CmsVO> delList = list("intra.cms.getDeleteMenuList", cmsVo);

        return delList;
    }

    /**
     * 메뉴 삭제 릴레이션 관계 테이블 모두 삭제 및 하위 계층 메뉴 모두를 삭제
     */
    public int deleteMenu(CmsVO cmsVo) throws Exception {

        // 컨텐츠 및 메뉴 관련 정보 삭제
        delete("intra.cms.deleteCascadeContent", cmsVo);
        //delete("intra.cms.deleteCascadeSatisfyDetl", cmsVo);
        //delete("intra.cms.deleteCascadeSatisfy", cmsVo);
        delete("intra.cms.deleteCascadeSubUrls", cmsVo);
        delete("intra.cms.deleteCascadeAuthMgr", cmsVo);
        delete("intra.cms.deleteCascadeUserGrade", cmsVo);
        // delete("intra.cms.deleteCascadeStatistics", cmsVo);

        return delete("intra.cms.deleteCascadeMenu", cmsVo);
    }

}
