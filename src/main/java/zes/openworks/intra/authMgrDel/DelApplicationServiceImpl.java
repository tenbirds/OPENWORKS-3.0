package zes.openworks.intra.authMgrDel;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.support.OpHelper;
import zes.openworks.intra.authMgrAdd.AddApplicationDAO;
import zes.openworks.intra.authMgrAdd.AddApplicationVO;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("delApplicationService")
public class DelApplicationServiceImpl extends AbstractServiceImpl implements DelApplicationService {

    @Resource
    private DelApplicationDAO dao;
    @Resource
    private AddApplicationDAO dao2;

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
    public List<AddApplicationVO> currentlyList2(AddApplicationVO vo) {
        return dao.currentlyList2(vo);
    }

    @Override
    public int insert(AddApplicationVO vo, HttpServletRequest request) {
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");
        int seqNo = 0;
        LoginVO loginVo = OpHelper.getMgrSession(request);
        AddApplicationVO newSeq = new AddApplicationVO();
        seqNo = dao2.newSeqNo(newSeq);
        vo.setSeqNo(seqNo);
        vo.setMngrId(loginVo.getMngrId());
        vo.setReqTypeCd("D");
        vo.setResConts(request.getParameter("reqConts"));
        dao2.authReqInsert(vo);

        if(request.getParameter("authCds").length() > 0) {
            for(String authCd : authCds) {
                vo.setAuthCd(authCd);
                dao2.authReqItemInsert(vo);
            }
        }

        if(request.getParameter("menuCds").length() > 0) {
            vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
            dao2.authReqItemInsert(vo);
            for(int i = 0 ; i < menuCds.length ; i++) {
                vo.setMenuCd(menuCds[i]);
                vo.setAssignTypeCd(assignTypeCds[i]);
                dao.menuReqItemDel(vo);
            }
        }

        return 0;
    }

}
