package zes.openworks.intra.authMgrDel;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.support.OpHelper;
import zes.openworks.intra.authMgrAdd.AdditionalVO;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("deletionService")
public class DeletionServiceImpl extends AbstractServiceImpl implements DeletionService {

    @Resource
    private DeletionDAO dao;

    @Override
    public List<AdditionalVO> delList(AdditionalVO vo, HttpServletRequest request) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
        vo.setReqTypeCd("D");
        return dao.delList(vo);
    }

    @Override
    public List<AdditionalVO> delList2(AdditionalVO vo, HttpServletRequest request) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
        return dao.delList2(vo);
    }

    @Override
    public int delete(AdditionalVO vo, HttpServletRequest request) {
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setPrcMgrId(loginVo.getMngrId());
        vo.setMngrId(request.getParameter("mgrId"));
        dao.regUpdate(vo);
        dao.reqItemUpdate(vo);

        if(request.getParameter("authCds").length() > 0) {
            for(String authCd : authCds) {
                vo.setAuthCd(authCd);
                dao.delMgrAssign(vo);

            }
        }

        if(request.getParameter("menuCds").length() > 0) {
            vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
            for(int i = 0 ; i < menuCds.length ; i++) {
                vo.setMenuCd(menuCds[i]);
                dao.delMenuAssign(vo);
            }
        }
        return 0;
    }

}
