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

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.SynchronizeUtil;
import zes.openworks.component.domain.DomainDAO;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.user.grade.UserGradeDAO;
import zes.openworks.intra.user.grade.UserGradeVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 사용자메뉴 관리 서비스 객체
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OP 1.0
 */
@Service("cmsService")
public class CmsServiceImpl extends AbstractServiceImpl implements CmsService {

    @Resource
    private CmsDAO cmsDAO;
    @Resource
    private DomainDAO domainDAO;
    @Resource
    private UserGradeDAO userGradeDAO;

    /** 케쉬 클레스명 */
    private static String CACHE_CLASS_NAME = "CmsCache";

    @Override
    public List<UserGradeVO> getUserGradeList(CmsVO cmsVo) throws Exception {

        UserGradeVO userGradeVo = new UserGradeVO();
        userGradeVo.setUseYn("Y");

        return userGradeDAO.getUserGradeList(userGradeVo);
    }

    @Override
    public List<TreeVO> getMenuList(CmsVO cmsVo) throws Exception {

        return cmsDAO.getMenuList(cmsVo);
    }

    @Override
    public List<TreeVO> getChargeMenuList(CmsVO cmsVo) throws Exception {

        return cmsDAO.getChargeMenuList(cmsVo);
    }

    @Override
    public CmsVO getMenu(CmsVO cmsVo) throws Exception {

        return cmsDAO.getMenu(cmsVo);
    }

    @Override
    public Object createMenu(CmsVO cmsVo) throws Exception {

        // 사이트 루트 더미 메뉴 생성
        String topMenuCode = Config.getString("cms.rootMenu.topMenuCode");
        String parentMenuCode = Config.getString("cms.rootMenu.parentMenuCode");
        String menuCode = Config.getString("cms.rootMenu.menuCode");
        String menuNm = Config.getString("cms.rootMenu.menuNm");
        Integer menuDepth = Config.getInt("cms.rootMenu.menuDepth");
        Integer sortOrder = Config.getInt("cms.rootMenu.sortOrder");

        cmsVo.setLinkType(CmsConstant.DEFAULT_LINK_TYPE);
        cmsVo.setTopMenuCode(topMenuCode);
        cmsVo.setParentMenuCode(parentMenuCode);
        cmsVo.setMenuCode(menuCode);
        cmsVo.setMenuNm(menuNm);
        cmsVo.setMenuPath(menuNm);
        cmsVo.setBasePath("");
        cmsVo.setMenuDepth(menuDepth);
        cmsVo.setSortOrder(sortOrder);

        cmsDAO.insertMenu(cmsVo);

        // 실 사이트 트리 루트 메뉴 등록
        topMenuCode = Config.getString("cms.defaultMenu.topMenuCode");
        parentMenuCode = Config.getString("cms.defaultMenu.parentMenuCode");
        menuNm = Config.getString("cms.defaultMenu.menuNm");
        menuDepth = Config.getInt("cms.defaultMenu.menuDepth");
        sortOrder = Config.getInt("cms.defaultMenu.sortOrder");

        String domainNm = cmsVo.getDomainNm();
        domainNm = domainNm.trim();
        menuCode = domainNm.substring(0, domainNm.indexOf("."));

        cmsVo.setLinkType(CmsConstant.DEFAULT_LINK_TYPE);
        cmsVo.setTopMenuCode(topMenuCode);
        cmsVo.setParentMenuCode(parentMenuCode);
        cmsVo.setMenuCode(menuCode);
        cmsVo.setMenuNm(menuNm);
        cmsVo.setMenuPath(menuNm);
        cmsVo.setBasePath("/");
        cmsVo.setMenuDepth(menuDepth);
        cmsVo.setSortOrder(sortOrder);

        return cmsDAO.insertMenu(cmsVo);
    }

    @Override
    public int deleteMenuAdapter(Integer domainCd, String paramParentMenuCode) throws Exception {

        String parentMenuCode = Validate.isEmpty(paramParentMenuCode) ? Config
            .getString("cms.defaultMenu.parentMenuCode") : paramParentMenuCode;

        CmsVO cmsVo = new CmsVO();
        cmsVo.setDomainCd(domainCd);
        cmsVo.setMenuCode(parentMenuCode);
        cmsVo.setParentMenuCode(parentMenuCode);

        return deleteMenu(cmsVo);
    }

    @Override
    public Object insertMenu(CmsVO cmsVo) throws Exception {

     // 정보 승계를 위해 부모 메뉴 정보를 불러온다.
        CmsVO parentMenuVO = new CmsVO();
        parentMenuVO.setDomainCd(cmsVo.getDomainCd());
        parentMenuVO.setMenuCode(cmsVo.getParentMenuCode());
        parentMenuVO = getMenu(parentMenuVO);

        // 등록할 정보 설정
        cmsVo.setBasePath(parentMenuVO.getBasePath() + parentMenuVO.getMenuCode() + "/");
        if(Validate.isNotEmpty(parentMenuVO.getMenuPath())) {
            cmsVo.setMenuPath(parentMenuVO.getMenuPath() + " > " + cmsVo.getMenuNm());
        } else {
            cmsVo.setMenuPath(cmsVo.getMenuNm());
        }
        cmsVo.setMenuDepth(parentMenuVO.getMenuDepth() + 1);

        if(parentMenuVO.getMenuDepth() == 0) {
            cmsVo.setTopMenuCode(cmsVo.getMenuCode());
            cmsVo.setParentLayoutUseYn("N");
        } else {
            cmsVo.setTopMenuCode(parentMenuVO.getTopMenuCode());
            cmsVo.setParentLayoutUseYn("Y");
        }

        cmsVo.setLinkType(CmsConstant.DEFAULT_LINK_TYPE);

        return cmsDAO.insertMenu(cmsVo);
    }

    /*
     * @see
     * zes.openworks.intra.cms.CmsService#updateMenu(zes.openworks.intra.cms
     * .CmsVO)
     */
    @Override
    public int updateMenu(CmsVO cmsVo) throws Exception {

        // 정보 승계를 위해 부모 메뉴 정보를 불러온다.
        CmsVO parentMenuVO = new CmsVO();
        parentMenuVO.setDomainCd(cmsVo.getDomainCd());
        parentMenuVO.setMenuCode(cmsVo.getParentMenuCode());
        parentMenuVO = getMenu(parentMenuVO);

        // 최상위 메뉴가 아닌경우 경로 정보 설정(보정을 위해서라도 부모 메뉴를 사용한다.)
        if(Validate.isNotEmpty(parentMenuVO) && parentMenuVO.getMenuDepth() > -1) {

            cmsVo.setBasePath(parentMenuVO.getBasePath() + parentMenuVO.getMenuCode() + "/");

            cmsVo.setMenuPath(parentMenuVO.getMenuPath() + " > " + cmsVo.getMenuNm());

            // 상위메뉴레이아웃 상속을 설정했다면 상위메뉴 레이아웃 코드를 가져온다.
            if(Validate.isNotEmpty(cmsVo.getParentLayoutUseYn())) {
                cmsVo.setLayoutCode(parentMenuVO.getLayoutCode());
            }
        }

        cmsVo.setMenuDepth(parentMenuVO.getMenuDepth() + 1);

        // 레이아웃이 변경된 경우를 확인하여 하위 메뉴 설정 변경을 적용한다.
        if(!cmsVo.getPreLayoutCode().equals(cmsVo.getLayoutCode())) {
            cmsDAO.updateChildLayoutCode(cmsVo);
        }

        // 기존 이미지 삭제 후 등록
        deleteMenuImg(cmsVo);

        // 이미지 메뉴 사용 업로드시 등록
        if(Validate.isNotEmpty(cmsVo.getFileList())) {
            if(cmsVo.getFileSeqNo() == null) {
                cmsVo.setFileSeqNo(-1);
            }

            cmsVo.setFileSeqNo(-1);
        }

        int updCnt = cmsDAO.updateMenu(cmsVo);

        return updCnt;
    }

    /*
     * @see
     * zes.openworks.intra.cms.CmsService#chargerUpdateMenu(zes.openworks.intra
     * .cms.CmsVO)
     */
    @Override
    public int chargerUpdateMenu(CmsVO cmsVo) throws Exception {

        int updCnt = cmsDAO.chargerUpdateMenu(cmsVo);

        return updCnt;
    }

    /*
     * @see
     * zes.openworks.intra.cms.CmsService#updateMoveMenu(zes.openworks.intra
     * .cms.CmsVO)
     */
    @Override
    public int updateMoveMenu(CmsVO cmsVo) throws Exception {

        int updateCnt = 0;
        CmsVO parentMenuVO = new CmsVO();

        List<CmsVO> dataList = cmsDAO.getBaseMenuList(cmsVo);
        for(CmsVO dataVo : dataList) {
            // 정보 승계를 위해 부모 메뉴 정보를 불러온다.
            parentMenuVO.setDomainCd(cmsVo.getDomainCd());

            if(cmsVo.getMenuCode().equals(dataVo.getMenuCode())) {
                parentMenuVO.setMenuCode(cmsVo.getParentMenuCode());
                dataVo.setSortOrder(cmsVo.getSortOrder());
            } else {
                parentMenuVO.setMenuCode(dataVo.getParentMenuCode());
            }

            parentMenuVO = getMenu(parentMenuVO);

            // 최상위 메뉴가 아닌경우 경로 정보 설정(보정을 위해서라도 부모 메뉴를 사용한다.)
            if(Validate.isNotEmpty(parentMenuVO) && parentMenuVO.getMenuDepth() > -1) {

                dataVo.setBasePath(parentMenuVO.getBasePath() + parentMenuVO.getMenuCode() + "/");
                dataVo.setMenuPath(parentMenuVO.getMenuPath() + " > " + dataVo.getMenuNm());
                dataVo.setMenuDepth(parentMenuVO.getMenuDepth() + 1);

                if(parentMenuVO.getMenuDepth() > 0) {
                    dataVo.setTopMenuCode(parentMenuVO.getTopMenuCode());
                } else {
                    dataVo.setTopMenuCode(dataVo.getMenuCode());
                }

                dataVo.setParentMenuCode(parentMenuVO.getMenuCode());

                // 상위메뉴레이아웃 상속을 설정했다면 상위메뉴 레이아웃 코드를 가져온다.
                if(Validate.isNotEmpty(dataVo.getParentLayoutUseYn())) {
                    dataVo.setLayoutCode(parentMenuVO.getLayoutCode());
                }

                updateCnt += cmsDAO.updateMoveMenu(dataVo);
            }

        }

        return updateCnt;
    }

    /*
     * @see
     * zes.openworks.intra.cms.CmsService#deleteMenu(zes.openworks.intra.cms
     * .CmsVO)
     */
    @Override
    public int deleteMenu(CmsVO cmsVo) throws Exception {

        CmsVO delCmsVo = getMenu(cmsVo);

        // 하위 메뉴 파일 삭제
        List<CmsVO> delList = cmsDAO.getDeleteMenuList(cmsVo);

        for(CmsVO delInfo : delList) {
            CmsUtil.deleteFile(delInfo.getTitleImg());
            CmsUtil.deleteFile(delInfo.getMenuTitleImg());
            CmsUtil.deleteFile(delInfo.getMenuOnImg());
            CmsUtil.deleteFile(delInfo.getMenuOffImg());
            if(delInfo.getMenuType() != null && delInfo.getMenuType().equals("content")) {
                CmsUtil.deleteFile(delInfo.getUserMenuUrl());
            }
        }

        if(delCmsVo.getMenuType() != null && delCmsVo.getMenuType().equals("content")) {
            CmsUtil.deleteFile(delCmsVo.getUserMenuUrl());
        }

        int deleteCnt = cmsDAO.deleteMenu(cmsVo);

        return deleteCnt;
    }

    @Override
    public String synchronize(CmsVO cmsVo) throws Exception {

        List<DomainGroupVO> domainGroup = domainDAO.getDomainGroupSync(cmsVo.getDomainCd());

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("serviceName", "cmsMenuSyncService");
        param.put("domainCd", cmsVo.getDomainCd());
        param.put("cacheName", CACHE_CLASS_NAME);

        return SynchronizeUtil.synchronize(domainGroup, param);
    }

    /**
     * 메뉴 이미지 삭제(DB 정보 및 물리적 파일 삭제)
     * 
     * @param cmsVo
     * @throws Exception
     */
    private void deleteMenuImg(CmsVO cmsVo) throws Exception {

        CmsVO delInfo = cmsDAO.getDeleteMenu(cmsVo);

        if(Validate.isNotEmpty(delInfo)) {
            if(Validate.isEmpty(cmsVo.getTitleImg()) || !cmsVo.getTitleImg().equals(delInfo.getTitleImg())) {
                CmsUtil.deleteFile(delInfo.getTitleImg());
            }

            if(Validate.isEmpty(cmsVo.getMenuTitleImg()) || !cmsVo.getMenuTitleImg().equals(delInfo.getMenuTitleImg())) {
                CmsUtil.deleteFile(delInfo.getMenuTitleImg());
            }

            if(Validate.isEmpty(cmsVo.getMenuOnImg()) || !cmsVo.getMenuOnImg().equals(delInfo.getMenuOnImg())) {
                CmsUtil.deleteFile(delInfo.getMenuOnImg());
            }

            if(Validate.isEmpty(cmsVo.getMenuOffImg()) || !cmsVo.getMenuOffImg().equals(delInfo.getMenuOffImg())) {
                CmsUtil.deleteFile(delInfo.getMenuOffImg());
            }
        }
    }

}
