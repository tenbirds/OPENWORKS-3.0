package zes.openworks.intra.authMgrTrs;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("authTransferService")
public class AuthTransferServiceImpl extends AbstractServiceImpl implements AuthTransferService {

    @Resource
    private AuthTransferDAO dao;

    @Override
    public Pager<AuthTransferVO> list(AuthTransferVO vo) {
        return dao.list(vo);
    }

    @Override
    public List<AuthTransferVO> prvCurrentlyList(AuthTransferVO vo) {
        return dao.prvCurrentlyList(vo);
    }

    @Override
    public AuthTransferVO applicantDirector(AuthTransferVO vo) {
        return dao.applicantDirector(vo);
    }

    @Override
    public AuthTransferVO targetTitleNm(AuthTransferVO vo) {
        return dao.targetTitleNm(vo);
    }

    @Override
    public List<AuthTransferVO> currentlyList(AuthTransferVO vo) {
        return dao.currentlyList(vo);
    }

    @Override
    public List<AuthTransferVO> sendCurrentlyList(AuthTransferVO vo) {
        return dao.sendCurrentlyList(vo);
    }

    @Override
    public int authReqApproveAction(AuthTransferVO vo) {

        return dao.authReqApproveAction(vo);
    }

    @Override
    public int authReqItemApproveAction(HttpServletRequest request) {

        String[] authCds = request.getParameter("authCds").split(",");

        int seqNo = 0;
        AuthTransferVO vo;

        seqNo = Integer.parseInt(request.getParameter("seqNo"));

        vo = new AuthTransferVO();

        vo.setSeqNo(seqNo);

        List<AuthTransferVO> appAuthReqItemList = dao.appAuthReqItemList(vo);

        for(int i = 0 ; i < appAuthReqItemList.size() ; i++) {
            String appAuthCd = appAuthReqItemList.get(i).getAuthCds();
            for(int j = 0 ; j < authCds.length ; j++) {
                String authCd = authCds[j];
                if(appAuthCd.equals(authCd)) {
                    dao.authReqItemApproveAction(vo);
                }
            }
        }

        dao.authReqItemApproveAction2(vo);

        return 0;
    }

    @Override
    public int authMgrAssignApproveAction(HttpServletRequest request) {

        String targetMgrId = request.getParameter("targetMgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] authTypeCds = request.getParameter("authTypeCds").split(",");

        LoginVO loginVo = OpHelper.getMgrSession(request);
        AuthTransferVO vo;

        vo = new AuthTransferVO();

        for(int i = 0 ; i < authCds.length ; i++) {
            String authCd = authCds[i];
            String authTypeCd = authTypeCds[i];

            if(authTypeCd.equals("P")) {
                vo.setAuthCd("P_AUTH_" + targetMgrId);
            } else {
                vo.setAuthCd(authCd);
            }
            vo.setTargetMgrId(targetMgrId);
            vo.setRegId(loginVo.getMngrId());

            dao.authMgrAssignAproveAction(vo);
        }

        return 0;
    }

    @Override
    public int authReqItemMenuApproveAction(HttpServletRequest request) {

        String targetMgrId = request.getParameter("targetMgrId");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");
        String[] authTypeCds = request.getParameter("authTypeCds").split(",");

        LoginVO loginVo = OpHelper.getMgrSession(request);
        AuthTransferVO vo;

        vo = new AuthTransferVO();

        int seqNo = Integer.parseInt(request.getParameter("seqNo"));
        vo.setSeqNo(seqNo);

        List<AuthTransferVO> mgrAuthList = dao.mgrAuthList(vo);

        for(int i = 0 ; i < authTypeCds.length ; i++) {
            int count = 0;
            int count3 = 0;
            String authTypeCd = authTypeCds[i];

            if(authTypeCd.equals("P")) {
                ++count;
            }

            if(count > 0) {

                vo.setAuthCd("P_AUTH_" + targetMgrId);
                vo.setRegId(loginVo.getMngrId());

                for(int j = 0 ; j < mgrAuthList.size() ; j++) {
                    String mgrAuthCd = mgrAuthList.get(j).getAuthCds();
                    if(mgrAuthCd.equals("P_AUTH_" + targetMgrId)) {
                        ++count3;
                    }
                }

                vo.setAuthNm(targetMgrId + "의 개별권한");
                vo.setRegId(loginVo.getMngrId());

                if(count3 < 1) {
                    vo.setAuthCd("P_AUTH_" + targetMgrId);
                    dao.prvAuthCdInsert(vo);
                }

                dao.opAuthAproveAction(vo);

                for(int j = 0 ; j < menuCds.length ; j++) {
                    String menuCd = menuCds[j];
                    String assignTypeCd = assignTypeCds[j];

                    vo.setAuthCd("P_AUTH_" + targetMgrId);
                    vo.setMenuCd(menuCd);
                    vo.setAssignTypeCd(assignTypeCd);

                    dao.authReqItemMenuAproveAction(vo);
                }
            }
        }

        return 0;
    }

    @Override
    public int deleteAction(HttpServletRequest request) {

        String mgrId = request.getParameter("mgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] authTypeCds = request.getParameter("authTypeCds").split(",");

        AuthTransferVO vo;

        vo = new AuthTransferVO();

        for(int i = 0 ; i < authCds.length ; i++) {
            String authCd = authCds[i];
            vo.setAuthCd(authCd);
            vo.setMngrId(mgrId);

            dao.authMgrAssignDeleteAction(vo);
        }

        for(int i = 0 ; i < authTypeCds.length ; i++) {
            int count = 0;
            String authTypeCd = authTypeCds[i];

            if(authTypeCd.equals("P")) {
                ++count;
            }

            if(count > 0) {
                for(int j = 0 ; j < menuCds.length ; j++) {
                    String menuCd = menuCds[j];

                    vo.setAuthCd("P_AUTH_" + mgrId);
                    vo.setMenuCd(menuCd);

                    dao.authReqItemMenuDeleteAction(vo);
                }
            }
        }
        return 0;
    }

    @Override
    public List<AuthTransferVO> mgrAuthBeforeList(AuthTransferVO vo) {

        return dao.mgrAuthBeforeList(vo);
    }

    @Override
    public int mgrAuthBeforeListCount(AuthTransferVO vo) {

        return dao.mgrAuthBeforeListCount(vo);
    }

    @Override
    public int currentlyListCount(AuthTransferVO vo) {

        return dao.currentlyListCount(vo);
    }

    @Override
    public List<AuthTransferVO> targetMgrAuthBeforeList(AuthTransferVO vo) {

        return dao.targetMgrAuthBeforeList(vo);
    }

    @Override
    public int targetMgrAuthBeforeListCount(AuthTransferVO vo) {

        return dao.targetMgrAuthBeforeListCount(vo);
    }

    @Override
    public List<AuthTransferVO> targetMgrAuthAfterList(AuthTransferVO vo) {

        vo.setMngrId(vo.getTargetMgrId());

        return dao.currentlyList(vo);
    }

    @Override
    public int targetMgrAuthAfterListCount(AuthTransferVO vo) {

        vo.setMngrId(vo.getTargetMgrId());

        return dao.currentlyListCount(vo);
    }

    @Override
    public int authReqItemRetrocedeAction(HttpServletRequest request) {

        int seqNo = 0;
        AuthTransferVO vo = new AuthTransferVO();
        ;

        seqNo = Integer.parseInt(request.getParameter("seqNo"));

        vo.setSeqNo(seqNo);

        return dao.authReqItemRetrocedeAction(vo);
    }

    @Override
    public String resTypeCdCheck(AuthTransferVO vo) {

        return dao.resTypeCdCheck(vo);
    }

    @Override
    public List<AuthTransferVO> assignmentMenu(AuthTransferVO vo) {

        return dao.assignmentMenu(vo);
    }

    @Override
    public AuthTransferVO assignmentMenuCount(AuthTransferVO vo) {
        return dao.assignmentMenuCount(vo);
    }

    @Override
    public List<AuthTransferVO> authTrasferList(AuthTransferVO vo) {

        return dao.authTrasferList(vo);
    }

}
