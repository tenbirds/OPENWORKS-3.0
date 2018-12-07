package zes.openworks.intra.authMgrAdd;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

public interface AdditionalService {

    /** 권한 추가 요청 관리 목록 */
    Pager<AdditionalVO> list(AdditionalVO vo);

    /** 권한 추가 요청 신청자 정보 */
    AdditionalVO applicant(AdditionalVO vo);

    /**
     * 반려시 업데이트
     * 
     * @param vo
     */
    int retrocession(AdditionalVO vo);

    int retrocession2(AdditionalVO vo);

    /**
     * 승인 업데이트
     * 
     * @param vo
     * @return
     */
    int approve(AdditionalVO vo);

    /** 현재 할당 권한 정보 */
    List<AdditionalVO> currentlyList(AdditionalVO vo);

    /** 할당 권한 메뉴 */
    List<AdditionalVO> assignmentMenu(AdditionalVO vo);

    List<AdditionalVO> assignmentMenu2(AdditionalVO vo);

    AdditionalVO assignmentMenuCount(AdditionalVO vo);

    AdditionalVO assignmentMenuCount2(AdditionalVO vo);

    /** 추가 요청 권한 정보 */
    List<AdditionalVO> addList(AdditionalVO vo);

    List<AdditionalVO> addList2(AdditionalVO vo);

    List<AdditionalVO> addList3(AdditionalVO vo);

    List<AdditionalVO> authCds(AdditionalVO vo);

    int approve2(AdditionalVO vo);

    int approve3(HttpServletRequest request);

    /***/
    List<AdditionalVO> getMenuCd(AdditionalVO vo);

    /** 권한 요청 권한 미처리 카운트 */
    AdditionalVO listCount2(AdditionalVO vo);

    AdditionalVO listCount3(AdditionalVO vo);
}
