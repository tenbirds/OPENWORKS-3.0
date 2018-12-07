/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.stat;

import java.text.*;
import java.util.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class SleStatDAO extends EgovAbstractMapper {
    @Resource
    private FileDAO fileDao;

    /**
     * ctgryList 설명
     * @param vo
     * @return
     */
    public List<WebGoodsManageVO> ctgryList(WebGoodsManageVO vo) {
        return list("_sleStat.ctgryList", vo);
    }

    /**
     * langList 서비스 언어 목록
     *
     * @param vo
     * @return
     */
    public List<WebGoodsManageVO> langList(WebGoodsManageVO vo) {
        return list("_sleStat.langList", vo);
    }

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    public Pager<WebGoodsManageVO> goodsList(WebGoodsManageVO vo) {

        //공통 파라메타
//        getDataMap(vo);
        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }

        // 날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate", sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
        
        
        
        
        vo.setTotalNum((Integer) selectByPk("_sleStat.goodsCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<WebGoodsManageVO> dataList = list("_sleStat.goodsList", vo.getDataMap());

        // Map<String, List<FileVO>> setmark = new HashMap<>();
        // List<FileVO>[] goodsMarkImage = new ArrayList<FileVO>();

        for(WebGoodsManageVO data : dataList) {
            // for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if(!Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }

        // 원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
//        vo.getDataMap().put("q_statusCodes", statusCodes);
//        vo.getDataMap().put("q_expsrCodes", expsrCodes);
//        vo.getDataMap().put("q_crtfcCodes", crtfcCodes);

        return new Pager<WebGoodsManageVO>(dataList, vo);
    }
}
