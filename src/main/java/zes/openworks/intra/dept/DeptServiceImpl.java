/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.springframework.stereotype.Service;

import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.base.vo.TreeVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 2.    유상원   부서 관리
 * </pre>
 * @see
 */
@Service("deptService")
public class DeptServiceImpl extends AbstractServiceImpl implements DeptService {

    @Resource
    private DeptDAO dao;

    @Resource
    private FileDAO fileDao;

    @Override
    public List<TreeVO> deptList(DeptVO vo) {
        return dao.deptList(vo);
    }

    @Override
    public List<TreeVO> deptListAll(DeptVO vo) {
        return dao.deptListAll(vo);
    }

    @Override
    public List<DeptVO> deptSearchList(DeptVO vo) {
        return dao.deptSearchList(vo);
    }

    @Override
    public DeptVO deptView(DeptVO vo) {
        return dao.deptView(vo);
    }

    @Override
    public Integer insertAction(DeptVO vo) {
        return dao.insertAction(vo);
    }

    @Override
    public int dupCheckDept(DeptVO vo) {
        return dao.dupCheckDept(vo);
    }

    @Override
    public int updateAction(DeptVO vo) {
        return dao.updateAction(vo);
    }

    @Override
    public int deleteAction(DeptVO vo) {
        return dao.deleteAction(vo);
    }

    @Override
    public List<TreeVO> deptUserTreeList(DeptUserTreeVO dutVo) {
        return dao.deptUserTreeList(dutVo);
    }

    @Override
    public DeptVO deptKey(DeptVO vo) {
        return dao.deptKey(vo);
    }

    @Override
    public List<DeptVO> deptListExcel(DeptVO vo) {
        return dao.deptListExcel(vo);
    }

    @Override
    public List<DeptVO> registerExcelEnBloLoad(HttpServletRequest request) throws Exception {
        List<FileVO> fileList = fileDao.getFiles(fileDao.saveFile(UploadHelper.upload(request, "deptExcelEnBloc")));
        Workbook workbook = null;
        Sheet sheet = null;

        List<DeptVO> deptList = new ArrayList<DeptVO>();

        for(FileVO file : fileList) {
            workbook = Workbook.getWorkbook(new File(GlobalConfig.UPLOAD_ROOT + file.getFileUrl()));
            sheet = workbook.getSheet(0);

            int rowCount = sheet.getRows();
            int colCount = sheet.getColumns();

            log.debug(">> rowCount > " + rowCount);
            log.debug(">> colCount > " + colCount);

            if(rowCount <= 1) {
                return null;
            }
            String content = null;

            // 엑셀데이터를 배열에 저장
            for(int i = 1 ; i < rowCount ; i++) {
                DeptVO deptVo = new DeptVO();
                for(int k = 0 ; k < colCount ; k++) {
                    log.debug("i => " + i + " // k => " + k);
                    Cell cell = sheet.getCell(k, i); // 해당 위치의 셀을 가져옴
                    content = (cell != null) ? cell.getContents() : "";

                    switch(k) {
                        case 0:
                            deptVo.setDeptNm(content);
                            break;
                        case 1:
                            deptVo.setDeptCode(content);
                            deptVo.setDeptCdDupCnt(dao.dupCheckDept(deptVo));
                            break;
                        case 2:
                            deptVo.setTelno(content);
                            break;
                        case 3:
                            deptVo.setFxnum(content);
                            break;
                        case 4:
                            deptVo.setMainDuty(content);
                            break;
                    }
                }
                if(deptVo.getDeptCode() != null) {
                    deptList.add(deptVo);
                }
            }

            try {
                if(workbook != null) {
                    workbook.close();
                }
            } catch (Exception e) {}

            fileDao.removeFile(file.getFileSeq());
        }

        return deptList;
    }

    @Override
    public int insertDeptExcelEnBloc(DeptVO vo) {
        int returnVal = 0;

        String[] deptCd = vo.getDeptCode().split(",");
        String[] deptNm = vo.getDeptNm().split(",");
        int defaultSize = deptCd.length;
        String[] telNum = vo.getTelno().split(",", defaultSize);
        String[] faxNum = vo.getFxnum().split(",", defaultSize);
        String[] mainTask = vo.getMainDuty().split(",", defaultSize);

        for(int i = 0 ; i < deptCd.length ; i++) {
            vo.setDeptCode(deptCd[i]);
            vo.setDeptNm(deptNm[i]);
            vo.setTelno(telNum[i]);
            vo.setFxnum(faxNum[i]);
            vo.setMainDuty(mainTask[i]);
            dao.insertAction(vo);
            returnVal++;
        }

        return returnVal;
    }
}
