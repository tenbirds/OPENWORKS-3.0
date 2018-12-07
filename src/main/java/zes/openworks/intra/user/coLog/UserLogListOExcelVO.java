/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.coLog;

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
 *  2012. 5. 25.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserLogListOExcelVO implements IExcelVO {

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        @SuppressWarnings("unchecked")
        List<UserLogVO> list = (List<UserLogVO>) model.get("_userLogList");

        HSSFSheet sheet = workbook.createSheet();

        // 메뉴명, 출력내용, 조회일시, 조회자, 조회자 ID, 조회사유, 출력파일명
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("메뉴명");
        header.createCell(colIndex++).setCellValue("출력내용");
        header.createCell(colIndex++).setCellValue("출력일시");
//        header.createCell(colIndex++).setCellValue("출력자");
        header.createCell(colIndex++).setCellValue("출력자 ID");
        header.createCell(colIndex++).setCellValue("출력사유");
        // header.createCell(colIndex++).setCellValue("출력파일명");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(UserLogVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getLogMenuNm());
            row.createCell(colIndex++).setCellValue(vo.getOutptCn());
            row.createCell(colIndex++).setCellValue(vo.getAccessDt());
//            row.createCell(colIndex++).setCellValue(vo.getMngrNm());
            row.createCell(colIndex++).setCellValue(vo.getMngrId());
            row.createCell(colIndex++).setCellValue(vo.getAccessResn());
            // row.createCell(colIndex++).setCellValue(vo.getOutputFileNm());
            colIndex = 0;
        }

    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "회원정보출력이력목록";
    }

}
