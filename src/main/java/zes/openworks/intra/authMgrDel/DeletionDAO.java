package zes.openworks.intra.authMgrDel;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.openworks.intra.authMgrAdd.AdditionalVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class DeletionDAO extends EgovAbstractMapper {

    public List<AdditionalVO> delList(AdditionalVO vo) {
        return list("_deletion.delList", vo);
    }

    public List<AdditionalVO> delList2(AdditionalVO vo) {
        return list("_deletion.delList2", vo);
    }

    public Object delMgrAssign(AdditionalVO vo) {
        return delete("_deletion.delMgrAssign", vo);
    }

    public Object delMenuAssign(AdditionalVO vo) {
        return delete("_deletion.delMenuAssign", vo);
    }

    public Object regUpdate(AdditionalVO vo) {
        return update("_deletion.regUpdate", vo);

    }

    public Object reqItemUpdate(AdditionalVO vo) {
        return update("_deletion.reqItemUpdate", vo);
    }

}
