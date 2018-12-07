package zes.openworks.intra.mgr;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.login.LoggingWebLoginVO;
import zes.openworks.intra.login.LoginVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("mgrService")
public class MgrServiceImpl extends AbstractServiceImpl implements MgrService {

    @Resource
    private MgrDAO dao;

    @Resource
    private FileDAO fileDao;

    // public List<MgrVO> mgrList(MgrVO vo) {
    // return dao.mgrList(vo);
    // }
    @Override
    public Pager<MgrVO> mgrList(MgrVO vo) {
        return dao.mgrList(vo);
    }

    @Override
    public List<MgrVO> mgrListExcel(MgrVO vo) {
        return dao.mgrListExcel(vo);
    }

    // public List<MgrVO> mgrListWithPermission(MgrVO vo) {
    // return dao.mgrListWithPermission(vo);
    // }

    @Override
    public Pager<MgrVO> mgrListWithPermission(MgrVO vo) {
        return dao.mgrListWithPermission(vo);
    }

    @Override
    public List<MgrVO> mgrSearchList(MgrVO vo) {
        return dao.mgrSearchList(vo);
    }

    @Override
    public int mgrView(MgrVO vo) {
        return dao.mgrView(vo);
    }

    @Override
    public MgrVO mgrViewWithPermission(MgrVO vo) {
        return dao.mgrViewWithPermission(vo);
    }

    @Override
    public List<MgrVO> currentlyList(MgrVO vo) {
        return dao.currentlyList(vo);
    }

    @Override
    public List<MgrVO> authList(MgrVO vo) {
        return dao.authList(vo);
    }

    @Override
    public Object insertAction(MgrVO vo) {
        return dao.insertAction(vo);
    }

    @Override
    public int updatePwdAction(MgrVO vo) {
        return dao.updatePwdAction(vo);
    }

    @Override
    public int updateAction(MgrVO vo) {
        return dao.updateAction(vo);
    }

    @Override
    public int assignInsertAction(MgrVO vo) {
        String[] authCds = vo.getAuthCds().split(",");

        for(int i = 0 ; i < authCds.length ; i++) {
            String authCd = authCds[i];
            vo.setAuthCode(authCd);

            dao.assignInsertAction(vo);
        }

        return 0;
    }

    @Override
    public int assignInsertListAction(HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        MgrVO vo = new MgrVO();
        vo.setRegId(loginVO.getMngrId());

        String mgrId = request.getParameter("mgrId");
        String[] authCds = request.getParameter("authCds").split(",");
        String[] mgrIds = request.getParameter("mgrIds").split(",");

        if(request.getParameter("mgrIds").length() > 0) {
            for(int j = 0 ; j < mgrIds.length ; j++) {
                mgrId = mgrIds[j];
                vo.setMngrId(mgrId);

                dao.assignDeleteAction(vo);

                if(request.getParameter("authCds").length() > 0) {
                    for(int i = 0 ; i < authCds.length ; i++) {
                        String authCd = authCds[i];
                        vo.setAuthCode(authCd);

                        dao.assignInsertAction(vo);
                    }
                }
            }
        }

        return mgrIds.length;
    }

    @Override
    public int assignUpdateAction(MgrVO vo) {
        String[] authCds = vo.getAuthCds().split(",");
        dao.assignDeleteAction(vo);

        for(int i = 0 ; i < authCds.length ; i++) {
            String authCd = authCds[i];
            vo.setAuthCode(authCd);
            if(authCd != null && !"".equals(authCd)) {
                dao.assignInsertAction(vo);
            }
        }

        return 0;
    }

    @Override
    public int deleteListAction(HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);

        String[] mgrIds = request.getParameter("mgrIds").split(",");

        MgrVO vo = new MgrVO();
        vo.setModiId(loginVO.getMngrId());
        for(int i = 0 ; i < mgrIds.length ; i++) {
            vo.setMngrId(mgrIds[i]);
            dao.deleteAction(vo);
        }

        return mgrIds.length;
    }

    @Override
    public int deptTransferAction(HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);

        String[] mgrIds = request.getParameter("mgrIds").split(",");
        String deptCd = request.getParameter("deptCode");

        MgrVO vo = new MgrVO();
        vo.setDeptCode(deptCd);
        vo.setModiId(loginVO.getMngrId());

        int cnt = 0;
        if(request.getParameter("mgrIds").length() > 0) {
            for(int i = 0 ; i < mgrIds.length ; i++) {
                vo.setMngrId(mgrIds[i]);

                dao.assignDeleteAction(vo);
                dao.deptTransferAction(vo);
                cnt++;
            }
        }

        return cnt;
    }

    @Override
    public int deptUpdateAction(MgrVO vo) {
        return dao.deptUpdateAction(vo);
    }

    @Override
    public int useYnUpdateAction(MgrVO vo) {
        return dao.useYnUpdateAction(vo);
    }

    @Override
    public int deleteAction(MgrVO vo) {
        // return dao.deptUpdateAction(vo);
        return dao.deleteAction(vo);
    }

    @Override
    public List<MgrVO> menuAssignList(MgrVO vo) {
        return dao.menuAssignList(vo);
    }

    @Override
    public List<MgrVO> menuList(MgrVO vo) {

        return dao.menuList(vo);
    }

    @Override
    public int currentlyListCount(MgrVO vo) {
        return dao.currentlyListCount(vo);
    }

    @Override
    public String mgrDeptNm(MgrVO vo) {

        return dao.mgrDeptNm(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.mgr.MgrService#webLogList(zes.openworks.intra.mgr
     * .MgrVO)
     */
    @Override
    public Pager<LoggingWebLoginVO> webLogList(MgrVO vo) {
        return dao.webLogList(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.mgr.MgrService#getIpState(zes.openworks.intra.mgr
     * .MgrVO)
     */
    @Override
    public List<LoggingWebLoginVO> getIpState(MgrVO vo) {
        return dao.getIpState(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.mgr.MgrService#getWebLogContents(zes.openworks.intra
     * .mgr.MgrVO)
     */
    @Override
    public LoggingWebLoginVO getWebLogContents(MgrVO vo) {
        return dao.getWebLogContents(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.mgr.MgrService#changeLogList(zes.openworks.intra.
     * mgr.MgrVO)
     */
    @Override
    public Pager<LoggingMgrVO> changeLogList(MgrVO vo) {
        return dao.changeLogList(vo);
    }

    @Override
    public MgrVO getDeptTransferInfo(Map<String, String[]> map) {
        return dao.getDeptTransferInfo(map);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.mgr.MgrService#changeLogExcel(zes.openworks.intra
     * .mgr.MgrVO)
     */
    @Override
    public List<LoggingMgrVO> changeLogExcel(MgrVO vo) {
        return dao.changeLogExcel(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.mgr.MgrService#webLogExcel(zes.openworks.intra.mgr
     * .MgrVO)
     */
    @Override
    public List<LoggingWebLoginVO> webLogExcel(MgrVO vo) {
        return dao.webLogExcel(vo);
    }

    /**
     * selectAuthNmByAuthCd 권한 정보 조회
     * 
     * @param vo
     * @return
     */
    @Override
    public MgrVO selectAuthNmByAuthCd(MgrVO vo) {
        return dao.selectAuthNmByAuthCd(vo);
    }

    /**
     * insertMrgExcelEnBloc 담당자 일괄 등록
     * 
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public List<MgrVO> registerExcelEnBloLoad(HttpServletRequest request) throws Exception {
        List<FileVO> fileList = fileDao.getFiles(fileDao.saveFile(UploadHelper.upload(request, "mrgExcelEnBloc")));
        Workbook workbook = null;
        Sheet sheet = null;

        List<MgrVO> mgrList = new ArrayList<MgrVO>();

        for(FileVO file : fileList) {
            log.debug(">> GlobalConfig.WEBAPP_ROOT >> " + GlobalConfig.UPLOAD_ROOT);
            log.debug(">> file.getFileUrl() >> " + file.getFileUrl());

            workbook = Workbook.getWorkbook(new File(GlobalConfig.UPLOAD_ROOT + file.getFileUrl()));
            sheet = workbook.getSheet(0);

            int rowCount = sheet.getRows();
            int colCount = sheet.getColumns();

            if(rowCount <= 1) {
                return null;
            }
            String content = null;

            // 엑셀데이터를 배열에 저장
            for(int i = 1 ; i < rowCount ; i++) {
                MgrVO mgrVo = new MgrVO();
                for(int k = 0 ; k < colCount ; k++) {
                    Cell cell = sheet.getCell(k, i); // 해당 위치의 셀을 가져옴
                    content = (cell != null) ? cell.getContents() : "";

                    switch(k) {
                        case 0:
                            mgrVo.setMngrId(content);
                            break;
                        case 1:
                            mgrVo.setMngrNm(content);
                            break;
                        case 2:
                            try {
                                mgrVo.setLangCode("00");
                                mgrVo.setOfcpsCd(Integer.valueOf(content));
                                mgrVo.setGradeNm(dao.selectGradeNm(mgrVo));
                            } catch (Exception e) {                                
                                mgrVo.setOfcpsCd(-1);
                            }
                            break;
                        case 3:
                            mgrVo.setDeptCode(content);
                            mgrVo.setDeptNm(dao.selectDeptNm(mgrVo.getDeptCode()));
                            // if(mgrVo.getDeptNm() == null)
                            // mgrVo.setDeptCd("잘못된 값!");
                            break;
                        case 4:
                            mgrVo.setMngrPassword(content);
                            break;
                        case 5:
                            mgrVo.setTelno(content);
                            break;
                        case 6:
                            mgrVo.setFxnum(content);
                            break;
                        case 7:
                            mgrVo.setMbtlnum(content);
                            break;
                        case 8:
                            mgrVo.setEmail(content);
                            break;
                        case 9:
                            mgrVo.setChrgJob(content);
                            break;
                        case 10:
                            mgrVo.setUseYn(content);
                            break;
                    }
                }
                if(mgrVo.getMngrId() != null) {
                    mgrList.add(mgrVo);
                }
            }

            try {
                if(workbook != null) {
                    workbook.close();
                }
            } catch (Exception e) {}

            fileDao.removeFile(file.getFileSeq());
        }

        return mgrList;
    }

    /**
     * insertMrgExcelEnBloc 담당자 일괄 등록
     * 
     * @param vo
     */
    @Override
    public int insertMrgExcelEnBloc(MgrVO vo) {
        int returnVal = 0;

        String[] mgrId = vo.getMngrId().split(",");
        String[] mgrNm = vo.getMngrNm().split(",");
        String[] gradeCd = vo.getOfcpsCds().split(",");
        String[] deptCd = vo.getDeptCode().split(",");
        String[] mgrPwd = vo.getMngrPassword().split(",");
        int defaultSize = mgrId.length;
        String[] telNum = vo.getTelno().split(",", defaultSize);
        String[] faxNum = vo.getFxnum().split(",", defaultSize);
        String[] mobile = vo.getMbtlnum().split(",", defaultSize);
        String[] email = vo.getEmail().split(",", defaultSize);
        String[] roleNm = vo.getChrgJob().split(",", defaultSize);

        for(int i = 0 ; i < mgrId.length ; i++) {
            vo.setMngrId(mgrId[i]);
            vo.setMngrNm(mgrNm[i]);
            vo.setOfcpsCd(Integer.valueOf(gradeCd[i]));
            vo.setDeptCode(deptCd[i]);
            vo.setMngrPassword(mgrPwd[i]);
            vo.setTelno(telNum[i]);
            vo.setFxnum(faxNum[i]);
            vo.setMbtlnum(mobile[i]);
            vo.setEmail(email[i]);
            vo.setChrgJob(roleNm[i]);


                dao.insertAction(vo);
                returnVal++;

        }

        return returnVal;
    }

}
