package zes.openworks.intra.authMgrTrs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class AuthTransferDAO extends EgovAbstractMapper {

    public Pager<AuthTransferVO> list(AuthTransferVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("resTypeCds", vo.getResTypeCds());

        List<AuthTransferVO> dataList = list("_authTrnasfer.list", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_authTrnasfer.listCount", parameterMap));

        return new Pager<AuthTransferVO>(dataList, vo);
    }

    public AuthTransferVO applicant(AuthTransferVO vo) {

        return (AuthTransferVO) selectByPk("_authTrnasfer.applicant", vo);
    }

    public List<AuthTransferVO> prvCurrentlyList(AuthTransferVO vo) {

        return list("_authTrnasfer.prvCurrentlyList", vo);
    }

    public AuthTransferVO applicantDirector(AuthTransferVO vo) {

        AuthTransferVO targetMgrId = (AuthTransferVO) selectByPk("_authTrnasfer.targetMgrIdSelect", vo);
        vo.setTargetMgrId(targetMgrId.getTargetMgrId());

        return (AuthTransferVO) selectByPk("_authTrnasfer.applicantDirector", vo);
    }

    public AuthTransferVO targetTitleNm(AuthTransferVO vo) {

        // AuthTransferVO authTransferVO = (AuthTransferVO)
        // selectByPk("_authTrnasfer.targetTitleNm",
        // vo);
        AuthTransferVO authTransferVO = new AuthTransferVO();

        AuthTransferVO Count = (AuthTransferVO) selectByPk("_authTrnasfer.targetCurrentlyListCount", vo);
        authTransferVO.setAssignCount(Count.getAssignCount());

        return authTransferVO;
    }

    public List<AuthTransferVO> currentlyList(AuthTransferVO vo) {

        return list("_authTrnasfer.currentlyList", vo);
    }

    public List<AuthTransferVO> sendCurrentlyList(AuthTransferVO vo) {

        return list("_authTrnasfer.sendCurrentlyList", vo);
    }

    public int authReqApproveAction(AuthTransferVO vo) {

        return update("_authTrnasfer.authReqApproveAction", vo);
    }

    public int authReqItemApproveAction(AuthTransferVO vo) {

        return update("_authTrnasfer.authReqItemApproveAction", vo);
    }

    public List<AuthTransferVO> appAuthReqItemList(AuthTransferVO vo) {

        return list("_authTrnasfer.appAuthReqItemList", vo);
    }

    public int authReqItemApproveAction2(AuthTransferVO vo) {

        return update("_authTrnasfer.authReqItemApproveAction2", vo);
    }

    public int authReqItemMenuAproveAction(AuthTransferVO vo) {

        return update("_authTrnasfer.authReqItemMenuAproveAction", vo);
    }

    public int authMgrAssignAproveAction(AuthTransferVO vo) {

        return update("_authTrnasfer.authMgrAssignAproveAction", vo);
    }

    public int opAuthAproveAction(AuthTransferVO vo) {

        return update("_authTrnasfer.opAuthAproveAction", vo);
    }

    public List<AuthTransferVO> mgrAuthList(AuthTransferVO vo) {

        return list("_authTrnasfer.mgrAuthList", vo);
    }

    public Object prvAuthCdInsert(AuthTransferVO vo) {

        return insert("_authTrnasfer.prvAuthCdInsert", vo);
    }

    public int authMgrAssignDeleteAction(AuthTransferVO vo) {

        return delete("_authTrnasfer.authMgrAssignDeleteAction", vo);
    }

    public int authReqItemMenuDeleteAction(AuthTransferVO vo) {

        return delete("_authTrnasfer.authReqItemMenuDeleteAction", vo);
    }

    public List<AuthTransferVO> mgrAuthBeforeList(AuthTransferVO vo) {

        return list("_authTrnasfer.mgrAuthBeforeList", vo);
    }

    public int mgrAuthBeforeListCount(AuthTransferVO vo) {

        return (Integer) selectByPk("_authTrnasfer.mgrAuthBeforeListCount", vo);
    }

    public int currentlyListCount(AuthTransferVO vo) {

        return (Integer) selectByPk("_authTrnasfer.currentlyListCount", vo);
    }

    public List<AuthTransferVO> targetMgrAuthBeforeList(AuthTransferVO vo) {

        return list("_authTrnasfer.targetMgrAuthBeforeList", vo);
    }

    public int targetMgrAuthBeforeListCount(AuthTransferVO vo) {

        return (Integer) selectByPk("_authTrnasfer.targetMgrAuthBeforeListCount", vo);
    }

    public int authReqItemRetrocedeAction(AuthTransferVO vo) {

        return update("_authTrnasfer.authReqItemRetrocedeAction", vo);
    }

    public String resTypeCdCheck(AuthTransferVO vo) {

        return (String) selectByPk("_authTrnasfer.resTypeCdCheck", vo);
    }

    public List<AuthTransferVO> assignmentMenu(AuthTransferVO vo) {
        return list("_authTrnasfer.assignmentMenu", vo);
    }

    public AuthTransferVO assignmentMenuCount(AuthTransferVO vo) {
        AuthTransferVO dataVo = (AuthTransferVO) selectByPk("_authTrnasfer.assignmentMenuCount", vo);
        return dataVo;
    }

    public List<AuthTransferVO> authTrasferList(AuthTransferVO vo) {

        return list("_authTrnasfer.authTrasferList", vo);
    }

}
