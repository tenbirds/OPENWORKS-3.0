package zes.openworks.intra.auth;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class AuthDAO extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public List<AuthVO> groupAuthList(AuthVO vo) {
        return list("_auth.groupAuthList", vo);
    }

    public AuthVO authView(AuthVO vo) {
        return (AuthVO) selectByPk("_auth.authView", vo);
    }

    public AuthVO insertAuth(AuthVO vo) {
        insert("_auth.insertAuth", vo);
        return vo;
    }

    public int updateAuth(AuthVO vo) {

        if(!vo.getAuthCode().equals(vo.getOldAuthCd())) {
            insert("_auth.insertAuth", vo);
            update("_auth.updateAuthMgrAssign", vo);
            update("_auth.updateAuthMenuAssign", vo);
            //update("_auth.updateAuthReqItem", vo);
            return delete("_auth.deleteAuth", vo);
        } else {
            update("_auth.updateAuth", vo);
            update("_auth.updateAuthMgrAssign", vo);            
            return update("_auth.updateAuthMenuAssign", vo);//update("_auth.updateAuthReqItem", vo);
        }
    }

    public int deleteAuth(AuthVO vo) {
        delete("_auth.deleteAuthMenuAssign", vo);
        delete("_auth.deleteAuthMgrAssign", vo);
        //delete("_auth.deleteAuthReqItem", vo);

        return delete("_auth.deleteAuth", vo);
    }

    public int dupCheckAuth(AuthVO vo) {
        return (Integer) selectByPk("_auth.dupCheckAuth", vo);
    }

    @SuppressWarnings("unchecked")
    public List<AuthMenuVO> menuAllList(AuthVO vo) {
        return list("_auth.menuAllList", vo);
    }

    public int deleteAssignMenu(AuthMgrVO vo) {
        return update("_auth.deleteAssignMenu", vo);
    }

    public int saveAssignMenu(AuthMgrVO vo) {
        return update("_auth.saveAssignMenu", vo);
    }

    @SuppressWarnings("unchecked")
    public Pager<AuthMgrVO> mgrList4Auth(AuthMgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("menuCd", vo.getMenuCd());
        parameterMap.put("authCode", vo.getAuthCode());

        List<AuthMgrVO> dataList = list("_auth.mgrList4Auth", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_auth.mgrList4AuthCount", parameterMap));

        return new Pager<AuthMgrVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public Pager<AuthMgrVO> mgrList(AuthMgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();

        parameterMap.put("deptCode", vo.getDeptCode());
        parameterMap.put("mgrId", vo.getMngrId());
        parameterMap.put("mgrNm", vo.getMngrNm());
        parameterMap.put("langCode", "00");
        List<AuthMgrVO> dataList = list("_auth.mgrList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_auth.mgrListCount", parameterMap));

        return new Pager<AuthMgrVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public Pager<AuthMgrVO> assignMgrList(AuthMgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();

        List<AuthMgrVO> dataList = list("_auth.assignMgrList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_auth.assignMgrListCount", parameterMap));

        return new Pager<AuthMgrVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public List<AuthMgrVO> assignMgrListExcel(AuthMgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();

        List<AuthMgrVO> dataList = list("_auth.assignMgrListExcel", parameterMap);

        return dataList;
    }

    @SuppressWarnings("unchecked")
    public List<AuthMgrVO> mgrDeptAllList(AuthMgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();

        parameterMap.put("deptCode", vo.getDeptCode());
        parameterMap.put("upperDeptCode", vo.getUpperDeptCode());
        parameterMap.put("langCode", "00");
        return list("_auth.mgrDeptAllList", parameterMap);
    }

    public int savAssignMgr(AuthMgrVO vo) {
        return update("_auth.saveAssignMgr", vo);
    }

    @SuppressWarnings("unchecked")
    public List<AuthMenuVO> authMenuList(AuthVO vo) {
        return list("_auth.authMenuList", vo);
    }

    @SuppressWarnings("unchecked")
    public List<AuthVO> mgrAuthList(AuthVO vo) {
        return list("_auth.mgrAuthList", null);
    }

    public AuthMgrVO getAuthMgr(AuthMgrVO vo) {
        return (AuthMgrVO) selectByPk("_auth.mgrAuthList", vo);
    }

    public String getNewPersonAuthCd(AuthMgrVO vo) {
        return (String) selectByPk("_auth.newPersonCd", vo);
    }
}
