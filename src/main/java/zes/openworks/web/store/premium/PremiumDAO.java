/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store.premium;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.myGoods.MyGoodsVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 6.    이슬버미       신규
 *</pre>
 * @see
 */
@Repository
public class PremiumDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * getCommanString 리스트의 문자열을 콤머로 연결한다.
     * 
     * @param termLst
     * @return
     */
    private String getCommanString(List<String> termLst) {
        if(!Validate.isEmpty(termLst)) {
            StringBuilder commaSepValueBuilder = new StringBuilder();
            for(int j = 0 ; j < termLst.size() ; j++) {
                commaSepValueBuilder.append(termLst.get(j));

                if(j != termLst.size() - 1) {
                    commaSepValueBuilder.append(",");
                }
            }

            return commaSepValueBuilder.toString();
        } else {
            return null;
        }
    }

    /**
     * ctgryPath 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, String> ctgryPath(PremiumVO vo) {
        return (Map<String, String>) selectByPk("_premium.ctgryPath", vo);
    }

    /**
     * ctgry 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> ctgry(PremiumVO vo) {
        return (Map<String, Object>)selectByPk("_premium.ctgry", vo);
    }

    /**
     * ctgryList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ctgryList(PremiumVO vo) {
        return list("_premium.ctgryList", vo);
    }

    /**
     * bestList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> bestList(PremiumVO vo) {
        List<PremiumVO> dataList = list("_premium.bestList", vo);

        for(PremiumVO data : dataList) {
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
            if (Validate.isNotEmpty(data.getCngdMarkList())) {
                data.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
            }

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }
 
    /**
     * rcmdList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> rcmdList(PremiumVO vo) {
        List<PremiumVO> dataList = list("_premium.rcmdList", vo);

        for(PremiumVO data : dataList) {
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
            if (Validate.isNotEmpty(data.getCngdMarkList())) {
                data.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
            }

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * bestSellerList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PremiumVO> bestSellerList(PremiumVO vo) {
        return list("_premium.bestSellerList", vo);
    }

    /**
     * goodsList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<PremiumVO> goodsList(PremiumVO vo) {
        List<PremiumVO> dataList = list("_premium.goodsList", vo.getDataMap());
        for(PremiumVO data : dataList) {
//          for(int fileSeq : data.getGoodsMarkList()){
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
            if (Validate.isNotEmpty(data.getCngdMarkList())) {
                data.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
            }
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        vo.setTotalNum((Integer) selectByPk("_premium.goodsCount", vo.getDataMap()));
        return new Pager<PremiumVO>(dataList, vo);
    }

    /**
     * ctgryInit 설명
     * @param vo
     * @return
     */
    public String ctgryInit(PremiumVO vo) {

        return (String)selectByPk("_premium.ctgryInit", vo);
    }

    /**
     * goodsView 설명
     * @param vo
     * @return
     */
    public PremiumVO goodsView(PremiumVO vo) {

        String reviewCount = (String)selectByPk("_premium.reviewCount", vo);    //리뷰갯수 (이전 평가 내용 )
        String relationCount = (String)selectByPk("_premium.relationCount", vo); //연관서비스 갯수
        String goodsCode = vo.getGoodsCode();
        String ctgryCode = vo.getCtgryCode();        
        
        Map<String, String> parameterMap = new HashMap<String, String>(2);
        
        parameterMap.put("langCode", "00");
        parameterMap.put("ctgryCode", ctgryCode);
        parameterMap.put("goodsCode", goodsCode);

        PremiumVO gvo = (PremiumVO) selectByPk("_premium.goodsView", parameterMap);

        

        //if("null".equals(strGoodsChargerNm)) {
            
        //}

        int strGoodsChargerNmCnt = (Integer) selectByPk("_premium.goodsViewInfoCount", parameterMap);
        
        if(strGoodsChargerNmCnt < 1) { //규격서 ROW가 없는 경우는 서비스 테이블에서 정보 불러오기 

            PremiumVO gvo1 = (PremiumVO) selectByPk("_premium.goodsViewInfo", parameterMap);
            
            gvo.setSmlpzChk(gvo1.getSmlpzChk());
            gvo.setGoodsChargerNm(gvo1.getGoodsChargerNm());
            gvo.setGoodsChargerCttpc(gvo1.getGoodsChargerCttpc());
            gvo.setGoodsChargerEmail(gvo1.getGoodsChargerEmail());
            
        } else {
            
            String strGoodsChargerNmStrCnt = (String) selectByPk("_premium.goodsViewInfoCount1", parameterMap);
            
            if("0".equals(strGoodsChargerNmStrCnt)){   //해당 담당자 컬럼이 없는겅우

                PremiumVO gvo1 = (PremiumVO) selectByPk("_premium.goodsViewInfo", parameterMap);
                
                gvo.setSmlpzChk(gvo1.getSmlpzChk());
                gvo.setGoodsChargerNm(gvo1.getGoodsChargerNm());
                gvo.setGoodsChargerCttpc(gvo1.getGoodsChargerCttpc());
                gvo.setGoodsChargerEmail(gvo1.getGoodsChargerEmail());                
                
            } else {  // 해당 컬럼의 담당자가 있는 경우 규격서 테이블에서 불러온다.
                
            }
            
        }    
            
        
                
        /**
         *  규격서테이블에서 담당자명으로 데이터가 없으면 
         *  기업구분, 담당자, 연락처, 이메일을 서비스 테이블에서 정보를 가져오도록 셋팅
         */
      

        List<String> listCtgryNm = list("_premium.listCtgryNm", parameterMap);
        
        gvo.setLangCtgryNm(getCommanString(listCtgryNm));

        gvo.setRevCnt(reviewCount);
        gvo.setRelationCnt(relationCount);

        if (Validate.isNotEmpty(gvo.getGoodsImageFileSeq())) {
            gvo.setImageFile(fileDao.getFiles(gvo.getGoodsImageFileSeq()));
        }
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsFileSeq()))) {
            gvo.setGoodsFile(fileDao.getFiles(gvo.getGoodsFileSeq()));
        }
        
        /*1.0 규격서 */
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsMnlFileSeq1()))) {
            gvo.setMnlFile(fileDao.getFiles(gvo.getGoodsMnlFileSeq1()));
        }
        
        //{{
        // 나용자 메뉴얼
        if (Validate.isNotEmpty(fileDao.getFiles(gvo.getMnlDnFileSeq()))) {
            gvo.setDnlFile(fileDao.getFiles(gvo.getMnlDnFileSeq()));
        }

        // 기타첨부
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getEtcFileSeq()))) {
            gvo.setEtcFile(fileDao.getFiles(gvo.getEtcFileSeq()));
        }

        //가격표 첨부파일
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getPriceDnFileSeq()))) {
            gvo.setPriceFile(fileDao.getFiles(gvo.getPriceDnFileSeq()));
        }

        //}}

        List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
        for(int i = 0 ; i < gvo.getGoodsMarkList().size() ; i++) {
            goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(gvo.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
        }

        if ( ! Validate.isNull(goodsMarkImage)) {
            gvo.setMarkFile(goodsMarkImage);
        }

        if (Validate.isNotEmpty(gvo.getCngdMarkList())) {
            gvo.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(gvo.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
        }

        if (Validate.isNotEmpty(gvo.getGoodsStore())) {
            gvo.setStoreImageFile(fileDao.getFiles(Integer.parseInt(String.valueOf(gvo.getGoodsStore().get(0).get("STOREIMAGEFILESEQ")))));
        }

        //계약정보
        gvo.setCntrctInfoList( list("_premium.cntrctList", goodsCode));

        return gvo;

    }

    /**
     * rdcntUpdate 설명
     * @param vo
     * @return
     */
    public int rdcntUpdate(PremiumVO vo) {
        return update("_premium.rdcntUpdate", vo);
    }

    /**
     * rcntUpdate 설명
     * @param vo
     * @return
     */
    public int rcntUpdate(PremiumVO vo) {
        return update("_premium.rcntUpdate", vo);
    }

    /**
     * purchInsert 설명
     * @param vo
     * @return
     */
    public int purchInsert(PremiumVO vo) {
        int ret = 0;

        ret = insert("_premium.pchsInsert", vo);
//        Integer sleMthdCd = vo.getSleMthdCd();
//        if (Validate.isNotEmpty(sleMthdCd) && sleMthdCd == 1001) {
//            vo.setOrderCnfirmAt("Y"); // 파일다운로드
//
//        } else {
//            vo.setOrderCnfirmAt("N"); //신청작성
//        }

        ret = insert("_premium.ordrInsert", vo);
        return ret;
    }

    /**
     * itstUpdate 설명
     * @param vo
     * @return
     */
    public int itstUpdate(PremiumVO vo) {
        
        return update("_premium.itstUpdate", vo);
    }

    /**
     * itstUpdate 설명
     * @param vo
     * @return
     */
    public int itstCount(PremiumVO vo) {
        
        return (Integer)selectByPk("_premium.itstCount", vo);
    }

    /**
     * ctgryNull 설명
     * @param vo
     * @return
     */
    public String ctgryNull(PremiumVO vo) {
        return (String)selectByPk("_premium.ctgryNull", vo);
    }

    /**
     * goodsListOfSeller 설명
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<PremiumVO> goodsListOfSeller(PremiumVO vo) {
        List<PremiumVO> dataList = list("_premium.goodsListOfSeller", vo.getDataMap());
        for(PremiumVO data : dataList) {
//          for(int fileSeq : data.getGoodsMarkList()){
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
            if (Validate.isNotEmpty(data.getCngdMarkList())) {
                data.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
            }
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        vo.setTotalNum((Integer) selectByPk("_premium.goodsListOfSellerCount", vo.getDataMap()));

        return new Pager<PremiumVO>(dataList, vo);
    }

    /**
     * goodsStore 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> goodsStore(PremiumVO vo) {
        Map<String, Object> store = (Map<String, Object>)selectByPk("_premium.goodsStoreList", vo);
        if (Validate.isNotEmpty(store)) {
//            vo.setStoreImageFile(fileDao.getFiles(Integer.parseInt(String.valueOf(store.get("STOREIMAGEFILESEQ")))));
            store.put("img", fileDao.getFiles(Integer.parseInt(String.valueOf(store.get("STOREIMAGEFILESEQ")))));
        }

      //{{SKYOU 2015.12.10 소프트웨어/IT서비스
        store.put("Count",selectByPk("_premium.goodsListOfKindCount", vo));
      //}}

        return store;
    }

    /**
     * sellerInfo 설명
     * @param vo
     * @return
     */
    public GoodsManageVO sellerInfo(PremiumVO vo) {
        GoodsManageVO dataVO = (GoodsManageVO) selectByPk("_premium.sellerInfo", vo);
        if(dataVO.getGoodsImageFileSeq() != -1){
            dataVO.setImageFile(fileDao.getFiles(dataVO.getGoodsImageFileSeq()));
        }

        return dataVO;
    }

    /**
     * getPurchsNo 설명
     * @param vo
     * @return
     */
    public String getPurchsNo(PremiumVO vo) {
        String purchsNo = (String)selectByPk("_premium.purchsKey", null);
        return purchsNo;
    }





    /**
     * 서비스별 카테고리 목록[등록 서비스의 카테고리 정보]
     * @param Map searchMap
     * @return List
     * @ 2015.12.23 생성
     */
    public List goodsCateList(PremiumVO vo) {
        return list("_premium.goodsCateList", vo);
    }
    
    
    public int suplyCnt(MyGoodsVO vo) {
        return (Integer) selectByPk("_premium.suplyCnt", vo);
    }

    /**
     * suplyCnt 설명
     * @param vo
     * @return
     */
    public int suplyCnt(PremiumVO vo) {
        return (Integer) selectByPk("_premium.suplyCnt", vo);
    }
}
