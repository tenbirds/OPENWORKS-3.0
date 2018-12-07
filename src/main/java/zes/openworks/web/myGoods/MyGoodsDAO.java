/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myGoods;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsPPSVO;
import zes.openworks.web.issue.IssueVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class MyGoodsDAO extends EgovAbstractMapper {
    @Resource
    private FileDAO fileDao;

    public Pager<MyGoodsVO> shoppingIndex(MyGoodsVO vo, int goodsType) {
        
        vo.getDataMap().put("q_userId", vo.getUserId());
        vo.getDataMap().put("q_langCode", vo.getLangCode());

        Object goodsTyCds = vo.getDataMap().get("q_goodsTyCd");
        String[] goodsTyCd;
        
        if (goodsType == 1) {
            if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){                
                goodsTyCd = new String[] {"1001", "1002"};
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
            goodsTyCd = new String[] {"1001","1002","1003"};
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
    
    
    //{{ SKYOU 2015-11-30 관심서비스 갯수 
    public int intrstCnt(MyGoodsVO vo) {
        
        Map<String, Object> map = new HashMap<String, Object>();         
        map.put("q_userId", vo.getUserId());
        map.put("q_langCode", vo.getLangCode());
        
        String[] goodsTyCd = new String[] {"1001","1002","1003"};
        map.put("q_goodsTyCd", goodsTyCd);
        
        map.put("q_goodsCode", vo.getGoodsCode());
        return (Integer) selectByPk("_mygoods.intrstListCount", map);
    }    
  //}
    
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

    /**
     * intrstDelete 설명
     * @param vo
     * @return
     */
    public int intrstDelete(MyGoodsVO vo) {
        return delete("_mygoods.intrstDelete", vo);
    }

    public List<GoodsPPSVO> selectGoodsPPS(MyGoodsVO vo) {
        return list("_mygoods.selectGoodsPPS", vo);
    }
}
