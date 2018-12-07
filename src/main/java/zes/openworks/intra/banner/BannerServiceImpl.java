/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.banner;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.advertisement.AdvrtsVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("bannerService")
public class BannerServiceImpl extends AbstractServiceImpl implements BannerService {

    @Resource
    private BannerDAO dao;

    @Override
    public Pager<BannerVO> bannerList(BannerVO vo) {
        return dao.bannerList(vo);
    }

    @Override
    public List<BannerVO> bannerTypeList(BannerVO vo) {
        return dao.bannerTypeList(vo);
    }

    @Override
    public int bannerInsertAction(BannerVO vo, HttpServletRequest request) {

        int cnt = dao.bannerInsertAction(vo);
        
        //사이트
        String[] domainCds = request.getParameter("domainCds1").split(",");        
            for(String domainCd : domainCds) {
                vo.setDomainCd(Integer.parseInt(domainCd));
                dao.bannerInsertDomainCd(vo);        
        }
        
        //메뉴구분
        String[] bannerLcSeCds = request.getParameter("bannerLcSeCds1").split(",");        
        for(String bannerLsCeCd : bannerLcSeCds){
            if(Validate.isNotEmpty(bannerLsCeCd)){
                vo.setBannerLcSeCd(Integer.parseInt(bannerLsCeCd));
                dao.bannerInsertLsSeCd(vo);
            }
        }
        

        return cnt;
    }

    @Override
    public BannerVO bannerUpdateForm(BannerVO vo) {
        /* FileUtil.delete(GlobalConfig.WEBAPP_ROOT + baseFileVo.getFileUrl()); */
        return dao.bannerUpdateForm(vo);
    }

    @Override
    public int bannerUpdate(BannerVO vo, HttpServletRequest request) {
        dao.bannerUpdate(vo);
        dao.bannerDomainDel(vo);
        dao.bannerLcInfoDel(vo);
        String[] domainCds = request.getParameter("domainCds1").split(",");
        for(String domainCd : domainCds) {
            vo.setDomainCd(Integer.parseInt(domainCd));
            dao.bannerInsertDomainCd(vo);
        }
        
        //메뉴구분
        String[] bannerLcSeCds = request.getParameter("bannerLcSeCds1").split(",");        
            for(String bannerLsCeCd : bannerLcSeCds){
                if(Validate.isNotEmpty(bannerLsCeCd)){
                    vo.setBannerLcSeCd(Integer.parseInt(bannerLsCeCd));
                    dao.bannerInsertLsSeCd(vo);
                }
            }
        
        return 0;
    }

    @Override
    public int fileDel(BannerVO vo) {
        String filePath = dao.filePath(vo);
        FileUtil.delete(GlobalConfig.RESOURCE_ROOT + filePath);
        return dao.fileDel(vo);
    }

    @Override
    public List<BannerVO> domainList(BannerVO vo) {
        return dao.domainList(vo);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.banner.BannerService#bannerLcSeList(zes.openworks.intra.banner.BannerVO)
     */
    public List<BannerVO> bannerLcSeList(BannerVO vo) {
        return dao.bannerLcSeList(vo);
    }

    @Override
    public List<BannerVO> bannerDomainList(BannerVO vo) {
        return dao.bannerDomainList(vo);
    }

    @Override
    public List<BannerVO> orderList(BannerVO vo) {
        return dao.orderList(vo);
    }

    @Override
    public int orderUpdate(BannerVO vo, HttpServletRequest request) {
        String[] seqs = request.getParameter("seqs").split(",");
        vo.setDomainCd(Integer.parseInt(request.getParameter("domainCds")));
        for(String seq : seqs) {
            vo.setBannerSn(Integer.parseInt(seq));
            dao.orderDelete(vo);
            dao.orderUpdate(vo);
        }
        return 0;
    }

    @Override
    public int bannerInsertAction(BannerVO vo) {
        dao.bannerInsertAction(vo);
        return 0;
    }

    @Override
    public int useYnUpdateAction(BannerVO vo) {

        return dao.useYnUpdateAction(vo);
    }

    @Override
    public int bannerDeleteAction(BannerVO vo) {    
        
        //유형 삭제 (Y/N)
        return dao.bannerAtDeleteAction(vo);
        
        //완전 삭제
        //return dao.bannerDeleteAction(vo);

    }

    @Override
    public List<AdvrtsVO> advrtsList(AdvrtsVO avo) {

        return dao.advrtsList(avo);
    }
}
