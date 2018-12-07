/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale;

import java.util.List;


import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class SleDAO extends EgovAbstractMapper {
/*
    @Resource
    private FileDAO fileDao;

    public Pager<MyGoodsVO> shoppingIndex(MyGoodsVO vo, int goodsType) {
        
        vo.getDataMap().put("q_userId", vo.getUserId());
        vo.getDataMap().put("q_langCode", vo.getLangCode());

        Object goodsTyCds = vo.getDataMap().get("q_goodsTyCd");
        String[] goodsTyCd;
        
        if (goodsType == 1) {
            if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){                
                goodsTyCd = new String[] {"1001"};
                vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
            }
            else {
                if(Validate.isNotEmpty(goodsTyCds)){
                    goodsTyCd = goodsTyCds.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(", ");                 
                    vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
                }                
            }
                
        } else
        {
            goodsTyCd = new String[] {"1003"};
            vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
            
//            if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
//                goodsTyCd = new String[] {"1003"};
//                vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
//            }
//            else {
//                if(Validate.isNotEmpty(goodsTyCds)){
//                    goodsTyCd = goodsTyCds.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(", ");                    
//                    vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
//                }
//            }            
        }
        
        //날짜 설정 없으면 디폴트 현재 날짜
        /*
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);
            
            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }

        List<MyGoodsVO> dataList = list("_mygoods.shoppingList", vo.getDataMap());
        
        for(MyGoodsVO data : dataList) {
         
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));

        }
      
        vo.setTotalNum((Integer) selectByPk("_mygoods.shoppingListCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_goodsTyCd", goodsTyCds);

        return new Pager<MyGoodsVO>(dataList, vo);
    }
    
    public Pager<MyGoodsVO> intrstIndex(MyGoodsVO vo) {
        
        vo.getDataMap().put("q_userId", vo.getUserId());
        vo.getDataMap().put("q_langCode", vo.getLangCode());
        
        Object goodsTyCds = vo.getDataMap().get("q_goodsTyCd");
        String[] goodsTyCd;

        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            goodsTyCd = new String[] {"1001"};
            vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
        } else {
            if(Validate.isNotEmpty(goodsTyCds)){
                goodsTyCd = goodsTyCds.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(", ");                 
                vo.getDataMap().put("q_goodsTyCd", goodsTyCd);
            }
        }
        
        List<MyGoodsVO> dataList = list("_mygoods.intrstList", vo.getDataMap());
        
        for(MyGoodsVO data : dataList) {
         
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));

        }
      
        vo.setTotalNum((Integer) selectByPk("_mygoods.intrstListCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_goodsTyCd", goodsTyCds);
        
        return new Pager<MyGoodsVO>(dataList, vo);
    }
    
    public Pager<MyGoodsVO> recentIndex(MyGoodsVO vo) {
        
        vo.getDataMap().put("q_userId", vo.getUserId());
        vo.getDataMap().put("q_langCode", vo.getLangCode());
        
        List<MyGoodsVO> dataList = list("_mygoods.recentList", vo.getDataMap());
        
        for(MyGoodsVO data : dataList) {
         
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));

        }
      
        vo.setTotalNum((Integer) selectByPk("_mygoods.recentListCount", vo.getDataMap()));

        return new Pager<MyGoodsVO>(dataList, vo);
    }
*/

    /**
     * goodsOrder 설명
     * @param vo
     * @return
     */
    public List<SleVO> goodsOrder(SleVO vo) {
        return list("_sle.goodsOrder", vo);
    }

    /**
     * goodsWait 설명
     * @param vo
     * @return
     */
    public List<SleVO> goodsWait(SleVO vo) {
        return list("_sle.goodsWait", vo);
    }

    /**
     * goodsInqr 설명
     * @param vo
     * @return
     */
    public List<SleVO> goodsInqr(SleVO vo) {
        return list("_sle.goodsInqr", vo);
    }

    /**
     * goodsBiz 설명
     * @param vo
     * @return
     */
    public List<SleVO> goodsBiz(SleVO vo) {
        return list("_sle.goodsBiz", vo);
    }

    /**
     * goodsNoti 설명
     * @param vo
     * @return
     */
    public List<SleVO> goodsNoti(SleVO vo) {
        return list("_sle.goodsNoti", vo);
    }


    /**
     * goodsSubBoard 설명
     * @param vo
     * @return
     */
    public List<SleVO> goodsSubBoard(SleVO vo) {
        return list("_sle.goodsSubBoard", vo);
    }
  
    /**
     * buyingRequest 설명
     * @param vo
     * @return
     */
    public List<SleVO> buyingRequest(SleVO vo) {
        return list("_sle.buyingRequest", vo);
    }
 
    /**
     * goodsOrderCount 설명
     * @param vo
     * @return
     */
    public Integer goodsOrderCount(SleVO vo) {
        return (Integer)selectByPk("_sle.goodsOrderCount", vo);
    }

    /**
     * goodsWaitCount 설명
     * @param vo
     * @return
     */
    public Integer goodsWaitCount(SleVO vo) {
        return (Integer)selectByPk("_sle.goodsWaitCount", vo);
    }

    /**
     * goodsInqrCount 설명
     * @param vo
     * @return
     */
    public Integer goodsInqrCount(SleVO vo) {
        return (Integer)selectByPk("_sle.goodsInqrCount", vo);
    }

    /**
     * goodsBizCount 설명
     * @param vo
     * @return
     */
    public Integer goodsBizCount(SleVO vo) {
        return (Integer)selectByPk("_sle.goodsBizCount", vo);
    }


    
    
}
