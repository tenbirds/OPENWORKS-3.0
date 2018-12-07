/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.apply;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.pager.Pager;
import zes.base.vo.IExcelVO;

public class WebapplyManageExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        @SuppressWarnings("unchecked")
        Pager<ApplyManageVO> list = (Pager<ApplyManageVO>) model.get("_applyList");

        HSSFSheet sheet = workbook.createSheet();

        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        if(model.get("q_excel").equals("1")){
            header.createCell(colIndex++).setCellValue("번호");
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("판매방식");
            header.createCell(colIndex++).setCellValue("전시");
            header.createCell(colIndex++).setCellValue("상점명(판매자ID)");
            header.createCell(colIndex++).setCellValue("등록일");
        } else if(model.get("q_excel").equals("2")){
            header.createCell(colIndex++).setCellValue("번호");
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("판매방식");
            header.createCell(colIndex++).setCellValue("상점명(판매자ID)");
            header.createCell(colIndex++).setCellValue("등록일");
            header.createCell(colIndex++).setCellValue("검토완료 목표일");
            header.createCell(colIndex++).setCellValue("지연일");
            header.createCell(colIndex++).setCellValue("상태");
        } else if(model.get("q_excel").equals("3")){
            header.createCell(colIndex++).setCellValue("번호");
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("판매방식");
            header.createCell(colIndex++).setCellValue("상점명(판매자ID)");
            header.createCell(colIndex++).setCellValue("등록일");
            header.createCell(colIndex++).setCellValue("승인완료 목표일");
            header.createCell(colIndex++).setCellValue("지연일");
            header.createCell(colIndex++).setCellValue("상태");
        } else if(model.get("q_excel").equals("4")){
            header.createCell(colIndex++).setCellValue("번호");
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("판매방식");
            header.createCell(colIndex++).setCellValue("상점명(판매자ID)");
            header.createCell(colIndex++).setCellValue("등록일");
            header.createCell(colIndex++).setCellValue("승인완료 목표일");
            header.createCell(colIndex++).setCellValue("지연일");
            header.createCell(colIndex++).setCellValue("상태");
        }
    }

    @Override
    public String getFileName() {
        return "구매요청 답변서 목록";
    }
}