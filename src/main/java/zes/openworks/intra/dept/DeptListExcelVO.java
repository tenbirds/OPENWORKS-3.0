/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

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
 *  2012. 6. 4.    유상원   회원 관리
 * </pre>
 * @see
 */
public class DeptListExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<DeptVO> list = (List<DeptVO>) model.get("_deptList");

        HSSFSheet sheet = workbook.createSheet();

        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("상위부서명");
        header.createCell(colIndex++).setCellValue("부서명");
        header.createCell(colIndex++).setCellValue("부서코드");
        header.createCell(colIndex++).setCellValue("부서전화번호");
        header.createCell(colIndex++).setCellValue("부서팩스번호");
        header.createCell(colIndex++).setCellValue("주요업무");
        header.createCell(colIndex++).setCellValue("사용여부");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(DeptVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getUpdtDt());
            row.createCell(colIndex++).setCellValue(vo.getDeptNm());
            row.createCell(colIndex++).setCellValue(vo.getDeptCode());
            row.createCell(colIndex++).setCellValue(vo.getTelno());
            row.createCell(colIndex++).setCellValue(vo.getFxnum());
            row.createCell(colIndex++).setCellValue(vo.getMainDuty());
            row.createCell(colIndex++).setCellValue(vo.getUseYn());
            colIndex = 0;
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "부서관리목록";
    }

}
