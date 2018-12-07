package zes.openworks.intra.authMgrTrs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class AuthTransferApplicationDAO extends EgovAbstractMapper {

    public Pager<AuthTransferApplicationVO> list(AuthTransferApplicationVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mgrId", vo.getMngrId());
        parameterMap.put("resTypeCds", vo.getResTypeCds());

        List<AuthTransferApplicationVO> dataList = list("_authTrnasferApp.list", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_authTrnasferApp.listCount", parameterMap));

        return new Pager<AuthTransferApplicationVO>(dataList, vo);
    }

    public AuthTransferApplicationVO applicant(AuthTransferApplicationVO vo) {

        return (AuthTransferApplicationVO) selectByPk("_authTrnasferApp.applicant", vo);
    }

    public List<AuthTransferApplicationVO> currentlyList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.currentlyList", vo);
    }

    public List<AuthTransferApplicationVO> sendCurrentlyList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.sendCurrentlyList", vo);
    }

    public List<AuthTransferApplicationVO> prvCurrentlyList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.prvCurrentlyList", vo);
    }

    public Pager<AuthTransferApplicationVO> directorSerchList(AuthTransferApplicationVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        List<AuthTransferApplicationVO> dataList = list("_authTrnasferApp.directorSerchList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_authTrnasferApp.directorSerchListCount", parameterMap));

        return new Pager<AuthTransferApplicationVO>(dataList, vo);
    }

    public int newSeqNo(AuthTransferApplicationVO newSeq) {

        return (Integer) selectByPk("_authTrnasferApp.newSeqNo", newSeq);
    }

    public Object authReqInsert(AuthTransferApplicationVO vo) {

        return insert("_authTrnasferApp.authReqInsert", vo);
    }

    public Object authReqItemInsert(AuthTransferApplicationVO vo) {

        return insert("_authTrnasferApp.authReqItemInsert", vo);
    }

    // public int creatAuth(AuthTransferApplicationVO addApplication) {
    //
    // return update("_authTrnasferApp.creatAuth", addApplication);
    // }

    public int saveAssignMenu(AuthTransferApplicationVO vo) {

        return update("_authTrnasferApp.saveAssignMenu", vo);
    }

    public AuthTransferApplicationVO applicantDirector(AuthTransferApplicationVO vo) {

        AuthTransferApplicationVO targetMgrId = (AuthTransferApplicationVO) selectByPk("_authTrnasferApp.targetMgrId", vo);
        vo.setTargetMgrId(targetMgrId.getTargetMgrId());

        String applicationCause = (String) selectByPk("_authTrnasferApp.applicationCause", vo);
        vo.setReqConts(applicationCause);

        return (AuthTransferApplicationVO) selectByPk("_authTrnasferApp.applicantDirector", vo);
    }

    public int authReqUpdate(AuthTransferApplicationVO vo) {

        return update("_authTrnasferApp.authReqUpdate", vo);
    }

    public Object authReqItemDelete(AuthTransferApplicationVO vo) {

        return delete("_authTrnasferApp.authReqItemDelete", vo);
    }

    public int deleteAssignMenu(AuthTransferApplicationVO vo) {

        return delete("_authTrnasferApp.deleteAssignMenu", vo);
    }

    public List<AuthTransferApplicationVO> mgrAuthList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.mgrAuthList", vo);
    }

    public Object prvAuthCdInsert(AuthTransferApplicationVO vo) {

        return insert("_authTrnasferApp.prvAuthCdInsert", vo);
    }

    public void prvAuthCdDelete(AuthTransferApplicationVO vo) {
        delete("_authTrnasferApp.prvAuthCdDelete", vo);

    }

    public String resTypeCdCheck(AuthTransferApplicationVO vo) {

        return (String) selectByPk("_authTrnasferApp.resTypeCdCheck", vo);
    }

    public List<AuthTransferApplicationVO> assignmentMenu(AuthTransferApplicationVO vo) {
        return list("_authTrnasferApp.assignmentMenu", vo);
    }

    public AuthTransferApplicationVO assignmentMenuCount(AuthTransferApplicationVO vo) {
        AuthTransferApplicationVO dataVo = (AuthTransferApplicationVO) selectByPk("_authTrnasferApp.assignmentMenuCount", vo);
        return dataVo;
    }

    public List<AuthTransferApplicationVO> mgrAuthBeforeList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.mgrAuthBeforeList", vo);
    }

    public int mgrAuthBeforeListCount(AuthTransferApplicationVO vo) {

        return (Integer) selectByPk("_authTrnasferApp.mgrAuthBeforeListCount", vo);
    }

    public int currentlyListCount(AuthTransferApplicationVO vo) {

        return (Integer) selectByPk("_authTrnasferApp.currentlyListCount", vo);
    }

    public List<AuthTransferApplicationVO> targetMgrAuthBeforeList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.targetMgrAuthBeforeList", vo);
    }

    public int targetMgrAuthBeforeListCount(AuthTransferApplicationVO vo) {

        return (Integer) selectByPk("_authTrnasferApp.targetMgrAuthBeforeListCount", vo);
    }

    /**
     * authTrasferList 설명
     * 
     * @param vo
     * @return
     */
    public List<AuthTransferApplicationVO> authTrasferList(AuthTransferApplicationVO vo) {

        return list("_authTrnasferApp.authTrasferList", vo);
    }

}
