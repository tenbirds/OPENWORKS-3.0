package zes.openworks.intra.authMgrAdd;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class AddtionalDAO extends EgovAbstractMapper {

    public Pager<AdditionalVO> list(AdditionalVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("reqTypeCd", vo.getReqTypeCd());
        // parameterMap.put("searchKey2", vo.getSearchKey2());

        List<AdditionalVO> dataList = list("_addtional.list", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_addtional.listCount", parameterMap));

        return new Pager<AdditionalVO>(dataList, vo);
    }

    public AdditionalVO applicant(AdditionalVO vo) {
        /*
         * Map<String, Object> parameterMap = vo.getRequestMap();
         * parameterMap.put("seqNo", vo.getSeqNo());
         */
        AdditionalVO dataVo = (AdditionalVO) selectByPk("_addtional.applicant", vo);
        return dataVo;
    }

    public int retrocession(AdditionalVO vo) {
        return update("_addtional.retrocession", vo);
    }

    public int retrocession2(AdditionalVO vo) {
        return update("_addtional.retrocession2", vo);
    }

    public int approve(AdditionalVO vo) {

        return update("_addtional.approve", vo);
    }

    public int approve2(AdditionalVO vo) {
        return update("_addtional.approve2", vo);

    }

    public Object approve3(AdditionalVO vo) {
        return insert("_addtional.approve3", vo);
    }

    public List<AdditionalVO> currentlyList(AdditionalVO vo) {
        return list("_addtional.currentlyList", vo);
    }

    public List<AdditionalVO> assignmentMenu(AdditionalVO vo) {
        return list("_addtional.assignmentMenu", vo);
    }

    public List<AdditionalVO> assignmentMenu2(AdditionalVO vo) {
        return list("_addtional.assignmentMenu2", vo);
    }

    public AdditionalVO assignmentMenuCount(AdditionalVO vo) {
        AdditionalVO dataVo = (AdditionalVO) selectByPk("_addtional.assignmentMenuCount", vo);
        return dataVo;
    }

    public AdditionalVO assignmentMenuCount2(AdditionalVO vo) {
        AdditionalVO dataVo = (AdditionalVO) selectByPk("_addtional.assignmentMenuCount2", vo);
        return dataVo;
    }

    public List<AdditionalVO> addList(AdditionalVO vo) {
        return list("_addtional.addList", vo);
    }

    public List<AdditionalVO> addList2(AdditionalVO vo) {
        return list("_addtional.addList2", vo);
    }

    public List<AdditionalVO> addList3(AdditionalVO vo) {
        return list("_addtional.addList3", vo);
    }

    public List<AdditionalVO> authCds(AdditionalVO vo) {
        return list("_addtional.authCds", vo);
    }

    public List<AdditionalVO> menuCds(AdditionalVO vo) {
        return list("_addtional.menuCds", vo);
    }

    public int saveAssignMenu(AdditionalVO vo1) {
        return update("_addtional.saveAssignMenu", vo1);

    }

    public int creatMgrAssign(AdditionalVO vo) {
        return update("_addtional.creatMgrAssign", vo);

    }

    public AdditionalVO listCount2(AdditionalVO vo) {
        AdditionalVO dataVo = (AdditionalVO) selectByPk("_addtional.listCount2", vo);
        return dataVo;
    }

    public AdditionalVO listCount3(AdditionalVO vo) {
        AdditionalVO baseVo = (AdditionalVO) selectByPk("_addtional.listCount3", vo);
        return baseVo;
    }

}
