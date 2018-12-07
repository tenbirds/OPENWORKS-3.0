/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.cache;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.spi.oscache.Cache;
import zes.core.spi.oscache.ICache;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.cms.CmsVO;
import zes.openworks.intra.mgr.MgrVO;

/**
 * <pre>
 * 사용자단 메뉴 케쉬 객체
 * 모든 메뉴 케쉬는 동일 메뉴정보의 레퍼런스를 유지 하도록
 * 개별 객체를 생성을 하지 않도록 하여 관리 한다.
 *
 * </pre>
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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CmsCache implements ICache {

    public static final String DOMAIN_MAP = "_DM";
    public static final String TOP_MENU_LIST = "_TL";
    public static final String TOP_MENU_VO = "_TM";
    public static final String ALL_MENU_MAP = "_AM";
    public static final String ALL_SUB_LIST = "_ASL";
    public static final String ALL_CTG_LIST = "_ACL";

    /** 환경설정 객체 */
    private static final Integer MIN_MENU_DEPTH = Config.getInt("cms.topMenuDepth.minDepth");
    private static final Integer MAX_MENU_DEPTH = Config.getInt("cms.topMenuDepth.maxDepth");

    /**
     * 사이트별 케시 리로드
     */
    public void createCacheDomain(SqlSession sqlSession, Integer domainCd) {

        try {
            List<DomainVO> domainList = null;
            List<CmsVO> userTopMenuList = null;

            Map<String, CmsVO> userAllMenuMap = null;

            DomainVO pDomainVO = new DomainVO();
            domainList = sqlSession.selectList("component.domain.getDomainList", pDomainVO);
            Cache.put(GlobalConfig.KEY_DOMAIN_LIST, domainList);

            pDomainVO.setUseYn("Y");

            if(Validate.isNotEmpty(domainCd)) {
                pDomainVO.setDomainCd(domainCd);
            }

            // 사이트 목록 케쉬
            domainList = sqlSession.selectList("component.domain.getDomainList", pDomainVO);
            for(DomainVO domainVO : domainList) {
                Cache.put(domainVO.getDomainNm() + DOMAIN_MAP, domainVO);
            }

            // 사이트 별 메뉴 맵과 목록을 생성
            for(DomainVO domainVO : domainList) {

                userAllMenuMap = new HashMap<String, CmsVO>();
                String domainNm = domainVO.getDomainNm();

                if(logger.isDebugEnabled()) {
                    logger.debug(domainNm + " ==> Cache START");
                }

                CmsVO pCmsVO = new CmsVO();
                pCmsVO.setDomainCd(domainVO.getDomainCd());

                // TOP 메뉴 표시 뎁스
                pCmsVO.setMinMenuDepth(MIN_MENU_DEPTH);
                pCmsVO.setMaxMenuDepth(MAX_MENU_DEPTH);
                pCmsVO.setUseYn("Y");

                // 사이트의 최상위 메뉴를 목록 케쉬
                userTopMenuList = sqlSession.selectList("intra.cms.getMenuList", pCmsVO);
                Cache.put(domainNm + TOP_MENU_LIST, userTopMenuList);

                for(CmsVO cmsVo : userTopMenuList) {

                    if(Validate.isNotEmpty(cmsVo.getUserMenuUrl())) {
                        userAllMenuMap.put(cmsVo.getUserMenuUrl(), cmsVo);
                    }
                    List<String> subMenuUrl = sqlSession.selectList("intra.cms.getSubMenuUrl", cmsVo);
                    cmsVo.setSubMenuUrl(subMenuUrl);

                    if(cmsVo.getMenuDepth().equals(1)) {

                        if(Validate.isNotEmpty(cmsVo.getChargerId())) {
                            MgrVO mgrVo = new MgrVO();
                            mgrVo.setMngrId(cmsVo.getChargerId());

                            cmsVo.setChargerInfo((MgrVO) sqlSession.selectOne("intra.cms.mgrView", mgrVo));
                        }

                        setChildMenu(sqlSession, cmsVo, userAllMenuMap);

                        // 사이트의 최상위 메뉴를 기준으로 한 목록 케쉬
                        Cache.put(domainNm + cmsVo.getMenuCode() + TOP_MENU_VO, cmsVo);

                    }

                }
                // 사이트의 최상위 메뉴를 기준으로 한 목록 케쉬
                Cache.put(domainNm + ALL_MENU_MAP, userAllMenuMap);


                //전체 서브메뉴 리스트 캐쉬
                CmsVO cmsAsVo = new CmsVO();
                cmsAsVo.setDomainCd(domainVO.getDomainCd());
                Cache.put(domainNm + ALL_SUB_LIST, sqlSession.selectList("_userguide.getAllMenuList",cmsAsVo));

                //서비스 카테고리 리스트 캐쉬
                Map<String, Object> vo = new HashMap<String, Object>();
                vo.put("ctgryCode", "0");
                vo.put("langCode", "00");
                Cache.put(domainNm + ALL_CTG_LIST, sqlSession.selectList("_userguide.getCtgryList",vo));

                if(logger.isDebugEnabled()) {
                    logger.debug("{} ==> Cache END", domainNm);
                }
            }

        } catch (SQLException e) {
            logger.error("CMS Cache error", e);
        }
    }

    /**
     * 하위 메뉴 계층 구조를 위한 쿼리 설정
     * 재귀 반복을 통하여 셋팅한다.
     *
     * @param sqlSession
     * @param cmsVo
     * @return
     * @throws SQLException
     */
    private void setChildMenu(SqlSession sqlSession, CmsVO cmsVo, Map<String, CmsVO> userAllMenuMap) throws SQLException {

        List<CmsVO> childList = cmsVo.getChildList();

        if(cmsVo.getLeaf().equals("0") && Validate.isNotEmpty(childList)) {

            for(CmsVO childVO : childList) {

                CmsVO paramVo = new CmsVO();
                paramVo.setDomainCd(childVO.getDomainCd());
                paramVo.setTopMenuCode(childVO.getTopMenuCode());
                paramVo.setParentMenuCode(childVO.getMenuCode());
                paramVo.setUseYn("Y");
                List<CmsVO> cList = sqlSession.selectList("intra.cms.getMenuList", paramVo);
                childVO.setChildList(cList);

                if(childVO.getUserMenuUrl() != null) {

                    if(Validate.isNotEmpty(childVO.getChargerId())) {
                        MgrVO mgrVo = new MgrVO();
                        mgrVo.setMngrId(childVO.getChargerId());

                        childVO.setChargerInfo((MgrVO) sqlSession.selectOne("intra.cms.mgrView", mgrVo));
                    }

                    List<String> subMenuUrl = sqlSession.selectList("intra.cms.getSubMenuUrl", childVO);
                    childVO.setSubMenuUrl(subMenuUrl);

                    userAllMenuMap.put(childVO.getUserMenuUrl(), childVO);

                }
                setChildMenu(sqlSession, childVO, userAllMenuMap);
            }
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.core.spi.oscache.ICache#createCache(com.ibatis.sqlmap.client
     * .SqlSession)
     */
    @Override
    public void createCache(SqlSession sqlSession) {
        createCacheDomain(sqlSession, null);
    }

    /**
     * 사이트별 케시 리로드
     *
     * @param sqlSession
     * @param domainCd
     */
    @Override
    public void reloadCache(SqlSession sqlSession, Integer domainCd) {

        if(logger.isDebugEnabled()) {
            logger.debug("\r\n");
            logger.debug("This createCache Class is ==> " + this.getClass().getPackage().getName() + this.getClass().getName() + "#reloadCache");
            logger.debug("\r\n");
        }

        createCacheDomain(sqlSession, domainCd);
    }

    @Override
    public String getName() {

        return "CMS 메뉴 정보";
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.core.spi.oscache.ICache#reloadCache(com.ibatis.sqlmap.client.SqlSession
     * )
     */
    @Override
    public void reloadCache(SqlSession sqlSession) {
        reloadCache(sqlSession, null);
    }
}
