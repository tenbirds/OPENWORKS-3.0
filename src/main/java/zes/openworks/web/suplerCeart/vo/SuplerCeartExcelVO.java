/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

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

public class SuplerCeartExcelVO implements IExcelVO {

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
            header.createCell(colIndex++).setCellValue("서비스");
            header.createCell(colIndex++).setCellValue("기업/기관");
            header.createCell(colIndex++).setCellValue("응답만료일");
            header.createCell(colIndex++).setCellValue("답변상태");
            header.createCell(colIndex++).setCellValue("선정상태");
            header.createCell(colIndex++).setCellValue("계약상태");
        }else if(model.get("q_excel").equals("02")) {
            header.createCell(colIndex++).setCellValue("계약번호");
            header.createCell(colIndex++).setCellValue("계약체결일");
            header.createCell(colIndex++).setCellValue("계약기관(회사)명");
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("총 계약기간");
            header.createCell(colIndex++).setCellValue("총 계약금액");
        }

        if(model.get("q_excel").equals("01")) {
            Pager<SuplerCeartVO> list = (Pager<SuplerCeartVO>) model.get("_bidList");

            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;

            for(SuplerCeartVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                row.createCell(colIndex++).setCellValue(vo.getAuditlogNm());   // 사업명
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());      // 서비스
                row.createCell(colIndex++).setCellValue(vo.getRealDmndOrgn()); // 기업/기관
                row.createCell(colIndex++).setCellValue(vo.getRplyDt());       // 응답만료일
                row.createCell(colIndex++).setCellValue(vo.getAskApplyNm());   // 답변상태
                row.createCell(colIndex++).setCellValue(vo.getBidSussGbn());   // 선정상태
                row.createCell(colIndex++).setCellValue(vo.getCntrGbn());      // 계약상태

                --totalCnt;
                colIndex = 0;
            }
        }else if(model.get("q_excel").equals("02")) {
            Pager<SuplerCeartSuplySttusVO> list = (Pager<SuplerCeartSuplySttusVO>) model.get("_bidList");

            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;
            String Unit="";
            for(SuplerCeartSuplySttusVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);                                       // 번호
                row.createCell(colIndex++).setCellValue(vo.getCntrNum());                                // 계약번호
                row.createCell(colIndex++).setCellValue(vo.getCntrDt());                                 // 계약체결일
                row.createCell(colIndex++).setCellValue(vo.getPurchsInsttNm());                          // 계약기관(회사)명
                row.createCell(colIndex++).setCellValue(vo.getGoodsTyNm());                              // 구분 goodsTyNm
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());                                // 서비스명
                if(vo.getSplyForm() != null && (vo.getSplyForm().equals("1") || vo.getSplyForm().equals("2")) )
                    Unit ="개월";
                else if(vo.getSplyForm() != null && vo.getSplyForm().equals("3"))
                    Unit ="일";
                
                row.createCell(colIndex++).setCellValue(vo.getSplyFormUnit()+ Unit);                    // 총 계약기간  splyFormUnit
                row.createCell(colIndex++).setCellValue(vo.getCntrctamount()+" 원");                     // 총 계약금액
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
