/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.auth;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;

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
 *  2012. 6. 28.    박수정   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class MgrListByAuthExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<AuthMgrVO> list = (List<AuthMgrVO>) model.get("_mgrListByAuth");

        HSSFSheet sheet = workbook.createSheet();

        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("번호");
        header.createCell(colIndex++).setCellValue("ID");
        header.createCell(colIndex++).setCellValue("부서명");
        header.createCell(colIndex++).setCellValue("직위");
        header.createCell(colIndex++).setCellValue("담당자명");
        header.createCell(colIndex++).setCellValue("권한그룹");
        header.createCell(colIndex++).setCellValue("사용여부");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(AuthMgrVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(rowIndex - 1);
            row.createCell(colIndex++).setCellValue(vo.getMngrId());
            row.createCell(colIndex++).setCellValue(vo.getDeptNm());
            row.createCell(colIndex++).setCellValue(vo.getGradeNm());
            row.createCell(colIndex++).setCellValue(vo.getMngrNm());
            row.createCell(colIndex++).setCellValue(vo.getAuthListString());
            row.createCell(colIndex++).setCellValue("Y".equals(vo.getUseYn()) ? "사용" : "미사용");
            colIndex = 0;
        }

    }

    @Override
    public String getFileName() {

        return "권한별 담당자 목록";
    }

}
