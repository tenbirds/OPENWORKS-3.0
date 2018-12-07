package zes.openworks.intra.analyze.statistic.cntrct;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

@Repository
public class CntrctSttusDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;
    
    /**
     * cntrctAmountViewList 설명
     * @param map
     * @return
     */
    public List cntrctAmountViewList(HashMap<String, String> map) {
        return list ("_explorer.cntrctAmountView", map);
    }

    /**
     * cntrctRatioList 설명
     * @param map
     * @return
     */
    public List cntrctTpList(HashMap<String, String> map) {
        return list ("_explorer.cntrctTpList", map);
    }

    /**
     * cntrctCorpList 설명
     * @param map
     * @return
     */
    public List cntrctCorpList(HashMap<String, String> map) {
        return list ("_explorer.cntrctCorpList", map);
    }

    /**
     * cntrctServiceList 설명
     * @param map
     * @return
     */
    public List cntrctServiceList(HashMap<String, String> map) {
        return list ("_explorer.cntrctServiceList", map);
    }

    /**
     * cntrctSupplyList 설명
     * @param map
     * @return
     */
    public List cntrctSupplyList(HashMap<String, String> map) {
        return list ("_explorer.cntrctSupplyList", map);
    }

    /**
     * cntrctUseInsttList 설명
     * @param map
     * @return
     */
    public List cntrctUseInsttList(HashMap<String, String> map) {
        return list ("_explorer.cntrctUseInsttList", map);
    }

    /**
     * cntrctSportList 설명
     * @param map 
     * @return
     */
    public List cntrctSportList(HashMap<String, String> map) {
        return list ("_explorer.cntrctSportList", map);
    }
    public List cntrctSportTotList(HashMap<String, String> map) {
        return list ("_explorer.cntrctSportTotList", map);
    }

    /**
     * serviceDetailList 설명
     * @param vo
     * @return
     * @throws UnsupportedEncodingException 
     */
    public Pager<ResultVO> serviceDetailList(ResultVO vo) {
        vo.setTotalNum((Integer) selectByPk("_explorer.cntrctServiceDetailCount", vo.getDataMap()));
        
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }

        System.out.println("goodsCode: " + vo.getDataMap().get("goodsCode"));        
        
        List<ResultVO> dataList = list("_explorer.cntrctServiceDetailList", vo.getDataMap());
        for(ResultVO dataVo : dataList){
            // 계약서 파일 정보
            if (Validate.isNotEmpty(dataVo.getCtrtcSn())) {
                dataVo.setCtrtcFile(fileDao.getFiles(dataVo.getCtrtcSn()));
            }
        }
//        vo.setTotalNum((Integer) selectByPk("_cntrctManage.cntrctManageCount", vo.getDataMap()));;
        return new Pager<ResultVO>(dataList, vo);
    }

    /**
     * contractList 설명
     * @param purchsInsttNm
     * @return
     */
    public Pager<ResultVO> contractList(ResultVO vo) 
    {
        vo.setTotalNum((Integer) selectByPk("_explorer.contractListCount", vo.getDataMap()));
        List<ResultVO> dataList = list("_explorer.contractList", vo.getDataMap());
        for(ResultVO dataVo : dataList){
            // 계약서 파일 정보
            if (Validate.isNotEmpty(dataVo.getCtrtcSn())) {
                dataVo.setCtrtcFile(fileDao.getFiles(dataVo.getCtrtcSn()));
            }
        }

        return new Pager<ResultVO>(dataList, vo);
    }

    /**
     * cntrctServiceExcelList 설명
     * @param map
     * @return
     */
    public HashMap<String, Object> cntrctServiceExcelList(HashMap<String, Object> map) {

        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", list("_explorer.cntrctServiceList", map));
        return resultMap;
    }
}