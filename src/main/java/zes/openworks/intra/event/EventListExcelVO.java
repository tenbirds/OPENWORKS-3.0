/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.event;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.    이슬버미       신규
 *</pre>
 * @see
 */
public class EventListExcelVO implements IExcelVO {

    /* (non-Javadoc)
     * @see zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel.HSSFWorkbook, java.util.Map)
     */
    @Override
    @SuppressWarnings("unchecked")
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        
        List<EventVO> list = (List<EventVO>) model.get("_answerList");
        HSSFSheet sheet = workbook.createSheet();
        
        //작성일, 작성자 ID, 작성자 이름, 내용, 작성자 IP
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("작성일");
        header.createCell(colIndex++).setCellValue("작성자ID");
        header.createCell(colIndex++).setCellValue("작성자이름");
        header.createCell(colIndex++).setCellValue("내용");
        header.createCell(colIndex++).setCellValue("작성자IP");
        
        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(EventVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getWritngDt());
            row.createCell(colIndex++).setCellValue(vo.getWrterId());
            row.createCell(colIndex++).setCellValue(vo.getWrterNm());
            row.createCell(colIndex++).setCellValue(vo.getEventCmtCn());
            row.createCell(colIndex++).setCellValue(vo.getWrterIp());
            colIndex = 0;
        }
    }

    /* (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {
        // TODO Auto-generated method stub
        return "댓글목록";
    }

}
