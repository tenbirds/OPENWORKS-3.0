package zes.openworks.intra.analyze.statistic.cntrct;

import java.util.HashMap;
import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

public interface CntrctSttusService {

    /**
     * cntrctAmountViewList 설명
     * @param map
     * @return
     */
    List cntrctAmountViewList(HashMap<String, String> map);

    /**
     * cntrctRatioList 설명
     * @param map
     * @return
     */
    List cntrctTpList(HashMap<String, String> map);

    /**
     * cntrctCorpList 설명
     * @param map
     * @return
     */
    List cntrctCorpList(HashMap<String, String> map);

    /**
     * cntrctServiceList 설명
     * @param map
     * @return
     */
    List cntrctServiceList(HashMap<String, String> map);

    /**
     * cntrctSupplyList 설명
     * @param map
     * @return
     */
    List cntrctSupplyList(HashMap<String, String> map);

    /**
     * cntrctUseInsttList 설명
     * @param map
     * @return
     */
    List cntrctUseInsttList(HashMap<String, String> map);

    /**
     * cntrctSportList 설명 
     * @param map
     * @return
     */
    List cntrctSportList(HashMap<String, String> map);
    
    List cntrctSportTotList(HashMap<String, String> map);

    /**
     * serviceDetailList 설명
     * @param vo
     * @return
     */
    Pager<ResultVO> serviceDetailList(ResultVO vo);

    /**
     * contractList 설명
     * @param purchsInsttNm
     * @return
     */
    Pager<ResultVO> contractList(ResultVO vo);

    /**
     * cntrctServiceExcelList 설명
     * @param map
     * @return
     */
    HashMap<String, Object> cntrctServiceExcelList(HashMap<String, Object> map);
    
}