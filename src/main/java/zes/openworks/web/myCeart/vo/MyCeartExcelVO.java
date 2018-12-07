/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.pager.Pager;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.web.myCeart.MyCeartVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.orderManage.OrderManageVO;

public class MyCeartExcelVO implements IExcelVO {

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

        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("번호");// 번호
        if(model.get("q_excel").equals("01")) {
            header.createCell(colIndex++).setCellValue("사업명");
            header.createCell(colIndex++).setCellValue("사업등록일");
            header.createCell(colIndex++).setCellValue("서비스");
            header.createCell(colIndex++).setCellValue("회사");
            header.createCell(colIndex++).setCellValue("응답완료일");
            header.createCell(colIndex++).setCellValue("답변상태");
            header.createCell(colIndex++).setCellValue("계약대상");
        }else if(model.get("q_excel").equals("02")) {
            header.createCell(colIndex++).setCellValue("구매방식");
            header.createCell(colIndex++).setCellValue("공급자");
            header.createCell(colIndex++).setCellValue("서비스");
            header.createCell(colIndex++).setCellValue("계약(구매)일");
            header.createCell(colIndex++).setCellValue("계약시작일");
            header.createCell(colIndex++).setCellValue("계약종료일");
            header.createCell(colIndex++).setCellValue("구매(실적)증명서");
        }

        if(model.get("q_excel").equals("01")) {
            Pager<MyCeartVO> list = (Pager<MyCeartVO>) model.get("_bidList");

            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;

            for(MyCeartVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                row.createCell(colIndex++).setCellValue(vo.getAuditlogNm());   // 사업명
                row.createCell(colIndex++).setCellValue(vo.getEntrDt());       // 사업등록일
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());      // 서비스
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm());  // 회사
                row.createCell(colIndex++).setCellValue(vo.getRplyDt());       // 응답완료일
                row.createCell(colIndex++).setCellValue(vo.getAskApplyNm());   // 답변상태
                row.createCell(colIndex++).setCellValue(vo.getBidSussGbnNm()); // 계약대상

                --totalCnt;
                colIndex = 0;
            }
        }else if(model.get("q_excel").equals("02")) {
            Pager<MyCeartPurchsDtlsVO> list = (Pager<MyCeartPurchsDtlsVO>) model.get("_bidList");

            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;

            for(MyCeartPurchsDtlsVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                row.createCell(colIndex++).setCellValue(vo.getBidGbnNm());      // 구매방식
                row.createCell(colIndex++).setCellValue(vo.getSuplerStoreNm()); // 공급자
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());       // 서비스
                row.createCell(colIndex++).setCellValue(vo.getCntrDt());        // 계약(구매)일
                row.createCell(colIndex++).setCellValue(vo.getCntrctBeginDe()); // 계약시작일
                row.createCell(colIndex++).setCellValue(vo.getCntrctEndDe());   // 계약종료일
                
                if(vo.getCertReultCode() == null || vo.getCertReultCode().equals("")){
                    row.createCell(colIndex++).setCellValue("미신청");   // 구매(실적)증명서    
                }else{
                    row.createCell(colIndex++).setCellValue(vo.getCertReultNm());   // 구매(실적)증명서
                }
                
                
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
