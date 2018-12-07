/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.webLog;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;
import zes.openworks.intra.user.UserVO;

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
 *  2012. 6. 19.    유상원   회원 관리
 * </pre>
 * @see
 */
public class UserWebLogListExcelVO implements IExcelVO {

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<UserVO> list = (List<UserVO>) model.get("_webLogList");

        HSSFSheet sheet = workbook.createSheet();

        // ID, 성명, 조회일시, 조회자, 조회자 ID, 변경내용, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("ID");
        header.createCell(colIndex++).setCellValue("성명");
        header.createCell(colIndex++).setCellValue("가입일시");
        header.createCell(colIndex++).setCellValue("최근접속일시");
        header.createCell(colIndex++).setCellValue("로그인회수");
        header.createCell(colIndex++).setCellValue("회원등급");
        header.createCell(colIndex++).setCellValue("회원가입유형");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(UserVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getUserId());
            row.createCell(colIndex++).setCellValue(vo.getUserNm());
            row.createCell(colIndex++).setCellValue(vo.getRegistDt());
            row.createCell(colIndex++).setCellValue(vo.getRecentLoginDt());
            row.createCell(colIndex++).setCellValue(vo.getLoginCnt());
            row.createCell(colIndex++).setCellValue(vo.getUserGradCode());
            row.createCell(colIndex++).setCellValue(vo.getSbscrbTyNm());
            colIndex = 0;
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "회원접속이력 목록";
    }

}
