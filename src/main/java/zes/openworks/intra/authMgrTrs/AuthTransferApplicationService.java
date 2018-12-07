package zes.openworks.intra.authMgrTrs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

public interface AuthTransferApplicationService {

    /** 권한 이양 요청 관리 목록 */
    Pager<AuthTransferApplicationVO> list(AuthTransferApplicationVO vo);

    /** 권한 이양 신청자 정보 */
    AuthTransferApplicationVO applicant(AuthTransferApplicationVO vo);

    /** 신청자 할당 권한 정보 */
    List<AuthTransferApplicationVO> currentlyList(AuthTransferApplicationVO vo);

    /** 담당자 목록 */
    Pager<AuthTransferApplicationVO> directorSerchList(AuthTransferApplicationVO vo);

    /** 권한 이양 신청 */
    int insertAction(HttpServletRequest request);

    /** 현재 할당 된 개별권한의 메뉴 정보 */
    List<AuthTransferApplicationVO> prvCurrentlyList(AuthTransferApplicationVO vo);

    /** 권한 이양 신청자,대상자 정보 */
    AuthTransferApplicationVO applicantDirector(AuthTransferApplicationVO vo);

    /** 권한 이양 수정 */
    int updateAction(HttpServletRequest request);

    /** 이양시킬 권한 정보 */
    List<AuthTransferApplicationVO> sendCurrentlyList(AuthTransferApplicationVO vo);

    String resTypeCdCheck(AuthTransferApplicationVO vo);

    // 신청자 변경전 권한 정보
    List<AuthTransferApplicationVO> mgrAuthBeforeList(AuthTransferApplicationVO vo);

    int mgrAuthBeforeListCount(AuthTransferApplicationVO vo);

    int currentlyListCount(AuthTransferApplicationVO vo);

    List<AuthTransferApplicationVO> targetMgrAuthBeforeList(AuthTransferApplicationVO vo);

    int targetMgrAuthBeforeListCount(AuthTransferApplicationVO vo);

    List<AuthTransferApplicationVO> targetMgrAuthAfterList(AuthTransferApplicationVO vo);

    int targetMgrAuthAfterListCount(AuthTransferApplicationVO vo);

    List<AuthTransferApplicationVO> assignmentMenu(AuthTransferApplicationVO vo);

    AuthTransferApplicationVO assignmentMenuCount(AuthTransferApplicationVO vo);

    /**
     * authTrasferList 설명
     * 
     * @param vo
     * @return
     */
    List<AuthTransferApplicationVO> authTrasferList(AuthTransferApplicationVO vo);

}
