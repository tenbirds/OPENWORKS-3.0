package zes.openworks.web.dmandExamin;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;

/**
 * 수요조사 DAO 클래스
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
@Repository
@SuppressWarnings("unchecked")
public class DmandExaminDAO extends EgovAbstractMapper{

	@Resource
	private FileDAO fileDao;

    public DmandExaminVO dmandExaminView(DmandExaminVO vo) {
        DmandExaminVO dataVo = (DmandExaminVO) selectByPk("_dmandExaminQuery.selectDmandExaminInfo", vo);
        // 계약서 파일 정보
        if (Validate.isNotEmpty(dataVo) && Validate.isNotEmpty(dataVo.getFileSeq())) {
            dataVo.setDmandExaminFile(fileDao.getFiles(dataVo.getFileSeq()));
            //dataVo.setDmandExaminDetailList(list("_dmandExaminQuery.selectDmandExaminDetailList", vo));
        }
        return dataVo;
    }
    public DmandExaminVO dmandExaminView1(DmandExaminVO vo) {
        DmandExaminVO dataVo = (DmandExaminVO) selectByPk("_dmandExaminQuery.selectDmandExaminInfo", vo);
        // 계약서 파일 정보
        if (Validate.isNotEmpty(dataVo) && Validate.isNotEmpty(dataVo.getFileSeq())) {
            dataVo.setDmandExaminFile(fileDao.getFiles(dataVo.getFileSeq()));
            //dataVo.setDmandExaminDetailList(list("_dmandExaminQuery.selectDmandExaminDetailList", vo));
        }
        return dataVo;
    }

	public int dmandExaminSaveAction(DmandExaminVO vo, int seperator) {
		
		// 첨부파일
		if (seperator == -1) {
			
			vo.setFileSeq(seperator);
			
		} else {
			
			if (vo.getDmandExaminFile().size() > 0) {
				
				vo.setFileSeq(fileDao.saveFile(vo.getDmandExaminFile()));
			}
		}
		return update("_dmandExaminQuery.upsertDmandExaminInfo", vo) ;
	}
	
	public int fileDelete(FileVO fileVO) {
		int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
		return affected;
	}
	
	public List<DmandExaminVO> dmandExaminDetailList(String userId) {
		return list("_dmandExaminQuery.selectDmandExaminDetailList", userId);
	}
	
	public void insertDmandExaminDetail(DmandExaminVO vo) {
		insert("_dmandExaminQuery.insertDmandExaminDetail", vo) ;
	}

	public Integer deleteDmandExaminDetail(String userId) {
		return delete("_dmandExaminQuery.deleteDmandExaminDetail", userId) ;
	}
	
	public List<DmandExaminVO> selectDmandExaminEAList(String userId){
	    return list("_dmandExaminQuery.selectDmandExaminEAList",userId);
	}
	
	public int selectDmandExaminInfoCnt(DmandExaminVO vo){
	    int cnt = (Integer) selectByPk("_dmandExaminQuery.selectDmandExaminInfoCnt", vo);
	    return cnt;
	}
	
	public void insertDmandExaminInfo(DmandExaminVO vo){
	    insert("_dmandExaminQuery.insertDmandExaminInfo", vo);
	}
	
    public List<DmandExaminVO> selectDmandExaminDetail(String userId){
        return list("_dmandExaminQuery.selectDmandExaminDetail", userId);
    }
    public List<DmandExaminVO> selectDmandExaminDetail1(String userId){
        return list("_dmandExaminQuery.selectDmandExaminDetail1", userId);
    }
    public List<DmandExaminVO> selectDmandExaminDetail2(String userId){
        return list("_dmandExaminQuery.selectDmandExaminDetail2", userId);
    }
    public List<DmandExaminVO> selectDmandExaminDetail3(String userId){
        return list("_dmandExaminQuery.selectDmandExaminDetail3", userId);
    }

	
	public void insertIntoDmandExaminDetail(DmandExaminVO vo){
	    insert("_dmandExaminQuery.insertIntoDmandExaminDetail", vo);
	}
	
	public void insertGridDmandExaminDetail(DmandExaminVO vo){
	    insert("_dmandExaminQuery.insertGridDmandExaminDetail",vo);
	}
	
	public DmandExaminVO selectDmandExaminUserInfo(String userId){
	    DmandExaminVO userInfo =  (DmandExaminVO) selectByPk("_dmandExaminQuery.selectDmandExaminUserInfo", userId);
	    return userInfo;
	}
	
	public void updateDmandExaminUserInfo(String userId){
	    update("_dmandExaminQuery.updateDmandExaminUserInfo", userId);
	}
	
	public void updateDmandExaminUserInfoSubmit(String userId){
	    update("_dmandExaminQuery.updateDmandExaminUserInfoSubmit", userId);
	}
	
    public int selectTargetInstChkCnt(DmandExaminVO vo){
        return (Integer) selectByPk("_dmandExaminQuery.selectTargetInstChkCnt", vo);
    }
    public int selectTargetSubmitChkCnt(DmandExaminVO vo){
        return (Integer) selectByPk("_dmandExaminQuery.selectTargetSubmitChkCnt", vo);
    }

	public int selectUserTargetCnt(DmandExaminVO vo){
	    return (Integer) selectByPk("_dmandExaminQuery.selectUserTargetCnt", vo);
	}
	
    public int selectTmprChk(DmandExaminVO vo){
        return (Integer) selectByPk("_dmandExaminQuery.selectTmprChk",  vo);
    }
    public String selectLDapCodeNm(DmandExaminVO vo){
        return (String) selectByPk("_dmandExaminQuery.selectLDapCodeNm",  vo);
    }
    public String selectDmandSurveyVldtySecretAtGubun(DmandExaminVO vo){
        return (String) selectByPk("_dmandExaminQuery.selectDmandSurveyVldtySecretAtGubun",  vo);
    }

    public int selectHiddenStateNm(DmandExaminVO vo){
        return (Integer) selectByPk("_dmandExaminQuery.selectHiddenStateNm",  vo);
    }
}
