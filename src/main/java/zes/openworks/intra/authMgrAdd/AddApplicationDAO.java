package zes.openworks.intra.authMgrAdd;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class AddApplicationDAO extends EgovAbstractMapper {

    public Pager<AddApplicationVO> list(AddApplicationVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mgrId", vo.getMngrId());
        parameterMap.put("reqTypeCd", vo.getReqTypeCd());

        List<AddApplicationVO> dataList = list("_addApplication.list", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_addApplication.listCount", parameterMap));

        return new Pager<AddApplicationVO>(dataList, vo);
    }

    public AddApplicationVO applicant(AddApplicationVO vo) {
        AddApplicationVO dataVo = (AddApplicationVO) selectByPk("_addApplication.applicant", vo);
        return dataVo;
    }

    public List<AddApplicationVO> addList2(AddApplicationVO vo) {
        return list("_addApplication.addList2", vo);
    }

    public List<AddApplicationVO> addList3(AddApplicationVO vo) {
        return list("_addApplication.addList3", vo);
    }

    public List<AddApplicationVO> currentlyList(AddApplicationVO vo) {
        return list("_addApplication.currentlyList", vo);
    }

    public List<AddApplicationVO> currentlyList1(AddApplicationVO vo) {
        return list("_addApplication.currentlyList1", vo);
    }

    public List<AddApplicationVO> authGroupList(AddApplicationVO vo) {
        return list("_addApplication.authGroupList", vo);
    }

    public List<AddApplicationVO> assignmentMenu(AddApplicationVO vo) {
        return list("_addApplication.assignmentMenu", vo);
    }

    public AddApplicationVO assignmentMenuCount(AddApplicationVO vo) {
        AddApplicationVO dataVo = (AddApplicationVO) selectByPk("_addApplication.assignmentMenuCount", vo);
        return dataVo;
    }

    public List<AddApplicationVO> menuAllList(AddApplicationVO vo) {
        return list("_addApplication.menuAllList", vo);
    }

    public Object authReqInsert(AddApplicationVO vo) {
        return insert("_addApplication.authReqInsert", vo);
    }

    public Object authReqItemInsert(AddApplicationVO vo) {
        return insert("_addApplication.authReqItemInsert", vo);
    }

    public String getNewPersonAuthCd(AddApplicationVO addApplication) {
        return (String) selectByPk("_addApplication.newPersonCd", addApplication);
    }

    public int newSeqNo(AddApplicationVO newSeq) {
        return (Integer) selectByPk("_addApplication.newSeqNo", newSeq);
    }

    public int saveAssignMenu(AddApplicationVO vo) {
        return update("_addApplication.saveAssignMenu", vo);
    }

    public int creatAuth(AddApplicationVO addApplication) {
        return update("_addApplication.creatAuth", addApplication);

    }

}
