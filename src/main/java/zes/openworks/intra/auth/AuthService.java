package zes.openworks.intra.auth;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

public interface AuthService {

    /**
     * 권한그룹 목록
     * 
     * @param vo
     * @return
     */
    List<AuthVO> groupAuthList(AuthVO vo);

    /**
     * 권한그룹 상세
     * 
     * @param vo
     * @return
     */
    AuthVO authView(AuthVO vo);

    Pager<AuthMgrVO> mgrList(AuthMgrVO vo);

    List<AuthMenuVO> menuList(AuthVO vo);

    List<AuthMgrVO> mgrDeptAllList(AuthMgrVO vo);

    AuthVO insertAuth(AuthVO vo);

    int updateAuth(AuthVO vo);

    int deleteAuth(AuthVO vo);

    int dupCheckAuth(AuthVO vo);

    int saveAssignMenu(HttpServletRequest request);

    Pager<AuthMgrVO> mgrList4Auth(AuthMgrVO vo);

    int saveAssignMgr(HttpServletRequest request);

    List<AuthMenuVO> authMenuList(AuthVO vo);

    Pager<AuthMgrVO> assignMgrList(AuthMgrVO vo);

    List<AuthVO> mgrAuthList(AuthVO vo);

    int saveAssign4Mgr(HttpServletRequest request);

    List<AuthMgrVO> assignMgrListExcel(AuthMgrVO vo);
}
