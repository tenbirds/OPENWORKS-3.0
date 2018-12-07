package zes.openworks.intra.authMgrAdd;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("addApplicationService")
public class AddApplicationServiceImpl extends AbstractServiceImpl implements AddApplicationService {

    @Resource
    private AddApplicationDAO dao;

    @Override
    public Pager<AddApplicationVO> list(AddApplicationVO vo) {
        return dao.list(vo);
    }

    @Override
    public AddApplicationVO applicant(AddApplicationVO vo) {
        AddApplicationVO dataVo = dao.applicant(vo);
        return dataVo;
    }

    @Override
    public List<AddApplicationVO> currentlyList(AddApplicationVO vo) {
        return dao.currentlyList(vo);
    }

    @Override
    public List<AddApplicationVO> currentlyList1(AddApplicationVO vo) {
        return dao.currentlyList1(vo);
    }

    @Override
    public List<AddApplicationVO> addList2(AddApplicationVO vo) {
        return dao.addList2(vo);
    }

    @Override
    public List<AddApplicationVO> addList3(AddApplicationVO vo) {
        return dao.addList3(vo);
    }

    @Override
    public List<AddApplicationVO> authGroupList(AddApplicationVO vo) {
        return dao.authGroupList(vo);
    }

    @Override
    public List<AddApplicationVO> assignmentMenu(AddApplicationVO vo) {
        return dao.assignmentMenu(vo);
    }

    @Override
    public AddApplicationVO assignmentMenuCount(AddApplicationVO vo) {
        return dao.assignmentMenuCount(vo);
    }

    @Override
    public List<AddApplicationVO> menuAllList(AddApplicationVO vo) {
        return dao.menuAllList(vo);
    }

    @Override
    public int insert(HttpServletRequest request) {
        String reqConts = request.getParameter("reqconts");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");
        int seqNo = 0;
        LoginVO loginVo = OpHelper.getMgrSession(request);
        AddApplicationVO vo;
        AddApplicationVO newSeq = new AddApplicationVO();
        seqNo = dao.newSeqNo(newSeq);
        vo = new AddApplicationVO();
        vo.setMngrId(loginVo.getMngrId());
        vo.setReqConts(reqConts);
        vo.setSeqNo(seqNo);
        vo.setReqTypeCd("A");
        dao.authReqInsert(vo);
        if(request.getParameter("authCds").length() > 0) {
            for(String authCd : authCds) {
                vo.setAuthCd(authCd);
                vo.setSeqNo(seqNo);
                dao.authReqItemInsert(vo);
            }
        }

        if(request.getParameter("menuCds").length() > 0) {

            AddApplicationVO addApplication = new AddApplicationVO();
            addApplication.setAuthCd("P_AUTH_" + loginVo.getMngrId());
            addApplication.setAuthNm(loginVo.getMngrId() + "의 개별권한");
            dao.creatAuth(addApplication);
            for(int i = 0 ; i < menuCds.length ; i++) {
                if(menuCds[i] != null && !"".equals(menuCds[i])) {
                    vo = new AddApplicationVO();
                    vo.setSeqNo(seqNo);
                    vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
                    vo.setMngrId(loginVo.getMngrId());
                    vo.setMenuCd(menuCds[i]);
                    vo.setAssignTypeCd(assignTypeCds[i]);
                    dao.saveAssignMenu(vo);
                }
            }
            vo = new AddApplicationVO();

            vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
            vo.setMngrId(loginVo.getMngrId());
            vo.setSeqNo(seqNo);
            vo.setReqConts(reqConts);
            vo.setReqTypeCd("A");
            dao.authReqItemInsert(vo);
        }

        return 0;
    }

}
