/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.layout;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.core.lang.Validate;
import zes.core.utils.SynchronizeUtil;
import zes.openworks.component.domain.DomainDAO;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.cms.CmsConstant;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * Layout 관리 서비스객체
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
 *  2012. 5. 7.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("layoutService")
public class LayoutServiceImpl extends AbstractServiceImpl implements LayoutService {

    @Resource
    private LayoutDAO layoutDAO;
    @Resource
    private DomainDAO domainDAO;

    @Override
    public List<DomainVO> getDomainList(LayoutVO layoutVo) throws Exception {

        return layoutDAO.getDomainList(layoutVo);
    }

    @Override
    public LayoutVO getLayout(LayoutVO layoutVo) throws Exception {

        return layoutDAO.getLayout(layoutVo);
    }

    @Override
    public List<LayoutVO> getLayoutList(LayoutVO layoutVo) throws Exception {

        return layoutDAO.getLayoutList(layoutVo);
    }

    @Override
    public Object insertLayout(LayoutVO layoutVo) throws Exception {

        makeLayoutInfo(layoutVo);

        Object primaryKey = layoutDAO.insertLayout(layoutVo);

        return primaryKey;
    }

    @Override
    public int updateLayout(LayoutVO layoutVo) throws Exception {

        makeLayoutInfo(layoutVo);

        int uptCnt = layoutDAO.updateLayout(layoutVo);

        return uptCnt;
    }

    @Override
    public int deleteLayout(LayoutVO layoutVo) throws Exception {

        //updateLayout(layoutVo);

        return layoutDAO.deleteLayout(layoutVo);
    }

    @Override
    public String synchronize(LayoutVO layoutVo) throws Exception {

        List<DomainGroupVO> domainGroup = domainDAO.getDomainGroupSync(layoutVo.getDomainCd());

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("serviceName", "cmsLayoutSyncService");
        param.put("domainCd", layoutVo.getDomainCd());
        param.put("layoutCode", layoutVo.getLayoutCode());

        return SynchronizeUtil.synchronize(domainGroup, param);
    }

    /**
     * 레이아웃 저장 경로등 기본 정보를 생성한다.
     * 
     * @param layoutVo
     * @throws Exception
     */
    private void makeLayoutInfo(LayoutVO layoutVo) throws Exception {

        String decoratorRoot = CmsConstant.DECORATOR_ROOT;

        Integer domainCd = layoutVo.getDomainCd();

        String savePath = "";
        StringBuilder sb = new StringBuilder();

        if(Validate.isEmpty(layoutVo.getFilePath())) {
            sb.append(decoratorRoot);
            sb.append("/");
            sb.append(domainCd);
            sb.append("/");
        } else {
            savePath = layoutVo.getFilePath().substring(0, layoutVo.getFilePath().lastIndexOf("/"));
            sb.append(savePath);
        }
        // 저장경로(디렉토리 생성용 정보)
        savePath = sb.toString();

        sb.append(layoutVo.getLayoutCode());
        sb.append(".jsp");

        String saveFile = sb.toString();

        layoutVo.setFilePath(saveFile);

    }

}
