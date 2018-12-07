/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.wish.myWish;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.pager.Pager;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.orderManage.OrderManageVO;
import zes.openworks.web.suplerCeart.SuplerCeartVO;

public class MyWishExcelVO implements IExcelVO {

    Map<String, Object> model;

    String hostNm;

    public void setModel(Map<String, Object> model) {
        this.model = model;
    }

    public void setHostNm(String hostNm) {
        this.hostNm = hostNm;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        HSSFSheet sheet = workbook.createSheet();
        
        HSSFRow title = sheet.createRow(0);
        title.createCell(0).setCellValue(model.get("q_excelFileName").toString());
        title.setHeight((short) 500);
        
        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(1);
        header.createCell(colIndex++).setCellValue("번호");// 번호
        if(model.get("q_excel").equals("01") || model.get("q_excel").equals("02")) {
            header.createCell(colIndex++).setCellValue("기업/기관");
            
            header.createCell(colIndex++).setCellValue("서비스");
            header.createCell(colIndex++).setCellValue("검색어");
            header.createCell(colIndex++).setCellValue("필터조건");
        }
        if(model.get("q_excel").equals("01") || model.get("q_excel").equals("02")) {
            Pager<MyWishVO> list = (Pager<MyWishVO>) model.get("_bidList");

            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 2;
            colIndex = 0;
            HSSFRow row;

            for(MyWishVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm());      // 서비스
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm()); // 기업/기관
                row.createCell(colIndex++).setCellValue(vo.getKeyWord());       // 응답만료일
                row.createCell(colIndex++).setCellValue(vo.getFilterCon());   // 답변상태

                --totalCnt;
                colIndex = 0;
            }
        }
        
    }

    @Override
    public String getFileName() {
        return (String) model.get("q_excelFileName");
    }

    public String getMsg(String string) {
        String key = "";
        String upKey = "";
        
        if(Validate.isEmpty(hostNm) || "intra".equals(hostNm) || "korean".equals(hostNm)) {
            upKey = "msg";
        } else {
            upKey = hostNm + "Msg";
        }
        key = upKey + "." + string;
        return Config.getString(key);
    }
}
