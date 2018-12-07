/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.consult;

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
 * 2014. 11. 28.    이슬버미       신규
 *</pre>
 * @see
 */
public class ConsultOrderListExcelVO implements IExcelVO {

    /* (non-Javadoc)
     * @see zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel.HSSFWorkbook, java.util.Map)
     */
    @Override
    @SuppressWarnings("unchecked")
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        List<ConsultOrderVO> list = (List<ConsultOrderVO>) model.get("_consultListExcel");
        HSSFSheet sheet = workbook.createSheet();
        
        //작성일, 작성자 ID, 작성자 이름, 내용, 작성자 IP
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("번호");
        header.createCell(colIndex++).setCellValue("구분");
        header.createCell(colIndex++).setCellValue("주문번호");
        header.createCell(colIndex++).setCellValue("주문일시");
        header.createCell(colIndex++).setCellValue("서비스명");
        header.createCell(colIndex++).setCellValue("언어");
        header.createCell(colIndex++).setCellValue("신청내용");
        header.createCell(colIndex++).setCellValue("구매자");
        header.createCell(colIndex++).setCellValue("스토어명/판매자ID");
        header.createCell(colIndex++).setCellValue("완료여부");
        
        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(ConsultOrderVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getCtgryClNm().replaceAll("<br/>", ","));
            row.createCell(colIndex++).setCellValue(vo.getPurchsNo());
            row.createCell(colIndex++).setCellValue(vo.getOrderDt());
            row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
            row.createCell(colIndex++).setCellValue(vo.getLangNm());
            row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());
            row.createCell(colIndex++).setCellValue(vo.getOrdrrNm() + "(" + vo.getOrdrrId() + ")");
            row.createCell(colIndex++).setCellValue(vo.getOrdrrNm() + "(" + vo.getOrdrrId() + ")");
            row.createCell(colIndex++).setCellValue(vo.getStoreNm() + "(" + vo.getUserId() + ")");
            row.createCell(colIndex++).setCellValue(vo.getOrderCnfirmAt());
            colIndex = 0;
        }
        
    }

    /* (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "주문관리 컨설팅관리";
    }

}
