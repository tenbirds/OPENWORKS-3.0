package zes.openworks.web.sale;

import java.util.List;

public interface SleService {

    /**
     * goodsOrder 설명
     * @param vo
     * @return
     */
    List<SleVO> goodsOrder(SleVO vo);

    /**
     * goodsWait 설명
     * @param vo
     * @return
     */
    List<SleVO> goodsWait(SleVO vo);

    /**
     * goodsInqr 설명
     * @param vo
     * @return
     */
    List<SleVO> goodsInqr(SleVO vo);

    /**
     * goodsBiz 설명
     * @param vo
     * @return
     */
    List<SleVO> goodsBiz(SleVO vo);

    /**
     * goodsNoti 설명
     * @param vo
     * @return
     */
    List<SleVO> goodsNoti(SleVO vo);
 
    /**
     * goodsSubBoard 설명
     * @param vo
     * @return
     */
    List<SleVO> goodsSubBoard(SleVO vo);
 
    /**
     * buyingRequest 설명
     * @param vo
     * @return
     */
    List<SleVO> buyingRequest(SleVO vo);

    
    /**
     * goodsOrderCount 설명
     * @param vo
     * @return
     */
    Integer goodsOrderCount(SleVO vo);

    /**
     * goodsWaitCount 설명
     * @param vo
     * @return
     */
    Integer goodsWaitCount(SleVO vo);

    /**
     * goodsInqrCount 설명
     * @param vo
     * @return
     */
    Integer goodsInqrCount(SleVO vo);

    /**
     * goodsBizCount 설명
     * @param vo
     * @return
     */
    Integer goodsBizCount(SleVO vo);

    /**
     * goodsNotiCount 설명
     * @param vo
     * @return
     */
    /*Integer goodsNotiCount(SleVO vo);*/
    
}
