package zes.openworks.intra.authMgrTrs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

public interface AuthTransferService {

    /** 권한 이양 요청 관리 목록 */
    Pager<AuthTransferVO> list(AuthTransferVO vo);

    /** 신청자 할당 권한 정보(개별권한) */
    List<AuthTransferVO> prvCurrentlyList(AuthTransferVO vo);

    /** 권한 이양 신청자,대상자 정보 */
    AuthTransferVO applicantDirector(AuthTransferVO vo);

    AuthTransferVO targetTitleNm(AuthTransferVO vo);

    /** 신청자 할당 권한 정보 */
    List<AuthTransferVO> currentlyList(AuthTransferVO vo);

    /** 이양시킬 권한 정보 */
    List<AuthTransferVO> sendCurrentlyList(AuthTransferVO vo);

    int authReqApproveAction(AuthTransferVO vo);

    int authReqItemApproveAction(HttpServletRequest request);

    int authReqItemMenuApproveAction(HttpServletRequest request);

    int authMgrAssignApproveAction(HttpServletRequest request);

    int deleteAction(HttpServletRequest request);

    // 신청자 변경전 권한 정보
    List<AuthTransferVO> mgrAuthBeforeList(AuthTransferVO vo);

    int mgrAuthBeforeListCount(AuthTransferVO vo);

    int currentlyListCount(AuthTransferVO vo);

    List<AuthTransferVO> targetMgrAuthBeforeList(AuthTransferVO vo);

    int targetMgrAuthBeforeListCount(AuthTransferVO vo);

    List<AuthTransferVO> targetMgrAuthAfterList(AuthTransferVO vo);

    int targetMgrAuthAfterListCount(AuthTransferVO vo);

    int authReqItemRetrocedeAction(HttpServletRequest request);

    String resTypeCdCheck(AuthTransferVO vo);

    List<AuthTransferVO> assignmentMenu(AuthTransferVO vo);

    AuthTransferVO assignmentMenuCount(AuthTransferVO vo);

    List<AuthTransferVO> authTrasferList(AuthTransferVO vo);

}
