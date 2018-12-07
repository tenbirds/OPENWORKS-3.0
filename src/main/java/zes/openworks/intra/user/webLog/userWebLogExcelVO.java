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
 *  2012. 5. 29.    유상원   회원 관리
 * </pre>
 * @see
 */
public class userWebLogExcelVO implements IExcelVO {

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<UserWebLogVO> list = (List<UserWebLogVO>) model.get("_webLog");

        HSSFSheet sheet = workbook.createSheet();

        // ID, 성명, 조회일시, 조회자, 조회자 ID, 변경내용, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("접속일시");
        header.createCell(colIndex++).setCellValue("인증방식");
        header.createCell(colIndex++).setCellValue("결과");
        header.createCell(colIndex++).setCellValue("아이피");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(UserWebLogVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getLoginDt());
            row.createCell(colIndex++).setCellValue(vo.getRegType());
            if(vo.getLoginResult() == "0") {
                row.createCell(colIndex++).setCellValue("실패");
            } else {
                row.createCell(colIndex++).setCellValue("성공");
            }
            row.createCell(colIndex++).setCellValue(vo.getLoginIp());
            colIndex = 0;
        }

    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "회원접속이력관리상세목록";
    }

}
