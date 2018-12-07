package zes.openworks.web.myGoods;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsPPSVO;


public interface MyGoodsService {

    Pager<MyGoodsVO> purchsIndex(MyGoodsVO vo);
    
    Pager<MyGoodsVO> cnsIndex(MyGoodsVO vo);
    
    Pager<MyGoodsVO> intrstIndex(MyGoodsVO vo);
    
    //{{ SKYOU 2015-11-30 관신심서비스 갯수 가져로기 
    int intrstCnt(MyGoodsVO vo);    
    //}}
      
    
    Pager<MyGoodsVO> recentIndex(MyGoodsVO vo);

    /**
     * intrstDelete 설명
     * @param vo
     * @return
     */
    int intrstDelete(MyGoodsVO vo);
    
    
    List<GoodsPPSVO> selectGoodsPPS(MyGoodsVO vo);

}
