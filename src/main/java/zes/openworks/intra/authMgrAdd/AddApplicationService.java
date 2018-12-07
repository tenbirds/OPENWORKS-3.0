package zes.openworks.intra.authMgrAdd;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

public interface AddApplicationService {

    /** 신청자 리스트 */
    Pager<AddApplicationVO> list(AddApplicationVO vo);

    /** 권한 추가 요청 신청자 정보 */
    AddApplicationVO applicant(AddApplicationVO vo);

    /** 현재 할당 권한 정보 */
    List<AddApplicationVO> currentlyList(AddApplicationVO vo);

    List<AddApplicationVO> currentlyList1(AddApplicationVO vo);

    /** 추가 요청 권한 정보(처리) */
    List<AddApplicationVO> addList2(AddApplicationVO vo);

    /** 추가 요청 권한 정보(반려) */
    List<AddApplicationVO> addList3(AddApplicationVO vo);

    List<AddApplicationVO> authGroupList(AddApplicationVO vo);

    /** 할당 권한 목록 자세히 보기 */
    List<AddApplicationVO> assignmentMenu(AddApplicationVO vo);

    AddApplicationVO assignmentMenuCount(AddApplicationVO vo);

    /** 메뉴별 할당 권한 */
    List<AddApplicationVO> menuAllList(AddApplicationVO vo);

    /** 권한 추가 요청하기 */
    int insert(HttpServletRequest request);

}
