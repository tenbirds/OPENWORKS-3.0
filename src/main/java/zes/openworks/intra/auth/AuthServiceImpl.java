package zes.openworks.intra.auth;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("authService")
public class AuthServiceImpl extends AbstractServiceImpl implements AuthService {

    @Autowired
    private AuthDAO dao;

    @Override
    public List<AuthVO> groupAuthList(AuthVO vo) {
        return dao.groupAuthList(vo);
    }

    @Override
    public AuthVO authView(AuthVO vo) {
        return dao.authView(vo);
    }

    @Override
    public AuthVO insertAuth(AuthVO vo) {
        return dao.insertAuth(vo);
    }

    @Override
    public int updateAuth(AuthVO vo) {
        return dao.updateAuth(vo);
    }

    @Override
    public int deleteAuth(AuthVO vo) {
        return dao.deleteAuth(vo);
    }

    @Override
    public int dupCheckAuth(AuthVO vo) {
        return dao.dupCheckAuth(vo);
    }

    @Override
    public int saveAssignMenu(HttpServletRequest request) {
        String authCd = request.getParameter("authCode");
        String[] menuCds = request.getParameterValues("menuCd");
        String[] authTypeCds = request.getParameterValues("authTyCode");

        AuthMgrVO vo = new AuthMgrVO();
        vo.setAuthCode(authCd);
        dao.deleteAssignMenu(vo);

        for(int i = 0 ; i < menuCds.length ; i++) {
            if(menuCds[i] != null && !"".equals(menuCds[i])) {
                vo = new AuthMgrVO();
                vo.setAuthCode(authCd);
                vo.setMenuCd(menuCds[i]);
                vo.setAsgnTyCode(authTypeCds[i]);

                dao.saveAssignMenu(vo);
            }
        }

        return 0;
    }

    /**
     * 권한관리 담당자 목록
     * 
     * @param vo
     * @return
     */
    @Override
    public Pager<AuthMgrVO> mgrList4Auth(AuthMgrVO vo) {
        return dao.mgrList4Auth(vo);
    }

    @Override
    public Pager<AuthMgrVO> mgrList(AuthMgrVO vo) {
        return dao.mgrList(vo);
    }

    @Override
    public List<AuthMgrVO> mgrDeptAllList(AuthMgrVO vo) {
        return dao.mgrDeptAllList(vo);
    }

    @Override
    public List<AuthMenuVO> menuList(AuthVO vo) {
        return dao.menuAllList(vo);
    }

    @Override
    public int saveAssignMgr(HttpServletRequest request) {
        String[] authCds = request.getParameter("authCds").split(",");
        String[] mgrIds = request.getParameterValues("mngrId");

        AuthMgrVO vo;
        for(String authCd : authCds) {
            for(String mgrId : mgrIds) {
                vo = new AuthMgrVO();
                vo.setAuthCode(authCd);
                vo.setMngrId(mgrId);

                dao.savAssignMgr(vo);
            }
        }

        return 0;
    }

    @Override
    public List<AuthMenuVO> authMenuList(AuthVO vo) {
        return dao.authMenuList(vo);
    }

    @Override
    public Pager<AuthMgrVO> assignMgrList(AuthMgrVO vo) {
        return dao.assignMgrList(vo);
    }

    @Override
    public List<AuthVO> mgrAuthList(AuthVO vo) {
        return dao.mgrAuthList(vo);
    }

    @Override
    public int saveAssign4Mgr(HttpServletRequest request) {
        String mgrId = request.getParameter("mgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");

        AuthMgrVO vo;
        for(int i = 0 ; i < authCds.length ; i++) {
            if(authCds[i] != null && !"".equals(authCds[i])) {
                vo = new AuthMgrVO();
                vo.setAuthCode(authCds[i]);
                vo.setMngrId(mgrId);

                dao.savAssignMgr(vo);
            }
        }

        AuthMgrVO authMgr = new AuthMgrVO();
        authMgr.setMngrId(mgrId);
        authMgr = dao.getAuthMgr(authMgr);

        String personAuthCd = "";
        if(authMgr != null && !"".equals(authMgr.getAuthCode())) {
            personAuthCd = authMgr.getAuthCode();
        } else {
            authMgr = new AuthMgrVO();
            authMgr.setMngrId(mgrId);
            personAuthCd = dao.getNewPersonAuthCd(authMgr);

            AuthVO auth = new AuthVO();
            auth.setAuthCode(personAuthCd);
            auth.setAuthTyCode("P");
            auth.setAuthNm("개인권한(" + mgrId + ")");
            auth.setUseYn("Y");

            dao.insertAuth(auth);
        }

        authMgr.setAuthCode(personAuthCd);
        dao.savAssignMgr(authMgr);

        for(int i = 0 ; i < menuCds.length ; i++) {
            if(menuCds[i] != null && !"".equals(menuCds[i])) {
                vo = new AuthMgrVO();
                vo.setAuthCode(personAuthCd);
                vo.setMenuCd(menuCds[i]);
                vo.setAsgnTyCode(assignTypeCds[i]);

                dao.saveAssignMenu(vo);

            }
        }

        return 0;
    }

    @Override
    public List<AuthMgrVO> assignMgrListExcel(AuthMgrVO vo) {

        return dao.assignMgrListExcel(vo);
    }
}
