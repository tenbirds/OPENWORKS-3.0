package zes.openworks.intra.authMgrDel;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.openworks.intra.authMgrAdd.AddApplicationVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class DelApplicationDAO extends EgovAbstractMapper {

    public AddApplicationVO applicant(AddApplicationVO vo) {
        AddApplicationVO dataVo = (AddApplicationVO) selectByPk("_delApplication.applicant", vo);
        return dataVo;
    }

    public List<AddApplicationVO> currentlyList(AddApplicationVO vo) {
        return list("_delApplication.currentlyList", vo);
    }

    public List<AddApplicationVO> currentlyList2(AddApplicationVO vo) {
        return list("_delApplication.currentlyList2", vo);
    }

    public Object menuReqItemDel(AddApplicationVO vo) {
        return insert("_delApplication.menuReqItemDel", vo);
    }

}
