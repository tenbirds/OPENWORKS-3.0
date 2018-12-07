package zes.openworks.intra.bassAgremManage;

import java.util.List;
import java.util.Map;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.user.UserVO;


/**
*
*<pre>
*<< 개정이력(Modification Information) >>
*
*  기본협약관리>기본협약관리
*
* 수정일          수정자    수정내용
*--------------  --------  -------------------------------
* 2016. 10. 26.   엔키      신규
*</pre>
* @see
*/

public interface BassAgremManageService {

    /**
     * bassAgremManageList (기본협약관리목록)
     * @param vo
     * @return
     */
    Pager<BassAgremManageVO> bassAgremManageList(BassAgremManageVO vo);

    /**
     * bassAgremManageListExcel (기본협약관리목록 엑셀 다운로드)
     * @param vo
     * @return
     */
    List<BassAgremManageVO> bassAgremManageListExcel(BassAgremManageVO vo);

    /**
     * bassAgremManageInsertAction (기본협약관리 등록)
     * @param vo
     * @return
     */
    int bassAgremManageInsertAction(BassAgremManageVO vo);

    /**
     * bassAgremManageView (기본협약관리 상세)
     * @param vo
     * @return
     */
    BassAgremManageVO bassAgremManageView(BassAgremManageVO vo);

    /**
     * bassAgremManageUpdateAction (기본협약관리 수정)
     * @param vo
     * @return
     */
    int bassAgremManageUpdateAction(BassAgremManageVO vo);
    /**
     * opUserUpdateAction (회원 협약상태 수정)
     * @param vo
     * @return
     */
    int opUserUpdateAction(BassAgremManageVO vo);
    /**
     * tumSvcStorIUpdateAction (회원 협약상태 수정)
     * @param vo
     * @return
     */
    int tumSvcStorIUpdateAction(BassAgremManageVO vo);

    /**
     * fileDelete (파일 삭제)
     * @param fileVO
     * @return
     */
    int fileDelete(FileVO fileVO);

    /**
     * bassAgremManageDeleteAction (기본협약관리 삭제)
     * @param vo
     * @return
     */
    int bassAgremManageDeleteAction(BassAgremManageVO vo);

    /**
     * sellerListPop (담당자 목록(팝업))
     * @param vo
     * @return
     */
    Pager<UserVO> sellerListPop(BassAgremManageVO vo);

    /**
     * bassAgremClosUserList (협약 종료 사용자 목록 조회) - WAS 시간(날짜) 기준으로 조회 하도록 수정(2017.04.27)
     * @param paramMap
     * @return
     */
//    List<BassAgremManageVO> bassAgremClosUserList(BassAgremManageVO vo);
    List<BassAgremManageVO> bassAgremClosUserList(Map paramMap);

    /**
     * opUserBassAgremClosAction (협약 종료에 따른 사용자 전환(공급자->수요자)(OP_USER 테이블 Update))
     * @param vo
     * @return
     */
    int opUserBassAgremClosAction(BassAgremManageVO vo);

    /**
     * tumSvcStorBassAgremClosAction (협약 종료에 따른 사용자 전환(공급자->수요자)(TUM_SVC_STOR_I 테이블 Update))
     * @param vo
     * @return
     */
    int tumSvcStorBassAgremClosAction(BassAgremManageVO vo);

    /**
     * tstGoodInfoBassAgremClosAction (협약 종료에 따른 해당 사용자의 상품을 비전시로 전환)
     * @param vo
     * @return
     */
    int tstGoodInfoBassAgremClosAction(BassAgremManageVO vo);

    /**
     * bassAgremManageClosAction (해당 사용자의 협약정보의 협약상태 변경[승인(1004) -> 협약종료(1005)])
     * @param vo
     * @return
     */
    int bassAgremManageClosAction(BassAgremManageVO vo);

    /**
     * summaryBassAgrem 설명
     * @param vo
     * @return
     */
    BassAgremSummaryVO summaryBassAgrem(BassAgremManageVO vo);

    /**
     * updateUser 설명
     * @param request
     * @return
     */
    int updateUser(BassAgremManageVO vo);
}