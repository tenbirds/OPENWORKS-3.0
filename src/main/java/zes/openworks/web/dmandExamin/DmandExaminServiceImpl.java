package zes.openworks.web.dmandExamin;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.vo.FileVO;

/**
 * 수요조사 ServiceImple 클래스
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
@Service("dmandExaminService")
public class DmandExaminServiceImpl extends AbstractServiceImpl implements DmandExaminService {

	@Resource DmandExaminDAO dao;

    @Override
    public DmandExaminVO dmandExaminView(DmandExaminVO vo) {
        return dao.dmandExaminView(vo);
    }
    @Override
    public DmandExaminVO dmandExaminView1(DmandExaminVO vo) {
        return dao.dmandExaminView1(vo);
    }
	
	@Override
	public int dmandExaminSaveAction(DmandExaminVO vo, int seperator) {
		return dao.dmandExaminSaveAction(vo, seperator);
	}

	@Override
	public int fileDelete(FileVO fileVO) {
		return dao.fileDelete(fileVO);
	}

	@Override
	public List<DmandExaminVO> dmandExaminDetailList(String userId) {
		return dao.dmandExaminDetailList(userId);
	}

	@Override
	public void insertDmandExaminDetail(DmandExaminVO vo) {
		dao.insertDmandExaminDetail(vo);
	}

	@Override
	public Integer deleteDmandExaminDetail(String userId) {
		return dao.deleteDmandExaminDetail(userId);
	}

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#dmandExaminEAList(java.lang.String)
     */
    @Override
    public List<DmandExaminVO> selectDmandExaminEAList(String userId) {
        return dao.selectDmandExaminEAList(userId);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#selectDmandExaminInfoCnt(zes.openworks.web.dmandExamin.DmandExaminVO)
     */
    @Override
    public int selectDmandExaminInfoCnt(DmandExaminVO vo) {
        return dao.selectDmandExaminInfoCnt(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#insertDmandExaminInfo(zes.openworks.web.dmandExamin.DmandExaminVO)
     */
    @Override
    public void insertDmandExaminInfo(DmandExaminVO vo) {
        dao.insertDmandExaminInfo(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#selectDmandExaminDetailList(java.lang.String)
     */
    @Override
    public List<DmandExaminVO> selectDmandExaminDetail(String userId) {
        // TODO Auto-generated method stub
        return dao.selectDmandExaminDetail(userId);
    }
    @Override
    public List<DmandExaminVO> selectDmandExaminDetail1(String userId) {
        // TODO Auto-generated method stub
        return dao.selectDmandExaminDetail1(userId);
    }
    @Override
    public List<DmandExaminVO> selectDmandExaminDetail2(String userId) {
        // TODO Auto-generated method stub
        return dao.selectDmandExaminDetail2(userId);
    }
    @Override
    public List<DmandExaminVO> selectDmandExaminDetail3(String userId) {
        // TODO Auto-generated method stub
        return dao.selectDmandExaminDetail3(userId);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#insertIntoDmandExaminDetail(zes.openworks.web.dmandExamin.DmandExaminVO)
     */
    @Override
    public void insertIntoDmandExaminDetail(DmandExaminVO vo) {
        dao.insertIntoDmandExaminDetail(vo);
        
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#insertExcelDmandExaminDetail(zes.openworks.web.dmandExamin.DmandExaminVO)
     */
    @Override
    public void insertGridDmandExaminDetail(DmandExaminVO vo) {
        dao.insertGridDmandExaminDetail(vo);
        
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#selectDmandExaminUserInfo(java.lang.String)
     */
    @Override
    public DmandExaminVO selectDmandExaminUserInfo(String userId) {
        return dao.selectDmandExaminUserInfo(userId);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#updateDmandExaminUserInfo(java.lang.String)
     */
    @Override
    public void updateDmandExaminUserInfo(String userId) {
        dao.updateDmandExaminUserInfo(userId);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#updateDmandExaminUserInfoSubmit(java.lang.String)
     */
    @Override
    public void updateDmandExaminUserInfoSubmit(String userId) {
        dao.updateDmandExaminUserInfoSubmit(userId);
        
    }

    /* 수요조사 대상 기관여부 카운트
     * @see zes.openworks.web.dmandExamin.DmandExaminService#selectTargetInstChkCnt(DmandExaminVO vo)
     */
    @Override
    public int selectTargetInstChkCnt(DmandExaminVO vo) {
        return dao.selectTargetInstChkCnt(vo);
    }
    @Override
    public int selectTargetSubmitChkCnt(DmandExaminVO vo) {
        return dao.selectTargetSubmitChkCnt(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#selectUserTargetCnt(zes.openworks.web.dmandExamin.DmandExaminVO)
     */
    @Override
    public int selectUserTargetCnt(DmandExaminVO vo) {
        // TODO Auto-generated method stub
        return dao.selectUserTargetCnt(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.dmandExamin.DmandExaminService#selectTmprChk(zes.openworks.web.dmandExamin.DmandExaminVO)
     */
    @Override
    public int selectTmprChk(DmandExaminVO vo) {
        // TODO Auto-generated method stub
        return dao.selectTmprChk(vo);
    }

    @Override
    public String selectLDapCodeNm(DmandExaminVO vo) {
        return dao.selectLDapCodeNm(vo);
    }
    @Override
    public String selectDmandSurveyVldtySecretAtGubun(DmandExaminVO vo) {
        return dao.selectDmandSurveyVldtySecretAtGubun(vo);
    }

    @Override
    public int selectHiddenStateNm(DmandExaminVO vo) {
        return dao.selectHiddenStateNm(vo);
    }
 
    
    
}
