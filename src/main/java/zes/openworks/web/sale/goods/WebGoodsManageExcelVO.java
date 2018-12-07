/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.goods;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.pager.Pager;
import zes.base.vo.IExcelVO;

public class WebGoodsManageExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        @SuppressWarnings("unchecked")
        Pager<WebGoodsManageVO> list = (Pager<WebGoodsManageVO>) model.get("_goodsList");

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

        String type = "";
        int totalCnt = list.getTotalNum(); // 리스트 전체 갯
        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(WebGoodsManageVO vo : list.getList()) {
            row = sheet.createRow(rowIndex++);
            if(model.get("q_excel").equals("1")){ //서비스목록
                row.createCell(colIndex++).setCellValue(totalCnt);
                for(int i = 0; i < vo.getGoodsType().size(); ++i){
                    type += vo.getGoodsType().get(i).get("GOODSTYNM");
                    if(i < vo.getGoodsType(). size() - 1){
                        type += ", ";
                    }
                }
                row.createCell(colIndex++).setCellValue(type);
                row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                row.createCell(colIndex++).setCellValue("가격");
                row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());
                row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm()+"("+vo.getUserId()+")");
                row.createCell(colIndex++).setCellValue(vo.getRegistDt());
            } else if(model.get("q_excel").equals("2")){ //서비스대기
                row.createCell(colIndex++).setCellValue(totalCnt);
                for(int i = 0; i < vo.getGoodsType().size(); ++i){
                    type += vo.getGoodsType().get(i).get("GOODSTYNM");
                    if(i < vo.getGoodsType(). size() - 1){
                        type += ", ";
                    }
                }
                row.createCell(colIndex++).setCellValue(type);
                row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                row.createCell(colIndex++).setCellValue("가격");
                row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());
                row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm()+"("+vo.getUserId()+")");
                row.createCell(colIndex++).setCellValue(vo.getRegistDt());
            } else if(model.get("q_excel").equals("3")){ //컨설팅목록
                row.createCell(colIndex++).setCellValue(totalCnt);
                for(int i = 0; i < vo.getGoodsType().size(); ++i){
                    type += vo.getGoodsType().get(i).get("GOODSTYNM");
                    if(i < vo.getGoodsType(). size() - 1){
                        type += ", ";
                    }
                }
                row.createCell(colIndex++).setCellValue(type);
                row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                row.createCell(colIndex++).setCellValue("가격");
                row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());
                row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm()+"("+vo.getUserId()+")");
                row.createCell(colIndex++).setCellValue(vo.getRegistDt());
            } else if(model.get("q_excel").equals("4")){ //컨설팅대기
                row.createCell(colIndex++).setCellValue(totalCnt);
                for(int i = 0; i < vo.getGoodsType().size(); ++i){
                    type += vo.getGoodsType().get(i).get("GOODSTYNM");
                    if(i < vo.getGoodsType(). size() - 1){
                        type += ", ";
                    }
                }
                row.createCell(colIndex++).setCellValue(type);
                row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                row.createCell(colIndex++).setCellValue("가격");
                row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());
                row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm()+"("+vo.getUserId()+")");
                row.createCell(colIndex++).setCellValue(vo.getRegistDt());
            }
            type = "";
            --totalCnt;
            colIndex = 0;
        }
    }

    @Override
    public String getFileName() {
        return "서비스관리목록";
    }
}