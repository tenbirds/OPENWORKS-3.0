package zes.openworks.intra.analyze.statistic.cntrct;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.analyze.statistic.base.BaseServiceImpl;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

@Service("cntrctSttusService")
public class CntrctSttusServiceImpl extends BaseServiceImpl implements CntrctSttusService {
    @Resource
    private CntrctSttusDAO dao;

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctAmountViewList(java.util.HashMap)
     */
    @Override
    public List cntrctAmountViewList(HashMap<String, String> map) {
        return dao.cntrctAmountViewList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctRatioList(java.util.HashMap)
     */
    @Override
    public List cntrctTpList(HashMap<String, String> map) {
        return dao.cntrctTpList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctCorpList(java.util.HashMap)
     */
    @Override
    public List cntrctCorpList(HashMap<String, String> map) {
        return dao.cntrctCorpList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctServiceList(java.util.HashMap)
     */
    @Override
    public List cntrctServiceList(HashMap<String, String> map) {
        return dao.cntrctServiceList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctSupplyList(java.util.HashMap)
     */
    @Override
    public List cntrctSupplyList(HashMap<String, String> map) {
        return dao.cntrctSupplyList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctUseInsttList(java.util.HashMap)
     */
    @Override
    public List cntrctUseInsttList(HashMap<String, String> map) {
        return dao.cntrctUseInsttList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#cntrctSportList(java.util.HashMap) 
     */
    @Override
    public List cntrctSportList(HashMap<String, String> map) {
        return dao.cntrctSportList(map);
    }
    @Override
    public List cntrctSportTotList(HashMap<String, String> map) {
        return dao.cntrctSportTotList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.CntrctSttusService#serviceDetailList(zes.openworks.intra.analyze.statistic.common.ResultVO)
     */
    @Override
    public Pager<ResultVO> serviceDetailList(ResultVO vo) {
        return dao.serviceDetailList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.analyze.statistic.cntrct.contractList#contractList(zes.openworks.intra.analyze.statistic.common.ResultVO)
     */
    @Override
    public Pager<ResultVO>  contractList(ResultVO vo) {
        return dao.contractList(vo);
    }
    

    
    @Override
    public HashMap<String, Object> cntrctServiceExcelList(HashMap<String, Object> map) {
        return dao.cntrctServiceExcelList(map);
    }

}