package zes.openworks.intra.authMgrAdd;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("additionalService")
public class AdditionalServiceImpl extends AbstractServiceImpl implements AdditionalService {

    @Resource
    private AddtionalDAO dao;

    @Override
    public Pager<AdditionalVO> list(AdditionalVO vo) {
        return dao.list(vo);
    }

    @Override
    public AdditionalVO applicant(AdditionalVO vo) {
        AdditionalVO dataVo = dao.applicant(vo);
        return dataVo;
    }

    @Override
    public int retrocession(AdditionalVO vo) {
        return dao.retrocession(vo);
    }

    @Override
    public int retrocession2(AdditionalVO vo) {
        return dao.retrocession2(vo);
    }

    @Override
    public int approve(AdditionalVO vo) {
        return dao.approve(vo);
    }

    @Override
    public int approve2(AdditionalVO vo) {
        return dao.approve2(vo);
    }

    @Override
    public List<AdditionalVO> currentlyList(AdditionalVO vo) {
        return dao.currentlyList(vo);
    }

    @Override
    public List<AdditionalVO> assignmentMenu(AdditionalVO vo) {

        return dao.assignmentMenu(vo);
    }

    @Override
    public List<AdditionalVO> assignmentMenu2(AdditionalVO vo) {

        return dao.assignmentMenu2(vo);
    }

    @Override
    public AdditionalVO assignmentMenuCount(AdditionalVO vo) {
        return dao.assignmentMenuCount(vo);
    }

    @Override
    public AdditionalVO assignmentMenuCount2(AdditionalVO vo) {
        return dao.assignmentMenuCount2(vo);
    }

    @Override
    public List<AdditionalVO> addList(AdditionalVO vo) {

        return dao.addList(vo);
    }

    @Override
    public List<AdditionalVO> addList2(AdditionalVO vo) {

        return dao.addList2(vo);
    }

    @Override
    public List<AdditionalVO> addList3(AdditionalVO vo) {
        return dao.addList3(vo);
    }

    @Override
    public List<AdditionalVO> authCds(AdditionalVO vo) {
        return dao.authCds(vo);
    }

    @Override
    public int approve3(HttpServletRequest request) {
        String mgrId = request.getParameter("mgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");
        for(String authCd : authCds) {
            AdditionalVO vo = new AdditionalVO();
            vo.setAuthCd(authCd);
            vo.setMngrId(mgrId);
            LoginVO loginVo = OpHelper.getMgrSession(request);
            vo.setRegId(loginVo.getMngrId());
            if(vo.getAuthCd().equals("P_AUTH_" + vo.getMngrId())) {
                dao.creatMgrAssign(vo);
                for(int i = 0 ; i < menuCds.length ; i++) {
                    AdditionalVO vo1 = new AdditionalVO();
                    vo1.setMenuCd(menuCds[i]);
                    vo1.setAssignTypeCd(assignTypeCds[i]);
                    vo1.setAuthCd(authCd);
                    dao.saveAssignMenu(vo1);
                }
            } else {
                dao.approve3(vo);
            }
        }
        return 0;
    }

    @Override
    public List<AdditionalVO> getMenuCd(AdditionalVO vo) {
        return dao.menuCds(vo);
    }

    @Override
    public AdditionalVO listCount2(AdditionalVO vo) {
        return dao.listCount2(vo);
    }

    @Override
    public AdditionalVO listCount3(AdditionalVO vo) {
        return dao.listCount3(vo);
    }

}
