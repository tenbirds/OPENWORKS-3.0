package zes.openworks.intra.authMgrTrs;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("authTransferApplicationService")
public class AuthTransferApplicationServiceImpl extends AbstractServiceImpl implements AuthTransferApplicationService {

    @Resource
    private AuthTransferApplicationDAO dao;

    @Override
    public Pager<AuthTransferApplicationVO> list(AuthTransferApplicationVO vo) {
        return dao.list(vo);
    }

    @Override
    public AuthTransferApplicationVO applicant(AuthTransferApplicationVO vo) {
        return dao.applicant(vo);
    }

    @Override
    public List<AuthTransferApplicationVO> currentlyList(AuthTransferApplicationVO vo) {
        return dao.currentlyList(vo);
    }

    @Override
    public List<AuthTransferApplicationVO> prvCurrentlyList(AuthTransferApplicationVO vo) {
        return dao.prvCurrentlyList(vo);
    }

    @Override
    public Pager<AuthTransferApplicationVO> directorSerchList(AuthTransferApplicationVO vo) {
        return dao.directorSerchList(vo);
    }

    @Override
    public int insertAction(HttpServletRequest request) {
        String reqConts = request.getParameter("reqConts");
        String targetMgrId = request.getParameter("targetMgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");
        String[] authTypeCds = request.getParameter("authTypeCds").split(",");
        int seqNo = 0;
        LoginVO loginVo = OpHelper.getMgrSession(request);
        AuthTransferApplicationVO vo;
        AuthTransferApplicationVO newSeq = new AuthTransferApplicationVO();

        seqNo = dao.newSeqNo(newSeq);

        vo = new AuthTransferApplicationVO();
        List<AuthTransferApplicationVO> mgrAuthList = dao.mgrAuthList(vo);

        vo.setMngrId(loginVo.getMngrId());
        vo.setReqConts(reqConts);
        vo.setTargetMgrId(targetMgrId);
        vo.setSeqNo(seqNo);

        dao.authReqInsert(vo);

        // 이양시킬 권한중에 개별권한이 있으면 대상자가 개별권한이 있는지 체크 후 없으면 개별권한을 생성한다.
        for(int i = 0 ; i < authTypeCds.length ; i++) {
            String authTypeCd = authTypeCds[i];
            if(authTypeCd.equals("P")) {
                int count = 0;
                for(int j = 0 ; j < mgrAuthList.size() ; j++) {
                    String mgrAuthCd = mgrAuthList.get(j).getAuthCds();
                    if(mgrAuthCd.equals("P_AUTH_" + targetMgrId)) {
                        ++count;
                    }
                }
                if(count < 1) {
                    vo.setAuthCd("P_AUTH_" + targetMgrId);
                    vo.setAuthNm(targetMgrId + "의 개별권한");
                    dao.prvAuthCdInsert(vo);
                }
            }
        }

        if(request.getParameter("authCds").length() > 0) {
            for(int i = 0 ; i < authCds.length ; i++) {
                String authCd = authCds[i];
                if(authTypeCds[i].equals("P")) {
                    vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
                } else {
                    vo.setAuthCd(authCd);
                }
                vo.setSeqNo(seqNo);
                dao.authReqItemInsert(vo);
            }
        }

        if(request.getParameter("menuCds").length() > 0) {

            // AuthTransferApplicationVO aTAVo = new
            // AuthTransferApplicationVO();
            // aTAVo.setAuthCd("P_AUTH_"+loginVo.getMgrId());
            // aTAVo.setAuthNm(loginVo.getMgrId()+"의 개별권한");
            //
            // dao.creatAuth(aTAVo);

            for(int i = 0 ; i < menuCds.length ; i++) {
                if(menuCds[i] != null && !"".equals(menuCds[i])) {

                    vo = new AuthTransferApplicationVO();
                    vo.setSeqNo(seqNo);
                    vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
                    vo.setMngrId(loginVo.getMngrId());
                    vo.setMenuCd(menuCds[i]);
                    vo.setAssignTypeCd(assignTypeCds[i]);
                    dao.saveAssignMenu(vo);
                }
            }
        }
        return 0;
    }

    @Override
    public AuthTransferApplicationVO applicantDirector(AuthTransferApplicationVO vo) {
        return dao.applicantDirector(vo);
    }

    @Override
    public int updateAction(HttpServletRequest request) {
        String reqConts = request.getParameter("reqConts");
        String targetMgrId = request.getParameter("targetMgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] menuCds = request.getParameter("menuCds").split(",");
        String[] assignTypeCds = request.getParameter("assignTypeCds").split(",");
        String[] authTypeCds = request.getParameter("authTypeCds").split(",");

        int seqNo = 0;
        LoginVO loginVo = OpHelper.getMgrSession(request);
        AuthTransferApplicationVO vo;

        seqNo = Integer.parseInt(request.getParameter("seqNo"));

        vo = new AuthTransferApplicationVO();
        List<AuthTransferApplicationVO> mgrAuthList = dao.mgrAuthList(vo);

        vo.setMngrId(loginVo.getMngrId());
        vo.setReqConts(reqConts);
        vo.setTargetMgrId(targetMgrId);
        vo.setSeqNo(seqNo);

        dao.authReqUpdate(vo);

        // 수정시 이양시킬 권한중에 개별권한이 없으면 개별권한(대상자) 사용여부(없으면 지움)를 판단하여 개별권한을 지운다.
        // for (int i = 0; i < authTypeCds.length; i++) {
        // String authTypeCd = authTypeCds[i];
        // int count = 0;
        // int count2 = 0;
        // int count3 = 0;
        //
        // if(authTypeCd.equals("P")){
        // ++count;
        // }
        //
        // if(count < 1 ){
        // for (int j = 0; j < mgrAuthList.size(); j++) {
        // String mgrAuthCd = mgrAuthList.get(j).getAuthCds();
        // String useYn = (mgrAuthList.get(j).getUseYn()!=null)?
        // mgrAuthList.get(j).getUseYn() : "";
        //
        // if(mgrAuthCd.equals("P_AUTH_"+targetMgrId) && useYn.equals("")){
        // ++count2;
        // }
        // }
        // if(count2 > 0){
        // vo.setAuthCd("P_AUTH_"+targetMgrId);
        // dao.prvAuthCdDelete(vo);
        // }
        // }else{
        // for (int j = 0; j < mgrAuthList.size(); j++) {
        // String mgrAuthCd = mgrAuthList.get(j).getAuthCds();
        // if(mgrAuthCd.equals("P_AUTH_"+targetMgrId)){
        // ++count3;
        // }
        // }
        // if(count3 < 1 ){
        // vo.setAuthCd("P_AUTH_"+targetMgrId);
        // vo.setAuthNm(targetMgrId+"의 개별권한");
        // dao.prvAuthCdInsert(vo);
        // }
        // }
        // }

        // 이양시킬 권한중에 개별권한이 있으면 대상자가 개별권한이 있는지 체크 후 없으면 개별권한을 생성한다.
        for(int i = 0 ; i < authTypeCds.length ; i++) {
            String authTypeCd = authTypeCds[i];
            if(authTypeCd.equals("P")) {
                int count = 0;
                for(int j = 0 ; j < mgrAuthList.size() ; j++) {
                    String mgrAuthCd = mgrAuthList.get(j).getAuthCds();
                    if(mgrAuthCd.equals("P_AUTH_" + targetMgrId)) {
                        ++count;
                    }
                }
                if(count < 1) {
                    vo.setAuthCd("P_AUTH_" + targetMgrId);
                    vo.setAuthNm(targetMgrId + "의 개별권한");
                    dao.prvAuthCdInsert(vo);
                }
            }
        }

        if(request.getParameter("authCds").length() > 0) {
            vo.setSeqNo(seqNo);
            dao.authReqItemDelete(vo);
            for(int i = 0 ; i < authCds.length ; i++) {
                String authCd = authCds[i];
                if(authTypeCds[i].equals("P")) {
                    vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
                } else {
                    vo.setAuthCd(authCd);
                }
                dao.authReqItemInsert(vo);
            }
        }

        if(request.getParameter("menuCds").length() > 0) {

            // AuthTransferApplicationVO aTAVo = new
            // AuthTransferApplicationVO();
            // aTAVo.setAuthCd("P_AUTH_"+loginVo.getMgrId());
            // aTAVo.setAuthNm(loginVo.getMgrId()+"의 개별권한");
            //
            // dao.creatAuth(aTAVo);

            vo = new AuthTransferApplicationVO();
            vo.setSeqNo(seqNo);

            dao.deleteAssignMenu(vo);

            for(int i = 0 ; i < menuCds.length ; i++) {
                if(menuCds[i] != null && !"".equals(menuCds[i])) {

                    vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
                    vo.setMngrId(loginVo.getMngrId());
                    vo.setMenuCd(menuCds[i]);
                    vo.setAssignTypeCd(assignTypeCds[i]);

                    dao.saveAssignMenu(vo);
                }
            }
        }
        return 0;
    }

    @Override
    public List<AuthTransferApplicationVO> sendCurrentlyList(AuthTransferApplicationVO vo) {
        return dao.sendCurrentlyList(vo);
    }

    @Override
    public String resTypeCdCheck(AuthTransferApplicationVO vo) {

        return dao.resTypeCdCheck(vo);
    }

    @Override
    public List<AuthTransferApplicationVO> assignmentMenu(AuthTransferApplicationVO vo) {

        return dao.assignmentMenu(vo);
    }

    @Override
    public AuthTransferApplicationVO assignmentMenuCount(AuthTransferApplicationVO vo) {
        return dao.assignmentMenuCount(vo);
    }

    @Override
    public List<AuthTransferApplicationVO> mgrAuthBeforeList(AuthTransferApplicationVO vo) {

        return dao.mgrAuthBeforeList(vo);
    }

    @Override
    public int mgrAuthBeforeListCount(AuthTransferApplicationVO vo) {

        return dao.mgrAuthBeforeListCount(vo);
    }

    @Override
    public int currentlyListCount(AuthTransferApplicationVO vo) {

        return dao.currentlyListCount(vo);
    }

    @Override
    public List<AuthTransferApplicationVO> targetMgrAuthBeforeList(AuthTransferApplicationVO vo) {

        return dao.targetMgrAuthBeforeList(vo);
    }

    @Override
    public int targetMgrAuthBeforeListCount(AuthTransferApplicationVO vo) {

        return dao.targetMgrAuthBeforeListCount(vo);
    }

    @Override
    public List<AuthTransferApplicationVO> targetMgrAuthAfterList(AuthTransferApplicationVO vo) {

        vo.setMngrId(vo.getTargetMgrId());

        return dao.currentlyList(vo);
    }

    @Override
    public int targetMgrAuthAfterListCount(AuthTransferApplicationVO vo) {

        vo.setMngrId(vo.getTargetMgrId());

        return dao.currentlyListCount(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.authMgrTrs.AuthTransferApplicationService#authTrasferList
     * (zes.openworks.intra.authMgrTrs.AuthTransferApplicationVO)
     */
    @Override
    public List<AuthTransferApplicationVO> authTrasferList(AuthTransferApplicationVO vo) {

        return dao.authTrasferList(vo);
    }

}
