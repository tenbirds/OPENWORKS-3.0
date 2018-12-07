/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.goods;

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

public class GoodsManageExcelVO implements IExcelVO {

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
        header.createCell(colIndex++).setCellValue(getMsg("excelHeader0"));// 번호
        if(model.get("q_excel").equals("1")) {
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
          /*  header.createCell(colIndex++).setCellValue("판매방식");*/
            header.createCell(colIndex++).setCellValue("전시");
            header.createCell(colIndex++).setCellValue("스토어명");
            header.createCell(colIndex++).setCellValue("판매자명");
           /* header.createCell(colIndex++).setCellValue("판매자구분");*/
            header.createCell(colIndex++).setCellValue("판매자유형");
            header.createCell(colIndex++).setCellValue("최종변경날짜");
            header.createCell(colIndex++).setCellValue("최종승인일/최초승인일");
        } else if(model.get("q_excel").equals("2")) {
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
           /* header.createCell(colIndex++).setCellValue("판매방식");*/
            header.createCell(colIndex++).setCellValue("스토어명");
            /*header.createCell(colIndex++).setCellValue("판매자구분");*/
            header.createCell(colIndex++).setCellValue("판매자유형");
            header.createCell(colIndex++).setCellValue("검토대기 등록일 (검토완료 목표일)");
            header.createCell(colIndex++).setCellValue("지연일");
            header.createCell(colIndex++).setCellValue("승인유형");
            header.createCell(colIndex++).setCellValue("상태");
        } else if(model.get("q_excel").equals("3")) {
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드");
            header.createCell(colIndex++).setCellValue("서비스명");
            /*header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("판매방식");*/
            header.createCell(colIndex++).setCellValue("스토어명");
          /*  header.createCell(colIndex++).setCellValue("판매자구분");*/
            header.createCell(colIndex++).setCellValue("판매자유형");
            header.createCell(colIndex++).setCellValue("운영팀 검토일");  
            header.createCell(colIndex++).setCellValue("승인완료 목표일");
            header.createCell(colIndex++).setCellValue("지연일");
          /*  header.createCell(colIndex++).setCellValue("상태");*/
        } else if(model.get("q_excel").equals("4")) {
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("전시");
            header.createCell(colIndex++).setCellValue("스토어명(판매자ID)");
            header.createCell(colIndex++).setCellValue("판매자구분");
            header.createCell(colIndex++).setCellValue("판매자유형");
            header.createCell(colIndex++).setCellValue("등록일");
        } else if(model.get("q_excel").equals("5")) {
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("스토어명(판매자ID)");
            header.createCell(colIndex++).setCellValue("판매자구분");
            header.createCell(colIndex++).setCellValue("판매자유형");
            header.createCell(colIndex++).setCellValue("등록일 검토완료 목표일");
            header.createCell(colIndex++).setCellValue("지연일");
            header.createCell(colIndex++).setCellValue("상태");
        } else if(model.get("q_excel").equals("6")) {
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("스토어명(판매자ID)");
            header.createCell(colIndex++).setCellValue("판매자구분");
            header.createCell(colIndex++).setCellValue("판매자유형");
            header.createCell(colIndex++).setCellValue("승인대기 등록일 (승인완료 목표일)");
            header.createCell(colIndex++).setCellValue("지연일");
            header.createCell(colIndex++).setCellValue("상태");
        } else if(model.get("q_excel").equals("7")) {
            // 포털(한국어) 서비스관리 엑셀다운로드
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("단가");
            header.createCell(colIndex++).setCellValue("전시");
            header.createCell(colIndex++).setCellValue("등록자");
            header.createCell(colIndex++).setCellValue("등록(변경)일시");
        } else if(model.get("q_excel").equals("8")) {
            // 포털(한국어) 서비스 등록대기 엑셀다운로드
            header.createCell(colIndex++).setCellValue("구분");
            header.createCell(colIndex++).setCellValue("서비스코드");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("단가");
            header.createCell(colIndex++).setCellValue("상태");
            header.createCell(colIndex++).setCellValue("등록자");
            header.createCell(colIndex++).setCellValue("등록(변경)일시");
        } else if(model.get("q_excel").equals("9")) {
            // 포털(한국어) 컨설팅관리 엑셀다운로드
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("전시");
            header.createCell(colIndex++).setCellValue("등록일");
        } else if(model.get("q_excel").equals("10")) {
            // 포털(한국어) 컨설팅 등록대기 엑셀다운로드
            header.createCell(colIndex++).setCellValue("서비스코드(언어)");
            header.createCell(colIndex++).setCellValue("서비스명");
            header.createCell(colIndex++).setCellValue("가격");
            header.createCell(colIndex++).setCellValue("상태");
            header.createCell(colIndex++).setCellValue("등록일");
        } else if(model.get("q_excel").equals("11")) {
            // 판매하기 통계목록
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader1"));// 서비스코드(언어)
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader2"));// 구분
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader3"));// 서비스명
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader4"));// 가격
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader5"));// 조회수
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader6"));// 구매문의(신청)수
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader7"));// 관심서비스
                                                                               // 등록횟수
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader8"));// 평가수
        } else if(model.get("q_excel").equals("12")) {
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader2"));// 구분
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader9"));// 구매번호
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader10"));// 주문일시
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader3"));// 서비스명
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader4"));// 가격
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader12"));// 구매자
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader13"));// 판매방식
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader14"));// 처리
        } else if(model.get("q_excel").equals("13")) {
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader9"));// 구매번호(언어)
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader10"));// 주문일시
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader3"));// 서비스명
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader12"));// 구매자
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader15"));// 신청내용
            header.createCell(colIndex++).setCellValue(getMsg("excelHeader14"));// 처리
        }

        if(model.get("q_excel").equals("11")) {
            Pager<WebGoodsManageVO> list = (Pager<WebGoodsManageVO>) model.get("_goodsList");
            String type = "";
            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;

            for(WebGoodsManageVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                for(int i = 0 ; i < vo.getGoodsType().size() ; ++i) {
                    type += vo.getGoodsType().get(i).get("GOODSTYNM");
                    if(i < vo.getGoodsType().size() - 1) {
                        type += ", ";
                    }
                }
                row.createCell(colIndex++).setCellValue(type);
                row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                row.createCell(colIndex++).setCellValue(vo.getGoodsRdcnt());
                row.createCell(colIndex++).setCellValue(vo.getSellCnt());
                row.createCell(colIndex++).setCellValue(vo.getInqrCnt());
                row.createCell(colIndex++).setCellValue(vo.getEvlScore());

                --totalCnt;
                type = "";
                colIndex = 0;
            }
        } else if(model.get("q_excel").equals("12") || model.get("q_excel").equals("13")) {
            Pager<OrderManageVO> list = (Pager<OrderManageVO>) model.get("_goodsList");
            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;

            for(OrderManageVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                if(model.get("q_excel").equals("12")) {
                    row.createCell(colIndex++).setCellValue(vo.getCtgryClNm().replace(" <br/> ", ","));
                    row.createCell(colIndex++).setCellValue(vo.getPurchsNo() + "(" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getOrderDt());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getOrdrrNm() + "(" + vo.getOrdrrId() + ")");
                    row.createCell(colIndex++).setCellValue(getMsg(vo.getOrdrOx().equals("O") ? "excelHeader16" : "excelHeader17"));
                    row.createCell(colIndex++).setCellValue(getMsg(vo.getOrderCnfirmAt().equals("Y") ? "excelHeader18" : "excelHeader19"));
                } else if(model.get("q_excel").equals("13")) {
                    row.createCell(colIndex++).setCellValue(vo.getPurchsNo() + "(" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getOrderDt());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    row.createCell(colIndex++).setCellValue(vo.getOrdrrNm() + "(" + vo.getOrdrrId() + ")");
                    row.createCell(colIndex++).setCellValue(getMsg(vo.getOrdrOx().equals("O") ? "excelHeader16" : "excelHeader17"));
                    row.createCell(colIndex++).setCellValue(getMsg(vo.getOrderCnfirmAt().equals("Y") ? "excelHeader18" : "excelHeader19"));
                }

                --totalCnt;
                colIndex = 0;
            }
        } else {
            Pager<GoodsManageVO> list = (Pager<GoodsManageVO>) model.get("_goodsList");
            String type = "";
            int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
            int rowIndex = 1;
            colIndex = 0;
            HSSFRow row;

            for(GoodsManageVO vo : list.getList()) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(totalCnt);
                if(model.get("q_excel").equals("1")) {
                    for(int i = 0 ; i < vo.getGoodsType().size() ; ++i) {
                        type += vo.getGoodsType().get(i).get("GOODSTYNM");
                        if(i < vo.getGoodsType().size() - 1) {
                            type += ", ";
                        }
                    }
                    row.createCell(colIndex++).setCellValue(type);
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    /*row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                    row.createCell(colIndex++).setCellValue(vo.getUserId());
                    /*row.createCell(colIndex++).setCellValue(vo.getNationGrp());*/
                    row.createCell(colIndex++).setCellValue(vo.getUserTyGrp());
                    row.createCell(colIndex++).setCellValue(vo.getExmntConfmDt()+"/"+vo.getConfmDt());
                } else if(model.get("q_excel").equals("2")) {
                    for(int i = 0 ; i < vo.getGoodsType().size() ; ++i) {
                        type += vo.getGoodsType().get(i).get("GOODSTYNM");
                        if(i < vo.getGoodsType().size() - 1) {
                            type += ", ";
                        }
                    }
                    row.createCell(colIndex++).setCellValue(type);
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    /*row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());*/
                    row.createCell(colIndex++).setCellValue(vo.getLangStoreNm() + "(" + vo.getUserId() + ")");
                   /* row.createCell(colIndex++).setCellValue(vo.getNationGrp());*/
                    row.createCell(colIndex++).setCellValue(vo.getUserTyGrp());
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntConfmDt()) ? "" : Validate.isEmpty(vo.getExmntLimitDt()) ? vo.getExmntConfmDt() :vo.getExmntConfmDt() + "("+vo.getExmntLimitDt()+")");
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntDay()) ? "-" : vo.getExmntDay().toString());
                    if(vo.getGoodsRegistSttus() == 1002)
                        row.createCell(colIndex++).setCellValue("신규");
                    else if(vo.getGoodsRegistSttus() == 1009) 
                        row.createCell(colIndex++).setCellValue("변경");
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                } else if(model.get("q_excel").equals("3")) {
                    for(int i = 0 ; i < vo.getGoodsType().size() ; ++i) {
                        type += vo.getGoodsType().get(i).get("GOODSTYNM");
                        if(i < vo.getGoodsType().size() - 1) {
                            type += ", ";
                        }
                    }
                    row.createCell(colIndex++).setCellValue(type);
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    /*row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getSleMthdNm());*/
                    row.createCell(colIndex++).setCellValue(vo.getLangStoreNm());
                    /*row.createCell(colIndex++).setCellValue(vo.getNationGrp());*/
                    row.createCell(colIndex++).setCellValue(vo.getUserTyGrp());
                    row.createCell(colIndex++).setCellValue(vo.getExmntConfmDt());
                    row.createCell(colIndex++).setCellValue(vo.getExmntLimitDt());
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntDay()) ? "-" : vo.getExmntDay().toString());
                    /*row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());*/
                } else if(model.get("q_excel").equals("4")) {
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                    row.createCell(colIndex++).setCellValue(vo.getLangStoreNm() + "(" + vo.getUserId() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getNationGrp());
                    row.createCell(colIndex++).setCellValue(vo.getUserTyGrp());
                    row.createCell(colIndex++).setCellValue(vo.getExmntConfmDt());
                } else if(model.get("q_excel").equals("5")) {
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getLangStoreNm() + "(" + vo.getUserId() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getNationGrp());
                    row.createCell(colIndex++).setCellValue(vo.getUserTyGrp());
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntConfmDt()) ? "" : Validate.isEmpty(vo.getExmntLimitDt()) ? vo.getExmntConfmDt() :vo.getExmntConfmDt() + "("+vo.getExmntLimitDt()+")");
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntDay()) ? "-" : vo.getExmntDay().toString());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                } else if(model.get("q_excel").equals("6")) {
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getLangStoreNm() + "(" + vo.getUserId() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getNationGrp());
                    row.createCell(colIndex++).setCellValue(vo.getUserTyGrp());
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntConfmDt()) ? "" : Validate.isEmpty(vo.getExmntLimitDt()) ? vo.getExmntConfmDt() :vo.getExmntConfmDt() + "("+vo.getExmntLimitDt()+")");
                    row.createCell(colIndex++).setCellValue(Validate.isEmpty(vo.getExmntDay()) ? "-" : vo.getExmntDay().toString());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                } else if(model.get("q_excel").equals("7") || model.get("q_excel").equals("8")) {
                    for(int i = 0 ; i < vo.getGoodsType().size() ; ++i) {
                        type += vo.getGoodsType().get(i).get("GOODSTYNM");
                        if(i < vo.getGoodsType().size() - 1) {
                            type += ", ";
                        }
                    }
                    row.createCell(colIndex++).setCellValue(type);
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                    row.createCell(colIndex++).setCellValue(vo.getRegistId());
                    row.createCell(colIndex++).setCellValue(vo.getRegistDt());
                } else if(model.get("q_excel").equals("9") || model.get("q_excel").equals("10")) {
                    row.createCell(colIndex++).setCellValue(vo.getGoodsCode() + " (" + vo.getLangNm() + ")");
                    row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
                    /*row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getGoodsPc()) ? 0 : vo.getGoodsPc()));*/
                    row.createCell(colIndex++).setCellValue(vo.getGoodsPc());
                    row.createCell(colIndex++).setCellValue(vo.getGoodsRegistSttusNm());
                    row.createCell(colIndex++).setCellValue(vo.getRegistDt());
                }
                --totalCnt;
                type = "";
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
