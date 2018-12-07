/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.wish;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;

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
public class WishListExcelVO implements IExcelVO {

    /* (non-Javadoc)
     * @see zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel.HSSFWorkbook, java.util.Map)
     */
    @Override
    @SuppressWarnings({ "unchecked", "deprecation" })
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        
        List<WishListVO> list = (List<WishListVO>) model.get("_wishListExcel");
        List<WishListVO> info = (List<WishListVO>) model.get("_wishListInfo");
        HSSFSheet sheet = workbook.createSheet(); 
        HSSFWorkbook style1 = new HSSFWorkbook(); // 타이틀 속성
        HSSFSheet title = style1.createSheet();
        
        HSSFRow Title = sheet.createRow(1);
        HSSFCellStyle style = style1.createCellStyle();
        Title.createCell(0).setCellValue("클라우드서비스 씨앗 구매희망 목록");
        sheet.addMergedRegion(new Region(1,(short)0,1,(short)6));
        style.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE);
        
        
        HSSFRow header = sheet.createRow(2);
        header.createCell(0).setCellValue("사업명");
        sheet.addMergedRegion(new Region(2,(short)1,2,(short)5));
        header.createCell(1).setCellValue(info.get(0).getAuditlogNm());
        
        HSSFRow header2 = sheet.createRow(4);
        header2.createCell(0).setCellValue("기준");
        header2.createCell(1).setCellValue("사용자아이디");
        header2.createCell(2).setCellValue(info.get(0).getUserId()); // 사용자아이디
        header2.createCell(3).setCellValue("적용일시");
        sheet.addMergedRegion(new Region(4,(short)4,4,(short)5));
        header2.createCell(4).setCellValue(info.get(0).getSrcDt()); // 적용일시
        
        HSSFRow header3 = sheet.createRow(5);
        header3.createCell(0).setCellValue("검색조건");
        sheet.addMergedRegion(new Region(5,(short)0,6,(short)0));
        header3.createCell(1).setCellValue("검색어");
        header3.createCell(2).setCellValue(info.get(0).getKeyWord()); // 검색어
        header3.createCell(3).setCellValue("카테고리");
        header3.createCell(4).setCellValue(info.get(0).getCtgryCode()); // 카테고리
        sheet.addMergedRegion(new Region(5,(short)4,5,(short)5));
        
        
        HSSFRow header4 = sheet.createRow(6);
        header4.createCell(1).setCellValue("필터조건");
        header4.createCell(2).setCellValue(info.get(0).getFilterCon()); // 필터조건
        sheet.addMergedRegion(new Region(6,(short)2,6,(short)5));
        
       /* HSSFCellStyle style = workbook.createCellStyle();    
        style.setFillBackgroundColor(HSSFColor.AQUA.index);    
        style.setFillPattern(HSSFCellStyle.BIG_SPOTS);    */
        
        //작성일, 작성자 ID, 작성자 이름, 내용, 작성자 IP
        HSSFRow data = sheet.createRow(8);
        data.createCell(0).setCellValue("번호");
        data.createCell(1).setCellValue("선택여부");
        data.createCell(2).setCellValue("서비스명");
        data.createCell(3).setCellValue("판매자");

        
        int rowIndex = 9;
        int colIndex = 0;
        HSSFRow row;
        for(WishListVO vo : list) {
            row = sheet.createRow(rowIndex);
            row.createCell(colIndex++).setCellValue((rowIndex++)-8);
            if(vo.getSelChk().equals("Y")){
                row.createCell(colIndex++).setCellValue("선택");
            }else if(vo.getSelChk().equals("N")){
                row.createCell(colIndex++).setCellValue("미선택");
            }
            row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
            row.createCell(colIndex++).setCellValue(vo.getLangStoreNm());
            colIndex = 0;
        }
        
        
       
        
    }

    /* (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "구매희망 목록";
    }

}
