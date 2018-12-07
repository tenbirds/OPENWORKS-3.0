/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.introduction;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 3. 7.    이홍석       신규
 *</pre>
 * @see
 */
@Repository
public class IntroductionDAO extends EgovAbstractMapper 
{
    
    /**
     * 협약기업정보 리스트 _ 페이지 단위
     * index 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<AgremManageVO> agremManage(AgremManageVO vo) 
    {   
        vo.getDataMap().put("q_companyName", vo.getQ_companyName());
        
        Map<String, Object> parameterMap = vo.getDataMap();       
        
        List<AgremManageVO> dataList = list("_introduction.agremManageList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_introduction.agremManageListCount", parameterMap));
        
        /*        
        for(AgremManageVO data : dataList) {
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
          */
        
        
        return new Pager<AgremManageVO>(dataList, vo);        
        
    }

    /**
     * 총서비스 갯수
     * @return
     */
    public int totalService(AgremManageVO vo) 
    {
        Map<String, Object> parameterMap = vo.getDataMap();
        
        return (Integer) selectByPk("_premium.goodsCount", parameterMap);
    }

    /**
     * 서비스(상품) 목록
     * @param vo
     * @return
     */
    public List<AgremManageServiceVO> listService(AgremManageServiceVO vo) 
    {
        Map<String, Object> parameterMap = vo.getDataMap();
        
        return list("_introduction.goodsList", parameterMap);
    }

    /**
     * getServiceNum 설명
     * @param vo
     * @return
     */
    public int getServiceNum(AgremManageServiceVO vo) 
    {
        Map<String, Object> parameterMap = vo.getDataMap();
        
        return (Integer) selectByPk("_introduction.goodsListCount", parameterMap);
    }

}
