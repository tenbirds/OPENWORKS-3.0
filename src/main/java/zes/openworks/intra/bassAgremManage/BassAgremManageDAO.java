package zes.openworks.intra.bassAgremManage;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
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

@Repository
@SuppressWarnings("unchecked")
public class BassAgremManageDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * bassAgremManageList (기본협약관리 목록)
     * @param vo
     * @return
     */
    public Pager<BassAgremManageVO> bassAgremManageList(BassAgremManageVO vo) {

        List<BassAgremManageVO> dataList = list("_bassAgremManage.bassAgremManageList", vo.getDataMap());
        for(BassAgremManageVO dataVo : dataList){
            
            // 확정협약서파일 정보
            if (Validate.isNotEmpty(dataVo.getLastAgrmntFileSeq())) {
                dataVo.setLastAgrmntFile(fileDao.getFiles(dataVo.getLastAgrmntFileSeq()));
            }
            
            // 기본협약서파일 정보
            if (Validate.isNotEmpty(dataVo.getBassAgrmntFileSeq())) {
                dataVo.setBassAgrmntFile(fileDao.getFiles(dataVo.getBassAgrmntFileSeq()));
            }
            // 등기부등본파일 정보
            if (Validate.isNotEmpty(dataVo.getRgsbukTrnscrFileSeq())) {
                dataVo.setRgsbukTrnscrFile(fileDao.getFiles(dataVo.getRgsbukTrnscrFileSeq()));
            }
            // 벤처기업증명서파일 정보
            if (Validate.isNotEmpty(dataVo.getVnentrCrtfFileSeq())) {
                dataVo.setVnentrCrtfFile(fileDao.getFiles(dataVo.getVnentrCrtfFileSeq()));
            }
            // 직접생산증명서파일 정보
            if (Validate.isNotEmpty(dataVo.getDirectPrdctnCrtfFileSeq())) {
                dataVo.setDirectPrdctnCrtfFile(fileDao.getFiles(dataVo.getDirectPrdctnCrtfFileSeq()));
            }
            // 신용평가서파일 정보
            if (Validate.isNotEmpty(dataVo.getCdltDocFileSeq())) {
                dataVo.setCdltDocFile(fileDao.getFiles(dataVo.getCdltDocFileSeq()));
            }
            // 재무재표파일 정보
            if (Validate.isNotEmpty(dataVo.getFnlttFileSeq())) {
                dataVo.setFnlttFile(fileDao.getFiles(dataVo.getFnlttFileSeq()));
            }
        }
        vo.setTotalNum((Integer) selectByPk("_bassAgremManage.bassAgremManageCount", vo.getDataMap()));
        return new Pager<BassAgremManageVO>(dataList, vo);
    }

    /**
     * bassAgremManageListExcel (기본협약관리 목록 엑셀 다운로드)
     * @param vo
     * @return
     */
    public List<BassAgremManageVO> bassAgremManageListExcel(BassAgremManageVO vo) {
        List<BassAgremManageVO> dataList = list("_bassAgremManage.bassAgremManageListExcel", vo.getDataMap());
        for(BassAgremManageVO dataVo : dataList){
            // 기본협약서파일 정보
            if (Validate.isNotEmpty(dataVo.getBassAgrmntFileSeq())) {
                dataVo.setBassAgrmntFile(fileDao.getFiles(dataVo.getBassAgrmntFileSeq()));
            }
            // 등기부등본파일 정보
            if (Validate.isNotEmpty(dataVo.getRgsbukTrnscrFileSeq())) {
                dataVo.setRgsbukTrnscrFile(fileDao.getFiles(dataVo.getRgsbukTrnscrFileSeq()));
            }
            // 벤처기업증명서파일 정보
            if (Validate.isNotEmpty(dataVo.getVnentrCrtfFileSeq())) {
                dataVo.setVnentrCrtfFile(fileDao.getFiles(dataVo.getVnentrCrtfFileSeq()));
            }
            // 직접생산증명서파일 정보
            if (Validate.isNotEmpty(dataVo.getDirectPrdctnCrtfFileSeq())) {
                dataVo.setDirectPrdctnCrtfFile(fileDao.getFiles(dataVo.getDirectPrdctnCrtfFileSeq()));
            }
            // 신용평가서파일 정보
            if (Validate.isNotEmpty(dataVo.getCdltDocFileSeq())) {
                dataVo.setCdltDocFile(fileDao.getFiles(dataVo.getCdltDocFileSeq()));
            }
            // 재무재표파일 정보
            if (Validate.isNotEmpty(dataVo.getFnlttFileSeq())) {
                dataVo.setFnlttFile(fileDao.getFiles(dataVo.getFnlttFileSeq()));
            }
        }
        return  dataList;
    }

    /**
     * bassAgremManageView (기본협약관리 상세)
     * @param vo
     * @return
     */
    public BassAgremManageVO bassAgremManageView(BassAgremManageVO vo) {
        BassAgremManageVO dataVo = (BassAgremManageVO) selectByPk("_bassAgremManage.bassAgremManageView",vo);
        // 확정협약서파일 정보
        if (Validate.isNotEmpty(dataVo.getLastAgrmntFileSeq())) {
            dataVo.setLastAgrmntFile(fileDao.getFiles(dataVo.getLastAgrmntFileSeq()));
        }
        // 기본협약서파일 정보
        if (Validate.isNotEmpty(dataVo.getBassAgrmntFileSeq())) {
            dataVo.setBassAgrmntFile(fileDao.getFiles(dataVo.getBassAgrmntFileSeq()));
        }
        // 등기부등본파일 정보
        if (Validate.isNotEmpty(dataVo.getRgsbukTrnscrFileSeq())) {
            dataVo.setRgsbukTrnscrFile(fileDao.getFiles(dataVo.getRgsbukTrnscrFileSeq()));
        }
        // 벤처기업증명서파일 정보
        if (Validate.isNotEmpty(dataVo.getVnentrCrtfFileSeq())) {
            dataVo.setVnentrCrtfFile(fileDao.getFiles(dataVo.getVnentrCrtfFileSeq()));
        }
        // 직접생산증명서파일 정보
        if (Validate.isNotEmpty(dataVo.getDirectPrdctnCrtfFileSeq())) {
            dataVo.setDirectPrdctnCrtfFile(fileDao.getFiles(dataVo.getDirectPrdctnCrtfFileSeq()));
        }
        // 신용평가서파일 정보
        if (Validate.isNotEmpty(dataVo.getCdltDocFileSeq())) {
            dataVo.setCdltDocFile(fileDao.getFiles(dataVo.getCdltDocFileSeq()));
        }
        // 재무재표파일 정보
        if (Validate.isNotEmpty(dataVo.getFnlttFileSeq())) {
            dataVo.setFnlttFile(fileDao.getFiles(dataVo.getFnlttFileSeq()));
        }
        return dataVo;
    }

    /**
     * bassAgremManageInsertAction (기본협약관리 등록)
     * @param vo
     * @return
     */
    public int bassAgremManageInsertAction(BassAgremManageVO vo) {

        // 기본협약서파일
        if(vo.getBassAgrmntFile().size() > 0) {
            vo.setBassAgrmntFileSeq(fileDao.saveFile(vo.getBassAgrmntFile(), vo.getBassAgrmntFileSeq()));
        } else {
            vo.setBassAgrmntFileSeq(-1);
        }
        // 등기부등본파일
        if(vo.getRgsbukTrnscrFile().size() > 0) {
            vo.setRgsbukTrnscrFileSeq(fileDao.saveFile(vo.getRgsbukTrnscrFile(), vo.getRgsbukTrnscrFileSeq()));
        } else {
            vo.setRgsbukTrnscrFileSeq(-1);
        }
        // 벤처기업증명서파일
        if(vo.getVnentrCrtfFile().size() > 0) {
            vo.setVnentrCrtfFileSeq(fileDao.saveFile(vo.getVnentrCrtfFile(), vo.getVnentrCrtfFileSeq()));
        } else {
            vo.setVnentrCrtfFileSeq(-1);
        }
        // 직접생산증명서파일
        if(vo.getDirectPrdctnCrtfFile().size() > 0) {
            vo.setDirectPrdctnCrtfFileSeq(fileDao.saveFile(vo.getDirectPrdctnCrtfFile(), vo.getDirectPrdctnCrtfFileSeq()));
        } else {
            vo.setDirectPrdctnCrtfFileSeq(-1);
        }
        // 신용평가서파일
        if(vo.getCdltDocFile().size() > 0) {
            vo.setCdltDocFileSeq(fileDao.saveFile(vo.getCdltDocFile(), vo.getCdltDocFileSeq()));
        } else {
            vo.setCdltDocFileSeq(-1);
        }
        // 재무재표파일
        if(vo.getFnlttFile().size() > 0) {
            vo.setFnlttFileSeq(fileDao.saveFile(vo.getFnlttFile(), vo.getFnlttFileSeq()));
        } else {
            vo.setFnlttFileSeq(-1);
        }
        return insert("_bassAgremManage.bassAgremManageInsertAction", vo) ;
    }

    /**
     * bassAgremManageUpdateAction (기본협약관리 수정)
     * @param vo
     * @return
     */
    public int bassAgremManageUpdateAction(BassAgremManageVO vo) {
        if(vo.getAgremStat() == 1004){
            
            if(vo.getLastAgrmntFileSeq()  < 1){
                // 확정협약서파일
                if(vo.getLastAgrmntFile().size() > 0) {
                    vo.setLastAgrmntFileSeq(fileDao.saveFile(vo.getLastAgrmntFile(), vo.getLastAgrmntFileSeq()));
                } else {
                    vo.setLastAgrmntFileSeq(-1);
                }
            }
            
        }
        return update("_bassAgremManage.bassAgremManageUpdateAction", vo) ;
    }
    
    
    
    /**
     * opUserUpdateAction 설명
     */
    public int opUserUpdateAction(BassAgremManageVO vo) {
        return update("_bassAgremManage.opUserUpdateAction", vo);
    }
    
    /**
     * tumSvcStorIUpdateAction 설명
     */
    public int tumSvcStorIUpdateAction(BassAgremManageVO vo) {        
        return update("_bassAgremManage.tumSvcStorIUpdateAction", vo);
    }

    /**
     * bassAgremManageDeleteAction (기본협약관리 삭제)
     * @param vo
     * @return
     */
    public int bassAgremManageDeleteAction(BassAgremManageVO vo) {
        int affected = 0;
        if(Validate.isNotEmpty(vo.getBassAgremManageSeqs())){

            for(String bassAgremManageSeqs : vo.getBassAgremManageSeqs()) {
                BassAgremManageVO dataVO  = new BassAgremManageVO();
                dataVO.setBassAgremManageSeq(Integer.valueOf(bassAgremManageSeqs));
                affected += update("_bassAgremManage.bassAgremManageDeleteAction", dataVO);

            }
        }

        return affected;
    }


    /**
     * fileDelete (파일 삭제)
     * @param fileVO
     * @return
     */
    public int fileDelete(FileVO fileVO) {
        int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
        return affected;
    }

    /**
     * 판매자 목록(팝업)
     */
    public Pager<UserVO> sellerListPop(BassAgremManageVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        List<UserVO> dataList = list("_bassAgremManage.sellerList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_bassAgremManage.sellerListCount", parameterMap));

        return new Pager<UserVO>(dataList, vo);
    }

    /**
     * bassAgremClosUserList (협약 종료 사용자 목록 조회) - WAS 시간(날짜) 기준으로 조회 하도록 수정(2017.04.27)
     * @param paramMap
     * @return
     */
//    public List<BassAgremManageVO> bassAgremClosUserList(BassAgremManageVO vo) {
//        List<BassAgremManageVO> dataList = list("_bassAgremManage.bassAgremClosUserList", vo.getDataMap());
//        return  dataList;
//    }
    public List<BassAgremManageVO> bassAgremClosUserList(Map paramMap) {
        List<BassAgremManageVO> dataList = list("_bassAgremManage.bassAgremClosUserList", paramMap);
        return  dataList;
    }

    /**
     * opUserBassAgremClosAction (협약 종료에 따른 사용자 전환(공급자->수요자)(OP_USER 테이블 Update))
     * @param vo
     * @return
     */
    public int opUserBassAgremClosAction(BassAgremManageVO vo) {        
        return update("_bassAgremManage.opUserBassAgremClosAction", vo);
    }

    /**
     * tumSvcStorBassAgremClosAction (협약 종료에 따른 사용자 전환(공급자->수요자)(TUM_SVC_STOR_I 테이블 Update))
     * @param vo
     * @return
     */
    public int tumSvcStorBassAgremClosAction(BassAgremManageVO vo) {        
        return update("_bassAgremManage.tumSvcStorBassAgremClosAction", vo);
    }

    /**
     * tstGoodInfoBassAgremClosAction (협약 종료에 따른 해당 사용자의 상품을 비전시로 전환)
     * @param vo
     * @return
     */
    public int tstGoodInfoBassAgremClosAction(BassAgremManageVO vo) {        
        return update("_bassAgremManage.tstGoodInfoBassAgremClosAction", vo);
    }
    
    /**
     * bassAgremManageClosAction (해당 사용자의 협약정보의 협약상태 변경[승인(1004) -> 협약종료(1005)])
     * @param vo
     * @return
     */
    public int bassAgremManageClosAction(BassAgremManageVO vo) {        
        return update("_bassAgremManage.bassAgremManageClosAction", vo);
    }

    /**
     * summaryBassAgrem 설명
     * @param vo
     * @return
     */
    public BassAgremSummaryVO summaryBassAgrem(BassAgremManageVO vo) {
        BassAgremSummaryVO bassAgremSummaryVO = (BassAgremSummaryVO) selectByPk("_bassAgremManage.bassAgremManageSummaryList", vo.getDataMap());
        return bassAgremSummaryVO; 
    }

    /**
     * updateUser 설명
     * @param request
     * @return
     */
    public int updateUser(BassAgremManageVO vo) {
        return update("_bassAgremManage.bassAgremManageUpdateUserAction", vo);
    }

}