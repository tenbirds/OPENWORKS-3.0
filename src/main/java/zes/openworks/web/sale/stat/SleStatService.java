package zes.openworks.web.sale.stat;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.web.sale.goods.WebGoodsManageVO;


public interface SleStatService {

    /**
     * ctgryList 설명
     * @param vo
     * @return
     */
    List<WebGoodsManageVO> ctgryList(WebGoodsManageVO vo);

    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<WebGoodsManageVO> langList(WebGoodsManageVO vo);

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    Pager<WebGoodsManageVO> goodsList(WebGoodsManageVO vo);
}
