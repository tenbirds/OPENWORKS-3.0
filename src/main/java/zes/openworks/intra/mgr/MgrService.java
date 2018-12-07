package zes.openworks.intra.mgr;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
import zes.openworks.intra.login.LoggingWebLoginVO;

public interface MgrService {

    /**
     * 담당자 정보 목록 조회
     */
    Pager<MgrVO> mgrList(MgrVO vo);

    List<MgrVO> mgrListExcel(MgrVO vo);

    /**
     * 담당자 정보 목록 조회(할당권한 포함)
     */
    Pager<MgrVO> mgrListWithPermission(MgrVO vo);

    /**
     * 담당자 정보 검색 목록 조회
     */
    List<MgrVO> mgrSearchList(MgrVO vo);

    /**
     * 담당자 정보 아이디 중복 체크
     */
    int mgrView(MgrVO vo);

    /**
     * 담당자 정보 상세 조회(String)
     * MgrVO mgrView(String vo);
     */

    /**
     * 담당자 정보 상세 조회(할당권한 포함)
     */
    MgrVO mgrViewWithPermission(MgrVO vo);

    /**
     * 담당자 정보 아이디로 권한코드,권한명,권한타입코드 가져오기
     */
    List<MgrVO> currentlyList(MgrVO vo);

    /**
     * 담당자 정보 등록 액션
     */
    Object insertAction(MgrVO vo);

    /**
     * 비밀번호 수정
     */
    int updatePwdAction(MgrVO vo);

    /**
     * 담당자 정보 수정 액션
     */
    int updateAction(MgrVO vo);

    /**
     * 담당자 권한정보 입력 액션
     */
    int assignInsertAction(MgrVO vo);

    /**
     * 담당자 권한 코드 일괄입력
     */
    int assignInsertListAction(HttpServletRequest request);

    /**
     * 담당자 권한정보 확인
     */
    List<MgrVO> authList(MgrVO vo);

    /**
     * 담당자 권한정보 삭제 액션
     */
    int assignUpdateAction(MgrVO vo);

    /**
     * 담당자 정보 삭제(리스트) 액션
     */
    int deleteListAction(HttpServletRequest request);

    /**
     * 담당자 부서정보 수정 액션
     */
    int deptUpdateAction(MgrVO vo);

    /**
     * 담당자 사용 여부 수정 액션
     */
    int useYnUpdateAction(MgrVO vo);

    /**
     * 담당자 부서이동 수정 액션
     */
    int deptTransferAction(HttpServletRequest request);

    /**
     * 담당자 정보 삭제 액션
     */
    int deleteAction(MgrVO vo);

    /**
     * 담당자 할당 권한 코드 조회
     */
    List<MgrVO> menuAssignList(MgrVO vo);

    List<MgrVO> menuList(MgrVO vo);

    int currentlyListCount(MgrVO vo);

    String mgrDeptNm(MgrVO vo);

    /**
     * webLogList 설명
     * 
     * @param vo
     * @return
     */
    Pager<LoggingWebLoginVO> webLogList(MgrVO vo);

    List<LoggingWebLoginVO> getIpState(MgrVO vo);

    LoggingWebLoginVO getWebLogContents(MgrVO vo);

    Pager<LoggingMgrVO> changeLogList(MgrVO vo);

    MgrVO getDeptTransferInfo(Map<String, String[]> map);

    /**
     * changeLogExcel 설명
     * 
     * @param vo
     * @return
     */
    List<LoggingMgrVO> changeLogExcel(MgrVO vo);

    /**
     * webLogExcel 설명
     * 
     * @param vo
     * @return
     */
    List<LoggingWebLoginVO> webLogExcel(MgrVO vo);

    /**
     * selectAuthNmByAuthCd 권한 정보 조회
     * 
     * @param vo
     * @return
     */
    MgrVO selectAuthNmByAuthCd(MgrVO vo);

    /**
     * registerExcelEnBloLoad 담당자 일괄 등록 엑셀 로드
     * 
     * @param request
     * @return
     * @throws Exception
     */
    List<MgrVO> registerExcelEnBloLoad(HttpServletRequest request) throws Exception;

    /**
     * insertMrgExcelEnBloc 담당자 일괄 등록
     * 
     * @param vo
     */
    int insertMrgExcelEnBloc(MgrVO vo);
}
