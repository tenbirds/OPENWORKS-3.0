/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.store.premium.PremiumVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2014. 11. 20.     김영상      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository("webMainDAO")
public class MainDao extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * 게시물 최근 목록 조회
     *
     * @param : bbsCd
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> boardList(Integer bbsCd, Integer domainCd) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        List<BoardVO> dataList = null;
        parameterMap.put("domainCd", domainCd);                         //사이트
        parameterMap.put("bbsCd", bbsCd);                               //게시판코드
        if(bbsCd.equals(1009)) {            //성공사례
            parameterMap.put("cutTitleNum", 30);                            //제목이 길 경우 자를 글자수(0이면 자르지 않음)
            parameterMap.put("rowNum", MainConstant.MAIN_SUCCES_STY_CNT);   //성공스토리 최근 게시물 가져올 갯수

            dataList = list("_main.boardRecentList", parameterMap);
            for(BoardVO dataVO : dataList) {
                dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
                dataVO.setFileCnt(dataVO.getFileList().size());
            }
        } else if(bbsCd.equals(1007)) {     //행사 및 이벤트
            parameterMap.put("cutTitleNum", 0);                             //제목이 길 경우 자를 글자수(0이면 자르지 않음)
            parameterMap.put("rowNum", MainConstant.MAIN_EVENT_COUNT);      //성공스토리 최근 게시물 가져올 갯수
            dataList = list("_main.boardRecentList", parameterMap);
        } else {                            //기타 게시판(공지)
            parameterMap.put("cutTitleNum", MainConstant.CUT_TITLE_NUM);    //제목이 길 경우 자를 글자수(0이면 자르지 않음)
            parameterMap.put("rowNum", MainConstant.RECENT_ARTICLE_COUNT);  //최근 게시물 가져올 갯수
            dataList = list("_main.boardRecentList", parameterMap);
        }
        
        return dataList;
    }

    @SuppressWarnings("unchecked")
    public String boardList1(Integer bbsCd, Integer domainCd) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        String dataList = "";
        parameterMap.put("domainCd", domainCd);                         //사이트
        parameterMap.put("bbsCd", bbsCd);                               //게시판코드

        dataList = (String) selectByPk("_main.boardRecentList1", parameterMap);
        
        return dataList;
    }


    /**
     * 게시물 최근 목록 조회
     *
     * @param : bbsCd
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> knwldgHubList(Integer domainCd) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        List<BoardVO> dataList = null;
        parameterMap.put("domainCd", domainCd);                         //사이트
        parameterMap.put("cutTitleNum", 20);    //제목이 길 경우 자를 글자수
        parameterMap.put("rowNum", MainConstant.MAIN_KNWLDG_HUB_CNT);   //최근 게시물 가져올 갯수
        dataList = list("_main.knwldgHubList", parameterMap);
        for(BoardVO dataVO : dataList) {
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
            dataVO.setFileCnt(dataVO.getFileList().size());
        }
        return dataList;
    }

    /**
     * PopupZoneListToday 설명
     *
     * @param bannerVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> PopupZoneListToday(BannerVO bannerVO) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("bannerTyCd", bannerVO.getBannerTyCd());
        parameterMap.put("domainCd", bannerVO.getDomainCd());
        return list("_main.PopupZoneListToday", parameterMap);
    }

    /**
     * quickMenuListToday 설명
     *
     * @param bannerVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> quickMenuListToday(BannerVO bannerVO) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("bannerTyCd", bannerVO.getBannerTyCd());
        parameterMap.put("domainCd", bannerVO.getDomainCd());
        return list("_main.PopupZoneListToday", parameterMap);
    }

    /**
     * bannerListToday 설명
     *
     * @param bannerVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> bannerListToday(BannerVO bannerVO) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("bannerLcSeCd", bannerVO.getBannerLcSeCd());
        parameterMap.put("bannerTyCd", bannerVO.getBannerTyCd());
        parameterMap.put("domainCd", bannerVO.getDomainCd());
        return list("_main.bannerListToday", parameterMap);
    }


    /**
     * rcmdList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> rcmdList(PremiumVO vo) {
        List<PremiumVO> dataList = null;
        if(vo.getGoodsTyCd() == 1003){  //컨설팅은 신청건수 많은 5개 서비스
            dataList = list("_main.cntl5List", vo);
        }else{
            dataList = list("_main.rcmdList", vo);
        }

        for(PremiumVO data : dataList) {
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
            if(Validate.isNotEmpty(data.getCngdMarkList())){
                data.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
            }

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size(); i++){
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }

            if(! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * top10List 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> top10List(PremiumVO vo, String se) {
        List<PremiumVO> dataList = null;
        HashMap<String, Object> tt = new HashMap<String, Object>();

        tt.put("se", se);
        tt.put("langCode", vo.getLangCode());
        dataList = list("_main.top10List", tt);

        for(PremiumVO data : dataList) {
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
        }

        return dataList;
    }

    /**
     * mainGoodsList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> mainGoodsList(PremiumVO vo, String se) {
        List<PremiumVO> dataList = null;
        HashMap<String, Object> tt = new HashMap<String, Object>();

        tt.put("se", se);
        tt.put("langCode", vo.getLangCode());
        dataList = list("_main.mainGoodsList", tt);

        for(PremiumVO data : dataList) {
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
        }

        return dataList;
    }

    /**
     * bestSellList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> bestSellList(PremiumVO vo) {
        List<PremiumVO> dataList = null;

        dataList = list("_main.bestSellerList", vo);
        return dataList;
    }

    /**
     * bidInfoMainList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BidInfoVO> bidInfoMainList(BidInfoVO vo) {
        List<BidInfoVO> dataList = null;

        dataList = list("_main.bidInfoMainList", vo);
        return dataList;
    }
    
    /**
     * bidInfoMainList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<MyCeartBidNotifyVO> bidNofiyMainList(MyCeartBidNotifyVO vo) {
        return list("_main.bidNofiyMainList", vo);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String, Object> mainCntInfo() {
        Map<String, Object> map = new HashMap<String, Object>();
        return (Map<String, Object>) selectByPk("_main.serviceCnt", map);
    }
    /**
     * bidInfoMainList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> boardViewM(BoardVO vo,int type) {
        List<BoardVO> dataList = null;
        vo.setBbsCd(type);
        vo.setDomainCd(2);
        dataList = list("_main.boardViewM", vo);
        return dataList;
    }
    

    /**
     * communicationList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<BoardVO> communicationList(BoardVO vo) {
        vo.setTotalNum((Integer) selectByPk("_main.communicationListCount", vo.getDataMap()));
        
        List<BoardVO> dataList = list("_main.communicationList", vo.getDataMap());
       
      
        return new Pager<BoardVO>(dataList, vo);

    }
}
