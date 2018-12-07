/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCertif;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.pager.Pager;
import zes.base.vo.IExcelVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.web.myCeart.MyCeartVO;
import zes.openworks.web.myCeart.vo.MyCeartPurchsDtlsVO;

/** *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2017. 11. 24.    SKYOU      신규
 * </pre> rou_issu_service_i (이용실적증명서발급내역)
 * @see
 */
public class MyCertifExcelVO implements IExcelVO {
    
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
        header.createCell(colIndex++).setCellValue("사업명");
        header.createCell(colIndex++).setCellValue("이용기간");
        header.createCell(colIndex++).setCellValue("구분");
        header.createCell(colIndex++).setCellValue("서비스명");
        header.createCell(colIndex++).setCellValue("제공업체");
        
        Pager<MyCertifGoodsVO> list = (Pager<MyCertifGoodsVO>) model.get("_bidList");

        int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;

        for(MyCertifGoodsVO vo : list.getList()) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(totalCnt);
            row.createCell(colIndex++).setCellValue(vo.getSvcNm());   // 사업명
            row.createCell(colIndex++).setCellValue(vo.getCntrctBeginDe()+" ~ " + vo.getCntrctEndDe());
            row.createCell(colIndex++).setCellValue(vo.getGoodsTyNm());
            row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
            row.createCell(colIndex++).setCellValue(vo.getSuplerStoreNm());
            --totalCnt;
            colIndex = 0;
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
