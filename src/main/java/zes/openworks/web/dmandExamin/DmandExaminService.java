package zes.openworks.web.dmandExamin;

import java.util.List;
import java.util.Map;

import zes.base.vo.FileVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;

/**
 * 수요조사
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)엔키소프트 양교훈
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일               수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2016. 10. 5.     양교훈     신규
 * </pre>
 * @see
 */
public interface DmandExaminService {

	DmandExaminVO dmandExaminView(DmandExaminVO dmandExaminVO);

    DmandExaminVO dmandExaminView1(DmandExaminVO dmandExaminVO);
	
	int dmandExaminSaveAction(DmandExaminVO dmandExaminVO, int seperator);

	int fileDelete(FileVO fileVO);

	List<DmandExaminVO> dmandExaminDetailList(String userId);

	void insertDmandExaminDetail(DmandExaminVO dmandExaminVO);

	Integer deleteDmandExaminDetail(String userId);
	/*EA LIST*/
	List<DmandExaminVO> selectDmandExaminEAList(String userId);
	/*User Info Count*/
	int selectDmandExaminInfoCnt(DmandExaminVO vo);
	/*User Info Insert*/
	void insertDmandExaminInfo(DmandExaminVO vo);
	/*EA to Detail Insert*/
	void insertIntoDmandExaminDetail(DmandExaminVO vo);
	/*Detail LIST*/
    List<DmandExaminVO> selectDmandExaminDetail(String userId);
    List<DmandExaminVO> selectDmandExaminDetail1(String userId);
    List<DmandExaminVO> selectDmandExaminDetail2(String userId);    
    List<DmandExaminVO> selectDmandExaminDetail3(String userId);    

	/*Excel,Grid to Detail DB*/
	void insertGridDmandExaminDetail(DmandExaminVO vo);
	/*select Info User*/
	DmandExaminVO selectDmandExaminUserInfo(String userId);
	/*update Info User*/
	void updateDmandExaminUserInfo(String userId);
	/*update Submit Info User*/
	void updateDmandExaminUserInfoSubmit(String userId);
	
	/*수요조사 대상 기관여부 카운트*/
    int selectTargetInstChkCnt(DmandExaminVO vo);
    int selectTargetSubmitChkCnt(DmandExaminVO vo);

    /*1기관 1담당자 체크 카운트*/
    int selectUserTargetCnt(DmandExaminVO vo);
    /*임시저장 이력 확인(안한 경우 EA데이터 재조회 후 Detail 적재)*/
    int selectTmprChk(DmandExaminVO vo);
    
    String selectLDapCodeNm(DmandExaminVO vo);
    String selectDmandSurveyVldtySecretAtGubun(DmandExaminVO vo);    

    int selectHiddenStateNm(DmandExaminVO vo);
}
