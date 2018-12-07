/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.recomgoods;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
 * 2014. 10. 21.   김병욱       신규
 *</pre>
 * @see
 */
@Repository
public class RecomGoodsDAO  extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<RecomGoodsVO> goodsList(RecomGoodsVO vo) {

        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }


        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }


        List<RecomGoodsVO> dataList = list("_recomgoods.goodsList", vo.getDataMap());

//        Map<String, List<FileVO>> setmark = new HashMap<>();
//        List<FileVO>[] goodsMarkImage = new ArrayList<FileVO>();


        for(RecomGoodsVO data : dataList) {
//            for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }
        vo.setTotalNum((Integer) selectByPk("_recomgoods.goodsCount", vo.getDataMap()));

        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<RecomGoodsVO>(dataList, vo);
    }

    /**
     * langList 서비스 언어 목록
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> langList(GoodsManageVO vo) {
        return list("_goodsManage.langList", vo);
    }

    /**
     * ctgryList (카테고리 항목)
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> ctgryList(GoodsManageVO vo){
        return list("_goodsManage.ctgryList", vo);
    }

    /**
     * recomGoodsList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<RecomGoodsVO> recomGoodsList(RecomGoodsVO vo) {
//        Object langCodes = vo.getDataMap().get("q_langCodes");
//        if(Validate.isNotEmpty(langCodes)){
//            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
//            vo.getDataMap().put("q_langCodes", langCode);
//        }

        List<RecomGoodsVO> dataList = list("_recomgoods.recomGoodsList", vo);

//        Map<String, List<FileVO>> setmark = new HashMap<>();
//        List<FileVO>[] goodsMarkImage = new ArrayList<FileVO>();



        vo.setTotalNum((Integer) selectByPk("_recomgoods.recomGoodsCount", vo));

        //원상복구
//        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<RecomGoodsVO>(dataList, vo);
    }

    /**
     * recomGoodsList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<RecomGoodsVO> recomGoodsList2(RecomGoodsVO vo) {
//        Object langCodes = vo.getDataMap().get("q_langCodes");
//        if(Validate.isNotEmpty(langCodes)){
//            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
//            vo.getDataMap().put("q_langCodes", langCode);
//        }

        List<RecomGoodsVO> dataList = list("_recomgoods.recomGoodsList2", vo);

//        Map<String, List<FileVO>> setmark = new HashMap<>();
//        List<FileVO>[] goodsMarkImage = new ArrayList<FileVO>();



        vo.setTotalNum((Integer) selectByPk("_recomgoods.recomGoodsCount2", vo));

        //원상복구
//        vo.getDataMap().put("q_langCodes", langCodes);

        return new Pager<RecomGoodsVO>(dataList, vo);
    }

    /**
     * recomGoodsInsert 설명
     * @param vo
     * @return
     */
    public int recomGoodsInsert(RecomGoodsVO vo, boolean recomApply) {
        int ret = 1;
        Integer limitCnt = 0;

        String[] goodsCodes = vo.getGoodsCodes();
        Integer lc = vo.getRecomendLcSeCd();
        Integer ty = vo.getRecomendSeCd();
        Integer[] priorts = vo.getPriorts();
        String[] appnDts = vo.getAppnDts();
        Integer cnt = 0;
        Integer selectCnt = 0;

        if (!recomApply) {
           cnt = (Integer) selectByPk("_recomgoods.recomGoodsCount", vo);
        }
        if (lc == 1001) {
           if (ty == 1001) {
               limitCnt = 4;
           }
           if (ty == 1002) {
               limitCnt = 3;
           }
        } else
        {
           limitCnt = 10;
        }

        if (Validate.isNotEmpty(goodsCodes)) {
            selectCnt = goodsCodes.length;
        }
        if (limitCnt < cnt + selectCnt) {
            return 999; // 정한 갯수보다 초과했을때
        }

        for (int i=0 ;i < selectCnt; i++)
        {
            vo.setGoodsCode(goodsCodes[i]);
            Integer goodsTy = (Integer)selectByPk("_recomgoods.goodsTy", vo);
            if (Validate.isEmpty(goodsTy)) {
                return 998; // 서비스 타입이 맞지 않을때
            }
        }

        if (recomApply) {
            recomGoodsDelete(vo);
        }
        for (int i=0 ;i < selectCnt; i++)
        {
            vo.setGoodsCode(goodsCodes[i]);
            Integer goodsTy = (Integer)selectByPk("_recomgoods.goodsTy", vo);
            if (Validate.isNotEmpty(goodsTy)) {
                if (recomApply) {
                    vo.setPriort(priorts[i]);
                    vo.setAppnDt(appnDts[i]);
                    ret = insert("_recomgoods.recomGoodsInsert", vo);
                } else {
                    ret = 1;
                }
            }
            else
            {
                return 998; // 서비스 타입이 맞지 않을때
            }

        }
        return ret;
    }

    /**
     * recomGoodsDelete 설명
     * @param vo
     * @return
     */
    public int recomGoodsDelete(RecomGoodsVO vo) {
        int ret = 1;
        ret = delete("_recomgoods.recomGoodsDelete", vo);
        return ret;
    }

    /**
     * recomGoodsInsert2 설명
     * @param vo
     * @return
     */
    public int recomGoodsInsert2(RecomGoodsVO vo, boolean recomApply) {
        int ret = 0;
        Integer limitCnt = 0;

        String[] goodsCodes = vo.getGoodsCodes();
        Integer lc = vo.getRecomendLcSeCd();
        Integer ty = vo.getRecomendSeCd();
        Integer[] priorts = vo.getPriorts();
        String[] appnDts = vo.getAppnDts();
        Integer cnt = 0;
        Integer selectCnt = 0;
        if (!recomApply) {
            cnt = (Integer) selectByPk("_recomgoods.recomGoodsCount2", vo);
        }
        if (lc == 1001) {
           if (ty == 1001) {
               limitCnt = 4;
           }
           if (ty == 1002) {
               limitCnt = 3;
           }
        } else
        {
           limitCnt = 10;
        }

        if (Validate.isNotEmpty(goodsCodes)) {
            selectCnt = goodsCodes.length;
        }
        if (limitCnt < cnt + selectCnt) {
            return 999; // 정한 갯수보다 초과했을때
        }

        for (int i=0 ;i < selectCnt; i++)
        {
            vo.setGoodsCode(goodsCodes[i]);
            Integer goodsTy = (Integer)selectByPk("_recomgoods.goodsTy", vo);
            if (Validate.isEmpty(goodsTy)) {
                return 998; // 서비스 타입이 맞지 않을때
            }
        }

        if (recomApply) {
            recomGoodsDelete(vo);
        }
        for (int i=0 ;i < selectCnt; i++)
        {
            vo.setGoodsCode(goodsCodes[i]);
            Integer goodsTy = (Integer)selectByPk("_recomgoods.goodsTy", vo);
            if (Validate.isNotEmpty(goodsTy)) {
                if (recomApply) {
                    vo.setPriort(priorts[i]);
                    vo.setAppnDt(appnDts[i]);
                    ret = insert("_recomgoods.recomGoodsInsert", vo);
                } else {
                    ret = 1;
                }
            }
            else
            {
                return 998; // 서비스 타입이 맞지 않을때
            }

        }
        return ret;
    }
}
