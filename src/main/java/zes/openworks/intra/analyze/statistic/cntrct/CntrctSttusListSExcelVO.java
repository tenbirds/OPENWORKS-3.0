/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.cntrct;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;

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
 *  2012. 5. 29.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CntrctSttusListSExcelVO implements IExcelVO {

    Map<String, Object> model;

    String hostNm;
    
    public void setModel(Map<String, Object> model) {
        this.model = model;
    }

    public void setHostNm(String hostNm) {
        this.hostNm = hostNm;
    }
    
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        String listFlag = (String) model.get("listFlag");
        System.out.println("listFlag: " + listFlag);
        

        HSSFSheet sheet = workbook.createSheet();
        HSSFCellStyle style = workbook.createCellStyle();
        HSSFFont font = workbook.createFont();
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font.setFontName(HSSFFont.FONT_ARIAL);
        
        // 서비스명 서비스 구분  총 계약금액  공공회원    기업회원    개인회원
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        style.setFont(font);
        style.setFillBackgroundColor(IndexedColors.AQUA.getIndex());

        header.setRowStyle(style);
        
        if ("svc".equals(listFlag)) {
            List<HashMap<String, String> > list = (List<HashMap<String, String> >) model.get("cntrctServiceList");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("서비스 구분");
            header.createCell(colIndex++).setCellValue("총 계약금액");
            header.createCell(colIndex++).setCellValue("공공회원");
            header.createCell(colIndex++).setCellValue("기업회원");
            header.createCell(colIndex++).setCellValue("개인회원");
            
    
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;
            for(HashMap<String, String> hmap : list) {
                row = sheet.createRow(rowIndex++);
    
                row.createCell(colIndex++).setCellValue(hmap.get("svcNm"));
                row.createCell(colIndex++).setCellValue(hmap.get("goodsKnd"));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("cntrctAmount")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("privAmount")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("corpAmount")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("orgAmount")));
                
                colIndex = 0;
            }
        }else if ("sup".equals(listFlag)) {
            List<HashMap<String, String> > list = (List<HashMap<String, String> >) model.get("cntrctSupplyList");
            
            header.createCell(colIndex++).setCellValue("제공기업명");
            header.createCell(colIndex++).setCellValue("기업구분");
            header.createCell(colIndex++).setCellValue("총 계약금액");
            header.createCell(colIndex++).setCellValue("SaaS");
            header.createCell(colIndex++).setCellValue("PaaS");
            header.createCell(colIndex++).setCellValue("IaaS");
            
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;
            
            for(HashMap<String, String> hmap : list) {
                row = sheet.createRow(rowIndex++);
                
                row.createCell(colIndex++).setCellValue(hmap.get("goodsMakr"));
                row.createCell(colIndex++).setCellValue(hmap.get("smlpzChk"));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("cntrctAmount")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("saasCnt")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("paasCnt")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("iaasCnt")));
                
                colIndex = 0;
            }
        }else if ("use".equals(listFlag)) {
            List<HashMap<String, String> > list = (List<HashMap<String, String> >) model.get("cntrctUseInsttList");
            
            header.createCell(colIndex++).setCellValue("이용자 구분");
            header.createCell(colIndex++).setCellValue("이용기관(이용자명)");
            header.createCell(colIndex++).setCellValue("총 계약금액");
            header.createCell(colIndex++).setCellValue("계약 건수");
            
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;
            
            for(HashMap<String, String> hmap : list) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(hmap.get("userTy"));
                row.createCell(colIndex++).setCellValue(hmap.get("purchsInsttNm"));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("cntrctAmount")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("cntrCount")));
                
                colIndex = 0;
            }
            
        }else if ("spo".equals(listFlag)) {
            List<HashMap<String, String> > list = (List<HashMap<String, String> >) model.get("cntrctSportList");
            
            header.createCell(colIndex++).setCellValue("업명");
            header.createCell(colIndex++).setCellValue("서비스 구분");
            header.createCell(colIndex++).setCellValue("서비스 명");
            header.createCell(colIndex++).setCellValue("판개기관");
            header.createCell(colIndex++).setCellValue("계약기관");
            header.createCell(colIndex++).setCellValue("계약체곌일");
            header.createCell(colIndex++).setCellValue("계약기간");
            header.createCell(colIndex++).setCellValue("지원계약 수");
            header.createCell(colIndex++).setCellValue("주 계약금액");
            
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;
            
            for(HashMap<String, String> hmap : list) {
                row = sheet.createRow(rowIndex++);
                                
                row.createCell(colIndex++).setCellValue(hmap.get("svcNm"));
                row.createCell(colIndex++).setCellValue(hmap.get("goodsKnd"));
                row.createCell(colIndex++).setCellValue(hmap.get("sleInsttNm"));
                row.createCell(colIndex++).setCellValue(hmap.get("goodsMakr"));
                row.createCell(colIndex++).setCellValue(hmap.get("purchsInsttNm"));
                row.createCell(colIndex++).setCellValue(hmap.get("cntrDt"));
                row.createCell(colIndex++).setCellValue(hmap.get("cntrctBeginDe"));
                row.createCell(colIndex++).setCellValue(hmap.get("cntrctEndDe"));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("cntrCount")));
                row.createCell(colIndex++).setCellValue(String.valueOf(hmap.get("cntrctAmount")));
                
                
                colIndex = 0;
            }
            
            
            
        }

    }

    @Override
    public String getFileName() {
        return (String) model.get("fileName");
    }
 

}

